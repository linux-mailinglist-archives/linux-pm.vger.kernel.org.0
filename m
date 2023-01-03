Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A04165B886
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jan 2023 02:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236511AbjACBJZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Jan 2023 20:09:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236460AbjACBJU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Jan 2023 20:09:20 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C5059FD3
        for <linux-pm@vger.kernel.org>; Mon,  2 Jan 2023 17:09:13 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id jo4so70149438ejb.7
        for <linux-pm@vger.kernel.org>; Mon, 02 Jan 2023 17:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VA+8K2hv48fLrDkZSZadZsjZ4I4yG7EsHjILu1Lcy8k=;
        b=Wss+XeFlnyffhaqysFEayCASUdOiUCysj/G4AwdIknXzjKiDrI+u2Mu+mWGLeQl/By
         vLi0ZELEt7uaPV03lIxrPKbiFg2xh/UxaaVCn9DLiwOXLC9gXK7mSDnbU7rzSjBDA6Yw
         6WKYJ9LIebrRDM4BW82GoeBBbd5+DncUkuZwdKFMhW3UqhWRwn+xvtJLG/tZmyS6yrpk
         YrH3UhcSVVpojnW5HrIOhlrLlZUWeqOK0y6UPHoU1igidlNfd6eGv5YKeSQpSXO24aGT
         x4af2T+bkNT4+wTFTJ1mCXMETidRhl3PVukhtT91So2sWhWuVeeqfEoM33zh4Q0A0VoY
         2uKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VA+8K2hv48fLrDkZSZadZsjZ4I4yG7EsHjILu1Lcy8k=;
        b=upqu+74rI6o0L5HRcyktlP5fNopQ8iRy+S24W6J5CW36kMhPs8pkYouuRu586KQuMn
         Ngg8CRR3TiE699EKpodbe4yrh5lIcGf7x4m2OSzdVDSAMM9PBCO61fXU7ZKk3rTUcgmm
         +PrezZCntbrIWsq5jgOKrd/ZZPAsLqqJxYyVT91+tDxwAZK5P+lqlPtvTl5oXH25pXi3
         JXWdfDoR+F+3t5I48ke2oDGTiHJw9tTUwRO55zSGlNZKe4dUz1xk2PwZGGdhyv0UplRQ
         3r7/8XVDTn2DB8SEm1hChphqrG2cXd6N3+2lCa/s58dAlDHLHJoQcUxLUpqKRDHahAvG
         +BOQ==
X-Gm-Message-State: AFqh2krorYPlzOIVfKMMHXDu06PZPIqWJX5B0WhTkPcWgLM5Pvg3cjr5
        yXu7SOozpaN3UfGdGQSjYysd8Q==
X-Google-Smtp-Source: AMrXdXtv38Mvh9+DDu01Iy912rW8xdF/I3+IYPN7USkF4WcOK19pg9rzTdweuTptiQXe8m/pAc6FRQ==
X-Received: by 2002:a17:906:e2d3:b0:7c0:deb3:596a with SMTP id gr19-20020a170906e2d300b007c0deb3596amr39743561ejb.70.1672708151926;
        Mon, 02 Jan 2023 17:09:11 -0800 (PST)
Received: from planet9.chello.ie (2001-1c06-2302-5600-b443-9db7-1e5c-4fd5.cable.dynamic.v6.ziggo.nl. [2001:1c06:2302:5600:b443:9db7:1e5c:4fd5])
        by smtp.gmail.com with ESMTPSA id q26-20020a17090676da00b008302732f569sm13564648ejn.78.2023.01.02.17.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 17:09:11 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        djakov@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     bryan.odonoghue@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, benl@squareup.com,
        shawn.guo@linaro.org, fabien.parent@linaro.org, leo.yan@linaro.org,
        dmitry.baryshkov@linaro.org
Subject: [PATCH v2 2/7] dt-bindings: arm: qcom: Document MSM8939 SoC binding
Date:   Tue,  3 Jan 2023 01:08:59 +0000
Message-Id: <20230103010904.3201835-3-bryan.odonoghue@linaro.org>
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

Document the MSM8939 and supported boards in upstream Sony "Tulip" M4 Aqua
and Square APQ8039 T2.

MSM8939 is one of the older SoCs so we need to expand the list of
qcom,board-ids to allow for the bootloader DTS board-id matching
dependency.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 27063a045bd0a..300b56718a8d3 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -35,6 +35,7 @@ description: |
         mdm9615
         msm8226
         msm8916
+        msm8939
         msm8956
         msm8974
         msm8976
@@ -160,6 +161,12 @@ properties:
               - samsung,s3ve3g
           - const: qcom,msm8226
 
+      - items:
+          - enum:
+              - sony,kanuti-tulip
+              - square,apq8039-t2
+          - const: qcom,msm8939
+
       - items:
           - enum:
               - sony,kugo-row
@@ -922,6 +929,7 @@ allOf:
               - qcom,apq8026
               - qcom,apq8094
               - qcom,apq8096
+              - qcom,msm8939
               - qcom,msm8992
               - qcom,msm8994
               - qcom,msm8996
-- 
2.34.1

