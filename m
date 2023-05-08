Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C74C6FB49D
	for <lists+linux-pm@lfdr.de>; Mon,  8 May 2023 18:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbjEHQE7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 May 2023 12:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232838AbjEHQEw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 May 2023 12:04:52 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0891E5588
        for <linux-pm@vger.kernel.org>; Mon,  8 May 2023 09:04:51 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4eed764a10cso5212064e87.0
        for <linux-pm@vger.kernel.org>; Mon, 08 May 2023 09:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683561889; x=1686153889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QLu6la4M2S+eq30bRBxEn3j3JQWM6yeWV3xnHdJprV4=;
        b=U1T92bLP9KjsMOvz+8xGEjU3pO6jpYbf7knLt2es3jGHdIWQ+fHuOrfMSfzK8I0pDD
         HeQbQh55+iE5rRlGRgw0dety+6AaVR+I7ACbCOwgJLl8CY0EfqF7Sb7Yp4e1iWYpFMr0
         j6OK3/2T/3IzhhRZNi/JdAgClF2ADY7KpsFQqTxdkO5u54amHm9PiTgrENVhRUnHRGyp
         esM2rZ0FwNx9ve4FkqvMQHq82zmYVhoKTG4zAODs3EIcdmrZAs5+aA2PZEIOrxDJEx2m
         0J91hBqCSNprTwa637cDer8MnpP355jsTE/JC21EImykDm8RywaiBzRmugN4dswuh6f0
         USCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683561889; x=1686153889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QLu6la4M2S+eq30bRBxEn3j3JQWM6yeWV3xnHdJprV4=;
        b=GpcoKovd9oBZc+OAL+m+YZu6Or1jizGHXPmBB/9lbhagCHhYkYDMdqd8JRb4fDn2Dl
         vwX9mqMVeK6VuJFE1kaMSrudTiVAiZAVMDyRuKe19Eh7VIgAbp094lpUbFN3M05jLOcz
         yayMWqPlkh4NV7MCKXCYfPG60NaMH/eRJY3JoyJq4ZVPZaBaqNo1dTRiqoE0XnDZinsS
         fTmZTmVnai7XLuT7Zncm61zgZj/k7VE3WANO39b2y+Oq16aL8isCJsxwMgfyg6JfYwhA
         wv50z0pDsKHO1T5LlU5jCzlIcsEXvB0+8Ac0OexVjmg6MB1JFiT8auAaPx8DaL3jsZmm
         yMqg==
X-Gm-Message-State: AC+VfDwFb1QEhtBdAq0L+5woNohRXd+P72Bpy82T/sGiALVylJx863hs
        xlvvVVgK2yxT/IMS0eE+6Uim5A==
X-Google-Smtp-Source: ACHHUZ4QiKu8q75nnHDsmzWRA51cCxJapIE1UKFcsWVd9AN5EFpzV7cAVjfBbVdy+ljY/NLWUCJg2g==
X-Received: by 2002:ac2:44c3:0:b0:4f1:36fb:7533 with SMTP id d3-20020ac244c3000000b004f136fb7533mr2476376lfm.66.1683561889310;
        Mon, 08 May 2023 09:04:49 -0700 (PDT)
Received: from lothlorien.lan (dzdqv0yyyyyyyyyyybm5y-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::ab2])
        by smtp.gmail.com with ESMTPSA id h3-20020ac25963000000b004eff4ea8dd3sm32372lfp.76.2023.05.08.09.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 09:04:48 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/6] dt-bindings: power: reset: qcom-pon: define pm8941-pon
Date:   Mon,  8 May 2023 19:04:41 +0300
Message-Id: <20230508160446.2374438-2-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230508160446.2374438-1-dmitry.baryshkov@linaro.org>
References: <20230508160446.2374438-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On PM8941 pon doesn't store the reset reason. However we still need the
wrapping node for pwrkey and resin nodes. Add bindings for pm8941-pon
device.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 Documentation/devicetree/bindings/power/reset/qcom,pon.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
index d96170eecbd2..0f4f55dd4eac 100644
--- a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
+++ b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
@@ -19,6 +19,7 @@ properties:
   compatible:
     enum:
       - qcom,pm8916-pon
+      - qcom,pm8941-pon
       - qcom,pms405-pon
       - qcom,pm8998-pon
       - qcom,pmk8350-pon
@@ -63,6 +64,7 @@ allOf:
           contains:
             enum:
               - qcom,pm8916-pon
+              - qcom,pm8941-pon
               - qcom,pms405-pon
               - qcom,pm8998-pon
     then:
-- 
2.39.2

