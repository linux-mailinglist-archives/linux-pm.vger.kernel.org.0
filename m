Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2E8525B61
	for <lists+linux-pm@lfdr.de>; Fri, 13 May 2022 08:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377198AbiEMGOY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 May 2022 02:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377207AbiEMGOQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 May 2022 02:14:16 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228A226FA22
        for <linux-pm@vger.kernel.org>; Thu, 12 May 2022 23:14:15 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id k2so10018938wrd.5
        for <linux-pm@vger.kernel.org>; Thu, 12 May 2022 23:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2QnLrd3aQG4x4XRKBeZ9JG1UWhf0XATvYFxcEhWYbS4=;
        b=F9+/MjIyLcTvcR1BJUDgg0hsFVaPyYtyTtFv2BGsFvgPi1jYrt9LIO7KKPxj40kLGj
         qW16X7HTzpFZcQXbRkMY7x5C+OiDC1hiishMwQt9XXr1HsFf5xCLnmgpktv9gurX7350
         B5GNOBgSoNBSIdzlr1P/uNFsBkjbOtzG+Kzy6idCPJ7q8CeiHs6gtzwc4X2v4cASoWfW
         jgJCriYt1rst1Tyg/q3RwW+Lzoqs3M8riw7W4c2kAV5s9NWf0YQD4NlsIEqFFAnMVVJ+
         OxpYhfHTf6Zk2gt/rqjEaAtZKYnmvY8tiuG+uLzmFPp53H1Nlvtz9A56Pu1Mm8CSStC9
         GbEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2QnLrd3aQG4x4XRKBeZ9JG1UWhf0XATvYFxcEhWYbS4=;
        b=L6KO1yEuW/YBwYLbjZ8qvgbYeOgS+uqMtA7UHt0mdlwj6hu5rphpuopa4z3vMW8MhL
         jHOjPYY4+Ksx5CocrxYynWHH2t/QlqecqLbnH4188DzqDFoOt4a6xo/ffk9kqAgvGPIn
         dMI2OENtA2F/d50mKd3DLb8Nuaffn6HTmumleNI1Pwyw+8Ucg5mfSCehbFPk/7xuhWoq
         5JHSjGcw3BV6Tn799OOirDlkza/XoLts8qYDh2KNj2Ys90+T3o9ib8avC37eJ+CnR36n
         h3FhNL+Vf02Mrftgp+nU+WkbPsgEReN1O3YjZ9oZAyT3lZTX/yE7o1Rwzn+Wopa8aoXi
         zLLA==
X-Gm-Message-State: AOAM533lKILvmVvfDIAU/wJyFr+OJVXEbLbXlNaY2UEYHUr+b9GA7MXn
        jEbMwfDtg4w5hG6vywX9WwOVmQ==
X-Google-Smtp-Source: ABdhPJyxlT4LTSxCcbfKaqSmTY40Q1OhX2cXOOeh7WoWgy+4treWyWheDFYdpt7Ykc/JFDcvcDXSNw==
X-Received: by 2002:adf:facd:0:b0:20a:de99:403c with SMTP id a13-20020adffacd000000b0020ade99403cmr2477557wrs.123.1652422453624;
        Thu, 12 May 2022 23:14:13 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id g4-20020adfbc84000000b0020c5253d8f3sm1477760wrh.63.2022.05.12.23.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 23:14:12 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-scsi@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 2/7] dt-bindings: opp: accept array of frequencies
Date:   Fri, 13 May 2022 08:13:42 +0200
Message-Id: <20220513061347.46480-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220513061347.46480-1-krzysztof.kozlowski@linaro.org>
References: <20220513061347.46480-1-krzysztof.kozlowski@linaro.org>
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

Devices might need to control several clocks when scaling the frequency
and voltage.  Allow passing array of clock frequencies, similarly to the
voltages.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>

---

Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/opp/opp-v2-base.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/opp/opp-v2-base.yaml b/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
index 76c8acd981b3..66d0ec763f0b 100644
--- a/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
+++ b/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
@@ -50,6 +50,16 @@ patternProperties:
           property to uniquely identify the OPP nodes exists. Devices like power
           domains must have another (implementation dependent) property.
 
+          Entries for multiple clocks shall be provided in the same field, as
+          array of frequencies.  The OPP binding doesn't provide any provisions
+          to relate the values to their clocks or the order in which the clocks
+          need to be configured and that is left for the implementation
+          specific binding.
+        minItems: 1
+        maxItems: 16
+        items:
+          maxItems: 1
+
       opp-microvolt:
         description: |
           Voltage for the OPP
-- 
2.32.0

