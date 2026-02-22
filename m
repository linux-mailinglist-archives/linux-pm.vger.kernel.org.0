Return-Path: <linux-pm+bounces-42973-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHFlKfMBm2nPpgMAu9opvQ
	(envelope-from <linux-pm+bounces-42973-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sun, 22 Feb 2026 14:17:39 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 526D616F290
	for <lists+linux-pm@lfdr.de>; Sun, 22 Feb 2026 14:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED00C301A726
	for <lists+linux-pm@lfdr.de>; Sun, 22 Feb 2026 13:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7072E26CE3B;
	Sun, 22 Feb 2026 13:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=abscue.de header.i=@abscue.de header.b="CeKAwOCM"
X-Original-To: linux-pm@vger.kernel.org
Received: from srv01.abscue.de (abscue.de [89.58.28.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8CB217733;
	Sun, 22 Feb 2026 13:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.28.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771766226; cv=none; b=NbODy1gyO4Napb02k1eszv6TK4uR4ZiK64sjTi0MCBjp0lK4iRjjguMYgAHgj/juw628zDu+67FHmEoJKQAW6n+oAuBhMnQeR0eYTDw1e8l59TjwCxxNPGMxOvV+QEQBNe9jnr7Cl0oFfwSb8H+LH73EJhwQw90Me4DTPMkhO90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771766226; c=relaxed/simple;
	bh=O/KjtfYAh0eFvpJG4/ufSjwPAa+DibSdtcTaPMSW4so=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c+5EUMeVhGMj7w1RtW98Igeg5jy9ChMjNFQKr99s2qnrgCU/ouIxudusIWW/yaHM7TusZ99VWveb91AUxQqStPcARoPpJL8L9McVizyHchiK1Nb5hBKu8XDlBKNnLFwiSoEsxgR+6sAk/XKtfJysjzM9LQmqqBoHGMddzsfeDt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de; spf=pass smtp.mailfrom=abscue.de; dkim=fail (0-bit key) header.d=abscue.de header.i=@abscue.de header.b=CeKAwOCM reason="key not found in DNS"; arc=none smtp.client-ip=89.58.28.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=abscue.de
Received: from fluffy-mammal.metal.fwg-cag.de (unknown [IPv6:2001:9e8:cde0:3300:edee:770f:8e03:a80])
	by srv01.abscue.de (Postfix) with ESMTPSA id 946B61C01B9;
	Sun, 22 Feb 2026 14:16:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=abscue.de; s=dkim;
	t=1771766217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RcLqEbWvExfOz69WSf7UPJzVd4m3ddxOxrR/3cYwXIo=;
	b=CeKAwOCMFsMDF9emlbptb4/2tfUnyf7RaBZoRRtr7CxXmN6N4O+jSm1lgqYR1/9PAMU93i
	Q6WLABBhYXyJjvfM+XbJkL1w3uixjsK1TqiSj05XFUBCWYcFbnKgcQIaCxN0+NGLtIR24l
	ReiFeryqF2hhh0YG/KadHM2ukmgp5/rxZvX+IbO6MtA8wa3YHVOtk0snqzmQvSAcSaNjhy
	0C0tlLXt4IIU8W6p6+jqZF0gJILUlfoaBxpPnEdU/io8rQ55Ej5a2G53g+s9rrdWt8DCVj
	SiFZCKJMsNyqR2s5kqZURha8N9F/+xr81UrLH1vEiY6BvvbBcQ3CiTO3w6kSrA==
From: =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
Date: Sun, 22 Feb 2026 14:16:47 +0100
Subject: [PATCH 3/6] regulator: dt-bindings: sc2731: Deprecate compatible
 property
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260222-sc27xx-mfd-cells-v1-3-69526fe74c77@abscue.de>
References: <20260222-sc27xx-mfd-cells-v1-0-69526fe74c77@abscue.de>
In-Reply-To: <20260222-sc27xx-mfd-cells-v1-0-69526fe74c77@abscue.de>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, Lee Jones <lee@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Sebastian Reichel <sre@kernel.org>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, 
 linux-pm@vger.kernel.org, 
 =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
X-Mailer: b4 0.14.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42973-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[abscue.de];
	FREEMAIL_TO(0.00)[bootlin.com,kernel.org,gmail.com,linux.alibaba.com];
	R_DKIM_PERMFAIL(0.00)[abscue.de:s=dkim];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[abscue.de:~];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[otto.pflueger@abscue.de,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.597];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,abscue.de:mid,abscue.de:email]
X-Rspamd-Queue-Id: 526D616F290
X-Rspamd-Action: no action

The node containing the regulators is always a child of the main PMIC
node, which already has a compatible property identifying the type of
PMIC. This makes the compatible in the child node redundant. Mark it
as deprecated and remove it from the required property list and the
examples.

Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
---
 Documentation/devicetree/bindings/mfd/sprd,sc2731.yaml                | 2 --
 .../devicetree/bindings/regulator/sprd,sc2731-regulator.yaml          | 4 +---
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/sprd,sc2731.yaml b/Documentation/devicetree/bindings/mfd/sprd,sc2731.yaml
index b023e1ef8d3c..12b3258daef5 100644
--- a/Documentation/devicetree/bindings/mfd/sprd,sc2731.yaml
+++ b/Documentation/devicetree/bindings/mfd/sprd,sc2731.yaml
@@ -222,8 +222,6 @@ examples:
         };
 
         regulators {
-          compatible = "sprd,sc2731-regulator";
-
           BUCK_CPU0 {
             regulator-name = "vddarm0";
             regulator-min-microvolt = <400000>;
diff --git a/Documentation/devicetree/bindings/regulator/sprd,sc2731-regulator.yaml b/Documentation/devicetree/bindings/regulator/sprd,sc2731-regulator.yaml
index 9bd752bab68e..7af20a4781b7 100644
--- a/Documentation/devicetree/bindings/regulator/sprd,sc2731-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/sprd,sc2731-regulator.yaml
@@ -26,6 +26,7 @@ description: |
 
 properties:
   compatible:
+    deprecated: true
     const: sprd,sc2731-regulator
 
 patternProperties:
@@ -39,8 +40,5 @@ patternProperties:
     $ref: regulator.yaml#
     unevaluatedProperties: false
 
-required:
-  - compatible
-
 additionalProperties: false
 ...

-- 
2.51.0


