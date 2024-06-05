Return-Path: <linux-pm+bounces-8640-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 133788FCBE6
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2024 14:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A11BCB21137
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2024 12:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6EC1AED3B;
	Wed,  5 Jun 2024 11:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DaNjv8WU"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679821AED35;
	Wed,  5 Jun 2024 11:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588393; cv=none; b=gfl4Wh4ztEBejIc9Bc67jbcMY27ZQJm/Nz5zhE0jle4uzALv3HjlLIoIsYh2CY+g7GolIYSxFZb8WMFMNQD8gdCuoHAST1WTC0jKOdrf3oiLqkuxKgqin2jMUr3cENliRX22b+GpxSxtj28HUPOngO04uIUWA8/aJs7MQYc3MeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588393; c=relaxed/simple;
	bh=kjeZ8UHJFxHkLku+pSLI36o1lVjKiKC7NzUYHLFjFwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nFXrwrrpjxqdi1TBT9vLFGj3mTPzOwis59jnaK+mcpHdmtpc4dGTwq7CtExIaAZHTCuPumSNwwAPYEUsh32U3iY6tsGEsje1EbDnpp6Ujboqbj96ptsRLy8KSVKhsptvFoSZNRAAsP/6qfpcL783PjbFhy2vLrS62ryW+O404KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DaNjv8WU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA60BC32786;
	Wed,  5 Jun 2024 11:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588393;
	bh=kjeZ8UHJFxHkLku+pSLI36o1lVjKiKC7NzUYHLFjFwg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DaNjv8WUUoFpH8zQnv3qw29go/H00oUOUI5/ephyztejr9cjJ1s+e67d46aRAo+GT
	 XbZXbYvUhD4O4k8lTCtpUeQ8YtGLMWVQIePOvT+aaGDwX4FjebXVU+27axc66L2/kv
	 CisKPhFjsfb3v1glsCL9XLUG0s2nV+TBAHQ7dzZ0tSKSpQYMSAuNlSAqK264a99Zk8
	 D+MdqFezoFlcJ3mZ6wehegJ+mCQtvtMqTPZJlZ6VYnPZ4D2nf19s9xIocrAnhTxa4b
	 iAwpq4odji81MM6At353QUnshC1RPt+hx2KUW9PeGhXF0dY80aZ5am0UDjW6TzLGQe
	 P3g6bxrIw9cRw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peng Ma <andypma@tencent.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <Perry.Yuan@amd.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	ray.huang@amd.com,
	gautham.shenoy@amd.com,
	rafael@kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 18/20] cpufreq: amd-pstate: fix memory leak on CPU EPP exit
Date: Wed,  5 Jun 2024 07:52:01 -0400
Message-ID: <20240605115225.2963242-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605115225.2963242-1-sashal@kernel.org>
References: <20240605115225.2963242-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.32
Content-Transfer-Encoding: 8bit

From: Peng Ma <andypma@tencent.com>

[ Upstream commit cea04f3d9aeebda9d9c063c0dfa71e739c322c81 ]

The cpudata memory from kzalloc() in amd_pstate_epp_cpu_init() is
not freed in the analogous exit function, so fix that.

Signed-off-by: Peng Ma <andypma@tencent.com>
Acked-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Perry Yuan <Perry.Yuan@amd.com>
[ rjw: Subject and changelog edits ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/amd-pstate.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 07f3419954396..3efc2aef31ce4 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1216,6 +1216,13 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 
 static int amd_pstate_epp_cpu_exit(struct cpufreq_policy *policy)
 {
+	struct amd_cpudata *cpudata = policy->driver_data;
+
+	if (cpudata) {
+		kfree(cpudata);
+		policy->driver_data = NULL;
+	}
+
 	pr_debug("CPU %d exiting\n", policy->cpu);
 	return 0;
 }
-- 
2.43.0


