Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD1858434C
	for <lists+linux-pm@lfdr.de>; Thu, 28 Jul 2022 17:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbiG1Pls (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Jul 2022 11:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbiG1Plr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Jul 2022 11:41:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6544568DD8
        for <linux-pm@vger.kernel.org>; Thu, 28 Jul 2022 08:41:46 -0700 (PDT)
Date:   Thu, 28 Jul 2022 15:41:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659022905;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hHY+HKaH/AM2gVWYUEs7hxctf6bgNaAbpucHlyUO2Ro=;
        b=1PYQGQiYO0/9atSz7wQGx6rq/AJX6OmhKXrN4ryjg8HxgPtYMjNGMMx3uu4PMd25m9qGFQ
        F8RWZceQM7z5DLSq0lGuntk7AggWeO7zfv5QyXah0DNBUcy45MCSwVXRvd/WwQxpSN5Zpk
        FQVZWSKVg4rE68p7M2eX46Undim5yp4UawDzt+p80u6gIOi/8jKuCfTdEnSUw6maklvy6T
        OS0HAkItqL9xWc8OGDCByXG5YtcDXjxLjLk3gLLYhlVHd/GT+pThuHRGty3YmUSs36FrdB
        qfQvJIAnChpHYNm2XvU37Ov1OefGnVXSRpN3wpwtaHZGn4PiVuIEiAitI7y7LQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659022905;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hHY+HKaH/AM2gVWYUEs7hxctf6bgNaAbpucHlyUO2Ro=;
        b=P2O2U+kMoFN2iH10aJwdiIgxbdTeoBRKnKUIPH0f778TGdi5GK7ImuIFOk8io696P2Qs5t
        8t6Ij2r4t7SmtTDg==
From:   "thermal-bot for Dmitry Baryshkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/qcom/spmi-adc-tm5: Register
 thermal zones as hwmon sensors
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20220719054940.755907-2-dmitry.baryshkov@linaro.org>
References: <20220719054940.755907-2-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Message-ID: <165902290396.15455.5533342393994258286.tip-bot2@tip-bot2>
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

Commit-ID:     ee35f721477a96cd7a5ee8b0d24507ff4e67fa65
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//ee35f721477a96cd7a5ee8b0d24507ff4e67fa65
Author:        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
AuthorDate:    Tue, 19 Jul 2022 08:49:40 +03:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 28 Jul 2022 17:29:51 +02:00

thermal/drivers/qcom/spmi-adc-tm5: Register thermal zones as hwmon sensors

Register thermal zones as hwmon sensors to let userspace read
temperatures using standard hwmon interface.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
Link: https://lore.kernel.org/r/20220719054940.755907-2-dmitry.baryshkov@linaro.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/qcom/qcom-spmi-adc-tm5.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
index d9c9c97..073943c 100644
--- a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
+++ b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
@@ -20,6 +20,8 @@
 #include <linux/thermal.h>
 #include <asm-generic/unaligned.h>
 
+#include "../thermal_hwmon.h"
+
 /*
  * Thermal monitoring block consists of 8 (ADC_TM5_NUM_CHANNELS) channels. Each
  * channel is programmed to use one of ADC channels for voltage comparison.
@@ -687,6 +689,9 @@ static int adc_tm5_register_tzd(struct adc_tm5_chip *adc_tm)
 			return PTR_ERR(tzd);
 		}
 		adc_tm->channels[i].tzd = tzd;
+		if (devm_thermal_add_hwmon_sysfs(tzd))
+			dev_warn(adc_tm->dev,
+				 "Failed to add hwmon sysfs attributes\n");
 	}
 
 	return 0;
