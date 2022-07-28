Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68CCA583DB3
	for <lists+linux-pm@lfdr.de>; Thu, 28 Jul 2022 13:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236733AbiG1Lis (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Jul 2022 07:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237017AbiG1Li1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Jul 2022 07:38:27 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194FB68DD4
        for <linux-pm@vger.kernel.org>; Thu, 28 Jul 2022 04:38:09 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id bf9so2386056lfb.13
        for <linux-pm@vger.kernel.org>; Thu, 28 Jul 2022 04:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7WcyHHWIuXa8VBPBmhioGhUQ+Xl6g95Mz+t9tkKTCEE=;
        b=XXikpq4I/jW+AumV70eTCCV2Ptd5SsO9qHv6A7iZSY642uz4UUiHeNoXa2gawDIUzJ
         31q4HvbJggh03XUgtkoOORHYaMw5CegBW2yHLsebrPvU59gkc04uQvLo/v9nWVCdvAVw
         2I0v6Edzo0kV21nMh7FtpRmgxbLpEfoTzMo5sszqzaNCHdaGyOzMGZmXL568hxAiprDO
         M6LSNypKapgJOB1T9DhDQwfRCF/9jJDtedl1ySmgHTlE9tp1XNv7V4q8BEe9EfPV5l4W
         TtLTMnCS20lad85a827ns0XsxqvvsDPEf1dlbSewP4WHtiuHNyYz0pH4vQvpZgT+Bthj
         uvtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7WcyHHWIuXa8VBPBmhioGhUQ+Xl6g95Mz+t9tkKTCEE=;
        b=CXY33Hh9C88ArXaaJTbFbWkqRCZFBmBq8r5r5nyyw319p/h+4Bsjs9lupw3BHcxvpw
         bgimDWVdHx+Q7gzBb5R3xk4p2fVxOAHI/kOX+a/GGNbv861TutNqaEqabWEr6agfA67X
         70kmn0F9/WQIbj3qQ4Xo1LvgGwSXubJNBE6OlO5vLGDumm0l9BiV3HbuXAa9osJWI1L7
         teZ4Eph7hIV3V2gpccuTHT88GAbPXP8x9f4MFf9ZEXvkSV+5v+wVliLuDX+Uy5PbJkjI
         YaAW9ew48tSNNssXCzzoi4bPcGgro57bxouaJY2j2ELeUX1bASqaEe7dx0LSTp65ml1E
         U9Vg==
X-Gm-Message-State: AJIora+SrKKTfoxzNbUlJ/dIvrN3hfi4a0NzVd+fX+xWtDl9qzrs1jbY
        puzuNa5uSNNndIWqafxjDjz7n99XuEhYPg==
X-Google-Smtp-Source: AGRyM1uJfu0P2CdKUsT7ENojpTOjhC0cbukQWp9qJUtVrhWH1EkfyW9GtqdTSI08jIL1v+KwbDuvLw==
X-Received: by 2002:a05:6512:3d19:b0:48a:7d10:b972 with SMTP id d25-20020a0565123d1900b0048a7d10b972mr9786396lfv.615.1659008286924;
        Thu, 28 Jul 2022 04:38:06 -0700 (PDT)
Received: from krzk-bin.lan (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id l12-20020a2ea80c000000b0025e0396786dsm98192ljq.93.2022.07.28.04.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 04:38:06 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rajendra Nayak <quic_rjendra@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Steev Klimaszewski <steev@kali.org>
Subject: [PATCH v2 10/11] arm64: dts: qcom: sdm845: narrow LLCC address space
Date:   Thu, 28 Jul 2022 13:37:47 +0200
Message-Id: <20220728113748.170548-11-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220728113748.170548-1-krzysztof.kozlowski@linaro.org>
References: <20220728113748.170548-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Last Level Cache Controller (LLCC) device does not need to access
entire LLCC address space.  Currently driver uses only hardware info and
status registers which both reside in LLCC0_COMMON range (offset
0x30000, size 0x1000).  Narrow the address space to allow binding other
drivers to rest of LLCC address space.

Cc: Rajendra Nayak <quic_rjendra@quicinc.com>
Cc: Sibi Sankar <quic_sibis@quicinc.com>
Reported-by: Steev Klimaszewski <steev@kali.org>
Suggested-by: Sibi Sankar <quic_sibis@quicinc.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index fe14f7e7523b..e318c3f8aee0 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -2048,7 +2048,7 @@ uart15: serial@a9c000 {
 
 		llcc: system-cache-controller@1100000 {
 			compatible = "qcom,sdm845-llcc";
-			reg = <0 0x01100000 0 0x200000>, <0 0x01300000 0 0x50000>;
+			reg = <0 0x01100000 0 0x31000>, <0 0x01300000 0 0x50000>;
 			reg-names = "llcc_base", "llcc_broadcast_base";
 			interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
 		};
-- 
2.34.1

