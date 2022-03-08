Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA114D0CA4
	for <lists+linux-pm@lfdr.de>; Tue,  8 Mar 2022 01:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbiCHALo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Mar 2022 19:11:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344083AbiCHALj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Mar 2022 19:11:39 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E079377FD
        for <linux-pm@vger.kernel.org>; Mon,  7 Mar 2022 16:10:37 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id n15so5531837plh.2
        for <linux-pm@vger.kernel.org>; Mon, 07 Mar 2022 16:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3vcQ7E3QlJ5EMbZ1LFMqprOJOYHlzqtxgL896kYiqOo=;
        b=iYeKTGT4dlyZ/4cNXE6cfNS9XrK9+jF+QC2NeyIzykXCNsGl3wNW47bpL5UUCEoJ7P
         xpuZm4eeGE0nwrgiheytLeqFqVXXoveIvwCNOAyEyRoygFWlx8Y6M5txM4ctoJlTuc+d
         eWGi3Sq2FexM2KHNohtPvHfVCCTq0KYB6fX8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3vcQ7E3QlJ5EMbZ1LFMqprOJOYHlzqtxgL896kYiqOo=;
        b=bg+E1SJXVZ+7R4NiT/wQn4aU2jALXJZSVLOXGpQ6M2ATWlllynTxpCaODr1f5i1kdm
         eRMAfiV+c7Sys0RDCafZCnnIQR+CmEkRYPqXHpOZVEeFgzr6uU4q6KP8ke4A4qykhzEw
         r7ohMaEjCbWYBsEtHv32AZyAOepeXhiRxYjbhWQgiFw76eYkvLdHeVfbZTltFFFkseWc
         E80nSEM/bUetncrSikYdeuGdQmcI7Z3GFJAgsxAkdn8eUrjMFXcJjVHmUYA0WNCUOm3/
         spLMmFJcerye+TCUQufbMyk9zd8zTGT+jTgXfBDcPaG/IRqIzJ9Pb09rxrhNmZ2QpPV2
         ABKQ==
X-Gm-Message-State: AOAM533E9FuPk5DrlEd0uFE23xfJcUkcJi+xIGG/E553Z5+kclDH5eWV
        OJyFxKGfr1dqADSdGTSnOgOCrg==
X-Google-Smtp-Source: ABdhPJz1pr5t9xbmu7C/GASb4Drasky8f6mYutfdkoI2dep7+myru1QSijt9H+r6gLIYzInYwl9ZEw==
X-Received: by 2002:a17:90b:4f92:b0:1bf:25e2:f6af with SMTP id qe18-20020a17090b4f9200b001bf25e2f6afmr1687730pjb.98.1646698237105;
        Mon, 07 Mar 2022 16:10:37 -0800 (PST)
Received: from localhost ([2620:15c:202:201:e551:44dc:2842:57f1])
        by smtp.gmail.com with UTF8SMTPSA id c30-20020a63725e000000b0037c8bf5b630sm10695427pgn.12.2022.03.07.16.10.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 16:10:36 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Lin Huang <hl@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
        Derek Basehore <dbasehore@chromium.org>,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH v3 14/15] PM / devfreq: rk3399_dmc: Use devm_pm_opp_of_add_table()
Date:   Mon,  7 Mar 2022 16:09:44 -0800
Message-Id: <20220307160918.v3.14.I3df48ceacbf299549501a44433039d46e0a275ea@changeid>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
In-Reply-To: <20220308000945.706701-1-briannorris@chromium.org>
References: <20220308000945.706701-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This simplifies error-cleanup and remove().

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

(no changes since v2)

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
2.35.1.616.g0bdcbb4464-goog

