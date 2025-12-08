Return-Path: <linux-pm+bounces-39292-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1B7CACBED
	for <lists+linux-pm@lfdr.de>; Mon, 08 Dec 2025 10:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 380DD306C2F2
	for <lists+linux-pm@lfdr.de>; Mon,  8 Dec 2025 09:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4103E322A2E;
	Mon,  8 Dec 2025 09:43:13 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3933218B3;
	Mon,  8 Dec 2025 09:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765186993; cv=none; b=fEgioEhDk94gUvxOA+n/s970DR1j3U7GZBLGvYjD/PC6YcXsIPQ2HjRYxa5k2USHYytrP9+uYiP0gn0znbllIIMmHXKbGz0M0PiFTi9V4AgDc+47H8HKVzs7Z6Wr+HRctdzsfLDnbfrQ8db5yZRw+T/WWu2iCajKPz2/vHwA6q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765186993; c=relaxed/simple;
	bh=78Dl1vQ2yaBh7z6ugJ5fq/4fwesJC059Jr3yD3ti/O4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uejwoWmheU41qTqI/lN00t4m6QndAlm/DOXIzd92LeTEllDhuCAtU/aGlB6MKCYsC/2B/ngqVaoC2lnlXV/vNlUB21uXF/bCFODiuNQjUnRiar7w4lWQ8q7eMRI1BVrTabaFHsH+DIS+YOC2wFQC+L2Qt4Dt90peAvO7BPtfvYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [124.16.138.129])
	by APP-03 (Coremail) with SMTP id rQCowAB3muGVnTZpnbsAAA--.961S2;
	Mon, 08 Dec 2025 17:42:45 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: ulf.hansson@linaro.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-pm@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] pmdomain: imx: Fix reference count leak in imx_gpc_probe()
Date: Mon,  8 Dec 2025 09:42:42 +0000
Message-Id: <20251208094242.17821-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAB3muGVnTZpnbsAAA--.961S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCF4fWF4ftF47WFyftr4DXFb_yoW5Xw15pF
	ZrGFWakrWxGF47Ga4xtr1DZas0k3y2yw4jgw47G3WxZFn8tr9rur1Sva4UKr4SkFWkW3W5
	AF43JFy09F1UZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9C14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxkF7I0En4kS14v26r1q6r43MxkIecxEwVAFwVW8uwCF04k20xvY0x0EwIxGrw
	CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
	14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
	IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxK
	x2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI
	0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUhmiiUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAYKA2k2dlSkkAAAsK

of_get_child_by_name() returns a node pointer with refcount incremented,
we should use of_node_put() on it when not needed anymore. Add missing
of_node_put() calls in imx_gpc_probe() to avoid reference count leak.

This commit fixes the following issues:
1. Add of_node_put(pgc_node) before returning from imx_gpc_probe()
2. Use goto pattern to consolidate error handling

Fixes: 721cabf6c660 ("soc: imx: move PGC handling to a new GPC driver")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/pmdomain/imx/gpc.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/pmdomain/imx/gpc.c b/drivers/pmdomain/imx/gpc.c
index f18c7e6e75dd..754c60effc8a 100644
--- a/drivers/pmdomain/imx/gpc.c
+++ b/drivers/pmdomain/imx/gpc.c
@@ -416,8 +416,10 @@ static int imx_gpc_probe(struct platform_device *pdev)
 		return 0;
 
 	base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(base))
-		return PTR_ERR(base);
+	if (IS_ERR(base)) {
+		ret = PTR_ERR(base);
+		goto err_free;
+	}
 
 	regmap = devm_regmap_init_mmio_clk(&pdev->dev, NULL, base,
 					   &imx_gpc_regmap_config);
@@ -425,7 +427,7 @@ static int imx_gpc_probe(struct platform_device *pdev)
 		ret = PTR_ERR(regmap);
 		dev_err(&pdev->dev, "failed to init regmap: %d\n",
 			ret);
-		return ret;
+		goto err_free;
 	}
 
 	/*
@@ -460,29 +462,33 @@ static int imx_gpc_probe(struct platform_device *pdev)
 		int domain_index;
 
 		ipg_clk = devm_clk_get(&pdev->dev, "ipg");
-		if (IS_ERR(ipg_clk))
-			return PTR_ERR(ipg_clk);
+		if (IS_ERR(ipg_clk)) {
+			ret = PTR_ERR(ipg_clk);
+			goto err_free;
+		}
 		ipg_rate_mhz = clk_get_rate(ipg_clk) / 1000000;
 
 		for_each_child_of_node_scoped(pgc_node, np) {
 			ret = of_property_read_u32(np, "reg", &domain_index);
 			if (ret)
-				return ret;
+				goto err_free;
 
 			if (domain_index >= of_id_data->num_domains)
 				continue;
 
 			pd_pdev = platform_device_alloc("imx-pgc-power-domain",
 							domain_index);
-			if (!pd_pdev)
-				return -ENOMEM;
+			if (!pd_pdev) {
+				ret = -ENOMEM;
+				goto err_free;
+			}
 
 			ret = platform_device_add_data(pd_pdev,
 						       &imx_gpc_domains[domain_index],
 						       sizeof(imx_gpc_domains[domain_index]));
 			if (ret) {
 				platform_device_put(pd_pdev);
-				return ret;
+				goto err_free;
 			}
 			domain = pd_pdev->dev.platform_data;
 			domain->regmap = regmap;
@@ -495,12 +501,17 @@ static int imx_gpc_probe(struct platform_device *pdev)
 			ret = platform_device_add(pd_pdev);
 			if (ret) {
 				platform_device_put(pd_pdev);
-				return ret;
+				goto err_free;
 			}
 		}
 	}
 
+	of_node_put(pgc_node);
 	return 0;
+
+err_free:
+	of_node_put(pgc_node);
+	return ret;
 }
 
 static void imx_gpc_remove(struct platform_device *pdev)
-- 
2.34.1


