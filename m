Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B040A18C6CA
	for <lists+linux-pm@lfdr.de>; Fri, 20 Mar 2020 06:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgCTFXK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Mar 2020 01:23:10 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45414 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgCTFXK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Mar 2020 01:23:10 -0400
Received: by mail-qt1-f195.google.com with SMTP id z8so3964574qto.12
        for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2020 22:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:reply-to:organization:content-transfer-encoding;
        bh=wi1k/IuAlSMQ0sD08Rluy7qCovjgpl4TLmxMEPLrgCI=;
        b=VcRrHxEKrxJc/jUHv0LxovHX/jrDt9JvcdzvUkkOBTe34rVhONiUz+oFX4sXEuN+U4
         zInN9aPQxkAcQ7+Uw+c2abwNgIKI0QlmziNccqEzAQxvpkGUTXwikzEhk5bnDHvVP0cu
         q4/H1tx406b34If84wjUcfBhk4HjQzf5cWuUt3tlhi7C9T2luQAU8gvJUdd+4SKFLUeC
         d4bF9Fcrdq05qbOYFd1kE4Dd9lv11Fmogyzvvqq0pnM67O3kTzcgz07csXgjN817BBQm
         /XIuyrhnkulpB1AyxVsk1CjCdY7Q97iMdd165QCAz/NmtpM+RRp+H1x/4zOJqgjFiMZk
         Yeig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:reply-to:organization
         :content-transfer-encoding;
        bh=wi1k/IuAlSMQ0sD08Rluy7qCovjgpl4TLmxMEPLrgCI=;
        b=VuJKmV9WSoRJdLRpatSv9x0dd7/XsmwovEnAYYihIRYJPAlF5AGtBnn4kHGpK8NF2c
         v6yGvbR09wjecoUP46lb+iEjIgnCAlovnZcVSoUB+peGd+NeCBxfFKFRnaqZ8a0RIdLk
         q+9DBIl+5NDuhP5qXLdLy0+WUjYzrxpEj3JVy4XASANjNlEfNWkCywZ0qB5Lh7lzwTPx
         M9hhhlbgzNIg88Wokj187W7aG3+OJHTrwTtZ+SDcV/Z+cgVD1cuYT9dtcrXsiBSbbLtz
         +81nTiVzWWCaclDZAmbuvmO4Hiig6pij/LnbZqz8N77UjN6uwTowggL5IHVWD3bKerWT
         Ting==
X-Gm-Message-State: ANhLgQ1AiR3NC2blZGMOAKoLdhn6MEpDueEEMXaJ0osGVLc3ObNy6Gyl
        /YHc9inssITNOgezPQonVN7n621e
X-Google-Smtp-Source: ADFU+vtJ1CVSTuSYNL+DFPTnyAU+7CLu5HOGMumxbON5+pljo2V015tolTCoJKCCjNzpuV7NYQMQgg==
X-Received: by 2002:ac8:3656:: with SMTP id n22mr6553067qtb.296.1584681788095;
        Thu, 19 Mar 2020 22:23:08 -0700 (PDT)
Received: from localhost.localdomain (h96-61-82-19.cntcnh.dsl.dynamic.tds.net. [96.61.82.19])
        by smtp.gmail.com with ESMTPSA id w134sm3273383qka.127.2020.03.19.22.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 22:23:07 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     linux-pm@vger.kernel.org
Cc:     Len Brown <len.brown@intel.com>
Subject: [PATCH 07/10] tools/power turbostat: Fix missing SYS_LPI counter on some Chromebooks
Date:   Fri, 20 Mar 2020 01:22:45 -0400
Message-Id: <1f81c5efc020314b2db30d77efe228b7e117750d.1584679387.git.len.brown@intel.com>
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

Some Chromebook BIOS' do not export an ACPI LPIT, which is how
Linux finds the residency counter for CPU and SYSTEM low power states,
that is exports in /sys/devices/system/cpu/cpuidle/*residency_us

When these sysfs attributes are missing, check the debugfs attrubte
from the pmc_core driver, which accesses the same counter value.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 761146c4f9bc..3ecbf709a48c 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -304,6 +304,10 @@ int *irqs_per_cpu;		/* indexed by cpu_num */
 
 void setup_all_buffers(void);
 
+char *sys_lpi_file;
+char *sys_lpi_file_sysfs = "/sys/devices/system/cpu/cpuidle/low_power_idle_system_residency_us";
+char *sys_lpi_file_debugfs = "/sys/kernel/debug/pmc_core/slp_s0_residency_usec";
+
 int cpu_is_not_present(int cpu)
 {
 	return !CPU_ISSET_S(cpu, cpu_present_setsize, cpu_present_set);
@@ -2916,8 +2920,6 @@ int snapshot_gfx_mhz(void)
  *
  * record snapshot of
  * /sys/devices/system/cpu/cpuidle/low_power_idle_cpu_residency_us
- *
- * return 1 if config change requires a restart, else return 0
  */
 int snapshot_cpu_lpi_us(void)
 {
@@ -2941,17 +2943,14 @@ int snapshot_cpu_lpi_us(void)
 /*
  * snapshot_sys_lpi()
  *
- * record snapshot of
- * /sys/devices/system/cpu/cpuidle/low_power_idle_system_residency_us
- *
- * return 1 if config change requires a restart, else return 0
+ * record snapshot of sys_lpi_file
  */
 int snapshot_sys_lpi_us(void)
 {
 	FILE *fp;
 	int retval;
 
-	fp = fopen_or_die("/sys/devices/system/cpu/cpuidle/low_power_idle_system_residency_us", "r");
+	fp = fopen_or_die(sys_lpi_file, "r");
 
 	retval = fscanf(fp, "%lld", &cpuidle_cur_sys_lpi_us);
 	if (retval != 1) {
@@ -4946,10 +4945,16 @@ void process_cpuid()
 	else
 		BIC_NOT_PRESENT(BIC_CPU_LPI);
 
-	if (!access("/sys/devices/system/cpu/cpuidle/low_power_idle_system_residency_us", R_OK))
+	if (!access(sys_lpi_file_sysfs, R_OK)) {
+		sys_lpi_file = sys_lpi_file_sysfs;
 		BIC_PRESENT(BIC_SYS_LPI);
-	else
+	} else if (!access(sys_lpi_file_debugfs, R_OK)) {
+		sys_lpi_file = sys_lpi_file_debugfs;
+		BIC_PRESENT(BIC_SYS_LPI);
+	} else {
+		sys_lpi_file_sysfs = NULL;
 		BIC_NOT_PRESENT(BIC_SYS_LPI);
+	}
 
 	if (!quiet)
 		decode_misc_feature_control();
-- 
2.20.1

