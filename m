Return-Path: <linux-pm+bounces-29792-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B344AECAB9
	for <lists+linux-pm@lfdr.de>; Sun, 29 Jun 2025 00:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69FDB170399
	for <lists+linux-pm@lfdr.de>; Sat, 28 Jun 2025 22:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5F123B610;
	Sat, 28 Jun 2025 22:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="ho9MfSrp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC5615A856
	for <linux-pm@vger.kernel.org>; Sat, 28 Jun 2025 22:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751150726; cv=none; b=JQzaoca6KXmPsJ1aBM34Fh91sR6zlEEuVXmifkAFn/iSzG9BB5u1GwAvvSh4yg2sTPyGDlXQdgDUKwB9r7PcbSFJw6sQltTO61VrLpqJxAqDaSfKqvnN3gId/DwWACoMy2F63qPMOIw+EL2r4Rtv8F4PkPJ3uupco1/qF+S7AZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751150726; c=relaxed/simple;
	bh=HOxtaYcGwe1Dr4Y1WuLiliZlybxYUzGV4lfY449z6QQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cuGrAde1/1XTLJblM+EuPjZGgracQfNiljFkJtM6YXLvEYyh0JfaunFP1TQbNf5PvzFTL9Zoiz/cNVzEZcdaUpF33qiSNzcIjgAUExow7lXE2e61IHrHlNKuKgoRmYnAT/XQ1eWVeG5/WHTjHmOXIIhMLejxGrMU3SkLMEAEFPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=ho9MfSrp; arc=none smtp.client-ip=212.77.101.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 30245 invoked from network); 29 Jun 2025 00:38:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1751150322; bh=4x6ilKt5iJmJ+aTcOPfoqYo5nK7rJ62lmNxO5mvvtEE=;
          h=From:To:Subject;
          b=ho9MfSrpJm1Tq1q9xQG60cHTcoy0xqWNNQBRf6smEjqkmqmh03r+oaznAE3MCLXOR
           1qmy0TMgKCuhybMqGIlXeZBQ4CASBq01cG3czT44FWA/Y6m35b76pXrSPaCwK1imE3
           OPvx2SwKrJ+WM9bM1Q3Cozk6ODfGfqDVQKl/3PfXk6DxySRgmgG7zYToHcZi53QT1u
           0bIB4CBBOmkeMREbzCB8MqpFwDs1Ze+ICiYHeMXSodAFjnS2uXrgkc3HQwfVP6eiPs
           2mP4PQeF4JNRBiSiqfehwu4XYKC1FBZh3e8zowxC5xba1btCrdZ9qeZIz2VCew+37I
           /QktqBuN1dCBw==
Received: from 83.24.145.121.ipv4.supernova.orange.pl (HELO laptop-olek.lan) (olek2@wp.pl@[83.24.145.121])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <rafael@kernel.org>; 29 Jun 2025 00:38:42 +0200
From: Aleksander Jan Bajkowski <olek2@wp.pl>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	olek2@wp.pl,
	zhiyong.tao@mediatek.com,
	linux-pm@vger.kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 1/3] arm64: dts: mediatek: add thermal sensor support on mt7981
Date: Sun, 29 Jun 2025 00:38:35 +0200
Message-Id: <20250628223837.848244-2-olek2@wp.pl>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250628223837.848244-1-olek2@wp.pl>
References: <20250628223837.848244-1-olek2@wp.pl>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-MailID: 83e3732595d5e7000e752de9e0de6415
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [ceMx]                               

The temperature sensor in the MT7981 is same as in the MT7986.

Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
---
 arch/arm64/boot/dts/mediatek/mt7981b.dtsi | 29 ++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7981b.dtsi b/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
index 5cbea9cd411f..c2001a82722a 100644
--- a/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
@@ -76,7 +76,7 @@ watchdog: watchdog@1001c000 {
 			#reset-cells = <1>;
 		};
 
-		clock-controller@1001e000 {
+		apmixedsys: clock-controller@1001e000 {
 			compatible = "mediatek,mt7981-apmixedsys";
 			reg = <0 0x1001e000 0 0x1000>;
 			#clock-cells = <1>;
@@ -184,6 +184,29 @@ spi@1100b000 {
 			status = "disabled";
 		};
 
+		thermal@1100c800 {
+			compatible = "mediatek,mt7981-thermal";
+			reg = <0 0x1100c800 0 0x800>;
+			interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&infracfg CLK_INFRA_THERM_CK>,
+				 <&infracfg CLK_INFRA_ADC_26M_CK>;
+			clock-names = "therm", "auxadc";
+			nvmem-cells = <&thermal_calibration>;
+			nvmem-cell-names = "calibration-data";
+			#thermal-sensor-cells = <1>;
+			mediatek,auxadc = <&auxadc>;
+			mediatek,apmixedsys = <&apmixedsys>;
+		};
+
+		auxadc: adc@1100d000 {
+			compatible = "mediatek,mt7981-auxadc";
+			reg = <0 0x1100d000 0 0x1000>;
+			clocks = <&infracfg CLK_INFRA_ADC_26M_CK>;
+			clock-names = "main";
+			#io-channel-cells = <1>;
+			status = "disabled";
+		};
+
 		pio: pinctrl@11d00000 {
 			compatible = "mediatek,mt7981-pinctrl";
 			reg = <0 0x11d00000 0 0x1000>,
@@ -211,6 +234,10 @@ efuse@11f20000 {
 			reg = <0 0x11f20000 0 0x1000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
+
+			thermal_calibration: calib@274 {
+				reg = <0x274 0xc>;
+			};
 		};
 
 		clock-controller@15000000 {
-- 
2.39.5


