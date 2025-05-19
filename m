Return-Path: <linux-pm+bounces-27317-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9298ABB5EF
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 09:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72C7F3BBA40
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 07:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9616D2676D3;
	Mon, 19 May 2025 07:09:49 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E7B26658F;
	Mon, 19 May 2025 07:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747638589; cv=none; b=t3TZg5P8mif94dXvi7IiZrirdFWZMW0TjxbZoco5MB+uXoYHjYzH8p2duWMSXXOxDQ6WOMtCwr+lM8lIt/pyK96o4o0LnbqGKnWuRFWknlYA5FTbYaOwr1bO90UjjVq3bPeCwCjgTSq8u1cpiJd8KgEReUegFrN6NENiaj7UyNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747638589; c=relaxed/simple;
	bh=BqaEOXA8aeltNjMxATYKo6Qrwtnb7mFiJst0GZK6Nic=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AqAFZB4M+tHGJ9JLO2V2cUEpM2wNP5yZXX8DoJQR5tFPtayuPgoe8dLWcB+i6TDeia8AUu79aAulcoyUIvFPkBOmfKVgQqKDr8SxXVEr+M2fZnztv0ClN1ONakAt4m1+X0dzVFxCuVJ944Pi5K6/5EFp/9rLZuRArc3r0IvyI84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4b18372qTWz27hm0;
	Mon, 19 May 2025 15:10:27 +0800 (CST)
Received: from kwepemk500012.china.huawei.com (unknown [7.202.194.97])
	by mail.maildlp.com (Postfix) with ESMTPS id 27C69140258;
	Mon, 19 May 2025 15:09:39 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemk500012.china.huawei.com (7.202.194.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 19 May 2025 15:09:38 +0800
From: Bowen Yu <yubowen8@huawei.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <zhanjie9@hisilicon.com>,
	<jonathan.cameron@huawei.com>, <lihuisong@huawei.com>,
	<zhenglifeng1@huawei.com>, <yubowen8@huawei.com>, <cenxinghai@h-partners.com>
Subject: [PATCH] cpufreq: Update sscanf() to kstrtouint()
Date: Mon, 19 May 2025 15:09:38 +0800
Message-ID: <20250519070938.931396-1-yubowen8@huawei.com>
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

In store_scaling_setspeed(), sscanf is still used to read to sysfs.
Newer kstrtox provide more features including overflow protection,
better errorhandling and allows for other systems of numeration. It
is therefore better to update sscanf() to kstrtouint().

Signed-off-by: Bowen Yu <yubowen8@huawei.com>
---
 drivers/cpufreq/cpufreq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index be727da0be4d..0c842edd1a76 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -920,9 +920,9 @@ static ssize_t store_scaling_setspeed(struct cpufreq_policy *policy,
 	if (!policy->governor || !policy->governor->store_setspeed)
 		return -EINVAL;
 
-	ret = sscanf(buf, "%u", &freq);
-	if (ret != 1)
-		return -EINVAL;
+	ret = kstrtouint(buf, 0, &freq);
+	if (ret)
+		return ret;
 
 	policy->governor->store_setspeed(policy, freq);
 
-- 
2.33.0


