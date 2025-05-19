Return-Path: <linux-pm+bounces-27316-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7393CABB5C8
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 09:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BAFF17789E
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 07:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037EC267F48;
	Mon, 19 May 2025 07:09:20 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B6E2586E0;
	Mon, 19 May 2025 07:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747638559; cv=none; b=gx6p/9zL6qiDxy4W/LUvQzhUQJkB0tJdJ1HN9neGucPAbj/GbzYxnr4MOyrIbj8LZQnL6CTAf7251B7H3XrbZICiYQy2pij/EFTnObE2KvsOtBYOAy8DDWW1nfJNULW9FHMgoaCoSBiWhK1nzBdMfi2mwQPn9fP884bVMoAQEYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747638559; c=relaxed/simple;
	bh=WSpJYlRdTTN+OUW6AXaLqzDV6FzuUBYEVN+BQ6jqN9M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KItlqSx264/406CH3qVc26Mk7cuyrcKs8F4udfVzjociqaZQKRicc2CiOlcgorb+y9QsGbscPQa17GgSfQSOmc/Mr7EmKAonMLCmd5hhHCURxs+BJFvd/2RimwojolTBgoWt92m6CikZRbLTpUlWPwfPPV9l/k8TfS5paLzVKbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4b17xN1msmz2CdVR;
	Mon, 19 May 2025 15:05:28 +0800 (CST)
Received: from kwepemk500012.china.huawei.com (unknown [7.202.194.97])
	by mail.maildlp.com (Postfix) with ESMTPS id 2BAC21A016C;
	Mon, 19 May 2025 15:09:09 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemk500012.china.huawei.com (7.202.194.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 19 May 2025 15:09:08 +0800
From: Bowen Yu <yubowen8@huawei.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <zhanjie9@hisilicon.com>,
	<jonathan.cameron@huawei.com>, <lihuisong@huawei.com>,
	<zhenglifeng1@huawei.com>, <yubowen8@huawei.com>, <cenxinghai@h-partners.com>
Subject: [PATCH] cpufreq: Replace magic number
Date: Mon, 19 May 2025 15:09:08 +0800
Message-ID: <20250519070908.930879-1-yubowen8@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemk500012.china.huawei.com (7.202.194.97)

Setting the length of str_governor with a magic number could cause
overflow when max length increases, it is better to use the defined
macro in this case.

Signed-off-by: Bowen Yu <yubowen8@huawei.com>
---
 drivers/cpufreq/cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 0c842edd1a76..a3a376f030f0 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -809,7 +809,7 @@ static ssize_t show_scaling_governor(struct cpufreq_policy *policy, char *buf)
 static ssize_t store_scaling_governor(struct cpufreq_policy *policy,
 					const char *buf, size_t count)
 {
-	char str_governor[16];
+	char str_governor[CPUFREQ_NAME_LEN];
 	int ret;
 
 	ret = sscanf(buf, "%15s", str_governor);
-- 
2.33.0


