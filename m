Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7B5695E60
	for <lists+linux-pm@lfdr.de>; Tue, 14 Feb 2023 10:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbjBNJKT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Feb 2023 04:10:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232397AbjBNJKA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Feb 2023 04:10:00 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94022241E0
        for <linux-pm@vger.kernel.org>; Tue, 14 Feb 2023 01:08:54 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id n10so11452364ejc.4
        for <linux-pm@vger.kernel.org>; Tue, 14 Feb 2023 01:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rWt3LYH3/eszNoBF9DRl58MX49iUtC5j5NaUzoPgKC4=;
        b=BLKgk2uYVpYd623GhmXngbIem3o5/4Ja7wB5VVqk5/GGO3MIFMhn+cqLX6OGFYNXrp
         VBUx001ombc1Sz9nqm/BGmlQy6PIrQalqePysVkGDYA26+La3PhmcP3OUcn1NhdDoGGb
         6c4MeKMCjOOPMF4Tf3EdaBgbhsL4FBek1InjKBBv3IPFDF4XumE4hFj/a/azdWqT9Cop
         4qJYHV/4Enqd1NlMC5HWvNN3Wh31/uE3M0nRqtKRLNn4nCpYxh3GL45yzAlsHk1BHRMf
         NRnTgQ7fD5CXmQs6FwSCVbRQr2GGob3mfeEQdWwV30qGDkDVq5KSQuf6k4NfACzoC3Zv
         SsgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rWt3LYH3/eszNoBF9DRl58MX49iUtC5j5NaUzoPgKC4=;
        b=EGvuEDbvRlqge8UaISxUXnOxxnlUdjNw8/xVcLUkdoklH7gIyxySMFofUE4Pj0Ndrm
         5WLBU0Guj7LGV/QmklcsD1Jk9k8f0nOKeGmoQ9N5uxw/kOGZIp31N/zBlbYBgHdgQbsK
         EaDstJJrxr2L2g14XNtsqwx00CcwUCku9DVJRO7YtcXwKeQXPdDj923DFViRbkadsgM7
         iL2mMq4SUgpoe0+9uDphPwFmAfAqkSKBZf4DihPx0VI+Hj0wkA5Zx/O+0qbenh1RoQs1
         uRDR2NcA3rS+uUEhAK/DEckwmV/u9xrunxcC58y987gdJT0RWBbWC6Is9WVcSzhy5TQR
         VXyw==
X-Gm-Message-State: AO0yUKWFeW7y1vZ6/xLUyuppCX7JMGKdcMGmnXE2bgYkdH2LoeTRmjwB
        ry1jlMmLN7PUUnoB04zdbbStOA==
X-Google-Smtp-Source: AK7set9Tp2XWrms9/AHj3EygmaZhp6J5Dtlo4+AuLB/kDv9YuT76Sh6vm1MiOGttQGNwsgdEwlfJeA==
X-Received: by 2002:a17:906:5fca:b0:8aa:9a03:356a with SMTP id k10-20020a1709065fca00b008aa9a03356amr2277522ejv.49.1676365733194;
        Tue, 14 Feb 2023 01:08:53 -0800 (PST)
Received: from localhost.localdomain (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id d6-20020a170906040600b008838b040454sm7998110eja.95.2023.02.14.01.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 01:08:52 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] dt-bindings: power: supply: pm8941-coincell: Add PM8998 compatible
Date:   Tue, 14 Feb 2023 10:08:47 +0100
Message-Id: <20230214090849.2186370-1-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.1
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

Add a specific compatible for the coincell charger present on PM8998.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
v1 -> v2:

- Pick up ab

 .../bindings/power/supply/qcom,pm8941-coincell.yaml       | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/power/supply/qcom,pm8941-coincell.yaml b/Documentation/devicetree/bindings/power/supply/qcom,pm8941-coincell.yaml
index 0450f4dd4e51..b7b58aed3f3c 100644
--- a/Documentation/devicetree/bindings/power/supply/qcom,pm8941-coincell.yaml
+++ b/Documentation/devicetree/bindings/power/supply/qcom,pm8941-coincell.yaml
@@ -16,7 +16,13 @@ maintainers:
 
 properties:
   compatible:
-    const: qcom,pm8941-coincell
+    oneOf:
+      - items:
+          - enum:
+              - qcom,pm8998-coincell
+          - const: qcom,pm8941-coincell
+
+      - const: qcom,pm8941-coincell
 
   reg:
     maxItems: 1
-- 
2.39.1

