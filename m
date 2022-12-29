Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F17486588D0
	for <lists+linux-pm@lfdr.de>; Thu, 29 Dec 2022 04:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232989AbiL2DBT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Dec 2022 22:01:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233070AbiL2DBM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Dec 2022 22:01:12 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F2512756
        for <linux-pm@vger.kernel.org>; Wed, 28 Dec 2022 19:01:09 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id cf42so25930542lfb.1
        for <linux-pm@vger.kernel.org>; Wed, 28 Dec 2022 19:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TXCQltnJB15hT96I0u7uf01iijzutH3MEcPaoII8eTE=;
        b=B0t/ABUpg4aPD4l3uD/tKdcJHsdtWr6qTTrgvJzwxEWzX0Tj6RF4JhxLEQzV3zAdUa
         PeDe4WQ5Gb1q9i7S+5mURVLaxjkZyJCb3WAysnn6hpB/DKuVdXrE9sb+Ox/r37Nrf6rb
         mrgi24w0axd7xNDD/dOVqxf0GUsP+RcoQcCtnTjs9MpVvk5dKdfhkrb1Xs2oTmXB7G8l
         IzmukR1veKX9ST+jcXdcYCTJYAvaFYl6Kbf+zc9G1CqQCFUfhU1ceeAi+EhZrl/eAeZ2
         fJuN3j220ewD3RkjRYIgxKYrCjcosHVKFxUxxqx7CFkIk9li+AnoElNA00LhnwEgun0w
         Vc7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TXCQltnJB15hT96I0u7uf01iijzutH3MEcPaoII8eTE=;
        b=C+tn0eKo7Ys+mzpmKLSMCUA4o+qmdu7f3mylJUELwdHGElYCaDJuKx4WbRGfSUMJeA
         Ce8IktLbwRVcidBDz20x9V8AGJ6Rrcsl1KjRjfcOzG0boexiLyVwyH/8rkOrFqg/4JaS
         5Mb2NDrd13M1n1ig1r0XlH+jpNroxtx9D6Vk5etpBJig2MbrGYZG7PPD7iA3FMoxh/ub
         Dm3zWlbaOosVpAGRUh4epyZM7Mu107v8OK5ZD81eL8XDhiBvmHrzNCeiDTOi8scWq0/u
         HQjR4YXSdaGBRbm+9kZE3mbiOL4IEWiM5aGC2S8bMbBKIlW1+94VW3Qp2prEWG/+VOmL
         DoZQ==
X-Gm-Message-State: AFqh2kqYx2ZuZ9CmhBvvwVTVp0imVBPye9B81euDAoT+OgkIKzjGJZc1
        Jr7TMlfFM4Bd+F5ILBrRfGU+Hg==
X-Google-Smtp-Source: AMrXdXuvuVl9P6M4dvkUd4ynzY7US27FKEYHNUKxxFjMlZXY+i3qOoQTt6dcI9DuazbqrvWm95fKEA==
X-Received: by 2002:a19:760a:0:b0:4cb:96:57d2 with SMTP id c10-20020a19760a000000b004cb009657d2mr5257961lff.36.1672282868392;
        Wed, 28 Dec 2022 19:01:08 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id b11-20020a056512024b00b004b57277474esm2883070lfo.106.2022.12.28.19.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 19:01:07 -0800 (PST)
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
        Shawn Guo <shawn.guo@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 01/20] dt-bindings: thermal: tsens: add msm8956 compat
Date:   Thu, 29 Dec 2022 05:00:47 +0200
Message-Id: <20221229030106.3303205-2-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221229030106.3303205-1-dmitry.baryshkov@linaro.org>
References: <20221229030106.3303205-1-dmitry.baryshkov@linaro.org>
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
2.39.0

