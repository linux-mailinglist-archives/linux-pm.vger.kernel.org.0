Return-Path: <linux-pm+bounces-25761-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 315DDA94B44
	for <lists+linux-pm@lfdr.de>; Mon, 21 Apr 2025 05:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E42A91890E32
	for <lists+linux-pm@lfdr.de>; Mon, 21 Apr 2025 03:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E430B44C94;
	Mon, 21 Apr 2025 03:00:26 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3872571C1;
	Mon, 21 Apr 2025 03:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745204426; cv=none; b=ndg0D0TVFavm+tiKh35DIDJfC8ME9rg4A3ocEs+anc4v0SyI5tRvO1v9ENynKDtrqeclZzAaV1A3M14aBCm7MwWKUDC1MyIpRQ6H99iYdlM/Cz1qd/ZcxSSSPfEsp+KmN8WfXTQOq2lztWIvnqQ9TaUjE9z3BD2PmJJlPanocdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745204426; c=relaxed/simple;
	bh=/IYGqHZb/LjYMhHEpC7wrGfAhEB/2iaJVtOGQS30ffE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kY6kASiiuybmO8tvq0rGFiyJv+I1QsfV/PcwT2gGkptzLD7+rHPA0Y1GTwtiMC+0WBPjWp/hPLM3lWuFEGZakal822KPUFWXYrSHWYPBemtXRet988VxIntUkVtSS5XDbMNebvnqGG+NNUd7ZcSfgAafDTyiQSXGtJMiSKHAi1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Zgqkk2dW0zvWqs;
	Mon, 21 Apr 2025 10:56:14 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 82F4C180B46;
	Mon, 21 Apr 2025 11:00:22 +0800 (CST)
Received: from localhost.huawei.com (10.50.165.33) by
 kwepemh100008.china.huawei.com (7.202.181.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 21 Apr 2025 11:00:21 +0800
From: Lifeng Zheng <zhenglifeng1@huawei.com>
To: <myungjoo.ham@samsung.com>, <kyungmin.park@samsung.com>,
	<cw00.choi@samsung.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>, <yubowen8@huawei.com>,
	<cenxinghai@h-partners.com>, <zhenglifeng1@huawei.com>
Subject: [PATCH 2/4] PM / devfreq: Limit max_freq with scaling_min_freq
Date: Mon, 21 Apr 2025 11:00:18 +0800
Message-ID: <20250421030020.3108405-3-zhenglifeng1@huawei.com>
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

Limit max_freq in devfreq_get_freq_range() with scaling_min_freq to avoid
showing an unreachable freq when reading it.

Use macro clamp to simplify code.

Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
---
 drivers/devfreq/devfreq.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 98657d3b9435..2810c84b9f8a 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -152,11 +152,8 @@ void devfreq_get_freq_range(struct devfreq *devfreq,
 				(unsigned long)HZ_PER_KHZ * qos_max_freq);
 
 	/* Apply constraints from OPP interface */
-	*min_freq = max(*min_freq, devfreq->scaling_min_freq);
-	*max_freq = min(*max_freq, devfreq->scaling_max_freq);
-
-	if (*min_freq > *max_freq)
-		*min_freq = *max_freq;
+	*max_freq = clamp(*max_freq, devfreq->scaling_min_freq, devfreq->scaling_max_freq);
+	*min_freq = clamp(*min_freq, devfreq->scaling_min_freq, *max_freq);
 }
 EXPORT_SYMBOL(devfreq_get_freq_range);
 
-- 
2.33.0


