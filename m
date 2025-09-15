Return-Path: <linux-pm+bounces-34621-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F242BB57025
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 08:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B336A172944
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 06:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABFB427FD46;
	Mon, 15 Sep 2025 06:21:44 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7899927FB3E;
	Mon, 15 Sep 2025 06:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757917304; cv=none; b=n34wS5B/dUpWHWUW4RkQ6q6kLdDIJhVT7KoU3KTgnY9Lqr8dvqd3mKMooNNsbK3GmpfD2DKZdgZ54uotN6bx0c2p/lIIlM0VVmPUMQ2VD45SkYY5pu065Rip4EhIV5b/zKdYsmhlcR0wMuEtG7TdMA/BcLfhQpwwQ2DrVUs1S3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757917304; c=relaxed/simple;
	bh=8MrpnsoVIpmUDeKsvKj8ItBysKFNmcy3yS25cp7V4UU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OnNP4eIqmn/+hPT2DvLDcgP7kOYWhNbfdslQovzjNkIGkgyxbgS4CngNZYKDQXEbU6Ze7ZdeTTYAmK0yfxsPetqsehYeiG2cNWIYzMs8yTqQ4W9Y6d7emvwv9vEI/1tBLA2kBOPSKS2/Frw3apacMPrttpFXaBOEq1N/LxnQN98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4cQFFy371mz2VRhZ;
	Mon, 15 Sep 2025 14:18:14 +0800 (CST)
Received: from kwepemg100007.china.huawei.com (unknown [7.202.181.25])
	by mail.maildlp.com (Postfix) with ESMTPS id 896691800CE;
	Mon, 15 Sep 2025 14:21:36 +0800 (CST)
Received: from huawei.com (10.50.165.33) by kwepemg100007.china.huawei.com
 (7.202.181.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 15 Sep
 2025 14:21:35 +0800
From: Pengjie Zhang <zhangpengjie2@huawei.com>
To: <myungjoo.ham@samsung.com>, <kyungmin.park@samsung.com>,
	<cw00.choi@samsung.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <lihuisong@huawei.com>,
	<yubowen8@huawei.com>, <linhongye@h-partners.com>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>, <zhangpengjie2@huawei.com>
Subject: [PATCH] PM / devfreq: hisi: Fix potential UAF in OPP handling
Date: Mon, 15 Sep 2025 14:21:35 +0800
Message-ID: <20250915062135.748653-1-zhangpengjie2@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemg100007.china.huawei.com (7.202.181.25)

Ensure all required data is acquired before calling dev_pm_opp_put(opp)
to maintain correct resource acquisition and release order.

Fixes: 7da2fdaaa1e6 ("PM / devfreq: Add HiSilicon uncore frequency scaling driver")
Signed-off-by: Pengjie Zhang <zhangpengjie2@huawei.com>
---
 drivers/devfreq/hisi_uncore_freq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/devfreq/hisi_uncore_freq.c b/drivers/devfreq/hisi_uncore_freq.c
index 96d1815059e3..c1ed70fa0a40 100644
--- a/drivers/devfreq/hisi_uncore_freq.c
+++ b/drivers/devfreq/hisi_uncore_freq.c
@@ -265,10 +265,11 @@ static int hisi_uncore_target(struct device *dev, unsigned long *freq,
 		dev_err(dev, "Failed to get opp for freq %lu hz\n", *freq);
 		return PTR_ERR(opp);
 	}
-	dev_pm_opp_put(opp);
 
 	data = (u32)(dev_pm_opp_get_freq(opp) / HZ_PER_MHZ);
 
+	dev_pm_opp_put(opp);
+
 	return hisi_uncore_cmd_send(uncore, HUCF_PCC_CMD_SET_FREQ, &data);
 }
 
-- 
2.33.0


