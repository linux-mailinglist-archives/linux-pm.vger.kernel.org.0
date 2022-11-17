Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B04A562DA1D
	for <lists+linux-pm@lfdr.de>; Thu, 17 Nov 2022 13:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239987AbiKQMCJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Nov 2022 07:02:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239896AbiKQMBs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Nov 2022 07:01:48 -0500
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F21959FE8;
        Thu, 17 Nov 2022 04:01:44 -0800 (PST)
From:   Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
        t=1668686500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=L6AmVYk+3czGQRwn6dfUAWPTlXwM30IpBMZAykr0mwg=;
        b=s9XEMn872hGlytHJ1n3LB32DjIrVnEMxL1+/h0qVx8jNx8bhMXujyeUNTXF5H2jThWOtsB
        Oo2Qa/tT/wVPHpCfOmIwskELJzkf9R3T4paKA/sCDNgv2PKMHVw4scdZD5GPw8/qQ81IGz
        QeE/7CRsJyryXyfd0sztD4yrng+EieY=
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, Hans de Goede <hdegoede@redhat.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-patches@linuxtesting.org, trufanov@swemel.ru, vfh@swemel.ru
Subject: [PATCH] power: supply: Added check for negative values
Date:   Thu, 17 Nov 2022 15:01:40 +0300
Message-Id: <20221117120140.103208-1-arefev@swemel.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Variable 'pirq', which may receive negative value
in platform_get_irq().
Used as an index in a function regmap_irq_get_virq().

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Denis Arefev <arefev@swemel.ru>
---
 drivers/power/supply/axp288_fuel_gauge.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/power/supply/axp288_fuel_gauge.c b/drivers/power/supply/axp288_fuel_gauge.c
index 148eb8105803..36c7039c99c2 100644
--- a/drivers/power/supply/axp288_fuel_gauge.c
+++ b/drivers/power/supply/axp288_fuel_gauge.c
@@ -640,6 +640,8 @@ static void fuel_gauge_init_irq(struct axp288_fg_info *info)
 
 	for (i = 0; i < AXP288_FG_INTR_NUM; i++) {
 		pirq = platform_get_irq(info->pdev, i);
+		if (pirq < 0)
+			continue;
 		info->irq[i] = regmap_irq_get_virq(info->regmap_irqc, pirq);
 		if (info->irq[i] < 0) {
 			dev_warn(&info->pdev->dev,
-- 
2.25.1

