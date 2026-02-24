Return-Path: <linux-pm+bounces-43166-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJXYJTj5nWmeSwQAu9opvQ
	(envelope-from <linux-pm+bounces-43166-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 20:17:12 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3010018BD34
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 20:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0A55430EBFB9
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 19:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19133ACA45;
	Tue, 24 Feb 2026 19:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="AgIbaGII"
X-Original-To: linux-pm@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843A02BD012;
	Tue, 24 Feb 2026 19:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771960546; cv=none; b=Ib1wYkBF2dJBUXwrzeGMZr8e3Ay9RkEeYsNgTHWQrxdh0UydOqXKdjkz4rxq01rChXnQwk67LbozTu4kWHEuHp9RKRkmvPbGZXSKNHl2uYgIeMXNcpAXgs3Rje0NNAI9ukNwpDyTrSMWB8OthZKObG0bRmmhuKGA2BzXm+O2ho0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771960546; c=relaxed/simple;
	bh=v18ecyJjpRt8OYAuP8S1Zuke3HLjhsE22p1SX0Vty34=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mP0ILxXDQ7n5O+fWGM2vOez7eFqY3t2MMkuO0yDO9421YasDRyEM25n3XWKqT8Q2RMb5zXxGAHWiAt/02sW8Y0iDXPTUkKro0PwBdf1RBb5gZEtlGjGU8v/F18mLd6gXsb9oR2GVMD+1vhv+LWrPLV7fM8brvNn3bxu2dpzA9K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=AgIbaGII; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 1AE4E2696F;
	Tue, 24 Feb 2026 20:15:44 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HJwJlmwNeWBN; Tue, 24 Feb 2026 20:15:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1771960543; bh=v18ecyJjpRt8OYAuP8S1Zuke3HLjhsE22p1SX0Vty34=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=AgIbaGIIBv69ADODQo7KduJc0OwEX1XODQEUcJFaaIsUODc4gWn2xu+HuddUtO5Sj
	 wiyttlHKbzIrnv1K2e13X7GinVKpbSA1b0ADVllk9KrBkyBaR+cT4P3nkq9tHXZLC1
	 Su7TW/KL+Gu6kdNBtkCrKk0ZEfC2wofEPzXLTDgBULAm5k2x/qoWlft/Z2dqskUhFz
	 21xgOzc8noVL9DXvQYH58gTszv6F+84TJxIWGZPl5r922vrd3GsbUx4/5E2Kh9cLar
	 yU/Sspa0wr/my4IkgEaECEWIDpLVSojloIucXhQTAWBaPQwSpf+YH5EnnBzER8jA5c
	 jBCZT89xy5KfA==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Wed, 25 Feb 2026 00:45:06 +0530
Subject: [PATCH v3 04/13] dt-bindings: power: supply: document Samsung S2M
 series PMIC charger device
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260225-s2mu005-pmic-v3-4-b4afee947603@disroot.org>
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
	TAGGED_FROM(0.00)[bounces-43166-lists,linux-pm=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,devicetree.org:url,disroot.org:mid,disroot.org:dkim,disroot.org:email]
X-Rspamd-Queue-Id: 3010018BD34
X-Rspamd-Action: no action

Certain Samsung S2M series PMICs have a battery charger device which,
among other things, manages power interfacing of the USB port. It may
supply power, as done in USB OTG operation mode, or it may accept power
and redirect it to the battery fuelgauge for charging. Document this
device.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 .../power/supply/samsung,s2mu005-charger.yaml      | 35 ++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/samsung,s2mu005-charger.yaml b/Documentation/devicetree/bindings/power/supply/samsung,s2mu005-charger.yaml
new file mode 100644
index 0000000000000..9159a15e77c61
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/samsung,s2mu005-charger.yaml
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/samsung,s2mu005-charger.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Battery Charger for Samsung S2M series PMICs
+
+maintainers:
+  - Kaustabh Chakraborty <kauschluss@disroot.org>
+
+description: |
+  The Samsung S2M series PMIC battery charger manages power interfacing
+  of the USB port. It may supply power, as done in USB OTG operation
+  mode, or it may accept power and redirect it to the battery fuelgauge
+  for charging.
+
+  This is a part of device tree bindings for S2M and S5M family of Power
+  Management IC (PMIC).
+
+  See also Documentation/devicetree/bindings/mfd/samsung,s2mps11.yaml for
+  additional information and example.
+
+allOf:
+  - $ref: power-supply.yaml#
+
+properties:
+  compatible:
+    enum:
+      - samsung,s2mu005-charger
+
+required:
+  - compatible
+
+unevaluatedProperties: false

-- 
2.52.0


