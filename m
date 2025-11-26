Return-Path: <linux-pm+bounces-38673-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD11C87EE2
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 04:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 659D5345DF5
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 03:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9254330B505;
	Wed, 26 Nov 2025 03:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="3N4s5Tub"
X-Original-To: linux-pm@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98D62FDC30;
	Wed, 26 Nov 2025 03:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764127172; cv=none; b=THhNolmq0NEfAJWm4ohLj3mgB/43ONlGkti1BvXjf0phmpcXok/hGPvncrj66Xv7/A76HYRQYc7jSXb1qh5rZScSGLDlRF5IcmkrXeBOmd+dgeYF3e0aPkJmMqxaxqGOCLxwTctbdVM/PVHJ28ODwmBddO3mP5NidPwGTA7SN4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764127172; c=relaxed/simple;
	bh=9jfs19wTbS6oSIU2Wqul+QVgs3u1wwQIGGbrxKpQYZo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dt9zHwIWpXgNwvWzKTMSmS2/j0CwKgf99pbgORnJao/Ygb+BcNyUZPWNVf5F/fxgbJGX3qBhxdsHbnbg5AKCFWWiJguisKHbtDjiJ9akfPbAC7jTXj5xFV6H/ty9XeVyn5XjCRLdFpMy/KzF/MWUUJ2/lGIMsrb61ShvrkDOixM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=3N4s5Tub; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=VcXRjcDFFQ1PQSh9wuYY1aQWvTuqM0TiPzkrSBmMDA4=;
	b=3N4s5TubRyjD9KDAn78++zYqnoZn3ZtDgWE7k5LmMZQXcm9OefXTXJGGf/EoXBPfjKfevYQoD
	ZcClsXQ481PL0tEyioVbOf5DuqhTRhz8WA2S8RqsDvSyoPTRpPsCvsnNEoHcF4w33KwxAhwI2tg
	wb4wctTAknBOfzfoztWCKJU=
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4dGPrS3RQyz1T4HQ;
	Wed, 26 Nov 2025 11:17:44 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id DF02C180471;
	Wed, 26 Nov 2025 11:19:26 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemf200001.china.huawei.com (7.202.181.227) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 26 Nov 2025 11:19:26 +0800
From: Lifeng Zheng <zhenglifeng1@huawei.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>, <yubowen8@huawei.com>,
	<zhangpengjie2@huawei.com>, <wangzhi12@huawei.com>,
	<linhongye@h-partners.com>, <zhenglifeng1@huawei.com>
Subject: [PATCH] cpufreq: Return -EINVAL if no policy is boost supported
Date: Wed, 26 Nov 2025 11:19:16 +0800
Message-ID: <20251126031916.3641176-1-zhenglifeng1@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemf200001.china.huawei.com (7.202.181.227)

In cpufreq_boost_trigger_state(), if all the policies are boost
unsupported, policy_set_boost() will not be called and this function will
return 0. But it is better to return an error to indicate that the platform
doesn't support boost.

Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
---
 drivers/cpufreq/cpufreq.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index e8d7544b77b8..2df714b24074 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2806,7 +2806,9 @@ static int cpufreq_boost_trigger_state(int state)
 {
 	struct cpufreq_policy *policy;
 	unsigned long flags;
-	int ret = 0;
+
+	/* Return -EINVAL if no policy is boost supported. */
+	int ret = -EINVAL;
 
 	/*
 	 * Don't compare 'cpufreq_driver->boost_enabled' with 'state' here to
@@ -2824,14 +2826,12 @@ static int cpufreq_boost_trigger_state(int state)
 
 		ret = policy_set_boost(policy, state);
 		if (ret)
-			goto err_reset_state;
+			break;
 	}
 	cpus_read_unlock();
 
-	return 0;
-
-err_reset_state:
-	cpus_read_unlock();
+	if (!ret)
+		return 0;
 
 	write_lock_irqsave(&cpufreq_driver_lock, flags);
 	cpufreq_driver->boost_enabled = !state;
-- 
2.33.0


