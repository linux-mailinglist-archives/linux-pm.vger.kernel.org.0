Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7D9416761
	for <lists+linux-pm@lfdr.de>; Thu, 23 Sep 2021 23:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243283AbhIWVYK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 Sep 2021 17:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243310AbhIWVYJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Sep 2021 17:24:09 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68839C061574
        for <linux-pm@vger.kernel.org>; Thu, 23 Sep 2021 14:22:37 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id g62-20020a9d2dc4000000b0054752cfbc59so4734337otb.1
        for <linux-pm@vger.kernel.org>; Thu, 23 Sep 2021 14:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PNc03WntMHltar98IQXNaOEr4ocp4Ko7bP2GtS5B5+E=;
        b=zxobRb9I2u607sNWX34uw3V7DrFe5hlimKl1vglXqbIyRHHwiiJqHplGPNteyqYM4a
         xjmn3q+Nvvq0ZHuaVh1dL+z+fLXdkD9RJVbheWNjqObezBTRXvM4WU9AqOxHllASdWG4
         aATlfoMwSqwI9p/TLa1DgRJgKR7rcC+fXPyXhrsDdeMONz8m2ZBgHX6++Bq+si0p5bnI
         4T7UZYhnJ5R38dgiKrd7kYFT6fsw+tGIcGjQWX2fqVGD4WVxWgeEg2RJQX0IiITKVDo/
         SYS0azz6uBIkSs8Z4rmKgI1FHhg7k8A9Sz20e00GT+eXSnR7SUg65SbKtoaGas/xIfyd
         owjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PNc03WntMHltar98IQXNaOEr4ocp4Ko7bP2GtS5B5+E=;
        b=VLeVa0D5wp55Roix7LrvmhzOopRvOpSeQDZGX6/1aU0+gWLonioEyd2woywvfeERWO
         WqFpTnu0sUlCmT+ApMMpQBKIYe6ClFVjWqkmZVik1aKm5cN8XN6Hdvu488JZXhZEPrEi
         D0uzEDSMOytNuu7W8+zv3Rd3XTlfW0fabyykJOaLLPhI9jKDO2LxSnNi9AUizvRcs+PI
         gilPL5xA+y5/dS4UwLvwe1r6+ui+5W6W4Sph9DSePNBj2AMFbOpk3tLS53OUjm0lJ2n4
         5oSVB/oivsNwTttFrh/on0FnoTxPcvUybT3zCGopq1yGOZozKEJwecDrY/gYCiZfk2ZS
         QNYQ==
X-Gm-Message-State: AOAM533dKz4Uo3xexhfJRc5UyFFKsjr2Ofwz07Zu3xMtc448Ht5lEA9+
        kHfCIEk050V7HDE2AQRw7Yy28A==
X-Google-Smtp-Source: ABdhPJyf1LTxlgk2XjXKCL76EdnMX9E/fiLyKS/GDsWDWOM7YxkZkZHaubP93N8qcu4ZRw0hldHHww==
X-Received: by 2002:a9d:7d8d:: with SMTP id j13mr791717otn.220.1632432156748;
        Thu, 23 Sep 2021 14:22:36 -0700 (PDT)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id e16sm1586820oie.17.2021.09.23.14.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 14:22:36 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] arm64: dts: qcom: pm8998: Add ADC Thermal Monitor node
Date:   Thu, 23 Sep 2021 14:23:10 -0700
Message-Id: <20210923212311.2877048-4-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210923212311.2877048-1-bjorn.andersson@linaro.org>
References: <20210923212311.2877048-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add a node for the ADC Thermal Monitor found in the PM8998 PMIC. This is
used to connect thermal zones with ADC channels.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- New patch

 arch/arm64/boot/dts/qcom/pm8998.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi b/arch/arm64/boot/dts/qcom/pm8998.dtsi
index 6f5bb6b37ec2..d09f2954b6f9 100644
--- a/arch/arm64/boot/dts/qcom/pm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8998.dtsi
@@ -84,6 +84,16 @@ adc-chan@6 {
 			};
 		};
 
+		pm8998_adc_tm: adc-tm@3400 {
+			compatible = "qcom,spmi-adc-tm-hc";
+			reg = <0x3400>;
+			interrupts = <0x0 0x34 0x0 IRQ_TYPE_EDGE_RISING>;
+			#thermal-sensor-cells = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		rtc@6000 {
 			compatible = "qcom,pm8941-rtc";
 			reg = <0x6000>, <0x6100>;
-- 
2.29.2

