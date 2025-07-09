Return-Path: <linux-pm+bounces-30449-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79877AFE62F
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 12:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAA9B5A03FA
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 10:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1CC299A82;
	Wed,  9 Jul 2025 10:42:04 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7BB295517;
	Wed,  9 Jul 2025 10:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752057724; cv=none; b=g8xHkiJ8s0P0bDmRTrQPZqJy4YOrzUaRWpxo3ie+p+L2GWCFDqeld8A3yxeoBaL4prox7NWsl3GVIdufh9IRI0XPXFre4KAInpOG1ZpHQsx+2P5T6scHtsEKOGjqHzhywX7uGz5gKNJlPvw+Pf+461UPtLKFAdGI7LEgS87lrGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752057724; c=relaxed/simple;
	bh=vvmBHtD61cbnPFztUuFrT09mgfVv2kLY4F89WkAEAkU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UoAzhTlMWOIGh77xCyR+j656sarkw3JnH6JAhifAve12J0qybzmUZ8GXs3T9DY4Gr3SbOB956IFULX3oVo24SlUjTLv3/W08rkvy3wK0HPtUbE2r3TZcFxoJjL+9iTp2kfMclnH3o5TgFCbAGojZCuU1z3AXOw6erwFzWWF5svs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4bcZGb2ZHKz1d1sS;
	Wed,  9 Jul 2025 18:39:19 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 184C6180B64;
	Wed,  9 Jul 2025 18:41:58 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemh100008.china.huawei.com (7.202.181.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 9 Jul 2025 18:41:57 +0800
From: Lifeng Zheng <zhenglifeng1@huawei.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <ionela.voinescu@arm.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>, <yubowen8@huawei.com>,
	<zhenglifeng1@huawei.com>
Subject: [PATCH v2 2/4] cpufreq: Init policy->rwsem before it may be possibly used
Date: Wed, 9 Jul 2025 18:41:43 +0800
Message-ID: <20250709104145.2348017-3-zhenglifeng1@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250709104145.2348017-1-zhenglifeng1@huawei.com>
References: <20250709104145.2348017-1-zhenglifeng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemh100008.china.huawei.com (7.202.181.93)

In cpufreq_policy_put_kobj(), policy->rwsem is used. But in
cpufreq_policy_alloc(), if freq_qos_add_notifier() returns an error, error
path via err_kobj_remove or err_min_qos_notifier will be reached and
cpufreq_policy_put_kobj() will be called before policy->rwsem is
initialized. Thus, the calling of init_rwsem() should be moved to where
before these two error paths can be reached.

Fixes: 67d874c3b2c6 ("cpufreq: Register notifiers with the PM QoS framework")
Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
---
 drivers/cpufreq/cpufreq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index eb713d116c34..2175d2df95b6 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1281,6 +1281,8 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
 		goto err_free_real_cpus;
 	}
 
+	init_rwsem(&policy->rwsem);
+
 	freq_constraints_init(&policy->constraints);
 
 	policy->nb_min.notifier_call = cpufreq_notifier_min;
@@ -1303,7 +1305,6 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
 	}
 
 	INIT_LIST_HEAD(&policy->policy_list);
-	init_rwsem(&policy->rwsem);
 	spin_lock_init(&policy->transition_lock);
 	init_waitqueue_head(&policy->transition_wait);
 	INIT_WORK(&policy->update, handle_update);
-- 
2.33.0


