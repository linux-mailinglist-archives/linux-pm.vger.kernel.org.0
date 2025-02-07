Return-Path: <linux-pm+bounces-21521-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6CFA2B9F9
	for <lists+linux-pm@lfdr.de>; Fri,  7 Feb 2025 05:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3340162D3E
	for <lists+linux-pm@lfdr.de>; Fri,  7 Feb 2025 04:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377051DE2CC;
	Fri,  7 Feb 2025 04:00:00 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59EC15445D;
	Fri,  7 Feb 2025 03:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738900800; cv=none; b=oltgsjl/1mSQ7d4qH3afXM232ZNMyXO34DJ3KiiLE4Hv42tDuDZOQQcoMHxwYi+VgGu/1qHIqyAziJZsAAW2GZyDRtJrvdnk7H7whC90JSL5yKnLJzAyboGMiCpI11V/sh8qsRriNc+XvaU6L87Qjrv3GzadIFpz0xbNaoj2c4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738900800; c=relaxed/simple;
	bh=xfEJh4u+WX9uN/15nbOGQboQ20mTsV2Z+FQUCm7exow=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JkMusSj2qOJdvaAeChvyu3oid/qunZkMbEhflZ6TJ82S7fxC6CPHJHY8UqhwhP6+0iAXDjX/beW6buU+g3X2VAvHOofNowzz+Y+7sgufraBM6mkCgJWDeIkbQaW8kLjdrgRS37xUo/3twlRsvon7Yp/CQcOKOszdLTi4qow05r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Yq0Vt3GcLz1W5D7;
	Fri,  7 Feb 2025 11:55:34 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 9C7A21800DB;
	Fri,  7 Feb 2025 11:59:54 +0800 (CST)
Received: from localhost.huawei.com (10.50.165.33) by
 kwepemh100008.china.huawei.com (7.202.181.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 7 Feb 2025 11:59:53 +0800
From: Lifeng Zheng <zhenglifeng1@huawei.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>, <zhenglifeng1@huawei.com>,
	<fanghao11@huawei.com>
Subject: [PATCH] cpufreq: Use str_enable_disable() helper
Date: Fri, 7 Feb 2025 11:59:53 +0800
Message-ID: <20250207035953.2420053-1-zhenglifeng1@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemh100008.china.huawei.com (7.202.181.93)

Commit f994c1cb6c43 ("cpufreq: Use str_enable_disable()-like helpers") has
already introduced helpers from string_choices.h and replaced ternary
syntax with it. Use str_enable_disable() helper in this line to stay
consistent.

Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
---
 drivers/cpufreq/cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 30ffbddc7ece..a12e1da89163 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1578,7 +1578,7 @@ static int cpufreq_online(unsigned int cpu)
 		if (ret) {
 			/* If the set_boost fails, the online operation is not affected */
 			pr_info("%s: CPU%d: Cannot %s BOOST\n", __func__, policy->cpu,
-				policy->boost_enabled ? "enable" : "disable");
+				str_enable_disable(policy->boost_enabled));
 			policy->boost_enabled = !policy->boost_enabled;
 		}
 	}
-- 
2.33.0


