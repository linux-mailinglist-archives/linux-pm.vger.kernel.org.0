Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB97228F515
	for <lists+linux-pm@lfdr.de>; Thu, 15 Oct 2020 16:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389137AbgJOOqW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 15 Oct 2020 10:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389122AbgJOOqV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Oct 2020 10:46:21 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4706BC0613D8;
        Thu, 15 Oct 2020 07:46:20 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0ed2005c4d90d75300802a.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:d200:5c4d:90d7:5300:802a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CBB1D1EC03CE;
        Thu, 15 Oct 2020 16:46:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1602773177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4QHsxbopA1jJrvw6XXL20mjzFqcvCsIi7OxZFfD0NeQ=;
        b=Tgk9Dlfg+QjNmPd0iN4JDbzWCJXW6wKliztX6tsxmcVyUCoG72bk2C5sZQDC09gH0KDk1h
        uW3RiVYBt8noxH7BmEohcq0eWIuxPqTDCa4Sit5J03qG+z6O0qlFUMp66qH6C6HG8Yg+Rx
        63oCEk75Ghq9acxa9M1EwtzM2KXKJ1E=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/4] tools/power/turbostat: Read energy_perf_bias from sysfs
Date:   Thu, 15 Oct 2020 16:46:01 +0200
Message-Id: <20201015144603.27933-3-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201015144603.27933-1-bp@alien8.de>
References: <20201015144603.27933-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

... instead of poking at the MSR directly.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org
---
 tools/power/x86/turbostat/turbostat.c | 29 ++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 33b370865d16..0baec7ea1bbd 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -1721,6 +1721,25 @@ int get_mp(int cpu, struct msr_counter *mp, unsigned long long *counterp)
 	return 0;
 }
 
+int get_epb(int cpu)
+{
+	char path[128 + PATH_BYTES];
+	int ret, epb = -1;
+	FILE *fp;
+
+	sprintf(path, "/sys/devices/system/cpu/cpu%d/power/energy_perf_bias", cpu);
+
+	fp = fopen_or_die(path, "r");
+
+	ret = fscanf(fp, "%d", &epb);
+	if (ret != 1)
+		err(1, "%s(%s)", __func__, path);
+
+	fclose(fp);
+
+	return epb;
+}
+
 void get_apic_id(struct thread_data *t)
 {
 	unsigned int eax, ebx, ecx, edx;
@@ -3631,9 +3650,8 @@ dump_sysfs_pstate_config(void)
  */
 int print_epb(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 {
-	unsigned long long msr;
 	char *epb_string;
-	int cpu;
+	int cpu, epb;
 
 	if (!has_epb)
 		return 0;
@@ -3649,10 +3667,11 @@ int print_epb(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 		return -1;
 	}
 
-	if (get_msr(cpu, MSR_IA32_ENERGY_PERF_BIAS, &msr))
+	epb = get_epb(cpu);
+	if (epb < 0)
 		return 0;
 
-	switch (msr & 0xF) {
+	switch (epb) {
 	case ENERGY_PERF_BIAS_PERFORMANCE:
 		epb_string = "performance";
 		break;
@@ -3666,7 +3685,7 @@ int print_epb(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 		epb_string = "custom";
 		break;
 	}
-	fprintf(outf, "cpu%d: MSR_IA32_ENERGY_PERF_BIAS: 0x%08llx (%s)\n", cpu, msr, epb_string);
+	fprintf(outf, "cpu%d: EPB: %d (%s)\n", cpu, epb, epb_string);
 
 	return 0;
 }
-- 
2.21.0

