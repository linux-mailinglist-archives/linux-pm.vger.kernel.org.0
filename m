Return-Path: <linux-pm+bounces-28234-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF80FAD13AE
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 20:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E84DE3AA2AC
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 18:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097D71CF7AF;
	Sun,  8 Jun 2025 18:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBSoHFfI"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CBC13B58A
	for <linux-pm@vger.kernel.org>; Sun,  8 Jun 2025 18:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749406739; cv=none; b=hSmXJiNehMW5eKhCJjRnTHh/LYDk0LoxUR0H7tuh9MYomBROuKfqZNz3KFOBW9KdUAAiONGarOvtttydZlhpn3qrsf/d5eUQHAqegfaTnWb1EUQerjMvWNe3tKuWdbU73Z5Fj8SiVXQZk6oQpdYTa8/I2E7LOjSH9Squhenku7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749406739; c=relaxed/simple;
	bh=O/9o3vnBRhPOu36Yv9n2MUcrOQOKvxYkBQTRTgP1LHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M/GvuyoxeWU9Fep47xTu8eiqzPBGj6KsOr1xoXTpnl7EA2dIwA0XGMKsHMEuyYviF+afeELVnTTm0mfVt4lJzfHqoOGp7ZFV9x17OOCJFMh7QTqkp5Dg6jnxFGsnjYGgvxsBDhRWkvtciK6VrCi8XhLVfnHYOka/iIg6dM+L9v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MBSoHFfI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24D2CC4CEF0;
	Sun,  8 Jun 2025 18:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749406739;
	bh=O/9o3vnBRhPOu36Yv9n2MUcrOQOKvxYkBQTRTgP1LHs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=MBSoHFfIYVK36hntZuEKhzkU93IXAD7x2l9rGUfIAmwU2KVuel2PLAvTadsaO092r
	 3XOTPVXRwqwaM5l0mnuLBu2mcW+Z1BTDD3tNDzmRkVIDB6wwUDzRJQzzpY8Y4Uho6Z
	 K4K/gEPCnip4o1qBpwWJdzeNz5Vl6Zupx0xzLs1uC/DTww0GkI2tfchYmvgWZjNvBy
	 OWMCFFrNk0NqENiCUyaiu0xjknGF6EONzdthwJrbCpgU2KQNuBM9tDhLA4E4PmryLL
	 1/2U3M4A5C9aiv5lymFdwgMl6k3eZOh745FUA3vqZCncGcgfCywF+f9fhjGOQPu2Gn
	 sCB7CnPgF6Jhg==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 10/18] tools/power turbostat: Remove add_msr_perf_counter_()
Date: Sun,  8 Jun 2025 14:17:09 -0400
Message-ID: <9621106bd7e19dc5d9df0930bec2ae94d2ba7a22.1749406068.git.len.brown@intel.com>
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

As the only caller of add_msr_perf_counter_(), add_msr_perf_counter()
just gives extra debug output on top. There is no need to keep both
functions.

Remove add_msr_perf_counter_() and move all the logic to
add_msr_perf_counter().

No functional change.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 9af1e13484e2..ef923da00765 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -8052,30 +8052,26 @@ int add_cstate_perf_counter(int cpu, struct cstate_counter_info_t *cci, const st
 	return ret;
 }
 
-int add_msr_perf_counter_(int cpu, struct msr_counter_info_t *cci, const struct msr_counter_arch_info *cai)
+int add_msr_perf_counter(int cpu, struct msr_counter_info_t *cci, const struct msr_counter_arch_info *cai)
 {
+	int ret = -1;
+
 	if (no_perf)
 		return -1;
 
 	const unsigned int type = read_perf_type(cai->perf_subsys);
 	const unsigned int config = read_perf_config(cai->perf_subsys, cai->perf_name);
 
-	const int fd_counter = open_perf_counter(cpu, type, config, cci->fd_perf, PERF_FORMAT_GROUP);
+	ret = open_perf_counter(cpu, type, config, cci->fd_perf, PERF_FORMAT_GROUP);
 
-	if (fd_counter == -1)
-		return -1;
+	if (ret == -1)
+		goto end;
 
 	/* If it's the first counter opened, make it a group descriptor */
 	if (cci->fd_perf == -1)
-		cci->fd_perf = fd_counter;
-
-	return fd_counter;
-}
-
-int add_msr_perf_counter(int cpu, struct msr_counter_info_t *cci, const struct msr_counter_arch_info *cai)
-{
-	int ret = add_msr_perf_counter_(cpu, cci, cai);
+		cci->fd_perf = ret;
 
+end:
 	if (debug)
 		fprintf(stderr, "%s: %s/%s: %d (cpu: %d)\n", __func__, cai->perf_subsys, cai->perf_name, ret, cpu);
 
-- 
2.45.2


