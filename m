Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BADD959E6F3
	for <lists+linux-pm@lfdr.de>; Tue, 23 Aug 2022 18:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244470AbiHWQWM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Aug 2022 12:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244476AbiHWQVx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Aug 2022 12:21:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA0616D2D1
        for <linux-pm@vger.kernel.org>; Tue, 23 Aug 2022 05:42:47 -0700 (PDT)
Date:   Tue, 23 Aug 2022 12:42:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661258566;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4CZtoTEX34bv34DtTlhoEYE/uS10o3lIhpvvbC7wZEg=;
        b=qSe6sAbj3vDNiAHCa3pW5Sh4CXvxz+1MNBBywYfDw/kXZmmUaw8JkgcOQdqDOGJj7HwmuX
        xrWJdsQEMAE0ghCEJpdgdBPegR2bKzrX6S1WURwGDR3qiIwWdpmAIAKUVb4c2Bi1lc5ELi
        jbIh9LdfXjC8MIJsDWhGmUEq4VKKTDxd8azgbMrpN+kbttrY/exZ6ckbowWU8YplI4iyt9
        tqxvGN3+R5n/3q8/1OK1Ck1Wa8b+coUW5zPecqFjYuhX0BRE1/UZgCjZGfUj+HFUoHU6qG
        JR3/BSa1D5rf46SX3jP2+wmYiiOINQLCfFfKDNAflX61wqTF6aaV5Ag0s2vlqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661258566;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4CZtoTEX34bv34DtTlhoEYE/uS10o3lIhpvvbC7wZEg=;
        b=J53Qcaz6Nyk837T7B8J4tVYol0WktoTwMWDVn96LBvzVzMpZa6+gCBDGUHVEFnswIvce05
        mjk5q8baA1MJycBw==
From:   "thermal-bot for Jiapeng Chong" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/qcom/spmi-adc-tm5: Remove
 unnecessary print function dev_err()
Cc:     Abaci Robot <abaci@linux.alibaba.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20220809034346.128607-1-jiapeng.chong@linux.alibaba.com>
References: <20220809034346.128607-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Message-ID: <166125856489.401.13603202925739175296.tip-bot2@tip-bot2>
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

Commit-ID:     e920209847c396ca243259160b7d10d0dae17b35
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//e920209847c396ca243259160b7d10d0dae17b35
Author:        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
AuthorDate:    Tue, 09 Aug 2022 11:43:46 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 17 Aug 2022 14:09:39 +02:00

thermal/drivers/qcom/spmi-adc-tm5: Remove unnecessary print function dev_err()

The print function dev_err() is redundant because platform_get_irq()
already prints an error.

./drivers/thermal/qcom/qcom-spmi-adc-tm5.c:1029:2-9: line 1029 is redundant because platform_get_irq() already prints an error.

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=1846
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Link: https://lore.kernel.org/r/20220809034346.128607-1-jiapeng.chong@linux.alibaba.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/qcom/qcom-spmi-adc-tm5.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
index add6f40..af68adf 100644
--- a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
+++ b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
@@ -1025,10 +1025,8 @@ static int adc_tm5_probe(struct platform_device *pdev)
 	adc_tm->base = reg;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "get_irq failed: %d\n", irq);
+	if (irq < 0)
 		return irq;
-	}
 
 	ret = adc_tm5_get_dt_data(adc_tm, node);
 	if (ret) {
