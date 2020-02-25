Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8FB16BAA6
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2020 08:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728999AbgBYHbd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Feb 2020 02:31:33 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38909 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728976AbgBYHbc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Feb 2020 02:31:32 -0500
Received: by mail-pf1-f196.google.com with SMTP id x185so6713509pfc.5
        for <linux-pm@vger.kernel.org>; Mon, 24 Feb 2020 23:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zZsq6DdlTUllP1Ky5M6aIC5cYvOLunweWDxkADaPGjU=;
        b=Tr6XjG+8w/WVnbmg1OAs62FUbJ/tFZloNl/UDY8uOnR+782nDkSXFsijmlseW0afa2
         aDc2uqaHoeezyb2pQeCXw6AoLdhwrEecl6pAW5nIn+IjSn9b/pYCrp13O9T4eZgnx78O
         9/N1qKivaVK8c5sbSPC5l+OJSR6UZxBtH3XahWR/kETl0MlscRa8GGdWt0xBfk3nIX4d
         09gBEEYu+qfpneePimChIxlh1btiBNqAra2daW6XufpEqEfcT/3RdD6zdw3wk3VCpe4W
         avah/+Iq3JkC+tHbi8wGsv2gFULA/6oyJN5PiTH7VUXCUtJOT1xrxdcIg3KV2kfFOZm7
         2DJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zZsq6DdlTUllP1Ky5M6aIC5cYvOLunweWDxkADaPGjU=;
        b=qo6QH2QFR2Y681HO1EwjH2dxLBlPRx+StGAFybJXGudxk2b2EwXK4yijeq70nghRyU
         +FkBrj7318KnohQwcpOG9cF1GyP2/4TwYLkbTCaE+Ydlj5Akiv0DdU2sOL10YiWpPpRG
         uwy1ob5WI5S3N4DopZHpXXH0ElZm8Js1lTOyfttLa1GG0aMpXBbkEFbmQmo6c2LHgLI9
         rb9DBxPfRu94+M/ByJCNYugellgYvHSRNqTWD1k2wYQj7okzdi/W90KefDHZq0ZDNQt2
         /6YBKjQU0ZyuN8WFmP855oR1zP9pzLMmfXYEX2ceQPZC3S3Gxtj78xMqgve5z92lGx/H
         irhQ==
X-Gm-Message-State: APjAAAXVA7JbhSJU6bSmdOKJVkureGRHQ7hte3e/bdJK/5I85oXEesLm
        fx+k/jFJAjfFhu1TDmkZ7rB3Pw==
X-Google-Smtp-Source: APXvYqws+7RY/sQ+7jnJlytqn0LEDGzDdcGQ/AzcWV/7izOxobUMOGH8YGCG/GxfQy0YS6aNbqWnRA==
X-Received: by 2002:a63:e841:: with SMTP id a1mr9876074pgk.244.1582615891929;
        Mon, 24 Feb 2020 23:31:31 -0800 (PST)
Received: from localhost ([103.195.202.114])
        by smtp.gmail.com with ESMTPSA id q12sm15511899pfh.158.2020.02.24.23.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 23:31:31 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org, bjorn.andersson@linaro.org,
        sivaa@codeaurora.org, Andy Gross <agross@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v1 1/3] dt-bindings: thermal: tsens: Make dtbs_check pass for sc7180 tsens
Date:   Tue, 25 Feb 2020 13:01:20 +0530
Message-Id: <0f506cfdd8eb9d50b5eb43c9dca510284ac8ded1.1582615616.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1582615616.git.amit.kucheria@linaro.org>
References: <cover.1582615616.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fixes the following warnings:
builds/arch/arm64/boot/dts/qcom/sc7180-idp.dt.yaml:
thermal-sensor@c263000: compatible: ['qcom,sc7180-tsens',
'qcom,tsens-v2'] is not valid under any of the given schemas (Possible
causes of the failure):
builds/arch/arm64/boot/dts/qcom/sc7180-idp.dt.yaml:
thermal-sensor@c263000: compatible:0: 'qcom,sc7180-tsens' is not one of
['qcom,msm8916-tsens', 'qcom,msm8974-tsens']
builds/arch/arm64/boot/dts/qcom/sc7180-idp.dt.yaml:
thermal-sensor@c263000: compatible:0: 'qcom,sc7180-tsens' is not one of
['qcom,msm8976-tsens', 'qcom,qcs404-tsens']
builds/arch/arm64/boot/dts/qcom/sc7180-idp.dt.yaml:
thermal-sensor@c263000: compatible:0: 'qcom,sc7180-tsens' is not one of
['qcom,msm8996-tsens', 'qcom,msm8998-tsens', 'qcom,sdm845-tsens']
builds/arch/arm64/boot/dts/qcom/sc7180-idp.dt.yaml:
thermal-sensor@c263000: compatible:1: 'qcom,tsens-v0_1' was expected
builds/arch/arm64/boot/dts/qcom/sc7180-idp.dt.yaml:
thermal-sensor@c263000: compatible:1: 'qcom,tsens-v1' was expected

builds/arch/arm64/boot/dts/qcom/sc7180-idp.dt.yaml:
thermal-sensor@c265000: compatible: ['qcom,sc7180-tsens',
'qcom,tsens-v2'] is not valid under any of the given schemas (Possible
causes of the failure):
builds/arch/arm64/boot/dts/qcom/sc7180-idp.dt.yaml:
thermal-sensor@c265000: compatible:0: 'qcom,sc7180-tsens' is not one of
['qcom,msm8916-tsens', 'qcom,msm8974-tsens']
builds/arch/arm64/boot/dts/qcom/sc7180-idp.dt.yaml:
thermal-sensor@c265000: compatible:0: 'qcom,sc7180-tsens' is not one of
['qcom,msm8976-tsens', 'qcom,qcs404-tsens']
builds/arch/arm64/boot/dts/qcom/sc7180-idp.dt.yaml:
thermal-sensor@c265000: compatible:0: 'qcom,sc7180-tsens' is not one of
['qcom,msm8996-tsens', 'qcom,msm8998-tsens', 'qcom,sdm845-tsens']
builds/arch/arm64/boot/dts/qcom/sc7180-idp.dt.yaml:
thermal-sensor@c265000: compatible:1: 'qcom,tsens-v0_1' was expected
builds/arch/arm64/boot/dts/qcom/sc7180-idp.dt.yaml:
thermal-sensor@c265000: compatible:1: 'qcom,tsens-v1' was expected

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index eef13b9446a8..13e294328932 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -39,6 +39,7 @@ properties:
               - qcom,msm8996-tsens
               - qcom,msm8998-tsens
               - qcom,sdm845-tsens
+              - qcom,sc7180-tsens
           - const: qcom,tsens-v2
 
   reg:
-- 
2.20.1

