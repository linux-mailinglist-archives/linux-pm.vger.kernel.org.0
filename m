Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD3F194CFA
	for <lists+linux-pm@lfdr.de>; Fri, 27 Mar 2020 00:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbgCZX1x (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Mar 2020 19:27:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:44942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728022AbgCZXYr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 26 Mar 2020 19:24:47 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54A3B20409;
        Thu, 26 Mar 2020 23:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585265086;
        bh=YOtm7zAs79v1XBoTlS89YdTT4HhPrN1rh4uVtP3fu6A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mB7ogkdLMcbJB8o/Z9nnUXbEtknF64Oc9Wkng9GGgDgdW8FehR/AB9ChNbEGO10Zy
         oVWbFNgKVEmOtwXJsNui7+b4TV1A5jPDasKyytOAAJIQFwZjz+lPlAsIf64pw+2Jdi
         MPsx1CijcG8zTy6Bnk+iDbJi1eKIWrmHvjvlNiOg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Len Brown <len.brown@intel.com>, Sasha Levin <sashal@kernel.org>,
        linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 13/19] tools/power turbostat: Fix 32-bit capabilities warning
Date:   Thu, 26 Mar 2020 19:24:25 -0400
Message-Id: <20200326232431.7816-13-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200326232431.7816-1-sashal@kernel.org>
References: <20200326232431.7816-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

[ Upstream commit fcaa681c03ea82193e60d7f2cdfd94fbbcd4cae9 ]

warning: `turbostat' uses 32-bit capabilities (legacy support in use)

Signed-off-by: Len Brown <len.brown@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/power/x86/turbostat/Makefile    |  2 +-
 tools/power/x86/turbostat/turbostat.c | 46 +++++++++++++++++----------
 2 files changed, 31 insertions(+), 17 deletions(-)

diff --git a/tools/power/x86/turbostat/Makefile b/tools/power/x86/turbostat/Makefile
index 13f1e8b9ac525..2b6551269e431 100644
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
index 17e82eaf5c4f4..988326b67a916 100644
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

