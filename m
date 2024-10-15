Return-Path: <linux-pm+bounces-15655-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 288AD99ECC6
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 15:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AA971C22459
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 13:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22B61C4A03;
	Tue, 15 Oct 2024 13:18:12 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D473B1B2185;
	Tue, 15 Oct 2024 13:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728998292; cv=none; b=WBJSMFTR/memvYiY1F1pfaC+Al45x7qpLmogOLSG4iZFHIPBeIjestQ2sb6Q4o4JFafFzDHFkSJpaGEsYwE8sqfncHXpHBB0QtTn2UlJOA27ar1tcUj7Tf+F4tahoqnwYK3AJaDOhMrZYNSoGDYooo1aLqUfEiTQE23yBle36vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728998292; c=relaxed/simple;
	bh=VNySIiZ7c3IG0aHf8oREvKMaNBVY+7BMcz1RyC5A3Ak=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sEmFsz+hUqOWOfzh3qC3LBn92/fXPiWYGXajp3Nkl164T/meFdhTgfinHobTPpvCz3KaiZyvm/XD4pPTkW7NyLcuU62egA7+vjNKkSppzSXwKjEJfBCIiR1YmY9pmVtApmxi3ww4NqDNaIoalsL+UwjIpFXrGvhon2ibnrpZXRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4XSZPd4bPMz1gx2L;
	Tue, 15 Oct 2024 21:16:53 +0800 (CST)
Received: from dggpeml500024.china.huawei.com (unknown [7.185.36.10])
	by mail.maildlp.com (Postfix) with ESMTPS id 4E6801400D4;
	Tue, 15 Oct 2024 21:18:07 +0800 (CST)
Received: from huawei.com (10.175.112.208) by dggpeml500024.china.huawei.com
 (7.185.36.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 15 Oct
 2024 21:18:06 +0800
From: Yuan Can <yuancan@huawei.com>
To: <jiaxun.yang@flygoat.com>, <rafael@kernel.org>, <viresh.kumar@linaro.org>,
	<ralf@linux-mips.org>, <wuzhangjin@gmail.com>, <linux-mips@vger.kernel.org>,
	<linux-pm@vger.kernel.org>
CC: <yuancan@huawei.com>
Subject: [PATCH] cpufreq: loongson2: Unregister platform_driver on failure
Date: Tue, 15 Oct 2024 21:13:37 +0800
Message-ID: <20241015131337.20159-1-yuancan@huawei.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500024.china.huawei.com (7.185.36.10)

When cpufreq_register_driver() returns error, the cpufreq_init() returns
without unregister platform_driver, fix by add missing
platform_driver_unregister() when cpufreq_register_driver() failed.

Fixes: f8ede0f700f5 ("MIPS: Loongson 2F: Add CPU frequency scaling support")
Signed-off-by: Yuan Can <yuancan@huawei.com>
---
 drivers/cpufreq/loongson2_cpufreq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cpufreq/loongson2_cpufreq.c b/drivers/cpufreq/loongson2_cpufreq.c
index 6a8e97896d38..1291db067559 100644
--- a/drivers/cpufreq/loongson2_cpufreq.c
+++ b/drivers/cpufreq/loongson2_cpufreq.c
@@ -153,6 +153,9 @@ static int __init cpufreq_init(void)
 		cpu_wait = loongson2_cpu_wait;
 	}
 
+	if (ret)
+		platform_driver_unregister(&platform_driver);
+
 	return ret;
 }
 
-- 
2.17.1


