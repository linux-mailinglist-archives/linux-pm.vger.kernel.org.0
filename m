Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0E5B2CE62E
	for <lists+linux-pm@lfdr.de>; Fri,  4 Dec 2020 03:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbgLDC5g (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Dec 2020 21:57:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727353AbgLDC5g (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Dec 2020 21:57:36 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E658DC09426A
        for <linux-pm@vger.kernel.org>; Thu,  3 Dec 2020 18:55:45 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id y7so4911146lji.8
        for <linux-pm@vger.kernel.org>; Thu, 03 Dec 2020 18:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zaHs3+jp5gi1zoB752JHaairqtuKahDKgtbpGx914Yw=;
        b=ii+XBoBPtaDrzNohuwi0YnNIgc/LAAE/WQ2KTId1gFlSgJOIsaexIz7P+is5biVxSl
         y3E6YMpsDOuKDkOpKp8oeZG1kt8VqOpM50eIVzWgnOzBZSUuMwOStC3dRKO+Xku/LHTd
         q5/AbJCDZaNZEM/Cgiq5ARaTmHjU6e59r2Uy9u5Vlq44REgLorKPLIsZdJY/XmXAyrEH
         OSs/vlrqyXs7A1hGF+PnWhx/WR+9DA7CjE3yII4EVY/c5KYDsIQkAnZDKo/MP59C27mK
         dPBhOalVp4JEsrvpdtgZldZony9cnVAmNW04ZN9KgxMYk66awNJZPB3Eh2Gw6t1Sa4/0
         H3YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zaHs3+jp5gi1zoB752JHaairqtuKahDKgtbpGx914Yw=;
        b=emdOpATBOIbIJnhBfKSb1jtO+dZsxso+AIt9XaanEOrP37FCY6oyaWMhKLN6ye0mBW
         qJ7f5GBOdq0MpaJfwVMyjJMLCZkaU151bjxE/CsazKG3IByNcM/UfFImzEmMnXyj02xX
         GQMGef5amWKjbkwg60LiIGL96x+u61RDnMyxQAxaoOi2y3sZxGGHSo8yNeQpAhvYZneB
         lyd9f4tbEFP2C6dBV3JaGRAX5O5ADXL98jmy66oE0FH159Qj71Lvd5EunVtT0Pphnr5w
         rAcCg6mFK62i9G7EAT/N3K7UoJmxQK61Wk4tDmTVD33gp5k9HHMBdcOXQSfbK7wCkzei
         WzFw==
X-Gm-Message-State: AOAM531/UsfrDjyZSopCQsR1M9Mc3QnOxV1Se6VoI+xH4y7wbJ0M3+xc
        WJSiwG+lufrpAAS1Ec9+ZA2FOQ==
X-Google-Smtp-Source: ABdhPJyPhdLZKt5h53MKLUjJcdAbVn7Jn5Elv/MV0B95RjEAEwxUt0L6meOeDt2ldk2j+ult8eRDSg==
X-Received: by 2002:a2e:731a:: with SMTP id o26mr2355904ljc.98.1607050544464;
        Thu, 03 Dec 2020 18:55:44 -0800 (PST)
Received: from eriador.lumag.spb.ru ([188.162.64.117])
        by smtp.gmail.com with ESMTPSA id b8sm1131667ljo.68.2020.12.03.18.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 18:55:43 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Jishnu Prakash <jprakash@qti.qualcomm.com>
Subject: [PATCH v10 13/15] arm64: dts: qcom: pm8150x: add definitions for adc-tm5 part
Date:   Fri,  4 Dec 2020 05:55:07 +0300
Message-Id: <20201204025509.1075506-14-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201204025509.1075506-1-dmitry.baryshkov@linaro.org>
References: <20201204025509.1075506-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Define adc-tm5 thermal monitoring part. Individual channes and thermal
zones are to be configured in per-device dts files.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/pm8150.dtsi  | 10 ++++++++++
 arch/arm64/boot/dts/qcom/pm8150b.dtsi | 10 ++++++++++
 arch/arm64/boot/dts/qcom/pm8150l.dtsi | 10 ++++++++++
 3 files changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pm8150.dtsi b/arch/arm64/boot/dts/qcom/pm8150.dtsi
index 1b6406927509..b1b518c6a2c9 100644
--- a/arch/arm64/boot/dts/qcom/pm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8150.dtsi
@@ -97,6 +97,16 @@ die-temp@6 {
 			};
 		};
 
+		pm8150_adc_tm: adc-tm@3500 {
+			compatible = "qcom,spmi-adc-tm5";
+			reg = <0x3500>;
+			interrupts = <0x0 0x35 0x0 IRQ_TYPE_EDGE_RISING>;
+			#thermal-sensor-cells = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		rtc@6000 {
 			compatible = "qcom,pm8941-rtc";
 			reg = <0x6000>;
diff --git a/arch/arm64/boot/dts/qcom/pm8150b.dtsi b/arch/arm64/boot/dts/qcom/pm8150b.dtsi
index e112e8876db6..8e2f3250c914 100644
--- a/arch/arm64/boot/dts/qcom/pm8150b.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8150b.dtsi
@@ -95,6 +95,16 @@ chg-temp@9 {
 			};
 		};
 
+		pm8150b_adc_tm: adc-tm@3500 {
+			compatible = "qcom,spmi-adc-tm5";
+			reg = <0x3500>;
+			interrupts = <0x2 0x35 0x0 IRQ_TYPE_EDGE_RISING>;
+			#thermal-sensor-cells = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		pm8150b_gpios: gpio@c000 {
 			compatible = "qcom,pm8150b-gpio";
 			reg = <0xc000>;
diff --git a/arch/arm64/boot/dts/qcom/pm8150l.dtsi b/arch/arm64/boot/dts/qcom/pm8150l.dtsi
index 62139538b7d9..9f214ceec2b7 100644
--- a/arch/arm64/boot/dts/qcom/pm8150l.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8150l.dtsi
@@ -89,6 +89,16 @@ die-temp@6 {
 			};
 		};
 
+		pm8150l_adc_tm: adc-tm@3500 {
+			compatible = "qcom,spmi-adc-tm5";
+			reg = <0x3500>;
+			interrupts = <0x4 0x35 0x0 IRQ_TYPE_EDGE_RISING>;
+			#thermal-sensor-cells = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		pm8150l_gpios: gpio@c000 {
 			compatible = "qcom,pm8150l-gpio";
 			reg = <0xc000>;
-- 
2.29.2

