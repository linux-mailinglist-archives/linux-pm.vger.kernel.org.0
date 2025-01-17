Return-Path: <linux-pm+bounces-20611-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27233A14D58
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 11:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B0863A2A75
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 10:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36211FCFE9;
	Fri, 17 Jan 2025 10:15:09 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B541FCD1B;
	Fri, 17 Jan 2025 10:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737108909; cv=none; b=BsnQ64qgO0Y5rMEKCwYtqZT1CJVH3NTwr8zIkK9FgEClJfvoXAyB1alUD0r0YflYd2v4PGH+9BZ68dCaSEZuKTHCJiPDMsHJ8X6E6EA8Hefk4fmNnhDhr5d5HYSvy4rIpbTGkxVxMfojC7OHNaPbfy4u7Ez0JRDUTEKzsDgRs84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737108909; c=relaxed/simple;
	bh=cBALt8JHgJ3WAS/hFV28rhLE2UQ5Yup636KAW6SWzGA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jhov8S5WpCKfJQZzkVLvYKPJV8MVitQ3QpPaVhSSmbbkkWHvAgkfVITYJiHfft7SZM18zRaryRpO5mevnuEiuBGvz7Oh1rG57fUkiMlLdt09ljTSIreCQAEKwZd6DpdE8b2HvgG+lyzJtczyPmo/0uyWSrWrjm07i2zL4kJ73ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4YZFrg3wKDz2DkXS;
	Fri, 17 Jan 2025 18:11:47 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 5FE2F180214;
	Fri, 17 Jan 2025 18:15:00 +0800 (CST)
Received: from localhost.huawei.com (10.50.165.33) by
 kwepemh100008.china.huawei.com (7.202.181.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 17 Jan 2025 18:14:59 +0800
From: Lifeng Zheng <zhenglifeng1@huawei.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>, <zhenglifeng1@huawei.com>,
	<fanghao11@huawei.com>
Subject: [PATCH v2 4/4] cpufreq: ACPI: Remove set_boost in acpi_cpufreq_cpu_init()
Date: Fri, 17 Jan 2025 18:14:57 +0800
Message-ID: <20250117101457.1530653-5-zhenglifeng1@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250117101457.1530653-1-zhenglifeng1@huawei.com>
References: <20250117101457.1530653-1-zhenglifeng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemh100008.china.huawei.com (7.202.181.93)

At the end of cpufreq_online() in cpufreq.c, set_boost is executed and the
per-policy boost flag is set to mirror the cpufreq_driver boost. So it is
not necessary to run set_boost in acpi_cpufreq_cpu_init().

Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
---
 drivers/cpufreq/acpi-cpufreq.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index c9ebacf5c88e..f4b5e455f173 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -891,11 +891,6 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	if (perf->states[0].core_frequency * 1000 != freq_table[0].frequency)
 		pr_warn(FW_WARN "P-state 0 is not max freq\n");
 
-	if (acpi_cpufreq_driver.set_boost) {
-		set_boost(policy, acpi_cpufreq_driver.boost_enabled);
-		policy->boost_enabled = acpi_cpufreq_driver.boost_enabled;
-	}
-
 	return result;
 
 err_unreg:
-- 
2.33.0


