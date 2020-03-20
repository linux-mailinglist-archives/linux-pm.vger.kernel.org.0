Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C34B318C6CB
	for <lists+linux-pm@lfdr.de>; Fri, 20 Mar 2020 06:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgCTFXL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Mar 2020 01:23:11 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42422 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbgCTFXL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Mar 2020 01:23:11 -0400
Received: by mail-qk1-f193.google.com with SMTP id e11so5704298qkg.9
        for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2020 22:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:reply-to:organization:content-transfer-encoding;
        bh=u7fqq9R71dpjrIomT6zK23AIJpwrHJ8YljxAyx/5uGE=;
        b=jkojP7/6Z74ittioC6CuL9IA58uzMms85+h5WFmdz1dcak1f62IoZqz0MSu+sUbLwe
         M02GMMmqVyDUiAzua7eygmWlY2mw01WxuyOUqUlKFJR0uDSpSvHM6TJBFOGE5VcI+3TJ
         aMAbMkbeE0vvnctCy6BOE5srmjDrFpr6Re5MCkwi9BnyCAfLdKN22P2AkCyCHqvhg0v/
         whJUoKQwIFjxSsLxg+CiAYPejqUSO+Tof/zJaBDoIzTGR1noySaiGRhJgPnEdTJzOFdq
         MpTvuU5az4ZDFzOP8WJ+XGKtdEzbK7VBSeOJync47uVqFnzZujrsMIipGqdnrRYqn0EH
         8wxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:reply-to:organization
         :content-transfer-encoding;
        bh=u7fqq9R71dpjrIomT6zK23AIJpwrHJ8YljxAyx/5uGE=;
        b=qBkq57i9g/D5j78mdZtvnb4KKEcHc3ZQtSkIlWm2oAIDfRun+TsTWxh+A+d6hY28IQ
         oYdf2KXnTdySUJT3GbE8vqmxf39OnDJekDJsMMjNzjVOBmMwPtWzVmSeBDM0l5xkVAKs
         5yjp9T4NXjbC0AIDd/xk6T2dL3ZMqUqrPu9V2o3A4+paVv6lb6t+ZTk1YMN1OUdhOaur
         oH8Dqmv57tlClSHgsV8Oo/c+twVpa3yijXYzPM5RZUd7vftVh/a9mRDmeGaBLskzz5Nz
         tzhMYa82RIj62B2DTn0Gb01d1Y29EUeUSrDfRqLlB/Z4JlO+0XnCu+nQ+qCmqECKsc0L
         FcBA==
X-Gm-Message-State: ANhLgQ3kWYQlnVsgPahGWNVMSYFNl3s3rPG9gGBhdd2WF8IRyQLBSwrl
        Pn7CTSiMgrr492aqGupElpelTLTk
X-Google-Smtp-Source: ADFU+vvr7aSsEmtlu/c15Ja2pR/bvLD/2a90hXcnpvFJeizMx7L0aX3LNz9tqWb/lJPin0SYYz6Z6w==
X-Received: by 2002:a37:393:: with SMTP id 141mr6307468qkd.393.1584681789394;
        Thu, 19 Mar 2020 22:23:09 -0700 (PDT)
Received: from localhost.localdomain (h96-61-82-19.cntcnh.dsl.dynamic.tds.net. [96.61.82.19])
        by smtp.gmail.com with ESMTPSA id w134sm3273383qka.127.2020.03.19.22.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 22:23:08 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     linux-pm@vger.kernel.org
Cc:     Len Brown <len.brown@intel.com>
Subject: [PATCH 08/10] tools/power turbostat: Fix 32-bit capabilities warning
Date:   Fri, 20 Mar 2020 01:22:46 -0400
Message-Id: <fcaa681c03ea82193e60d7f2cdfd94fbbcd4cae9.1584679387.git.len.brown@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <081c54323b27d8d4b40df6b2375b9e1f6846d827.1584679387.git.len.brown@intel.com>
References: <081c54323b27d8d4b40df6b2375b9e1f6846d827.1584679387.git.len.brown@intel.com>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

warning: `turbostat' uses 32-bit capabilities (legacy support in use)

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/Makefile    |  2 +-
 tools/power/x86/turbostat/turbostat.c | 46 +++++++++++++++++----------
 2 files changed, 31 insertions(+), 17 deletions(-)

diff --git a/tools/power/x86/turbostat/Makefile b/tools/power/x86/turbostat/Makefile
index 13f1e8b9ac52..2b6551269e43 100644
--- a/tools/power/x86/turbostat/Makefile
+++ b/tools/power/x86/turbostat/Makefile
@@ -16,7 +16,7 @@ override CFLAGS +=	-D_FORTIFY_SOURCE=2
 
 %: %.c
 	@mkdir -p $(BUILD_OUTPUT)
-	$(CC) $(CFLAGS) $< -o $(BUILD_OUTPUT)/$@ $(LDFLAGS)
+	$(CC) $(CFLAGS) $< -o $(BUILD_OUTPUT)/$@ $(LDFLAGS) -lcap
 
 .PHONY : clean
 clean :
diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 3ecbf709a48c..77f89371ec5f 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -30,7 +30,7 @@
 #include <sched.h>
 #include <time.h>
 #include <cpuid.h>
-#include <linux/capability.h>
+#include <sys/capability.h>
 #include <errno.h>
 #include <math.h>
 
@@ -3150,28 +3150,42 @@ void check_dev_msr()
 			err(-5, "no /dev/cpu/0/msr, Try \"# modprobe msr\" ");
 }
 
-void check_permissions()
+/*
+ * check for CAP_SYS_RAWIO
+ * return 0 on success
+ * return 1 on fail
+ */
+int check_for_cap_sys_rawio(void)
 {
-	struct __user_cap_header_struct cap_header_data;
-	cap_user_header_t cap_header = &cap_header_data;
-	struct __user_cap_data_struct cap_data_data;
-	cap_user_data_t cap_data = &cap_data_data;
-	extern int capget(cap_user_header_t hdrp, cap_user_data_t datap);
-	int do_exit = 0;
-	char pathname[32];
+	cap_t caps;
+	cap_flag_value_t cap_flag_value;
 
-	/* check for CAP_SYS_RAWIO */
-	cap_header->pid = getpid();
-	cap_header->version = _LINUX_CAPABILITY_VERSION;
-	if (capget(cap_header, cap_data) < 0)
-		err(-6, "capget(2) failed");
+	caps = cap_get_proc();
+	if (caps == NULL)
+		err(-6, "cap_get_proc\n");
 
-	if ((cap_data->effective & (1 << CAP_SYS_RAWIO)) == 0) {
-		do_exit++;
+	if (cap_get_flag(caps, CAP_SYS_RAWIO, CAP_EFFECTIVE, &cap_flag_value))
+		err(-6, "cap_get\n");
+
+	if (cap_flag_value != CAP_SET) {
 		warnx("capget(CAP_SYS_RAWIO) failed,"
 			" try \"# setcap cap_sys_rawio=ep %s\"", progname);
+		return 1;
 	}
 
+	if (cap_free(caps) == -1)
+		err(-6, "cap_free\n");
+
+	return 0;
+}
+void check_permissions(void)
+{
+	int do_exit = 0;
+	char pathname[32];
+
+	/* check for CAP_SYS_RAWIO */
+	do_exit += check_for_cap_sys_rawio();
+
 	/* test file permissions */
 	sprintf(pathname, "/dev/cpu/%d/msr", base_cpu);
 	if (euidaccess(pathname, R_OK)) {
-- 
2.20.1

