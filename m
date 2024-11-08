Return-Path: <linux-pm+bounces-17189-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D061A9C1795
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2024 09:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D4C9B21099
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2024 08:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B948C1D2F55;
	Fri,  8 Nov 2024 08:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="SOAZL9Lv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-m254123.xmail.ntesmail.com (mail-m254123.xmail.ntesmail.com [103.129.254.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5967DA95;
	Fri,  8 Nov 2024 08:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.129.254.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731053644; cv=none; b=L9rolxOLnc7VWdvnTwjh1Qy+Mf8YVYTO9/d87QvEbAB2tXHTd5UPqW4B5D7XCqrT4kYsg2aCTJKobkAVRW9DiUsJYZtn9h+yp2a+6EC54FegbdhGqkJHgRKmYAkrPaq65dPCjzTcXZxGAfHM0kLEec35MtbudUqlMlAFaxqAHAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731053644; c=relaxed/simple;
	bh=NtDQUEz4omxEChqNNmk3HpSG/qVosikuT1gmlOmiBwI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ercRx0A1oRSv8OnZnf8gT9t6gmZBxtN83D6YPieP+zYevD7dlq2ejqxGTKG03F8TUjXaZjZSpnelVNW6ItX8EMiMKjKQRBnHm9wa98+UZX39VjOVlkeqcYGvQkJqEHh8ErVIpM2HakSwUU1xyFwm86sQvhfHpNPkJND5uIJDjRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=SOAZL9Lv; arc=none smtp.client-ip=103.129.254.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 22d55d15;
	Fri, 8 Nov 2024 14:58:13 +0800 (GMT+08:00)
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
Subject: [PATCH v5 7/7] arm64: dts: rockchip: Add UFS support for RK3576 SoC
Date: Fri,  8 Nov 2024 14:56:26 +0800
Message-Id: <1731048987-229149-8-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1731048987-229149-1-git-send-email-shawn.lin@rock-chips.com>
References: <1731048987-229149-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGh1PTVZDHRhOQkIdSUtPQk1WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhCSE
	NVSktLVUpCS0tZBg++
X-HM-Tid: 0a930a90fb3409cckunm22d55d15
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OUk6Fhw6CDItNCpWLhkcPxge
	CwhPFB5VSlVKTEhKS09CS0JOT05DVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUpDT0w3Bg++
DKIM-Signature:a=rsa-sha256;
	b=SOAZL9LvJ+qDHchjTV5Q0IP7mKMmQAwIOjP7EVVWMsshbpPJ7i7qK5h6SI0DOxkH95848JUG1ZewWnnjfYLxs9Nbwx/1Rl7C/sTd3K1zDbgeSSm8jKNxfTpSGqCMFrwEkuUJQmoKkHz6Q42h44vJdlmxbiPqMSB0RpTeokzmVnY=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=3H24NrQLEMfPWL1st4iL+1t7GW4sDnhpoxLzFNJ/4Qk=;
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

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 arch/arm64/boot/dts/rockchip/rk3576.dtsi | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576.dtsi b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
index 436232f..32beda2 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
@@ -1110,6 +1110,31 @@
 			};
 		};
 
+		ufshc: ufshc@2a2d0000 {
+			compatible = "rockchip,rk3576-ufshc";
+			reg = <0x0 0x2a2d0000 0 0x10000>, /* 0: HCI standard */
+			      <0x0 0x2b040000 0 0x10000>, /* 1: Mphy */
+			      <0x0 0x2601f000 0 0x1000>,  /* 2: HCI Vendor specified */
+			      <0x0 0x2603c000 0 0x1000>,  /* 3: Mphy Vendor specified */
+			      <0x0 0x2a2e0000 0 0x10000>; /* 4: HCI apb */
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


