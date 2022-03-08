Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A1A4D2121
	for <lists+linux-pm@lfdr.de>; Tue,  8 Mar 2022 20:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350067AbiCHTL1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Mar 2022 14:11:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350041AbiCHTLH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Mar 2022 14:11:07 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E55356223
        for <linux-pm@vger.kernel.org>; Tue,  8 Mar 2022 11:09:51 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id m2so12138pll.0
        for <linux-pm@vger.kernel.org>; Tue, 08 Mar 2022 11:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ExeMvBUYf18gUbw3oNoBhQIqfKznu+dtCvkD2ZUwMDI=;
        b=ib6FySm/SIILussMyTK7iihJLMt8Z1en8slTwlrFY5+R7JaTUXQp9kyMH9l8rQzknO
         em20DU9AF9v5Tq9pS2VCCi+eMzdQAtqCXv5+LQSGxEgZsykZLTjntKZ+bWUTwJj7eMqp
         yne0N1Zo66kQ5sLI0k1LFhdoc/452HkjAHras=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ExeMvBUYf18gUbw3oNoBhQIqfKznu+dtCvkD2ZUwMDI=;
        b=x3LJQ96AmCp7qCgJZyYnXpp6ja0vOuR5lCKahS7YlbFSf4+cpwB6XTYSS9LRIGtU00
         Ssca0u1X38Nh5DyJpepWQU3bfDaMiUpH6Zl7eoitNMrXdQMShO1YUiizggUU2NbKri0B
         L4brD/sDl3SNMjnbSgiSe3BKc2+KinRlnlJ9XK32XTds0Y6q8dubnXzJH96XhqXj7Jj2
         Y76K1xFC7NGnq4RRi1PcY0zJ74Eudcar9+d9GG+pX82CM6J63O9jW/yJ4rXeqJFWj/q6
         A97ykpHoviAjGTAN29VidPtseLdmwqj/Vi64m9a5UYNbN52PUM/SFDJww5t1MMURHxte
         mDtg==
X-Gm-Message-State: AOAM530AgNRj9ENf2GaQ6HDEmWw4pbpdu3wKLvYm/llTp60MRq9UXe/5
        fA10BuwbCU5+XAP5fnp5Jmseuw==
X-Google-Smtp-Source: ABdhPJy2AstUgBchjh7EwV+wcmMkcQM+A0fg1kljv5PG4sghXwqZVBUofbggon0HsXXkeiKY53yCJw==
X-Received: by 2002:a17:902:b945:b0:14f:f05e:5479 with SMTP id h5-20020a170902b94500b0014ff05e5479mr19169202pls.94.1646766591062;
        Tue, 08 Mar 2022 11:09:51 -0800 (PST)
Received: from localhost ([2620:15c:202:201:b3e3:a188:cbfc:3a0e])
        by smtp.gmail.com with UTF8SMTPSA id z13-20020a63e10d000000b003733d6c90e4sm15339293pgh.82.2022.03.08.11.09.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 11:09:50 -0800 (PST)
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
Subject: [PATCH v4 15/15] PM / devfreq: rk3399_dmc: Avoid static (reused) profile
Date:   Tue,  8 Mar 2022 11:09:01 -0800
Message-Id: <20220308110825.v4.15.I8d71e9555aca1fa7e532d22dd1ef27976f21799d@changeid>
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

This static struct can get reused if the device gets removed/reprobed,
and that causes use-after-free in its ->freq_table.

Let's just move the struct to our dynamic allocation.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

(no changes since v2)

Changes in v2:
 * New patch

 drivers/devfreq/rk3399_dmc.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
index 9615658d04ae..e494d1497d60 100644
--- a/drivers/devfreq/rk3399_dmc.c
+++ b/drivers/devfreq/rk3399_dmc.c
@@ -38,6 +38,7 @@
 struct rk3399_dmcfreq {
 	struct device *dev;
 	struct devfreq *devfreq;
+	struct devfreq_dev_profile profile;
 	struct devfreq_simple_ondemand_data ondemand_data;
 	struct clk *dmc_clk;
 	struct devfreq_event_dev *edev;
@@ -228,13 +229,6 @@ static int rk3399_dmcfreq_get_cur_freq(struct device *dev, unsigned long *freq)
 	return 0;
 }
 
-static struct devfreq_dev_profile rk3399_devfreq_dmc_profile = {
-	.polling_ms	= 200,
-	.target		= rk3399_dmcfreq_target,
-	.get_dev_status	= rk3399_dmcfreq_get_dev_status,
-	.get_cur_freq	= rk3399_dmcfreq_get_cur_freq,
-};
-
 static __maybe_unused int rk3399_dmcfreq_suspend(struct device *dev)
 {
 	struct rk3399_dmcfreq *dmcfreq = dev_get_drvdata(dev);
@@ -422,10 +416,16 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
 	data->volt = dev_pm_opp_get_voltage(opp);
 	dev_pm_opp_put(opp);
 
-	rk3399_devfreq_dmc_profile.initial_freq = data->rate;
+	data->profile = (struct devfreq_dev_profile) {
+		.polling_ms	= 200,
+		.target		= rk3399_dmcfreq_target,
+		.get_dev_status	= rk3399_dmcfreq_get_dev_status,
+		.get_cur_freq	= rk3399_dmcfreq_get_cur_freq,
+		.initial_freq	= data->rate,
+	};
 
 	data->devfreq = devm_devfreq_add_device(dev,
-					   &rk3399_devfreq_dmc_profile,
+					   &data->profile,
 					   DEVFREQ_GOV_SIMPLE_ONDEMAND,
 					   &data->ondemand_data);
 	if (IS_ERR(data->devfreq)) {
-- 
2.35.1.616.g0bdcbb4464-goog

