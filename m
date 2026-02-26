Return-Path: <linux-pm+bounces-43246-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDuyHgNIoGkuhwQAu9opvQ
	(envelope-from <linux-pm+bounces-43246-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 26 Feb 2026 14:17:55 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F12D41A63F0
	for <lists+linux-pm@lfdr.de>; Thu, 26 Feb 2026 14:17:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6DA133180F54
	for <lists+linux-pm@lfdr.de>; Thu, 26 Feb 2026 13:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD96320CD1;
	Thu, 26 Feb 2026 13:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J6Idgqz9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A74A314A86
	for <linux-pm@vger.kernel.org>; Thu, 26 Feb 2026 13:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772111502; cv=none; b=RxndoJhy5/UNnYRasEn4ASmaNiSXVbkfIALuqPynUF4879NNPOy3J2xDOPitnGTdaJN4Xh/zrOnXRsEZfToL/f31dc8qusthofTCIAU2g8mKS6grko9qrVrLW1Hl8kgZnY2kx3G11s5CFYd5N9WA0I/yM5yRcyA403MVHnvFxcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772111502; c=relaxed/simple;
	bh=uM7acMEWg9xtVde6an/R0rIMKgGj7N5BbTvZVGi3OsE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ozrj8s6w3HuHOHScHj1bzPz+PQRB3T+uNr5phYf4Joyh/Yqx3m9bQXGJn67+yrvOTfOv1Rf05wV9APgifRjof33Var3M+r8r48bOq7RIhDBv+cQyP5ioAvFPdrherCgLtqIrp9OcHfnt0YQuMwzAHtFj1XpAjL4KGjKsK5Xgadg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J6Idgqz9; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b90bc00578cso125365866b.0
        for <linux-pm@vger.kernel.org>; Thu, 26 Feb 2026 05:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772111498; x=1772716298; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nnfas49B5o6rQmk/3s9tmpPhHSMTtzj52htjuhnyrV8=;
        b=J6Idgqz97vLvG/s1KMV1OD38s+oAIU6uWVHqBFLP/wLQOxWV/7fMy2LF43Y0y1U3g6
         L6pym+XGdskGMZdEnMCdKnv7vVTvWnHeI4/Ub8oYuwxK8oqtL1mHuLz8TeyFdR88qnTT
         X8vLgOC4cTS7H3L22huahUEGKV/4EiGRR8B+FuxSR9s3GmTV/77LmZM/5TJzhKQLukG7
         8WZUrF18qHm5g90L1TgdpK5UUzsEx+4ieK8uws08fz0JbyUzEHtJPaKOxBFx1pt3gFJT
         UfpfLeFlqRL82+uJchSzjg+37SnJrGPZwTf/lFlnn7C+QcrUde17A1sAxiVKsuervNaW
         EgHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772111498; x=1772716298;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nnfas49B5o6rQmk/3s9tmpPhHSMTtzj52htjuhnyrV8=;
        b=wqsrRjaIaeLeYvQFZ/ZWtnr28FK9t9iEAbPUNv2pIQeKbWvm7R0ky8le1nLMXptmGX
         muKCRbd8bLsU0wT/ujhgvagUU8wSaOf9otSCp4tgQizmk5zxaKCoZGZ6Oh2uw/q1S4eH
         GJvG/nnFfv7d/SFdhNBg4nGw/04QAxnw3elqV+EwUWFSBHJcphzRiNkjnUXTsGuREtq6
         6ULdKCzzUaMGonfmPEwF+FAFc6oTFZy4dLbhZvTTJFGyu1EinZId8J89ysyinUiqsvDC
         ByoKzlW3lx7kAKQWyBVkhnaBjQo7Ghk83idRw/2To5nNNdgFRMitfWA8cdaXuhgJskgm
         wssg==
X-Forwarded-Encrypted: i=1; AJvYcCXDagXJrVGxZD06nBkMNi2/xtGP2YDKPnPE4vGZgOocN4thcQlSAi3KzoFTmi2D7IGEqv5WJWWisw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxZQaV+GQkG3akbR4OK4gnM8sweqym3jqL1t1f3NfAwDeI5MX9Y
	zFBOIGxEX2RbEbpm6fUREzBmfqh22yuICNXhNMjtI8hNhF/c8s6EmNzE7WdrllJ9IL8=
X-Gm-Gg: ATEYQzwxzSYbhbynXIZKupOFQI06Lg7wQRP/ZVHmB4MELS96XRWrjncE0EBo8RfKhsf
	sgIM3zUSZsltHjvtQPAIyafqRNJt04ePvHbQy9FZvGRAHhqOFdfU3IYnDkByt5vljhb6XRkbBko
	P/EKcfEAVAUCM1W2Hn+zJGFSxGF48y1Z9Ei6drGVwkDBRizb8lgkoZoezIfKR4exyxe8GWClLjQ
	+k98wAmsh+Nq+50yeCSSJ9ZEp4DVY3cSXL3s8rAWdQNI4xWq/Bwn5KWBId1FZumW8ks0NS6tAop
	aKeNOhsPMDRR9ONp3RDOpUefpC8o//+2OrWhCroOwhoUkCj4Tw8RuaQJ2ueNYrIYQ3/KBkMTvet
	5UnD431JzORwKDOeuFelLNEkV06qdo7SzfieE1JPqqlCQjoHDo3Oe/VsTD6J+yE5Yw4nu9MaYMC
	90FslQjaviL+krmsMQ4zDwlN68FsnZ+y6uRwmKToCt7GsWw/hbbPTe0Xyujf/hpWKXWPCzvrnKD
	FkbatR8H8Cd5ziJN2c94zkvnnOc
X-Received: by 2002:a17:907:982:b0:b8a:8537:e399 with SMTP id a640c23a62f3a-b935b9324d7mr149288166b.48.1772111498522;
        Thu, 26 Feb 2026 05:11:38 -0800 (PST)
Received: from puffmais2.c.googlers.com (244.175.141.34.bc.googleusercontent.com. [34.141.175.244])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b935ac73d2asm55125866b.26.2026.02.26.05.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 05:11:38 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 26 Feb 2026 13:11:36 +0000
Subject: [PATCH 02/11] dt-bindings: power: supply: max17042: support
 shunt-resistor-micro-ohms
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260226-max77759-fg-v1-2-ff0a08a70a9f@linaro.org>
References: <20260226-max77759-fg-v1-0-ff0a08a70a9f@linaro.org>
In-Reply-To: <20260226-max77759-fg-v1-0-ff0a08a70a9f@linaro.org>
To: Hans de Goede <hansg@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
 Purism Kernel Team <kernel@puri.sm>, Sebastian Reichel <sre@kernel.org>, 
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, Juan Yescas <jyescas@google.com>, 
 Amit Sunil Dhamne <amitsd@google.com>, kernel-team@android.com, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43246-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[linaro.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andre.draszik@linaro.org,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linaro.org:mid,linaro.org:dkim,linaro.org:email]
X-Rspamd-Queue-Id: F12D41A63F0
X-Rspamd-Action: no action

This binding supports the vendor-specific property maxim,rsns-microohm
to describe the value of a shunt resistor required when measuring
currents. shunt-resistor-micro-ohms is a standard property with the
same meaning. Standard properties should be used instead of vendor-
specific ones of similar intention when possible.

Allow this standard property here, while also deprecating the existing
vendor-specific property maxim,rsns-microohm.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml
index 055d1f2ee0ba..25ea8e19b980 100644
--- a/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml
+++ b/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml
@@ -31,7 +31,13 @@ properties:
     description: |
       The ALRT pin (or FG_INTB pin on MAX77759), an open-drain interrupt.
 
+  shunt-resistor-micro-ohms:
+    description:
+      Resistance of rsns resistor in micro Ohms (datasheet-recommended value is 10000).
+      Defining this property enables current-sense functionality.
+
   maxim,rsns-microohm:
+    deprecated: true
     $ref: /schemas/types.yaml#/definitions/uint32
     description: |
       Resistance of rsns resistor in micro Ohms (datasheet-recommended value is 10000).

-- 
2.53.0.414.gf7e9f6c205-goog


