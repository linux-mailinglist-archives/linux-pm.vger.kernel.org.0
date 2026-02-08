Return-Path: <linux-pm+bounces-42266-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIdtF8zNiGn6wAQAu9opvQ
	(envelope-from <linux-pm+bounces-42266-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sun, 08 Feb 2026 18:54:20 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 05CB21099CF
	for <lists+linux-pm@lfdr.de>; Sun, 08 Feb 2026 18:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BDEEE3030B39
	for <lists+linux-pm@lfdr.de>; Sun,  8 Feb 2026 17:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F562E8DEB;
	Sun,  8 Feb 2026 17:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="OoSsIyae"
X-Original-To: linux-pm@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2ACE2E7623;
	Sun,  8 Feb 2026 17:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770573209; cv=none; b=IWx9wNTi7EPkJUZZcXS79zDLvNNP9pT3T6/t8A5iZWvpgbXK6UtaJMzm+T9bNNDqv0Lp+8w1jeeZks/RKLHVoao9TjyRLkIk2a5/KsV1pRay5GD8qTCW+M2KnSOWw4qjh2eVK0ZUjIzNno0RC6AUf4k0DnodQ0q4yREd5hxMo60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770573209; c=relaxed/simple;
	bh=E+H4LBoeJ/ftgGgKbAViwKF8hz1RW0oyNxeyhY46F8Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EG515bzWtWk8EX5X+xU7g1T3dGKY6caRPPVW1dUty7oQlnEv5spfhroowZq5eqa8vbzgX3SvY+HUeGR325kZj0ybqxQeNGHT5Dwj6h4OT6U4YWIZDTHVf9LrsFmQTrGU1tKVc/0rWbJkbL+Ya4Taxu/WXdlPypkHAS/vr+3b7rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=OoSsIyae; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 37D6D27185;
	Sun,  8 Feb 2026 18:53:22 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lkt_tuI4LeyE; Sun,  8 Feb 2026 18:53:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1770573201; bh=E+H4LBoeJ/ftgGgKbAViwKF8hz1RW0oyNxeyhY46F8Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=OoSsIyae3tW0ZcjyxxWu0qJojQ6ZeK08IAFaNG5oaxT0rKJPpUwOIdo9V919FQAtb
	 ctj31+YsOsIoMd5TjUtxOTj7mTIfehZfLscZHEhkuDyIMSMh+LEsZ7W44s+Y3XJ7Sa
	 xpw40Y5sdq47PmiV8p6+PGYB7cl9St0kujGtufVubzIBo9KfbNwJysESorpfKMlT0+
	 R3I5eLyCXeAInDc2Skh9wRfdxOkIBaX3VvRusGLnK8kfx2n3FkrSgjccM4gipRzsuF
	 P1/pU1mDfIycrYFGkbpsRERDbD98OCDJuzMc1MQLf+Kcr3+LhvoATrUItTa7GzHec3
	 +RRz8uVMTtlUQ==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Sun, 08 Feb 2026 23:22:30 +0530
Subject: [PATCH v2 1/2] dt-bindings: power: supply: document Samsung
 S2MU005 battery fuel gauge
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260208-s2mu005-fuelgauge-v2-1-be3af8969291@disroot.org>
References: <20260208-s2mu005-fuelgauge-v2-0-be3af8969291@disroot.org>
In-Reply-To: <20260208-s2mu005-fuelgauge-v2-0-be3af8969291@disroot.org>
To: Yassine Oudjana <y.oudjana@protonmail.com>, 
 Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kaustabh Chakraborty <kauschluss@disroot.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[disroot.org,reject];
	R_DKIM_ALLOW(-0.20)[disroot.org:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-42266-lists,linux-pm=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[protonmail.com,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[disroot.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kauschluss@disroot.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.956];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[disroot.org:email,disroot.org:dkim,disroot.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 05CB21099CF
X-Rspamd-Action: no action

Samsung S2MU005 is a PMIC device which has LED controllers, an MUIC and
a battery charger. The battery charger is paired with an independent
device connected via I2C which can be used to access various metrics of
the battery. Document the device as a schema.

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
2.52.0


