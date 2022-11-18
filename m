Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9501E62EF6F
	for <lists+linux-pm@lfdr.de>; Fri, 18 Nov 2022 09:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235149AbiKRIaf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Nov 2022 03:30:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241516AbiKRI35 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Nov 2022 03:29:57 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10A331DC9
        for <linux-pm@vger.kernel.org>; Fri, 18 Nov 2022 00:29:25 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id m7-20020a05600c090700b003cf8a105d9eso3492132wmp.5
        for <linux-pm@vger.kernel.org>; Fri, 18 Nov 2022 00:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MehYhB6F0Q5eHfYcAMk4Q22mdZNFopk2+xLRwUYYDiU=;
        b=Tc9K7qBbu2jDZJ/r2Eoy+5Uf3qf770e9f+doGH/fjoM30oPsXj2/NidmK5eE09oGzJ
         +vgJ+4cHDqBbm8HnmUN9MigS6qOjnUnZ28FL8T9i3a3uISZAk9lo3brKybaTF60x/AHz
         PhULHjqc72htt980FOaq740ETBTbpv+XH20U/atQ+rpsHr08z+HrOC8ImM0dXyEdIjC7
         WaKd9QDOw7We6YKsO4QRBelPw/0jfOeP+Wtbj9nHeoHD3+D9LcSj0DLBnC9d0OBlsAo2
         FdPdEao0qROC7JuLuXahe5xk1hTmkvh+CA10NttYBUexvp7GzSWxcJidEWs1eVc+mSOJ
         CL+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MehYhB6F0Q5eHfYcAMk4Q22mdZNFopk2+xLRwUYYDiU=;
        b=lH2F7OmO3JRNUkhcaCAlxn5co1tq/hka5e3WLzS78te8Aa698MoCZ/SuOdfDh/5qmZ
         1EID4QqBif5RFm2KHJ9znrBRaRsSvMPQ9VYxn0xtBrytDlIKv7TzsisqyG4BbvHcWiPK
         N0aQkzVx78G8c6ElPMs0aQQukO0VyC/xQ/iLg1YXmkNdTZzhSqaruk7GWZNua4Qq5Xak
         QU5xmcanro3EuKj+XrIcjnxyoQ6M0gXW7yrq91cNKqCSzzbi7l4dRix7GuDBmtsFmHhi
         pjE7e8oKz2WeeVerLY05xpbGy55jcbJLEdE86EWCyo55gbpt38OesKWQV7dA2HGSPhfs
         Oe3w==
X-Gm-Message-State: ANoB5pnfO25e4a02ESnsxDBYNDVzLAzpTUte1uW0VWDms7p7BXLRJPLW
        FF9iQXW1xSzI5EjSmJR2AGuT3g==
X-Google-Smtp-Source: AA0mqf59fUADY3sUukFZnRP7lC2MzZfO/bqTdIj1/GDrGS++AzdDdwEmzyyMRBDBohKIXJizSXbk5Q==
X-Received: by 2002:a1c:e917:0:b0:3cf:681a:43e1 with SMTP id q23-20020a1ce917000000b003cf681a43e1mr3914195wmc.126.1668760164367;
        Fri, 18 Nov 2022 00:29:24 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id p18-20020adfe612000000b002366a624bd4sm869268wrm.28.2022.11.18.00.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 00:29:24 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Fri, 18 Nov 2022 09:29:21 +0100
Subject: [PATCH v2] dt-bindings: interconnect: qcom-bwmon: document SM8550
 compatibles
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221114-narmstrong-sm8550-upstream-bwmon-v2-0-20c555e3ba5d@linaro.org>
To:     Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.10.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Document the compatibles used to describe the Bandwidth Monitors
present on the SM8550 platform.

A BWMON v4 IP monitors the CPU bandwidth, and a v5 does the LLCC
bandwidth monitoring.

This is described by adding "llcc" and "cpu" into the compatible
strings to differentiate the BWMON IPs.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Andy Gross <agross@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@somainline.org>
To: Georgi Djakov <djakov@kernel.org>
To: Rob Herring <robh+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes in v2:
- Reworded commit message
- Added Reviewed-by from Krzysztof
- Link to v1: https://lore.kernel.org/r/20221114-narmstrong-sm8550-upstream-bwmon-v1-0-b6dd08927f35@linaro.org
---
 .../devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml         | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
index be29e0b80995..00b635662697 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
@@ -26,8 +26,13 @@ properties:
           - enum:
               - qcom,sc7280-cpu-bwmon
               - qcom,sdm845-bwmon
+              - qcom,sm8550-cpu-bwmon
           - const: qcom,msm8998-bwmon
       - const: qcom,msm8998-bwmon       # BWMON v4
+      - items:
+          - enum:
+              - qcom,sm8550-llcc-bwmon
+          - const: qcom,sc7280-llcc-bwmon
       - const: qcom,sc7280-llcc-bwmon   # BWMON v5
       - const: qcom,sdm845-llcc-bwmon   # BWMON v5
 

---
base-commit: 3aec1f3082a7f388d04a1fa1a351aa25fd6335f0
change-id: 20221114-narmstrong-sm8550-upstream-bwmon-a7c6227fab6d

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>
