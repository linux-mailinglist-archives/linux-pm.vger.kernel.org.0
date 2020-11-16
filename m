Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A55CD2B5206
	for <lists+linux-pm@lfdr.de>; Mon, 16 Nov 2020 21:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731722AbgKPUIc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Nov 2020 15:08:32 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43350 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgKPUIb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Nov 2020 15:08:31 -0500
Date:   Mon, 16 Nov 2020 20:08:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605557309;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=peDNfF+HZPUmdgkgBtUN3jkmX7nTFV65Rz6J8vjKBaA=;
        b=aWShKzvXB+NwB7/XkI8Ai51RbYRzdJooSH7Ia2fTkLqL1ZDplMbyX13Xe/pilJ/5eUp58y
        qQ2c+eCy7N9E/FU1ZNspH/cK7cniIamrlYxK7nMLu2ffqhZAqsAuDgby8AYAuWefmHAZjK
        FAgfGi8AXuJynrZmU+a0hjPvA27AdqQcTlvV0/1W7lFj2ojmiyYSeG0fmD5Hps6VRsTTC6
        dEk49GTtCJ8RPZ65HCazuPCEvEyT7mHAAwtgJgfb7ZSwd5r/9jlm0AEHnkdwZWF8XZhEWM
        i3iXwg1RXoKtHF40j4HPDTwTTNw5YTzQFo2MaUCw1RJtfE9tuS683f1q49fn6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605557309;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=peDNfF+HZPUmdgkgBtUN3jkmX7nTFV65Rz6J8vjKBaA=;
        b=XxhLiqV1nx8NpUJtzjQ2ICnONKuS4HVKIHGX7+CGQQh69pV7G+u0JKgzoHMuvU7HXeqjK5
        rOTBRyL/I/UKa7DA==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] tools/power/turbostat: Read energy_perf_bias from sysfs
Cc:     Borislav Petkov <bp@suse.de>, Len Brown <lenb@kernel.org>,
        linux-pm@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201029190259.3476-3-bp@alien8.de>
References: <20201029190259.3476-3-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <160555730832.11244.4666731063927349137.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     6d6501d912a9a5e1b73d7fbf419b90a8ec11ed7a
Gitweb:        https://git.kernel.org/tip/6d6501d912a9a5e1b73d7fbf419b90a8ec11ed7a
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Thu, 15 Oct 2020 14:50:16 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 16 Nov 2020 17:42:46 +01:00

tools/power/turbostat: Read energy_perf_bias from sysfs

... instead of poking at the MSR directly.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org
Link: https://lkml.kernel.org/r/20201029190259.3476-3-bp@alien8.de
---
 tools/power/x86/turbostat/turbostat.c | 29 +++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 33b3708..0baec7e 100644
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
