Return-Path: <linux-pm+bounces-17103-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 547329C044B
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2024 12:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 142E01F23778
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2024 11:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83BD20ADCE;
	Thu,  7 Nov 2024 11:39:51 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A178201010;
	Thu,  7 Nov 2024 11:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730979591; cv=none; b=uiXen/FQO7vz+uJBBDT+WqkFeC98tFuCESFJAVFdQxiGLXx4kZBfVlQDuUiE6YKoMSk0ZUXTwMdmh+r7jEs0So92wHKfbBllY+AHYg10At5p94iyxWY+UIz6Nh8auSHoXo9AOTIVrUgc3ZtWOl/qNJxiJ9J4zvu+Ivzhg9LE6Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730979591; c=relaxed/simple;
	bh=YWySLyjr99AwQD0xhEVR71eBJCSTV8U5fJgvvmwWMes=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hZ2/s/mduIO03oWhxz/1WVQgru9EZ6hhUCvlKO7g+YiyzlIRfKsYjAfYTf+miVeHNvBGGyoT1FiGNjOQxw2ObcTK5lBBkP8dJPG3Ek6DZtBY+3qBpQ2l4/xxuEyBi7fPeVvKopLwC+TRFan9q9U8umTPdEA75X21DDogb7WsQv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Xkg6D11v4z10N3T;
	Thu,  7 Nov 2024 19:37:24 +0800 (CST)
Received: from kwepemg200008.china.huawei.com (unknown [7.202.181.35])
	by mail.maildlp.com (Postfix) with ESMTPS id B867D1401F3;
	Thu,  7 Nov 2024 19:39:45 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemg200008.china.huawei.com
 (7.202.181.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 7 Nov
 2024 19:39:45 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <matthias.bgg@gmail.com>,
	<angelogioacchino.delregno@collabora.com>, <hector.yuan@mediatek.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v2 RESEND] cpufreq: mediatek-hw: Fix wrong return value in mtk_cpufreq_get_cpu_power()
Date: Thu, 7 Nov 2024 19:38:41 +0800
Message-ID: <20241107113841.989475-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemg200008.china.huawei.com (7.202.181.35)

mtk_cpufreq_get_cpu_power() return 0 if the policy is NULL. Then in
em_create_perf_table(), the later zero check for power is not invalid
as power is uninitialized. As Lukasz suggested, it must return -EINVAL when
the 'policy' is not found. So return -EINVAL to fix it.

Cc: stable@vger.kernel.org
Fixes: 4855e26bcf4d ("cpufreq: mediatek-hw: Add support for CPUFREQ HW")
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Suggested-by: Lukasz Luba <lukasz.luba@arm.com>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
v2 -> v2 RESEND:
- Update the commit subject and Cc Viresh.
- Add Reviewed-by.
v2:
- Fix the driver instead of em_create_perf_table() as suggested.
- Update the commit message.
- Add Suggested-by.
---
 drivers/cpufreq/mediatek-cpufreq-hw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/mediatek-cpufreq-hw.c b/drivers/cpufreq/mediatek-cpufreq-hw.c
index 8925e096d5b9..aeb5e6304542 100644
--- a/drivers/cpufreq/mediatek-cpufreq-hw.c
+++ b/drivers/cpufreq/mediatek-cpufreq-hw.c
@@ -62,7 +62,7 @@ mtk_cpufreq_get_cpu_power(struct device *cpu_dev, unsigned long *uW,
 
 	policy = cpufreq_cpu_get_raw(cpu_dev->id);
 	if (!policy)
-		return 0;
+		return -EINVAL;
 
 	data = policy->driver_data;
 
-- 
2.34.1


