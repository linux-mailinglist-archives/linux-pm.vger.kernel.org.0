Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC119616504
	for <lists+linux-pm@lfdr.de>; Wed,  2 Nov 2022 15:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbiKBOWc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Nov 2022 10:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbiKBOV5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Nov 2022 10:21:57 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55CA41F613
        for <linux-pm@vger.kernel.org>; Wed,  2 Nov 2022 07:21:56 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d24so16727570pls.4
        for <linux-pm@vger.kernel.org>; Wed, 02 Nov 2022 07:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c/pMCaexTxPLJj78ppz2hR1Nnq2hMOxwXWSwZaAwP1o=;
        b=v2KPaSNwlUsp7p+WI5eQrzk4CxEQ6P+VRict3TlT67cdkOV/KtVsTQn1bBV14Y2xFO
         M8iBDtfXrhY2DbRs3tQQNOkLjkdUY82UJJqDY+Yl/unoGbQJNfn398w3vhZPkbwkrS2h
         5JC21Q1z1i3DqZn9MSKDNQEhrzRa0DvrsJKeuxCwN4H0Za6QySEnjA90r53MOB9JEY0w
         UMISsBQmaJHGYYCzVoSXOGHlHeaahNz1VAxpoL4LfN/bcaTQ3gGtzt0fqqGW183CHhjC
         w1FSWrIobeM+RnDn2GHoAUhyA07K5CPRng9lsDQuK1MpgoOo3DiUlY/lSh6Ke8Q6EUv7
         o7jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c/pMCaexTxPLJj78ppz2hR1Nnq2hMOxwXWSwZaAwP1o=;
        b=PVYAJsGpErdEUqXoGH2fJ87JLnKePgVyMdnWfR3gLfAu9Wj1nLUOuo31AaAsaf7fUD
         DpQDgNQ5Td0yJoe4gU/Xw64R9QV/iH/I2gbnyWonqcR0/Xj2vydbPOSrP+CtYYiAZUpj
         dsdtEP/IPep9X4wNoYEvMue3HQPY0Wz3FnlVxwfBIL0PpAqRK7+N3Q35twhxgy3OVJAq
         ZPK8RYIW9GcEGRCF9jP5RfYASAiHuprJFrJiF2L6UdTdDU5vvcy96j5GKVcYkMoRRX7x
         Kg/eR4WhaMuBZ97qMBp5dKmn5IlpWHpoJDZcVcPx/5O38Zy98prTtk3sMH94nIj0nlJT
         sezQ==
X-Gm-Message-State: ACrzQf04IgcfXwRaEBztXou3/RIyMT7sAj/Y1jaDvRNZnInfJEmKk3ty
        Nc1EiQZoeUhTShzDy6iankoxYw==
X-Google-Smtp-Source: AMsMyM4qK/lnzUIzNqln7RZX8vMCbyXMe2wNHwxwm70Vj3P2QkQS7yGpFjKhbkoOYB6isVoY+KTCpA==
X-Received: by 2002:a17:903:11c4:b0:178:634b:1485 with SMTP id q4-20020a17090311c400b00178634b1485mr24234234plh.142.1667398915892;
        Wed, 02 Nov 2022 07:21:55 -0700 (PDT)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id o28-20020aa7979c000000b0056b8181861esm8817773pfp.19.2022.11.02.07.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 07:21:55 -0700 (PDT)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v3 4/4] PM: domains: Power off[on] domain in hibernate .freeze[thaw]_noirq hook
Date:   Wed,  2 Nov 2022 22:21:04 +0800
Message-Id: <20221102142104.2006554-5-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221102142104.2006554-1-shawn.guo@linaro.org>
References: <20221102142104.2006554-1-shawn.guo@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On platforms which use SHUTDOWN as hibernation mode, the genpd noirq
hooks will be called like below.

    genpd_freeze_noirq()         genpd_restore_noirq()
          ↓                            ↑
    Create snapshot image        Restore target kernel
          ↓                            ↑
    genpd_thaw_noirq()           genpd_freeze_noirq()
          ↓                            ↑
    Write snapshot image         Read snapshot image
          ↓                            ↑
    power_down()                 Kernel boot

As of today suspend hooks genpd_suspend[resume]_noirq() manages domain
on/off state, but hibernate hooks genpd_freeze[thaw]_noirq() doesn't.
This results in a different behavior of domain power state between suspend
and hibernate freeze, i.e. domain is powered off for the former while on
for the later.  It causes a problem on platforms like i.MX where the
domain needs to be powered on/off by calling clock and regulator interface.
When the platform restores from hibernation, the domain is off in hardware
and genpd_restore_noirq() tries to power it on, but will never succeed
because software state of domain (clock and regulator) is left on from the
last hibernate freeze, so kernel thinks that clock and regulator are
enabled while they are actually not turned on in hardware.  The
consequence would be that devices in the power domain will access
registers without clock or power, and cause hardware lockup.

Power off[on] domain in hibernate .freeze[thaw]_noirq hook for reasons:

- Align the behavior between suspend and hibernate freeze.
- Have power state of domains stay in sync between hardware and software
  for hibernate freeze, and thus fix the lockup issue seen on i.MX
  platform.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 35 ++++-------------------------------
 1 file changed, 4 insertions(+), 31 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 7cee9439fd21..2f0787d5101b 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1307,24 +1307,11 @@ static int genpd_resume_noirq(struct device *dev)
  */
 static int genpd_freeze_noirq(struct device *dev)
 {
-	const struct generic_pm_domain *genpd;
-	int ret = 0;
-
 	dev_dbg(dev, "%s()\n", __func__);
 
-	genpd = dev_to_genpd(dev);
-	if (IS_ERR(genpd))
-		return -EINVAL;
-
-	ret = pm_generic_freeze_noirq(dev);
-	if (ret)
-		return ret;
-
-	if (genpd->dev_ops.stop && genpd->dev_ops.start &&
-	    !pm_runtime_status_suspended(dev))
-		ret = genpd_stop_dev(genpd, dev);
-
-	return ret;
+	return genpd_finish_suspend(dev,
+				    pm_generic_freeze_noirq,
+				    pm_generic_thaw_noirq);
 }
 
 /**
@@ -1336,23 +1323,9 @@ static int genpd_freeze_noirq(struct device *dev)
  */
 static int genpd_thaw_noirq(struct device *dev)
 {
-	const struct generic_pm_domain *genpd;
-	int ret = 0;
-
 	dev_dbg(dev, "%s()\n", __func__);
 
-	genpd = dev_to_genpd(dev);
-	if (IS_ERR(genpd))
-		return -EINVAL;
-
-	if (genpd->dev_ops.stop && genpd->dev_ops.start &&
-	    !pm_runtime_status_suspended(dev)) {
-		ret = genpd_start_dev(genpd, dev);
-		if (ret)
-			return ret;
-	}
-
-	return pm_generic_thaw_noirq(dev);
+	return genpd_finish_resume(dev, pm_generic_thaw_noirq);
 }
 
 /**
-- 
2.25.1

