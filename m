Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89BAF77EDAA
	for <lists+linux-pm@lfdr.de>; Thu, 17 Aug 2023 01:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347124AbjHPXGL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Aug 2023 19:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233746AbjHPXFn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Aug 2023 19:05:43 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B60E2D40;
        Wed, 16 Aug 2023 16:05:21 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-58a24ac48eeso35961327b3.0;
        Wed, 16 Aug 2023 16:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692227120; x=1692831920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SHHvH1R50hlGEwDWy54Ftr/XiT00eGPxCBa6hf7d2fM=;
        b=W23vD8o4X5LLWIfiibjOhbKtgecPu+KNermLmBs/7pYz7KDKfIJDg+q567b8ox2Bss
         m9OYBmYQY1d89/9AcfrE6S4ZBGMe4aVREMMbJNhG2jV+t1qyQLMAycJzX9x/jy72ikTw
         G7/YlWhTnp7dKuejFVcI8JKfQegKA7CGZ/+NNBHn3vlqyFxXsNd9gP+LGvpvaxuh//Wk
         CU29132IWrdZcM2Ztos+r9qaXoov6GTYB9TnnPti+fbHChQqCqX0AND7IHcMiophXWFy
         D6zHg4OZaXwxuHBcRco5TKjWVo2Om2S9LyjbBlL3M5uJ+/fEZ2iu0Hc4P9r9LN9RAd72
         Dp1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692227120; x=1692831920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SHHvH1R50hlGEwDWy54Ftr/XiT00eGPxCBa6hf7d2fM=;
        b=imc3wLx6JvyTFhzE7Ra+2oeteL+UdDKlar/m5mmk/iZ1ISt+kMrcibjY5ZQoN6PPyL
         dYch45rXzrutgq1Nmy2yNJKCNReKsaMS6R66zpGHCaVbZgfFkhqqKcOAYUcDeHSS5Rj7
         9Pnr/c/gJbHlNA7eME5GFteJ3Mqh0/2+MQhuQWo5zHPeDPhQ7gR4ivlz0ty+HHY93U03
         uyGXdN9w4FHXxGYyZii0FRfmmkkmK5ZuudXNpMBdnbrfGFtbGHaSHbXT9VeGnVvFvz10
         pFhd7QxpkFzPWbBM+I/Fel4RhylxFd7ZH3s72SY1TpqxZNcJS+rCVBSB0P7fGyIX09BJ
         c6aQ==
X-Gm-Message-State: AOJu0YyFfN2M0Fp9JsZCNhEanw0XWkJB0gjl6Hb+u4bkRhUTcbQsABK/
        o9n0sHFtPYfzJnblrkk+XvQ=
X-Google-Smtp-Source: AGHT+IFIRlOddrCV9PtsKBnmPPmXUmelfYWp4Rc/jMrEYbo1bELrr5kxUHq45TbObXEYY0nJJSLSew==
X-Received: by 2002:a81:8ac3:0:b0:586:9e0a:e3c4 with SMTP id a186-20020a818ac3000000b005869e0ae3c4mr3466574ywg.30.1692227120377;
        Wed, 16 Aug 2023 16:05:20 -0700 (PDT)
Received: from localhost ([2607:fea8:529e:7800::5ee])
        by smtp.gmail.com with ESMTPSA id y6-20020a818806000000b0057736c436f1sm4269905ywf.141.2023.08.16.16.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 16:05:20 -0700 (PDT)
From:   Richard Acayan <mailingradian@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     Richard Acayan <mailingradian@gmail.com>
Subject: [PATCH v2 1/3] dt-bindings: interconnect: OSM L3: add SDM670 compatible
Date:   Wed, 16 Aug 2023 19:04:15 -0400
Message-ID: <20230816230412.76862-7-mailingradian@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230816230412.76862-6-mailingradian@gmail.com>
References: <20230816230412.76862-6-mailingradian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add the compatible for the OSM L3 interconnect used in the Snapdragon
670.

Signed-off-by: Richard Acayan <mailingradian@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
index 9d0a98d77ae9..21dae0b92819 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
@@ -21,6 +21,7 @@ properties:
           - enum:
               - qcom,sc7180-osm-l3
               - qcom,sc8180x-osm-l3
+              - qcom,sdm670-osm-l3
               - qcom,sdm845-osm-l3
               - qcom,sm6350-osm-l3
               - qcom,sm8150-osm-l3
-- 
2.41.0

