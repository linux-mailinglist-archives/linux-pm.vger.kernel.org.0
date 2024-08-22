Return-Path: <linux-pm+bounces-12724-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47DF895B62F
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 15:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DB5C281820
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 13:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D001C9EBD;
	Thu, 22 Aug 2024 13:14:07 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FFED26AC1
	for <linux-pm@vger.kernel.org>; Thu, 22 Aug 2024 13:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724332447; cv=none; b=Du7Hezt2QT1vceF4Jvc4rK3iFZ99NWu0xg/WiORluWMrFTIzSYq8vlgZuIMxl27G6y8X2zpMjnoFIQGU98X7iOMZ2A2dZ7WMX5TCeoFiUG5ggIUMKvkPw3pmmFlBsLZtlByxeY4lfI5IcF9QWjmTJ6KZGHVCOv9f9AsMta2Pb9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724332447; c=relaxed/simple;
	bh=SqUPlwDthx1P7i3KHrrA9DJ5yWBJZlR1o2GynFZrb5E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mZi9Y9Qynq0TGlvsd6RCbogiTlw6IfxyUBMK3BA2gMdhnGLLAJuy6Nc5oWd7GSI9nlnltrx/0gRkvgrU5a0ze+v8zhMZNwMLO0gXUDMkyHiOJUCAKMIiCx3XFJZT7nCTNpuMrKfNOwcD4Gu6z0Wn4g3pqWFcnY6QLozEiQGx3sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WqNns0Xx9z20lxR;
	Thu, 22 Aug 2024 21:09:21 +0800 (CST)
Received: from kwepemf500003.china.huawei.com (unknown [7.202.181.241])
	by mail.maildlp.com (Postfix) with ESMTPS id E5107180019;
	Thu, 22 Aug 2024 21:14:03 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemf500003.china.huawei.com
 (7.202.181.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 22 Aug
 2024 21:14:03 +0800
From: Zhang Zekun <zhangzekun11@huawei.com>
To: <nm@ti.com>, <kristo@kernel.org>, <ssantosh@kernel.org>,
	<ulf.hansson@linaro.org>, <linux-pm@vger.kernel.org>
CC: <zhangzekun11@huawei.com>
Subject: [PATCH 1/2]  pmdomain: ti-sci: Add missing of_node_put() for args.np
Date: Thu, 22 Aug 2024 21:00:54 +0800
Message-ID: <20240822130055.50113-2-zhangzekun11@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240822130055.50113-1-zhangzekun11@huawei.com>
References: <20240822130055.50113-1-zhangzekun11@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemf500003.china.huawei.com (7.202.181.241)

of_parse_phandle_with_args() need to call of_node_put() to decerement
the refcount of args.np. Adding backing the missing of_node_put().

Fixes: efa5c01cd7ee ("soc: ti: ti_sci_pm_domains: switch to use multiple genpds instead of one")
Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
---
 drivers/pmdomain/ti/ti_sci_pm_domains.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pmdomain/ti/ti_sci_pm_domains.c b/drivers/pmdomain/ti/ti_sci_pm_domains.c
index 1510d5ddae3d..2b5c26713958 100644
--- a/drivers/pmdomain/ti/ti_sci_pm_domains.c
+++ b/drivers/pmdomain/ti/ti_sci_pm_domains.c
@@ -161,6 +161,7 @@ static int ti_sci_pm_domain_probe(struct platform_device *pdev)
 				break;
 
 			if (args.args_count >= 1 && args.np == dev->of_node) {
+				of_node_put(args.np);
 				if (args.args[0] > max_id) {
 					max_id = args.args[0];
 				} else {
@@ -192,7 +193,8 @@ static int ti_sci_pm_domain_probe(struct platform_device *pdev)
 				pm_genpd_init(&pd->pd, NULL, true);
 
 				list_add(&pd->node, &pd_provider->pd_list);
-			}
+			} else
+				of_node_put(args.np);
 			index++;
 		}
 	}
-- 
2.17.1


