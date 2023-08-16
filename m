Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A90277EDAD
	for <lists+linux-pm@lfdr.de>; Thu, 17 Aug 2023 01:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347109AbjHPXGL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Aug 2023 19:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347146AbjHPXFo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Aug 2023 19:05:44 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B232D44;
        Wed, 16 Aug 2023 16:05:23 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-58d41109351so5152267b3.1;
        Wed, 16 Aug 2023 16:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692227122; x=1692831922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LGkWlW25TONP4qMhpLPr+s5h1/xjs6PgPavj7GKvPiE=;
        b=n0sDaWW8ORrKMNcCJW1egFbGJVjEoseeDVqV8Zwk5sE8OkoGMD6H3jgd6BC2dn3QOx
         GGYaSIJSRAd4gZkSFzwlxY5ngSHVqCFN+zFyyU3sIh9wWVWQfBJRHxmLO6L945Yac5N9
         XgFeeXOpRYubxOiclswyOJyD1KQ0b/bDlnGKGVCzGBXrgut+pPfAcvMhhgVdz4tOJIBc
         YkR3VqZ1cfD+zsr76STSUx1JxqQfbRnlcq4krzENz1B8d4u2lCKFxX85feKPiX2rs4WU
         VBzFC0r88mazZhayP1m953TqXm/0Qjm1OZ5l038X+BHGSGj15IbIYIahjzjNVGcOhh60
         o1gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692227122; x=1692831922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LGkWlW25TONP4qMhpLPr+s5h1/xjs6PgPavj7GKvPiE=;
        b=cquhs7Sqi5lXlg/4L6jUF5lvc5H8FvwJ+wBu4GfnEqCBCI4xWL2D6SJVokFDgxVCr6
         HVHqpoE36K2IR+l4mUP6GsxNHlaoIKsA3eFdlb/f1W01tVObeXVG73UA5i/7tL3GCUm7
         F0N8ypl5euD7AYC2pruekllJb9EDuqa1PhNmvaKLJgdVR86xsLPnzX4irGQI00a/8KAw
         irAEYGQYm6A3ED+i2OsYbkQ5II/0PD7axBMYinQkGpxbKyfU7y1brKEYZyhj4UWfJNeg
         xg7/QVMHqY7p7f2MfYMf8WGpsFDGjF7GBoQPe/aQ/Zu+WcUaFnrjnXngElb6odbwPRAS
         ciEA==
X-Gm-Message-State: AOJu0Yw8J+zmDi+SMmzYQVCw6Gn1RzreQC6FER+M4MvilWzbayzodzVr
        n7HTFsk2VcHLxPWF1plu+mk=
X-Google-Smtp-Source: AGHT+IEHY0RoqLLSldQEEIjnh5LaHzkWRPagaKWXcQy4TkEXei5OlrHbCjoX2qHB6LXROqJtazzrzQ==
X-Received: by 2002:a0d:eb94:0:b0:577:3cd0:3728 with SMTP id u142-20020a0deb94000000b005773cd03728mr1240736ywe.14.1692227122254;
        Wed, 16 Aug 2023 16:05:22 -0700 (PDT)
Received: from localhost ([2607:fea8:529e:7800::5ee])
        by smtp.gmail.com with ESMTPSA id i64-20020a0df843000000b005704c4d3579sm4286085ywf.40.2023.08.16.16.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 16:05:21 -0700 (PDT)
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
Subject: [PATCH v2 2/3] dt-bindings: cpufreq: cpufreq-qcom-hw: add SDM670 compatible
Date:   Wed, 16 Aug 2023 19:04:16 -0400
Message-ID: <20230816230412.76862-8-mailingradian@gmail.com>
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

The bindings for Qualcomm CPU frequency have a compatible for each SoC.
Add the compatible for SDM670.

Fixes: 0c665213d126 ("arm64: dts: qcom: sdm670: add cpu frequency scaling")
Signed-off-by: Richard Acayan <mailingradian@gmail.com>
---
 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
index a6b3bb8fdf33..3ce288c5e591 100644
--- a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
@@ -23,6 +23,7 @@ properties:
           - enum:
               - qcom,qcm2290-cpufreq-hw
               - qcom,sc7180-cpufreq-hw
+              - qcom,sdm670-cpufreq-hw
               - qcom,sdm845-cpufreq-hw
               - qcom,sm6115-cpufreq-hw
               - qcom,sm6350-cpufreq-hw
@@ -125,6 +126,7 @@ allOf:
               - qcom,qdu1000-cpufreq-epss
               - qcom,sc7180-cpufreq-hw
               - qcom,sc8280xp-cpufreq-epss
+              - qcom,sdm670-cpufreq-hw
               - qcom,sdm845-cpufreq-hw
               - qcom,sm6115-cpufreq-hw
               - qcom,sm6350-cpufreq-hw
-- 
2.41.0

