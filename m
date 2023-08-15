Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5433177D61F
	for <lists+linux-pm@lfdr.de>; Wed, 16 Aug 2023 00:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240425AbjHOWcA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Aug 2023 18:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240454AbjHOWbm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Aug 2023 18:31:42 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B6C2100;
        Tue, 15 Aug 2023 15:31:35 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-6418d8a659fso18541206d6.0;
        Tue, 15 Aug 2023 15:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692138694; x=1692743494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SHHvH1R50hlGEwDWy54Ftr/XiT00eGPxCBa6hf7d2fM=;
        b=ZZLlP3p6MTLSn/fqdwK/FcdSY8M5YCbyTv0h1N+vR1kzzXvCoNYUIosZbu64li8kGq
         T2xF0GClEHHJqKU3cwrMAUYUuXWAnCpW7HvWw/t/Z7adRrsHadNjvqIy+QzKevmoKMvt
         pCDNhbK1G+KdpXQyTWoqTDSk0aEkr+zx1CAHdyQNxjfxHTHKaWauWwwMkml96HyE4+1X
         a3EanK/rmZ12YjocafJB0wOXl7mUyH/UodJlFCFW2/QoGgBRhgz3IXeXrc1Ugan4TNS+
         Q/WnWpGtF4w3GAa2zk2S66/Id1zD7qyr1jJRExvC2Z6MMrVps2F680iRBFeJXrDxZWx/
         M17g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692138694; x=1692743494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SHHvH1R50hlGEwDWy54Ftr/XiT00eGPxCBa6hf7d2fM=;
        b=BURIyVVZnwTxwl6u0rdb5+0ZLcc8Sx/PPVYXRwXD8AziXvoESeGYnDk5QoN8H5JlWx
         rlj2xpooputGKoRvRc+JuwBe8acNeIjtVoXK07sLErqt2olwboKSWnFgkPJKJ+N2wB13
         nQUET0UvFEV4V4xOhLHpXHNzK4tMvAg5rDuEig8AfsS2LYeq9RF9OTh7uMqDNM/eV4Ta
         jAgOo6q+LDKAS0hAy9VvAyTXtTiQCN6A6YdJVYfQT7XwTRjgM5RY4lbKzHwFupcmrPy7
         7jvHR316Fdw7GSAlOQyahUuAlRVZm7fx/Qtuye8byzTvXSN7vSFHZA6oTI/fAwp2BAZ5
         VWvQ==
X-Gm-Message-State: AOJu0YzVjUkJGw8ZSNyjbrvTDaHODT147yivEO5emLijV3lO66X4PBwa
        qb1HIWSp2DGT7JHdAJCN3q8=
X-Google-Smtp-Source: AGHT+IHxuExnICsKRhEJG6i5BfqZhlm52gJMsU0yR96psUr5z2u1ENGjAZLAidqcEMc36Y9z8QeENQ==
X-Received: by 2002:a0c:9d0c:0:b0:642:66bf:902c with SMTP id m12-20020a0c9d0c000000b0064266bf902cmr109491qvf.32.1692138694257;
        Tue, 15 Aug 2023 15:31:34 -0700 (PDT)
Received: from localhost ([2607:fea8:529e:7800::bdee])
        by smtp.gmail.com with ESMTPSA id t8-20020a05620a034800b007671cfe8a18sm4038208qkm.13.2023.08.15.15.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 15:31:33 -0700 (PDT)
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
Subject: [PATCH 1/3] dt-bindings: interconnect: add SDM670 OSM L3 compatible
Date:   Tue, 15 Aug 2023 18:31:10 -0400
Message-ID: <20230815223108.306018-6-mailingradian@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230815223108.306018-5-mailingradian@gmail.com>
References: <20230815223108.306018-5-mailingradian@gmail.com>
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

