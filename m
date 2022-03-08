Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE5804D22B4
	for <lists+linux-pm@lfdr.de>; Tue,  8 Mar 2022 21:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350248AbiCHUes (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Mar 2022 15:34:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350251AbiCHUer (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Mar 2022 15:34:47 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBAE3B028
        for <linux-pm@vger.kernel.org>; Tue,  8 Mar 2022 12:33:49 -0800 (PST)
Date:   Tue, 08 Mar 2022 20:33:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646771627;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wu3fpLLmcM7FYvDeSHiwVkN3bIS20vmnS3erl6pBUwI=;
        b=rudzZ1T7j7wmy/pofiIHtS8z/EGhGsfAsDvqmfPM7eAhbMI7qY1K8xxvq9IUpIwRPKKPQG
        s4os90VjNA7J4XeGnA3A9gKHet8sb82O/ANdGW9C5sE91KLz/Mq2DvPZZd4H0gkpbtwcfL
        U5E4Em/QMnyxAG/xbL2NsNv93sb1qOFE92iAWRdZqpbP78JbbYj2FEuekBQv2Tsv0otkis
        i+sTjo7iBTFStip9hGnaGOl7ti8yT2aPGUsmbCsZHRdAKMhUpowZEdKLx3juFKKZZYDFXK
        2LX3khd4ebke3kYUuCvFqFEI9sVAE3RTR/hGEo6+07+efLA0Xs1VtwKNZaktxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646771627;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wu3fpLLmcM7FYvDeSHiwVkN3bIS20vmnS3erl6pBUwI=;
        b=BHys0VThYoxhM00hXiYDkQgSKknpTnUCzKTGcq0561Z4DDMkrsaUFFWpz4DxLsfTn9Cd0O
        3x/cSyILojTzQxCA==
From:   "thermal-bot for Florian Fainelli" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/brcmstb_thermal: Interrupt is
 optional
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20220301181412.2008044-1-f.fainelli@gmail.com>
References: <20220301181412.2008044-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Message-ID: <164677162497.16921.16912408744026813034.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     7eab0b9d48a825e8e845003f81eeaaf0bcb239fd
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//7eab0b9d48a825e8e845003f81eeaaf0bcb239fd
Author:        Florian Fainelli <f.fainelli@gmail.com>
AuthorDate:    Tue, 01 Mar 2022 10:14:12 -08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 08 Mar 2022 21:26:09 +01:00

thermal/drivers/brcmstb_thermal: Interrupt is optional

Utilize platform_get_irq_optional() to silence these messages:

brcmstb_thermal a581500.thermal: IRQ index 0 not found

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Link: https://lore.kernel.org/r/20220301181412.2008044-1-f.fainelli@gmail.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/broadcom/brcmstb_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/broadcom/brcmstb_thermal.c b/drivers/thermal/broadcom/brcmstb_thermal.c
index 8df5ede..0cedb8b 100644
--- a/drivers/thermal/broadcom/brcmstb_thermal.c
+++ b/drivers/thermal/broadcom/brcmstb_thermal.c
@@ -351,7 +351,7 @@ static int brcmstb_thermal_probe(struct platform_device *pdev)
 
 	priv->thermal = thermal;
 
-	irq = platform_get_irq(pdev, 0);
+	irq = platform_get_irq_optional(pdev, 0);
 	if (irq >= 0) {
 		ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
 						brcmstb_tmon_irq_thread,
