Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 286EE301D2B
	for <lists+linux-pm@lfdr.de>; Sun, 24 Jan 2021 16:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbhAXPZa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 24 Jan 2021 10:25:30 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:58073 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726333AbhAXPZ2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 24 Jan 2021 10:25:28 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 704C25C009B;
        Sun, 24 Jan 2021 10:24:23 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 24 Jan 2021 10:24:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=xMMEtd5uO4eABDjtC8AtZRx24Z
        O7m/3uoHD163uV0DI=; b=Mze9xgXHBtF3RZKTQVI0JrOtv1+hMHfwcPw+bDeXqz
        l68HMA6na5bpIPKCmtyYTh9YTqQR1rbTlVQ9uGTSCsTuMAApdVJynzE+NyDcNNs1
        U45j3CPGaw5jaNBAVHDsdUNQMD/v8t6/XjOL4vpqUke6um4L2yoD4Tdu0I+WdU+o
        8YUIAWt6SQCGdrf9jD7l10l3msXgBuAe+CvS5OKPj+AdV6eqdMfLTymfoedDKghw
        oRvZqvWp97z91O+XMFzPCsO0zyg8V1Qhp5s1f4lwMZ1MawqCudU9wx1Sfpx6oYpJ
        6dMbSnjTpHw+EWi/d0RNFWE4SCTi7gYzUXCNzAHTQiEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=xMMEtd5uO4eABDjtC
        8AtZRx24ZO7m/3uoHD163uV0DI=; b=Gosv6Uu0s9jFXNxnVU+zuQkP7w+NLYc/t
        zD6JvC2XpCdhbqXQPSMdHN0VDQ5Qo/yUrRYC9nHXkFSwA7KlwE3Kvg7TP4+DeD97
        VruKMKECqijGHgI12+62kdCbU2P2UA/2AczXyXOdPxuxsoEKiuZHiIhuWRBLrS96
        9VjZpAhKsgC60/qN4J1yhN/16uBxGa1iVyBolHEeXzEOLqNxQzaU5YUTB3gozsEb
        a7wR6yK9zq37QYOngcZWGgsvPuhFbbzUskubcofpYiX+X9Cd3QNt/P8hQeR4UydT
        PKuWtS2j4vffCKo+vskls9jIX8DPj/zJquXT/fQ2Jm/KT7agMtgIQ==
X-ME-Sender: <xms:JpENYLrzrNPv-lBaE5iOHCeVSt2Hlt2urWn1mK9TVNjbozI4ppcYBg>
    <xme:JpENYFr-CseeeU48y-ucw6SiNcLtkueI5Uao-WGLVoYzveR2oQNXsTQ-6grRutCZ9
    IXUczxPfqwCtXlWXw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvddugdejjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghlucfj
    ohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrfgrth
    htvghrnhepieetkefhheduudfgledtudefjeejfeegveehkeeufffhhfejkeehiefftdev
    tdevnecukfhppeejtddrudefhedrudegkedrudehudenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdho
    rhhg
X-ME-Proxy: <xmx:JpENYIOAix7yScdVlhlgJeLO386Z6zR1aVAhGQlwKFSmvx0qgYLnnQ>
    <xmx:JpENYO7Vgq5Z1I1SEjuvRkvgl4ILtTTU4vl04oslySj2Cpypj3i1qg>
    <xmx:JpENYK6ulLHtowc-EkbgINecqewPJ5gfZNSRUYz6a33fTfQY8uKAMA>
    <xmx:J5ENYKGjmUqMX2H65sAnt2NnQgOYSQHouFgPGsuOI_fLQf4K-aJPAA>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8F3C624005E;
        Sun, 24 Jan 2021 10:24:22 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH] power: supply: axp20x_usb_power: Init work before enabling IRQs
Date:   Sun, 24 Jan 2021 09:24:21 -0600
Message-Id: <20210124152421.39693-1-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The IRQ handler calls mod_delayed_work() on power->vbus_detect. However,
that work item is not initialized until after the IRQs are enabled. If
an IRQ is already pending when the driver is probed, the driver calls
mod_delayed_work() on an uninitialized work item, which causes an oops.

Fixes: bcfb7ae3f50b ("power: supply: axp20x_usb_power: Only poll while offline")
Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 drivers/power/supply/axp20x_usb_power.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index 20817a49110b..02aba3da271a 100644
--- a/drivers/power/supply/axp20x_usb_power.c
+++ b/drivers/power/supply/axp20x_usb_power.c
@@ -711,20 +711,21 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
 			     struct_size(power, irqs, axp_data->num_irq_names),
 			     GFP_KERNEL);
 	if (!power)
 		return -ENOMEM;
 
 	platform_set_drvdata(pdev, power);
 
 	power->axp20x_id = axp_data->axp20x_id;
 	power->regmap = axp20x->regmap;
 	power->num_irqs = axp_data->num_irq_names;
+	INIT_DELAYED_WORK(&power->vbus_detect, axp20x_usb_power_poll_vbus);
 
 	if (power->axp20x_id == AXP202_ID) {
 		/* Enable vbus valid checking */
 		ret = regmap_update_bits(power->regmap, AXP20X_VBUS_MON,
 					 AXP20X_VBUS_MON_VBUS_VALID,
 					 AXP20X_VBUS_MON_VBUS_VALID);
 		if (ret)
 			return ret;
 
 		if (IS_ENABLED(CONFIG_AXP20X_ADC))
@@ -763,21 +764,20 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
 		ret = devm_request_any_context_irq(&pdev->dev, power->irqs[i],
 						   axp20x_usb_power_irq, 0,
 						   DRVNAME, power);
 		if (ret < 0) {
 			dev_err(&pdev->dev, "Error requesting %s IRQ: %d\n",
 				axp_data->irq_names[i], ret);
 			return ret;
 		}
 	}
 
-	INIT_DELAYED_WORK(&power->vbus_detect, axp20x_usb_power_poll_vbus);
 	if (axp20x_usb_vbus_needs_polling(power))
 		queue_delayed_work(system_power_efficient_wq, &power->vbus_detect, 0);
 
 	return 0;
 }
 
 static int axp20x_usb_power_remove(struct platform_device *pdev)
 {
 	struct axp20x_usb_power *power = platform_get_drvdata(pdev);
 
-- 
2.26.2

