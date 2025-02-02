Return-Path: <linux-pm+bounces-21233-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E581A24F20
	for <lists+linux-pm@lfdr.de>; Sun,  2 Feb 2025 18:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9864162ED8
	for <lists+linux-pm@lfdr.de>; Sun,  2 Feb 2025 17:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE96B1FAC53;
	Sun,  2 Feb 2025 17:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qzqvQK45"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA1A1D7E57
	for <linux-pm@vger.kernel.org>; Sun,  2 Feb 2025 17:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738516390; cv=none; b=GFiiPTXWi6qI/QZk/MpJyfSAEFpoiZsf5pvysA2+px1DRgzUqaqhJfPgZLu7WeHYgnD+H8TLt9F6BkEDWNuXbDvQ33yypyrMKn8DVDCxFrNpvm/IALhPg0l4b12mEjDwZu/CFE1EQqnmMzaInZhJm4liuDCrfK6XHdbVcfBzapI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738516390; c=relaxed/simple;
	bh=q302wuFw3gQzYRetSahHKXsr1ukicFltaWIDK0bCXRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hScu1frjnB21Tza+XNyPPhzNsPnv3TchAqkEF169YG0Fhlvtlze4Nqn49pICH41W3VqHLotlk82TGJJ6NNP1K1o9OSUeHTOeM+GisLH8l4qJz2ULkdkiMWc96yZtCqgQ9+USU+uuvmN+HzixCDtI2gKcmjZNzkBn2CypcEJNge0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qzqvQK45; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C2CEC4CEE0;
	Sun,  2 Feb 2025 17:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738516390;
	bh=q302wuFw3gQzYRetSahHKXsr1ukicFltaWIDK0bCXRE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=qzqvQK45MsR9uU7IhP/A5alDIglUqQhIy1u3vXTJbinviJ4S/nXOz2MbIdgSGsmwj
	 qXfrU8XMHgiu4qHGJC1YteUUq4S1tw04Oddz80V63chRlgOu1rbwDqgp1lR5ejaiyz
	 OxDo12HpfcmAUQPsXltogMMgLkldBvIo+w652Q7FT6O/iHmj2vvLwgeLqOgYhHU+CH
	 wbRU/YhRVndcpbx8+JR+hEi3WRjsPudiCj1oT9EwQ33q6yhcflGBmV5lB+t2RsLUkd
	 7TKkpUymNUkwLNBIkIhB9PgSu+IX+If4m31oxobKKwSq1UmXI4QmojIBmGFkVmWIyu
	 JI61Wxcu3L5Vw==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 10/25] tools/power turbostat: Remove SysWatt from DISABLED_BY_DEFAULT
Date: Sun,  2 Feb 2025 11:09:26 -0600
Message-ID: <4a358ba215dfefe161b5904e51e48f5f0e82652f.1738515889.git.len.brown@intel.com>
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

The counter is present on most supporting Intel platforms and provides
useful data to the user. There is no reason to disable the counter by
default.

Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.8 | 2 +-
 tools/power/x86/turbostat/turbostat.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.8 b/tools/power/x86/turbostat/turbostat.8
index 59b89e6b25bf..f043a93defd4 100644
--- a/tools/power/x86/turbostat/turbostat.8
+++ b/tools/power/x86/turbostat/turbostat.8
@@ -190,7 +190,7 @@ The system configuration dump (if --quiet is not used) is followed by statistics
 .PP
 \fBRAMWatt\fP Watts consumed by the DRAM DIMMS -- available only on server processors.
 .PP
-\fBSysWatt\fP Watts consumed by the whole platform (RAPL PSYS). Disabled by default.  Enable with --enable SysWatt.
+\fBSysWatt\fP Watts consumed by the whole platform (RAPL PSYS).
 .PP
 \fBPKG_%\fP percent of the interval that RAPL throttling was active on the Package.  Note that the system summary is the sum of the package throttling time, and thus may be higher than 100% on a multi-package system.  Note that the meaning of this field is model specific.  For example, some hardware increments this counter when RAPL responds to thermal limits, but does not increment this counter when RAPL responds to power limits.  Comparing PkgWatt and PkgTmp to system limits is necessary.
 .PP
diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 2620ed000ad0..1d99aaf9681b 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -270,12 +270,12 @@ struct msr_counter bic[] = {
 #define	BIC_NMI			(1ULL << 61)
 
 #define BIC_TOPOLOGY (BIC_Package | BIC_Node | BIC_CoreCnt | BIC_PkgCnt | BIC_Core | BIC_CPU | BIC_Die )
-#define BIC_THERMAL_PWR ( BIC_CoreTmp | BIC_PkgTmp | BIC_PkgWatt | BIC_CorWatt | BIC_GFXWatt | BIC_RAMWatt | BIC_PKG__ | BIC_RAM__)
+#define BIC_THERMAL_PWR ( BIC_CoreTmp | BIC_PkgTmp | BIC_PkgWatt | BIC_CorWatt | BIC_GFXWatt | BIC_RAMWatt | BIC_PKG__ | BIC_RAM__ | BIC_SysWatt)
 #define BIC_FREQUENCY (BIC_Avg_MHz | BIC_Busy | BIC_Bzy_MHz | BIC_TSC_MHz | BIC_GFXMHz | BIC_GFXACTMHz | BIC_SAMMHz | BIC_SAMACTMHz | BIC_UNCORE_MHZ)
 #define BIC_IDLE (BIC_Busy | BIC_sysfs | BIC_CPU_c1 | BIC_CPU_c3 | BIC_CPU_c6 | BIC_CPU_c7 | BIC_GFX_rc6 | BIC_Pkgpc2 | BIC_Pkgpc3 | BIC_Pkgpc6 | BIC_Pkgpc7 | BIC_Pkgpc8 | BIC_Pkgpc9 | BIC_Pkgpc10 | BIC_CPU_LPI | BIC_SYS_LPI | BIC_Mod_c6 | BIC_Totl_c0 | BIC_Any_c0 | BIC_GFX_c0 | BIC_CPUGFX | BIC_SAM_mc6 | BIC_Diec6)
 #define BIC_OTHER ( BIC_IRQ | BIC_NMI | BIC_SMI | BIC_ThreadC | BIC_CoreTmp | BIC_IPC)
 
-#define BIC_DISABLED_BY_DEFAULT	(BIC_USEC | BIC_TOD | BIC_APIC | BIC_X2APIC | BIC_SysWatt | BIC_Sys_J)
+#define BIC_DISABLED_BY_DEFAULT	(BIC_USEC | BIC_TOD | BIC_APIC | BIC_X2APIC)
 
 unsigned long long bic_enabled = (0xFFFFFFFFFFFFFFFFULL & ~BIC_DISABLED_BY_DEFAULT);
 unsigned long long bic_present = BIC_USEC | BIC_TOD | BIC_sysfs | BIC_APIC | BIC_X2APIC;
-- 
2.43.0


