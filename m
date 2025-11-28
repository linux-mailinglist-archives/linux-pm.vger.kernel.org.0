Return-Path: <linux-pm+bounces-38869-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B69B0C91612
	for <lists+linux-pm@lfdr.de>; Fri, 28 Nov 2025 10:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C9493A3302
	for <lists+linux-pm@lfdr.de>; Fri, 28 Nov 2025 09:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B8230102B;
	Fri, 28 Nov 2025 09:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="ubl9T1Nn"
X-Original-To: linux-pm@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDDD2E8B8F;
	Fri, 28 Nov 2025 09:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764321250; cv=none; b=V/FLPY3pdKrpJLgx1zYRtN44vrq5fcLsbScD6JCyvHRKpw9aW5bZPb/CEzzqjpVcm7mr9i/nIvw8uxUc2J6QSNLXIMgzgC4hLhD5L/vGftyM4i9EHtgQZsbJHtiPgmrsiAHMRyTciGro228X1k3W+YolL9bx95ry0hvXEtbN760=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764321250; c=relaxed/simple;
	bh=k+LXNhhv/2D78qcXqcsag2uQnFkwzasMfJEKcTwpknE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VVN+/jbxzxBBEvpOvcCXjEZplyGM8JwLBLICsKCQvrFEwnmBYrFE9C6w1latYDSSNSQmZylTBy5B+YiwYDHFudZhaUt4qHsiLqVwVZW73R8RKG2vPblnR8KBwtGFA1Av6zfTUXhz692uwQqhWE9zJ7auaFR4RNVe5gz6bRz918k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=ubl9T1Nn; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=afxhcsATKeMlsKhFPoKSc71E6igb3p8qnldzp5j38+w=;
	b=ubl9T1NnhEaaVdlXArstXy67RR0SAmMunB3lKOsmGIzrpkSq08UgY7TKP5Cqng/2TrU8A+/5P
	dtQSgirokjl1mmaEmPaz9/C5lLrsojqxClwW87FYxUdQ54FFgVQ54V8R73YklKuKl0/h1j4pLwc
	tuavow9o8yOu+0GSoLkHY0Y=
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4dHncf5M1rz1T4J5;
	Fri, 28 Nov 2025 17:12:18 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id 48F711401F3;
	Fri, 28 Nov 2025 17:14:04 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemf200001.china.huawei.com (7.202.181.227) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 28 Nov 2025 17:14:03 +0800
From: Lifeng Zheng <zhenglifeng1@huawei.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>, <yubowen8@huawei.com>,
	<zhangpengjie2@huawei.com>, <wangzhi12@huawei.com>,
	<linhongye@h-partners.com>, <zhenglifeng1@huawei.com>
Subject: [PATCH v2 1/2] cpufreq: Return -EOPNOTSUPP if no policy is boost supported
Date: Fri, 28 Nov 2025 17:13:51 +0800
Message-ID: <20251128091352.1969333-2-zhenglifeng1@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20251128091352.1969333-1-zhenglifeng1@huawei.com>
References: <20251128091352.1969333-1-zhenglifeng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemf200001.china.huawei.com (7.202.181.227)

In cpufreq_boost_trigger_state(), if all the policies are boost
unsupported, policy_set_boost() will not be called and this function will
return 0. But it is better to return an error to indicate that the platform
doesn't support boost.

Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
---
 drivers/cpufreq/cpufreq.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index e8d7544b77b8..a4399e5490da 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2806,7 +2806,7 @@ static int cpufreq_boost_trigger_state(int state)
 {
 	struct cpufreq_policy *policy;
 	unsigned long flags;
-	int ret = 0;
+	int ret = -EOPNOTSUPP;
 
 	/*
 	 * Don't compare 'cpufreq_driver->boost_enabled' with 'state' here to
@@ -2826,6 +2826,10 @@ static int cpufreq_boost_trigger_state(int state)
 		if (ret)
 			goto err_reset_state;
 	}
+
+	if (ret)
+		goto err_reset_state;
+
 	cpus_read_unlock();
 
 	return 0;
-- 
2.33.0


