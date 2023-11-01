Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C770C7DDE0B
	for <lists+linux-pm@lfdr.de>; Wed,  1 Nov 2023 10:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234309AbjKAJEl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Nov 2023 05:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233710AbjKAJEh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Nov 2023 05:04:37 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5086A127
        for <linux-pm@vger.kernel.org>; Wed,  1 Nov 2023 02:04:30 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9c2a0725825so1033097566b.2
        for <linux-pm@vger.kernel.org>; Wed, 01 Nov 2023 02:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698829469; x=1699434269; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0LdBd+eSnqsjZMHB05XZWoWkNDVuurU7hslZrFc0/dQ=;
        b=HU9+MlTL7XIYt1jMX6Jj9aqoaQfTtzufV5g+cW2kD6R8mygnrHzexjTbgwrbFKC27Z
         YKRtHb0ROQGIx9cMmClWdC1HyxYHVLwbE0i4XPLHEOyQBB6yr4VvTuAEogVQ0CT9veW6
         DE/Rmaqc2ftYUE9RWcyiqdBD1yfPdR9hMQT5qYd1Dbd6E8ybhhkXCg2Gcc+nkIawrA32
         fDfkz77JghblFOOt7Z/ENe1QAd7MCIXxH3bqtt4K1O4H18aTMADf3p3WnCOFrBISDnTR
         mdS8Qcwj2u8nxFksCi7mtGfpiYvacpn3Q0xSVpjSbBz3c22E8TEueMA0GZpXOQLBdM5Z
         0rTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698829469; x=1699434269;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0LdBd+eSnqsjZMHB05XZWoWkNDVuurU7hslZrFc0/dQ=;
        b=FAxfuYMrJ4fTstpYVGKcsrtSv8PUdNANSJ5eaaHwudU+/mNVSqRBDBEuwxCEX0jZ7v
         hgchHRFtga7GpNAqFrnHE4Me66NucOzk5H7kDB7dQUx8bniATYCRfRIpaVqEVujqD/UI
         QlS4DZZgmGfVwr1QcSjluwnPWXfvzodpvOdFO2J+iU/NhQcLdEopgDeyxMMbO0XzOWQH
         Huw3d5NJEo3OEp3xtuvffR5sIJ/W3ikY6pTEKWbYsNwEUyEiL3L5voQgFnJxjsiJG0B5
         qpA9NOqCKrwtou2Br0nGN0YUjD0U9BkJoIvhTTnl5n6awLiY0/sfFz3opgGcq26BJWGv
         tgxw==
X-Gm-Message-State: AOJu0Yzf1/pnFTsx7GPiFbQ5ellr1P594eJifvidh9zQcOs2JKfmIWqo
        w6bG7WvV9Yge5jPXYeymC4ACOw==
X-Google-Smtp-Source: AGHT+IF8owVHGEBYAi/7+QKh88vTO7EdewkA8H8mX7gh6BGKujrT9cpDZHc4ytF0Nll9lRzquKUD7w==
X-Received: by 2002:a17:907:2d0d:b0:9ce:ed5:d902 with SMTP id gs13-20020a1709072d0d00b009ce0ed5d902mr1391857ejc.1.1698829468845;
        Wed, 01 Nov 2023 02:04:28 -0700 (PDT)
Received: from [127.0.1.1] ([86.122.213.220])
        by smtp.gmail.com with ESMTPSA id l25-20020a170906a41900b0099cd1c0cb21sm2152781ejz.129.2023.11.01.02.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 02:04:28 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
Date:   Wed, 01 Nov 2023 11:04:10 +0200
Subject: [PATCH RESEND v3 4/5] clk: qcom: Use HW_CTRL_TRIGGER flag to
 switch video GDSC to HW mode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231101-gdsc-hwctrl-v3-4-0740ae6b2b04@linaro.org>
References: <20231101-gdsc-hwctrl-v3-0-0740ae6b2b04@linaro.org>
In-Reply-To: <20231101-gdsc-hwctrl-v3-0-0740ae6b2b04@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Taniya Das <tdas@qti.qualcomm.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-media@vger.kernel.org,
        Abel Vesa <abel.vesa@linaro.org>,
        Jagadeesh Kona <quic_jkona@quicinc.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3732; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=a+7KMvY2f76KyNp4mawcxB7T/y6S1n2568EVeOXgKHE=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlQhSRv/eJjEx7V98Pf4qxr0viFw+ahCnxI2vjn
 ZXHTuRS+dWJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZUIUkQAKCRAbX0TJAJUV
 VrvJEAC3Y/UOKnQdDm03urqvZd6i7dIkQVdf7zJeqDhplplom/lSHjGiadPWyQVEvkWYMaSrIcc
 Qs/2FD3IXwKn0qmrihldBtoqDzP5nqVYmHRVMexrflE7MP+yuLBZxr6gpFe+4UfsuH++QbQlxG0
 2XIynWe/Jhu5f0NqnrkSEb2XuuJj2PYcdSXGurl3uuO5pgZ1ThzYu2/JEzAKEt2MN1yuqIndfYU
 wYyI8KMuVrUZ3qmpcVQN8tP6NpXOj8iv1avzsMjagd2I6ghFYuNCz4QYmfiC72YRkYJhFunMkAc
 ALZvuTH07XutA7byhYgxf15NxycvWRDmkzVWZ/pTb5YZ1D8Ojz+dqKhPEDQlGSOojFZqKEzffKV
 aav+ZKEYpzqi7YIJPvnzIQM8xd22L8+bv5BL+REJ0g7FlqFzT59oXQt6VIlgkIrfrg5BK9ikSII
 M8pErfVuf3g0jaxlPo7w11/aSmu3RilYrt6Bp/9Ho6piNEBrEcYQBOTxLBK++HOtZDuo8qr8/LL
 L1slJtZsN3W5LZ5XPru+P/t7898gkvCnegNjoEHL+l7DECuwkRR3nT45btd9RQW/2/TH0qHWQHd
 mwud6QwyMJi9oBdFQvBV9gL4yFg3jRyBpMmlStqMCXN8qkUypxYM6Teh2p7QpbxFyUvtLcelvAQ
 +PBB8BzkQFtpOsg==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Jagadeesh Kona <quic_jkona@quicinc.com>

The current HW_CTRL flag switches the video GDSC to HW control mode as
part of GDSC enable itself, instead of that use HW_CTRL_TRIGGER flag to
give consumer drivers more control and switch the GDSC mode as and when
required.

HW_CTRL_TRIGGER flag allows consumer drivers to switch the video GDSC to
HW/SW control modes at runtime using dev_pm_genpd_set_hwmode API.

Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/clk/qcom/videocc-sc7180.c | 2 +-
 drivers/clk/qcom/videocc-sc7280.c | 2 +-
 drivers/clk/qcom/videocc-sdm845.c | 4 ++--
 drivers/clk/qcom/videocc-sm8250.c | 4 ++--
 drivers/clk/qcom/videocc-sm8550.c | 4 ++--
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/qcom/videocc-sc7180.c b/drivers/clk/qcom/videocc-sc7180.c
index 5b9b54f616b8..51439f7ba70c 100644
--- a/drivers/clk/qcom/videocc-sc7180.c
+++ b/drivers/clk/qcom/videocc-sc7180.c
@@ -166,7 +166,7 @@ static struct gdsc vcodec0_gdsc = {
 	.pd = {
 		.name = "vcodec0_gdsc",
 	},
-	.flags = HW_CTRL,
+	.flags = HW_CTRL_TRIGGER,
 	.pwrsts = PWRSTS_OFF_ON,
 };
 
diff --git a/drivers/clk/qcom/videocc-sc7280.c b/drivers/clk/qcom/videocc-sc7280.c
index 615695d82319..3d07b1e95986 100644
--- a/drivers/clk/qcom/videocc-sc7280.c
+++ b/drivers/clk/qcom/videocc-sc7280.c
@@ -236,7 +236,7 @@ static struct gdsc mvs0_gdsc = {
 		.name = "mvs0_gdsc",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
-	.flags = HW_CTRL | RETAIN_FF_ENABLE,
+	.flags = HW_CTRL_TRIGGER | RETAIN_FF_ENABLE,
 };
 
 static struct gdsc mvsc_gdsc = {
diff --git a/drivers/clk/qcom/videocc-sdm845.c b/drivers/clk/qcom/videocc-sdm845.c
index c77a4dd5d39c..dad011c48973 100644
--- a/drivers/clk/qcom/videocc-sdm845.c
+++ b/drivers/clk/qcom/videocc-sdm845.c
@@ -260,7 +260,7 @@ static struct gdsc vcodec0_gdsc = {
 	},
 	.cxcs = (unsigned int []){ 0x890, 0x930 },
 	.cxc_count = 2,
-	.flags = HW_CTRL | POLL_CFG_GDSCR,
+	.flags = HW_CTRL_TRIGGER | POLL_CFG_GDSCR,
 	.pwrsts = PWRSTS_OFF_ON,
 };
 
@@ -271,7 +271,7 @@ static struct gdsc vcodec1_gdsc = {
 	},
 	.cxcs = (unsigned int []){ 0x8d0, 0x950 },
 	.cxc_count = 2,
-	.flags = HW_CTRL | POLL_CFG_GDSCR,
+	.flags = HW_CTRL_TRIGGER | POLL_CFG_GDSCR,
 	.pwrsts = PWRSTS_OFF_ON,
 };
 
diff --git a/drivers/clk/qcom/videocc-sm8250.c b/drivers/clk/qcom/videocc-sm8250.c
index ad46c4014a40..c1b73d852f1c 100644
--- a/drivers/clk/qcom/videocc-sm8250.c
+++ b/drivers/clk/qcom/videocc-sm8250.c
@@ -293,7 +293,7 @@ static struct gdsc mvs0_gdsc = {
 	.pd = {
 		.name = "mvs0_gdsc",
 	},
-	.flags = HW_CTRL,
+	.flags = HW_CTRL_TRIGGER,
 	.pwrsts = PWRSTS_OFF_ON,
 };
 
@@ -302,7 +302,7 @@ static struct gdsc mvs1_gdsc = {
 	.pd = {
 		.name = "mvs1_gdsc",
 	},
-	.flags = HW_CTRL,
+	.flags = HW_CTRL_TRIGGER,
 	.pwrsts = PWRSTS_OFF_ON,
 };
 
diff --git a/drivers/clk/qcom/videocc-sm8550.c b/drivers/clk/qcom/videocc-sm8550.c
index f3c9dfaee968..404c6600edae 100644
--- a/drivers/clk/qcom/videocc-sm8550.c
+++ b/drivers/clk/qcom/videocc-sm8550.c
@@ -322,7 +322,7 @@ static struct gdsc video_cc_mvs0_gdsc = {
 	},
 	.pwrsts = PWRSTS_OFF_ON,
 	.parent = &video_cc_mvs0c_gdsc.pd,
-	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE | HW_CTRL,
+	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE | HW_CTRL_TRIGGER,
 };
 
 static struct gdsc video_cc_mvs1c_gdsc = {
@@ -347,7 +347,7 @@ static struct gdsc video_cc_mvs1_gdsc = {
 	},
 	.pwrsts = PWRSTS_OFF_ON,
 	.parent = &video_cc_mvs1c_gdsc.pd,
-	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE | HW_CTRL,
+	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE | HW_CTRL_TRIGGER,
 };
 
 static struct clk_regmap *video_cc_sm8550_clocks[] = {

-- 
2.34.1

