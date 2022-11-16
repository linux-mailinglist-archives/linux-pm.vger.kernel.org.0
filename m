Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92A6262BCC8
	for <lists+linux-pm@lfdr.de>; Wed, 16 Nov 2022 12:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbiKPL7p (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Nov 2022 06:59:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233169AbiKPL7V (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Nov 2022 06:59:21 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350AB3E0BA
        for <linux-pm@vger.kernel.org>; Wed, 16 Nov 2022 03:50:57 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id d9so24786080wrm.13
        for <linux-pm@vger.kernel.org>; Wed, 16 Nov 2022 03:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6jPDIKJUZBHxGJeoj0/C8sMbmIsMxr7SVE4DgWHm9YY=;
        b=dauxGlns5AnwTSHimiJFbk2VzkM5bX2Y+sYb38tBg5HSxuqB0sGlwju7x1JvwbDOu7
         GiBgGnUmSKtcz0gx4DeKjsoAtUIaiaeQ5IR0npjRXZbRVquF/qoHo/K/eXTWi324r50m
         b794EDP0Qrmk0gGsdvjkvrCOz6+hdFtxvrUY6wgp/fPEJ95jU2Wbdo+xDkaff7Aw3b1d
         vsbW/7d3RcWHjZkIIXy2pJaZenGV5s9ptFPgzb0BvRrKv9/NHcwuHH2k7W0oxrH97r3Y
         zEPPr0aXHFQBK32sUy3Foyf3p4CeHsE3LzyVLcGAX002uSgUTN/QjIJXrYxqEBz1zuQo
         8s0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6jPDIKJUZBHxGJeoj0/C8sMbmIsMxr7SVE4DgWHm9YY=;
        b=C50+A0kTAWRUbJxmcaNpc2nJx2yjU/X/yrEmLhSyslVYKB1MAM2j41zvTzwMVoBNAh
         h0t+ZuIyns9T7rHkFiOiEsnC5PlxKTxglvFBenerCs1YRj84imGjJQDann/EBMQWtXNi
         g3BHyXHZZnZFAGvOx+QSQn/broCoTSsI1BpxLG3bDjYayo+ZeQ91YMtaGek1de2LZ25U
         n8oAQvGfAQVou5u46mxlqRjNn0yldbHRXf3P6Cc52qUTCi99kAEJfoNvQy1H/66I0PNu
         hEp9Uk4sSFdeNKTNtO783sqw6MsG31Og3QyK2buFMT3aXlh1ACrzSRwPjK013kMLbDcj
         IMMg==
X-Gm-Message-State: ANoB5pnUjzLl7zORlK7LW8bXBMS4a/o0CyxoAd+DojhuFO4emjyx2FjO
        aVkKU2r+mwZCl4p9sx/rkK+GRHb0rdtbGg==
X-Google-Smtp-Source: AA0mqf6M3TtLZSiU426echhPBBPflnFXiIKqSaDZH0CekD01/gfMNW/Ls51osoSBqsH2dX2DuBBeFw==
X-Received: by 2002:adf:decc:0:b0:236:69fd:643e with SMTP id i12-20020adfdecc000000b0023669fd643emr13006031wrn.560.1668599455528;
        Wed, 16 Nov 2022 03:50:55 -0800 (PST)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id v3-20020a1cf703000000b003cf774c31a0sm1745029wmh.16.2022.11.16.03.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 03:50:54 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH] dt-bindings: cpufreq: cpufreq-qcom-hw: Add SM8550 compatible
Date:   Wed, 16 Nov 2022 13:50:46 +0200
Message-Id: <20221116115046.2687244-1-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Add compatible for EPSS CPUFREQ-HW on SM8550.
Also document the interrupts.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 .../devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml       | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
index e58c55f78aaa..83d814afc780 100644
--- a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
@@ -27,6 +27,7 @@ properties:
           - enum:
               - qcom,sm6375-cpufreq-epss
               - qcom,sm8250-cpufreq-epss
+              - qcom,sm8550-cpufreq-epss
           - const: qcom,cpufreq-epss
 
   reg:
@@ -53,6 +54,12 @@ properties:
       - const: xo
       - const: alternate
 
+  interrupts:
+    maxItems: 3
+
+  interrupt-names:
+    maxItems: 3
+
   '#freq-domain-cells':
     const: 1
 
-- 
2.34.1

