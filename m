Return-Path: <linux-pm+bounces-16939-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1DF9BB393
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 12:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ECD91C21C6E
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 11:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7781AF0B3;
	Mon,  4 Nov 2024 11:36:58 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E586418B473;
	Mon,  4 Nov 2024 11:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730720218; cv=none; b=hxiJSjSr5Nr+Cgi2kP0bCpOlQpdhTSbioo/0s1JsxBauHoLbtLkDZJFVoz57iK47hG7USu6xaSBazXO2diU3rpiSy2ekPFZC5oyCNld3rTv1oMVJWfXGkY/8l9mIZjIpSoHCdA4TexWe1X0MqG+OPK8WbYV3wIvxhebZNpmiQQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730720218; c=relaxed/simple;
	bh=rWT/UhQK41/pl7QfPB/0KppNr9Y+HnzSSkK/w4+Rsxc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VXaxKdvGELQtqieWVz6IcYuj8OIQmHfxnVXy8hVAYzkhdQc+t4Gj7i6XEW/On205lCeA1FLKWAS1LS0QDp3fH5tfgQ6P26SfYKS+g+DVf4UhmXHiU3+pWIS8Wfcida6zg3zFOccHaCO+vLeVnyPGU2Bo6Q8Bw2QYmwVqVGQXC60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XhqC51bcnz2Fb27;
	Mon,  4 Nov 2024 19:35:13 +0800 (CST)
Received: from kwepemg200008.china.huawei.com (unknown [7.202.181.35])
	by mail.maildlp.com (Postfix) with ESMTPS id BEE361A0188;
	Mon,  4 Nov 2024 19:36:51 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemg200008.china.huawei.com
 (7.202.181.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 4 Nov
 2024 19:36:51 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <matthias.bgg@gmail.com>,
	<angelogioacchino.delregno@collabora.com>, <hector.yuan@mediatek.com>,
	<lukasz.luba@arm.com>, <qperret@google.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v2] PM: EM: Fix wrong return value in mtk_cpufreq_get_cpu_power()
Date: Mon, 4 Nov 2024 19:36:15 +0800
Message-ID: <20241104113615.1397410-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemg200008.china.huawei.com (7.202.181.35)

mtk_cpufreq_get_cpu_power() return 0 if the policy is NULL. Then in
em_create_perf_table(), the later zero check for power is not invalid
as power is uninitialized. As Lukasz suggested, it must return -EINVAL when
the 'policy' is not found. So return -EINVAL to fix it.

Cc: stable@vger.kernel.org
Fixes: 4855e26bcf4d ("cpufreq: mediatek-hw: Add support for CPUFREQ HW")
Suggested-by: Lukasz Luba <lukasz.luba@arm.com>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
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


