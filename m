Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5C1584358
	for <lists+linux-pm@lfdr.de>; Thu, 28 Jul 2022 17:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbiG1Pl7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Jul 2022 11:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231945AbiG1Pl6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Jul 2022 11:41:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F6268DD8
        for <linux-pm@vger.kernel.org>; Thu, 28 Jul 2022 08:41:57 -0700 (PDT)
Date:   Thu, 28 Jul 2022 15:41:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659022916;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X3naLKrfgzsx1gc+8Czo3/Vw/Jse8qVvEJP0VbVfc98=;
        b=B0yA6zwQCy6sn1LVsYr13K0mMfU23GQT+1IqfxD2jhVjTqOImxkgMErfZUifdEaw/VlQmf
        SzvChddk6cALyXNikaIO0eZ3zbmLtwNmngzCgtv0+SX/1U5jK7vyxbFZ1573l0xcyts5Nf
        Rfw/QGW+BPbl0SIZeb19Kp5JPjcCBoyIcF1U0lCozfQizq/ciDfHS1H1ZaxgCT42Nv5kpG
        299b8QWdK6iVVZHLO+vgWrdya0U48pOGeSZLj2aE10ShnvN1MR/gfaUAmqGYQQaNargEy2
        ETL0qMdXz3zfVy5vv/886zindML5y5SXR4rwvtZ+UG7VISDe+5mF7TEScW5yDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659022916;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X3naLKrfgzsx1gc+8Czo3/Vw/Jse8qVvEJP0VbVfc98=;
        b=sTDLvB9WqtSAWKqADgANYO66IOTsjaFj+59HxIU6DbPj99AKI7+vW7KDPmDTIqbCjK8OJu
        kD8ratDv//KqCzDQ==
From:   "thermal-bot for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/qcom: Remove get_trend function
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>, rui.zhang@intel.com
In-Reply-To: <20220616202537.303655-1-daniel.lezcano@linaro.org>
References: <20220616202537.303655-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Message-ID: <165902291540.15455.2784966312672221423.tip-bot2@tip-bot2>
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

Commit-ID:     198fa45252d84baea593456cfda01deeb9dff13f
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//198fa45252d84baea593456cfda01deeb9dff13f
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Thu, 16 Jun 2022 22:25:35 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 28 Jul 2022 17:29:45 +02:00

thermal/drivers/qcom: Remove get_trend function

There is a get_trend function which is a wrapper to call a private
get_trend function. However, this private get_trend function is not
assigned anywhere.

Remove this dead code.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Amit Kucheria <amitk@kernel.org>
Link: https://lore.kernel.org/r/20220616202537.303655-1-daniel.lezcano@linaro.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/qcom/tsens.c | 12 ------------
 drivers/thermal/qcom/tsens.h |  2 --
 2 files changed, 14 deletions(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 7963ee3..e49f58e 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -933,17 +933,6 @@ static int tsens_get_temp(void *data, int *temp)
 	return priv->ops->get_temp(s, temp);
 }
 
-static int tsens_get_trend(void *data, int trip, enum thermal_trend *trend)
-{
-	struct tsens_sensor *s = data;
-	struct tsens_priv *priv = s->priv;
-
-	if (priv->ops->get_trend)
-		return priv->ops->get_trend(s, trend);
-
-	return -ENOTSUPP;
-}
-
 static int  __maybe_unused tsens_suspend(struct device *dev)
 {
 	struct tsens_priv *priv = dev_get_drvdata(dev);
@@ -1004,7 +993,6 @@ MODULE_DEVICE_TABLE(of, tsens_table);
 
 static const struct thermal_zone_of_device_ops tsens_of_ops = {
 	.get_temp = tsens_get_temp,
-	.get_trend = tsens_get_trend,
 	.set_trips = tsens_set_trips,
 };
 
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index 1471a2c..ba05c82 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -65,7 +65,6 @@ struct tsens_sensor {
  * @disable: Function to disable the tsens device
  * @suspend: Function to suspend the tsens device
  * @resume: Function to resume the tsens device
- * @get_trend: Function to get the thermal/temp trend
  */
 struct tsens_ops {
 	/* mandatory callbacks */
@@ -77,7 +76,6 @@ struct tsens_ops {
 	void (*disable)(struct tsens_priv *priv);
 	int (*suspend)(struct tsens_priv *priv);
 	int (*resume)(struct tsens_priv *priv);
-	int (*get_trend)(struct tsens_sensor *s, enum thermal_trend *trend);
 };
 
 #define REG_FIELD_FOR_EACH_SENSOR11(_name, _offset, _startbit, _stopbit) \
