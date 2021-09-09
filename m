Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8081440598E
	for <lists+linux-pm@lfdr.de>; Thu,  9 Sep 2021 16:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240362AbhIIOrw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Sep 2021 10:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245352AbhIIOrp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Sep 2021 10:47:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96DCBC061226
        for <linux-pm@vger.kernel.org>; Thu,  9 Sep 2021 07:38:36 -0700 (PDT)
Date:   Thu, 09 Sep 2021 14:38:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631198314;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xP3Rp7V9Xm543LIjN3FrMeijC2BhAfeDlCI1oNBZRUA=;
        b=M8DPtzTGUfB5zvNg0rSUY1YLVmuTRZ9YdpLW9c/UgnBDw3fLNK7GC/PuZ/KyVikCV5PHFB
        J+AyIbO8DAXITWto1FBvBul6e9xyUS8n2t2UdaQXxckmEQHBTyZs3hPyO1Q9JZgXMUzkeg
        5t3fnAjuMONW6Wf5ZFJF2sKOWj7xAHNKbMQ0KvQ3ZaUYHiHOEhZKeQ0jjdLfCVyFxBJavr
        jnJd0/N+F3Tr0dpuu8ZSHZQ9bZFLsagZIzNdTCktrD/Ci3tmoVDUt+besHfAcybqfbdo74
        c3j1rH8nbYpZhPR+FRJ2JyJXif7TawVBDkcCLBmSz8dVFtzGW6nxv5GZAp/dgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631198314;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xP3Rp7V9Xm543LIjN3FrMeijC2BhAfeDlCI1oNBZRUA=;
        b=+AC5mn4NdYwX5OE79a5kjmC19FvSmm+FRE8nUqelf9ZcxY0KnsXwl48eEqfV1j/5sUaKQr
        aCdnPpSdfmXP58Dg==
From:   "thermal-bot for Matthias Kaehlcke" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/qcom/spmi-adc-tm5: Don't
 abort probing if a sensor is not used
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20210823134726.1.I1dd23ddf77e5b3568625d80d6827653af071ce19@changeid>
References: <20210823134726.1.I1dd23ddf77e5b3568625d80d6827653af071ce19@changeid>
MIME-Version: 1.0
Message-ID: <163119831350.25758.1593569936102362428.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     70ee251ded6ba24c15537f4abb8a318e233d0d1a
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//70ee251ded6ba24c15537f4abb8a318e233d0d1a
Author:        Matthias Kaehlcke <mka@chromium.org>
AuthorDate:    Mon, 23 Aug 2021 13:47:30 -07:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 09 Sep 2021 16:33:29 +02:00

thermal/drivers/qcom/spmi-adc-tm5: Don't abort probing if a sensor is not used

adc_tm5_register_tzd() registers the thermal zone sensors for all
channels of the thermal monitor. If the registration of one channel
fails the function skips the processing of the remaining channels
and returns an error, which results in _probe() being aborted.

One of the reasons the registration could fail is that none of the
thermal zones is using the channel/sensor, which hardly is a critical
error (if it is an error at all). If this case is detected emit a
warning and continue with processing the remaining channels.

Fixes: ca66dca5eda6 ("thermal: qcom: add support for adc-tm5 PMIC thermal monitor")
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reported-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210823134726.1.I1dd23ddf77e5b3568625d80d6827653af071ce19@changeid
---
 drivers/thermal/qcom/qcom-spmi-adc-tm5.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
index 232fd0b..8494cc0 100644
--- a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
+++ b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
@@ -359,6 +359,12 @@ static int adc_tm5_register_tzd(struct adc_tm5_chip *adc_tm)
 							   &adc_tm->channels[i],
 							   &adc_tm5_ops);
 		if (IS_ERR(tzd)) {
+			if (PTR_ERR(tzd) == -ENODEV) {
+				dev_warn(adc_tm->dev, "thermal sensor on channel %d is not used\n",
+					 adc_tm->channels[i].channel);
+				continue;
+			}
+
 			dev_err(adc_tm->dev, "Error registering TZ zone for channel %d: %ld\n",
 				adc_tm->channels[i].channel, PTR_ERR(tzd));
 			return PTR_ERR(tzd);
