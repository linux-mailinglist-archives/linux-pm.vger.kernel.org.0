Return-Path: <linux-pm+bounces-41483-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aF38M/iKd2m9hgEAu9opvQ
	(envelope-from <linux-pm+bounces-41483-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jan 2026 16:40:40 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE248A3DB
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jan 2026 16:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ED952302158E
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jan 2026 15:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4FA340A49;
	Mon, 26 Jan 2026 15:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="KZhomKBK"
X-Original-To: linux-pm@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1773D340279;
	Mon, 26 Jan 2026 15:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769442007; cv=none; b=ah7Wgcl5oDIUqCsmqfU3JE29xwmjgT98rijB6a8BrIc3sQVYglMrPEh+0WZ61q3Xb2LNudC3T6KDqu9G2+papZBuWKE3K1CFfzt69/3mDH4sRrlkLnKC6Yzn2lpALuuOHy/MeQHPdDnolD8sUCTmOFAikVBY+Ex6KL6rw1t1X7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769442007; c=relaxed/simple;
	bh=EoFfBo5hPiItUd0YquJyrcSZKrDBJIGSBOCGyATgRkY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hY4KRax40phdMQPz2r0zfRsrSwERuyxOm3w0OxhiMgpwOAmvv2/bqHXBxNRHWmx6n2dqIOFBWLadBEckKC/IbqC3fsfp88uQELzID5/QDPRGAGMTkRMXde/EReDA0LiI9eNs3v1WLS0QVA7rdREBB25pzLChjGomuwx7eH1C3yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=KZhomKBK; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id B0CD727374;
	Mon, 26 Jan 2026 16:40:04 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zgxnwz87wuUc; Mon, 26 Jan 2026 16:40:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1769442003; bh=EoFfBo5hPiItUd0YquJyrcSZKrDBJIGSBOCGyATgRkY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=KZhomKBK3cAKj4wHLXXg/+Gp9cMnmK9/f8IzJfyVFrPhsXAVNNw3gb5W2PUHqIy9J
	 WxPbkPkSj/7ueV+tuXiEJvSzGqjh+w4WQiaKJ96l40HftVUBJnsFbzGLLWoKPC4FLy
	 vk5jLXIbM5yubxYlfVWMXmWEBwm+He5UtJmLq59zwJ0bYNPmTMGmAiZ6P0muteh9fx
	 B4xfD30VQEwiiGujlno73xbCA4z3kT0NKLu65hXEoui0yZZ0sSazx/+OOTAlmqWQQG
	 DqnBgACRDLHbyku14iiIEAiTGgnFW03j/Uuu/9D1jQv4MQ/8+OBwD+PaEhVplDJZel
	 wT4PQJAhswiGQ==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Mon, 26 Jan 2026 21:09:48 +0530
Subject: [PATCH 1/2] dt-bindings: power: supply: document Samsung S2MU005
 battery fuel gauge
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260126-s2mu005-fuelgauge-v1-1-68a146ed0819@disroot.org>
References: <20260126-s2mu005-fuelgauge-v1-0-68a146ed0819@disroot.org>
In-Reply-To: <20260126-s2mu005-fuelgauge-v1-0-68a146ed0819@disroot.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-41483-lists,linux-pm=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[protonmail.com,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[disroot.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kauschluss@disroot.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[devicetree.org:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6EE248A3DB
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
index 0000000000000..5f945a5369dc8
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
+      fuelgauge@3b {
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


