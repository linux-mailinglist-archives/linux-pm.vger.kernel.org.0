Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E799648526
	for <lists+linux-pm@lfdr.de>; Fri,  9 Dec 2022 16:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbiLIP0t (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Dec 2022 10:26:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbiLIP0h (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Dec 2022 10:26:37 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51958F0AE
        for <linux-pm@vger.kernel.org>; Fri,  9 Dec 2022 07:26:32 -0800 (PST)
Date:   Fri, 09 Dec 2022 15:26:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670599588;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x61v7bg0mA7iagJ9asTj4lKa9Gg2uXWFJd1qvDMl+dI=;
        b=vLGqBgG+X2BuQfZvZsBaq66jduEz0i4D2sCmdpsmBcwqUsaJyXpaaWK2kBPfDjLl1nsokk
        Z+5jQoBZSHWb6Mz5ZBXiNJVs3P2xqUbzpLnvy3ddrGJoF4C7V98qh4lHgi/jxJH1qVkENY
        4p5ZYLobV7khpPcKqee9/qewGEp6LJAccmcRTuyYeAtVbWTxHXj9iC4h1p5ptc2itC4XeV
        X2BzDwPLMhLjuABaw2NXEPTFCbrGCJBocsmkN336jHUZEybbdmoxghmZvHMrlegvaVBPfR
        TyaXXjpxWgD/+EJTfRJ1LPxPzfGGDx05q9o7uP2Ie4+mE2mCC0Zr2DmMt4Spsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670599588;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x61v7bg0mA7iagJ9asTj4lKa9Gg2uXWFJd1qvDMl+dI=;
        b=ceFh/BdxDStnOR1HkRJb/YpmhKQFDfI/RnGV3ar2IWrtTC/Z50zw2PrIbvEGz26lhXlcAM
        4WigGYjbqvfIgkBA==
From:   "thermal-bot for Johan Hovold" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal: qcom-spmi-adc-tm5: suppress
 probe-deferral error message
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Andrew Halaney <ahalaney@redhat.com>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org
In-Reply-To: <20221102152630.696-1-johan+linaro@kernel.org>
References: <20221102152630.696-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Message-ID: <167059958829.4906.9817713570611553877.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     807efb7102e8d22b61cd400495f9478a110badd2
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//807efb7102e8d22b61cd400495f9478a110badd2
Author:        Johan Hovold <johan+linaro@kernel.org>
AuthorDate:    Wed, 02 Nov 2022 16:26:30 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Thu, 08 Dec 2022 14:30:44 +01:00

thermal: qcom-spmi-adc-tm5: suppress probe-deferral error message

Drivers should not be logging errors on probe deferral. Switch to using
dev_err_probe() to log failures when parsing the devicetree to avoid
errors like:

	qcom-spmi-adc-tm5 c440000.spmi:pmic@0:adc-tm@3400: get dt data failed: -517

when a channel is not yet available.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
Link: https://lore.kernel.org/r/20221102152630.696-1-johan+linaro@kernel.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
---
 drivers/thermal/qcom/qcom-spmi-adc-tm5.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
index 1b2c43e..88462a4 100644
--- a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
+++ b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
@@ -1030,10 +1030,8 @@ static int adc_tm5_probe(struct platform_device *pdev)
 		return irq;
 
 	ret = adc_tm5_get_dt_data(adc_tm, node);
-	if (ret) {
-		dev_err(dev, "get dt data failed: %d\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "get dt data failed\n");
 
 	ret = adc_tm->data->init(adc_tm);
 	if (ret) {
