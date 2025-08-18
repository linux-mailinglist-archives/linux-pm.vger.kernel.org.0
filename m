Return-Path: <linux-pm+bounces-32537-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1367B2A105
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 14:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23CA3189C625
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 11:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC6731CA58;
	Mon, 18 Aug 2025 11:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="eLfUmPEB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645192FB98E;
	Mon, 18 Aug 2025 11:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755518287; cv=none; b=Yyd6d2LlGkDbAnJb3aNzolpFVWpXdzd+IaMkmhK1e3ZvYoB/XLKHW5SmVDmiW2W8/3tCA5K3Un5wSNwCOxG84LVVwhD2OVUubBymckciAGyQ4arn4W8kNeGOMM/3z09BA++EjmXKaz3EXkuHuJPPS6b7ClFyDUhrMkK8QOv0wVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755518287; c=relaxed/simple;
	bh=SPld2osk4Wz70HS9pOdtJbZnrdI2Xuqt6TyAGF8ws3Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZWoDTmTJNJd1Gbp40EjYIjKW7Lwa8Ox/12j7nRoA/oFdOS0IVPIHRcbbI1r77D0xZwTFkNJQn6Dx15QeYikcZaPX+t6TUnvr6WCupu27lCsCDMhtQ9Ivv0u96iRPsLvQsTJkd76mTZaqxFPMmWNMSrXj+zVuRn9iDKIagEW6XT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=eLfUmPEB; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 96d0e3b27c2a11f08729452bf625a8b4-20250818
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=XE/Wsu/+2JfTzmMtwqnxXK18dYzx6PrNiqIfUIe6Nqc=;
	b=eLfUmPEBVp/yWnvZgKlf054fltaad0spMbTWgvDgshsVWsEi3k5/4x8QJEEbDqvYH+OWGKdfyPz5jjG3drBOW0Glu3gvZe9ILGnx8+LDN70Y5nOYNF7dEjtNfyEB7ABSkaMX8+Q8FApUdhY/eIfDd1/k44fSS2rRWfGomJtu6ik=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.3,REQID:e59a8b89-54ba-4346-8d72-1ddd1ad72f76,IP:0,UR
	L:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:25
X-CID-META: VersionHash:f1326cf,CLOUDID:40929844-18c5-4075-a135-4c0afe29f9d6,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:-5,Content:0|15|50,EDM:
	-3,IP:nil,URL:11|97|99|83|106|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 96d0e3b27c2a11f08729452bf625a8b4-20250818
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <irving-ch.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 759813251; Mon, 18 Aug 2025 19:58:00 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Mon, 18 Aug 2025 19:57:59 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Mon, 18 Aug 2025 19:57:59 +0800
From: irving.ch.lin <irving-ch.lin@mediatek.com>
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
	<sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Ulf Hansson
	<ulf.hansson@linaro.org>, Richard Cochran <richardcochran@gmail.com>
CC: Qiqi Wang <qiqi.wang@mediatek.com>, <linux-clk@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<linux-pm@vger.kernel.org>, <netdev@vger.kernel.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	<sirius.wang@mediatek.com>, <vince-wl.liu@mediatek.com>,
	<jh.hsu@mediatek.com>, <irving-ch.lin@mediatek.com>
Subject: [PATCH 2/6] dt-bindings: power: mediatek: Add new MT8189 power
Date: Mon, 18 Aug 2025 19:57:30 +0800
Message-ID: <20250818115754.1067154-3-irving-ch.lin@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250818115754.1067154-1-irving-ch.lin@mediatek.com>
References: <20250818115754.1067154-1-irving-ch.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Irving-ch Lin <irving-ch.lin@mediatek.com>

Add the new binding documentation for power controller
on MediaTek MT8189.

Signed-off-by: Irving-ch Lin <irving-ch.lin@mediatek.com>
---
 .../mediatek,mt8189-power-controller.yaml     | 94 +++++++++++++++++++
 1 file changed, 94 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/mediatek,mt8189-power-controller.yaml

diff --git a/Documentation/devicetree/bindings/power/mediatek,mt8189-power-controller.yaml b/Documentation/devicetree/bindings/power/mediatek,mt8189-power-controller.yaml
new file mode 100644
index 000000000000..1bf8f94858c8
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/mediatek,mt8189-power-controller.yaml
@@ -0,0 +1,94 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/mediatek,mt8189-power-controller.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek Power Domains Controller for MT8189
+
+maintainers:
+  - Qiqi Wang <qiqi.wang@mediatek.com>
+
+description: |
+  MediaTek processors include support for multiple power domains which can be
+  powered up/down by software based on different application scenes to save power.
+
+  IP cores belonging to a power domain should contain a 'power-domains'
+  property that is a phandle for SCPSYS node representing the domain.
+
+properties:
+  $nodename:
+    pattern: '^power-controller(@[0-9a-f]+)?$'
+
+  compatible:
+    enum:
+      - mediatek,mt8189-scpsys
+
+  '#power-domain-cells':
+    const: 1
+
+  reg:
+    description: physical base address and size of the power-controller's register area.
+
+  infra-infracfg-ao-reg-bus:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: phandle to the device containing the infracfg register range.
+
+  emicfg-ao-mem:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: phandle to the device containing the emicfg register range.
+
+  vlpcfg-reg-bus:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: phandle to the device containing the vlpcfg (very low power config) register range.
+
+  clocks:
+    description: |
+      A number of phandles to clocks that need to be enabled during domain
+      power-up sequencing.
+
+  clock-names:
+    description: |
+      List of names of clocks, in order to match the power-up sequencing
+      for each power domain we need to group the clocks by name. BASIC
+      clocks need to be enabled before enabling the corresponding power
+      domain, and should not have a '-' in their name (i.e mm, mfg, venc).
+      SUSBYS clocks need to be enabled before releasing the bus protection,
+      and should contain a '-' in their name (i.e mm-0, isp-0, cam-0).
+
+      In order to follow properly the power-up sequencing, the clocks must
+      be specified by order, adding first the BASIC clocks followed by the
+      SUSBSYS clocks.
+
+  domain-supply:
+    description: domain regulator supply.
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/mt8189-clk.h>
+    #include <dt-bindings/power/mt8189-power.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+        scpsys: power-controller@1c001000 {
+            compatible = "mediatek,mt8189-scpsys";
+            reg = <0 0x1c001000 0 0x1000>;
+            #power-domain-cells = <1>;
+            infra-infracfg-ao-reg-bus = <&infracfg_ao_clk>;
+            emicfg-ao-mem = <&emicfg_ao_mem_clk>;
+            vlpcfg-reg-bus = <&vlpcfg_reg_bus_clk>;
+            clocks = /* MFG */
+                <&topckgen_clk CLK_TOP_MFG_REF_SEL>,
+                <&apmixedsys_clk CLK_APMIXED_MFGPLL>;
+            clock-names = "mfg", "mfg_top";
+            mfg0-supply = <&mt6359_vproc1_buck_reg>;
+            mfg1-supply = <&mt6359_vsram_proc1_ldo_reg>;
+        };
+    };
-- 
2.45.2


