Return-Path: <linux-pm+bounces-16338-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 707639ADA42
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 05:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FC6F1C218BF
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 03:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CDA1154456;
	Thu, 24 Oct 2024 03:09:37 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0C874068
	for <linux-pm@vger.kernel.org>; Thu, 24 Oct 2024 03:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729739377; cv=none; b=pSsXTUyUQdR7uqIZgDbMS88vcx+nU/0L1Qq1fV75l4JkUYD/jzL0AN4SUWWziMPu7kvn2vsKduSXgjGroNwy7IeTrQpY9YHkwPecerQ56gN+sAGntvZson3it1eSl1uEfssUqL+Ose+zUklvy6hWzzkrF/Tzd+YmY1aw5tNcfjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729739377; c=relaxed/simple;
	bh=8gIVK7vhsNt+7MTQf6nWZ6GU3ahg6rKXdhIQElTORCA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aCaSsjYK1VgEeFBcD69YegveqtePBqDvroeY4uLVCX5WseGkB9HEX+jGsdkOVW5p6U/TeM5CQBcduNV7HP3TdBayUUtz313098wl7WWOGIFTfgudV21S7EiDK3InBIRcG1wyttNiVpI7/Fh5XklPbnGls0NkYeHBr6jx3Zw/Wc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XYrT23fF4z2FbTx;
	Thu, 24 Oct 2024 11:08:06 +0800 (CST)
Received: from kwepemf500003.china.huawei.com (unknown [7.202.181.241])
	by mail.maildlp.com (Postfix) with ESMTPS id 87FA8140154;
	Thu, 24 Oct 2024 11:09:30 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemf500003.china.huawei.com
 (7.202.181.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 24 Oct
 2024 11:09:29 +0800
From: Zhang Zekun <zhangzekun11@huawei.com>
To: <nm@ti.com>, <kristo@kernel.org>, <ssantosh@kernel.org>,
	<ulf.hansson@linaro.org>, <d-gole@ti.com>, <linux-pm@vger.kernel.org>
CC: <chenjun102@huawei.com>, <zhangzekun11@huawei.com>
Subject: [PATCH v3 1/2] pmdomain: ti-sci: Add missing of_node_put() for args.np
Date: Thu, 24 Oct 2024 11:04:41 +0800
Message-ID: <20241024030442.119506-2-zhangzekun11@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241024030442.119506-1-zhangzekun11@huawei.com>
References: <20241024030442.119506-1-zhangzekun11@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemf500003.china.huawei.com (7.202.181.241)

of_parse_phandle_with_args() needs to call of_node_put() to decrement
the refcount of args.np. So, Add the missing of_node_put() in the loop.

Fixes: efa5c01cd7ee ("soc: ti: ti_sci_pm_domains: switch to use multiple genpds instead of one")
Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
---
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


