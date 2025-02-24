Return-Path: <linux-pm+bounces-22816-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B96A42339
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 15:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A04671712B8
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 14:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B2F2561B6;
	Mon, 24 Feb 2025 14:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="OkW0D74b";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="JOHuXYZ5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBA418A6C5;
	Mon, 24 Feb 2025 14:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740407339; cv=none; b=GNIbaq95AlzLhWZOVmZJGjT45wP2dc2Z/JcuHTRJjpYaM60YDNTYwOY75tMMwo6jAphKBx5oJUYG8LwLuVJbdsmIGJMQxri388VJYBQwznfxroqjbYedN6Lp5XumzWN6DxpxmrPEIN9Fyk9ackaJpNijTfjwBPgrrn4a/JSVedA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740407339; c=relaxed/simple;
	bh=AHV9PExneGNDlIztsPAwGvqiSD7lIAM4Hx7DE71MhZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JjyP32O8YnaQAz1Qz0mHOkukHrBzRCmIM2w4v1zZ1DDkBQxJWigHSVoc1rJd8OJQ1e2dRTnNWHmhNm1NSfEJ67DcFBMTE0PFzQnMhr/7o1ZxQyuHQVCztdx4TlWlxjoHjNdy33kILebEHHL3tmF8LLgl1wV7V4KXPaLxLauU9fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=OkW0D74b; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=JOHuXYZ5 reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1740407336; x=1771943336;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sWKqOX5BSiiuBOfVvs+gR33D/sqaIKO5jTjWIObEE8A=;
  b=OkW0D74bIUwKi+7E1r2s01/eapu8F3V1hf1RWmNQEa+I9Ik6yvsLxdPR
   g6urUJ1ZBogum5SNqiiGcHIneOMldoBymb6Sgw2rFDZWLgOURiQI26Rpk
   y18Jj67rQrvz4EvHkRMfiPWvktgl9G3vhswNxbCKsgGBbj38K1FwiUZQJ
   0qYSPQSvlZQ+S+gTdg1KRC8YDEZX1IV9rbhEcPwcpW1FiZS3AirzDfw1x
   NKLkSKuWjhfjiCciPsNjKvpXLZG6LOovYLp2JFKZxYmNq3/fohsD1vj7k
   3WOpJz69DHLiUwRCmrn0MivN2uqHlzJB0lk+hbLzLDt1C3Y2Pkm8xLe7A
   g==;
X-CSE-ConnectionGUID: nlRWI6nFT6yE2yzHATWdoA==
X-CSE-MsgGUID: lPDIY21vTlyNPODEk8h+bA==
X-IronPort-AV: E=Sophos;i="6.13,309,1732575600"; 
   d="scan'208";a="42042107"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 24 Feb 2025 15:28:52 +0100
X-CheckPoint: {67BC8224-28-6E0A4539-DBC44C3A}
X-MAIL-CPID: C472B7EE68207FE8A685CB9E4A0C8BC4_1
X-Control-Analysis: str=0001.0A002103.67BC8223.008B,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 35F021679A1;
	Mon, 24 Feb 2025 15:28:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1740407328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sWKqOX5BSiiuBOfVvs+gR33D/sqaIKO5jTjWIObEE8A=;
	b=JOHuXYZ5msjXIsVC2G/ioyQOMnlvTAobJnlbb00ytJhaFlW4p79i/tfXezswfLiSEpnucL
	wiPx5EmNMbTMrDspxE4J7CD6Ftu14fzUyhmxc1AeFzYzDix8wUYaDbr2i+nugXZrH1BIiI
	NzYty9WJQMz2zicYz65xzrbi7/m0AVgrGvrPqmRWDIqCv9FBzRy6+CDEcYoPWq+3pM3ddV
	PBjpL/Dp5zErebxHVKBQkRrKpEVVH/v3O4hCJ9GAHo+CKs4TGQcBWS6ZDetCBb2Yp5+5NJ
	ni5NSPcuq0I9ovwZrl46uYrS+BLjaU7DbLkAa2U1K7lheII1Y56DKV5DT8kkDw==
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
Subject: [PATCH v2 2/6] dt-bindings: soc: imx93-media-blk-ctrl: Add LDB subnode into schema and example
Date: Mon, 24 Feb 2025 15:28:23 +0100
Message-ID: <20250224142831.485159-3-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224142831.485159-1-alexander.stein@ew.tq-group.com>
References: <20250224142831.485159-1-alexander.stein@ew.tq-group.com>
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
index b3554e7f9e76d..d914dea6ecbb5 100644
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
+      ranges;
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


