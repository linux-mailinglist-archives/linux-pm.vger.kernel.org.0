Return-Path: <linux-pm+bounces-13777-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6160A96EFBE
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 11:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D8DD1C23F4A
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 09:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C221CBE98;
	Fri,  6 Sep 2024 09:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b="kr3p73MJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from classfun.cn (unknown [129.204.178.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9021CB30B;
	Fri,  6 Sep 2024 09:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.204.178.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725615492; cv=none; b=QUyPMdtpb9ExSyShdc8BsiETKTrjDXtgs4jPMYylWjkb3Wz/sN+SBTN2y4jprikWJcEoPNtXUTPAnvrJckWtVmO/sfdgP7w2Vf2WcDz339rbjsEEcKj2YQJ26/FbqwPLqQspatNBvkFS1lb2wYV3PB+L9IJUKQSEBUEjJqJuJD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725615492; c=relaxed/simple;
	bh=nlfbLg90Zf7S1mmJm0+BODYh2sKXPqJQOo0Mv87pzLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B44sAV7EzxDPuUmtEb+DtIQmdA3cXfq3D67TRCpP9tcdx+CxkSJbkFg+/kRanUCSFN/sormTD6Ts6dhjs0NGYYtkllUqmXewn2vAp8C0sQo1WwjDadjrfPEmoZs1+9/7S+I1v3UuyoUb+dVM1u/Cyyxc5tOfqI1cvCvOgiK3wLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn; spf=pass smtp.mailfrom=classfun.cn; dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b=kr3p73MJ; arc=none smtp.client-ip=129.204.178.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=classfun.cn
Received: from bigfoot-server-storage.classfun.cn (unknown [124.72.163.35])
	(Authenticated sender: bigfoot)
	by classfun.cn (Postfix) with ESMTPSA id 2A15B78A09;
	Fri,  6 Sep 2024 17:38:09 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.11.0 classfun.cn 2A15B78A09
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=classfun.cn;
	s=default; t=1725615490;
	bh=4iXFbTgHyY6K8dz+IW7PQ4SZIPOZ8q/AqB9y9MhNIP0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kr3p73MJl49h2aPllRV/YPwy6pXv5KGKkqdhVZdd+1776nSl5X5Tvpa7REribPuQX
	 YpoNrobXRwV3TsUoVLcL0kigvpzc9iAeFbQ87KrUmFrLC6jDf4ipJIizmJGTf+KU/2
	 KMbwaTMxEN6jTXFFheGNHlimR7FYTiod26Ky/yn4=
From: Junhao Xie <bigfoot@classfun.cn>
To: devicetree@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Cc: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	Junhao Xie <bigfoot@classfun.cn>
Subject: [PATCH 9/9] arm64: dts: rockchip: add Photonicat PMU support for Ariaboard Photonicat
Date: Fri,  6 Sep 2024 17:36:30 +0800
Message-ID: <20240906093630.2428329-10-bigfoot@classfun.cn>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240906093630.2428329-1-bigfoot@classfun.cn>
References: <20240906093630.2428329-1-bigfoot@classfun.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds support for Photonicat power management MCU on
Ariaboard Photonicat.

Signed-off-by: Junhao Xie <bigfoot@classfun.cn>
---
 .../boot/dts/rockchip/rk3568-photonicat.dts   | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-photonicat.dts b/arch/arm64/boot/dts/rockchip/rk3568-photonicat.dts
index 2fe403cd61cb..597275702408 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-photonicat.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-photonicat.dts
@@ -513,6 +513,49 @@ &uart4 {
 	dma-names = "tx", "rx";
 	status = "okay";
 	/* Onboard power management MCU */
+
+	pcat_pmu: mcu {
+		compatible = "ariaboard,photonicat-pmu";
+		current-speed = <115200>;
+		local-address = <1>;
+		remote-address = <1>;
+
+		pcat_pmu_battery: supply-battery {
+			compatible = "ariaboard,photonicat-pmu-supply";
+			label = "battery";
+			monitored-battery = <&battery>;
+			power-supplies = <&pcat_pmu_charger>;
+			type = "battery";
+		};
+
+		pcat_pmu_charger: supply-charger {
+			compatible = "ariaboard,photonicat-pmu-supply";
+			label = "charger";
+			type = "charger";
+		};
+
+		pcat_pmu_hwmon: hwmon {
+			compatible = "ariaboard,photonicat-pmu-hwmon";
+			label = "pcat_board";
+		};
+
+		pcat_pmu_leds_status: leds-status {
+			compatible = "ariaboard,photonicat-pmu-leds";
+			label = "net-status";
+		};
+
+		pcat_pmu_poweroff: poweroff {
+			compatible = "ariaboard,photonicat-pmu-poweroff";
+		};
+
+		pcat_pmu_rtc: rtc {
+			compatible = "ariaboard,photonicat-pmu-rtc";
+		};
+
+		pcat_pmu_watchdog: watchdog {
+			compatible = "ariaboard,photonicat-pmu-watchdog";
+		};
+	};
 };
 
 &usb_host0_xhci {
-- 
2.46.0


