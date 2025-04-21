Return-Path: <linux-pm+bounces-25763-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D867A94B47
	for <lists+linux-pm@lfdr.de>; Mon, 21 Apr 2025 05:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A1B93B0665
	for <lists+linux-pm@lfdr.de>; Mon, 21 Apr 2025 03:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF8325743B;
	Mon, 21 Apr 2025 03:00:31 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8CD2561A3;
	Mon, 21 Apr 2025 03:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745204431; cv=none; b=hB0kpJ6vxjuB4uBuMwihy0HIqxy8IFRejC9wCtf4oN0pv6ej92SL4tVnuIZnCwWwdKFGw/4yqC89EcGXPHOmvMSMUQCUsqxpkz2TTTA3vUrd6FTK3Hfji0/dwh9tdSe3SwlcoIvDJcjNfIYRq45VMbp8XVmlbeCUcgMk14IU+MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745204431; c=relaxed/simple;
	bh=eB/QPvCIsjr4y/2wDUf/WblAbW+xJAmt27smax51QXw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u8A6cVB2MPy7jwPozQMGonJl7ULNDdzrEXxfVo24SWGgbjTvMJWpAmwl1Sq5TPY1/aUjttLKBkfVBIkcm53Z0O7HdUC23T/2IZlP8A//F3yd4d5+Fn61A8R42UoX0lDkPxNhRVw3WYR4ZTtyDDF5PRHiEBv4x0rD2OXNvedW/wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4ZgqqC5SsPzsSg2;
	Mon, 21 Apr 2025 11:00:07 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 0CAAC1A0188;
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
Subject: [PATCH 1/4] PM / devfreq: governor: Replace sscanf() with kstrtoul() in set_freq_store()
Date: Mon, 21 Apr 2025 11:00:17 +0800
Message-ID: <20250421030020.3108405-2-zhenglifeng1@huawei.com>
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

Replace sscanf() with kstrtoul() in set_freq_store() and check the result
to avoid invalid input.

Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
---
 drivers/devfreq/governor_userspace.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/devfreq/governor_userspace.c b/drivers/devfreq/governor_userspace.c
index d1aa6806b683..175de0c0b50e 100644
--- a/drivers/devfreq/governor_userspace.c
+++ b/drivers/devfreq/governor_userspace.c
@@ -9,6 +9,7 @@
 #include <linux/slab.h>
 #include <linux/device.h>
 #include <linux/devfreq.h>
+#include <linux/kstrtox.h>
 #include <linux/pm.h>
 #include <linux/mutex.h>
 #include <linux/module.h>
@@ -39,10 +40,13 @@ static ssize_t set_freq_store(struct device *dev, struct device_attribute *attr,
 	unsigned long wanted;
 	int err = 0;
 
+	err = kstrtoul(buf, 0, &wanted);
+	if (err)
+		return err;
+
 	mutex_lock(&devfreq->lock);
 	data = devfreq->governor_data;
 
-	sscanf(buf, "%lu", &wanted);
 	data->user_frequency = wanted;
 	data->valid = true;
 	err = update_devfreq(devfreq);
-- 
2.33.0


