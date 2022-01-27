Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1CD649EE9E
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jan 2022 00:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344697AbiA0XJL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Jan 2022 18:09:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344475AbiA0XIx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Jan 2022 18:08:53 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE10C061757
        for <linux-pm@vger.kernel.org>; Thu, 27 Jan 2022 15:08:52 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id i1so4185650pla.9
        for <linux-pm@vger.kernel.org>; Thu, 27 Jan 2022 15:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TgvyNELvg3Sp7eq/kP6ZXmVUFjIF8jXZbUQbHyXbYEA=;
        b=ksWYFpunD8F/POefDSacV+EHnA/Ob+b1C5cIWM4AR/RdicdiwkskZr6IkLTPvIAGlx
         jzRkBKTSZajM3cDG91qrW1bTBuFeklxmwp2NSoSV28l53EIxjzc01BDxznvW5DWUvycM
         r+wZn7zVndV2p4K+H9hIjyzSRx3eZWLf/U1Xc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TgvyNELvg3Sp7eq/kP6ZXmVUFjIF8jXZbUQbHyXbYEA=;
        b=Afs87RIUv/67bZoOC3vEi1uHhRu+xDYOAM6B7tDzrwcXHswfGCL9kvVoKMpcLVFd2g
         RCipzYEipl4dY857foMcyiEaFkuOtllTtIOU1dpIF1f9R4rKkwMHvf+pC8+bC6xdHFfC
         kSKFx0Jtmd+gDv4olx4h13FR+7djqJkx7ZYJ8fHzkh+VlPFvfuBbq3TMItRcaDbQdq30
         7NaG3toaKZSZ/QY/gboeM1RYu555FGEStffQ/jRas4ZyQzcmwgJohHtryt+JwajZYpFf
         6xLV56C42ZGAz3QkwgBh6lJHie90O+2XPeg6ObQd171ARoKp4IHoA30XRi9RKoZYrybM
         MRJQ==
X-Gm-Message-State: AOAM533nPMWz+xkfx2njRH9ItLnbjmX5bXBzvRH0Wx0iDzFkWd6q/mUt
        Gn08MODNSYJHwo4MXTGqQSHZlw==
X-Google-Smtp-Source: ABdhPJxGTgGsf17+kFpx/sl5BjhXHh6BcmwIuThMSQoz/ECA3RxkZOf4C40gfM6CZkmpTwdQkKj4Mw==
X-Received: by 2002:a17:902:c946:: with SMTP id i6mr5502608pla.74.1643324932282;
        Thu, 27 Jan 2022 15:08:52 -0800 (PST)
Received: from localhost ([2620:15c:202:201:723d:38a9:9e7f:3435])
        by smtp.gmail.com with UTF8SMTPSA id 5sm367869pjf.34.2022.01.27.15.08.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 15:08:51 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Lin Huang <hl@rock-chips.com>,
        linux-arm-kernel@lists.infradead.org,
        Derek Basehore <dbasehore@chromium.org>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2 14/15] PM / devfreq: rk3399_dmc: Use devm_pm_opp_of_add_table()
Date:   Thu, 27 Jan 2022 15:07:25 -0800
Message-Id: <20220127150615.v2.14.I3df48ceacbf299549501a44433039d46e0a275ea@changeid>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
In-Reply-To: <20220127230727.3369358-1-briannorris@chromium.org>
References: <20220127230727.3369358-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This simplifies error-cleanup and remove().

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

Changes in v2:
 - New patch

 drivers/devfreq/rk3399_dmc.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
index fca9fcbd4249..9615658d04ae 100644
--- a/drivers/devfreq/rk3399_dmc.c
+++ b/drivers/devfreq/rk3399_dmc.c
@@ -401,7 +401,7 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
 	 * We add a devfreq driver to our parent since it has a device tree node
 	 * with operating points.
 	 */
-	if (dev_pm_opp_of_add_table(dev)) {
+	if (devm_pm_opp_of_add_table(dev)) {
 		dev_err(dev, "Invalid operating-points in device tree.\n");
 		ret = -EINVAL;
 		goto err_edev;
@@ -415,7 +415,7 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
 	opp = devfreq_recommended_opp(dev, &data->rate, 0);
 	if (IS_ERR(opp)) {
 		ret = PTR_ERR(opp);
-		goto err_free_opp;
+		goto err_edev;
 	}
 
 	data->rate = dev_pm_opp_get_freq(opp);
@@ -430,7 +430,7 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
 					   &data->ondemand_data);
 	if (IS_ERR(data->devfreq)) {
 		ret = PTR_ERR(data->devfreq);
-		goto err_free_opp;
+		goto err_edev;
 	}
 
 	devm_devfreq_register_opp_notifier(dev, data->devfreq);
@@ -440,8 +440,6 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
 
 	return 0;
 
-err_free_opp:
-	dev_pm_opp_of_remove_table(&pdev->dev);
 err_edev:
 	devfreq_event_disable_edev(data->edev);
 
@@ -454,12 +452,6 @@ static int rk3399_dmcfreq_remove(struct platform_device *pdev)
 
 	devfreq_event_disable_edev(dmcfreq->edev);
 
-	/*
-	 * Before remove the opp table we need to unregister the opp notifier.
-	 */
-	devm_devfreq_unregister_opp_notifier(dmcfreq->dev, dmcfreq->devfreq);
-	dev_pm_opp_of_remove_table(dmcfreq->dev);
-
 	return 0;
 }
 
-- 
2.35.0.rc0.227.g00780c9af4-goog

