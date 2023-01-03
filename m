Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B09165B8A1
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jan 2023 02:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbjACBJg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Jan 2023 20:09:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236446AbjACBJS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Jan 2023 20:09:18 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1AC9FE6
        for <linux-pm@vger.kernel.org>; Mon,  2 Jan 2023 17:09:14 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id fc4so70077643ejc.12
        for <linux-pm@vger.kernel.org>; Mon, 02 Jan 2023 17:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+balc+MRgedWafjUxob4M65cvBwrRUb1ln9bhd9UBPw=;
        b=KUblhxszEPc8VviOgPBZQSF/dWySeQ+15/+JKg3M6LwC+KjmP4oNWnY7AGHUI2UqN6
         xbfHaj15VgVoSVboOCncvwIg44dhDIF4dx1aU+u9oa2bpX0YCB4qsh/fanJuTeZOKbXb
         CxhthhdL2tv9CO+pCmnvOZFclIy6NVWAi0vKsU7XNX1vDXd2a+QIuhBFtyf4fX6RWJ7H
         +okSSjcIlkE4bp7LPS44K8yKYZZoiSUhKZwKdFLhPO4Ft337ZG+0Zqfg/JxUCQM+nZNj
         /ockMyzHX7fnZOAZ+3iBblIneXsfC9KjPmsa878yLLe9XP2XP0qmIAwgONwn3Rip2d/T
         s3vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+balc+MRgedWafjUxob4M65cvBwrRUb1ln9bhd9UBPw=;
        b=u9b+VwQY2FXlLCkhxj/Dw4w6JARdsBFmBJj0ScT+2MCsJ4ow2iah05hZogRz97la4B
         FVHhT2cT57S6FcRWSn3A/ZCbDo/xVE0/dxu7BEt0oCpfsH0N9SVqMGHsj0rbzSqB2oOW
         /Pe1ztrsjyPrlMTmIQhEJaA1bor4ya7FbG6QNNQD8bGZtoRyjEEBFprsNlP6vFN+RerC
         mwg57VsNykJIttS5ynWiLsIMLO0m+u4D0nr8xT99BjBInLqY6IA5M5ia/PiAP8+rMMYp
         E5EZWS3u560s+ZO3LeO8oNYyz4P8cs1C49wX+L5B/PUtgjH2p8vlFRNex7lbBITIfTv+
         WCkw==
X-Gm-Message-State: AFqh2kq7WYLvcdijcj1LL3fKHQ/8+GrXp1tL9D21QQQxQ/iEWw/uuuw3
        ZbAYZ69u9d513fvbBgjlH6HEYQ==
X-Google-Smtp-Source: AMrXdXt/04HbPLb4VObsdtgNjvhaI1eQZZhOUZBAY5X+BNtFSISQyXoy0yIulyZu2RM7fVR3FEmXlg==
X-Received: by 2002:a17:906:6d47:b0:7c0:c312:acaa with SMTP id a7-20020a1709066d4700b007c0c312acaamr35522054ejt.49.1672708152930;
        Mon, 02 Jan 2023 17:09:12 -0800 (PST)
Received: from planet9.chello.ie (2001-1c06-2302-5600-b443-9db7-1e5c-4fd5.cable.dynamic.v6.ziggo.nl. [2001:1c06:2302:5600:b443:9db7:1e5c:4fd5])
        by smtp.gmail.com with ESMTPSA id q26-20020a17090676da00b008302732f569sm13564648ejn.78.2023.01.02.17.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 17:09:12 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        djakov@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     bryan.odonoghue@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, benl@squareup.com,
        shawn.guo@linaro.org, fabien.parent@linaro.org, leo.yan@linaro.org,
        dmitry.baryshkov@linaro.org
Subject: [PATCH v2 3/7] dt-bindings: soc: qcom: smd-rpm: Exclude MSM8936 from glink-channels
Date:   Tue,  3 Jan 2023 01:09:00 +0000
Message-Id: <20230103010904.3201835-4-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230103010904.3201835-1-bryan.odonoghue@linaro.org>
References: <20230103010904.3201835-1-bryan.odonoghue@linaro.org>
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

MSM8936/MSM8939 should like MSM8916 not require glink-channels.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml
index 11c0f4dd797ce..16fd67c0bd1fd 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml
@@ -80,6 +80,7 @@ if:
         enum:
           - qcom,rpm-apq8084
           - qcom,rpm-msm8916
+          - qcom,rpm-msm8936
           - qcom,rpm-msm8974
           - qcom,rpm-msm8976
           - qcom,rpm-msm8953
-- 
2.34.1

