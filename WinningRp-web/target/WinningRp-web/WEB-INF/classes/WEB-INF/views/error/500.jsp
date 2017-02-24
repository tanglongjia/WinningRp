<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isErrorPage="true" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.StringReader" %>
<%@ page import="java.io.StringWriter" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>500-服务器内部错误</title>
</head>
<body>
<div>
    <h1>
        <span>服务器内部错误</span>
    </h1>
    <div>
        <div>
            <h2>500 Error</h2>
            <div>
                <h3>
                    If you're the <strong>site owner,</strong> one of two things happened:
                </h3>
                <ol>
                    <li>
                        <%
                            if (exception == null || exception.getMessage() == null) {
                                out.print("系统错误！");
                            } else {
                                String message = exception.getMessage();
                                if (message.lastIndexOf("Exception:") > 0) {
                                    out.print(message.substring(message.lastIndexOf("Exception:") + 10));
                                } else {
                                    out.print(message);
                                }

                                StringWriter outWriter = new StringWriter();
                                exception.printStackTrace(new PrintWriter(outWriter));

                                StringBuffer buffer = new StringBuffer();
                                BufferedReader in = new BufferedReader(new StringReader(outWriter.toString()));
                                while (true) {
                                    String line = in.readLine();
                                    if (line == null)
                                        break;
                                    buffer.append(line);
                                    buffer.append("<br>");
                                    if (buffer.length() > 3900)
                                        break;
                                }

                                out.print(buffer.toString());
                            }
                        %>
                    </li>
                </ol>
            </div>
        </div>
    </div>
</div>
</body>
</html>