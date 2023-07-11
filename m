Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7B774F25F
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jul 2023 16:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbjGKOfn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Jul 2023 10:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232579AbjGKOfm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Jul 2023 10:35:42 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51EC7171E
        for <linux-pm@vger.kernel.org>; Tue, 11 Jul 2023 07:35:22 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b63e5f94f1so72090141fa.1
        for <linux-pm@vger.kernel.org>; Tue, 11 Jul 2023 07:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689086118; x=1691678118;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yTj3v5b/T8fx5kMDAJroBSUFDjNBSAXDUnSVT8FEMlY=;
        b=f28jKzVoqE61/ysNWJIuTqe4Xo109EAmC8uDia7HFkXUM46qHdbIhyb4FJDiMXwWoT
         4pURB7RhBP3unj3DUSf3FcIis8ZoiGxBgDKf3DTOw5nshqoclYQ+SHwLvpp01Ix2W6nx
         WxgOtNq8Z/FevAWoZgKuMnNfSivH3/GEFSNtf8S3pWTvg3UrfYjk/x16REO3NT4TC/LJ
         l0s6Fylzy4o2cgdSSx/nWFGXPpWXDNOeGevK2bMqgiHOOR0+Pn4MXu7xrCwja/on5wa5
         rSzlEC4IPoZjZx8SgGv3DHtyIbbvmeuT/zIpeTXDUiFFBJR5hswnxAqOl3nZDh33ie8A
         iaEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689086118; x=1691678118;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yTj3v5b/T8fx5kMDAJroBSUFDjNBSAXDUnSVT8FEMlY=;
        b=Mrm34X1ca9TZpQTDFqRSXyjpHvWLQXIbHQomnObQrYh4luD4adh3upfeCBA1DrAwFa
         rLacdYLr3yJ6seQdfdU9sN0pqpfAdNAtpPCfLDYWXaumiKxJH8xAHC/Yjx++zxm/y38x
         0ZiKm/C8/qSWsY0qPBC/X8whX+HQzwl8tn/AhjOPld21T5RWhVVuE4+IfwXWyO/tyes3
         hzWdZFhpp7euetjPD37I7LylO/ttxCup06KKyB651jCvfgg3yW0ddDTRSoA8c/OKyFMX
         lBmc01rieLSjbgXaGuXzWjOAA59dZGTT34/TTrBMHPBLVnQMeXvmZWBYLkR0ktgxjind
         4VpQ==
X-Gm-Message-State: ABy/qLbTpe5cpdUYfyX6smZNOeOwxXC0tRPPzk7ptt7FGqok5KAIu0zT
        OOXymB4roEM1hctVMl6MeC9DgA==
X-Google-Smtp-Source: APBJJlHuB+kRV9em008RY7jWkjttD2hCzYbbBT/iQwOoTGgbAINm08eKlWwbK9pD4cU125RiVye5Ng==
X-Received: by 2002:a05:651c:2d0:b0:2b6:b30f:5bf with SMTP id f16-20020a05651c02d000b002b6b30f05bfmr7797469ljo.13.1689086117999;
        Tue, 11 Jul 2023 07:35:17 -0700 (PDT)
Received: from [192.168.1.101] (abyl96.neoplus.adsl.tpnet.pl. [83.9.31.96])
        by smtp.gmail.com with ESMTPSA id o11-20020a2e90cb000000b002b71c128ea0sm484221ljg.117.2023.07.11.07.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 07:35:17 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 11 Jul 2023 16:35:13 +0200
Subject: [PATCH 1/4] dt-bindings: interconnect: qcom,msm8998-bwmon: Add
 SM8250 bwmon instances
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230711-topic-sm638250_bwmon-v1-1-bd4bb96b0673@linaro.org>
References: <20230711-topic-sm638250_bwmon-v1-0-bd4bb96b0673@linaro.org>
In-Reply-To: <20230711-topic-sm638250_bwmon-v1-0-bd4bb96b0673@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689086115; l=1231;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=Mqr8aIJT7OZuMDiUt6qt7vmC8e4+0eA84eAoPkmAsQ0=;
 b=Pdrs+pvhJY/Lq+tgf8yLN+hoT2PFhKdwhUatRVatUnxk3FISdBGQShns4VZcj2l6rF2Wax2TP
 D0PtwBpplJuDgpniBlm/qwQqTH5hForQlhuyb8p86/MAPWOxZSC6762
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SM8250 has a BWMONv5 for LLCC and a BWMONv4 for CPU. Document them.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
index b63db9098345..51ba6490c951 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
@@ -29,12 +29,14 @@ properties:
               - qcom,sc7280-cpu-bwmon
               - qcom,sc8280xp-cpu-bwmon
               - qcom,sdm845-cpu-bwmon
+              - qcom,sm8250-cpu-bwmon
               - qcom,sm8550-cpu-bwmon
           - const: qcom,sdm845-bwmon    # BWMON v4, unified register space
       - items:
           - enum:
               - qcom,sc7180-llcc-bwmon
               - qcom,sc8280xp-llcc-bwmon
+              - qcom,sm8250-llcc-bwmon
               - qcom,sm8550-llcc-bwmon
           - const: qcom,sc7280-llcc-bwmon
       - const: qcom,sc7280-llcc-bwmon   # BWMON v5

-- 
2.41.0

