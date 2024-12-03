Return-Path: <linux-pm+bounces-18415-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71AC69E14A1
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 08:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9E4A1604B8
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 07:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E2F1D6188;
	Tue,  3 Dec 2024 07:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l/+NMBRl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AA01C9B62;
	Tue,  3 Dec 2024 07:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733212285; cv=none; b=MIu3Y9SPY9481MaxIXS42MZ4qZ1QKRBd24DFDJlSqUjoijGLH+RcDFtca1punRHqKVIXYKK1WlT9X6kR2nCx+36kf/oAqsiHi1f0HsIsmAswdslNRbuVVMqEzHLvDgFQ3AE71zRiWhgEuYt4BA1/+6FujuitUcsZep18kdCHGO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733212285; c=relaxed/simple;
	bh=f4CC0b0D5MIZ2ZEL/VKxCZPBavAVHtWJayN/GtBBJlc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rr/SXTBGDg1e5ZJBSqCTtvunLnACxC+S/KZz8YdF3pJLcbk+3gVUys/oSe9JA3A5ptHqEyJF6yfdszGyKiPaeXAJLCQ8V8rIgl1xrDAzNoqRCYjw5AHefIW2S3POqH0smkbjalgUB8cfKYPR4lIrgpWWuWT+exFeYnJknu50I2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l/+NMBRl; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733212284; x=1764748284;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=f4CC0b0D5MIZ2ZEL/VKxCZPBavAVHtWJayN/GtBBJlc=;
  b=l/+NMBRltXnXbAx5EQYtIkWW0jhTVAhSFgzI424nyEBeoqp4hlA4ihBW
   e28eyVp985of987VFc4yO5znwY6AfebolQg23lCJl24xuLRCUgPOPqGqC
   nASehSy+I2IFFhpXAhEUyqaPMmnRZXdkIwbdJfFVpRUtRzE+ogaXFi6PS
   SVysPR/p1JtItmtDHsWT9Xf+fTthIrNW4Nir1KiVtaAZ1I1R7Ik5ICVtt
   lYLo/bWdB/0G3r+AfHVtia4Fz7IImDKsNz8Yc4lI6eyfb7hWavzaH9JWu
   VsWgZBPkcqmyBaupBov1MxZwf721b3EcGsn+k66Dor2OdY3JRlObHXRno
   w==;
X-CSE-ConnectionGUID: OTwwIMeUQB6WiK5dvCuLrg==
X-CSE-MsgGUID: sn6Nu4OZSe+fPIRJZqzUyQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="50822856"
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="50822856"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 23:51:24 -0800
X-CSE-ConnectionGUID: 509+CLIETPujef2W0E6IAg==
X-CSE-MsgGUID: YbZNBhVCTR2eCqkkqRDpMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="124183040"
Received: from rzhang1-mobl.sh.intel.com ([10.239.158.59])
  by orviesa002.jf.intel.com with ESMTP; 02 Dec 2024 23:51:23 -0800
From: Zhang Rui <rui.zhang@intel.com>
To: rafael.j.wysocki@intel.com,
	lenb@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 4/4] tools/power turbostat: Introduce --force parameter
Date: Tue,  3 Dec 2024 15:51:19 +0800
Message-ID: <20241203075119.584419-5-rui.zhang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241203075119.584419-1-rui.zhang@intel.com>
References: <20241203075119.584419-1-rui.zhang@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Turbostat currently exits under the following conditions:
1. When running on non-Intel/AMD/Hygon x86 vendors.
2. When running on Intel models that lack specific platform features.

Introduce a new `--force` parameter that allows turbostat to run on
these unsupported platforms with minimal default feature support. This
provides users with the flexibility to gather basic information even on
unsupported systems.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 442a993c5114..123eb9ead7df 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -326,6 +326,7 @@ unsigned int rapl_joules;
 unsigned int summary_only;
 unsigned int list_header_only;
 unsigned int dump_only;
+unsigned int force_load;
 unsigned int has_aperf;
 unsigned int has_aperf_access;
 unsigned int has_epb;
@@ -1058,7 +1059,8 @@ void probe_platform_features(unsigned int family, unsigned int model)
 
 
 	if (authentic_amd || hygon_genuine) {
-		platform = &default_features;
+		/* fallback to default features on unsupported models */
+		force_load++;
 		if (max_extended_level >= 0x80000007) {
 			unsigned int eax, ebx, ecx, edx;
 
@@ -1067,7 +1069,7 @@ void probe_platform_features(unsigned int family, unsigned int model)
 			if ((edx & (1 << 14)) && family >= 0x17)
 				platform = &amd_features_with_rapl;
 		}
-		return;
+		goto end;
 	}
 
 	if (!genuine_intel)
@@ -1081,10 +1083,16 @@ void probe_platform_features(unsigned int family, unsigned int model)
 	}
 
 end:
+	if (force_load && !platform) {
+		fprintf(outf, "Unsupported platform detected. Force running with minimum default support.\n");
+		platform = &default_features;
+	}
+
 	if (platform)
 		return;
 
 	fprintf(stderr, "Unsupported platform detected.\n"
+		"\tUse \"--force\" parameter to launch turbostat with minimum default support.\n"
 		"\tTo get latest turbostat support, please contact\n"
 		"\t   lenb@kernel.org\n"
 		"\tor pull from\n"
@@ -2163,6 +2171,8 @@ void help(void)
 		"		displays the raw counter values\n"
 		"  -e, --enable [all | column]\n"
 		"		shows all or the specified disabled column\n"
+		"  -f, --force\n"
+		"		force load turbostat with minimum default features on unsupported platforms.\n"
 		"  -H, --hide [column | column,column,...]\n"
 		"		hide the specified column(s)\n"
 		"  -i, --interval sec.subsec\n"
@@ -9945,6 +9955,7 @@ void cmdline(int argc, char **argv)
 		{ "Dump", no_argument, 0, 'D' },
 		{ "debug", no_argument, 0, 'd' },	/* internal, not documented */
 		{ "enable", required_argument, 0, 'e' },
+		{ "force", no_argument, 0, 'f' },
 		{ "interval", required_argument, 0, 'i' },
 		{ "IPC", no_argument, 0, 'I' },
 		{ "num_iterations", required_argument, 0, 'n' },
@@ -10005,6 +10016,9 @@ void cmdline(int argc, char **argv)
 			/* --enable specified counter */
 			bic_enabled = bic_enabled | bic_lookup(optarg, SHOW_LIST);
 			break;
+		case 'f':
+			force_load++;
+			break;
 		case 'd':
 			debug++;
 			ENABLE_BIC(BIC_DISABLED_BY_DEFAULT);
-- 
2.43.0


