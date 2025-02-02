Return-Path: <linux-pm+bounces-21248-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8106BA24F2F
	for <lists+linux-pm@lfdr.de>; Sun,  2 Feb 2025 18:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F34AC162EE4
	for <lists+linux-pm@lfdr.de>; Sun,  2 Feb 2025 17:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210CF1FBC8B;
	Sun,  2 Feb 2025 17:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dLiv7dif"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F065F1FBC83
	for <linux-pm@vger.kernel.org>; Sun,  2 Feb 2025 17:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738516413; cv=none; b=tXfpiaaq/xpovBjnHLVfxJVH0+hr8czYBnLfAQfjVwnDQmCBcX5bjzuniZaOTJe1zNtPGxbTvRlIKk2kYS960RE2No1oV0lrl1PcctBU4DaGDM0jhLlC//5aiCexHcV2jtVBUR/nue6ZRPUoo2EpPAV1c04PqNsqPN1SDDGsdB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738516413; c=relaxed/simple;
	bh=GappRWpAvVdmFdj2co70h0M69z2g1/IHpwxfABymrA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sFXjvTZFtfxTeVnmI54uT9cX9kG6lJ4pSv7gSJTi0dmlFMu4DVHlEqMgmAsVlrVxnjetlq7OsQerSCOzQNTzL6ll51i/093NyfrHUs6+UZmdnwRP+ARIniSe3oKmtyGSB0V2jX01n20q6T3SbAdPYogxVhHrWqfJzGMUXNg2cco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dLiv7dif; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D73CC4CED1;
	Sun,  2 Feb 2025 17:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738516412;
	bh=GappRWpAvVdmFdj2co70h0M69z2g1/IHpwxfABymrA8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=dLiv7difCV7/LC+4SMuNwtmr1gt5Pm9cTxMFkFkO8CvlZJEmaDm4mTKYjsMb7z3/o
	 arI/nDNL4p9+9exVCarlkmz+qXs5GzOmbUZEtVn+OJ97RApvMVTgQ4SfoLZN4KFgxc
	 bDTf3pnwfY1N3ahyphjRnZEHuSqh5KYXF1hXXw+XY5wH1n/sEgX2BSMbtlwCfv7S3w
	 pguLSqPKFboMwr6M+z/Vu+lUH4uYz13MRuXCSA+njNjMclCGqFi43hzjn/wYbJHj0H
	 Zwc+q2rnx6vi5GzW5K+XePUjElzUvJD8oeL/KrOKSwBr62AcWA7uSos/l+h1fzsnEG
	 uYWZ+YAIqFDUg==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
Subject: [PATCH 25/25] tools/power turbostat: version 2025.02.02
Date: Sun,  2 Feb 2025 11:09:41 -0600
Message-ID: <2c4627c8ced77855b106c7104ecab70837d53799.1738515889.git.len.brown@intel.com>
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

From: Len Brown <len.brown@intel.com>

Summary of Changes since 2024.11.30:

Fix regression in 2023.11.07 that affinitized forked child
in one-shot mode.

Harden one-shot mode against hotplug online/offline

Enable RAPL SysWatt column by default.

Add initial PTL, CWF platform support.

Harden initial PMT code in response to early use.

Enable first built-in PMT counter: CWF c1e residency

Refuse to run on unsupported platforms without --force,
to encourage updating to a version that supports the system,
and to avoid no-so-useful measurement results.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 364a44a7d7ae..8d5011a0bf60 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -9559,7 +9559,7 @@ int get_and_dump_counters(void)
 
 void print_version()
 {
-	fprintf(outf, "turbostat version 2025.01.14 - Len Brown <lenb@kernel.org>\n");
+	fprintf(outf, "turbostat version 2025.02.02 - Len Brown <lenb@kernel.org>\n");
 }
 
 #define COMMAND_LINE_SIZE 2048
-- 
2.43.0


