Return-Path: <linux-pm+bounces-16937-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D70AF9BB2C4
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 12:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9FA1B21220
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 11:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D901BE223;
	Mon,  4 Nov 2024 11:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="KSVxPdwF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-m60244.netease.com (mail-m60244.netease.com [210.79.60.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0461BD014;
	Mon,  4 Nov 2024 11:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.79.60.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730718132; cv=none; b=pfdagVvpalo+K20VuU435zM03A6ZXLLzQ91/Hfd30MpyoH7H/Cyklra6TZ4EHGV4rufebGHhOT3R9ofGb22XOoFv98yrk4RtjCMWTmwvrPwMQznAyi+DCuM5TRmzNZ10FyOZCawkXtsUdc7clr57Zz4G2q27OeYbiWGtpEVrpxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730718132; c=relaxed/simple;
	bh=AWmRrV/UZ+5iDnXL4rcR+Cq8I1OD5Oyw/4/xpteEEf8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=hXeLhBGK1GNTlH0pOZrgpaipUfXdwllSkdfrN0/kZc7i6CPesKUKd7dYC7B506r2j+HXK7DMgsG+pEWx+uKDf8wlRYdsBnyDa31zLahHWRqnw1SXuMlhs5a6z9gfuO5TahvXrU0CbJ1itGIuepFza0NmZe00GZJPvlbe0/Bw+8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=KSVxPdwF; arc=none smtp.client-ip=210.79.60.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1b5d89cc;
	Mon, 4 Nov 2024 15:32:51 +0800 (GMT+08:00)
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
Subject: [PATCH v4 2/7] dt-bindings: ufs: Document Rockchip UFS host controller
Date: Mon,  4 Nov 2024 15:31:56 +0800
Message-Id: <1730705521-23081-3-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1730705521-23081-1-git-send-email-shawn.lin@rock-chips.com>
References: <1730705521-23081-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQx4eTVYfQx9KS0wdH0JISk1WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a92f6173f3409cckunm1b5d89cc
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PlE6SQw6ITIvLDo#HisyDzwo
	LBoaCTpVSlVKTEhLTEtOTkxISE5MVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUhDT0k3Bg++
DKIM-Signature:a=rsa-sha256;
	b=KSVxPdwFDVoqngFirPI2IBr5cWLLVww7StkydZ2wpTw83ZGY3oEa99cAmj5mSGL1XBwGH9X0ezVtGilNUQklv6RkyaY/a4sW6Tddz9wl6w0WIkD+Otjsm+MSJyXDTFXmp6n0klQcJYgMBgYrutFJDl6DvLR8GXKBYXkBNanq0mE=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=t0jfq2PeStTsZaJFc2X5b22FPiijLc9hnERUdwLupVk=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

Document Rockchip UFS host controller for RK3576 SoC.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v4:
- properly describe reset-gpios

Changes in v3:
- rename the file to rockchip,rk3576-ufshc.yaml
- add description for reset-gpios
- use rockchip,rk3576-ufshc as compatible

Changes in v2:
- rename the file
- add reset-gpios

 .../bindings/ufs/rockchip,rk3576-ufshc.yaml        | 105 +++++++++++++++++++++
 1 file changed, 105 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ufs/rockchip,rk3576-ufshc.yaml

diff --git a/Documentation/devicetree/bindings/ufs/rockchip,rk3576-ufshc.yaml b/Documentation/devicetree/bindings/ufs/rockchip,rk3576-ufshc.yaml
new file mode 100644
index 0000000..bc4c3de
--- /dev/null
+++ b/Documentation/devicetree/bindings/ufs/rockchip,rk3576-ufshc.yaml
@@ -0,0 +1,105 @@
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
+      GPIO specifiers for host to reset the whole UFS device including PHY and
+      memory. This gpio is active low and should choose the one whose high output
+      voltage is lower than 1.5V based on the UFS spec.
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


