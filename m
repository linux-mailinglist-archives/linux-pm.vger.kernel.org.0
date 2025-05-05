Return-Path: <linux-pm+bounces-26679-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00210AAA72B
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 02:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 079791A80D38
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 00:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A392C085C;
	Mon,  5 May 2025 22:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F4x+ExvI"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB6F2C0857;
	Mon,  5 May 2025 22:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484580; cv=none; b=Hz1xqOLNHu9D0uEn9jqZbAIBdd6GljJ9PK7CqNs+2U5MW0hgpoz4dzIxkJB24f56MIAU3wqvlKFLOwHVD7wZT1RjmurIDNEWqkvDaJLWX14R/+6jPkcUfCEdMXm1KZb/c6bKJq0LEaTPMalN+T5H8b21tGXse4HqxudnOCTCtjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484580; c=relaxed/simple;
	bh=5hb73CcXb8+qVB6cbm5qP12nY9T/ydtLkiLbo7bKb20=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BphO0EvdHbKwA89pT/YjjTv1VyyNiuyKHH768UU7bPP6VIslLvPAxvH6CklAjN6ksoYIZ9rwunfq8d5mZ4OUh7Gh11cUWTFvYL2kOyEvv+ZUeHcDHrZmTwhG2Eo/4h+ut1m/ZuRKmOOnR8IDwHap7dXdGMwmcHiyqrWbP/x5e60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F4x+ExvI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2161C4CEEF;
	Mon,  5 May 2025 22:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484578;
	bh=5hb73CcXb8+qVB6cbm5qP12nY9T/ydtLkiLbo7bKb20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F4x+ExvIk/GzBFsajxfXnSmEi2o3Tl/Yq6BkqI7mo0y2TX0WRnFxEJOU2lsrD5L4c
	 TKWi+1YmyWO0oQw/W9SOdMFXAjrW2aGjKL48GsUVTFNgQopPA6rm7jUq1MD7ozu1mr
	 MXGZMh6vpOB/8IQNZbgsiBh5I9phHGM0dC6Vm+VZlWqMGuMSIdeKPmyJkW/YvEpTnL
	 wBG5FmfKBj01WppPld1XC01qBm1iaLICfxj5UW7H8bnJAB2XgJWg3kNxCFm7maxaxm
	 ob9QK7RsVKX+kLI2SgUdqvLePO+rwkWBIRSufSEB7hWV0/1UbU+B4/yKljpiOh01/b
	 1SBDwUkKjW50g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	ray.huang@amd.com,
	gautham.shenoy@amd.com,
	rafael@kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 546/642] cpufreq: amd-pstate: Remove unnecessary driver_lock in set_boost
Date: Mon,  5 May 2025 18:12:42 -0400
Message-Id: <20250505221419.2672473-546-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>

[ Upstream commit db1cafc77aaaf871509da06f4a864e9af6d6791f ]

set_boost is a per-policy function call, hence a driver wide lock is
unnecessary. Also this mutex_acquire can collide with the mutex_acquire
from the mode-switch path in status_store(), which can lead to a
deadlock. So, remove it.

Signed-off-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Acked-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/amd-pstate.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 1b26845703f68..a27749d948b46 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -746,7 +746,6 @@ static int amd_pstate_set_boost(struct cpufreq_policy *policy, int state)
 		pr_err("Boost mode is not supported by this processor or SBIOS\n");
 		return -EOPNOTSUPP;
 	}
-	guard(mutex)(&amd_pstate_driver_lock);
 
 	ret = amd_pstate_cpu_boost_update(policy, state);
 	refresh_frequency_limits(policy);
-- 
2.39.5


