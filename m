Return-Path: <linux-pm+bounces-31570-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB553B157CC
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 05:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC5FF18A683A
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 03:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458E71DF754;
	Wed, 30 Jul 2025 03:23:22 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D058613B797;
	Wed, 30 Jul 2025 03:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753845802; cv=none; b=sFxq0grOBPdmNrSBFZQuAC0Zo+GaQb7XKOd9VuSMX+jA8Db//1ue9/NyFfVecpdgeku6nnYJxJMt6ghhWQP8+auTelZKufmmaQKwVKYmhnEaEnuB9lJ2Fi2CZOks5mXmz2BTn3xnfrIm/kp5KH5bdG+e4FwxO0k3dvwxJITtJpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753845802; c=relaxed/simple;
	bh=mEeeApHgOAP/P2OpIQHR7pNXuGBj5SUI7JRX/dnOVtc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TasqGbY/edDGRq0T4SMBXN4Sqdy87mrrzG720cjh2N/CkWy1ONlKWY4ERUnExFPsJbtrnKUqcuD/wTP2JV5b51F/B8W07dsBb0zmhoaJ5MS5JsMMpGHg0LFSYW6AZtSaTB56dvziSMTQDOT/6GK19qS4FAdF4p/bOKh/5odsfFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bsHX83HFZz13Mq9;
	Wed, 30 Jul 2025 11:20:08 +0800 (CST)
Received: from kwepemk500012.china.huawei.com (unknown [7.202.194.97])
	by mail.maildlp.com (Postfix) with ESMTPS id 2FA101401F3;
	Wed, 30 Jul 2025 11:23:14 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemk500012.china.huawei.com (7.202.194.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 30 Jul 2025 11:23:13 +0800
From: Bowen Yu <yubowen8@huawei.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>, <zhenglifeng1@huawei.com>,
	<yubowen8@huawei.com>
Subject: [PATCH 1/2] cpufreq: CPPC: Don't warn on failing to read perf counters on offline cpus
Date: Wed, 30 Jul 2025 11:23:11 +0800
Message-ID: <20250730032312.167062-2-yubowen8@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250730032312.167062-1-yubowen8@huawei.com>
References: <20250730032312.167062-1-yubowen8@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemk500012.china.huawei.com (7.202.194.97)

From: Jie Zhan <zhanjie9@hisilicon.com>

Reading perf counters on offline cpus should be expected to fail, e.g. it
returns -EFAULT as counters are shown to be 0. Remove the unnecessary
warning print on this failure path.

Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
Signed-off-by: Bowen Yu <yubowen8@huawei.com> # Changing loglevel to debug
---
 drivers/cpufreq/cppc_cpufreq.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index a1fd0ff22bc5..904006027df2 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -144,16 +144,14 @@ static void cppc_cpufreq_cpu_fie_init(struct cpufreq_policy *policy)
 		init_irq_work(&cppc_fi->irq_work, cppc_irq_work);
 
 		ret = cppc_get_perf_ctrs(cpu, &cppc_fi->prev_perf_fb_ctrs);
-		if (ret) {
-			pr_warn("%s: failed to read perf counters for cpu:%d: %d\n",
-				__func__, cpu, ret);
-
+		if (ret && cpu_online(cpu)) {
 			/*
 			 * Don't abort if the CPU was offline while the driver
 			 * was getting registered.
 			 */
-			if (cpu_online(cpu))
-				return;
+			pr_debug("%s: failed to read perf counters for cpu:%d: %d\n",
+				__func__, cpu, ret);
+			return;
 		}
 	}
 
-- 
2.33.0


