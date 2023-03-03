Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA636AA40A
	for <lists+linux-pm@lfdr.de>; Fri,  3 Mar 2023 23:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233087AbjCCWRw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Mar 2023 17:17:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbjCCWR0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Mar 2023 17:17:26 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BECF13C78A
        for <linux-pm@vger.kernel.org>; Fri,  3 Mar 2023 14:08:24 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id d36so2262666lfv.8
        for <linux-pm@vger.kernel.org>; Fri, 03 Mar 2023 14:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677881247;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kByKMAiyThWhQddTcnHkd5we2tSElWbVAhY9mxsVtno=;
        b=WBiuvDe4rDN/UwaKkoGSp7440me5p1g4Ali6B2xjq0D19iJCKAjngsYL4RR8fyMpOu
         BY27sXJw77nXxU/VxgeLJrF1TPZj2ZIbfdmR9LG/rdERIiAbal0MVxPaB4D5JPp4jQXa
         HgpahpGHmYnR3ExKEiV02oXW/NN81eqU0wq2PxegnSaIOMEoK0W3Yrgla0RNKSka6w1e
         FMmz/qIjC8hILt8nZVASLA+1nx1BrJ22O4JsEBDuTpv6yXsrgcT6OGdRdlGAYG4+mdaK
         wldQUZa2ADRleGxtQAbd615duAeGwaHCFbR3ioQgWejpsrP8NKEu4fP0RWYgzcNQkWuN
         vNGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677881247;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kByKMAiyThWhQddTcnHkd5we2tSElWbVAhY9mxsVtno=;
        b=jKeezu2tSWkCnFjTS96Ricbh8nvGNTS3oMHL7ccANNdEpX4N7dvGbVdMRSRW9cS+Ts
         V7YVV/2eb9snp0Kf8u+oEtKKI2kMNurlEOyvX0Nq70PUVuHuGwDe8jHiP26GHgLGdCxH
         p2NGt3m9z0+9T2Ibp8iKUyWkPe7My85mmWUxUXm9TWdq94rDgSYY8/hK5SshRp96EBbd
         2tRZijK7zzmSfyfo20avLFRa74R2l9bUMbZFGjyZJIRgYlR3Fz19zrDQUbFL7m+fHqMT
         INz7WFDwuCNY0ry5/xj7b03TApkTMxiMqsuWqE5fqqdoOr4p+Yeg5Uz6q4CIrTJYACwG
         xanQ==
X-Gm-Message-State: AO0yUKXa9nNyvVkLX5VBk9yJ4CGcH6YzWQagapge9ZTVA3VhGQfrjZ+s
        kRWGX0oR9dgQ4dMS9lsD12LytfcKqzhpdN0JPDQ=
X-Google-Smtp-Source: AK7set/GCprVfnv+hPF1Rzfmz6l0SL8mWmBDIe6hyGF2LRIdlIONxmT5k8eDdZCZA4AF4K+IijZHHA==
X-Received: by 2002:a19:ae13:0:b0:4e1:13fa:bf07 with SMTP id f19-20020a19ae13000000b004e113fabf07mr985985lfc.43.1677880692932;
        Fri, 03 Mar 2023 13:58:12 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id e27-20020ac2547b000000b004cafa01ebbfsm552670lfn.101.2023.03.03.13.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 13:58:12 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 03 Mar 2023 22:58:01 +0100
Subject: [PATCH 01/15] dt-bindings: thermal: qcom-tsens: Add compatible for
 SM6375
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230303-topic-sm6375_features0_dts-v1-1-8c8d94fba6f0@linaro.org>
References: <20230303-topic-sm6375_features0_dts-v1-0-8c8d94fba6f0@linaro.org>
In-Reply-To: <20230303-topic-sm6375_features0_dts-v1-0-8c8d94fba6f0@linaro.org>
To:     Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677880689; l=880;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=Xo5r61pKkn5u58scrvwnGxQSvCjXA8+p8ZYAEW/PB+Q=;
 b=7vSyzRro3M1PoiwzyP06k27hDzGfo3oDBQ8Z57zbfmtIIprHmAUCZ2Zdngs2nh9i9s8lrND9j7ZB
 IZhHCq+RAQmdNO0kARatFng3E2coXlwNbizIM1M6h2sKwXxeobOr
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Qualcomm SM6375 platform has two instances of the tsens v2.8.0 block,
add a compatible for these instances.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index 926e9c51c93c..d73b72dafcbc 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -56,6 +56,7 @@ properties:
               - qcom,sdm845-tsens
               - qcom,sm6115-tsens
               - qcom,sm6350-tsens
+              - qcom,sm6375-tsens
               - qcom,sm8150-tsens
               - qcom,sm8250-tsens
               - qcom,sm8350-tsens

-- 
2.39.2

