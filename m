Return-Path: <linux-pm+bounces-28235-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8401EAD13B2
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 20:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9BA67A291A
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 18:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099181D47B4;
	Sun,  8 Jun 2025 18:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SMH/DQgP"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D0F1C861F
	for <linux-pm@vger.kernel.org>; Sun,  8 Jun 2025 18:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749406739; cv=none; b=JxT7HC/CazFgef5WSUT+FtA3x37Lnfz25lkUkFKHTRDz/Dci0AFJayeRLj1LCWAcnOZlAwy74loBQM1Fi3M84ldA4gU+8ioH6kqXOGdX0r3C8bLr1Pkpxjt40B+UM3yUMIc7o82R5ZBxnWTkFvYGXk4QW/1cQNhNbi1T9mWm5+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749406739; c=relaxed/simple;
	bh=LsX8hKojEuiEhDOFGg4Y+E+7Ae0mVeNU0WPB1mp6wxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mGNhdgXfCtmbzF9edBpcBJ4Badcfh6PA6ax7HoU3U8tyMceTszGlZHxjIwa30XBlUXdHaw+xpEF713m8VCCMgPjJQMWYY5NGAaDTVDX7dA5QF39Vkv/dl/4gWr5TS2lujLrvDapyoYyBO6p9fbO0YFySROAkkqOnCgaPOjllmJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SMH/DQgP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B92CC4CEEE;
	Sun,  8 Jun 2025 18:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749406738;
	bh=LsX8hKojEuiEhDOFGg4Y+E+7Ae0mVeNU0WPB1mp6wxE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=SMH/DQgPM4v7e8W3yQTCJ0GEddVCiCYPNqYs2PShodaJ4z/X62R8qjl/TD2tLee+l
	 +j0W6P7GBOZoW/23ACgfK6cn6XkrnLCCUr3BnNQ1AG8MOF5GU4BU7pVQSngwpYFuNR
	 Vneawr3GuCgO8GIWQ/B0LbHQpU7s/0CgFceoe3ijuJoT6hAEiI3T5hdjpHC07PhT0p
	 Frby/IETzktoX42VNQWyL6lUDE5hKHodhm0Nl3uEWQJHZ5JtGcpt8MM/P9hcaktyT4
	 VVbH9jMFD3SwNL4Hi4f2ljm2iUuLiI6BqE5+6rqP6Jz6WRcY0CJRMhPFqlEAPvX3nQ
	 alGQHaz6g2fYg==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 09/18] tools/power turbostat: Remove add_cstate_perf_counter_()
Date: Sun,  8 Jun 2025 14:17:08 -0400
Message-ID: <419ceb11360495a3e1bb1b259abc1e476b26bf76.1749406068.git.len.brown@intel.com>
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

As the only caller of add_cstate_perf_counter_(),
add_cstate_perf_counter() just gives extra debug output on top. There is
no need to keep both functions.

Remove add_cstate_perf_counter_() and move all the logic to
add_cstate_perf_counter().

No functional change.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 2651030c506b..9af1e13484e2 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -8021,35 +8021,31 @@ int *get_cstate_perf_group_fd(struct cstate_counter_info_t *cci, const char *gro
 	return NULL;
 }
 
-int add_cstate_perf_counter_(int cpu, struct cstate_counter_info_t *cci, const struct cstate_counter_arch_info *cai)
+int add_cstate_perf_counter(int cpu, struct cstate_counter_info_t *cci, const struct cstate_counter_arch_info *cai)
 {
+	int ret = -1;
+
 	if (no_perf)
 		return -1;
 
 	int *pfd_group = get_cstate_perf_group_fd(cci, cai->perf_subsys);
 
 	if (pfd_group == NULL)
-		return -1;
+		goto end;
 
 	const unsigned int type = read_perf_type(cai->perf_subsys);
 	const unsigned int config = read_perf_config(cai->perf_subsys, cai->perf_name);
 
-	const int fd_counter = open_perf_counter(cpu, type, config, *pfd_group, PERF_FORMAT_GROUP);
+	ret = open_perf_counter(cpu, type, config, *pfd_group, PERF_FORMAT_GROUP);
 
-	if (fd_counter == -1)
-		return -1;
+	if (ret == -1)
+		goto end;
 
 	/* If it's the first counter opened, make it a group descriptor */
 	if (*pfd_group == -1)
-		*pfd_group = fd_counter;
-
-	return fd_counter;
-}
-
-int add_cstate_perf_counter(int cpu, struct cstate_counter_info_t *cci, const struct cstate_counter_arch_info *cai)
-{
-	int ret = add_cstate_perf_counter_(cpu, cci, cai);
+		*pfd_group = ret;
 
+end:
 	if (debug >= 2)
 		fprintf(stderr, "%s: %d (cpu: %d)\n", __func__, ret, cpu);
 
-- 
2.45.2


