Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49B08641ADE
	for <lists+linux-pm@lfdr.de>; Sun,  4 Dec 2022 06:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiLDF7Q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 4 Dec 2022 00:59:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiLDF7O (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 4 Dec 2022 00:59:14 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1FFA1A23F
        for <linux-pm@vger.kernel.org>; Sat,  3 Dec 2022 21:59:13 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id s8so13729817lfc.8
        for <linux-pm@vger.kernel.org>; Sat, 03 Dec 2022 21:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ZtsGWf+IkQq4iWsK/eqAfu1iBNO8SEVexJ7MO5T2cg=;
        b=bK3GyBjDV/IAR5+/NNEaBz9BnjQGQmM36DE/VqwuAV8QXyew6XvGdEsQlSqP7+HpmY
         9kfOKVMhQXLqy3ZvOhpBli8OPN1aPhngbz8SCwn9xqIvcvr4LhSSuB7yJulj5tUmAce5
         qwLMB5FE8nSeHxwq1v8uYveTh6TNgJr2edQS4OVo7Acfd01r3VSY1fuBg3H4xNXCX1Rc
         IYX970wlEdAjIZqioF4PLezIZKrp8z0ZUlo0AkZUyULYSHJBhpitsvEMkQGZKm/Qn+7X
         dk/7KoAVK3VBDUMv8Gld46pNuEt3IuQ25+I6cegDclBfXIAOFFoGz2bT+MwJy81KsFfc
         gO7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ZtsGWf+IkQq4iWsK/eqAfu1iBNO8SEVexJ7MO5T2cg=;
        b=sP/3FWQLvASrfRs+/gjpo60t9X0F/ba62oKbmNArC5Vxw0bhdJW8sblU9wsqtSlgCl
         oIQipOnMV6yGatR8dD+pHtD7+o4ZnFwLmu5IJwZR3rATBsmw+VV6NWY8mLDHU9MpWu5d
         BEjT+Fnz0JY999AhtN00ZGbgxncbVAqZMV6fZZ0hF1Ofchsvn/5Ny71F+iqHLs3XKjqW
         JPkmJcMP+2DLTV3LoRVlVLDfu7hkCUDRbxEOJaUFTSn2Poz7qLDR246OHxDTa5+DYdOx
         k2VS3nYWHQSc7CKkVnDXMCTPgrCL7Va5/90D0jKra7gqyqJr5ZxVwA/BLuH7C7pvwbxV
         pSKA==
X-Gm-Message-State: ANoB5pmhY6TW0jCezeRvhWxPkGzJk/34y2t+LP70kBQLKxQLcVjQu9vl
        u4AJtmjbU9pFJKB4eq5hLh87OQ==
X-Google-Smtp-Source: AA0mqf5bEQHK8V9RGmKYK6M9ffPQdAfGM3K/kSUQXBLom6PszH16IbBGW0l9KpsED5pBCS+YV+8INw==
X-Received: by 2002:ac2:4c49:0:b0:4a2:4d84:acce with SMTP id o9-20020ac24c49000000b004a24d84accemr19491666lfk.439.1670133551956;
        Sat, 03 Dec 2022 21:59:11 -0800 (PST)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id o6-20020a05651205c600b004917a30c82bsm1650028lfo.153.2022.12.03.21.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Dec 2022 21:59:11 -0800 (PST)
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
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 01/15] dt-bindings: thermal: tsens: add msm8956 compat
Date:   Sun,  4 Dec 2022 07:58:55 +0200
Message-Id: <20221204055909.1351895-2-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221204055909.1351895-1-dmitry.baryshkov@linaro.org>
References: <20221204055909.1351895-1-dmitry.baryshkov@linaro.org>
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

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index 038d81338fcf..1a5928cce133 100644
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

