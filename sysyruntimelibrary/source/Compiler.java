/**
 * @Author : YML
 * @Description:
 * @Date created at 2020/5/14 15:15
 **/
public class Compiler implements ICompiler
{
    @Override
    public void compile(String sourcePath, String targetPath) throws Exception
    {
        FileUtil.assertDictionary(sourcePath);
        AtomicBoolean isCppProject = new AtomicBoolean(false);
        StringBuilder fileList = new StringBuilder();
        StringBuilder linkCmd = new StringBuilder();
        Set<String> linkedDic = new HashSet<>();
        FileUtil.searchFilePathByBFS(sourcePath, file -> {
            if(file.isDirectory()){
                return false;
            }
            String path = file.getAbsolutePath();
            String suffix = path.substring(path.lastIndexOf(".") + 1);
            switch (suffix){
                case "hpp":
                case "hh":
                case "H":
                case "hxx":
                    isCppProject.set(true);
                case "h":
                    String linkPath = file.getParent();
                    if(!linkedDic.contains(linkPath)){
                        linkCmd.append(" ").append("-I ").append(linkPath);
                        linkedDic.add(linkPath);
                    }
                    break;
                case "cpp":
                case "CPP":
                case "c++":
                case "cxx":
                case "C":
                case "cc":
                case "cp":
                    isCppProject.set(true);
                case "c":
                    fileList.append(" ").append(path);
                    break;
                default:
                        break;
            }
            return false;
        });
        String compileCmd = String.format("%s %s %s -o %s",this.getCompileCmdHeader(isCppProject.get()),
            fileList, linkCmd, targetPath);
        try {
			exec(compileCmd);
        } catch (Exception e) {
            throw new CompileException(e.getMessage());
        }
    }

    private String getCompileCmdHeader(boolean isCppProject) throws CompileException
    {
        String compilerType = Environment.getConfig().getString("compiler");
        if(!"gcc".equals(compilerType) && !"clang".equals(compilerType)){
            throw new CompileException("Unsupported Compiler Type");
        }
        String ans;
        if(isCppProject){
            if ("gcc".equals(compilerType)){
                ans = "g++ -std=c++17 -O2 -lm -lantlr4-runtime";
            }else{
                ans = "clang++ -std=c++17 -O2 -lm -lantlr4-runtime";
            }
        }else{
            ans = compilerType + " -std=c11 -O2 -lm";
        }
        return ans;
    }
}
