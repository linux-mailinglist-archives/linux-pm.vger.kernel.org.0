Return-Path: <linux-pm+bounces-15913-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 970839A327B
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 04:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BD7A1F21717
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 02:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66876481A3;
	Fri, 18 Oct 2024 02:16:45 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7870320E325
	for <linux-pm@vger.kernel.org>; Fri, 18 Oct 2024 02:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729217805; cv=none; b=OBGjAsZopvKWnvswClZ1JzCGDmU8Q7g4FkDvXh36A+NwIsYtBWP+r7v6oqRbvaowyBHoj7tmjAK3D4epInhy8LnwI427rB1lXR+JzcBfC4ASJmK/L+OR9HWSIH8AIfuP2H+0ZfMkWS6LkTPL9+GCPfqnLRkkpMn+C9laM0cFKJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729217805; c=relaxed/simple;
	bh=kXyimktdM8+rvXuTaQgBcYOXrDCXtvpU2kXneH24rO8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jKFnkwC244Y80gUiDx8gfRq0obAi7wbKLz5DXUuR16hSUGVSzXQuIuZynF0LOd1DzTJ3Rh5p9xgAmHn/fEoQXzYmHwzwOq6Y6twRGsEHO259qfQSTw1YcWzoy2Lx/KvtCK/+LpqObE6biWj8RvXFip2xfFJU2ulOxClP5d77G8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XV7bY4FQxz20qSb;
	Fri, 18 Oct 2024 10:15:53 +0800 (CST)
Received: from dggpeml500024.china.huawei.com (unknown [7.185.36.10])
	by mail.maildlp.com (Postfix) with ESMTPS id 875A31400FD;
	Fri, 18 Oct 2024 10:16:39 +0800 (CST)
Received: from huawei.com (10.175.112.208) by dggpeml500024.china.huawei.com
 (7.185.36.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 18 Oct
 2024 10:16:39 +0800
From: Yuan Can <yuancan@huawei.com>
To: <daniel.lezcano@kernel.org>, <rafael@kernel.org>,
	<linux-pm@vger.kernel.org>
CC: <yuancan@huawei.com>
Subject: [PATCH] powercap/dtpm_devfreq: Fix error check against dev_pm_qos_add_request()
Date: Fri, 18 Oct 2024 10:12:05 +0800
Message-ID: <20241018021205.46460-1-yuancan@huawei.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500024.china.huawei.com (7.185.36.10)

The caller of the function dev_pm_qos_add_request() checks again a non
zero value but dev_pm_qos_add_request() can return '1' if the request
already exists. Therefore, the setup function fails while the QoS
request actually did not failed.

Fix that by changing the check against a negative value like all the
other callers of the function.

Fixes: e44655617317 ("powercap/drivers/dtpm: Add dtpm devfreq with energy model support")
Signed-off-by: Yuan Can <yuancan@huawei.com>
---
 drivers/powercap/dtpm_devfreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/powercap/dtpm_devfreq.c b/drivers/powercap/dtpm_devfreq.c
index f40bce8176df..d1dff6ccab12 100644
--- a/drivers/powercap/dtpm_devfreq.c
+++ b/drivers/powercap/dtpm_devfreq.c
@@ -178,7 +178,7 @@ static int __dtpm_devfreq_setup(struct devfreq *devfreq, struct dtpm *parent)
 	ret = dev_pm_qos_add_request(dev, &dtpm_devfreq->qos_req,
 				     DEV_PM_QOS_MAX_FREQUENCY,
 				     PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE);
-	if (ret) {
+	if (ret < 0) {
 		pr_err("Failed to add QoS request: %d\n", ret);
 		goto out_dtpm_unregister;
 	}
-- 
2.17.1


