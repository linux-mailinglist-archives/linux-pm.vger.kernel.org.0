Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 012D2286FB1
	for <lists+linux-pm@lfdr.de>; Thu,  8 Oct 2020 09:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbgJHHkx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Oct 2020 03:40:53 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:53694 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727318AbgJHHku (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Oct 2020 03:40:50 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20201008074047epoutp027e40f07952ab29f7ab2bd46e2bc8f445~79G5XcoDe0252902529epoutp02H
        for <linux-pm@vger.kernel.org>; Thu,  8 Oct 2020 07:40:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20201008074047epoutp027e40f07952ab29f7ab2bd46e2bc8f445~79G5XcoDe0252902529epoutp02H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1602142847;
        bh=R6fv09mNOqfqOl9fbsB3SRUWydTcHfWetpFYSlcV4zU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gPIJsZyCSqDxW+rKdRvokg6Tg+mkdNIAvs3fb8fYBdRhdwxUq3sIk8r+s2EDcUFNy
         vmdTRajni40wbGq0qGT5c9KUxDyv2/4SezleJ/b2ehGuUEsH6/b3LA0uefb5PUAvlI
         K1O77Kk1PlPXKvMnDq+ZyKRzFh/MpxuOQCKsPtAM=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20201008074046epcas1p1e0c825f8a14b582d2570e532f4346137~79G4zMsKa1555315553epcas1p1z;
        Thu,  8 Oct 2020 07:40:46 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.155]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4C6NRG028fzMqYm2; Thu,  8 Oct
        2020 07:40:42 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        9C.7B.10463.972CE7F5; Thu,  8 Oct 2020 16:40:41 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20201008074041epcas1p4b369a0bf9f2207a2d6e878385e23187b~79Gz4pU-F2048920489epcas1p4S;
        Thu,  8 Oct 2020 07:40:41 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20201008074041epsmtrp22615185a72f3f4b345221b7ace5f965f~79Gz37eKN0843908439epsmtrp2I;
        Thu,  8 Oct 2020 07:40:41 +0000 (GMT)
X-AuditID: b6c32a38-f11ff700000028df-51-5f7ec27907f7
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        EC.5D.08745.972CE7F5; Thu,  8 Oct 2020 16:40:41 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20201008074041epsmtip1062d198531397ce8c88e35a6c63e13a3~79GzotpF63022630226epsmtip1b;
        Thu,  8 Oct 2020 07:40:41 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     mka@chromium.org, rostedt@goodmis.org, mingo@redhat.com,
        cw00.choi@samsung.com, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Subject: [PATCH 1/3] trace: events: devfreq: Use fixed indentation size to
 improve readability
Date:   Thu,  8 Oct 2020 16:54:01 +0900
Message-Id: <20201008075403.26181-2-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201008075403.26181-1-cw00.choi@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLKsWRmVeSWpSXmKPExsWy7bCmgW7lobp4gw0PLSwm3rjCYnH9y3NW
        i7NNb9gtLu+aw2bxufcIo8WlAwuYLD5veMxocbtxBZvFvo4HTA6cHrMbLrJ4tOy7xe6xaVUn
        m8f7fVfZPPq2rGL0+LxJLoAtKtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkh
        LzE31VbJxSdA1y0zB+gqJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BZYFecWJu
        cWleul5yfq6VoYGBkSlQYUJ2xuoVrSwFv9kqVt6ZxNrA+Iu1i5GTQ0LARGLCimNsXYxcHEIC
        OxglPrT0MkI4nxglDt7ezQThfGaUWHL3PBNMy5u1h6BadjFKdK7ezQ7hfGGU+HTlDAtIFZuA
        lsT+FzfYQGwRASuJ0/87mEGKmAXmM0r8vfuTESQhLJAgsXblDbCxLAKqEov+fQFr4AVqOPFp
        CdSF8hKrNxxgBrE5Bawlvp/+ATZIQuAWu8Tyte1ARRxAjovE7g9hEPXCEq+Ob2GHsKUkPr/b
        ywZhV0usPHmEDaK3g1Fiy/4LUAuMJfYvncwEModZQFNi/S59iLCixM7fc8HuZBbgk3j3tQdq
        Fa9ER5sQRImyxOUHd6GhIimxuL0TapWHxOxZb6Dh2McocXrVH+YJjHKzEDYsYGRcxSiWWlCc
        m55abFhgghxnmxjB6U7LYgfj3Lcf9A4xMnEwHmKU4GBWEuFN966JF+JNSaysSi3Kjy8qzUkt
        PsRoCgy8icxSosn5wISbVxJvaGpkbGxsYWJoZmpoqCTO+/CWQryQQHpiSWp2ampBahFMHxMH
        p1QDk0vDLI3Fmuprv297vGX1Znf9y0JsobxX/U4sTr3sqWf34e7H9X9deV1d7+4pi01wPXxf
        40GhR+GhVW2+0mE/CtbPPVTz/ND75h/XvxVtuCc6TfMRN7PREXM5dUG/Ty/z90xe+axnUcxs
        c7EJioz/kvocfRxrLy6XSexe0aTy0brsUKj1lCtM9q8WJ15jsvJb0XzI+azotOId23hfHP03
        U8u770mqo1JtqNMLr4gHTx1r1p/l1fwuJ+uYbsJRevu7wr2fxcdsd/R/ZLuou+TJXTf9Eqs+
        jY1a1evLPtvZTNlYZXnc+7Trk28i5/Zl7T2+vFPL/oDvvR+u84TMNl9f8JnDe9Plky07ql5P
        OVrDcVCJpTgj0VCLuag4EQCmgNF2AAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKLMWRmVeSWpSXmKPExsWy7bCSnG7lobp4g7+L+C0m3rjCYnH9y3NW
        i7NNb9gtLu+aw2bxufcIo8WlAwuYLD5veMxocbtxBZvFvo4HTA6cHrMbLrJ4tOy7xe6xaVUn
        m8f7fVfZPPq2rGL0+LxJLoAtissmJTUnsyy1SN8ugStj9YpWloLfbBUr70xibWD8xdrFyMkh
        IWAi8WbtIbYuRi4OIYEdjBJ3HncwQyQkJaZdPApkcwDZwhKHDxdD1HxilHg6pZUFpIZNQEti
        /4sbbCC2iICNxN3F18DizALLGSXmtgqC2MICcRJrNtwDm8kioCqx6N8XsHpeASuJE5+WQB0h
        L7F6wwGwGk4Ba4nvp3+A2UJANSv3PWGawMi3gJFhFaNkakFxbnpusWGBUV5quV5xYm5xaV66
        XnJ+7iZGcEhqae1g3LPqg94hRiYOxkOMEhzMSiK86d418UK8KYmVValF+fFFpTmpxYcYpTlY
        lMR5v85aGCckkJ5YkpqdmlqQWgSTZeLglGpgCrKSzbdLOdjkMHnavc/z/Hh1T323/8YvI3Xz
        pMxh6UtN/+0Lb+c+cf2dlJBeZuPx17kptk9PoZ6lXPr3GtO+IKOnNxrcxf3mO76wdr3kZHTo
        fuaf6bpdR9VYDGe86efvXXVwc4/6phrZ1Zu1Hjsofg599DDynsa/TaG954SbK1jftNgbn479
        0y0br+1qpvz22fldcbJlX5bPtndeHnQo6DfHbu37PVGJLBVz3YKObwm5t2OF73GeT1sYAuIe
        tjzedczD1l5R9O1NUZWVK/ZttOg1qZVuEVugY69qXujZ/mX7VXHukNrEZVZHrjUHxJhbiPQ/
        rzEJOT/dVpjJPzlQ+Wv8NwkhiUvfT8YskFJiKc5INNRiLipOBAAb3UzquAIAAA==
X-CMS-MailID: 20201008074041epcas1p4b369a0bf9f2207a2d6e878385e23187b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20201008074041epcas1p4b369a0bf9f2207a2d6e878385e23187b
References: <20201008075403.26181-1-cw00.choi@samsung.com>
        <CGME20201008074041epcas1p4b369a0bf9f2207a2d6e878385e23187b@epcas1p4.samsung.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Each tracepoint infromation consist of the different size value.
So, in order to improve the readability, use the fixed indentation size.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 include/trace/events/devfreq.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/trace/events/devfreq.h b/include/trace/events/devfreq.h
index cf5b8772175d..bd36d28d16bc 100644
--- a/include/trace/events/devfreq.h
+++ b/include/trace/events/devfreq.h
@@ -29,7 +29,7 @@ TRACE_EVENT(devfreq_monitor,
 		__assign_str(dev_name, dev_name(&devfreq->dev));
 	),
 
-	TP_printk("dev_name=%s freq=%lu polling_ms=%u load=%lu",
+	TP_printk("dev_name=%-30s freq=%-12lu polling_ms=%-3u load=%-2lu",
 		__get_str(dev_name), __entry->freq, __entry->polling_ms,
 		__entry->total_time == 0 ? 0 :
 			(100 * __entry->busy_time) / __entry->total_time)
-- 
2.17.1

