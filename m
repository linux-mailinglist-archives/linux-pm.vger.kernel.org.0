Return-Path: <linux-pm+bounces-14762-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6E0986AA9
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2024 03:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAAD41C21817
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2024 01:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C84178387;
	Thu, 26 Sep 2024 01:40:16 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33C31714BE
	for <linux-pm@vger.kernel.org>; Thu, 26 Sep 2024 01:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727314816; cv=none; b=WzJXh7vXPtp1SwdK6vkAxxykvqT1UvDCY06WbNdvcn15liV115DtWuFZrfwEEr6wuOX2qNhyxLqhrgY9uKx8GatRppzD5utqsrJDJsoJAdTiKU3P4T/cqEmrChJ6NrC56RR+97H9k4ce+bWiVs7pXbZRFh0Syzdtk7vvHR6jx+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727314816; c=relaxed/simple;
	bh=1ds0uurUuie1pb7zbm7wCos3oPI7VOS5dr/ScjH7/4U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lfzzz44bhrSI13jo23EOilVHNTNd9esNqjJjS4wtV8Le4K2gwr7g8IkO2WhkYZqOUw4j8S5dNxzaZiaKt1SzXIoMwxlO6wHvlnCS/O8qFjs/8w8dipO5X/3+1iDAi8uSgucqwwXIK57nNQz+RWLFD0a3RTD3rwd53q5fTuq1XlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XDbp76yj4zpW86;
	Thu, 26 Sep 2024 09:38:07 +0800 (CST)
Received: from kwepemf500003.china.huawei.com (unknown [7.202.181.241])
	by mail.maildlp.com (Postfix) with ESMTPS id 73A5F18005F;
	Thu, 26 Sep 2024 09:40:10 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemf500003.china.huawei.com
 (7.202.181.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 26 Sep
 2024 09:40:09 +0800
From: Zhang Zekun <zhangzekun11@huawei.com>
To: <nm@ti.com>, <kristo@kernel.org>, <ssantosh@kernel.org>,
	<ulf.hansson@linaro.org>, <linux-pm@vger.kernel.org>
CC: <chenjun102@huawei.com>, <zhangzekun11@huawei.com>
Subject: [RESEND PATCH v2 1/2] pmdomain: ti-sci: Add missing of_node_put() for args.np
Date: Thu, 26 Sep 2024 09:25:50 +0800
Message-ID: <20240926012551.31712-2-zhangzekun11@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240926012551.31712-1-zhangzekun11@huawei.com>
References: <20240926012551.31712-1-zhangzekun11@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemf500003.china.huawei.com (7.202.181.241)

of_parse_phandle_with_args() need to call of_node_put() to decerement
the refcount of args.np. Adding backing the missing of_node_put().

Fixes: efa5c01cd7ee ("soc: ti: ti_sci_pm_domains: switch to use multiple genpds instead of one")
Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
---
v2: Add missing brackets.

 drivers/pmdomain/ti/ti_sci_pm_domains.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pmdomain/ti/ti_sci_pm_domains.c b/drivers/pmdomain/ti/ti_sci_pm_domains.c
index 1510d5ddae3d..0df3eb7ff09a 100644
--- a/drivers/pmdomain/ti/ti_sci_pm_domains.c
+++ b/drivers/pmdomain/ti/ti_sci_pm_domains.c
@@ -161,6 +161,7 @@ static int ti_sci_pm_domain_probe(struct platform_device *pdev)
 				break;
 
 			if (args.args_count >= 1 && args.np == dev->of_node) {
+				of_node_put(args.np);
 				if (args.args[0] > max_id) {
 					max_id = args.args[0];
 				} else {
@@ -192,7 +193,10 @@ static int ti_sci_pm_domain_probe(struct platform_device *pdev)
 				pm_genpd_init(&pd->pd, NULL, true);
 
 				list_add(&pd->node, &pd_provider->pd_list);
+			} else {
+				of_node_put(args.np);
 			}
+
 			index++;
 		}
 	}
-- 
2.17.1


