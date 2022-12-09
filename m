Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88F29648524
	for <lists+linux-pm@lfdr.de>; Fri,  9 Dec 2022 16:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbiLIP0s (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Dec 2022 10:26:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbiLIP0g (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Dec 2022 10:26:36 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEBE28DBE3
        for <linux-pm@vger.kernel.org>; Fri,  9 Dec 2022 07:26:32 -0800 (PST)
Date:   Fri, 09 Dec 2022 15:26:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670599588;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zw1E0iZOsmUGFALD/3ISDazxL5ZlATvGx+mCbcUGsr8=;
        b=e9fJnbRuihk1AFoPpBHw56tOlkE718sXyS19/24pA+SMq09OeNlg6ofzOnGCm6ubU08PBM
        Kc2RW0de+DWtIQWPZ53ZIKwCB67peLmZlokLQ4xRlo3RUy6HZslyMbfCL8mo6+AA/jzleN
        akgCvtzzRTam/gmv3mkb0zFdinqqPyc/E/pDI9dilFwKD/ZutCaku+HAk2tp+2lbq5QPhx
        PW3pwX2FXi1uNzdAOAjLZn4441rnAFl9H0nwZ6kFxSULdIWtSdjgWsKoWxDIm9gsA9MRGo
        JrtzkQg8Yj6TjRswXerEKaI7kK3WO0l/tbfrBPAgl+GPfN/dukHEU9/5HLgAqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670599588;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zw1E0iZOsmUGFALD/3ISDazxL5ZlATvGx+mCbcUGsr8=;
        b=IJX5lZIbLCAS8OQ+ZRnvp9njn74TpzMGfRuTZk9ILK+bSG7uogktaV/xQwJMSCdcjlwynm
        guxBoXnUzOGJhFBQ==
From:   "thermal-bot for Geert Uytterhoeven" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal: ti-soc-thermal: Drop comma after SoC
 match table sentinel
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Keerthy <j-keerthy@ti.com>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org
In-Reply-To: =?utf-8?q?=3C1d6de2a80b919cb11199e56ac06ad21c273ebe57=2E16690?=
 =?utf-8?q?45586=2Egit=2Egeert+renesas=40glider=2Ebe=3E?=
References: =?utf-8?q?=3C1d6de2a80b919cb11199e56ac06ad21c273ebe57=2E166904?=
 =?utf-8?q?5586=2Egit=2Egeert+renesas=40glider=2Ebe=3E?=
MIME-Version: 1.0
Message-ID: <167059958858.4906.4491730221042665319.tip-bot2@tip-bot2>
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

Commit-ID:     8a1ddd1c47a0274341091ce1bc2703c7aeea9b58
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//8a1ddd1c47a0274341091ce1bc2703c7aeea9b58
Author:        Geert Uytterhoeven <geert+renesas@glider.be>
AuthorDate:    Mon, 21 Nov 2022 16:47:10 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Thu, 08 Dec 2022 14:30:44 +01:00

thermal: ti-soc-thermal: Drop comma after SoC match table sentinel

It does not make sense to have a comma after a sentinel, as any new
elements must be added before the sentinel.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Keerthy <j-keerthy@ti.com>
Link: https://lore.kernel.org/r/1d6de2a80b919cb11199e56ac06ad21c273ebe57.1669045586.git.geert+renesas@glider.be
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
---
 drivers/thermal/ti-soc-thermal/ti-bandgap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
index 67050a1..a1c9a15 100644
--- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
+++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
@@ -878,7 +878,7 @@ static struct ti_bandgap *ti_bandgap_build(struct platform_device *pdev)
  */
 static const struct soc_device_attribute soc_no_cpu_notifier[] = {
 	{ .machine = "OMAP4430" },
-	{ /* sentinel */ },
+	{ /* sentinel */ }
 };
 
 /***   Device driver call backs   ***/
