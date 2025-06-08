Return-Path: <linux-pm+bounces-28231-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD4FAD13AC
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 20:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D5FC169031
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 18:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FFD1C6FFA;
	Sun,  8 Jun 2025 18:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hEmYxm+7"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D56B1C6FE8
	for <linux-pm@vger.kernel.org>; Sun,  8 Jun 2025 18:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749406737; cv=none; b=Go6ydFRZiwUpZhLboWIMkNqmt+KJTdSv9H/HhXSD3nNA0nBUVjfpk5xSwEOGO0Lj03IHMwlFLo+NmAQy0UMcr4rm1bzuuR53PT7Cv0gIW4XDY+AID1RuaLWDZnQP4YTtd0UcKWkaSAP0PCacfOCEVFsyqPCY5cEIaAB5wVkhczA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749406737; c=relaxed/simple;
	bh=W8X77xhnnBVZ0rRMaGrdMWinmM0Txty+8GwvbxejCig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sZyipMHf8Dee5SkNz7E7ohlU8Kd/Vi7BYqELJY9PoGO1NH3IU3S4lVj1NPahmLM2/hSXv+KSoAGpOqhsM+qMUo2ya3c8dZ/8gaX9IsGqbZ+7HbRsRHhw5MWPBghmcAgcDkpZ/tUCzBh86RT+oHRrX+3sffo81Q4jxnIl9ttUjFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hEmYxm+7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7D25C4CEF6;
	Sun,  8 Jun 2025 18:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749406737;
	bh=W8X77xhnnBVZ0rRMaGrdMWinmM0Txty+8GwvbxejCig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=hEmYxm+7MdEoTEQIZpSiCHBKRp+1ZyuQuxqayRkKI53iuPr35Ri96r4bKv/bKdbT1
	 mmV2r0UGWnP1JCdavfMfDSwZkUs51IYP2OM+hWBZexQAy2XNsIGzprNqJ1q1ozPZcX
	 WhGhntEdr+FHdwBuXQ0aUU1M76u6d149S+apNlcCgFA3tevhrqr19g5zvmK2WxnNqE
	 FrOdIonZegqJtu5Kl5FMM7QhfemhaFECqZwiSROj4BY4QrILDcojU+I9DCGmwmDHl2
	 8y4QF7eI9In2z3xtKHqtYLs8qGU6Qb/la5tLQdUzHWcRlbPhdE0yO78jGgqhyh2iUO
	 aOFl4kluH2Ygg==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 06/18] tools/power turbostat: Always check rapl_joules flag
Date: Sun,  8 Jun 2025 14:17:05 -0400
Message-ID: <ebb275c4e5544a0493a57010e9978240076a5738.1749406068.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <780da8a9557f2d114aaffda0eb0a517fe6a244c8.1749406068.git.len.brown@intel.com>
References: <780da8a9557f2d114aaffda0eb0a517fe6a244c8.1749406068.git.len.brown@intel.com>
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

rapl_joules bit should always be checked even if
platform_features->rapl_msrs is not set or no_msr flag is used.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 743db19a13c2..69c19e01b681 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -7302,6 +7302,9 @@ void rapl_probe_intel(void)
 	else
 		bic_enabled &= ~bic_joules_bits;
 
+	if (!platform->rapl_msrs || no_msr)
+		return;
+
 	if (!(platform->rapl_msrs & RAPL_PKG_PERF_STATUS))
 		bic_enabled &= ~BIC_PKG__;
 	if (!(platform->rapl_msrs & RAPL_DRAM_PERF_STATUS))
@@ -7352,6 +7355,9 @@ void rapl_probe_amd(void)
 	else
 		bic_enabled &= ~bic_joules_bits;
 
+	if (!platform->rapl_msrs || no_msr)
+		return;
+
 	if (get_msr(base_cpu, MSR_RAPL_PWR_UNIT, &msr))
 		return;
 
@@ -7504,9 +7510,6 @@ int print_rapl(struct thread_data *t, struct core_data *c, struct pkg_data *p)
  */
 void probe_rapl(void)
 {
-	if (!platform->rapl_msrs || no_msr)
-		return;
-
 	if (genuine_intel)
 		rapl_probe_intel();
 	if (authentic_amd || hygon_genuine)
@@ -7515,6 +7518,9 @@ void probe_rapl(void)
 	if (quiet)
 		return;
 
+	if (!platform->rapl_msrs || no_msr)
+		return;
+
 	for_all_cpus(print_rapl, ODD_COUNTERS);
 }
 
-- 
2.45.2


