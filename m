Return-Path: <linux-pm+bounces-43752-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMlSI22Nqml0TQEAu9opvQ
	(envelope-from <linux-pm+bounces-43752-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 09:16:45 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF3A21CF29
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 09:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9A8BD30091D3
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 08:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403A92D3727;
	Fri,  6 Mar 2026 08:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="iNOeAPWk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-m32124.qiye.163.com (mail-m32124.qiye.163.com [220.197.32.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136E8EEBA;
	Fri,  6 Mar 2026 08:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772785000; cv=none; b=OpQl1SQxsBUY90KObqKHV+lWbErScUHfQHVVvWng/IP1xyPt7liEW48TqoyQWMlGUvKHJJ0lFRJ/AjS1R/feD3bSQZoku/fJMsvCwPJ9rhW+TygEt6N+1ww11i0qT7hZQKHPvBA27Yx3bVTxiK4vTc/6MD0+Jnv6/2c7n/2ZldU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772785000; c=relaxed/simple;
	bh=WisLN+Ri98OqYGx4PFUs2+x4l34ln/mr7UTeDo8d1g8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=M5CEqKqhid5ANQU/p8fV9csSIkXNU0qXiLVsCvb8J2tAcicUVVW6xG4Iy4oG2oWy8cFOmWaSOqXPrTrUXS9y+0PRe8r3vg58Ryp4Wrhyvf6Defp41xfcfIvqwY0zWkD07Jt7nynFJ8Ex9WcbjOD0wBRfigjX0iF8K8tTwWIeieU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=iNOeAPWk; arc=none smtp.client-ip=220.197.32.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 35fcf4202;
	Fri, 6 Mar 2026 15:41:00 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: linux-pm@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 3/3] arm64: dts: rockchip: Add shaping nodes for rk3576
Date: Fri,  6 Mar 2026 15:40:32 +0800
Message-Id: <1772782832-216867-4-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1772782832-216867-1-git-send-email-shawn.lin@rock-chips.com>
References: <1772782832-216867-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9cc217b78d09cckunm7894a4e01405c0d
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQhlJTFYfSx9CGksaSU9OHkhWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=iNOeAPWkxZX7N28p0FUnFBKYs40CYdDO0vu8fnTnswaoUAxwOxYGiKiruG77EKHCH/i9guJHrwmo4h6tNWIqICgTgZeD9q7DTvoxiicKnRN+2A0nzlHWlkoK7wZWwU0yUjtAE1SACtPZ0+osdQHV6Zv4w2Iax8HXMvSaD3R+N20=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=bK2vSgJMIv/+ZiGEOmk6/o8nvWh39k+i8nePQ6JW820=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 8EF3A21CF29
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[rock-chips.com,none];
	R_DKIM_ALLOW(-0.20)[rock-chips.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-43752-lists,linux-pm=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shawn.lin@rock-chips.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[rock-chips.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

RK3576 has shaping settings which need to be saved and restored
along with the on/off of pmdomain, so add them in the rk3576.dtsi.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 arch/arm64/boot/dts/rockchip/rk3576.dtsi | 139 +++++++++++++++++++++++++++++++
 1 file changed, 139 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576.dtsi b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
index 53ff6bd..9c28769 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
@@ -1063,6 +1063,10 @@
 							 <&qos_npu_nsp1>,
 							 <&qos_npu_m0ro>,
 							 <&qos_npu_m1ro>;
+						pm_shaping = <&shaping_npu_nsp0>,
+							     <&shaping_npu_nsp1>,
+							     <&shaping_npu_m0ro>,
+							     <&shaping_npu_m1ro>;
 						#power-domain-cells = <1>;
 						#address-cells = <1>;
 						#size-cells = <0>;
@@ -1072,6 +1076,7 @@
 							clocks = <&cru HCLK_RKNN_ROOT>,
 								 <&cru ACLK_RKNN0>;
 							pm_qos = <&qos_npu_m0>;
+							pm_shaping = <&shaping_npu_m0>;
 							#power-domain-cells = <0>;
 						};
 						power-domain@RK3576_PD_NPU1 {
@@ -1079,6 +1084,7 @@
 							clocks = <&cru HCLK_RKNN_ROOT>,
 								 <&cru ACLK_RKNN1>;
 							pm_qos = <&qos_npu_m1>;
+							pm_shaping = <&shaping_npu_m1>;
 							#power-domain-cells = <0>;
 						};
 					};
@@ -1088,6 +1094,7 @@
 					reg = <RK3576_PD_GPU>;
 					clocks = <&cru CLK_GPU>, <&cru PCLK_GPU_ROOT>;
 					pm_qos = <&qos_gpu>;
+					pm_shaping = <&shaping_gpu>;
 					#power-domain-cells = <0>;
 				};
 
@@ -1129,6 +1136,9 @@
 						 <&cru ACLK_MMU1>;
 					pm_qos = <&qos_mmu0>,
 						 <&qos_mmu1>;
+					pm_shaping = <&shaping_mmu0>,
+						     <&shaping_mmu1>;
+
 					#power-domain-cells = <1>;
 					#address-cells = <1>;
 					#size-cells = <0>;
@@ -1149,6 +1159,7 @@
 					clocks = <&cru ACLK_VEPU1>,
 						 <&cru HCLK_VEPU1>;
 					pm_qos = <&qos_vepu1>;
+					pm_shaping = <&shaping_vepu1>;
 					#power-domain-cells = <0>;
 				};
 
@@ -1169,6 +1180,10 @@
 						 <&qos_rga0>,
 						 <&qos_rga1>,
 						 <&qos_vdpp>;
+					pm_shaping = <&shaping_rga0>,
+						     <&shaping_rga1>,
+						     <&shaping_jpeg>,
+						     <&shaping_vdpp>;
 					#power-domain-cells = <0>;
 				};
 
@@ -1177,6 +1192,7 @@
 					clocks = <&cru ACLK_RKVDEC_ROOT>,
 						 <&cru HCLK_RKVDEC>;
 					pm_qos = <&qos_rkvdec>;
+					pm_shaping = <&shaping_rkvdec>;
 					#power-domain-cells = <0>;
 				};
 
@@ -1199,6 +1215,11 @@
 						 <&qos_vicap_m0>,
 						 <&qos_vpss_mro>,
 						 <&qos_vpss_mwo>;
+					pm_shaping = <&shaping_isp_mro>,
+						     <&shaping_isp_mwo>,
+						     <&shaping_vicap_m0>,
+						     <&shaping_vpss_mro>,
+						     <&shaping_vpss_mwo>;
 					#power-domain-cells = <1>;
 					#address-cells = <1>;
 					#size-cells = <0>;
@@ -1208,6 +1229,7 @@
 						clocks = <&cru ACLK_VEPU0>,
 							 <&cru HCLK_VEPU0>;
 						pm_qos = <&qos_vepu0>;
+						pm_shaping = <&shaping_vepu0>;
 						#power-domain-cells = <0>;
 					};
 				};
@@ -1220,6 +1242,8 @@
 						 <&cru PCLK_VOP_ROOT>;
 					pm_qos = <&qos_vop_m0>,
 						 <&qos_vop_m1ro>;
+					pm_shaping = <&shaping_vop_m0>,
+						     <&shaping_vop_m1ro>;
 					#power-domain-cells = <1>;
 					#address-cells = <1>;
 					#size-cells = <0>;
@@ -1602,11 +1626,21 @@
 			reg = <0x0 0x27f05000 0x0 0x20>;
 		};
 
+		shaping_gpu: shaping@27f05088 {
+			compatible = "rockchip,rk3576-shaping", "syscon";
+			reg = <0x0 0x27f05088 0x0 0x4>;
+		};
+
 		qos_vepu1: qos@27f06000 {
 			compatible = "rockchip,rk3576-qos", "syscon";
 			reg = <0x0 0x27f06000 0x0 0x20>;
 		};
 
+		shaping_vepu1: shaping@27f06088 {
+			compatible = "rockchip,rk3576-shaping", "syscon";
+			reg = <0x0 0x27f06088 0x0 0x4>;
+		};
+
 		qos_npu_mcu: qos@27f08000 {
 			compatible = "rockchip,rk3576-qos", "syscon";
 			reg = <0x0 0x27f08000 0x0 0x20>;
@@ -1622,6 +1656,16 @@
 			reg = <0x0 0x27f08100 0x0 0x20>;
 		};
 
+		shaping_npu_nsp0: shaping@27f08188 {
+			compatible = "rockchip,rk3576-shaping", "syscon";
+			reg = <0x0 0x27f08188 0x0 0x4>;
+		};
+
+		shaping_npu_nsp1: shaping@27f08208 {
+			compatible = "rockchip,rk3576-shaping", "syscon";
+			reg = <0x0 0x27f08208 0x0 0x4>;
+		};
+
 		qos_emmc: qos@27f09000 {
 			compatible = "rockchip,rk3576-qos", "syscon";
 			reg = <0x0 0x27f09000 0x0 0x20>;
@@ -1642,11 +1686,26 @@
 			reg = <0x0 0x27f0a080 0x0 0x20>;
 		};
 
+		shaping_mmu0: shaping@27f0a108 {
+			compatible = "rockchip,rk3576-shaping", "syscon";
+			reg = <0x0 0x27f0a108 0x0 0x4>;
+		};
+
+		shaping_mmu1: shaping@27f0a188 {
+			compatible = "rockchip,rk3576-shaping", "syscon";
+			reg = <0x0 0x27f0a188 0x0 0x4>;
+		};
+
 		qos_rkvdec: qos@27f0c000 {
 			compatible = "rockchip,rk3576-qos", "syscon";
 			reg = <0x0 0x27f0c000 0x0 0x20>;
 		};
 
+		shaping_rkvdec: shaping@27f0c088 {
+			compatible = "rockchip,rk3576-shaping", "syscon";
+			reg = <0x0 0x27f0c088 0x0 0x4>;
+		};
+
 		qos_crypto: qos@27f0d000 {
 			compatible = "rockchip,rk3576-qos", "syscon";
 			reg = <0x0 0x27f0d000 0x0 0x20>;
@@ -1667,6 +1726,11 @@
 			reg = <0x0 0x27f0f000 0x0 0x20>;
 		};
 
+		shaping_vepu0: shaping@27f0f088 {
+			compatible = "rockchip,rk3576-shaping", "syscon";
+			reg = <0x0 0x27f0f088 0x0 0x4>;
+		};
+
 		qos_isp_mro: qos@27f10000 {
 			compatible = "rockchip,rk3576-qos", "syscon";
 			reg = <0x0 0x27f10000 0x0 0x20>;
@@ -1692,6 +1756,31 @@
 			reg = <0x0 0x27f10200 0x0 0x20>;
 		};
 
+		shaping_isp_mro: shaping@27f10288 {
+			compatible = "rockchip,rk3576-shaping", "syscon";
+			reg = <0x0 0x27f10288 0x0 0x4>;
+		};
+
+		shaping_isp_mwo: shaping@27f10308 {
+			compatible = "rockchip,rk3576-shaping", "syscon";
+			reg = <0x0 0x27f10308 0x0 0x4>;
+		};
+
+		shaping_vicap_m0: shaping@27f10388 {
+			compatible = "rockchip,rk3576-shaping", "syscon";
+			reg = <0x0 0x27f10388 0x0 0x4>;
+		};
+
+		shaping_vpss_mro: shaping@27f10408 {
+			compatible = "rockchip,rk3576-shaping", "syscon";
+			reg = <0x0 0x27f10408 0x0 0x4>;
+		};
+
+		shaping_vpss_mwo: shaping@27f10488 {
+			compatible = "rockchip,rk3576-shaping", "syscon";
+			reg = <0x0 0x27f10488 0x0 0x4>;
+		};
+
 		qos_hdcp0: qos@27f11000 {
 			compatible = "rockchip,rk3576-qos", "syscon";
 			reg = <0x0 0x27f11000 0x0 0x20>;
@@ -1707,6 +1796,16 @@
 			reg = <0x0 0x27f12880 0x0 0x20>;
 		};
 
+		shaping_vop_m0: shaping@27f12908 {
+			compatible = "rockchip,rk3576-shaping", "syscon";
+			reg = <0x0 0x27f12908 0x0 0x4>;
+		};
+
+		shaping_vop_m1ro: shaping@27f12988 {
+			compatible = "rockchip,rk3576-shaping", "syscon";
+			reg = <0x0 0x27f12988 0x0 0x4>;
+		};
+
 		qos_ebc: qos@27f13000 {
 			compatible = "rockchip,rk3576-qos", "syscon";
 			reg = <0x0 0x27f13000 0x0 0x20>;
@@ -1732,16 +1831,46 @@
 			reg = <0x0 0x27f13200 0x0 0x20>;
 		};
 
+		shaping_rga0: shaping@27f13288 {
+			compatible = "rockchip,rk3576-shaping", "syscon";
+			reg = <0x0 0x27f13288 0x0 0x4>;
+		};
+
+		shaping_rga1: shaping@27f13308 {
+			compatible = "rockchip,rk3576-shaping", "syscon";
+			reg = <0x0 0x27f13308 0x0 0x4>;
+		};
+
+		shaping_jpeg: shaping@27f13388 {
+			compatible = "rockchip,rk3576-shaping", "syscon";
+			reg = <0x0 0x27f13388 0x0 0x4>;
+		};
+
+		shaping_vdpp: shaping@27f13408 {
+			compatible = "rockchip,rk3576-shaping", "syscon";
+			reg = <0x0 0x27f13408 0x0 0x4>;
+		};
+
 		qos_npu_m0: qos@27f20000 {
 			compatible = "rockchip,rk3576-qos", "syscon";
 			reg = <0x0 0x27f20000 0x0 0x20>;
 		};
 
+		shaping_npu_m0: shaping@27f20088 {
+			compatible = "rockchip,rk3576-shaping", "syscon";
+			reg = <0x0 0x27f20088 0x0 0x4>;
+		};
+
 		qos_npu_m1: qos@27f21000 {
 			compatible = "rockchip,rk3576-qos", "syscon";
 			reg = <0x0 0x27f21000 0x0 0x20>;
 		};
 
+		shaping_npu_m1: shaping@27f21088 {
+			compatible = "rockchip,rk3576-shaping", "syscon";
+			reg = <0x0 0x27f21088 0x0 0x4>;
+		};
+
 		qos_npu_m0ro: qos@27f22080 {
 			compatible = "rockchip,rk3576-qos", "syscon";
 			reg = <0x0 0x27f22080 0x0 0x20>;
@@ -1752,6 +1881,16 @@
 			reg = <0x0 0x27f22100 0x0 0x20>;
 		};
 
+		shaping_npu_m0ro: shaping@27f22188 {
+			compatible = "rockchip,rk3576-shaping", "syscon";
+			reg = <0x0 0x27f22188 0x0 0x4>;
+		};
+
+		shaping_npu_m1ro: shaping@27f22208 {
+			compatible = "rockchip,rk3576-shaping", "syscon";
+			reg = <0x0 0x27f22208 0x0 0x4>;
+		};
+
 		gmac0: ethernet@2a220000 {
 			compatible = "rockchip,rk3576-gmac", "snps,dwmac-4.20a";
 			reg = <0x0 0x2a220000 0x0 0x10000>;
-- 
2.7.4


