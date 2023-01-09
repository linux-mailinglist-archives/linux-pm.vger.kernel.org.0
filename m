Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE30661B72
	for <lists+linux-pm@lfdr.de>; Mon,  9 Jan 2023 01:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234160AbjAIA3u (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 8 Jan 2023 19:29:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234181AbjAIA3p (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 8 Jan 2023 19:29:45 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9FE0C74A
        for <linux-pm@vger.kernel.org>; Sun,  8 Jan 2023 16:29:43 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id bn6so7328586ljb.13
        for <linux-pm@vger.kernel.org>; Sun, 08 Jan 2023 16:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8FiMYGHFGXrVpyzi7ZgB2e/VL6pJCok4vFhR2XZcqc4=;
        b=PZ1QLxq7FSPWJ7kL0sGttGozusdpey5kBAQTAqmjeC9XxAAS08x/Y0Emm7Fr/jQnXb
         aGx8knQkVtHBzCsha5za25b8PniisVEvXQQEISmV4J/B6G5cOVWRhUZBJElKOXKy7RtR
         beRX8Gz6U7QgVNRu8wXtaipsf4EG40TiplBiUviwVH6GErjPdaCbTu6NGHu0RH9cPezt
         ISlAY/6tUZf8HxFLMk6ZX/TbriaGQB3DTkGXfSA4lt6Zs9yp6/vZb6fA4wok6PTjOju6
         hnWp6DaTRaKZ87uKvU3YIJtrw/fLT3uK3L16rCpC5/dKfrhgfFVMhYmnFTHh8+dtpzMh
         eYKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8FiMYGHFGXrVpyzi7ZgB2e/VL6pJCok4vFhR2XZcqc4=;
        b=kmzAsBzBrsyH8vejNZ2bogD0sYI+h16B7ItRPncIlcSZYSqFoEDbrRxHAK6VE+rdqJ
         NROqQOBhmkbctR5k6DQZemjDI1hgUm0WnEmugy1MkGwHNxrShtDfOCXFIgdRdhSS3rOG
         oewFznU4bDc5Qto0hgvILKUZIHJU1H9m4YPnZqLjcTThs6BSFuMN6ge1aVWYbUzdT8BN
         egeOA+NjPIg5HUayPsMDDOwufb77QBhw4AeC1nBym9TZdYuutYSEcapNy/0+mOvnR3zD
         mP8CBn3zrvj3KNCcGBnhYI+2QAntFLgVmTHeLiUIhsDRXE5i3hLS6heoJvurIjOqiyC7
         yCsA==
X-Gm-Message-State: AFqh2krWIjnA7g5KWN63pQM+b4Fr96R+RwOBsYqC1V2fmumj5qmLvstQ
        Dp1CANCnV7fVUpE3gfH3McVP5w==
X-Google-Smtp-Source: AMrXdXvIh/UnBUZHr6BN0MGUAx+F/Z+scaaE+j4R+07r9IvBAVGLtl3YOB6xUp9f1wI5NL98H3xtCw==
X-Received: by 2002:a2e:940c:0:b0:281:e762:35aa with SMTP id i12-20020a2e940c000000b00281e76235aamr2610488ljh.3.1673224183468;
        Sun, 08 Jan 2023 16:29:43 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id a22-20020a2e9816000000b0027fc54f8bf0sm706626ljj.35.2023.01.08.16.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 16:29:42 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>
Cc:     Georgi Djakov <djakov@kernel.org>, Alex Elder <elder@linaro.org>,
        Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 08/12] dt-bindings: interconnect: qcom: Remove ipa-virt compatibles
Date:   Mon,  9 Jan 2023 02:29:31 +0200
Message-Id: <20230109002935.244320-9-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230109002935.244320-1-dmitry.baryshkov@linaro.org>
References: <20230109002935.244320-1-dmitry.baryshkov@linaro.org>
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

These interconnects are going to be modeled as clockks, not
interconnects. There are no other interconnects left on the virtual
SoC-ipa-virt NoCs, therefore remove the compatibles from the binding as
they're unused.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
index a429a1ed1006..4e8d950c2832 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
@@ -58,7 +58,6 @@ properties:
       - qcom,sc8180x-config-noc
       - qcom,sc8180x-dc-noc
       - qcom,sc8180x-gem-noc
-      - qcom,sc8180x-ipa-virt
       - qcom,sc8180x-mc-virt
       - qcom,sc8180x-mmss-noc
       - qcom,sc8180x-qup-virt
@@ -96,7 +95,6 @@ properties:
       - qcom,sm8150-config-noc
       - qcom,sm8150-dc-noc
       - qcom,sm8150-gem-noc
-      - qcom,sm8150-ipa-virt
       - qcom,sm8150-mc-virt
       - qcom,sm8150-mmss-noc
       - qcom,sm8150-system-noc
@@ -106,7 +104,6 @@ properties:
       - qcom,sm8250-config-noc
       - qcom,sm8250-dc-noc
       - qcom,sm8250-gem-noc
-      - qcom,sm8250-ipa-virt
       - qcom,sm8250-mc-virt
       - qcom,sm8250-mmss-noc
       - qcom,sm8250-npu-noc
-- 
2.39.0

