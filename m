Return-Path: <linux-pm+bounces-21228-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BDEFCA24F1B
	for <lists+linux-pm@lfdr.de>; Sun,  2 Feb 2025 18:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B39057A2315
	for <lists+linux-pm@lfdr.de>; Sun,  2 Feb 2025 17:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C327A1FAC34;
	Sun,  2 Feb 2025 17:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lvzdrw8H"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8411F8917
	for <linux-pm@vger.kernel.org>; Sun,  2 Feb 2025 17:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738516382; cv=none; b=E7wTZjc8Yg3NunaBABFM9va/WeKLCDVgjUsaZBhDcgByAS1kcdFoKYmxa6ve4IwOA3uRpW2MUkqSvdjWXmoxy8gMgHpe9W6HesdSLMXahjBFY0LiX/xhCr7CUX5Vrchv7IcIB4IVDY3h+SyZw9FFkxOQX2ZMb7FwpeMX+oSvuvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738516382; c=relaxed/simple;
	bh=wQvAfClLg/NJt+BX1HeP7ba8swpvY0Vu2Be+yznQT2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lc71WQ1q68hXcumZzD5yiGrmErmvgXaY18xkUKGLRlUHutTTmiiWv8zLDM03iwNy11ij8aj/61YQkuNTFhqWHKM4YgIGz0rq1PfpbqywocjwYw0SSPhapOb1L0Sbz91iUbWO1AOWPByby3+xcprBb7Sng8/EvUyXfKevXmFrj28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lvzdrw8H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21417C4CED1;
	Sun,  2 Feb 2025 17:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738516382;
	bh=wQvAfClLg/NJt+BX1HeP7ba8swpvY0Vu2Be+yznQT2E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=lvzdrw8HGDeZBSFk1RSsDvNFJgHBgs8nUbxnx4up1leir5msn9MzS1TqIOqhxlR/O
	 CEq33zCnMwxH3AAiDBQczcdezUMk2hmri4wNxjt1+rgKnP8OJH94Bcl2BYApriaPQs
	 o5/PT6+vAfEnQsZeEYcjTMl9eGdbH5L9lUs9lCNQ/f6sPAYcMviR3ZAgURSNLgfuSF
	 Vdcr6ST13OH4KSD39blJfTcBSZrJmCAIR37g7oyUScUXhzNTkscL8VEk3CRP65V7pX
	 IQFrjPK6Wr6eCEFUJxUKi6ZaAQCS6AS39PqAEqUOpWRE5fBF+zjWoVmJ7FGNzQvN96
	 s4QKLN8UU/qNA==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 05/25] tools/power turbostat: Exit on unsupported Vendors
Date: Sun,  2 Feb 2025 11:09:21 -0600
Message-ID: <48c62ba1b407140229e92f5cfae6ae113fc4af8e.1738515889.git.len.brown@intel.com>
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

Turbostat currently supports x86 processors from Intel, AMD, and Hygon.
The behavior of turbostat on CPUs from other vendors has not been
evaluated and may lead to incorrect or undefined behavior.

Enhance turbostat to exit by default when running on an unsupported CPU
vendor. This ensures that users are aware that their CPU is not
currently supported by turbostat, guiding them to seek support for their
specific hardware through future patches.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 5e894b71003c..cb659b274554 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -1056,9 +1056,9 @@ void probe_platform_features(unsigned int family, unsigned int model)
 {
 	int i;
 
-	platform = &default_features;
 
 	if (authentic_amd || hygon_genuine) {
+		platform = &default_features;
 		if (max_extended_level >= 0x80000007) {
 			unsigned int eax, ebx, ecx, edx;
 
@@ -1071,7 +1071,7 @@ void probe_platform_features(unsigned int family, unsigned int model)
 	}
 
 	if (!genuine_intel)
-		return;
+		goto end;
 
 	for (i = 0; turbostat_pdata[i].features; i++) {
 		if (VFM_FAMILY(turbostat_pdata[i].vfm) == family && VFM_MODEL(turbostat_pdata[i].vfm) == model) {
@@ -1080,6 +1080,10 @@ void probe_platform_features(unsigned int family, unsigned int model)
 		}
 	}
 
+end:
+	if (platform)
+		return;
+
 	fprintf(stderr, "Unsupported platform detected.\n"
 		"\tSee RUN THE LATEST VERSION on turbostat(8)\n");
 	exit(1);
-- 
2.43.0


