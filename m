Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A68E6BB483
	for <lists+linux-pm@lfdr.de>; Wed, 15 Mar 2023 14:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbjCONXs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Mar 2023 09:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232093AbjCONXn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Mar 2023 09:23:43 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A078C26BD
        for <linux-pm@vger.kernel.org>; Wed, 15 Mar 2023 06:23:41 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id z21so10158069edb.4
        for <linux-pm@vger.kernel.org>; Wed, 15 Mar 2023 06:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678886621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z6Q5mnwZerUqt0rPDmFb5WgXIlQQvBuhlqFXmv7x/E8=;
        b=v8CeUBfci+2vyzQEs4Rv2vSs3xgOflEwBGX290bxPufp8u8LNIOMlkwcnVzAd/JHTS
         fKtlg1yp861KIf8/L1MJwZILV+rQXo66j3Yxt9GK2ezkucnxv+S+0i/EnOuoYDUhJOV3
         B6JpC0fqm3lrN2erdD+046lrlomd/a16+nW2JchX0Jb24U9w1cd/ZJNtpLSUYRhQsIlu
         j0VP1QxVb20iygWUI9vh2kc1KeznBSrLdSCryvv3cS+hgbtWk5/gbaQj/AD3vNkuqYPU
         A/IWUl2UBUfC+Ob8tJcCN4OaDEuUsJbZqVAv+jnL6QKj1HEuwp2mjGfX7wCJLSZMrfzW
         EfjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678886621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z6Q5mnwZerUqt0rPDmFb5WgXIlQQvBuhlqFXmv7x/E8=;
        b=OZ5JbaswpC1vToTMRiH64M0xwknfzYWr3+8mAR3EeKZIJXQ6wgwKgzd61EXkUlR+lu
         bXmvfLwrdS5n8eZZ8RbdjW2ScjRWwT/gZGbweNL/plGgOp0+2AgoPd6+pdLY1g4jFXzw
         dK0FxAhf8eFQ5Kv3ypSzxrPi9CZlCNdHfcwj/92DzwnE8kfnc+DBxytdqXGoGQDlbxpD
         Y+a8mYO4zN8DAzpPJ3ELhWszzMQiyD+uHcVDamMW4ybEkwLGviYv5gJ897qd8bQqwCny
         2xX7l72q7m/FTTJvFunQ4TJgePAalP415ziSEGPQyN8l2OS9cvWm2qrdQR3ukJJJPxEk
         YQWQ==
X-Gm-Message-State: AO0yUKVufqgxc3Ibk4C6Xg0DzXeBWjS+YEp9u2qoBAoedktQb3Fx1wQ6
        KpEioco3bq4ySJ2d+bp2LW+84w==
X-Google-Smtp-Source: AK7set80lwILGeMEjE90/hXf2KxCex24k3hIxwK6a87YWNsiAs3RYf8jzg8Y/7RnlkbsWjydDWh7+g==
X-Received: by 2002:a17:907:7f8e:b0:92f:1418:27f0 with SMTP id qk14-20020a1709077f8e00b0092f141827f0mr2127459ejc.34.1678886620990;
        Wed, 15 Mar 2023 06:23:40 -0700 (PDT)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id pj18-20020a170906d79200b008b133f9b33dsm2497365ejb.169.2023.03.15.06.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 06:23:40 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Saravana Kannan <saravanak@google.com>
Cc:     linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [RFC PATCH 4/5] clk: qcom: Add sync state callback to all SC8280XP providers
Date:   Wed, 15 Mar 2023 15:23:29 +0200
Message-Id: <20230315132330.450877-5-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230315132330.450877-1-abel.vesa@linaro.org>
References: <20230315132330.450877-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Now that we have support for sync state delayed disabling of unused
power domains and a provided generic gdsc sync state callback, add it to
all the providers related to the SC8280XP platform.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/clk/qcom/dispcc-sc8280xp.c | 1 +
 drivers/clk/qcom/gcc-sc8280xp.c    | 1 +
 drivers/clk/qcom/gpucc-sc8280xp.c  | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/clk/qcom/dispcc-sc8280xp.c b/drivers/clk/qcom/dispcc-sc8280xp.c
index 167470beb369..f97bda6c7e3a 100644
--- a/drivers/clk/qcom/dispcc-sc8280xp.c
+++ b/drivers/clk/qcom/dispcc-sc8280xp.c
@@ -3199,6 +3199,7 @@ static struct platform_driver disp_cc_sc8280xp_driver = {
 	.driver = {
 		.name = "disp_cc-sc8280xp",
 		.of_match_table = disp_cc_sc8280xp_match_table,
+		.sync_state = gdsc_sync_state,
 	},
 };
 
diff --git a/drivers/clk/qcom/gcc-sc8280xp.c b/drivers/clk/qcom/gcc-sc8280xp.c
index b3198784e1c3..222bca0f8093 100644
--- a/drivers/clk/qcom/gcc-sc8280xp.c
+++ b/drivers/clk/qcom/gcc-sc8280xp.c
@@ -7441,6 +7441,7 @@ static struct platform_driver gcc_sc8280xp_driver = {
 	.driver = {
 		.name = "gcc-sc8280xp",
 		.of_match_table = gcc_sc8280xp_match_table,
+		.sync_state = gdsc_sync_state,
 	},
 };
 
diff --git a/drivers/clk/qcom/gpucc-sc8280xp.c b/drivers/clk/qcom/gpucc-sc8280xp.c
index ea1e9505c335..a9f0e7bbacce 100644
--- a/drivers/clk/qcom/gpucc-sc8280xp.c
+++ b/drivers/clk/qcom/gpucc-sc8280xp.c
@@ -453,6 +453,7 @@ static struct platform_driver gpu_cc_sc8280xp_driver = {
 	.driver = {
 		.name = "gpu_cc-sc8280xp",
 		.of_match_table = gpu_cc_sc8280xp_match_table,
+		.sync_state = gdsc_sync_state,
 	},
 };
 module_platform_driver(gpu_cc_sc8280xp_driver);
-- 
2.34.1

