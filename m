Return-Path: <linux-pm+bounces-14669-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7B4985996
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2024 13:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA5D71F24023
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2024 11:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93671A4B7A;
	Wed, 25 Sep 2024 11:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ebtWyxET"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06A91A4B70;
	Wed, 25 Sep 2024 11:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264373; cv=none; b=l346eC77EK5nzIFB/sbS2rlTS2FBa1KM+TK/AQErgUfEUNyv9KTF3HwwH59FzAyODvA4hx+bRyBJd5z2v0HAQyNNcyp6KwVnXxp7JGRoAE1Rh9rFUMaNDIsp4eysjRmjVrjDBVKGPXq7SevnXJuBgqIftCsrv08R5ODR9NNdeDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264373; c=relaxed/simple;
	bh=6a1bwz40ZkqHZ3gLJ3mVlCkX9Gp1T/afwEeN5qlkvRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XeV004HelsfAGPTwkZ4whD8UrFzbOIlHAXVdLbVeFE/R9bW0Z3XFtTsFGKRxqS8EgleWrYAeHzR4KmJwppkBY6c/e5feaWNk7/I2Ibv8RYUdlw2VWheIISRjSJa+o+a2w8JXCwz1ZwRhmAuHaM6AMLFfFpvoz96O14gJhNCKQKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ebtWyxET; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FCF5C4CEC7;
	Wed, 25 Sep 2024 11:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264373;
	bh=6a1bwz40ZkqHZ3gLJ3mVlCkX9Gp1T/afwEeN5qlkvRg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ebtWyxETo09JH2KORanWLOFs+A7XKBppdM/sLtOZqMoFpY+g2w2iLm/N+BGtRrN9g
	 6Zn/xKBemel1te31g8LHcLVN0TcDt+h0t3FdJsRKHcCrCSCZMTzoU5/OQyX7m6XTdN
	 1J/gx2Jv2jZQYv8AOk9SzubrZdpwBj9m7zvShna/oarzSpINbFRTdXSrMU1aDbanpP
	 EaYjz9TF4OCgrzEOeTuaryKLgiseSm339QfNWKgtIpGOyhT01Vlgrr1NCQ9Lblxw4o
	 1gHHCXjdQ61fcyFhsZBxkN1/KuRT5KNTDL7u0L5RhIotck1YNFyIES72nGDHOSXpkl
	 nHnkufkuBEwsQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Anastasia Belova <abelova@astralinux.ru>,
	Perry Yuan <perry.yuan@amd.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	ray.huang@amd.com,
	gautham.shenoy@amd.com,
	mario.limonciello@amd.com,
	rafael@kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 072/244] cpufreq: amd-pstate: add check for cpufreq_cpu_get's return value
Date: Wed, 25 Sep 2024 07:24:53 -0400
Message-ID: <20240925113641.1297102-72-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

From: Anastasia Belova <abelova@astralinux.ru>

[ Upstream commit 5493f9714e4cdaf0ee7cec15899a231400cb1a9f ]

cpufreq_cpu_get may return NULL. To avoid NULL-dereference check it
and return in case of error.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
Reviewed-by: Perry Yuan <perry.yuan@amd.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/amd-pstate.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 259a917da75f3..103b43e529b5f 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -656,7 +656,12 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
 	unsigned long max_perf, min_perf, des_perf,
 		      cap_perf, lowest_nonlinear_perf;
 	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
-	struct amd_cpudata *cpudata = policy->driver_data;
+	struct amd_cpudata *cpudata;
+
+	if (!policy)
+		return;
+
+	cpudata = policy->driver_data;
 
 	if (policy->min != cpudata->min_limit_freq || policy->max != cpudata->max_limit_freq)
 		amd_pstate_update_min_max_limit(policy);
@@ -870,11 +875,16 @@ static void amd_pstate_init_prefcore(struct amd_cpudata *cpudata)
 static void amd_pstate_update_limits(unsigned int cpu)
 {
 	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
-	struct amd_cpudata *cpudata = policy->driver_data;
+	struct amd_cpudata *cpudata;
 	u32 prev_high = 0, cur_high = 0;
 	int ret;
 	bool highest_perf_changed = false;
 
+	if (!policy)
+		return;
+
+	cpudata = policy->driver_data;
+
 	mutex_lock(&amd_pstate_driver_lock);
 	if ((!amd_pstate_prefcore) || (!cpudata->hw_prefcore))
 		goto free_cpufreq_put;
-- 
2.43.0


