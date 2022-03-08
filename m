Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 401824D2127
	for <lists+linux-pm@lfdr.de>; Tue,  8 Mar 2022 20:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238078AbiCHTLf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Mar 2022 14:11:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350037AbiCHTLG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Mar 2022 14:11:06 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C33B4AE25
        for <linux-pm@vger.kernel.org>; Tue,  8 Mar 2022 11:09:49 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id v4so220781pjh.2
        for <linux-pm@vger.kernel.org>; Tue, 08 Mar 2022 11:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3vcQ7E3QlJ5EMbZ1LFMqprOJOYHlzqtxgL896kYiqOo=;
        b=cC8dBqHfPkF5HKHeDhMknhDRfgstZiTS1u1yK5S3G3C6N0fiGTUxyYIQ7C7knE7yul
         lXJoiicgFcctg65I1e/izXC41nZ72yeoiJOY6b/PtDjW/Fvcxh8n+AFIrecGK7QP0rfm
         62TUbwp+3VeVnkaYdDFcz8OKq0TwTfLdwT9PQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3vcQ7E3QlJ5EMbZ1LFMqprOJOYHlzqtxgL896kYiqOo=;
        b=ooI5+JdPygpBPAd52WFlneGNGs2wWUjlcQNhGbXH1MZdmrBR1qFx9Di2MPTkv4bGtn
         tgEolQJLRkfVE27zNMRWk4FOAbfN/kZk3v6rFOLSvSIb5E8iHwWIPJTxnFqK4mFc1D7w
         srXEiWj/q7QvIz+/j3HPThhXIHJbxrEu3IH9gKx+YNBsyWIZChwrMi0bCCcooKhtJv5O
         2+l/mVO2gKS2Tfje4LvlZQ+oI/CxV8jtNYm/c+98GAYQ8t0MFcNxDU7KDCUPhMLDmMnW
         CjY09VNvhP6ylFCl4p41JV8EXYxH2HOr5BeyK1drU1mYHf8ew7IKifsbuHbI2CxpbgyQ
         kEwQ==
X-Gm-Message-State: AOAM531/3nX1vef0R1psO4Fea7zZkmUgTXomGA9rL6SKySInoyQ9Mf8T
        u+4+4FaKuZnE667X9m0HX7QFFQ==
X-Google-Smtp-Source: ABdhPJzuHLhnsJe7gqPUU3F8/rKTzM5Cz8MQmvX+D9Q23OR5/GSYX3B2XbcEjamJWu7JKVbRlxWzJQ==
X-Received: by 2002:a17:90b:3b92:b0:1bf:a61b:742b with SMTP id pc18-20020a17090b3b9200b001bfa61b742bmr662827pjb.157.1646766588724;
        Tue, 08 Mar 2022 11:09:48 -0800 (PST)
Received: from localhost ([2620:15c:202:201:b3e3:a188:cbfc:3a0e])
        by smtp.gmail.com with UTF8SMTPSA id f18-20020a056a001ad200b004bf321765dfsm21125042pfv.95.2022.03.08.11.09.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 11:09:48 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Derek Basehore <dbasehore@chromium.org>,
        devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, Lin Huang <hl@rock-chips.com>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH v4 14/15] PM / devfreq: rk3399_dmc: Use devm_pm_opp_of_add_table()
Date:   Tue,  8 Mar 2022 11:09:00 -0800
Message-Id: <20220308110825.v4.14.I3df48ceacbf299549501a44433039d46e0a275ea@changeid>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
In-Reply-To: <20220308190901.3144566-1-briannorris@chromium.org>
References: <20220308190901.3144566-1-briannorris@chromium.org>
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

