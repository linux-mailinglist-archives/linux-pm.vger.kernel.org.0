Return-Path: <linux-pm+bounces-21247-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 179DEA24F2E
	for <lists+linux-pm@lfdr.de>; Sun,  2 Feb 2025 18:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 882FF1639AB
	for <lists+linux-pm@lfdr.de>; Sun,  2 Feb 2025 17:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFFB81FBC8C;
	Sun,  2 Feb 2025 17:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rsPUwTqJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9D11FBC83
	for <linux-pm@vger.kernel.org>; Sun,  2 Feb 2025 17:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738516411; cv=none; b=B29DasARxfrxwuN+q0OUS9c62DxH9GkarX59SXGlPLLhrm7UIn+NFVz9Akf0yQ1eZXtvWixSuWvoqNzkRV5l95d/58W7tA6RR+HduwtkKsj0QJUT9qfYjfztxdqw1zZMZp9T2HXRfoA6tVSMma05sDDe0VJ9IHfhQKF2kQUUNS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738516411; c=relaxed/simple;
	bh=90HlGdqnG/+vaKlBUf3XFfUskofiLY/e6tjr0WDH7/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eNbZ9e9mjYcWPDB/hS4PN80/3y8YCcQly2b+fH2oJ0VL1Fgf8JJEvn/N5bsjkPNlINm3XaQOZ8auw3JLvyGgasPtfUz+NPDdXSSyjVSBNeFHOAcrEGUg5b0NiRgbw+dPlpoGAfJ0K7+NCyU5kvGNoDKQoPoIqUShFO+moGYLYCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rsPUwTqJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52BD7C4CEE0;
	Sun,  2 Feb 2025 17:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738516411;
	bh=90HlGdqnG/+vaKlBUf3XFfUskofiLY/e6tjr0WDH7/I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=rsPUwTqJ3mp85+3NKV9AoNHJhHDxQNspkPpaig8Gb1v3/mexp+6bxQN2U9B/zYPl0
	 eUbSFHUyebSuOWi1KE6cRwilVDaM/j0+VatajLdNcZIafCiGSYdHyxmaQvsD2hzKw7
	 2/bbhxN+DmdP05vDbnj1FeixmpnJunAClwhBpNQvNzTgRWb5HddA9jLo5FLy2kzRCk
	 KHuUgx+qqniqyzKPt5HDYhywRBATvSd1BJK/YQl+ZRghlUrBfGKf/qOLYaSC65GwLu
	 j8Xzp7xFLhJJrT6ilevwQdmJ5bg+RE1B8OcnahiXYEJKu5ylftX8bEYV/hp26wvkBb
	 3e3mqucHYBuXQ==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 24/25] tools/power turbostat: Add CPU%c1e BIC for CWF
Date: Sun,  2 Feb 2025 11:09:40 -0600
Message-ID: <5ce1e9bbb2a1d43cf9e613cb03e65ecdfd309fe9.1738515889.git.len.brown@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <e8a99af68c068865dbac7f3330e97bf8e96edf33.1738515889.git.len.brown@intel.com>
References: <e8a99af68c068865dbac7f3330e97bf8e96edf33.1738515889.git.len.brown@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>

Intel Clearwater Forest report PMT telemetry with GUID 0x14421519, which
can be used to obtain module c1e residency counter of type tcore clock.

Add early support for the counter by using heuristic that should work
for the Clearwater Forest platforms.

Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 68 +++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 8df08819e7b4..364a44a7d7ae 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -205,6 +205,7 @@ struct msr_counter bic[] = {
 	{ 0x0, "SysWatt", NULL, 0, 0, 0, NULL, 0 },
 	{ 0x0, "Sys_J", NULL, 0, 0, 0, NULL, 0 },
 	{ 0x0, "NMI", NULL, 0, 0, 0, NULL, 0 },
+	{ 0x0, "CPU%c1e", NULL, 0, 0, 0, NULL, 0 },
 };
 
 #define MAX_BIC (sizeof(bic) / sizeof(struct msr_counter))
@@ -270,6 +271,7 @@ struct msr_counter bic[] = {
 #define	BIC_SysWatt		(1ULL << 59)
 #define	BIC_Sys_J		(1ULL << 60)
 #define	BIC_NMI			(1ULL << 61)
+#define	BIC_CPU_c1e		(1ULL << 62)
 
 #define BIC_TOPOLOGY (BIC_Package | BIC_Node | BIC_CoreCnt | BIC_PkgCnt | BIC_Core | BIC_CPU | BIC_Die)
 #define BIC_THERMAL_PWR (BIC_CoreTmp | BIC_PkgTmp | BIC_PkgWatt | BIC_CorWatt | BIC_GFXWatt | BIC_RAMWatt | BIC_PKG__ | BIC_RAM__ | BIC_SysWatt)
@@ -1538,6 +1540,14 @@ static struct msr_counter_arch_info msr_counter_arch_infos[] = {
 #define PMT_MTL_DC6_GUID           0x1a067102
 #define PMT_MTL_DC6_SEQ            0
 
+#define PMT_COUNTER_CWF_MC1E_OFFSET_BASE          20936
+#define PMT_COUNTER_CWF_MC1E_OFFSET_INCREMENT     24
+#define PMT_COUNTER_CWF_MC1E_NUM_MODULES_PER_FILE 12
+#define PMT_COUNTER_CWF_CPUS_PER_MODULE           4
+#define PMT_COUNTER_CWF_MC1E_LSB                  0
+#define PMT_COUNTER_CWF_MC1E_MSB                  63
+#define PMT_CWF_MC1E_GUID                         0x14421519
+
 unsigned long long tcore_clock_freq_hz = 800000000;
 
 #define PMT_COUNTER_NAME_SIZE_BYTES      16
@@ -9367,11 +9377,69 @@ int pmt_add_counter(unsigned int guid, unsigned int seq, const char *name, enum
 
 void pmt_init(void)
 {
+	int cpu_num;
+	unsigned long seq, offset, mod_num;
+
 	if (BIC_IS_ENABLED(BIC_Diec6)) {
 		pmt_add_counter(PMT_MTL_DC6_GUID, PMT_MTL_DC6_SEQ, "Die%c6", PMT_TYPE_XTAL_TIME,
 				PMT_COUNTER_MTL_DC6_LSB, PMT_COUNTER_MTL_DC6_MSB, PMT_COUNTER_MTL_DC6_OFFSET,
 				SCOPE_PACKAGE, FORMAT_DELTA, 0, PMT_OPEN_TRY);
 	}
+
+	if (BIC_IS_ENABLED(BIC_CPU_c1e)) {
+		seq = 0;
+		offset = PMT_COUNTER_CWF_MC1E_OFFSET_BASE;
+		mod_num = 0;	/* Relative module number for current PMT file. */
+
+		/* Open the counter for each CPU. */
+		for (cpu_num = 0; cpu_num < topo.max_cpu_num;) {
+
+			if (cpu_is_not_allowed(cpu_num))
+				goto next_loop_iter;
+
+			/*
+			 * Set the scope to CPU, even though CWF report the counter per module.
+			 * CPUs inside the same module will read from the same location, instead of reporting zeros.
+			 *
+			 * CWF with newer firmware might require a PMT_TYPE_XTAL_TIME intead of PMT_TYPE_TCORE_CLOCK.
+			 */
+			pmt_add_counter(PMT_CWF_MC1E_GUID, seq, "CPU%c1e", PMT_TYPE_TCORE_CLOCK,
+					PMT_COUNTER_CWF_MC1E_LSB, PMT_COUNTER_CWF_MC1E_MSB, offset, SCOPE_CPU,
+					FORMAT_DELTA, cpu_num, PMT_OPEN_TRY);
+
+			/*
+			 * Rather complex logic for each time we go to the next loop iteration,
+			 * so keep it as a label.
+			 */
+next_loop_iter:
+			/*
+			 * Advance the cpu number and check if we should also advance offset to
+			 * the next counter inside the PMT file.
+			 *
+			 * On Clearwater Forest platform, the counter is reported per module,
+			 * so open the same counter for all of the CPUs inside the module.
+			 * That way, reported table show the correct value for all of the CPUs inside the module,
+			 * instead of zeros.
+			 */
+			++cpu_num;
+			if (cpu_num % PMT_COUNTER_CWF_CPUS_PER_MODULE == 0) {
+				offset += PMT_COUNTER_CWF_MC1E_OFFSET_INCREMENT;
+				++mod_num;
+			}
+
+			/*
+			 * There are PMT_COUNTER_CWF_MC1E_NUM_MODULES_PER_FILE in each PMT file.
+			 *
+			 * If that number is reached, seq must be incremented to advance to the next file in a sequence.
+			 * Offset inside that file and a module counter has to be reset.
+			 */
+			if (mod_num == PMT_COUNTER_CWF_MC1E_NUM_MODULES_PER_FILE) {
+				++seq;
+				offset = PMT_COUNTER_CWF_MC1E_OFFSET_BASE;
+				mod_num = 0;
+			}
+		}
+	}
 }
 
 void turbostat_init()
-- 
2.43.0


