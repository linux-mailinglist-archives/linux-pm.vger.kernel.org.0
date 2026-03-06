Return-Path: <linux-pm+bounces-43815-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEYHCujXqmnmXgEAu9opvQ
	(envelope-from <linux-pm+bounces-43815-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 14:34:32 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B838221BF2
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 14:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E83F83024EE8
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 13:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A883043DD;
	Fri,  6 Mar 2026 13:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jsgfZdGH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244732FFFBE
	for <linux-pm@vger.kernel.org>; Fri,  6 Mar 2026 13:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772804059; cv=none; b=g7l0LmJhXBZ8A1GJdckPXFuaco7/YQdbz5q5z/9/w+kMA2wWoQU40lBjgLC88VzhLY7IolBuJN4wq26VcTF8gghgOocJzdMCLNUdu6nv9uBu2NKA7hvkdr2PFmDsSB9vLYlNxE6UXDTsaWCRNNW6cbq4lK1aZyZX8bJmKLXAvCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772804059; c=relaxed/simple;
	bh=ph6zuP6F0f841JU6jbvip1lVe4NdAfa+AXBl7WT5uuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZuR4X+/2Qx3CFlzVggZiYfSGgwQAZsekSkGvlzVL98G3d9Oa3iLHF8CIdUYlF13EA1VlQ/Dq1DFwDJzw0+Unoive6eZ9onyuVpvKwdBnvt4/8+IImSM172lSzhMDBqFPfX8oAvD3beu9b0tWhwUMnIqW4bm17PrtUeucuCXGA9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jsgfZdGH; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4806cc07ce7so106294455e9.1
        for <linux-pm@vger.kernel.org>; Fri, 06 Mar 2026 05:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772804055; x=1773408855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qZBcwSima1Ck+pzqyaz+VDU2kW96ftT9STnzniKpHy8=;
        b=jsgfZdGHnELgRfOH+RxM9FoxuuITJA+w2mIPQAAA1mGlz/JW8SAukUlT2uR3LiiAfZ
         49EQ+gW3uT0HBr/WRMhEXRZveko6LnGAGlVu5cNAUtB98J/xsvCqAqMCN1W2bwVD6GAq
         6IUE7oLxFkxygKw/Q+kww+oRLNls5FoTHItOrQmitU1qq+c70h8fQVs9d9CNN/vcbpCZ
         BxGoYi8T9BCqTPcyYpUdioD3dg7/egVWyegk1WDMmp0YabjVMRzDWyzMpiAdojS5+9Db
         6CjEfND3qQEF1yjmq4EmA270e1hY63aodWZcF0jO5/R/e29ehn5y/tkTYe/9TJOgFKr0
         cYug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772804055; x=1773408855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qZBcwSima1Ck+pzqyaz+VDU2kW96ftT9STnzniKpHy8=;
        b=P3cZGcwoZp/drlWbfjbNrndflSvTSAadnq+mKYBnY+E7x6uYtW8OIAPt8QflJcwA+f
         kwDp09nAYp1gV3XQsDUzM1x0hkfwFjGBJUooB2ETEPw/RF3ijJ+a/eF9TgWHeiTXkvQz
         sD0c1kdKVc3UDykRj3RX++LuPrK7HxadlSGrGiqzl+H+qOWu0rlJxCO6z8D3xO4aR8VA
         d7Qlz7UYI0dvr24HXNAlfQbO07+30TO0/nHA4lJeZVu+xv9feNQ+DNCXIV76DtdL0GYT
         B739Em1sLqxkBOZdcsbwJwoLy3K8dR8u9FLVm2wWlkkw41oZfDiFTAM2hTwyxqtzqjEt
         SuZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNxzS81q9HCcCnLQGNc+mkoQ4QV4fSUvCNCscndNb49l3kwgy4Su7obL6wwHDvJSlmy6EmhbUXGQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwNZsc415NREMCjxWEgxQbaz8aYB2BPlL2oFrRdRmYAZIihkK83
	Peu8G/kpXnAdt9ScRXHlGxpyGais+YdkRROgc3NSF2mUg8XI4UtfjX3v
X-Gm-Gg: ATEYQzxgLfC6ObSijgKzbUKoMVbaQU6YTokOFqLObQr302/5XdtJepCMvvC3dqFDx7M
	FFggCMnhgDDx5f1orqS6tvGirSpxbhkVM1uDp91HqTfZaXl9Zs/yZlmU/Unfvx0yWX+n0KinoY0
	603jI/HDL0FKSBKJ5ZE3gEd3u+dBxIm+12116arcS1bLlCQK8954W/letUuIFqIIY54b45Xc6Nr
	GIW2nnuHcANky271BpLVhcfL2L6PXFSXDlWnmsP3ktipFmWoiRhc7JRB8eZCxHWvkvCNsfdzjBQ
	7D0+Lb4Ba8KE14cWggrFV4LFMwxz3v9jvHPgsR4yn/z9HANNAPrKXPEsJDIO9T9h3ReXGiaWdPs
	NHDspE9HJgjtQtekOiD06Yhi43wgqgRFObU09WIdlR55bkO8eBYjJq/Ocj4HG8TLoGs3akR1oV9
	d+8PV6t6SAGfqp
X-Received: by 2002:a05:600c:c10d:b0:485:2af3:3f8f with SMTP id 5b1f17b1804b1-4852af34095mr2453845e9.6.1772804055240;
        Fri, 06 Mar 2026 05:34:15 -0800 (PST)
Received: from xeon ([188.163.112.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48527681a3esm80856735e9.4.2026.03.06.05.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 05:34:14 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-rtc@vger.kernel.org
Subject: [PATCH v3 1/6] regulator: dt-binding: regulator-max77620: convert to DT schema
Date: Fri,  6 Mar 2026 15:33:46 +0200
Message-ID: <20260306133351.31589-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260306133351.31589-1-clamor95@gmail.com>
References: <20260306133351.31589-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0B838221BF2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-43815-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,intel.com,arm.com,samsung.com,bootlin.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clamor95@gmail.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[3c:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

Convert regulator-max77620 devicetree bindings for the MAX77620 PMIC from
TXT to YAML format. This patch does not change any functionality; the
bindings remain the same.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../regulator/maxim,max77620-regulator.yaml   |  99 ++++++++
 .../bindings/regulator/regulator-max77620.txt | 222 ------------------
 2 files changed, 99 insertions(+), 222 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/maxim,max77620-regulator.yaml
 delete mode 100644 Documentation/devicetree/bindings/regulator/regulator-max77620.txt

diff --git a/Documentation/devicetree/bindings/regulator/maxim,max77620-regulator.yaml b/Documentation/devicetree/bindings/regulator/maxim,max77620-regulator.yaml
new file mode 100644
index 000000000000..e8c374cfaef9
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/maxim,max77620-regulator.yaml
@@ -0,0 +1,99 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/maxim,max77620-regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Regulator for MAX77620 Power management IC from Maxim Semiconductor.
+
+maintainers:
+  - Svyatoslav Ryhel <clamor95@gmail.com>
+
+description:
+  Device has multiple DCDC(sd[0-3]) and LDOs(ldo[0-8]). The input supply
+  of these regulators are defined under parent device node. Details of
+  regulator properties are defined as child node under sub-node "regulators"
+  which is child node of device node.
+
+patternProperties:
+  "^in-(sd[0-3]|ldo(0-1|2|3-5|4-6|7-8))-supply$":
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: Input supply for DCDC or LDO
+
+  "^(sd[0-3]|ldo[0-8])$":
+    type: object
+    $ref: /schemas/regulator/regulator.yaml#
+    unevaluatedProperties: false
+
+    properties:
+      maxim,active-fps-source:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: |
+          FPS source for the GPIOs to get enabled/disabled when system is in
+          active state. Valid values are:
+          - MAX77620_FPS_SRC_0: FPS source is FPS0.
+          - MAX77620_FPS_SRC_1: FPS source is FPS1
+          - MAX77620_FPS_SRC_2: FPS source is FPS2
+          - MAX77620_FPS_SRC_NONE: GPIO is not controlled by FPS events and
+                                   it gets enabled/disabled by register access.
+          Absence of this property will leave the FPS configuration register
+          for that GPIO to default configuration.
+
+      maxim,active-fps-power-up-slot:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          Sequencing event slot number on which the GPIO get enabled when
+          master FPS input event set to HIGH. This is applicable if FPS source
+          is selected as FPS0, FPS1 or FPS2.
+        enum: [0, 1, 2, 3, 4, 5, 6, 7]
+
+      maxim,active-fps-power-down-slot:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          Sequencing event slot number on which the GPIO get disabled when
+          master FPS input event set to LOW. This is applicable if FPS source
+          is selected as FPS0, FPS1 or FPS2.
+        enum: [0, 1, 2, 3, 4, 5, 6, 7]
+
+      maxim,suspend-fps-source:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          This is same as property "maxim,active-fps-source" but value get
+          configured when system enters in to suspend state.
+
+      maxim,suspend-fps-power-up-slot:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          This is same as property "maxim,active-fps-power-up-slot" but this
+          value get configured into FPS configuration register when system
+          enters into suspend. This is applicable if suspend state FPS source
+          is selected as FPS0, FPS1 or FPS2.
+        enum: [0, 1, 2, 3, 4, 5, 6, 7]
+
+      maxim,suspend-fps-power-down-slot:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          This is same as property "maxim,active-fps-power-down-slot" but this
+          value get configured into FPS configuration register when system
+          enters into suspend. This is applicable if suspend state FPS source
+          is selected as FPS0, FPS1 or FPS2.
+        enum: [0, 1, 2, 3, 4, 5, 6, 7]
+
+      maxim,ramp-rate-setting:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: |
+          Ramp rate(uV/us) setting to be configured to the device. The platform
+          may have different ramp rate than advertised ramp rate if it has design
+          variation from Maxim's recommended. On this case, platform specific
+          ramp rate is used for ramp time calculation and this property is used
+          for device register configurations. The measured ramp rate of platform
+          is provided by the regulator-ramp-delay.
+
+          Maxim Max77620 supports following ramp delay:
+            SD: 13.75mV/us, 27.5mV/us, 55mV/us
+            LDOs: 5mV/us, 100mV/us
+        enum: [5000, 13750, 27500, 55000, 100000]
+
+additionalProperties: false
+
+# see maxim,max77620.yaml for an example
diff --git a/Documentation/devicetree/bindings/regulator/regulator-max77620.txt b/Documentation/devicetree/bindings/regulator/regulator-max77620.txt
deleted file mode 100644
index bcf788897e44..000000000000
--- a/Documentation/devicetree/bindings/regulator/regulator-max77620.txt
+++ /dev/null
@@ -1,222 +0,0 @@
-Regulator DT binding for MAX77620 Power management IC from Maxim Semiconductor.
-
-Device has multiple DCDC(sd[0-3] and LDOs(ldo[0-8]). The input supply
-of these regulators are defined under parent device node.
-Details of regulator properties are defined as child node under
-sub-node "regulators" which is child node of device node.
-
-Please refer file <Documentation/devicetree/bindings/regulator/regulator.txt>
-for common regulator bindings used by client.
-
-Following are properties of parent node related to regulators.
-
-Optional properties:
--------------------
-The input supply of regulators are the optional properties on the
-parent device node. The input supply of these regulators are provided
-through following properties:
-in-sd0-supply:		Input supply for SD0, INA-SD0 or INB-SD0 pins.
-in-sd1-supply:		Input supply for SD1.
-in-sd2-supply:		Input supply for SD2.
-in-sd3-supply:		Input supply for SD3.
-in-ldo0-1-supply:	Input supply for LDO0 and LDO1.
-in-ldo2-supply:		Input supply for LDO2.
-in-ldo3-5-supply:	Input supply for LDO3 and LDO5
-in-ldo4-6-supply:	Input supply for LDO4 and LDO6.
-in-ldo7-8-supply:	Input supply for LDO7 and LDO8.
-
-Optional sub nodes for regulators under "regulators" subnode:
-------------------------------------------------------------
-The subnodes name is the name of regulator and it must be one of:
-	sd[0-3], ldo[0-8]
-
-Each sub-node should contain the constraints and initialization
-information for that regulator. The definition for each of these
-nodes is defined using the standard binding for regulators found at
-<Documentation/devicetree/bindings/regulator/regulator.txt>.
-
-There are also additional properties for SD/LDOs. These additional properties
-are required to configure FPS configuration parameters for SDs and LDOs.
-Please refer <devicetree/bindings/mfd/max77620.txt> for more detail of Flexible
-Power Sequence (FPS).
-Following are additional properties:
-
-- maxim,active-fps-source:		FPS source for the regulators to get
-					enabled/disabled when system is in
-					active state.  Valid values are:
-					- MAX77620_FPS_SRC_0,
-						FPS source is FPS0.
-					- MAX77620_FPS_SRC_1,
-						FPS source is FPS1
-					- MAX77620_FPS_SRC_2 and
-						FPS source is FPS2
-					- MAX77620_FPS_SRC_NONE.
-						Regulator is not controlled
-						by FPS events and it gets
-						enabled/disabled by register
-						access.
-					Absence of this property will leave
-					the FPS configuration register for that
-					regulator to default configuration.
-
-- maxim,active-fps-power-up-slot:	Sequencing event slot number on which
-					the regulator get enabled when
-					master FPS input event set to HIGH.
-					Valid values are 0 to 7.
-					This is applicable if FPS source is
-					selected as FPS0, FPS1 or FPS2.
-			
-- maxim,active-fps-power-down-slot:	Sequencing event slot number on which
-					the regulator get disabled when master
-					FPS input event set to LOW.
-					Valid values are 0 to 7.
-					This is applicable if FPS source is
-					selected as FPS0, FPS1 or FPS2.
-			
-- maxim,suspend-fps-source:		This is same as property
-					"maxim,active-fps-source" but value
-					get configured when system enters in
-					to suspend state.
-
-- maxim,suspend-fps-power-up-slot:	This is same as property
-					"maxim,active-fps-power-up-slot" but
-					this value get configured into FPS
-					configuration register when system
-					enters into suspend.
-					This is applicable if suspend state
-					FPS source is selected as FPS0, FPS1 or
-
-- maxim,suspend-fps-power-down-slot:	This is same as property
-					"maxim,active-fps-power-down-slot" but
-					this value get configured into FPS
-					configuration register when system
-					enters into suspend.
-					This is applicable if suspend state
-					FPS source is selected as FPS0, FPS1 or
-					FPS2.
-- maxim,ramp-rate-setting:		integer, ramp rate(uV/us) setting to be
-					configured to the device.
-					The platform may have different ramp
-					rate than advertised ramp rate if it has
-					design variation from Maxim's
-					recommended. On this case, platform
-					specific ramp rate is used for ramp time
-					calculation and this property is used
-					for device register configurations.
-					The measured ramp rate of platform is
-					provided by the regulator-ramp-delay
-					as described in <devicetree/bindings/
-					regulator/regulator.txt>.
-					Maxim Max77620 supports following ramp
-					delay:
-					  SD: 13.75mV/us, 27.5mV/us, 55mV/us
-					  LDOs: 5mV/us, 100mV/us
-
-Note: If the measured ramp delay is same as advertised ramp delay then it is not
-required to provide the ramp delay with property "maxim,ramp-rate-setting". The
-ramp rate can be provided by the regulator-ramp-delay which will be used for
-ramp time calculation for voltage change as well as for device configuration.
-
-Example:
---------
-#include <dt-bindings/mfd/max77620.h>
-...
-max77620@3c {
-	in-ldo0-1-supply = <&max77620_sd2>;
-	in-ldo7-8-supply = <&max77620_sd2>;
-	regulators {
-		sd0 {
-			regulator-name = "vdd-core";
-			regulator-min-microvolt = <600000>;
-			regulator-max-microvolt = <1400000>;
-			regulator-boot-on;
-			regulator-always-on;
-			maxim,active-fps-source = <MAX77620_FPS_SRC_1>;
-		};
-
-		sd1 {
-			regulator-name = "vddio-ddr";
-			regulator-min-microvolt = <1200000>;
-			regulator-max-microvolt = <1200000>;
-			regulator-always-on;
-			regulator-boot-on;
-			maxim,active-fps-source = <MAX77620_FPS_SRC_0>;
-		};
-
-		sd2 {
-			regulator-name = "vdd-pre-reg";
-			regulator-min-microvolt = <1350000>;
-			regulator-max-microvolt = <1350000>;
-		};
-
-		sd3 {
-			regulator-name = "vdd-1v8";
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-			regulator-always-on;
-			regulator-boot-on;
-		};
-
-		ldo0 {
-			regulator-name = "avdd-sys";
-			regulator-min-microvolt = <1200000>;
-			regulator-max-microvolt = <1200000>;
-			regulator-always-on;
-			regulator-boot-on;
-		};
-
-		ldo1 {
-			regulator-name = "vdd-pex";
-			regulator-min-microvolt = <1050000>;
-			regulator-max-microvolt = <1050000>;
-		};
-
-		ldo2 {
-			regulator-name = "vddio-sdmmc3";
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <3300000>;
-		};
-
-		ldo3 {
-			regulator-name = "vdd-cam-hv";
-			regulator-min-microvolt = <2800000>;
-			regulator-max-microvolt = <2800000>;
-		};
-
-		ldo4 {
-			regulator-name = "vdd-rtc";
-			regulator-min-microvolt = <1250000>;
-			regulator-max-microvolt = <1250000>;
-			regulator-always-on;
-			regulator-boot-on;
-		};
-
-		ldo5 {
-			regulator-name = "avdd-ts-hv";
-			regulator-min-microvolt = <3000000>;
-			regulator-max-microvolt = <3000000>;
-		};
-
-		ldo6 {
-			regulator-name = "vdd-ts";
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-			regulator-always-on;
-			regulator-boot-on;
-		};
-
-		ldo7 {
-			regulator-name = "vdd-gen-pll-edp";
-			regulator-min-microvolt = <1050000>;
-			regulator-max-microvolt = <1050000>;
-			regulator-always-on;
-			regulator-boot-on;
-		};
-
-		ldo8 {
-			regulator-name = "vdd-hdmi-dp";
-			regulator-min-microvolt = <1050000>;
-			regulator-max-microvolt = <1050000>;
-		};
-	};
-};
-- 
2.51.0


