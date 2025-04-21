Return-Path: <linux-pm+bounces-25764-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4346AA94B4A
	for <lists+linux-pm@lfdr.de>; Mon, 21 Apr 2025 05:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76EA616FCED
	for <lists+linux-pm@lfdr.de>; Mon, 21 Apr 2025 03:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F8D2580D3;
	Mon, 21 Apr 2025 03:00:33 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB411E9B03;
	Mon, 21 Apr 2025 03:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745204432; cv=none; b=ZWyWsUN7xbbeGjfTw157vhbnhqqy+cRkilnfCnIT+SIa+ym1I7znx3yCtAhsFjwPHlFU/O6l5y8CvxpvDE1ti7JFfwP7x8f9UFNyItrxUYP4Fcodfhj73JgLsvjgzTmprbas6IYqTkbjz5/Xhp1Gq493yXMOVRWc9MCzmKboK1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745204432; c=relaxed/simple;
	bh=OqTv1HO/hF/hcOvfmtjmlaf7GztSdHtxh/CKXPMvZ8Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QM/BCycuYVxvnWY+sHAhe1ONkskXzMywrIf3kHSATRyueNjqA8aIyJ51CroLUe8nzjjI38PZDQR2Pg1TUpl2PPVGnu3IDQIN++TxAq6Enb0cTs/ZKW4z256hXudsmaILOhhx4qYMgz0BYQGEG0k84VqDLdRb6cNjad2fL6668L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4ZgqlV4lTPz2CdFF;
	Mon, 21 Apr 2025 10:56:54 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 03E6F140119;
	Mon, 21 Apr 2025 11:00:23 +0800 (CST)
Received: from localhost.huawei.com (10.50.165.33) by
 kwepemh100008.china.huawei.com (7.202.181.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 21 Apr 2025 11:00:22 +0800
From: Lifeng Zheng <zhenglifeng1@huawei.com>
To: <myungjoo.ham@samsung.com>, <kyungmin.park@samsung.com>,
	<cw00.choi@samsung.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>, <yubowen8@huawei.com>,
	<cenxinghai@h-partners.com>, <zhenglifeng1@huawei.com>
Subject: [PATCH 3/4] PM / devfreq: Remove redundant devfreq_get_freq_range() calling in devfreq_add_device()
Date: Mon, 21 Apr 2025 11:00:19 +0800
Message-ID: <20250421030020.3108405-4-zhenglifeng1@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250421030020.3108405-1-zhenglifeng1@huawei.com>
References: <20250421030020.3108405-1-zhenglifeng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemh100008.china.huawei.com (7.202.181.93)

The calling of devfreq_get_freq_range() in devfreq_add_device() is
redundant because min_freq and max_freq are never used. Remove it.

Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
---
 drivers/devfreq/devfreq.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 2810c84b9f8a..18e3f7e063a4 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -804,7 +804,6 @@ struct devfreq *devfreq_add_device(struct device *dev,
 {
 	struct devfreq *devfreq;
 	struct devfreq_governor *governor;
-	unsigned long min_freq, max_freq;
 	int err = 0;
 
 	if (!dev || !profile || !governor_name) {
@@ -872,8 +871,6 @@ struct devfreq *devfreq_add_device(struct device *dev,
 		goto err_dev;
 	}
 
-	devfreq_get_freq_range(devfreq, &min_freq, &max_freq);
-
 	devfreq->suspend_freq = dev_pm_opp_get_suspend_opp_freq(dev);
 	devfreq->opp_table = dev_pm_opp_get_opp_table(dev);
 	if (IS_ERR(devfreq->opp_table))
-- 
2.33.0


