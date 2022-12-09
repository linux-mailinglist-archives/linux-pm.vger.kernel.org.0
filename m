Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1C91648521
	for <lists+linux-pm@lfdr.de>; Fri,  9 Dec 2022 16:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbiLIP0p (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Dec 2022 10:26:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbiLIP0g (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Dec 2022 10:26:36 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9EAE8F0A7
        for <linux-pm@vger.kernel.org>; Fri,  9 Dec 2022 07:26:30 -0800 (PST)
Date:   Fri, 09 Dec 2022 15:26:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670599587;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xyhlxR0Qa9e5YHCBMtM54ct3txgg/Q0JoUDwivsIucI=;
        b=fGOYS0J7zsAqbMd2yZyUuwuT6s4fQB9F/lWM1Ipe83pLvBdINsoiF+q6Fcyvmt48VChkLx
        uwx4q9fZOC3vSK18fI3pdEdtSZfVBlH8+XGOcLi765Yf/P9ZQDwBECc3EY4gwZPDTVjf0m
        2DJ8jPZsSAlz9vIE3AcsKZI7JeLdwfvO/RrLum6bxPm0J5cMuAtKGwCKngej/zfapmolYb
        q3zndFT8UYZGk1UUng5OA2qj+jOb2ShICK3PSd+hJKys2PJDNtdtAzm5T45LJaGXkW9zka
        eBanSz5LYIbKaeQxw6/uqD4dvKfrU7YNKkbvTrHsNfz99z+FMzU30Uv9BWmefQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670599587;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xyhlxR0Qa9e5YHCBMtM54ct3txgg/Q0JoUDwivsIucI=;
        b=+wfLE5vY2kVNY60RbxrYzobiNKolWSDm/5PFHoYVYd2jtyxWzwxauu1rP9BualAPKVyptY
        sYg9s8dl4PkXw8Aw==
From:   "thermal-bot for Manivannan Sadhasivam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/qcom: Demote error log of
 thermal zone register to debug
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org
In-Reply-To: <20221029052933.32421-1-manivannan.sadhasivam@linaro.org>
References: <20221029052933.32421-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Message-ID: <167059958753.4906.3836580325590770835.tip-bot2@tip-bot2>
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

Commit-ID:     ddbac90afd071aab37d7041b6b526222384d9d04
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//ddbac90afd071aab37d7041b6b526222384d9d04
Author:        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
AuthorDate:    Sat, 29 Oct 2022 10:59:33 +05:30
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Thu, 08 Dec 2022 14:30:44 +01:00

thermal/drivers/qcom: Demote error log of thermal zone register to debug

devm_thermal_of_zone_register() can fail with -ENODEV if thermal zone for
the channel is not represented in DT. This is perfectly fine since not all
sensors needs to be used for thermal zones but only a few in real world.

So demote the error log to debug to avoid spamming users.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Link: https://lore.kernel.org/r/20221029052933.32421-1-manivannan.sadhasivam@linaro.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
---
 drivers/thermal/qcom/qcom-spmi-adc-tm5.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
index 88462a4..ff47fc9 100644
--- a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
+++ b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
@@ -678,7 +678,7 @@ static int adc_tm5_register_tzd(struct adc_tm5_chip *adc_tm)
 						    &adc_tm5_thermal_ops);
 		if (IS_ERR(tzd)) {
 			if (PTR_ERR(tzd) == -ENODEV) {
-				dev_warn(adc_tm->dev, "thermal sensor on channel %d is not used\n",
+				dev_dbg(adc_tm->dev, "thermal sensor on channel %d is not used\n",
 					 adc_tm->channels[i].channel);
 				continue;
 			}
