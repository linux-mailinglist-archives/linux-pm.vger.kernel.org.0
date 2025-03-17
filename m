Return-Path: <linux-pm+bounces-24168-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE017A651C8
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 14:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8AAA174059
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 13:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A21241C8B;
	Mon, 17 Mar 2025 13:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="Qncnz0Zm"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E912417E0;
	Mon, 17 Mar 2025 13:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742219464; cv=pass; b=Sfc6Qtammt25qBqZJYoR74CIOUPSoYmeTU1tp2x9v+yktVZ3aVgQvbBNCK9g6GJrbkzP9nsnPu9wYya8+w+gyPRoSARTfvFXoVFLGqHyJyxhgybHSmTtQeTBgn4PrRtKKwzyaOghtzMtSaFseeJsGa1v+OwgTocSxc0Q8RZIY8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742219464; c=relaxed/simple;
	bh=Mqn9/td0wpFnpoO5LuEtGWrHIFHFPWQFOhR7+fhcYcA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Oy6+1MrRvqe4PCJ9d+8DYTiqxGllO/fcZPuKc70QrYBHrP3uIPR5dbtGC+CZYTfFWh5Lvf5c5U8pcigk6BUZrsS1PBf436fytljmuSLY/xZa0LaE0Et03YmihUdOtrYvxqRHbhonV4/DMyv0sc9iXfEgvZamJvlptB+xEkL25IA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=Qncnz0Zm; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1742219443; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=GafCc7Fxa1MfqQ0lEIoNsL/wwfdl1CVrTuLWlcGqoOgQ/IX87ZYfIU5BmrOxX0RsbX0UYSecVLEzikctmN6CAyxFstpadnKqtkj2YFvNRPfTTfYniHvbEISCyk2QE9wr0pEtZyDSwwdrqAty49EmfiQ5s50iFhDtqmRSyaj3zcE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1742219443; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=nSSLB3r5L5l2WHm3T8V1rB+aRqL74ziqrn6q0GpxVUg=; 
	b=a/Y0at7ri8bNnLKTSGUK29UxEURiMk44rRiPMqV1uPF3DcowRMPPFAU985Hb8sgmYvvtLZDtGQwDePUzQR64N4wnGlIRdUUYcNgNMjbTtJvStKp0j3bEIzIr297yk60cZBVvgesLQojXYbzSvtawgxar0btoSpz0OA97fWEC5JU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1742219443;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=nSSLB3r5L5l2WHm3T8V1rB+aRqL74ziqrn6q0GpxVUg=;
	b=Qncnz0Zmr0rteXTB+aGTV/Un/ZgMLOFdqq+JAGo4HZqWQBjgg2Wous5e2MomILcg
	vOXK3u0mVtfOX6LJ0qKy+RT4610lK1JrfZfS8HA76T2d0kVKRfssrkKlllSbQYNXCLZ
	CTCnP2JFZOXxq83S0hgJCb6I+rYO+hptyw2Y5Dxk=
Received: by mx.zohomail.com with SMTPS id 1742219442290840.7508153932768;
	Mon, 17 Mar 2025 06:50:42 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Mon, 17 Mar 2025 14:49:31 +0100
Subject: [PATCH v4 6/7] arm64: dts: rockchip: Add thermal trim OTP and
 tsadc nodes
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250317-rk3576-tsadc-upstream-v4-6-c5029ce55d74@collabora.com>
References: <20250317-rk3576-tsadc-upstream-v4-0-c5029ce55d74@collabora.com>
In-Reply-To: <20250317-rk3576-tsadc-upstream-v4-0-c5029ce55d74@collabora.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Jonas Karlman <jonas@kwiboo.se>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>, 
 kernel@collabora.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.14.2

Thanks to Heiko's work getting OTP working on the RK3576, we can specify
the thermal sensor trim values which are stored there now, and with my
driver addition to rockchip_thermal, we can make use of these.

Add them to the devicetree for the SoC.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3576.dtsi | 57 ++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576.dtsi b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
index 250dca23ff4fc1ab3bd47366829c5dd1738057fe..6adfa0bfbe9e7ee03f4f516ff91b5c67e5c8346d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
@@ -1600,6 +1600,30 @@ gpu_leakage: gpu-leakage@21 {
 			log_leakage: log-leakage@22 {
 				reg = <0x22 0x1>;
 			};
+			bigcore_tsadc_trim: bigcore-tsadc-trim@24 {
+				reg = <0x24 0x2>;
+				bits = <0 10>;
+			};
+			litcore_tsadc_trim: litcore-tsadc-trim@26 {
+				reg = <0x26 0x2>;
+				bits = <0 10>;
+			};
+			ddr_tsadc_trim: ddr-tsadc-trim@28 {
+				reg = <0x28 0x2>;
+				bits = <0 10>;
+			};
+			npu_tsadc_trim: npu-tsadc-trim@2a {
+				reg = <0x2a 0x2>;
+				bits = <0 10>;
+			};
+			gpu_tsadc_trim: gpu-tsadc-trim@2c {
+				reg = <0x2c 0x2>;
+				bits = <0 10>;
+			};
+			soc_tsadc_trim: soc-tsadc-trim@64 {
+				reg = <0x64 0x2>;
+				bits = <0 10>;
+			};
 		};
 
 		gic: interrupt-controller@2a701000 {
@@ -2011,6 +2035,39 @@ tsadc: tsadc@2ae70000 {
 			rockchip,hw-tshut-temp = <120000>;
 			rockchip,hw-tshut-mode = <0>; /* tshut mode 0:CRU 1:GPIO */
 			rockchip,hw-tshut-polarity = <0>; /* tshut polarity 0:LOW 1:HIGH */
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			sensor@0 {
+				reg = <0>;
+				nvmem-cells = <&soc_tsadc_trim>;
+				nvmem-cell-names = "trim";
+			};
+			sensor@1 {
+				reg = <1>;
+				nvmem-cells = <&bigcore_tsadc_trim>;
+				nvmem-cell-names = "trim";
+			};
+			sensor@2 {
+				reg = <2>;
+				nvmem-cells = <&litcore_tsadc_trim>;
+				nvmem-cell-names = "trim";
+			};
+			sensor@3 {
+				reg = <3>;
+				nvmem-cells = <&ddr_tsadc_trim>;
+				nvmem-cell-names = "trim";
+			};
+			sensor@4 {
+				reg = <4>;
+				nvmem-cells = <&npu_tsadc_trim>;
+				nvmem-cell-names = "trim";
+			};
+			sensor@5 {
+				reg = <5>;
+				nvmem-cells = <&gpu_tsadc_trim>;
+				nvmem-cell-names = "trim";
+			};
 		};
 
 		i2c9: i2c@2ae80000 {

-- 
2.48.1


