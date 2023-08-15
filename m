Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1480B77D621
	for <lists+linux-pm@lfdr.de>; Wed, 16 Aug 2023 00:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240424AbjHOWb7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Aug 2023 18:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240472AbjHOWbr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Aug 2023 18:31:47 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC5B2132;
        Tue, 15 Aug 2023 15:31:37 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-6432a429f61so23719866d6.2;
        Tue, 15 Aug 2023 15:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692138696; x=1692743496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wd92bI5dLehLsF4hnvIr+iTqCos24EAh8tgkdn7mWwI=;
        b=jwUo9FHCANPSyKGp50jDSIuA68sQ0XO6+ov83c+1u+jNZrNZwVc2dl5f7NlA4YR5Hk
         B5HT49uw8P3BGHTnMBD/pKhY6ZxtHgbf7v2N4aOPint8Po1xOlf8jzHh1/WKflRTjGRC
         2qzjiH+k168nvTcnmSU3VjN9gg7QvcTifUId6oLiIK8cyqREBpmSNhKBT5bxBB1ra6j+
         MZ8mswb0YKxzXBpq3kGWQUdxbJ/ZDHlidfZ5OTa/yzURD+CcGcQWBMoW10QZXK4MFZrD
         vJrPA3VwdmH3bIb/9xZyRjWyFdr63q4MeiPZolp+5PsU46rlDCKrSe3QPDWtgnxQXs8y
         5BJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692138696; x=1692743496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wd92bI5dLehLsF4hnvIr+iTqCos24EAh8tgkdn7mWwI=;
        b=Xh5VG7/M+HvdWI8+i4QbeLvV77tQ76HiYC4aYMUNHSDtp6bsAK1yl6nT6je6YyrnUr
         8UIoMHE66IdFxGhqi+r2zKsvTBgX6BEwIAVBrFbDa+Z5wpXdEXl+/ikF89AVWzwYnzEs
         H4YYqKN8dE7M4TyK7laJXxZ4m8fZRXT9Lxy2vybvhVeGqKvvLhYKTHKdmF8Oia7BikGs
         XHH4lJZg8snBYlwramHNPgSWksKyqphRmF2ceHSkM9wiiE/y9EjNDK4wmknM6vGlyDzF
         OFVxttL8ETAluJJE9M1VaHWFVYrlKBCRXhqN6GJjFQpisngHiiSH3M6uIp3VfLvERpML
         29fg==
X-Gm-Message-State: AOJu0Yz0gb70Ec5mTuLycV7JCGmZcvnSJnFg7z9xdyZ9ZbepOs2MHEhc
        0UKDHBI+iFnyXkM+b0D7lm8=
X-Google-Smtp-Source: AGHT+IEukpCIlO8jXbUN/akpLNc30XLADv+QYlMxgAOmm0lkEFR31QihCVI+C0M6bagHOvtfzBUwOw==
X-Received: by 2002:a0c:f044:0:b0:639:91ad:64d6 with SMTP id b4-20020a0cf044000000b0063991ad64d6mr88387qvl.61.1692138696015;
        Tue, 15 Aug 2023 15:31:36 -0700 (PDT)
Received: from localhost ([2607:fea8:529e:7800::bdee])
        by smtp.gmail.com with ESMTPSA id a9-20020a0cca89000000b00647432144cfsm255900qvk.99.2023.08.15.15.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 15:31:35 -0700 (PDT)
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
Subject: [PATCH 2/3] dt-bindings: cpufreq: cpufreq-qcom-hw: add SDM670 compatible
Date:   Tue, 15 Aug 2023 18:31:11 -0400
Message-ID: <20230815223108.306018-7-mailingradian@gmail.com>
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

The bindings for Qualcomm CPU frequency have a compatible for each SoC.
Add the compatible for SDM670.

Signed-off-by: Richard Acayan <mailingradian@gmail.com>
---
 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
index a6b3bb8fdf33..764a1589f8a2 100644
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
-- 
2.41.0

