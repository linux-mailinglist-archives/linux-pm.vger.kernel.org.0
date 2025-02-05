Return-Path: <linux-pm+bounces-21371-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A58B2A285C1
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 09:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96C0616788D
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 08:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54EB22A4C2;
	Wed,  5 Feb 2025 08:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="U5mFfZr1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-m155115.qiye.163.com (mail-m155115.qiye.163.com [101.71.155.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5989422A1EF;
	Wed,  5 Feb 2025 08:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738744867; cv=none; b=dssUi1/SMtUKGmBWcmdtULimMI43zUYZmfuIzCNOclrmXxmwpAdTN1SpFnJTpwyraYm+KHeAgO2ygScUYWyEGsHGEJICycZEcplIBi3Qdc9c6wQSCYncVmcQQJJLUtDc4rdq6MsB0hMBXio3QI9Q5KfxcoI9ffLzTtrLClyGDvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738744867; c=relaxed/simple;
	bh=bNt3g41MbGOhRUtyPJTnQPZ+/OsEb8ekcvaA54K8B9s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=aUkZTQli1zFZn8Hlsll7O4ZHq4gRQwyD64xJ/A6m7M3tHigZybaMvo/sl1aN4dXN5hAeTFQUZUTW1bQukuD9LKmtHFEo2KRTNdiEZF++4NRPBYAb4Cpe1bmJ2r4OmBvCFmgTq1WCW1Lzl3Mz+1M6B5yUWmJoSZQcam8fCeSxevc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=U5mFfZr1; arc=none smtp.client-ip=101.71.155.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id a34e52fb;
	Wed, 5 Feb 2025 14:18:36 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Rob Herring <robh+dt@kernel.org>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Heiko Stuebner <heiko@sntech.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Avri Altman <avri.altman@wdc.com>,
	Bart Van Assche <bvanassche@acm.org>,
	YiFeng Zhao <zyf@rock-chips.com>,
	Liang Chen <cl@rock-chips.com>,
	linux-scsi@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v7 7/7] arm64: dts: rockchip: Add UFS support for RK3576 SoC
Date: Wed,  5 Feb 2025 14:15:56 +0800
Message-Id: <1738736156-119203-8-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1738736156-119203-1-git-send-email-shawn.lin@rock-chips.com>
References: <1738736156-119203-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQk9CSFZNTkNLTkxPGU5NGB1WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a94d4c2af6d09cckunma34e52fb
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nxw6Myo6ETIQEgs#EjcrHBor
	EwIwCxFVSlVKTEhDTEhNSEpMQ09PVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUpCSEI3Bg++
DKIM-Signature:a=rsa-sha256;
	b=U5mFfZr1sdZFCWiqy8e46HIrf3ILOWz6zcrZR9gIKDOVFyKDGv9l6sb9Y4BUzQyUBMCa/5Hu29CePBxDLaW2MrUGAyn0cD6yXRuETVSd//zKpxM3HDnMN5T77EtzggDXhfmT0DtyfEpxS+vtowhhug6ZY69/Wh7R+/9/GZOp8rg=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=zXet6/X8S9LRHFBz6ujYL262DrXxbFU9c0/qc0AtD7Q=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

Add ufshc node to rk3576.dtsi, so the board using UFS could
enable it.

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v7:
- Use 0x0 for consistency
- Collect Mani's acked-by tag

Changes in v6:
- remove comments suggested by Mani

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 arch/arm64/boot/dts/rockchip/rk3576.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576.dtsi b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
index 4dde954..bd55bd8 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
@@ -1221,6 +1221,30 @@
 			};
 		};
 
+		ufshc: ufshc@2a2d0000 {
+			compatible = "rockchip,rk3576-ufshc";
+			reg = <0x0 0x2a2d0000 0x0 0x10000>,
+			      <0x0 0x2b040000 0x0 0x10000>,
+			      <0x0 0x2601f000 0x0 0x1000>,
+			      <0x0 0x2603c000 0x0 0x1000>,
+			      <0x0 0x2a2e0000 0x0 0x10000>;
+			reg-names = "hci", "mphy", "hci_grf", "mphy_grf", "hci_apb";
+			clocks = <&cru ACLK_UFS_SYS>, <&cru PCLK_USB_ROOT>, <&cru PCLK_MPHY>,
+				 <&cru CLK_REF_UFS_CLKOUT>;
+			clock-names = "core", "pclk", "pclk_mphy", "ref_out";
+			assigned-clocks = <&cru CLK_REF_OSC_MPHY>;
+			assigned-clock-parents = <&cru CLK_REF_MPHY_26M>;
+			interrupts = <GIC_SPI 361 IRQ_TYPE_LEVEL_HIGH>;
+			power-domains = <&power RK3576_PD_USB>;
+			pinctrl-0 = <&ufs_refclk>;
+			pinctrl-names = "default";
+			resets = <&cru SRST_A_UFS_BIU>, <&cru SRST_A_UFS_SYS>,
+				 <&cru SRST_A_UFS>, <&cru SRST_P_UFS_GRF>;
+			reset-names = "biu", "sys", "ufs", "grf";
+			reset-gpios = <&gpio4 RK_PD0 GPIO_ACTIVE_LOW>;
+			status = "disabled";
+		};
+
 		sdmmc: mmc@2a310000 {
 			compatible = "rockchip,rk3576-dw-mshc";
 			reg = <0x0 0x2a310000 0x0 0x4000>;
-- 
2.7.4


