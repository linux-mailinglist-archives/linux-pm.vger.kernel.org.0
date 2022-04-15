Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 712E0501FE0
	for <lists+linux-pm@lfdr.de>; Fri, 15 Apr 2022 02:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348290AbiDOBA7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Apr 2022 21:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348276AbiDOBA6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Apr 2022 21:00:58 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6175DB91B3
        for <linux-pm@vger.kernel.org>; Thu, 14 Apr 2022 17:58:32 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id k29so6159785pgm.12
        for <linux-pm@vger.kernel.org>; Thu, 14 Apr 2022 17:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hyPhXVFORyR7RHJurDudy51Y1BldxtR7Rr+Twqx8qq0=;
        b=UpGObQNJ7gxLnU45LjZFNpQNS19zh2dUmTNqqp7/RSYHnEnJJmqzaK/SFmjJkVcbMJ
         W8y4i2Ao0kZwQervAt6GTx7JNntpSbrJlTytQlb2tLhHP6BOAlATLy0QQoZNYWbZgLit
         yh71YPJ4APLS2/q9F6MaBZgCgGNc3J48TFOHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hyPhXVFORyR7RHJurDudy51Y1BldxtR7Rr+Twqx8qq0=;
        b=CChNCZOIHjSd+Yk6mMPLllXM2xZgJgOw5snyCWZnxcKe7v/B04+fx+gEZ56P6q0kdG
         W+phBNJEvV6iN8zYkkPt6gILRyisnFb9XAI0vUpc7ozQtqTXlmwMOVC721wqzSsnjo/C
         3Jh7g6NHyGZ/CQ5Q4TK90XwVnQxiLELdFwIKrvOJW4GhD1IkftHhhIadYtzItK45n/QH
         O8BB9RPkZSLmhh02qM2/detxYbSvUJGHj4onnR2tD5LLqrYtKdo395HGXEhzOcjgAJYh
         aPBEtMqtlvrKeArz6vMD+0Rrc5VtPc6tY/FP0CiB2WA1Drli01bfNNJmoLHseaXeN77v
         +lOA==
X-Gm-Message-State: AOAM530A/IXL3FYNoJBD2eqacWuE2KOrX2LmZdROBmQF7CND4m6akKMM
        q81HHZ4cOShZA7Y2ECPm5unihzqpKz5DOg==
X-Google-Smtp-Source: ABdhPJy8+lgOWC71xrEtCZKaYKOnrR2EXDQ6cNqAcqir/M+theLFdeFia3l5g/9/zMa7vy7Rxmj4BA==
X-Received: by 2002:a05:6a00:1a0a:b0:4fc:d6c5:f3f1 with SMTP id g10-20020a056a001a0a00b004fcd6c5f3f1mr6479101pfv.45.1649984311767;
        Thu, 14 Apr 2022 17:58:31 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:e3e0:734:f81a:d2c1])
        by smtp.gmail.com with ESMTPSA id f4-20020aa79d84000000b00505f920ffb8sm996704pfq.179.2022.04.14.17.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 17:58:31 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>,
        Alex Elder <elder@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Mike Tipton <quic_mdtipton@quicinc.com>,
        Georgi Djakov <djakov@kernel.org>
Subject: [PATCH 4/2] ARM: dts: qcom: sdx55: Remove ipa interconnect node
Date:   Thu, 14 Apr 2022 17:58:27 -0700
Message-Id: <20220415005828.1980055-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
In-Reply-To: <20220415005828.1980055-1-swboyd@chromium.org>
References: <20220412220033.1273607-1-swboyd@chromium.org>
 <20220415005828.1980055-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This device node is unused now that we've removed the driver that
consumed it in the kernel. Drop the unused node to save some space.

Cc: Alex Elder <elder@linaro.org>
Cc: Taniya Das <quic_tdas@quicinc.com>
Cc: Mike Tipton <quic_mdtipton@quicinc.com>
Cc: Georgi Djakov <djakov@kernel.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 arch/arm/boot/dts/qcom-sdx55.dtsi | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom-sdx55.dtsi
index d455795da44c..f1e12a112cd0 100644
--- a/arch/arm/boot/dts/qcom-sdx55.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx55.dtsi
@@ -275,13 +275,6 @@ system_noc: interconnect@162c000 {
 			qcom,bcm-voters = <&apps_bcm_voter>;
 		};
 
-		ipa_virt: interconnect@1e00000 {
-			compatible = "qcom,sdx55-ipa-virt";
-			reg = <0x01e00000 0x100000>;
-			#interconnect-cells = <1>;
-			qcom,bcm-voters = <&apps_bcm_voter>;
-		};
-
 		qpic_bam: dma-controller@1b04000 {
 			compatible = "qcom,bam-v1.7.0";
 			reg = <0x01b04000 0x1c000>;
-- 
https://chromeos.dev

