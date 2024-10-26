Return-Path: <linux-pm+bounces-16492-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A089B1650
	for <lists+linux-pm@lfdr.de>; Sat, 26 Oct 2024 10:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E38A01C21341
	for <lists+linux-pm@lfdr.de>; Sat, 26 Oct 2024 08:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8721C6F47;
	Sat, 26 Oct 2024 08:26:03 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390B92EAE0;
	Sat, 26 Oct 2024 08:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729931163; cv=none; b=DJTNuDOpJe21qy45bFuinfh6DE2s5LMPB20ZPWjYxn4Yn34zLeABOCSfzxaj3AAoQyp5qiEOFlB7/dkuoyz63p6uFQGuvp7sqdTnnCjIT5MMnKlyrR88aEnKkd3tWXBWRPaSwLVqbvT5VK+PdsPRPQacb0aQK65JQxrxhMOHNpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729931163; c=relaxed/simple;
	bh=ik0BP8k0LDh/fZa4g/ZOlnF0fyV+bSjPZxHuNRMpO78=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=acySFLaa600pIg6dV5iLfkU13iUhgPpGFY/DCPsPqINprR4Bm16B9lKLfuXFqx1VGoyhBqhCeM6wW7Rr25OAWFI2uMWO9S3pZ3HK5QtDXBfSqgUTYLHIVz2GVcKQjxBBzqFRLQwgY9ba5EcFGgUhQfGqV521KJSSg1xPDOXukzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XbCNc4ZcDzlXHX;
	Sat, 26 Oct 2024 16:24:00 +0800 (CST)
Received: from kwepemg200008.china.huawei.com (unknown [7.202.181.35])
	by mail.maildlp.com (Postfix) with ESMTPS id 0A3AE1401F4;
	Sat, 26 Oct 2024 16:25:57 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemg200008.china.huawei.com
 (7.202.181.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 26 Oct
 2024 16:25:56 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <daniel.lezcano@kernel.org>, <rafael@kernel.org>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH] powercap: dtpm_devfreq: Fix possible memory leak in __dtpm_devfreq_setup()
Date: Sat, 26 Oct 2024 16:25:25 +0800
Message-ID: <20241026082525.474914-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemg200008.china.huawei.com (7.202.181.35)

If dev_pm_qos_add_request() fails, dtpm_devfreq will fail
to free, which cause the memory leak, add a new goto label
to free it.

Fixes: e44655617317 ("powercap/drivers/dtpm: Add dtpm devfreq with energy model support")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/powercap/dtpm_devfreq.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/powercap/dtpm_devfreq.c b/drivers/powercap/dtpm_devfreq.c
index d1dff6ccab12..85b6982901d1 100644
--- a/drivers/powercap/dtpm_devfreq.c
+++ b/drivers/powercap/dtpm_devfreq.c
@@ -171,8 +171,7 @@ static int __dtpm_devfreq_setup(struct devfreq *devfreq, struct dtpm *parent)
 	ret = dtpm_register(dev_name(dev), &dtpm_devfreq->dtpm, parent);
 	if (ret) {
 		pr_err("Failed to register '%s': %d\n", dev_name(dev), ret);
-		kfree(dtpm_devfreq);
-		return ret;
+		goto out_dtpm_free;
 	}
 
 	ret = dev_pm_qos_add_request(dev, &dtpm_devfreq->qos_req,
@@ -190,6 +189,8 @@ static int __dtpm_devfreq_setup(struct devfreq *devfreq, struct dtpm *parent)
 out_dtpm_unregister:
 	dtpm_unregister(&dtpm_devfreq->dtpm);
 
+out_dtpm_free:
+	kfree(dtpm_devfreq);
 	return ret;
 }
 
-- 
2.34.1


