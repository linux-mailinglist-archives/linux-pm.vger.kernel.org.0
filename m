Return-Path: <linux-pm+bounces-23417-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC75AA4E517
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 17:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E4B77A4398
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 16:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA4725FA28;
	Tue,  4 Mar 2025 15:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="My//eATu";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="bykKnpNc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2654427CB3E;
	Tue,  4 Mar 2025 15:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741103396; cv=none; b=HK7RYHywP1nN1NINZGB2hGnZtt2BagTj6j5rQWYawiyyglO+eOA2YTgzxTHxACsC8WeP5tBPHuolKAIbWh2MlfBLeTOX8FKRF08HSZ75BaRjfVG2emuybMFR/HxLw7J/aLl5pymu/RPe1+RDZt84lSnGqvF1+i5tbhn5KVWiDMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741103396; c=relaxed/simple;
	bh=4h0ro++EXKKMcYzlMyF2aROs67wiW1TBYUCRTybl1X0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qq0HcGbxxPyXXcLcf3RssElGTlRtJGvS3kGFHHX8ypAscq2g5ePFZsyEfQ2R13ZDTcKcKJRrECSlX/B3gpDrnjcOvNymCwEqsmbE6H7wz6I0Dgf1Y65jO9Iw8sQAmZcf0Ft1JVXiV8tYfS5DxPNFM2V5uGNSaAcH61oQ2HzoEu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=My//eATu; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=bykKnpNc reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1741103394; x=1772639394;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g5p5A34MpJIsUrfR0gYIJqddGWsXChyJFWZEMauN/Rk=;
  b=My//eATuhvJBiqCoQfiMQERDFHTt32Ab6EuIteH2KEJZnHwl946KxC67
   /xJKL6DTxym0iIjsP/n8dUccHHJXHzo3GvNdKPSKxoF7ZM2vMMDikVWAw
   pyuBXv6hxAc+zAnuL2QnqPPaWXdHBewXFrbyuuh3kT6XtcdJh/1iTWbai
   jnfyrf3BAq5zrGZjS339LZNuO/OfiL9oROf0jB75FuyK2GsnMGXqHmrvH
   tk73AZkB2A5RNHziXXQ0D3OvUO11E4Q4dqNz/BtquwK9WpeY1i8DbASfr
   6yE5KZ3OMQZWY4SSDoGYT/HbaTxogMM82RWfhN3Zv9Zwr6aYy3plLrR4M
   w==;
X-CSE-ConnectionGUID: wnINBS6UTbaKfLbsQjXPow==
X-CSE-MsgGUID: 9dDagD/4SpiBK2DXp8Z7ng==
X-IronPort-AV: E=Sophos;i="6.14,220,1736809200"; 
   d="scan'208";a="42272738"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 04 Mar 2025 16:49:50 +0100
X-CheckPoint: {67C7211E-16-F35B2447-E1635CDE}
X-MAIL-CPID: B5735A1773F397C33992F6DE6F197D7A_1
X-Control-Analysis: str=0001.0A00639B.67C7211F.00DF,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 34F65162421;
	Tue,  4 Mar 2025 16:49:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1741103386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g5p5A34MpJIsUrfR0gYIJqddGWsXChyJFWZEMauN/Rk=;
	b=bykKnpNcB+Sz/5BhgJVYQ+68PMg16ny4pejBB7mHy51mMLSqGaM1o505R9xmhQVt/GRnx0
	d9iNCAGXWJEMn5fFI2481U8YpnlCtt/JwCQwlYmYK49095XfyeE32lz1qDVdMv8eIo8yj3
	VWRj9trsfXFz63jqMOtaLDV5v+PvcqxcmxxtuGm2Ayg7SRrDzVQAXThEi6AIDzmjlYIzbR
	uzmenlb+GQlST/G4W02/7HHeIGdP56ZqW2nR2MhRAzmzzfD6O4a6L3Jx5APeZfG/ffSL7n
	OnfbRwIKSXtyL9mpKgkqwyQOnSygTZtJbfyIO2ngMz7+aV9uk9bB7lQRTDfTaQ==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Abel Vesa <abelvesa@kernel.org>,
	Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux@ew.tq-group.com,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v3 2/6] dt-bindings: soc: imx93-media-blk-ctrl: Add LDB subnode into schema and example
Date: Tue,  4 Mar 2025 16:49:21 +0100
Message-ID: <20250304154929.1785200-3-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250304154929.1785200-1-alexander.stein@ew.tq-group.com>
References: <20250304154929.1785200-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Document the LDB bridge subnode and add the subnode into the example.
For the subnode to work, the block control must scan its subnodes and
bind drivers to them, do not misuse either simple-bus or simple-mfd
here.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 .../soc/imx/fsl,imx93-media-blk-ctrl.yaml     | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,imx93-media-blk-ctrl.yaml b/Documentation/devicetree/bindings/soc/imx/fsl,imx93-media-blk-ctrl.yaml
index b3554e7f9e76d..cd785111928bf 100644
--- a/Documentation/devicetree/bindings/soc/imx/fsl,imx93-media-blk-ctrl.yaml
+++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx93-media-blk-ctrl.yaml
@@ -24,6 +24,14 @@ properties:
   reg:
     maxItems: 1
 
+  ranges: true
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 1
+
   '#power-domain-cells':
     const: 1
 
@@ -46,9 +54,20 @@ properties:
       - const: csi
       - const: dsi
 
+  bridge@20:
+    type: object
+    additionalProperties: true
+    properties:
+      compatible:
+        contains:
+          const: fsl,imx93-ldb
+
 required:
   - compatible
   - reg
+  - ranges
+  - '#address-cells'
+  - '#size-cells'
   - power-domains
   - clocks
   - clock-names
@@ -77,4 +96,36 @@ examples:
                clock-names = "apb", "axi", "nic", "disp", "cam",
                              "pxp", "lcdif", "isi", "csi", "dsi";
       #power-domain-cells = <1>;
+      #address-cells = <1>;
+      #size-cells = <1>;
+      ranges = <0x0 0x4ac10000 0x10000>;
+
+      bridge@20 {
+          compatible = "fsl,imx93-ldb";
+          reg = <0x20 0x4>, <0x24 0x4>;
+          reg-names = "ldb", "lvds";
+          clocks = <&clk IMX93_CLK_LVDS_GATE>;
+          clock-names = "ldb";
+
+          ports {
+              #address-cells = <1>;
+              #size-cells = <0>;
+
+              port@0 {
+                  reg = <0>;
+
+                  ldb_from_lcdif2: endpoint {
+                      remote-endpoint = <&lcdif2_to_ldb>;
+                  };
+              };
+
+              port@1 {
+                  reg = <1>;
+
+                  ldb_lvds: endpoint {
+                      remote-endpoint = <&ldb_to_panel>;
+                  };
+              };
+          };
+        };
     };
-- 
2.43.0


