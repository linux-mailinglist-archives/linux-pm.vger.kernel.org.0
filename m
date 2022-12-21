Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C391652B29
	for <lists+linux-pm@lfdr.de>; Wed, 21 Dec 2022 03:05:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiLUCF0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Dec 2022 21:05:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234257AbiLUCFZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Dec 2022 21:05:25 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C3F1FCD6
        for <linux-pm@vger.kernel.org>; Tue, 20 Dec 2022 18:05:23 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id bp15so21328459lfb.13
        for <linux-pm@vger.kernel.org>; Tue, 20 Dec 2022 18:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QYEvrA5jk7OGUR/7PWOk8acQl/of6Esek0ztRJgkInE=;
        b=z0b7d597vLaEA8QEnD2peK5jkdmzwAER/I5hSrrkp5jiXTAUx27inwlxHMbzeki5YQ
         uvbhNWg/nBlrl1iSEDTTOcBg23pWyi2pMfebq/COGMP1o4CPro0y8uXHU3Pk+xo1YAbL
         aJ+/dH+4lhli54oCAzR6c8R7nYwTp+H4oS1yW2oBzWwO24w/Au8If2hHS7am03Y2M907
         IImuup3MFIVOlofQy7jptb8oIs33CsOBikKlUhalIcS/haybnyPLiMvdeHXLF/7IV8fM
         C0osusCeholYpY/OgElSV7cApJtyxdcyg+x8U8H/qiN42gd2hD41yjcGUBetSroSu2DM
         4GyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QYEvrA5jk7OGUR/7PWOk8acQl/of6Esek0ztRJgkInE=;
        b=pQMqvahj97nqmSaeraHudwNpOR9blSjKXQXBcTx7ySVtu2VLgCBOw36nZZalcoZjWJ
         Fm6T2aPG00YMZyISryyMAQf3pSl97v9oVl3hBVEyMcl9abKVTBQNg35ThoD9y01BwvN7
         /epnALJkdJjPFLTU+bPxGCGYXyYmyrBMXJtfUjaz1yAglFqDi5oM9gMILBMGOBiJ18yL
         WT99LiR+hs8EPYAs0eidkWURwgqUgBUjqlcZSe3DYftz92XedXKjSYXG16C3tb7RBbST
         cozUry4bajp4zXfX807U4OW4q9WERHMsnAa0F2M+pCVib3jFlZ7mJ7qEGcmhIx6cyLTy
         XIkw==
X-Gm-Message-State: AFqh2kqpG+hM1fiMsCGU+iEZlZMDPHd+4rp2ZGp/EqKJtHzpLcWLjrR0
        duEmhbX5k0rSUSCwfys/D6l+7g==
X-Google-Smtp-Source: AMrXdXtVZXP6SmsuGuZmBiTrtotv7dzDZmhCKbWeKZ9Rgi7210UcLl5LbClis8uDQotoaMFbwOOuIw==
X-Received: by 2002:a05:6512:472:b0:4a4:68b8:f4d9 with SMTP id x18-20020a056512047200b004a468b8f4d9mr60658lfd.31.1671588322332;
        Tue, 20 Dec 2022 18:05:22 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id q18-20020a056512211200b004b257fef958sm1673048lfr.94.2022.12.20.18.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 18:05:21 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 01/20] dt-bindings: thermal: tsens: add msm8956 compat
Date:   Wed, 21 Dec 2022 04:05:01 +0200
Message-Id: <20221221020520.1326964-2-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221221020520.1326964-1-dmitry.baryshkov@linaro.org>
References: <20221221020520.1326964-1-dmitry.baryshkov@linaro.org>
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

When adding support for msm8976 it was thought that msm8956 would reuse
the same compat. However checking the vendor kernel revealed that these
two platforms use different slope values for calculating the calibration
data.

Add new compatible for the tsens on msm8956 SoC.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index 0231f187b097..f3660af0b3bf 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -37,6 +37,7 @@ properties:
       - description: v1 of TSENS
         items:
           - enum:
+              - qcom,msm8956-tsens
               - qcom,msm8976-tsens
               - qcom,qcs404-tsens
           - const: qcom,tsens-v1
-- 
2.35.1

