Return-Path: <linux-pm+bounces-20188-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC7FA08AFA
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 10:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B9D47A4043
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 09:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E982080EA;
	Fri, 10 Jan 2025 09:12:26 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049391ADFE4;
	Fri, 10 Jan 2025 09:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736500346; cv=none; b=XM30o3kbAY8J1OTt5WSdEXh4hfWbY3U/eiRBInBUa7rRFU7YzeD06g/isabMykuZCYYBcYi3gQm+Wy3UyW+PkU1Q+gw1a04XqdE21+lU+MqcdjbBcIjLD3zqXKSYyBfkBp56knQeqACxNZ+rRvRVC8TjF1QqrD4LC9Q2yOpdrMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736500346; c=relaxed/simple;
	bh=hySPAPRttZETuxsSfTLhfgDfk61WVzLU8mLozuVJgYU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mdAmSRsRNcOwYLbDAJSmrvLkVqL+bO7hi+GktH5WfNeIg3BuZEPFhOxJ2DV3jbwBsKrrGbPc8JuyrJe2HahyCzKV3BXO2hgL+7IH7ST/tQkZkPKbnZUAEBNGZPaeZ0y4lBYnGTjBZfeAnoiLBgNeRj8cdMMMfgZamBHXKmENDVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4YTwmz35lNz11Nqj;
	Fri, 10 Jan 2025 17:08:35 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 050C51402CF;
	Fri, 10 Jan 2025 17:12:20 +0800 (CST)
Received: from localhost.huawei.com (10.50.165.33) by
 kwepemh100008.china.huawei.com (7.202.181.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 10 Jan 2025 17:12:19 +0800
From: Lifeng Zheng <zhenglifeng1@huawei.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>,
	<mario.limonciello@amd.com>, <perry.yuan@amd.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>, <zhenglifeng1@huawei.com>,
	<fanghao11@huawei.com>
Subject: [PATCH] [PATCH] cpufreq/amd-pstate: Fix per-policy boost flag incorrect when fail
Date: Fri, 10 Jan 2025 17:12:18 +0800
Message-ID: <20250110091218.3530092-1-zhenglifeng1@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemh100008.china.huawei.com (7.202.181.93)

Commit c8c68c38b56f ("cpufreq: amd-pstate: initialize core precision
boost state") sets per-policy boost flag to false when boost fail.
However, this boost flag will be set to reverse value in
store_local_boost() and cpufreq_boost_trigger_state() in cpufreq.c. This
will cause the per-policy boost flag set to true when fail to set boost.
Remove the extra assignment in amd_pstate_set_boost() and keep all
operations on per-policy boost flag outside of set_boost() to fix this
problem.

Fixes: c8c68c38b56f ("cpufreq: amd-pstate: initialize core precision boost state")
Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
---
 drivers/cpufreq/amd-pstate.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index d7b1de97727a..a2573393ce30 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -747,7 +747,6 @@ static int amd_pstate_set_boost(struct cpufreq_policy *policy, int state)
 	guard(mutex)(&amd_pstate_driver_lock);
 
 	ret = amd_pstate_cpu_boost_update(policy, state);
-	policy->boost_enabled = !ret ? state : false;
 	refresh_frequency_limits(policy);
 
 	return ret;
-- 
2.17.1


