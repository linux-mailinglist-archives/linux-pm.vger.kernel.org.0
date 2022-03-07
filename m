Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2DF4CF22D
	for <lists+linux-pm@lfdr.de>; Mon,  7 Mar 2022 07:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235630AbiCGGqx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Mar 2022 01:46:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235674AbiCGGqt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Mar 2022 01:46:49 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22A860070
        for <linux-pm@vger.kernel.org>; Sun,  6 Mar 2022 22:45:53 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id q11so12903474pln.11
        for <linux-pm@vger.kernel.org>; Sun, 06 Mar 2022 22:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B/IcWlT+PDOAuKFhHBO22sb+SfpqtrQ61LlKL6Ry12Q=;
        b=JsZNPwd5gfGEQEV5Z9NtHoEKzQp9pRyGwnF/qdJEKZyT4TNa9nDqik67h5gMNdoUm6
         NlixliIa5cxfBDuS4po8LIk0YREQqQ+gEClfclJ5LlkAZaseIs2KaMkwE683RK2asf8g
         Gz8IOIa0fSiT2Ji2fXbK9hqnJDWEq1Gm5BKhxCVXDGoRlU/6HiShWq6fuNbTLKT9jHXk
         GgvB2Fu4o0T+F81SP4qe8nJ5oVTlW13lhWEzpH1oCLtmMdUvPVIjGIiniUmurmIMiLCJ
         vqJ0XsFTnSnfdviynYk9t+fZ774u90CP85yz5r9v0OifdUUIQXcNi4yuWH8FrNgq6j1a
         A5LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B/IcWlT+PDOAuKFhHBO22sb+SfpqtrQ61LlKL6Ry12Q=;
        b=RNKYd6JZW4xh8B2gNN0lhHk83ZIbgrsjMcqyN5CnJp+E5j67qeGNeMkIoE7eG3/21D
         mQAQJnV/iIluw3j7Nm6Scrb4sVvbIpGReClmG6twVhLL/9CBateW647wFfeiGAma0Aa6
         9wRn6iaY3aVf1MvuKlk0SEVZyoZAv47i1YfM1tmfO2m/l6wTGEu3/NqD8CB9UtOgVfD1
         qpWJPjREL2nnpMu+R72KqRwHp3/4qpCLzH9g3xV/GGUSQcVW895/LQypv4iG6GOBCDi6
         qj0jwMP85F8xbGNSzQEm/1nnme9Y2TrATr083y4vNld7vkNY7i4MTPt7EYTpN5gdwTcx
         8vWA==
X-Gm-Message-State: AOAM533wF60/ZODpPkP2bC5o95Of8MyAVm+pMWATU9YwbOZDfA5qJMdR
        Kw6l0KNLjTIr+Zk0dqTNHwP0
X-Google-Smtp-Source: ABdhPJwICh1wSPhlonqp9TgsEIy8sDO7RgWb6BtGrzYP7f1sVpnlEmkpZWF1SGuppoBXuL9xqT+evw==
X-Received: by 2002:a17:90a:4d07:b0:1bf:6ac4:b94a with SMTP id c7-20020a17090a4d0700b001bf6ac4b94amr2781619pjg.89.1646635553384;
        Sun, 06 Mar 2022 22:45:53 -0800 (PST)
Received: from localhost.localdomain ([117.207.25.157])
        by smtp.gmail.com with ESMTPSA id s7-20020a056a00178700b004e1a15e7928sm15841940pfg.145.2022.03.06.22.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Mar 2022 22:45:52 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     rafael@kernel.org, viresh.kumar@linaro.org, robh+dt@kernel.org
Cc:     bjorn.andersson@linaro.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        angelogioacchino.delregno@somainline.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Hector Yuan <hector.yuan@mediatek.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH 2/2] dt-bindings: dvfs: Use MediaTek CPUFREQ HW as an example
Date:   Mon,  7 Mar 2022 12:15:31 +0530
Message-Id: <20220307064531.47678-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220307064531.47678-1-manivannan.sadhasivam@linaro.org>
References: <20220307064531.47678-1-manivannan.sadhasivam@linaro.org>
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

Qcom CPUFREQ HW don't have the support for generic performance domains yet.
So use MediaTek CPUFREQ HW that has the support available in mainline.

This also silences the below dtschema warnings for "cpufreq-qcom-hw.yaml":

Documentation/devicetree/bindings/dvfs/performance-domain.example.dt.yaml: performance-controller@12340000: reg: [[305397760, 4096]] is too short
        From schema: Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
Documentation/devicetree/bindings/dvfs/performance-domain.example.dt.yaml: performance-controller@12340000: 'clocks' is a required property
        From schema: Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
Documentation/devicetree/bindings/dvfs/performance-domain.example.dt.yaml: performance-controller@12340000: 'clock-names' is a required property
        From schema: Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
Documentation/devicetree/bindings/dvfs/performance-domain.example.dt.yaml: performance-controller@12340000: '#freq-domain-cells' is a required property
        From schema: Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
Documentation/devicetree/bindings/dvfs/performance-domain.example.dt.yaml: performance-controller@12340000: '#performance-domain-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
        From schema: Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml

Cc: Hector Yuan <hector.yuan@mediatek.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../bindings/dvfs/performance-domain.yaml          | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/dvfs/performance-domain.yaml b/Documentation/devicetree/bindings/dvfs/performance-domain.yaml
index c8b91207f34d..9e0bcf1a89fe 100644
--- a/Documentation/devicetree/bindings/dvfs/performance-domain.yaml
+++ b/Documentation/devicetree/bindings/dvfs/performance-domain.yaml
@@ -52,10 +52,16 @@ additionalProperties: true
 
 examples:
   - |
-    performance: performance-controller@12340000 {
-        compatible = "qcom,cpufreq-hw";
-        reg = <0x12340000 0x1000>;
-        #performance-domain-cells = <1>;
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        performance: performance-controller@11bc00 {
+            compatible = "mediatek,cpufreq-hw";
+            reg = <0 0x0011bc10 0 0x120>, <0 0x0011bd30 0 0x120>;
+
+            #performance-domain-cells = <1>;
+        };
     };
 
     // The node above defines a performance controller that is a performance
-- 
2.25.1

