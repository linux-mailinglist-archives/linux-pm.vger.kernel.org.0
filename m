Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8AD205A4B
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jun 2020 20:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733125AbgFWSJQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Jun 2020 14:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733214AbgFWSIq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jun 2020 14:08:46 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97359C061573;
        Tue, 23 Jun 2020 11:08:45 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id l17so3824532wmj.0;
        Tue, 23 Jun 2020 11:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J8OcL2igjAskSXad9xrzVVWdlH7GJvm1mWz0l8/dfzA=;
        b=qlW0UT0INRLFF+18UA4WegQJDYUTYkGa2on8OgajVSza/LdEv0MWiQLmjbiZXiychi
         MZ0XwkY/FFJkgJXCubN2Lcmn8lrhgmBmyErSPqFD7telVRgLXQFHBSRNwGi4oepLFl1F
         oZH9WgVeI0xsT78HliB0EhzAp3l6NzZDOnIFl+iSQzBkjuZMpxyZn1YRb7o31c1W+yHJ
         TO1FzUfCQyz5YSOQ5AQyvPpyyxbfP3qLwX96ZMOWezf88JTykzysuhRYxsiqtkK0bfOL
         Z+SuRnEwSSD1bPcJ1UzE3Oxbt8/Z3fhj7NAe9Lq7Q4LLXlfgnWFGfQ3aazEiMpRcpurX
         qq0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J8OcL2igjAskSXad9xrzVVWdlH7GJvm1mWz0l8/dfzA=;
        b=hte+FF7NIXcplGxu1F3+0w6pdRq2AZCJ7yhdtnu1gt66++gZUo8MgND81pC3ZVqZnu
         C1B1zfW8KijG57WbkfoVsbL6oFSwni7UXPqU4d/PHQHd+c9Gyu5/OLWC96Jb7MgDIvmt
         drcSkZf0oMwT7yhxNejzo6p0W7HoJvooVGeV11en8XuKT0RpEJINmhIHe0m2gSPZ7V3D
         hBfi+eGiCBXr9xnAp1pkUoSSJ50vj5Na+/ztYMOjA21Ormj+GCmEPyIbjt2Gkh0czwYo
         tcF0uX+H/gv0jdj2d9xC0YsTQDQEHj1SZ+2p4rMAl/AMprufaT1d+DSTaxKYk+mPJEQT
         2gdw==
X-Gm-Message-State: AOAM532OMm2ar+fEE1x6urQcrxESdrvIk8xKJPu9URv69Sx2LvuZNkSb
        71iLOUhXHGYUnMkS5wFwvR4=
X-Google-Smtp-Source: ABdhPJwXRXk7kAY+Swq+1CCO+mVVjQWtgirNw0i03TSNku0/pz4e3x4VGJtYXemKG951DrgLzVPTrw==
X-Received: by 2002:a1c:96ce:: with SMTP id y197mr26789007wmd.55.1592935724369;
        Tue, 23 Jun 2020 11:08:44 -0700 (PDT)
Received: from localhost.localdomain (abag196.neoplus.adsl.tpnet.pl. [83.6.170.196])
        by smtp.googlemail.com with ESMTPSA id c16sm4719529wml.45.2020.06.23.11.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 11:08:44 -0700 (PDT)
From:   Konrad Dybcio <konradybcio@gmail.com>
To:     skrzynka@konradybcio.pl
Cc:     Konrad Dybcio <konradybcio@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 3/8] arm64: dts: qcom: sdm630: Add tsens node
Date:   Tue, 23 Jun 2020 20:08:27 +0200
Message-Id: <20200623180832.254163-4-konradybcio@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623180832.254163-1-konradybcio@gmail.com>
References: <20200623180832.254163-1-konradybcio@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Enable tsens on this SoC using tsens-v2 driver.

Signed-off-by: Konrad Dybcio <konradybcio@gmail.com>
---
 .../devicetree/bindings/thermal/qcom-tsens.yaml       |  1 +
 arch/arm64/boot/dts/qcom/sdm630.dtsi                  | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index d7be931b42d2..d89d5acd6e2a 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -39,6 +39,7 @@ properties:
               - qcom,msm8996-tsens
               - qcom,msm8998-tsens
               - qcom,sc7180-tsens
+              - qcom,sdm630-tsens
               - qcom,sdm845-tsens
           - const: qcom,tsens-v2
 
diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
index ea85f28032d2..92bf4ae6a590 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -566,6 +566,17 @@ anoc2_smmu: iommu@16c0000 {
 				<GIC_SPI 474 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		tsens: thermal-sensor@10ae000 {
+			compatible = "qcom,sdm630-tsens", "qcom,tsens-v2";
+			reg = <0x010ae000 0x1000>, /* TM */
+				  <0x010ad000 0x1000>; /* SROT */
+			#qcom,sensors = <12>;
+			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>,
+					 <GIC_SPI 430 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "uplow", "critical";
+			#thermal-sensor-cells = <1>;
+		};
+
 		tcsr_mutex_regs: syscon@1f40000 {
 			compatible = "syscon";
 			reg = <0x01f40000 0x20000>;
-- 
2.27.0

