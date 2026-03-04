Return-Path: <linux-pm+bounces-43588-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLKzNbBnqGl3uQAAu9opvQ
	(envelope-from <linux-pm+bounces-43588-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 18:11:12 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C46204ED5
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 18:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 628E030D0B24
	for <lists+linux-pm@lfdr.de>; Wed,  4 Mar 2026 17:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F7F379993;
	Wed,  4 Mar 2026 17:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="JHV4pP1Y"
X-Original-To: linux-pm@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0695378804;
	Wed,  4 Mar 2026 17:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772643860; cv=none; b=NsHqEhD0cGXhp0p36N/XxiszB8JF6kkQPPqLuTdnFO7t4ld7wd2mJshkexGKqGCgTeDYYKt5IyYE0GbqHKhhR1JdWZX0UD2wB7JzYbO6TQMCsftOHfvPFIwvJrqq/+hajzI5LvsG/HjZsscADnpzk8BFrP66z7nwGmUnl1x7mDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772643860; c=relaxed/simple;
	bh=F0R+U99Z+UhtqfAJSgAScg5AO+4DBZrXauWOxdl8xoE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oF50BMlcVhe8tFXKXHBaFmwi3YBt3yLrKj4cjE+l4ccAIU/KSk49Di9C2hdGvUXsIE6JjHGvAaSugJnjsSSE7T6I38QIIJwBnqsPCSV4NKm4di+jkLRT+QeN9Boa3S3BDV1OZ7IvC8rGuG4llOsfc08bHYpjfUX+jrQGUWLHuco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=JHV4pP1Y; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 8B95D2701A;
	Wed,  4 Mar 2026 18:04:10 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bIhmuLA0uHu9; Wed,  4 Mar 2026 18:04:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1772643849; bh=F0R+U99Z+UhtqfAJSgAScg5AO+4DBZrXauWOxdl8xoE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=JHV4pP1YCCjXG3n2H2JXI0Tx9n7R58VTRF5BsaXrJQ4iY/azpq/T4XVxYL2t5C4na
	 NuHHKE5bgLUBSLSnx2JTOIS8U4/G+Iry4qo1D+uU8e4VwZZuY6KvqyeZGPrc241hVs
	 ukl5v0dCAgdDaE/2/xKpBVrkKpVmFV+Acf7yZF0l7wAio/4FJdCzT7WZkyidxAK0ck
	 9Pnl4C1j1O/os0fa3wPPJaG47aoehltP9eRLdaRnN4952xdzcahk4A8w0dtAZPEcyk
	 JPyMbAc1wnzRrZ8cPIE2YW64ZjPx5xrTUfzE0i43U5WSaRINcPac54ZY6t18NkfjaA
	 bxxawrYsTMHyw==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Wed, 04 Mar 2026 22:33:55 +0530
Subject: [PATCH v3 1/2] dt-bindings: power: supply: document Samsung
 S2MU005 battery fuel gauge
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260304-s2mu005-fuelgauge-v3-1-e4dc4e47cde8@disroot.org>
References: <20260304-s2mu005-fuelgauge-v3-0-e4dc4e47cde8@disroot.org>
In-Reply-To: <20260304-s2mu005-fuelgauge-v3-0-e4dc4e47cde8@disroot.org>
To: Yassine Oudjana <y.oudjana@protonmail.com>, 
 Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Rspamd-Queue-Id: 53C46204ED5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[disroot.org,reject];
	R_DKIM_ALLOW(-0.20)[disroot.org:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-43588-lists,linux-pm=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[protonmail.com,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[disroot.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kauschluss@disroot.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,disroot.org:dkim,disroot.org:email,disroot.org:mid,devicetree.org:url,microchip.com:email,3b:email]
X-Rspamd-Action: no action

Samsung S2MU005 is a PMIC device which has LED controllers, an MUIC and
a battery charger. The battery charger is paired with an independent
device connected via I2C which can be used to access various metrics of
the battery. Document the device as a schema.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 .../power/supply/samsung,s2mu005-fuel-gauge.yaml   | 49 ++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/samsung,s2mu005-fuel-gauge.yaml b/Documentation/devicetree/bindings/power/supply/samsung,s2mu005-fuel-gauge.yaml
new file mode 100644
index 0000000000000..05e420316a26b
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/samsung,s2mu005-fuel-gauge.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/samsung,s2mu005-fuel-gauge.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Battery Fuel Gauge for Samsung S2M series PMICs
+
+maintainers:
+  - Kaustabh Chakraborty <kauschluss@disroot.org>
+
+allOf:
+  - $ref: power-supply.yaml#
+
+properties:
+  compatible:
+    enum:
+      - samsung,s2mu005-fuel-gauge
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      fuel-gauge@3b {
+        compatible = "samsung,s2mu005-fuel-gauge";
+        reg = <0x3b>;
+
+        interrupt-parent = <&gpa0>;
+        interrupts = <3 IRQ_TYPE_EDGE_BOTH>;
+
+        monitored-battery = <&battery>;
+      };
+    };

-- 
2.53.0


