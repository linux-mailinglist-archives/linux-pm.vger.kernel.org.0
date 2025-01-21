Return-Path: <linux-pm+bounces-20734-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E18FA1762D
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2025 04:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27C883A1803
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2025 03:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103921865EB;
	Tue, 21 Jan 2025 03:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="eVfzFqV9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-m3272.qiye.163.com (mail-m3272.qiye.163.com [220.197.32.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235D14689;
	Tue, 21 Jan 2025 03:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737428859; cv=none; b=UV+yVBqPQ3fK44NBDEBil7LQyiP92En7HflahBZsTVQLMd3yydwUTFZeCf6GQItFkumtFm9mCzaMcPYhEf5UcVoU3xWDqGQiNJhUB6742BOJTltM7b7BkA5CGv1aPDQyWaFRNKJekrjnSvNbLIxchZ7wwLzV6uv//fjxoA+nK5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737428859; c=relaxed/simple;
	bh=MVWks29q3iLdqkMqs0cxr90u1msFzWP6jyL7BW1PrIE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=k/NQrI8em+P6u1y6zorTpL8YReWmXRdTYdaIKojQJAGTil9tQMkigV9+onRM1a2xCCOiofMZAe9n3kaErjU2cg6j8xdEHcSR7fwVAigu0Jph2bPl/qJDsjBYlSzDOZlx0zENpHwY+itpNFOrv314EqesLT5ME1o1hgmUQ781GxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=eVfzFqV9; arc=none smtp.client-ip=220.197.32.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 93fdd038;
	Tue, 21 Jan 2025 11:02:17 +0800 (GMT+08:00)
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
Subject: [PATCH v6 7/7] arm64: dts: rockchip: Add UFS support for RK3576 SoC
Date: Tue, 21 Jan 2025 11:00:27 +0800
Message-Id: <1737428427-32393-8-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1737428427-32393-1-git-send-email-shawn.lin@rock-chips.com>
References: <1737428427-32393-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUJDH1ZJSklMH0lLSkJLQkNWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a9486cf8f9f09cckunm93fdd038
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PhQ6DCo6EzINFjUvDgIOMhQ1
	ITYaFE1VSlVKTEhMT0lDTkhDTEpKVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUpMQ0w3Bg++
DKIM-Signature:a=rsa-sha256;
	b=eVfzFqV9E89gb6hbrFGveVsdmK07EuQBxTSELGs4HI1ORIzRfw0rY7To1KMDye63FXWw7lh0Qb1Zz0PXKXaHhK8nVcYS9rNwR5ltyDvOVi/rvcstR9pAH0MUVcNmEvEsQcdn2cG3SnzAiofEgMIVKetA0UXWobahU3aVI2iQqJw=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=wYMBbIgjK+XD69o+ifjptcWHfJAy3+cY5gYZs7J+pSU=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

Add ufshc node to rk3576.dtsi, so the board using UFS could
enable it.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

Changes in v6:
- remove comments suggested by Mani

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 arch/arm64/boot/dts/rockchip/rk3576.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576.dtsi b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
index 4dde954..bb786bd 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
@@ -1221,6 +1221,30 @@
 			};
 		};
 
+		ufshc: ufshc@2a2d0000 {
+			compatible = "rockchip,rk3576-ufshc";
+			reg = <0x0 0x2a2d0000 0 0x10000>,
+			      <0x0 0x2b040000 0 0x10000>,
+			      <0x0 0x2601f000 0 0x1000>,
+			      <0x0 0x2603c000 0 0x1000>,
+			      <0x0 0x2a2e0000 0 0x10000>;
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


