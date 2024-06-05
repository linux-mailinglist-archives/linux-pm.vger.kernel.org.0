Return-Path: <linux-pm+bounces-8638-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8E08FCB97
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2024 14:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85AA91F21DF5
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2024 12:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF8421C16F;
	Wed,  5 Jun 2024 11:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mO8yHuZg"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A3019925C;
	Wed,  5 Jun 2024 11:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588317; cv=none; b=iiHan7fXLdOPPB95vBkk0dZEIrIKvdvKTYpVDZCyX7CjeD/ZwP40fxnUP9CtKAq0gu2/0S0qr696OAz4HLwzjC1hQBUxOh9/9tUghRKOtX6CrOXePRyeEmWowE2/qw4MvTQ6g3Ku6qB+0ntbRGDS03Cg7Uda/Mm4442yf8cQPzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588317; c=relaxed/simple;
	bh=kjeZ8UHJFxHkLku+pSLI36o1lVjKiKC7NzUYHLFjFwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LSmkVpxxEgRHoZydoxYZkxfKP8NSnHoB2aaJd1SyR8J8h9aqHEWdYfodNHnnsM8PdGErPOcyP/1dW9FndZFdTzfPcLKm7rqgFa5EBFBGIHJVskzPeM+TozWwJ4I6AndyVDHkid5iiYvnYIPP5q4gBZM8/V+DW3ZAoMkj3IP/9iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mO8yHuZg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9FD8C4AF09;
	Wed,  5 Jun 2024 11:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588316;
	bh=kjeZ8UHJFxHkLku+pSLI36o1lVjKiKC7NzUYHLFjFwg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mO8yHuZghR1kD0XUAUF5JTvTdOKhZg6EXWeL/idGvo8auQsDxsEJJtz8U+Jaoxgyk
	 T2GusckToELEAp9TlTVQdkz5jTWclz8ARypFv5S4X0RsMiz9bTTFBfwpvQjavO+l7k
	 BoDFf2JHdfOcgJcLaaK5tBgCC2vNbEx938TwvYWri5qSufnP3hejuVF6oAOsHMrZv1
	 CbUi7kuhJR3aOnrM2KOLdMout8CSbXqSGfsRHeHFfERDNhIPBPnCDzmRmd2oMbv72m
	 qAO9EIO+y6uGx6+NiZpBU4b0zt6MqkPYj5tVhILqYM2v8mENquwQ8FXeSl0BrcMLj1
	 iUO7TSeVZ607g==
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
Subject: [PATCH AUTOSEL 6.8 21/24] cpufreq: amd-pstate: fix memory leak on CPU EPP exit
Date: Wed,  5 Jun 2024 07:50:31 -0400
Message-ID: <20240605115101.2962372-21-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605115101.2962372-1-sashal@kernel.org>
References: <20240605115101.2962372-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.12
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


