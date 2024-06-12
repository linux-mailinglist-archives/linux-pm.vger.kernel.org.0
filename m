Return-Path: <linux-pm+bounces-9010-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A475C904FE3
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2024 12:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11F51B266A1
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2024 10:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064A416E887;
	Wed, 12 Jun 2024 09:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YY3r+vbX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD50716EBFA
	for <linux-pm@vger.kernel.org>; Wed, 12 Jun 2024 09:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718186383; cv=none; b=m883Mxm7ZIZVMhataxhGYilTUmowKe80Ejiwy+DJxD5zjPLegk4aUmDGkCLIPhTb3c1RzebAOw850c53fr1dq9rY5FwU3SzA2kPFxZwXnIQs+u9IWJDz7DvSGT0ki9PnLCc7OVkl3+a+g0zhbm39nNi7DkFJYZS9+RvtthUNSCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718186383; c=relaxed/simple;
	bh=D7uOWa4uDmtjSwf30b3ABIP8kdvr21SmZRUP7Dp4FOI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q8mYkhW3Va5TG1/64zKRKqOcofmIJZThTwEopDXZNMZp5SSJbB/ZYLT3C9y4GrCHSJ8GuyFWButdNvXCGAHFRFTTJjMykrJgNyAxnHopi6q+Q069v4zeDolePTRFCTO0eA4BGbADxXos6KxYkLLme8mNXNxDCfgWIJSbaQ55CXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YY3r+vbX; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52bbdb15dd5so2420337e87.3
        for <linux-pm@vger.kernel.org>; Wed, 12 Jun 2024 02:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718186379; x=1718791179; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pbxciSj28k5Q0p0UZvIK+bmv47cyvDnbr4Z/LAPTdSA=;
        b=YY3r+vbXfC/Y9tf1niSqtVV0/3OIcMZhU6SmrZ2DUMyPrElUKoVeLyjY4pKLeeap2y
         /9kEYkHGCf1WwBYTb2XpSOamIzY5rV/IN2GQZJqVZqxR6xv94w+Q7AGaMOcuHqlgKFA7
         /3T0gMQWJDamYP4FJhlxBspox7+EUWx3YQBKi7WTjf5fpPhgvFuxSijedHgZxAY2G9Ay
         /C4KCYn11sfyASLBLPjvJvVjdn+tcNKKEB8g9WfY4QUt+a6YpZktkUVkt/6O+Y4X9DT0
         fHqUQkcmV2NJBtyVNHFx4V+zmRXiJy0+Ak6Q+H9XPt+H4R2hrDN3gUxVNa1q8zl8/fSZ
         6AfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718186379; x=1718791179;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pbxciSj28k5Q0p0UZvIK+bmv47cyvDnbr4Z/LAPTdSA=;
        b=CL6EGI6ZOZzpTQt8w33WELnHpo2XjWdv362BXb+75tCE0EReO9L4jBY6hYaT6um7kg
         EiHb8LA/vPTkGmhVQqXguqRDttw0Byg3v2ENDOf/5qxGDHfmttOH2WzPIvEReI23F6Ez
         LwvnQYSfHUwergE8PMSq5lkfvuAovtuxjatMvVyG3KldIylmFw06XWFXV6KRyEToPw06
         BfRMljogSbxqNo6DZ6iztQ9cV8YXF5jrkbrmQ7pWfdy6afLlPOAfWZzZRqWWD/eG0+Ie
         CeEsBVF4R0CE7FYBQ6BnisRpSc0bsK0sdXNJQPfUtVNg/nk+qCCAKsKzjUtGhPn/MyYa
         Fvww==
X-Gm-Message-State: AOJu0Yw0b6M25rpgHOTLbxHUMGwDMG0srTlQ3y8TjOw6ymUA4mAlXrfa
	SXllB0tYS+anzYQUwrussD34gj1OcMU9kjkRQ1MIT5p0LJjlQPPTl9csweYHvQE=
X-Google-Smtp-Source: AGHT+IGUI7ZvsPCAH6It2x7kbWRHWUG4+wkOTpCQNz1t6NvaP/51Vx/SEMUet2s6JbBXdCB0wJkuWw==
X-Received: by 2002:a05:6512:48c6:b0:52c:8050:6f19 with SMTP id 2adb3069b0e04-52c9a405e3cmr744956e87.60.1718186378791;
        Wed, 12 Jun 2024 02:59:38 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52c8907dae9sm1408095e87.129.2024.06.12.02.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 02:59:38 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 12 Jun 2024 12:59:36 +0300
Subject: [PATCH v6 5/6] arm64: dts: qcom: sdm845: describe connections of
 USB/DP port
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240612-yoga-ec-driver-v6-5-8e76ba060439@linaro.org>
References: <20240612-yoga-ec-driver-v6-0-8e76ba060439@linaro.org>
In-Reply-To: <20240612-yoga-ec-driver-v6-0-8e76ba060439@linaro.org>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
 linux-usb@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Nikita Travkin <nikita@trvn.ru>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1967;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=D7uOWa4uDmtjSwf30b3ABIP8kdvr21SmZRUP7Dp4FOI=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmaXGGc7P4fHzcaQPT5coScEFYPOsIwqMDo1vug
 ZyBzPFUb6CJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZmlxhgAKCRCLPIo+Aiko
 1dp4CAChpYYB0Dn6m5M4lVLAbzOSVD8fIzavlY6uPQ60E2Ibf4v2h6fimoQIbqT33YjjJ6G2Ilx
 9+WaFciLOuIl2OExCw9xAa+wLodOFssGHIwPyduinYilbm3+yIYjo+87Fmdnbvab+Bpf+zpm1Mj
 VHIOxTu85t1BttTOBvCFRHCo21wBRaCXdghRvd2HY0yDDNS9gDkXhYqS6MZEjk3e5W23lZEH5sV
 LCF71QCao3VNID7GqvWx9edsIWl7OR8p6JEGPae43yjD0RV+YZWv88QH/BjDK8t/ZRJXCcWI8QG
 r79uKtqRVJK11By5K5Wy2KZ3ZLSOPmoNNM1lC2XLNRKiH2FB
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Describe links between the first USB3 host and the DisplayPort that is
routed to the same pins.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 53 +++++++++++++++++++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index a0125f3d92b2..23b101bb3842 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -4031,6 +4031,35 @@ usb_1_qmpphy: phy@88e8000 {
 
 			#clock-cells = <1>;
 			#phy-cells = <1>;
+			orientation-switch;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					usb_1_qmpphy_out: endpoint {
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+
+					usb_1_qmpphy_usb_ss_in: endpoint {
+						remote-endpoint = <&usb_1_dwc3_ss>;
+					};
+				};
+
+				port@2 {
+					reg = <2>;
+
+					usb_1_qmpphy_dp_in: endpoint {
+						remote-endpoint = <&dp_out>;
+					};
+				};
+			};
 		};
 
 		usb_2_qmpphy: phy@88eb000 {
@@ -4111,6 +4140,26 @@ usb_1_dwc3: usb@a600000 {
 				snps,dis_enblslpm_quirk;
 				phys = <&usb_1_hsphy>, <&usb_1_qmpphy QMP_USB43DP_USB3_PHY>;
 				phy-names = "usb2-phy", "usb3-phy";
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+
+						usb_1_dwc3_hs: endpoint {
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+
+						usb_1_dwc3_ss: endpoint {
+							remote-endpoint = <&usb_1_qmpphy_usb_ss_in>;
+						};
+					};
+				};
 			};
 		};
 
@@ -4601,7 +4650,9 @@ dp_in: endpoint {
 
 					port@1 {
 						reg = <1>;
-						dp_out: endpoint { };
+						dp_out: endpoint {
+							remote-endpoint = <&usb_1_qmpphy_dp_in>;
+						};
 					};
 				};
 

-- 
2.39.2


