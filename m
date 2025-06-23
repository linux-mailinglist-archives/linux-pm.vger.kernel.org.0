Return-Path: <linux-pm+bounces-29332-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C41AE44A9
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 15:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8B8C3B9122
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 13:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133DA254AE4;
	Mon, 23 Jun 2025 13:34:14 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E56253F20;
	Mon, 23 Jun 2025 13:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750685653; cv=none; b=CZ1gNbI0vczJ7VgQ0YH4sKmG+V1RtXmzvyYRi/z9EV1KH1qLNj6uKmdUzS5iNNRbI3WmlsjfGYZomob//knJcKHD/Xl4VmVk4fmaYH6v42VHoMvcXM6h4DfB5BslCgkO8PI9/jRr+V3c9vGBFuB8I66O6M1o8ashThHfDXSh/O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750685653; c=relaxed/simple;
	bh=beerym7k8zgy8EcfEIxlVoGUrkuzmwMRI1FujU6b5rw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZnXYmQQX9o4JlWujsrH2NkiWJRq0CkVThtGyu2A54frgAG6eZgvL6VPGs71/GNy4mT6zYfnfBCRVXqdnsdra6A6sYzoFk8QUxcYf+jN2VcbGMrrBoB/+1b3P5bk3iIgXJB/bYj9XTymC2/QoktNobIUwJNH+hVECmxwywj0o3gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bQppN68Fjz10XJM;
	Mon, 23 Jun 2025 21:29:32 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 5B4DE18006C;
	Mon, 23 Jun 2025 21:34:09 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemh100008.china.huawei.com (7.202.181.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 23 Jun 2025 21:34:08 +0800
From: Lifeng Zheng <zhenglifeng1@huawei.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <ionela.voinescu@arm.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>, <yubowen8@huawei.com>,
	<zhenglifeng1@huawei.com>
Subject: [PATCH 3/7] cpufreq: Contain scaling_cur_freq.attr in cpufreq_attrs
Date: Mon, 23 Jun 2025 21:33:58 +0800
Message-ID: <20250623133402.3120230-4-zhenglifeng1@huawei.com>
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

After commit c034b02e213d ("cpufreq: expose scaling_cur_freq sysfs file for
set_policy() drivers"), the file scaling_cur_freq is exposed to all
drivers. No need to create this file separately. It's better to be
contained in cpufreq_attrs.

Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
---
 drivers/cpufreq/cpufreq.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index efc1f4ac85cb..2303890de0ba 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -967,6 +967,7 @@ static struct attribute *cpufreq_attrs[] = {
 	&cpuinfo_min_freq.attr,
 	&cpuinfo_max_freq.attr,
 	&cpuinfo_transition_latency.attr,
+	&scaling_cur_freq.attr,
 	&scaling_min_freq.attr,
 	&scaling_max_freq.attr,
 	&affected_cpus.attr,
@@ -1095,10 +1096,6 @@ static int cpufreq_add_dev_interface(struct cpufreq_policy *policy)
 			return ret;
 	}
 
-	ret = sysfs_create_file(&policy->kobj, &scaling_cur_freq.attr);
-	if (ret)
-		return ret;
-
 	if (cpufreq_driver->bios_limit) {
 		ret = sysfs_create_file(&policy->kobj, &bios_limit.attr);
 		if (ret)
-- 
2.33.0


