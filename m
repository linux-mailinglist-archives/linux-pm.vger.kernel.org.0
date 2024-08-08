Return-Path: <linux-pm+bounces-11983-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D52F994B5E9
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2024 06:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 577EF283763
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2024 04:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2926783A06;
	Thu,  8 Aug 2024 04:29:27 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12359479;
	Thu,  8 Aug 2024 04:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723091367; cv=none; b=GRS6xyadray8WDvBTo8rwSO9TFnaFxeBdOG6Ym69NUw4xE+VgUIZEbfXREsQ2DPa62F+OjwMJXRUHx3GA9BEFwGK4dDPzGuazvoQvTVpmXgnabWMc4aHx+7w0S5EB1nPP3C1VBobQYv5dQRBvpM6T5M9pdL3DuspxTblrUdQbXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723091367; c=relaxed/simple;
	bh=z0h5RZUv4Ugp2MrhgSqmn8OTk4rVenDC+5+77ckWmRA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=esHqhRG8DXDh1CKlEtONQ5vFF/s9mnPlhj4MXGzUEHRBut5I1RF+6M8MBYo5VsdVgwvZAHFaN6mHi6N8MG04G9+dV81D1lP7ie0u+Y1JkgnJZQJI5qTWkPvMdp68/bj/EGl9Hlo1X+kCi7mxrZKktGWnLSsJ8nX1b4Q9SVvoa8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-03 (Coremail) with SMTP id rQCowAA3PfmLSbRmyYNeBA--.65294S2;
	Thu, 08 Aug 2024 12:29:03 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: ulf.hansson@linaro.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	geert+renesas@glider.be,
	arnd@arndb.de,
	peng.fan@nxp.com,
	make24@iscas.ac.cn,
	u.kleine-koenig@pengutronix.de,
	marex@denx.de,
	benjamin.gaignard@collabora.com
Cc: linux-pm@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] soc: imx: imx8m-blk-ctrl: Fix NULL pointer dereference
Date: Thu,  8 Aug 2024 12:28:58 +0800
Message-Id: <20240808042858.2768309-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAA3PfmLSbRmyYNeBA--.65294S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CrWrJryDGF48AFyDAF48tFb_yoW8Gr47pF
	4DXFyYyrWIkr12yF1jgF1jva45Xa42kw17Gwn5Gas3X3y5JFyqka4fWw1v9r15AFWxXa4Y
	ya12yr15C3WruFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBa14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr
	0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8v
	x2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20x
	vY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I
	3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIx
	AIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAI
	cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2js
	IEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRNAwsUUUUU=
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

Check bc->bus_power_dev = dev_pm_domain_attach_by_name() return value using
IS_ERR_OR_NULL() instead of plain IS_ERR(), and fail if bc->bus_power_dev 
is either error or NULL.

In case a power domain attached by dev_pm_domain_attach_by_name() is not
described in DT, dev_pm_domain_attach_by_name() returns NULL, which is
then used, which leads to NULL pointer dereference.

Found by code review.

Cc: stable@vger.kernel.org
Fixes: 1a1da28544fd ("soc: imx: imx8m-blk-ctrl: Defer probe if 'bus' genpd is not yet ready")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 drivers/pmdomain/imx/imx8m-blk-ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pmdomain/imx/imx8m-blk-ctrl.c b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
index ca942d7929c2..d46fb5387148 100644
--- a/drivers/pmdomain/imx/imx8m-blk-ctrl.c
+++ b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
@@ -212,7 +212,7 @@ static int imx8m_blk_ctrl_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	bc->bus_power_dev = dev_pm_domain_attach_by_name(dev, "bus");
-	if (IS_ERR(bc->bus_power_dev)) {
+	if (IS_ERR_OR_NULL(bc->bus_power_dev)) {
 		if (PTR_ERR(bc->bus_power_dev) == -ENODEV)
 			return dev_err_probe(dev, -EPROBE_DEFER,
 					     "failed to attach power domain \"bus\"\n");
-- 
2.25.1


