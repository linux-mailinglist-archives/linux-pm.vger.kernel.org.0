Return-Path: <linux-pm+bounces-29338-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7974AE442F
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 15:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B598B1BC1A71
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 13:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F9D2571BE;
	Mon, 23 Jun 2025 13:34:15 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9561F347DD;
	Mon, 23 Jun 2025 13:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750685655; cv=none; b=d+diINkLHIM9OAMBBXlESxLsCj9iFN9obBbMFJCdIFMFI7tGrAX2aS/iHI01Glkzm/l8ohS555NesucHeRUgPH4o2r3Q/QseaAVuOO5V/bfZaoJHpA8USLH6N+dVcXJbT2FQvuZy2xcibQAaWqhwr/IKJKwyBviG7lJ8W4htapw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750685655; c=relaxed/simple;
	bh=nNs90852AvD7c/IM+vWeq4W0y61YMO+WoWSS8I/UFII=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h9G+5ziwVNNFx7h9MgpOD6V8IPryHhvcu7OqisF0S/SvcidtaV/B/DkBgLgF929YcPXaHSBH1mrzQWleGXqGg9GAqC5WNdDej/ec1vIxwYWVT2GMGmCUd0NutzvDKhsDbVH+NaRwnE1/qjJo7wJ7gQWX2WPyj0ZXj/9rhH92+qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bQpq81nVXz2Cff7;
	Mon, 23 Jun 2025 21:30:12 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id EC216180042;
	Mon, 23 Jun 2025 21:34:08 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemh100008.china.huawei.com (7.202.181.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 23 Jun 2025 21:34:08 +0800
From: Lifeng Zheng <zhenglifeng1@huawei.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <ionela.voinescu@arm.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>, <yubowen8@huawei.com>,
	<zhenglifeng1@huawei.com>
Subject: [PATCH 2/7] cpufreq: Init policy->rwsem before it may be possibly used
Date: Mon, 23 Jun 2025 21:33:57 +0800
Message-ID: <20250623133402.3120230-3-zhenglifeng1@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250623133402.3120230-1-zhenglifeng1@huawei.com>
References: <20250623133402.3120230-1-zhenglifeng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemh100008.china.huawei.com (7.202.181.93)

In cpufreq_policy_put_kobj(), policy->rwsem is used. But in
cpufreq_policy_alloc(), if freq_qos_add_notifier() returns an error, error
path via err_kobj_remove or err_min_qos_notifier will be reached and
cpufreq_policy_put_kobj() will be called before policy->rwsem is
initialized. Thus, the calling of init_rwsem() should be moved to where
before these two error paths can be reached.

Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
---
 drivers/cpufreq/cpufreq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 1bc665b5bba8..efc1f4ac85cb 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1284,6 +1284,8 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
 		goto err_free_real_cpus;
 	}
 
+	init_rwsem(&policy->rwsem);
+
 	freq_constraints_init(&policy->constraints);
 
 	policy->nb_min.notifier_call = cpufreq_notifier_min;
@@ -1306,7 +1308,6 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
 	}
 
 	INIT_LIST_HEAD(&policy->policy_list);
-	init_rwsem(&policy->rwsem);
 	spin_lock_init(&policy->transition_lock);
 	init_waitqueue_head(&policy->transition_wait);
 	INIT_WORK(&policy->update, handle_update);
-- 
2.33.0


