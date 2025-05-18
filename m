Return-Path: <linux-pm+bounces-27280-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51178ABB1FE
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 00:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 003D33A2CFE
	for <lists+linux-pm@lfdr.de>; Sun, 18 May 2025 22:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75311F5402;
	Sun, 18 May 2025 22:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="Z2Qsg1lc"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC301CEADB
	for <linux-pm@vger.kernel.org>; Sun, 18 May 2025 22:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747606054; cv=none; b=YsGY8uARdCIrIlh7hoW5vvBBg1NqgdHnAPFYtuDjLQXrkLxejIW+TwbssF7BSAbeqw1zoa9FtGqxn53Hq6+doemwbviQqN2iD9kdOO8E5WySyxNVqgOjsaXWsl3w5tLF1feBnvf6lSVG7TZ1x/TV3IlnjIk5FwE1zod3Brk1nUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747606054; c=relaxed/simple;
	bh=/H1FZvLRs/wAqig6PIoBis+DpW+Q0lfcaiLoNoHN6Ys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nX3SiAfbaA69vZwlmaCsAEDIDigxN7oPlDFYeJTYMoejN5A9hh/c/HVr4Jkbej0ZSrnZ4DGzSexLXxizZPvYvZ0OS/OZA23hbRwsBTKE8MIAWZALi2A/ADHqdofIMXnJesfYGmZkT/+EEcmX8US73KwEYcVvfLEryDHPwg6EtEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=Z2Qsg1lc; arc=none smtp.client-ip=121.127.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1747606051; bh=UQqh8Zhf7I76+d8T83dbrs5i1DOHAaiBJnl55pIm1tw=;
 b=Z2Qsg1lc4QZdNSm5v57/VA7kylVpwja+Saf4VqagRKwTDzKm+w4Jj0AnjvRO71XxMy4Wb8aC8
 loTjDk1BK+Okq/PdwzUnAUx2qjAlP914QmQqZ+COq0q+WccS5NskFcBnuVzB1TgA/f1siCCZyOQ
 0YnMy2s0bgXzfbYUvjiXmMOd3GEIZf2EwqCmnCDwCEEl7nJPH/yV6NcxEhri7gCz8ZZ9TdgLM2C
 hlBjR1WKMVuNNB/nN+odo+H2m0JqdRGgyq41cBTr53mqqThq01vxOt6g8+FAT+D1mzZtDCh6uMX
 cwz6JpDzq3NRDjV8hlW/NTSL3FZWl4lP4OGmw9ex+IhA==
X-Forward-Email-ID: 682a5a2278cae75fbd8d46c5
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.0.3
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Heiko Stuebner <heiko@sntech.de>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Yao Zi <ziyao@disroot.org>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	linux-rockchip@lists.infradead.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Jonas Karlman <jonas@kwiboo.se>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/9] arm64: dts: rockchip: Add power controller for RK3528
Date: Sun, 18 May 2025 22:06:51 +0000
Message-ID: <20250518220707.669515-5-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250518220707.669515-1-jonas@kwiboo.se>
References: <20250518220707.669515-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add power-domain nodes for the power controller on RK3528.

Only PD_GPU can fully be powered down. PD_RKVDEC, PD_RKVENC, PD_VO and
PD_VPU are idle only power domains used by miscellaneous devices.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
Because multiple of the miscellaneous device types currently complain
about the use of a power-domains prop, only PD_GPU is enabled.
---
 arch/arm64/boot/dts/rockchip/rk3528.dtsi | 65 ++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3528.dtsi b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
index b2724c969a76..c13a6a566164 100644
--- a/arch/arm64/boot/dts/rockchip/rk3528.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
@@ -9,6 +9,7 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/pinctrl/rockchip.h>
 #include <dt-bindings/clock/rockchip,rk3528-cru.h>
+#include <dt-bindings/power/rockchip,rk3528-power.h>
 #include <dt-bindings/reset/rockchip,rk3528-cru.h>
 
 / {
@@ -371,6 +372,70 @@ ioc_grf: syscon@ff540000 {
 			reg = <0x0 0xff540000 0x0 0x40000>;
 		};
 
+		pmu: power-management@ff600000 {
+			compatible = "rockchip,rk3528-pmu", "syscon", "simple-mfd";
+			reg = <0x0 0xff600000 0x0 0x2000>;
+
+			power: power-controller {
+				compatible = "rockchip,rk3528-power-controller";
+				#power-domain-cells = <1>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				/* These power domains are grouped by VD_GPU */
+				power-domain@RK3528_PD_GPU {
+					reg = <RK3528_PD_GPU>;
+					clocks = <&cru ACLK_GPU_MALI>,
+						 <&cru PCLK_GPU_ROOT>;
+					pm_qos = <&qos_gpu_m0>,
+						 <&qos_gpu_m1>;
+					#power-domain-cells = <0>;
+				};
+
+				/* These power domains are grouped by VD_LOGIC */
+				power-domain@RK3528_PD_RKVDEC {
+					reg = <RK3528_PD_RKVDEC>;
+					pm_qos = <&qos_rkvdec>;
+					#power-domain-cells = <0>;
+					status = "disabled";
+				};
+				power-domain@RK3528_PD_RKVENC {
+					reg = <RK3528_PD_RKVENC>;
+					pm_qos = <&qos_rkvenc>;
+					#power-domain-cells = <0>;
+					status = "disabled";
+				};
+				power-domain@RK3528_PD_VO {
+					reg = <RK3528_PD_VO>;
+					pm_qos = <&qos_gmac0>,
+						 <&qos_hdcp>,
+						 <&qos_jpegdec>,
+						 <&qos_rga2_m0ro>,
+						 <&qos_rga2_m0wo>,
+						 <&qos_sdmmc0>,
+						 <&qos_usb2host>,
+						 <&qos_vdpp>,
+						 <&qos_vop>;
+					#power-domain-cells = <0>;
+					status = "disabled";
+				};
+				power-domain@RK3528_PD_VPU {
+					reg = <RK3528_PD_VPU>;
+					pm_qos = <&qos_emmc>,
+						 <&qos_fspi>,
+						 <&qos_gmac1>,
+						 <&qos_pcie>,
+						 <&qos_sdio0>,
+						 <&qos_sdio1>,
+						 <&qos_tsp>,
+						 <&qos_usb3otg>,
+						 <&qos_vpu>;
+					#power-domain-cells = <0>;
+					status = "disabled";
+				};
+			};
+		};
+
 		uart0: serial@ff9f0000 {
 			compatible = "rockchip,rk3528-uart", "snps,dw-apb-uart";
 			reg = <0x0 0xff9f0000 0x0 0x100>;
-- 
2.49.0


