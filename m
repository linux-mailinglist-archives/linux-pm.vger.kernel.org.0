Return-Path: <linux-pm+bounces-16926-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A669BAEF5
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 10:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00F9D1C219F8
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 09:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78EB1189F47;
	Mon,  4 Nov 2024 09:04:23 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C64123AB;
	Mon,  4 Nov 2024 09:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730711063; cv=none; b=F8g8eR60K401iuvFDS3RYSp4AIWodQfJyfbjarX19zUc7ZBR7y35KsyOoyGRu+XzGl2Y4SBmt2907w08D3SGW2RvqxVpMozVPyrEyil1lQiuN6jVQbv9kxVlMyos2uI/pL2WJTrrI/tWS1Wj+WzsITK8PiFhn98VyJnRmlJabg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730711063; c=relaxed/simple;
	bh=4uDxmULew50QrCLK89YOYVuo5mwOSNHUfkVwMVVIdfI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KCfrp1trF/4AMzMyUGvXl98osyMzjN5lShp6x6Pn2L6IY3CUp9VHw4BJiFzD9pRpIoQn+Bd61fadecP55ZlKGTtgnremnz3GtfPCqq+XHg+eClXIQJleEPrVMWeTuhyPexOSZWXuruoUNgXS2GUu6szARNbauUKvIKbNcZ5lTUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4XhlpG2TJDz1T7vs;
	Mon,  4 Nov 2024 17:01:58 +0800 (CST)
Received: from kwepemg200008.china.huawei.com (unknown [7.202.181.35])
	by mail.maildlp.com (Postfix) with ESMTPS id 97BF61800A7;
	Mon,  4 Nov 2024 17:04:15 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemg200008.china.huawei.com
 (7.202.181.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 4 Nov
 2024 17:04:15 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <rafael@kernel.org>, <pavel@ucw.cz>, <len.brown@intel.com>,
	<daniel.lezcano@linaro.org>, <qperret@google.com>, <lukasz.luba@arm.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH] PM: EM: Fix uninitialized power in em_create_perf_table
Date: Mon, 4 Nov 2024 17:03:51 +0800
Message-ID: <20241104090351.1352997-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemg200008.china.huawei.com (7.202.181.35)

In em_create_perf_table(), power is uninitialized and passed the pointer
to active_power() hook, but the hook function may not assign it and
return 0, such as mtk_cpufreq_get_cpu_power(), so the later zero check for
power is not invalid, initialize power to zero to fix it.

Cc: stable@vger.kernel.org
Fixes: 7d9895c7fbfc ("PM / EM: introduce em_dev_register_perf_domain function")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 kernel/power/energy_model.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index 927cc55ba0b3..866a3e9c05b2 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -344,7 +344,7 @@ static int em_create_perf_table(struct device *dev, struct em_perf_domain *pd,
 				struct em_data_callback *cb,
 				unsigned long flags)
 {
-	unsigned long power, freq, prev_freq = 0;
+	unsigned long power = 0, freq, prev_freq = 0;
 	int nr_states = pd->nr_perf_states;
 	int i, ret;
 
-- 
2.34.1


