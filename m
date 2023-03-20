Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2506C13C5
	for <lists+linux-pm@lfdr.de>; Mon, 20 Mar 2023 14:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbjCTNmu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Mar 2023 09:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbjCTNmd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Mar 2023 09:42:33 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBFFEF747
        for <linux-pm@vger.kernel.org>; Mon, 20 Mar 2023 06:42:31 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id w9so46947353edc.3
        for <linux-pm@vger.kernel.org>; Mon, 20 Mar 2023 06:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679319750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Htzjm9MSCo4/scEOmWkP20tbOGwc7n5xhdN8GyJQ6GQ=;
        b=bg8QBqEMCU2HBbMjnyK7G8pFNFhcaxlWlgPUkC1vmuTd98atUix3MIbBpG3lJAys+0
         2OxXvRg04f1/Y4Zw8e3Vi2GHv7C9QlOn47ZCDI6ypkC2t9j4c/68f5X7HfJigdkdE4rU
         i6r/7Cch0fOo1xTP21OktKc1Onawn+Hn4+yuBsrBwgR0h8M9V2FtKPI82e3hKXiBAOs3
         0pkDKbVru0PvsTBhhRiwHkOpn+cVCzsC1PdmFNoudWUAkN/Vby253U2/xMXn+Gzbg8yk
         ZxWg6fRkJz01IddW7B7uWGI0TLzKV5ppQJdre2FTgTZw29WSq37fGZgEi2MlHSxuctke
         Iqng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679319750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Htzjm9MSCo4/scEOmWkP20tbOGwc7n5xhdN8GyJQ6GQ=;
        b=5Ny2CHjUCosB96wK5KsUCiEGuVlXc5jcz7NGCg9u5pC8Sfw2r7jAhjCNty9CSgzuTV
         N1krSqXOV2FVxc5ek1PdL+OCUqCJEl32XIMA0zw7Z26XcJRGPYR6bgkNXtWb2ecEZeel
         OMjROwu2GJJ0lO5qXBiYAqUBUYuU0qBArb2f8moTNbpjJyEwuHnA+A7CEs1LIfxF2q1f
         BsRW+C53J5kXmlVedaPvVT6g/1Dv0Xl+IZEHxuzqaQ1XGnHAi/BsR9W/grzK/knF7Bm/
         qAKNHmbnBuJ9N9t7SbZT6vzR//X2F05knT5t3I6Wq9xzkomVaoi+pFur2QYPxEv321Ra
         yNQg==
X-Gm-Message-State: AO0yUKUtadw+v1UcRNBwI+473FEdbVQ11JSRMpilIRqX3Daf015izwx3
        f+60KWQ5WOL5h9jROFpBlC998w==
X-Google-Smtp-Source: AK7set8r62lDWNAku2VSCK32k/4YB9QoETXYmzVcob5j4AQs+mzZFX1MpD0qRD8dnoNReX8JRMdX/Q==
X-Received: by 2002:a17:906:13cb:b0:925:f542:1a3d with SMTP id g11-20020a17090613cb00b00925f5421a3dmr8999852ejc.25.1679319750345;
        Mon, 20 Mar 2023 06:42:30 -0700 (PDT)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id u23-20020a170906409700b009334a6ef3e8sm2368602ejj.141.2023.03.20.06.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 06:42:29 -0700 (PDT)
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
Subject: [RFC PATCH v2 4/5] clk: qcom: Add sync state callback to all SC8280XP providers
Date:   Mon, 20 Mar 2023 15:42:16 +0200
Message-Id: <20230320134217.1685781-5-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230320134217.1685781-1-abel.vesa@linaro.org>
References: <20230320134217.1685781-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index 167470beb369..a64c396b9cc4 100644
--- a/drivers/clk/qcom/dispcc-sc8280xp.c
+++ b/drivers/clk/qcom/dispcc-sc8280xp.c
@@ -3199,6 +3199,7 @@ static struct platform_driver disp_cc_sc8280xp_driver = {
 	.driver = {
 		.name = "disp_cc-sc8280xp",
 		.of_match_table = disp_cc_sc8280xp_match_table,
+		.sync_state = qcom_cc_sync_state,
 	},
 };
 
diff --git a/drivers/clk/qcom/gcc-sc8280xp.c b/drivers/clk/qcom/gcc-sc8280xp.c
index b3198784e1c3..64d828ba07da 100644
--- a/drivers/clk/qcom/gcc-sc8280xp.c
+++ b/drivers/clk/qcom/gcc-sc8280xp.c
@@ -7441,6 +7441,7 @@ static struct platform_driver gcc_sc8280xp_driver = {
 	.driver = {
 		.name = "gcc-sc8280xp",
 		.of_match_table = gcc_sc8280xp_match_table,
+		.sync_state = qcom_cc_sync_state,
 	},
 };
 
diff --git a/drivers/clk/qcom/gpucc-sc8280xp.c b/drivers/clk/qcom/gpucc-sc8280xp.c
index ea1e9505c335..46ca242ba427 100644
--- a/drivers/clk/qcom/gpucc-sc8280xp.c
+++ b/drivers/clk/qcom/gpucc-sc8280xp.c
@@ -453,6 +453,7 @@ static struct platform_driver gpu_cc_sc8280xp_driver = {
 	.driver = {
 		.name = "gpu_cc-sc8280xp",
 		.of_match_table = gpu_cc_sc8280xp_match_table,
+		.sync_state = qcom_cc_sync_state,
 	},
 };
 module_platform_driver(gpu_cc_sc8280xp_driver);
-- 
2.34.1

