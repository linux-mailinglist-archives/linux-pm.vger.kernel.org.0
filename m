Return-Path: <linux-pm+bounces-15819-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5B99A16C3
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 02:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5103E1C222B0
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 00:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B741F942;
	Thu, 17 Oct 2024 00:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="uBT0TVCi"
X-Original-To: linux-pm@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D2EBE4E
	for <linux-pm@vger.kernel.org>; Thu, 17 Oct 2024 00:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729124228; cv=none; b=EoPscOSAAZUqxVNjrERWDs0Z4WsXyJ7QiRV/h2CwNCn67MnsdqKMiDyEl+Ozm/iI0jVXUJdpz/ppTAKdAt4jcalTqA7574fuz+4fjbCrSGjRq2g+AyQVtQzaPe0DBPxvDm+ryC1fn9aNzHI0IPKqkb4cUgj5mFv8EMhxSD2J9QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729124228; c=relaxed/simple;
	bh=Jw1PFzWhFK5XiqnG4nVVU87o/PJ4zIYrcYjmq8XFrLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MhGl0aU9cQEZFOr7PTq/M7Pg8R3QW1gPZWO/Jq1VB/uKEHfTh6e0n74KgxMrPFvzHadUbSaFsjxzKa8Dtf9RFlcSSBCzMCOZiBfA6+h83rl+HU8rFd8JCAQpHK1qm7JoRCeV5T4Wrm5s/swWVgZJvCXGrf+gqmqggHaZW9ae5wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=uBT0TVCi; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id A55CC2C0677;
	Thu, 17 Oct 2024 13:16:57 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1729124217;
	bh=RuxZVsTkb5fb6zPXU9eWSOGWqZMZ3cYKJORhqZxf5ZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uBT0TVCiQkpq5MprOv5DnlqUi4zjQ+c3ppH6QSblqXeCBCTZ7MNeIIw3sFzV8eh72
	 gVM6vFTzgR8pIP4V4IJyURajuBNe/u3ZcCCE/ihFza6KWURXgknlrHVpkhI9jui2vm
	 Xbq6slacLu5QjC+sGZB3X4b9u4zf2zN+uvAvzgZArpL5YNhv176pJuz71dz0kImfjG
	 k4nnlehIEKPh56IsHJqirFZvLDLpO+PYgsdFFHqJHFlaio1Ltv1XNriDyH7vug4oBa
	 aqOuIO9HB2Str2zJ8qoIB33wJw0h1JySVpJmDrYXzmDMYwvTwqDChlgyJV4kM2tnLM
	 VSa3oH5kys5QA==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B671057790003>; Thu, 17 Oct 2024 13:16:57 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 357CC13EE9C;
	Thu, 17 Oct 2024 13:16:57 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id 338542802E6; Thu, 17 Oct 2024 13:16:57 +1300 (NZDT)
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: andi.shyti@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	lee@kernel.org,
	sre@kernel.org,
	tsbogend@alpha.franken.de,
	markus.stockhausen@gmx.de
Cc: linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-mips@vger.kernel.org,
	Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v7 3/6] dt-bindings: mfd: Add Realtek RTL9300 switch peripherals
Date: Thu, 17 Oct 2024 13:16:50 +1300
Message-ID: <20241017001653.178399-4-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241017001653.178399-1-chris.packham@alliedtelesis.co.nz>
References: <20241017001653.178399-1-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=ca1xrWDM c=1 sm=1 tr=0 ts=67105779 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=DAUX931o1VcA:10 a=gEfo2CItAAAA:8 a=Qe96mEiGhgO3E569TkkA:9 a=3ZKOabzyN94A:10 a=sptkURWiP4Gy88Gu7hUp:22
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

Add device tree schema for the Realtek RTL9300 switches. The RTL9300
family is made up of the RTL9301, RTL9302B, RTL9302C and RTL9303. These
have the same SoC differ in the Ethernet switch/SERDES arrangement.

Currently the only supported features are the syscon-reboot and i2c
controllers. The syscon-reboot is needed to be able to reboot the board.
The I2C controllers are slightly unusual because they each own an SCL
pin (GPIO8 for the first controller, GPIO 17 for the second) but have 8
common SDA pins which can be assigned to either controller (but not
both).

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

Notes:
    Changes in v7:
    - Set additionalProperties: false
    - Remove extraneous examples from i2c binding
    Changes in v6:
    - Drop wildcard compatible
    - Add specific compatibles for the 4 known SoC variants
    - For the i2c part of the binding accept realtek,rtl9301 as a fallbac=
k
      for the other compatibles
    - The overall switches will eventually differ because these will have
      different SERDES/port arrangements so they aren't getting the same
      fallback treatment
    Changes in v5:
      I've combined the two series I had in flight so this is the
      combination of adding the switch syscon, the reboot and i2c. It mak=
es
      the changelog a bit meaningless so I've dropped the earlier
      commentary.
   =20
      As requested I've put a more complete example in the main
      rtl9300-switch.yaml.
   =20
      I've kept rtl9300-i2c.yaml separate for now but link to it with a $=
ref
      from rtl9300-switch.yaml to reduce clutter. The example in
      rtl9300-i2c.yaml is technically duplicating part of the example fro=
m
      rtl9300-switch.yaml but I feel it's nice to be able to see the exam=
ple
      next to where the properties are defined.

 .../bindings/i2c/realtek,rtl9301-i2c.yaml     |  69 +++++++++++
 .../bindings/mfd/realtek,rtl9301-switch.yaml  | 114 ++++++++++++++++++
 2 files changed, 183 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/realtek,rtl9301=
-i2c.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/realtek,rtl9301=
-switch.yaml

diff --git a/Documentation/devicetree/bindings/i2c/realtek,rtl9301-i2c.ya=
ml b/Documentation/devicetree/bindings/i2c/realtek,rtl9301-i2c.yaml
new file mode 100644
index 000000000000..eddfd329c67b
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/realtek,rtl9301-i2c.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/i2c/realtek,rtl9301-i2c.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Realtek RTL I2C Controller
+
+maintainers:
+  - Chris Packham <chris.packham@alliedtelesis.co.nz>
+
+description:
+  The RTL9300 SoC has two I2C controllers. Each of these has an SCL line=
 (which
+  if not-used for SCL can be a GPIO). There are 8 common SDA lines that =
can be
+  assigned to either I2C controller.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - realtek,rtl9302b-i2c
+              - realtek,rtl9302c-i2c
+              - realtek,rtl9303-i2c
+          - const: realtek,rtl9301-i2c
+      - const: realtek,rtl9301-i2c
+
+  reg:
+    description: Register offset and size this I2C controller.
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+patternProperties:
+  '^i2c@[0-7]$':
+    $ref: /schemas/i2c/i2c-controller.yaml
+    unevaluatedProperties: false
+
+    properties:
+      reg:
+        description: The SDA pin associated with the I2C bus.
+        maxItems: 1
+
+    required:
+      - reg
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c@36c {
+      compatible =3D "realtek,rtl9301-i2c";
+      reg =3D <0x36c 0x14>;
+      #address-cells =3D <1>;
+      #size-cells =3D <0>;
+
+      i2c@2 {
+        reg =3D <2>;
+        #address-cells =3D <1>;
+        #size-cells =3D <0>;
+      };
+    };
diff --git a/Documentation/devicetree/bindings/mfd/realtek,rtl9301-switch=
.yaml b/Documentation/devicetree/bindings/mfd/realtek,rtl9301-switch.yaml
new file mode 100644
index 000000000000..f053303ab1e6
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/realtek,rtl9301-switch.yaml
@@ -0,0 +1,114 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/realtek,rtl9301-switch.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Realtek Switch with Internal CPU
+
+maintainers:
+  - Chris Packham <chris.packham@alliedtelesis.co.nz>
+
+description:
+  The RTL9300 is a series of is an Ethernet switches with an integrated =
CPU. A
+  number of different peripherals are accessed through a common register=
 block,
+  represented here as a syscon node.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - realtek,rtl9301-switch
+          - realtek,rtl9302b-switch
+          - realtek,rtl9302c-switch
+          - realtek,rtl9303-switch
+      - const: syscon
+      - const: simple-mfd
+
+  reg:
+    maxItems: 1
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 1
+
+patternProperties:
+  'reboot@[0-9a-f]+$':
+    $ref: /schemas/power/reset/syscon-reboot.yaml#
+
+  'i2c@[0-9a-f]+$':
+    $ref: /schemas/i2c/realtek,rtl9301-i2c.yaml#
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    ethernet-switch@1b000000 {
+      compatible =3D "realtek,rtl9301-switch", "syscon", "simple-mfd";
+      reg =3D <0x1b000000 0x10000>;
+      #address-cells =3D <1>;
+      #size-cells =3D <1>;
+
+      reboot@c {
+        compatible =3D "syscon-reboot";
+        reg =3D <0x0c 0x4>;
+        value =3D <0x01>;
+      };
+
+      i2c@36c {
+        compatible =3D "realtek,rtl9301-i2c";
+        reg =3D <0x36c 0x14>;
+        #address-cells =3D <1>;
+        #size-cells =3D <0>;
+
+        i2c@0 {
+          reg =3D <0>;
+          #address-cells =3D <1>;
+          #size-cells =3D <0>;
+          gpio@20 {
+            compatible =3D "nxp,pca9555";
+            gpio-controller;
+            #gpio-cells =3D <2>;
+            reg =3D <0x20>;
+          };
+        };
+
+        i2c@2 {
+          reg =3D <2>;
+          #address-cells =3D <1>;
+          #size-cells =3D <0>;
+          gpio@20 {
+            compatible =3D "nxp,pca9555";
+            gpio-controller;
+            #gpio-cells =3D <2>;
+            reg =3D <0x20>;
+          };
+        };
+      };
+
+      i2c@388 {
+        compatible =3D "realtek,rtl9301-i2c";
+        reg =3D <0x388 0x14>;
+        #address-cells =3D <1>;
+        #size-cells =3D <0>;
+
+        i2c@7 {
+          reg =3D <7>;
+          #address-cells =3D <1>;
+          #size-cells =3D <0>;
+          gpio@20 {
+            compatible =3D "nxp,pca9555";
+            gpio-controller;
+            #gpio-cells =3D <2>;
+            reg =3D <0x20>;
+          };
+        };
+      };
+    };
+
--=20
2.47.0


