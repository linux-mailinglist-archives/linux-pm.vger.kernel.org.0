Return-Path: <linux-pm+bounces-15323-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABEC2994772
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2024 13:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4228B26688
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2024 11:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B521DD552;
	Tue,  8 Oct 2024 11:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="fh1AmXna"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-m92248.xmail.ntesmail.com (mail-m92248.xmail.ntesmail.com [103.126.92.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533EF1D54E9;
	Tue,  8 Oct 2024 11:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.126.92.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728387716; cv=none; b=sUKsiIMRpC0/f/vRNT8OW7LiZoYPBWxg9/Y6+1vZ7ibls2EgOEfsKkqd6pzWfGodkRQLLrCZ0PzxeEcVVFKPI7oirHbpjAxXeNWRSGPCOn6GldQPc5yNrfpTtGSYlI96ayCcORhg51dA91iF/PW20Bw7hoZOnSIowBnNfQ0+Bxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728387716; c=relaxed/simple;
	bh=hL20nF2GAbPt9Dmwz+lPbghO14iAkuDz4HsVtgYryxI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=TM1iKSa/zlw+ONbG8Fay8zL32XLC3LGjaCOZrGn2/C4zFcgif4oWvFLXuc0/wRZ/GM2KoYgI4+kPwUKQGy8URILHy/8JVjD3nZJsSp0QNNodso2pLPHzU2OtCBlttR+qcuSfCVf7rEtgi+019967oKgeLgCa5IkJgf4VeSX8jug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=fh1AmXna; arc=none smtp.client-ip=103.126.92.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
DKIM-Signature: a=rsa-sha256;
	b=fh1AmXna3dWoxzFU4RxBgDi5rzS2EakRqgGDDynXI9227yQ9eIBR27lHCmLwl2iPcgFqFjkZcF3jcl0TJoJb9gZs7+kfajA9nK6l0j2X1IGrLyFmPm0k/itRXLu7fdRhkexETurGHQzYA/IN1fzXsrhiYNU3dodcL3UoVgUc1/I=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=AXK3YnjXax5rcpF78zMigMzTMhZlDrdMm0wDQmoO/X8=;
	h=date:mime-version:subject:message-id:from;
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 0B25B52057A;
	Tue,  8 Oct 2024 14:16:23 +0800 (CST)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Rob Herring <robh+dt@kernel.org>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Avri Altman <avri.altman@wdc.com>,
	Bart Van Assche <bvanassche@acm.org>,
	YiFeng Zhao <zyf@rock-chips.com>,
	Liang Chen <cl@rock-chips.com>,
	linux-scsi@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v3 2/5] dt-bindings: ufs: Document Rockchip UFS host controller
Date: Tue,  8 Oct 2024 14:15:27 +0800
Message-Id: <1728368130-37213-3-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1728368130-37213-1-git-send-email-shawn.lin@rock-chips.com>
References: <1728368130-37213-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0IfT1ZKSEIdSxhKH0lKGk5WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a926ac58ea403afkunm0b25b52057a
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6ND46Ejo5EzItLhY8GSwYNyg9
	SgEwCylVSlVKTElDSE1DSkNOTEpPVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQU5DS0g3Bg++
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

Document Rockchip UFS host controller for RK3576 SoC.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

Changes in v3:
- rename the file to rockchip,rk3576-ufshc.yaml
- add description for reset-gpios
- use rockchip,rk3576-ufshc as compatible

Changes in v2:
- rename the file
- add reset-gpios

 .../bindings/ufs/rockchip,rk3576-ufshc.yaml        | 103 +++++++++++++++++++++
 1 file changed, 103 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ufs/rockchip,rk3576-ufshc.yaml

diff --git a/Documentation/devicetree/bindings/ufs/rockchip,rk3576-ufshc.yaml b/Documentation/devicetree/bindings/ufs/rockchip,rk3576-ufshc.yaml
new file mode 100644
index 0000000..1c78ea5
--- /dev/null
+++ b/Documentation/devicetree/bindings/ufs/rockchip,rk3576-ufshc.yaml
@@ -0,0 +1,103 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/ufs/rockchip,rk3576-ufshc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip UFS Host Controller
+
+maintainers:
+  - Shawn Lin <shawn.lin@rock-chips.com>
+
+allOf:
+  - $ref: ufs-common.yaml
+
+properties:
+  compatible:
+    const: rockchip,rk3576-ufshc
+
+  reg:
+    maxItems: 5
+
+  reg-names:
+    items:
+      - const: hci
+      - const: mphy
+      - const: hci_grf
+      - const: mphy_grf
+      - const: hci_apb
+
+  clocks:
+    maxItems: 4
+
+  clock-names:
+    items:
+      - const: core
+      - const: pclk
+      - const: pclk_mphy
+      - const: ref_out
+
+  power-domains:
+    maxItems: 1
+
+  resets:
+    maxItems: 4
+
+  reset-names:
+    items:
+      - const: biu
+      - const: sys
+      - const: ufs
+      - const: grf
+
+  reset-gpios:
+    maxItems: 1
+    description: |
+      GPIO specifiers for host to reset the device.
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - clocks
+  - clock-names
+  - interrupts
+  - power-domains
+  - resets
+  - reset-names
+  - reset-gpios
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/rockchip,rk3576-cru.h>
+    #include <dt-bindings/reset/rockchip,rk3576-cru.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/power/rockchip,rk3576-power.h>
+    #include <dt-bindings/pinctrl/rockchip.h>
+    #include <dt-bindings/gpio/gpio.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        ufs: ufs@2a2d0000 {
+              compatible = "rockchip,rk3576-ufshc";
+              reg = <0x0 0x2a2d0000 0x0 0x10000>,
+                    <0x0 0x2b040000 0x0 0x10000>,
+                    <0x0 0x2601f000 0x0 0x1000>,
+                    <0x0 0x2603c000 0x0 0x1000>,
+                    <0x0 0x2a2e0000 0x0 0x10000>;
+              reg-names = "hci", "mphy", "hci_grf", "mphy_grf", "hci_apb";
+              clocks = <&cru ACLK_UFS_SYS>, <&cru PCLK_USB_ROOT>, <&cru PCLK_MPHY>,
+                      <&cru CLK_REF_UFS_CLKOUT>;
+              clock-names = "core", "pclk", "pclk_mphy", "ref_out";
+              interrupts = <GIC_SPI 361 IRQ_TYPE_LEVEL_HIGH>;
+              power-domains = <&power RK3576_PD_USB>;
+              resets = <&cru SRST_A_UFS_BIU>, <&cru SRST_A_UFS_SYS>, <&cru SRST_A_UFS>,
+                        <&cru SRST_P_UFS_GRF>;
+              reset-names = "biu", "sys", "ufs", "grf";
+              reset-gpios = <&gpio4 RK_PD0 GPIO_ACTIVE_LOW>;
+        };
+    };
-- 
2.7.4


