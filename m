Return-Path: <linux-pm+bounces-15747-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B309A051A
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 11:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23F09B2605E
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 09:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901DD1D172E;
	Wed, 16 Oct 2024 09:10:51 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E29517D378;
	Wed, 16 Oct 2024 09:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729069851; cv=none; b=C2Pk5W1XhrTu+bEsFmlXKVTDlvrQuRS6qkLzZCL7HBrXFJdzzf48rSAUaZlV7KZoyD0ixa3l3Fiw4NSmPPyyn3kD/jnjfF85faohoCS8cjw3DLJBMILweA2p9s7ckKyCJZblvVineoVM8EBWm4RVssRuL5hDSNc/RJSxiGkaYQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729069851; c=relaxed/simple;
	bh=ni1/h5ZUuU9JvygnJZuD78bSfAoXblxXrT5jzOTJs/0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A38LrOeCSQ8J+ThSwIH7sz06uSOrQ6doOz69WxqdFOrJYA/dyvQ90E/IPEfMutwCTnMwjSVU8KrJJ6wiX4+WP6FcjnDe1Op/8CevtWbcntr2cZwNX7pqQXTZQwpGDvHYrEieAvAF6+koYg38wDAo5zE0WQ6Zz3bvV0/T7tlKUmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XT4sn04Qpz1j9ks;
	Wed, 16 Oct 2024 17:09:33 +0800 (CST)
Received: from dggpeml500024.china.huawei.com (unknown [7.185.36.10])
	by mail.maildlp.com (Postfix) with ESMTPS id EE18E140361;
	Wed, 16 Oct 2024 17:10:46 +0800 (CST)
Received: from huawei.com (10.175.112.208) by dggpeml500024.china.huawei.com
 (7.185.36.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 16 Oct
 2024 17:10:46 +0800
From: Yuan Can <yuancan@huawei.com>
To: <jiaxun.yang@flygoat.com>, <rafael@kernel.org>, <viresh.kumar@linaro.org>,
	<ralf@linux-mips.org>, <wuzhangjin@gmail.com>, <linux-mips@vger.kernel.org>,
	<linux-pm@vger.kernel.org>
CC: <yuancan@huawei.com>
Subject: [PATCH v2] cpufreq: loongson2: Unregister platform_driver on failure
Date: Wed, 16 Oct 2024 17:06:15 +0800
Message-ID: <20241016090615.128678-1-yuancan@huawei.com>
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

When cpufreq_register_driver() returns error, the cpufreq_init() returns
without unregister platform_driver, fix by add missing
platform_driver_unregister() when cpufreq_register_driver() failed.

Fixes: f8ede0f700f5 ("MIPS: Loongson 2F: Add CPU frequency scaling support")
Signed-off-by: Yuan Can <yuancan@huawei.com>
---
Changes since v1:
- Change to style suggested by Viresh Kumar.
---
 drivers/cpufreq/loongson2_cpufreq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/loongson2_cpufreq.c b/drivers/cpufreq/loongson2_cpufreq.c
index 6a8e97896d38..ed1a6dbad638 100644
--- a/drivers/cpufreq/loongson2_cpufreq.c
+++ b/drivers/cpufreq/loongson2_cpufreq.c
@@ -148,7 +148,9 @@ static int __init cpufreq_init(void)
 
 	ret = cpufreq_register_driver(&loongson2_cpufreq_driver);
 
-	if (!ret && !nowait) {
+	if (ret) {
+		platform_driver_unregister(&platform_driver);
+	} else if (!nowait) {
 		saved_cpu_wait = cpu_wait;
 		cpu_wait = loongson2_cpu_wait;
 	}
-- 
2.17.1


