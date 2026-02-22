Return-Path: <linux-pm+bounces-42971-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDGoNNcBm2nPpgMAu9opvQ
	(envelope-from <linux-pm+bounces-42971-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sun, 22 Feb 2026 14:17:11 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8031B16F23F
	for <lists+linux-pm@lfdr.de>; Sun, 22 Feb 2026 14:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6065300C5A9
	for <lists+linux-pm@lfdr.de>; Sun, 22 Feb 2026 13:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B820F261B9E;
	Sun, 22 Feb 2026 13:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=abscue.de header.i=@abscue.de header.b="AlrVHdRr"
X-Original-To: linux-pm@vger.kernel.org
Received: from srv01.abscue.de (abscue.de [89.58.28.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2F114884C;
	Sun, 22 Feb 2026 13:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.28.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771766225; cv=none; b=Df1sHDGHXkV9fY3h+9NCghhGb90p4GThIkixaV1NEh5mn8ox0gDj7d0hmYZ58zVUrYDL1sis2pdvfNOQPXDTzCh6pv/4RB7h7LQgulCMvAEN60olmVzE1nGSYMmyfyLsxYv5okfFppfCKjOEOkxYX9E/KMEBSB1Ngl6fBrJHIc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771766225; c=relaxed/simple;
	bh=AHPZ9Kg9EFIN+ClL/kYY6iSAVzrJSjLABlAe68S0iGM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aHnP7epO5oKaWtp6Cx0kYrTIwLA9rc87aeuyMnXtvoNUPtmUZGv9OOePLzMxXyTWdpqeASmcqdLw8OZVIJrRP3k1gZ4TI4NqDckf3OgIDGow/DaulQaioqcGTzdOuFODxoB8yMMDtIAIn3Wx4p7tCYO6q50zB5IzhJodTcJGXw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de; spf=pass smtp.mailfrom=abscue.de; dkim=fail (0-bit key) header.d=abscue.de header.i=@abscue.de header.b=AlrVHdRr reason="key not found in DNS"; arc=none smtp.client-ip=89.58.28.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=abscue.de
Received: from fluffy-mammal.metal.fwg-cag.de (unknown [IPv6:2001:9e8:cde0:3300:edee:770f:8e03:a80])
	by srv01.abscue.de (Postfix) with ESMTPSA id 1D2671C01B8;
	Sun, 22 Feb 2026 14:16:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=abscue.de; s=dkim;
	t=1771766216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WlpsFxs1P7Smm7vuYQgOouHaz0DCYqvCEq9UTsUNOYE=;
	b=AlrVHdRr+rMjHooTQ5epEnGGR8MCMrmIsT0kzYIJT5+PUauqOMWgmpSyVPxfXPx5nwkWww
	FVl0Vl0WCj4+SOQ82rpbqta4OF1w0AVHVeoVk7Lo/AsYe2B1Z+X2cjzrTh/Rdnbx2krcVu
	ws5XawwjkeJwulcq7bVRT50+xWb2u7w/Gu3K1mMcd5fN272f/2cZ4qZl7TjDm29i64PbcG
	KF4NWegXwsffX+d/5cY93cLJoyQanoAQ//M7IkiF8lQs2lTtqGzp8THq5qZ4gp92cVpD4Q
	Lwnyy4d/6qYmyj32Ghngth0pgLxrRrm3ctoBauq3IPL6aSmlQBTzjsd4f+/Nag==
From: =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
Date: Sun, 22 Feb 2026 14:16:46 +0100
Subject: [PATCH 2/6] dt-bindings: leds: sc2731: Add compatible for SC2730
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260222-sc27xx-mfd-cells-v1-2-69526fe74c77@abscue.de>
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
	TAGGED_FROM(0.00)[bounces-42971-lists,linux-pm=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.648];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8031B16F23F
X-Rspamd-Action: no action

The LED controller found in the SC2730 PMIC is compatible with the one
found in the SC2731 PMIC.

Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
---
 Documentation/devicetree/bindings/leds/sprd,sc2731-bltc.yaml | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/leds/sprd,sc2731-bltc.yaml b/Documentation/devicetree/bindings/leds/sprd,sc2731-bltc.yaml
index 97535d6dc47a..2ae5cc31e623 100644
--- a/Documentation/devicetree/bindings/leds/sprd,sc2731-bltc.yaml
+++ b/Documentation/devicetree/bindings/leds/sprd,sc2731-bltc.yaml
@@ -18,7 +18,12 @@ description: |
 
 properties:
   compatible:
-    const: sprd,sc2731-bltc
+    oneOf:
+      - items:
+          - enum:
+              - sprd,sc2730-bltc
+          - const: sprd,sc2731-bltc
+      - const: sprd,sc2731-bltc
 
   reg:
     maxItems: 1

-- 
2.51.0


