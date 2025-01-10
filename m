Return-Path: <linux-pm+bounces-20191-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB875A08B8F
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 10:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D70DB3A1870
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 09:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970C420ADD1;
	Fri, 10 Jan 2025 09:19:57 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE56C20ADC9;
	Fri, 10 Jan 2025 09:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736500797; cv=none; b=VM1oBuHFjoIMr0iA6OB73RTY/KA0aWyLu++QurAjizkyq98I0OGj6FEEnmcp3923H6E3v1uXuFBYxgprobLHR1byjYoWdsiL2b8xKaM+B7MX6dwthTA2psExcVf54qs3WAbst2zpQzIbbKsvRXNuAquzx1AAmJynJs/ZFS+Z2UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736500797; c=relaxed/simple;
	bh=hySPAPRttZETuxsSfTLhfgDfk61WVzLU8mLozuVJgYU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cfs3ddxu2OV2tIu2C3QQ1RmyYDRZbWp0Nx7KA3CUO2B2p73Om1ytntJ4Yf+28CMQk0L/5h+hnn/n88ws3YqkGnTDjEhJMAoALgYej5djmyhQEawKoDKeKEJQrDqeyWCsks6fQofBPMHtx4RC0fzMKZccRXM0rwigzoHv5U3AW5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4YTwyN73J6zbjrx;
	Fri, 10 Jan 2025 17:16:44 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 2035E180101;
	Fri, 10 Jan 2025 17:19:51 +0800 (CST)
Received: from localhost.huawei.com (10.50.165.33) by
 kwepemh100008.china.huawei.com (7.202.181.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 10 Jan 2025 17:19:50 +0800
From: Lifeng Zheng <zhenglifeng1@huawei.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>,
	<mario.limonciello@amd.com>, <perry.yuan@amd.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>, <zhenglifeng1@huawei.com>,
	<fanghao11@huawei.com>
Subject: [PATCH v2] cpufreq/amd-pstate: Fix per-policy boost flag incorrect when fail
Date: Fri, 10 Jan 2025 17:19:49 +0800
Message-ID: <20250110091949.3610770-1-zhenglifeng1@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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


