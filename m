Return-Path: <linux-pm+bounces-29331-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B1DAE440B
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 15:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE90A7ABBF5
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 13:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1188E254874;
	Mon, 23 Jun 2025 13:34:14 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7F12472AF;
	Mon, 23 Jun 2025 13:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750685653; cv=none; b=r7ZL1cvQ2qr9wVBnc4xGNZeFP+v1xiX7M9Zj4MWmInMeSElg+RdOW3pp3kvjI0wfcInyqPg8EffVPgIc75OLcUAMWbiyJRQnihjwZu0VpG3YkuAbtIJQ9xCvqtQvUzuSDvfTcVPXZQ/tKxbUdR1XdCdi/kFmK/3pKIsh/TyWmtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750685653; c=relaxed/simple;
	bh=9AIFoa5M6hngoUo+a4+718LmWvntA7lviAeBcZrm/qg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XtUaD86ZE4R84QriMnAdP4H2jvxSNUwEeexXyfE82dtYyakaG3CeUwhPfHmUgOEeJgxUrJoskAubUNaPVlue1X3rO3JPdX5YFuShdawmmCLUufUrWhNHr7IhmbfAh24TVsSYI+y5kPtcwXp3wID4GiYyIQmyeHKGwusdT8oY5ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bQptN2WBbztSdC;
	Mon, 23 Jun 2025 21:33:00 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id BE92A1402CD;
	Mon, 23 Jun 2025 21:34:09 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemh100008.china.huawei.com (7.202.181.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 23 Jun 2025 21:34:09 +0800
From: Lifeng Zheng <zhenglifeng1@huawei.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <ionela.voinescu@arm.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>, <yubowen8@huawei.com>,
	<zhenglifeng1@huawei.com>
Subject: [PATCH 4/7] cpufreq: Remove duplicate check in __cpufreq_offline()
Date: Mon, 23 Jun 2025 21:33:59 +0800
Message-ID: <20250623133402.3120230-5-zhenglifeng1@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250623133402.3120230-1-zhenglifeng1@huawei.com>
References: <20250623133402.3120230-1-zhenglifeng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemh100008.china.huawei.com (7.202.181.93)

The has_target() checks in __cpufreq_offline() are duplicate. Remove one of
them and put the operations of exiting governor together with storing last
governor's name.

Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
---
 drivers/cpufreq/cpufreq.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 2303890de0ba..c4891bf5dc84 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1692,14 +1692,13 @@ static void __cpufreq_offline(unsigned int cpu, struct cpufreq_policy *policy)
 		return;
 	}
 
-	if (has_target())
+	if (has_target()) {
 		strscpy(policy->last_governor, policy->governor->name,
 			CPUFREQ_NAME_LEN);
-	else
-		policy->last_policy = policy->policy;
-
-	if (has_target())
 		cpufreq_exit_governor(policy);
+	} else {
+		policy->last_policy = policy->policy;
+	}
 
 	/*
 	 * Perform the ->offline() during light-weight tear-down, as
-- 
2.33.0


