Return-Path: <linux-pm+bounces-36792-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F8DC07104
	for <lists+linux-pm@lfdr.de>; Fri, 24 Oct 2025 17:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9851E56357E
	for <lists+linux-pm@lfdr.de>; Fri, 24 Oct 2025 15:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D60132E720;
	Fri, 24 Oct 2025 15:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hirkPUsp"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0888931AF1F
	for <linux-pm@vger.kernel.org>; Fri, 24 Oct 2025 15:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761320817; cv=none; b=cAvsUqby+0kg4O9LHl9MVnaN9xp/8CV3thmZa1zHq1Z9Lq4ct1pdPAVRL7fuVgcdbI6E7x4fz56wWE7CwntFxcBhwJclrNrSLqm2DB0hRk+DBiprckV+KkS8dCP/4Jsy8zjdNPv52wlOhPWFq8/B31BMeMQiGRvHQeHS6A8BD9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761320817; c=relaxed/simple;
	bh=saOq3SW3k8W3DbOBnQgIb9bIpgoDktMm8VQZN3zH18g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r+2GGIREPXR8k0zeVGW/Mz1L6N5PusUNZ/QSxY2NmolOytMAQ4u4R3KZHCWQKaABW3n7qWvYOMw3QKoIiidFgAyX+S0havrvRVSYuJQFGhZEjtt2k1cTUsYoCL6h8K8/J6Vn2IAwv0HhY46fHv+s3EuXffz+RyvUnSC56Q/h0HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hirkPUsp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62E04C113D0;
	Fri, 24 Oct 2025 15:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761320816;
	bh=saOq3SW3k8W3DbOBnQgIb9bIpgoDktMm8VQZN3zH18g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=hirkPUspHdrgMWpAl07aZrSU4M6I0zcH7AUEWRqQOtdSlPV9iNY3WpaMpkfZ97dV3
	 jsrY5csQ33zv3KDC4XejPEbDBp5oz5ppEnNu/mfS80tahWe+E2xDpLaLSe5kNMPajj
	 NSI0jEYYMOHCKNvB4MM5HXYCEY9foY23QjOfQEWvlrYCqA23radCHKKgmZQONJ6K7M
	 jl6ZzDoOJDwme6AueT8v8MXJJxChP5ARmXPy3VgKHpIqcUH+D+e3FF9t4tQiWcL0nO
	 EeOID8+ks7ydmVkHYLCLVi91CGF03tPGCAumRNTbRJ4ObQbmIAGBPGKIAX/Bmzp958
	 tUTCuA2J866tw==
From: Len Brown <lenb@kernel.org>
To: rafael@kernel.org,
	linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
Subject: [PATCH 7/8] tools/power turbostat: Remove dead code
Date: Fri, 24 Oct 2025 12:38:17 -0300
Message-ID: <6dfb04332f2391053d4cece0782637532fc75207.1761320252.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <92664f2e6ab2228a3330734fc72dabeaf8a49ee1.1761320252.git.len.brown@intel.com>
References: <92664f2e6ab2228a3330734fc72dabeaf8a49ee1.1761320252.git.len.brown@intel.com>
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

amperf_group_fd is never used.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 47cb72343038..f63525a1877c 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -466,8 +466,6 @@ static void bic_groups_init(void)
 #define PCL_10 14		/* PC10 */
 #define PCLUNL 15		/* Unlimited */
 
-struct amperf_group_fd;
-
 char *proc_stat = "/proc/stat";
 FILE *outf;
 int *fd_percpu;
@@ -4418,11 +4416,6 @@ int get_core_throt_cnt(int cpu, unsigned long long *cnt)
 	return 0;
 }
 
-struct amperf_group_fd {
-	int aperf;		/* Also the group descriptor */
-	int mperf;
-};
-
 static int read_perf_counter_info(const char *const path, const char *const parse_format, void *value_ptr)
 {
 	int fdmt;
-- 
2.45.2


