Return-Path: <linux-pm+bounces-43164-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHCyKQX5nWmeSwQAu9opvQ
	(envelope-from <linux-pm+bounces-43164-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 20:16:21 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3AC18BCB0
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 20:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 245D530D0F97
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 19:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2593A9D90;
	Tue, 24 Feb 2026 19:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="Kicg9aJg"
X-Original-To: linux-pm@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CDC28643A;
	Tue, 24 Feb 2026 19:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771960533; cv=none; b=dINEQ6yx/EDY+JAHPqSn2GcQFWVduH1N2yA9vuUqCt8HRLYNB5mKuoCN8GypW8i1SJd+LZFyaX02Rur4e7Hif1X4PgIwgWGXtepViRa6xfGTtk6qUcMhKTk+4wK+Wo8hTxvfkPVumgtIu97IVO82cJBD0pul6F+rE74S16Sh3GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771960533; c=relaxed/simple;
	bh=clcZ5FJmgMM6ci6aJDybExNNe8nVcW5PdNKApgjNU0o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b6FZgNEFVpL07xLHdwYuArvpTJI5+jV7KOFPTWDENJ+0zvMc2tkdKE87yDIyFOZicmm/WsPOjUwZd0qtIyYBDOmSaqAJS6gG2vqLvOAuxCKOOnFNXLF+BrTQM2anRrcMiCvMGNQJUrfmnz6cS0fsLvk6oUCo9CFGhQREX+jflms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=Kicg9aJg; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 7FD3A26F9E;
	Tue, 24 Feb 2026 20:15:30 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id McWapyWDJkpn; Tue, 24 Feb 2026 20:15:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1771960529; bh=clcZ5FJmgMM6ci6aJDybExNNe8nVcW5PdNKApgjNU0o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Kicg9aJgmgwEcghpV1nVMKNxzeGp5gyyba7Dlrydl58HmnqRNWanPOhfSFBOI596F
	 Z19N4UHHT/2GDRNGRTGUnCtWRCMbtNDp/TVwot50pPkLjM7+T9/K1iJomdHr0TcSk2
	 FG+hQzRD3pw7HNtxPidQycIlMMZIGTLEcBLEveCFMDC+rxOMV4CPotisppMtjVPqV5
	 L6pPlM7DsKMgPHNgv4s/whM0s5zCCdlQkNNAcPVe0MaKA6XIrxsGF8ZgfhOJNwEZuw
	 ZMA4XIN+vDH3QOzV8j+dBep1r4M2yAuGmHH61thBL7B7D06QVhGew75STqLrNaCNQg
	 5B0ZOpJ4F7/3g==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Wed, 25 Feb 2026 00:45:04 +0530
Subject: [PATCH v3 02/13] dt-bindings: leds: document Samsung S2M series
 PMIC RGB LED device
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260225-s2mu005-pmic-v3-2-b4afee947603@disroot.org>
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
	TAGGED_FROM(0.00)[bounces-43164-lists,linux-pm=lfdr.de];
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
X-Rspamd-Queue-Id: 6B3AC18BCB0
X-Rspamd-Action: no action

Certain Samsung S2M series PMICs have a three-channel LED device with
independent brightness control for each channel, typically used as
status indicators in mobile phones. Document the devicetree schema for
this device.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 .../bindings/leds/samsung,s2mu005-rgb.yaml         | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/samsung,s2mu005-rgb.yaml b/Documentation/devicetree/bindings/leds/samsung,s2mu005-rgb.yaml
new file mode 100644
index 0000000000000..6806b6d869ff7
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/samsung,s2mu005-rgb.yaml
@@ -0,0 +1,34 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/samsung,s2mu005-rgb.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RGB LED Controller for Samsung S2M series PMICs
+
+maintainers:
+  - Kaustabh Chakraborty <kauschluss@disroot.org>
+
+description: |
+  The Samsung S2M series PMIC RGB LED is a three-channel LED device with
+  8-bit brightness control for each channel, typically used as status
+  indicators in mobile phones.
+
+  This is a part of device tree bindings for S2M and S5M family of Power
+  Management IC (PMIC).
+
+  See also Documentation/devicetree/bindings/mfd/samsung,s2mps11.yaml for
+  additional information and example.
+
+allOf:
+  - $ref: common.yaml#
+
+properties:
+  compatible:
+    enum:
+      - samsung,s2mu005-rgb
+
+required:
+  - compatible
+
+unevaluatedProperties: false

-- 
2.52.0


