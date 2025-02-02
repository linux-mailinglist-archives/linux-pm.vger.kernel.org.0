Return-Path: <linux-pm+bounces-21230-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABE3A24F1C
	for <lists+linux-pm@lfdr.de>; Sun,  2 Feb 2025 18:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 005B01884BEF
	for <lists+linux-pm@lfdr.de>; Sun,  2 Feb 2025 17:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919B31FAC53;
	Sun,  2 Feb 2025 17:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CnTc+fmN"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D53A1FAC46
	for <linux-pm@vger.kernel.org>; Sun,  2 Feb 2025 17:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738516385; cv=none; b=RjUYdraa2yDd4bixSou3MwiC1yDVOJAcvnBXNwXNATjcf27QLBtsLTtLgTfKN5W5EAeeBokZUt0pSyul6++koT3H44MwGExO8koZzMac+lT14m9/cZeOlaBfBvPQKPL/Wrkp5VPT0vnCwJeCXaVUZTQ67bWt/reeUlV0E0YcjeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738516385; c=relaxed/simple;
	bh=h6cbDga1vMkMlHFF16RpT/8JhquiFTawIQvLXM0PzF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c8qEjsK5ieVGL4I5C9Xq+Tx3p8iFic4Z/lgALq/hKqE+6a3pkr7dxS88I4Ot3RUMgxZCrn3LE8czNxGmgLjtdjYXXWlLKMMCQ23vuvnXZPLAGX6A1N0FIH+NqP0C769yTma9PO3mfDzT0VihevawX3Cl3MH28aVlJPJyyk250OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CnTc+fmN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32DB6C4CEE1;
	Sun,  2 Feb 2025 17:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738516385;
	bh=h6cbDga1vMkMlHFF16RpT/8JhquiFTawIQvLXM0PzF0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=CnTc+fmNGI9SCuDNSHqo0qnQ7gHslNyNMikr1GCrleaQlqctKGoBI0ztIBl6C8UTl
	 e7Raugk/ahkniVvHqjxgTwa/LkmROMlCj3jyrxHdh4MEPR+FJkZ+cAF5iDPY9af6Wc
	 P6VKQJaGY0TAskT2Eg4Z+mYDOza4NU5fr3nD65KR+qa3Npp0c33hWnqhwvz2DmwYd7
	 BydaFcjxCydN6xbxd506NgBzPcZQ2bjqs8KYBNZhGnabVvQhvMBerwjfl62pIp50v9
	 4vo97gUyPGK3SS0dg3AjKPfJHhOqlpO+qHzGBba68PlmyyDOjfhx9iNArHBmoNtHP6
	 tcFm0LJ4TKpzA==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 07/25] tools/power turbostat: Introduce --force parameter
Date: Sun,  2 Feb 2025 11:09:23 -0600
Message-ID: <3d94026af328d3d355d15c1d7fe73278f77c6a42.1738515889.git.len.brown@intel.com>
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

From: Zhang Rui <rui.zhang@intel.com>

Turbostat currently exits under the following conditions:
1. When running on non-Intel/AMD/Hygon x86 vendors.
2. When running on Intel models that lack specific platform features.

Introduce a new `--force` parameter that allows turbostat to run on
these unsupported platforms with minimal default feature support. This
provides users with the flexibility to gather basic information even on
unsupported systems.

[lenb: updated warning message text]

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 5165450a8187..7accc4a73366 100644
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
@@ -1081,6 +1083,11 @@ void probe_platform_features(unsigned int family, unsigned int model)
 	}
 
 end:
+	if (force_load && !platform) {
+		fprintf(outf, "Forced to run on unsupported platform!\n");
+		platform = &default_features;
+	}
+
 	if (platform)
 		return;
 
@@ -2160,6 +2167,8 @@ void help(void)
 		"		displays the raw counter values\n"
 		"  -e, --enable [all | column]\n"
 		"		shows all or the specified disabled column\n"
+		"  -f, --force\n"
+		"		force load turbostat with minimum default features on unsupported platforms.\n"
 		"  -H, --hide [column | column,column,...]\n"
 		"		hide the specified column(s)\n"
 		"  -i, --interval sec.subsec\n"
@@ -9942,6 +9951,7 @@ void cmdline(int argc, char **argv)
 		{ "Dump", no_argument, 0, 'D' },
 		{ "debug", no_argument, 0, 'd' },	/* internal, not documented */
 		{ "enable", required_argument, 0, 'e' },
+		{ "force", no_argument, 0, 'f' },
 		{ "interval", required_argument, 0, 'i' },
 		{ "IPC", no_argument, 0, 'I' },
 		{ "num_iterations", required_argument, 0, 'n' },
@@ -10002,6 +10012,9 @@ void cmdline(int argc, char **argv)
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


