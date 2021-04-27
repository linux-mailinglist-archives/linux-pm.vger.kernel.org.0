Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86F9736CBEE
	for <lists+linux-pm@lfdr.de>; Tue, 27 Apr 2021 21:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238946AbhD0TpR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Apr 2021 15:45:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43146 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238961AbhD0TpR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Apr 2021 15:45:17 -0400
Date:   Tue, 27 Apr 2021 19:44:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619552673;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ekNZKg+fJEXdFLOhACjkf8HBEq87DtazlJh4c+QtmvI=;
        b=tNWYKExFPnz6/luNe8GnAZnyGJLGMo5IyKE0YHBvsqPwMt3TuTcmfGLRd3/3d/QAmYpaRv
        IFBjfSVVe5l4rAAIpTsr2h02KZOXg0xbjOGxNSPCgdIPHeoz7i0HYFTvkrFdqRFYP/2UuV
        bpB8A60sEpGuPrFycdJJXGmd0TgDZ4EPNRGO3mvtpueLpVXJIo+fH5G+SPSyDce9Bn408B
        jPm6Dl+7X9xvd4oGcGUo/gA5dUlAPro1rtN9FnkpRqvs0PwXOwy1uHC4NhVdvLbog4WPng
        jxPZAcpBMDfhCiZvAlvInZG0k+mMW3IlMaOVUzlfpXIA+Ja0azXMe6FCYFWziw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619552673;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ekNZKg+fJEXdFLOhACjkf8HBEq87DtazlJh4c+QtmvI=;
        b=BfFYO/v0NJj/m8AUw7WQ2/t3Ydtun4tGv47ScGeL8LfkgzwHFI/V+81ezdkwlKZYi37GGk
        JYuQr/qS26MQOaBA==
From:   "thermal-bot for dingsenjie" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/tegra: Use
 devm_platform_ioremap_resource_byname
Cc:     dingsenjie <dingsenjie@yulong.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20210414063943.96244-1-dingsenjie@163.com>
References: <20210414063943.96244-1-dingsenjie@163.com>
MIME-Version: 1.0
Message-ID: <161955267276.29796.7874248666079758069.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     fc88f7ad763a8ef2a20f8904bd241930b7696f86
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//fc88f7ad763a8ef2a20f8904bd241930b7696f86
Author:        dingsenjie <dingsenjie@yulong.com>
AuthorDate:    Wed, 14 Apr 2021 14:39:43 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 20 Apr 2021 09:18:58 +02:00

thermal/drivers/tegra: Use devm_platform_ioremap_resource_byname

Use the devm_platform_ioremap_resource_byname() helper instead of
calling platform_get_resource_byname() and devm_ioremap_resource()
separately.

Signed-off-by: dingsenjie <dingsenjie@yulong.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210414063943.96244-1-dingsenjie@163.com
---
 drivers/thermal/tegra/soctherm.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index 8b8fbd4..8e303e9 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -2118,7 +2118,6 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
 	struct tegra_soctherm *tegra;
 	struct thermal_zone_device *z;
 	struct tsensor_shared_calib shared_calib;
-	struct resource *res;
 	struct tegra_soctherm_soc *soc;
 	unsigned int i;
 	int err;
@@ -2140,26 +2139,20 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
 
 	tegra->soc = soc;
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
-					   "soctherm-reg");
-	tegra->regs = devm_ioremap_resource(&pdev->dev, res);
+	tegra->regs = devm_platform_ioremap_resource_byname(pdev, "soctherm-reg");
 	if (IS_ERR(tegra->regs)) {
 		dev_err(&pdev->dev, "can't get soctherm registers");
 		return PTR_ERR(tegra->regs);
 	}
 
 	if (!tegra->soc->use_ccroc) {
-		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
-						   "car-reg");
-		tegra->clk_regs = devm_ioremap_resource(&pdev->dev, res);
+		tegra->clk_regs = devm_platform_ioremap_resource_byname(pdev, "car-reg");
 		if (IS_ERR(tegra->clk_regs)) {
 			dev_err(&pdev->dev, "can't get car clk registers");
 			return PTR_ERR(tegra->clk_regs);
 		}
 	} else {
-		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
-						   "ccroc-reg");
-		tegra->ccroc_regs = devm_ioremap_resource(&pdev->dev, res);
+		tegra->ccroc_regs = devm_platform_ioremap_resource_byname(pdev, "ccroc-reg");
 		if (IS_ERR(tegra->ccroc_regs)) {
 			dev_err(&pdev->dev, "can't get ccroc registers");
 			return PTR_ERR(tegra->ccroc_regs);
