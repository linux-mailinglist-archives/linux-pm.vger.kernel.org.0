Return-Path: <linux-pm+bounces-43165-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJ/4Ih75nWlzSwQAu9opvQ
	(envelope-from <linux-pm+bounces-43165-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 20:16:46 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 43EB818BCE7
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 20:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0807B30DCC07
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 19:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5983AA1A0;
	Tue, 24 Feb 2026 19:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="BhWN6Rkq"
X-Original-To: linux-pm@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B1228643A;
	Tue, 24 Feb 2026 19:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771960540; cv=none; b=nsXhGmkn18y394rIlEwCNKtR0fN6eGIXFWR3BMagfrPbArBAlyGVAg3TguJcXPntTYXVWXlCvqSaC0kojg13tDpJl3gGvYLXqcocoky2UEPWSSs2Hu89O1f30cjotTvMk8c0RwEI+mwBx+k/htd0lSoO71J7U+4F7ce9bqrpNxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771960540; c=relaxed/simple;
	bh=vUzSdb23mgItjzTQ86+3X3cZ0kXwjbBMNG9uEN6O5yw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VE92qALjqVaDz8xuEjCpZ2iv3uIQJb41L/lYQUC2bzQzxipFcaMgjIXn7K2/fsKe4PO9cBo5CSDAlFU/LSzL3qBKD6FK7OT2ZO6lf5s9K445I1+CdQgFmG48rQV8H0grrrzT8DkGX5q0LPYa9qMHaSo6PefYZ8s/EtsJPWhFqjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=BhWN6Rkq; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 52C6926250;
	Tue, 24 Feb 2026 20:15:37 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id avV5tHAzLIog; Tue, 24 Feb 2026 20:15:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1771960536; bh=vUzSdb23mgItjzTQ86+3X3cZ0kXwjbBMNG9uEN6O5yw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=BhWN6RkqgeUuxJxnVecfv0to8QaDkIdyqxvLzcEcxNC04HgCcTPCUKUp37aURp9UV
	 ejj28tSnZrtk+S8+jG2HKgyW8zODq8mqztTn85Gw5WJ3kkQtwWb1FAm+pLpKXE5jAn
	 89SHkrCYoA9HiwyJMVcw7x6cQ/etHZKJZbqa6ukCz7rDVgslhfbZzxWH4wK32mPrqd
	 DTl0n7Fz5q7B17lRU7jDFKYmAc9ZQarnQrUAz/Ft0mt29Gm0F92qd41SXDrJkaJdUG
	 mlTkWLobJfztOGtKvzDH4uIKsyg7GvxEw32iwo3P2Lv9ts5Bm0iLH78jb8Eyp1faxG
	 Wllxc9NWt9eZw==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Wed, 25 Feb 2026 00:45:05 +0530
Subject: [PATCH v3 03/13] dt-bindings: extcon: document Samsung S2M series
 PMIC extcon device
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260225-s2mu005-pmic-v3-3-b4afee947603@disroot.org>
References: <20260225-s2mu005-pmic-v3-0-b4afee947603@disroot.org>
In-Reply-To: <20260225-s2mu005-pmic-v3-0-b4afee947603@disroot.org>
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Sebastian Reichel <sre@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Nam Tran <trannamatk@gmail.com>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, linux-rtc@vger.kernel.org, 
 linux-doc@vger.kernel.org, Kaustabh Chakraborty <kauschluss@disroot.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[disroot.org,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[disroot.org:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43165-lists,linux-pm=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,samsung.com,linaro.org,bootlin.com,lwn.net,linuxfoundation.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kauschluss@disroot.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[disroot.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,disroot.org:mid,disroot.org:dkim,disroot.org:email,devicetree.org:url]
X-Rspamd-Queue-Id: 43EB818BCE7
X-Rspamd-Action: no action

Certain Samsung S2M series PMICs have a MUIC device which reports
various cable states by measuring the ID-GND resistance with an internal
ADC. Document the devicetree schema for this device.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 .../bindings/extcon/samsung,s2mu005-muic.yaml      | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/Documentation/devicetree/bindings/extcon/samsung,s2mu005-muic.yaml b/Documentation/devicetree/bindings/extcon/samsung,s2mu005-muic.yaml
new file mode 100644
index 0000000000000..e047e8cbc264e
--- /dev/null
+++ b/Documentation/devicetree/bindings/extcon/samsung,s2mu005-muic.yaml
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/extcon/samsung,s2mu005-muic.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MUIC Device for Samsung S2M series PMICs
+
+maintainers:
+  - Kaustabh Chakraborty <kauschluss@disroot.org>
+
+description: |
+  The Samsung S2M series PMIC MUIC device is a USB port accessory
+  detector. It reports multiple states depending on the ID-GND
+  resistance measured by an internal ADC.
+
+  This is a part of device tree bindings for S2M and S5M family of Power
+  Management IC (PMIC).
+
+  See also Documentation/devicetree/bindings/mfd/samsung,s2mps11.yaml for
+  additional information and example.
+
+properties:
+  compatible:
+    enum:
+      - samsung,s2mu005-muic
+
+  connector:
+    $ref: /schemas/connector/usb-connector.yaml#
+
+  port:
+    $ref: /schemas/graph.yaml#/properties/port
+
+required:
+  - compatible
+  - connector
+  - port
+
+additionalProperties: false

-- 
2.52.0


