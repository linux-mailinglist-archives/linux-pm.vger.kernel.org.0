Return-Path: <linux-pm+bounces-39041-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 511E1C9A708
	for <lists+linux-pm@lfdr.de>; Tue, 02 Dec 2025 08:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C93B3A6248
	for <lists+linux-pm@lfdr.de>; Tue,  2 Dec 2025 07:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684EC3016E3;
	Tue,  2 Dec 2025 07:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="FiBeeH/u"
X-Original-To: linux-pm@vger.kernel.org
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EA6254B18;
	Tue,  2 Dec 2025 07:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764660467; cv=none; b=fE7Lq2H9fV9teBmqvN79182OdBSzw4BcIoeFvojP+QQN8LGM+JTviPDmnopPUgRHSo/ro51bdVn7ihxgD4oTL4SqCnsARXzLH7EMERzY2t/oP3O8cR8cXkr13TZTAyT4WTzgAtb48sg6+/r7FOYt5WfLca0/1JaWMNLhJQ0Y7/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764660467; c=relaxed/simple;
	bh=ZuxBc1P6orFr54kEMeK1EYIOEP3LLwLrHGpx8Bp7N2c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PrKnVCMA7bNPhTcM9digOCCBDlOSgrPcREl14FNwJZeeGdIV8fXwNgZxP9BJnD7hmY7AsoVGvophVbocAZT54+5q8AuR+82Jdrb5cwongsrs4yjmpqnzcOG4Zpdquvyz3T/Z0tD374WqllMg3qG8ri4lplPGBg2l5l2NY4PKwQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=FiBeeH/u; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=dgEwo616JrDGpFgdHl6UcsQdFxYIIq6oh0gOVD5Eqfo=;
	b=FiBeeH/u9zpPxGM1380Gj2FCa949sN3dPc6Gc3q5969qNSLAEdZtNtvlq6RwscjcYFODHx9Fj
	scvP1LvqdihsxJJ7NpcP91YGriZALUyZ5TZSIku8NlFhT++hLt9sMcyG6BQy/R4uLgadmRrHtK7
	xq/tAG04/Ww4sLxWJAG2ss8=
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4dLC3z55vcz1K9CW;
	Tue,  2 Dec 2025 15:25:51 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id 8EC9C1A0188;
	Tue,  2 Dec 2025 15:27:41 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemf200001.china.huawei.com (7.202.181.227) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 2 Dec 2025 15:27:40 +0800
From: Lifeng Zheng <zhenglifeng1@huawei.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>, <yubowen8@huawei.com>,
	<zhangpengjie2@huawei.com>, <wangzhi12@huawei.com>,
	<linhongye@h-partners.com>, <zhenglifeng1@huawei.com>
Subject: [PATCH v3 2/2] cpufreq: cpufreq_boost_trigger_state() optimization
Date: Tue, 2 Dec 2025 15:27:27 +0800
Message-ID: <20251202072727.1368285-3-zhenglifeng1@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20251202072727.1368285-1-zhenglifeng1@huawei.com>
References: <20251202072727.1368285-1-zhenglifeng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemf200001.china.huawei.com (7.202.181.227)

Optimize the error handling branch code in cpufreq_boost_trigger_state().

Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index a4399e5490da..a2507a5b42d9 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2823,19 +2823,14 @@ static int cpufreq_boost_trigger_state(int state)
 			continue;
 
 		ret = policy_set_boost(policy, state);
-		if (ret)
-			goto err_reset_state;
+		if (unlikely(ret))
+			break;
 	}
 
-	if (ret)
-		goto err_reset_state;
-
 	cpus_read_unlock();
 
-	return 0;
-
-err_reset_state:
-	cpus_read_unlock();
+	if (likely(!ret))
+		return 0;
 
 	write_lock_irqsave(&cpufreq_driver_lock, flags);
 	cpufreq_driver->boost_enabled = !state;
-- 
2.33.0


