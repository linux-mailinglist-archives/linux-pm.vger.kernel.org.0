Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA35852D2D0
	for <lists+linux-pm@lfdr.de>; Thu, 19 May 2022 14:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238012AbiESMo0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 May 2022 08:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238011AbiESMoY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 May 2022 08:44:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E152FBA9A9
        for <linux-pm@vger.kernel.org>; Thu, 19 May 2022 05:44:22 -0700 (PDT)
Date:   Thu, 19 May 2022 12:44:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652964261;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dRFRnFzNFJmfYYGM31LVX4TsK0erew7eGFocaxGB/7w=;
        b=KBjLUVbu7nphwghJp0RrPIsC9P5VOCTNrxjq8U4nMj+qQRZJTbeKddXC1hxuA0GcG9C7lR
        Pya3howEK7mS/COaND+g60Me+epwL/PW3YlUmchY+Ek/vDP0tJLjG4NGag0MeMGT9+Jfk5
        t4YrG1zxsFGlFgqNBzvEiSiSFrcVqQ/mjQrtFJAiHtwTDgUzAk6zJklb00MAM1tNb8eAZS
        vD07dra6OQ2kj4dncOJaJwQ7SYrS01tm9RFVfM0jgRHms2VFkf6Ffd49q2umuqNpfwgFh3
        9ZjIJ+hqXOMIPXl8+Z/E6f25+Xf5OQYNCoSp/3BOZYVoVOlN9OEV5MOl2mErJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652964261;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dRFRnFzNFJmfYYGM31LVX4TsK0erew7eGFocaxGB/7w=;
        b=NJoilCMxGzsZNsI6TE5/zmvSgJRprshCoxhxqyWXhKcF5a8ulSungNCateKMZL9DxxUI2N
        NV+FbK6QkmNnmSBQ==
From:   "thermal-bot for Dmitry Baryshkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/tsens: Add compat string for
 the qcom,msm8960
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20220406002648.393486-3-dmitry.baryshkov@linaro.org>
References: <20220406002648.393486-3-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Message-ID: <165296426003.4207.14373737174482487624.tip-bot2@tip-bot2>
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

Commit-ID:     2caf73969de6675318a711d0622406c8c66afc03
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//2caf73969de6675318a711d0622406c8c66afc03
Author:        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
AuthorDate:    Wed, 06 Apr 2022 03:26:46 +03:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 19 May 2022 12:11:51 +02:00

thermal/drivers/tsens: Add compat string for the qcom,msm8960

On apq8064 (msm8960) platforms the tsens device is created manually by
the gcc driver. Prepare the tsens driver for the qcom,msm8960-tsens
device instantiated from the device tree.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://lore.kernel.org/r/20220406002648.393486-3-dmitry.baryshkov@linaro.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/qcom/tsens.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 154d3cb..7963ee3 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -980,6 +980,9 @@ static const struct of_device_id tsens_table[] = {
 		.compatible = "qcom,msm8939-tsens",
 		.data = &data_8939,
 	}, {
+		.compatible = "qcom,msm8960-tsens",
+		.data = &data_8960,
+	}, {
 		.compatible = "qcom,msm8974-tsens",
 		.data = &data_8974,
 	}, {
