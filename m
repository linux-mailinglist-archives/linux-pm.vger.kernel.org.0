Return-Path: <linux-pm+bounces-39113-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D300C9D0DF
	for <lists+linux-pm@lfdr.de>; Tue, 02 Dec 2025 22:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5CC2B34A461
	for <lists+linux-pm@lfdr.de>; Tue,  2 Dec 2025 21:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BB12FB967;
	Tue,  2 Dec 2025 21:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sm5E1qZB"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE77D2F99A8
	for <linux-pm@vger.kernel.org>; Tue,  2 Dec 2025 21:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764710318; cv=none; b=dnGaZ8dcbU7hx3ne6uvyxP6gtynmscI99/UvKqzY2KKlPSDz4glhBWvMduiLFHyNrugH4+yvXubguLaG9NQR2o4Mj00apphzlGEHMZqp/jC0YNfv7JSWkoIL3KcDs3ygs3UpeC3yLM8uQ68pUtOqrpZfU9hGpz6sz8E+47bB/tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764710318; c=relaxed/simple;
	bh=saOq3SW3k8W3DbOBnQgIb9bIpgoDktMm8VQZN3zH18g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F2hFkd/ESxMX6ZFISvzVvBr0lt2ZQmztJKc3cl93G4LST3tD4EgfgmYf7f7MFWrXSmhi7rCsU9GYcUWmP0s6PeQCcrk++/mN3k4Ns/1JG03YBuzMKM38M9siI16gsDZ2N+QkLwkGVlHkNV1ybvmfH6TK1NKI8dTW/vzO1Psg0K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sm5E1qZB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCC6FC16AAE;
	Tue,  2 Dec 2025 21:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764710318;
	bh=saOq3SW3k8W3DbOBnQgIb9bIpgoDktMm8VQZN3zH18g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=sm5E1qZBmWHurG5om92gyUUBFe1PgImEDnzDCkm2Ior0qsM4S7WIbTL3bEfO8Zwq5
	 YtfY6N475CiLUVlmZVbor7KaZqSjbSWaCM+BAtTHJfPWQOnxIJz413j8O9BxFXLvdu
	 IY3kQPR1N8MFw2OheybF6N1jngSoBpW46o6b1+zxa6hOneBhneQeWR8X7jDkl5I9m2
	 B/i+Zo6XlMYrbk76yinsWaLPyWqCe3VmiXpx2/iCfp0zFu+TQhciEuDbEvM9VP13vT
	 mGK3DRocuA+Mt+6l5+EAZORrgzE+TA+/WE7JS/gy8nyxzgjIw7+7UjSXln+LCb9WvJ
	 jto+ytkHBmJPQ==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
Subject: [PATCH 07/21] tools/power turbostat: Remove dead code
Date: Tue,  2 Dec 2025 16:13:25 -0500
Message-ID: <6dfb04332f2391053d4cece0782637532fc75207.1764710012.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <92664f2e6ab2228a3330734fc72dabeaf8a49ee1.1764710012.git.len.brown@intel.com>
References: <92664f2e6ab2228a3330734fc72dabeaf8a49ee1.1764710012.git.len.brown@intel.com>
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


