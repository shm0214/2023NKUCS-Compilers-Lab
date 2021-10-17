package utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.security.MessageDigest;
import java.util.ArrayDeque;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.Queue;

/**
 * @Author : YML
 * @Description:
 * @Date created at 2020/5/12 15:21
 **/
public class FileUtil
{
    /**
     * 通过广度优先遍历获取一个目录下的所有文件的绝对路径
     * @param dictionaryPath 目录的绝对路径
     * @return  所有文件的绝对路径
     */
    public static List<String> getFilePathByBFS(String dictionaryPath){
        List<String> ans = new ArrayList<>();
        searchFilePathByBFS(dictionaryPath, file -> {
            if(!file.isDirectory()){
                ans.add(file.getAbsolutePath());
            }
            return false;
        });
        return ans;
    }

    public interface FileFoundCallBack{
        boolean onFound(File file);
    }

    public static void searchFilePathByBFS(String dictionaryPath, FileFoundCallBack callBack){
        Queue<String> queue = new ArrayDeque<>();
        queue.add(dictionaryPath);
        boolean breakFlag = false;
        while (!breakFlag && !queue.isEmpty()){
            String currentDicPath = queue.poll();
            File currentDic = new File(currentDicPath);
            if(!currentDic.exists() || !currentDic.isDirectory() ){
                continue;
            }
            File[] files = currentDic.listFiles();
            assert files != null;
            for(File file: files){
                if(callBack.onFound(file)){
                    breakFlag = true;
                    break;
                }
                if(file.isDirectory()){
                    queue.add(file.getAbsolutePath());
                }
            }
        }
    }
}
