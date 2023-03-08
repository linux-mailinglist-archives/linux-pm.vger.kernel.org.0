Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97FE6AFC44
	for <lists+linux-pm@lfdr.de>; Wed,  8 Mar 2023 02:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjCHB12 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Mar 2023 20:27:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbjCHB11 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Mar 2023 20:27:27 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4455867FB
        for <linux-pm@vger.kernel.org>; Tue,  7 Mar 2023 17:27:19 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id i28so19571802lfv.0
        for <linux-pm@vger.kernel.org>; Tue, 07 Mar 2023 17:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678238838;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rSKkpNbYMdizlF1Hcg/N2ARWz4QldZWXYT/s2rK2tJA=;
        b=NS72HA7x6azq8Oo6p63K66wCgwAP1l9vaFl65JhYFn5YgA/PNDBFBDfyfB/lVr8Gp5
         olZ/GFjlDCVsMko3PodpMhX+ORH83KenOIT0KdH03scpm7fXbJ36lksg3MFKoRfzTgBC
         CHd7UFVBYvvZdMPWG1xY9uGAVXOL+Y+XjhhpWIvAcKvAS50BJk7t3yR7lgFNGp02ym3X
         be2RiMPNu/hwtZjiA23ps3jX7AwzXEadCbRCUsMabyAn4+3PUmD+NWrx9RkwGj62om50
         2vPgn1v/QdNAmxlA6hrOXpc60oebE7jUQb27rih5zBsDCHiEx13O3/7M/cY/b3IMjbc/
         sR9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678238838;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rSKkpNbYMdizlF1Hcg/N2ARWz4QldZWXYT/s2rK2tJA=;
        b=d4FLm3dMupvuoqc4aIYhmju7zllBkaaxaFj/RkK/H/Vv8pHxsQyHSfBx8xCs7C7nWv
         dwuFUDP/L6a3rzR9nikS5RKXf79PqPYWlRzA15sVZqw+HO954xQIJdTKUG47AtcBzazO
         OGCKjf6zK/5dHAW54P2CzE/bZ6sAF7obBTe70tvvvfKogPJeBZqFiZucNZ92a2Dq/TVI
         kXc6f1R7uXPO9Ve87Tmz8sAvShByGBYBItDgORBSOe2R8SXiNt/dEh6zCOHpQnCDqATZ
         X+QFqVdVrfSJ6jlVXqnAfyD02ij3nfveafmbUw90U4FUQSeQJr/tkhX9FO4GuJrspP05
         6GmA==
X-Gm-Message-State: AO0yUKV7OOHqqlOiF8s7EwsQiB3Ot5TTrgBNUyGLm+EyLxatn4Rvom4b
        Yo/utvZn+aJLrURhogdXLlxqzQ==
X-Google-Smtp-Source: AK7set8oabf47X71W0OHEXA3HYJis7GvhrzB60WVfNnxxSsNsZ8ihJefVtG99nIokQAtXNIc3EICjg==
X-Received: by 2002:ac2:5108:0:b0:4d8:4f53:37ad with SMTP id q8-20020ac25108000000b004d84f5337admr3760704lfb.7.1678238838009;
        Tue, 07 Mar 2023 17:27:18 -0800 (PST)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id o24-20020a056512051800b004a2c447598fsm2182944lfb.159.2023.03.07.17.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 17:27:17 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 08 Mar 2023 02:26:58 +0100
Subject: [PATCH 1/8] dt-bindings: cpufreq: cpufreq-qcom-hw: Allow just 1
 frequency domain
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230308-topic-cpufreq_bindings-v1-1-3368473ec52d@linaro.org>
References: <20230308-topic-cpufreq_bindings-v1-0-3368473ec52d@linaro.org>
In-Reply-To: <20230308-topic-cpufreq_bindings-v1-0-3368473ec52d@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678238834; l=1052;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=VcREQrZ3O5Tg8/LdkaQG+SHph0xK/tPAY49fNyeIAmM=;
 b=w1hqviMRcVjC9G7LJ9pEuGt+mq9CPwQIKjKYXYgZPAgVAmceGhUW4EhZSj3xPf7hfLSHA+a402/n
 uOgK8/ADDz+Gj3Y5bC+2mROcGn4+VpGVGfhl+TFisk63HriZP+dY
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Some SoCs implementing CPUFREQ-HW only have a single frequency domain.
Allow such case.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
index e4aa8c67d532..aebf2254e45a 100644
--- a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
@@ -36,14 +36,14 @@ properties:
           - const: qcom,cpufreq-epss
 
   reg:
-    minItems: 2
+    minItems: 1
     items:
       - description: Frequency domain 0 register region
       - description: Frequency domain 1 register region
       - description: Frequency domain 2 register region
 
   reg-names:
-    minItems: 2
+    minItems: 1
     items:
       - const: freq-domain0
       - const: freq-domain1

-- 
2.39.2

