Return-Path: <linux-pm+bounces-43408-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YG1pLcCRpWmREAYAu9opvQ
	(envelope-from <linux-pm+bounces-43408-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 02 Mar 2026 14:33:52 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 273991D9D6F
	for <lists+linux-pm@lfdr.de>; Mon, 02 Mar 2026 14:33:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 159383063B4F
	for <lists+linux-pm@lfdr.de>; Mon,  2 Mar 2026 13:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923923FB064;
	Mon,  2 Mar 2026 13:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yLGBhyBU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37ED3E0C4B
	for <linux-pm@vger.kernel.org>; Mon,  2 Mar 2026 13:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772458340; cv=none; b=O3lew/BKUTKTk3Vgu8m3BFuCGDJD++tlJ4ZczT7JCK8WvChWqvSLLG4HYi1xn0010MWBU7I243ZchUtYS9fyEIgyKMVtrqqHfuulNqNnV77MrqijUvG3pCXKn1QpkQ48fKzCb9/yny4RhwJIi1U5VaLOQ8vrwkZGmxNo3k0vPb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772458340; c=relaxed/simple;
	bh=iJGqesgR7MlveqxFlCsVL9U0vJy5z+2BB/KiYiOfDGk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VIF1WqiOGNGzqd0imxL3ZGJ95jSRFfKZPs4Y6Jm5ZYwgaHVtkVbkDj1DJpNSO04C6wNjq5QejyGzcOFHHWpDjPLOi5R5BZvfHD3z/1OxS9+PYEPZTUcl6ntS+lVd8FqpmlwVSAD7SeGpONzK6JdS6Qv3xZilTqlIFk6+dTX0ZTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yLGBhyBU; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-65bfc858561so8081406a12.2
        for <linux-pm@vger.kernel.org>; Mon, 02 Mar 2026 05:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772458337; x=1773063137; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uxDE/h9r3IL5ikz6wtRHyU9C69/csAcT/xjQxm2w5X8=;
        b=yLGBhyBUDP6PDFUvR4w9DizPd2ddUN3z/heixPvjbFlAYfAsdJBpAVJK2a9K3AAQAH
         gLE72lrkEbnrFOyEAUMc7ezO7JuNE1wIAMv1VJmyHIZUBtMWE97ceBJIQRKNo/Is+qMg
         v2+Tmf0OWNOsm/uPRlLML7N3fK/DXTYwsCecZ+LcbA963kr/G6Sz3zc558b8ChDCAofQ
         4Uk6GHNTVrZSB9tIq7Ty4rg6ppJvth8hcFIX70m4tm8u+PYT3uiRaN4ntsx3zej4CQhp
         5w0ho1UtqZuaAAYhT5iVZYkiM0kVYjRCIOiquhKFOk0En89P8Qr3zrSXrXqBhmw+MH27
         F0cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772458337; x=1773063137;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uxDE/h9r3IL5ikz6wtRHyU9C69/csAcT/xjQxm2w5X8=;
        b=daZoL5DlgGeWcBXxknKsWuFHK0OEyrssp7jWGgwu6zusZDiwjzYJhxgRLvvu47KrIb
         AuisDQuHo1R3bOsWd6Ye/r0u3+A7mVQtGMT3g5NCkOV1R0zqpQllGkquSyOcPTAhN8us
         gqtjG5OwXhxiLDL0zXUXcZmd1q2BbQEpZ6QYfPd0l4599baG/VAnvcbCaL4U+e2/w/Ox
         weCgqQhzuAQxbAgyXd6C9srkXsjx1SYVFGih45P3ZEtY9Kh61EBkuhYscZweK8edZtEb
         jn+Fmtu4UXj+4J3pR6b8CgFKFpdr5cdVmiMJV9IDDwGA1yEDNt/uPpfXLOIEq5A8bZPv
         k6YQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsu8WSG0DTkiXrPNAia0cbcRLJhqNeyVvjja4t8umIfHEQuLyH+Oh5ppQtS8h2RBGT3QJAj5SV9w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv/cdkoXlEV71C2NVP4eJYgpjNxOyQ1J5XfH1H3I5J5u6eHLuA
	fMRk1TrzdyawKnkFAmVGu+QC2Ik4wfF+NuVPnNy9sGWOAaGKIw4o7IVlEip8vnXs74w=
X-Gm-Gg: ATEYQzyxb7/YKNbyoLl+258Jkbv8S7K2T144uv9UsnxtwjWcaiTSl0ktPlK9QJMLA3M
	Sfku3Os5OcziiPu7G8M0LxJKaOVBjCsoSC2nSj9UzWmXrJJ3Fy/ibMDNfzNcFq8qdsLUk0CtBYJ
	wA5c0dGcZkxHMftwvXQdwpLIbrwRy2ez9x2+y3Lzcnic70Lgs+T8uB8+koCj1lr/7+EuEu7007l
	zY2CmqfpvlQmOudU1vv4JF8n+MRCGCnorLqx8rOpSv9HVbskDFRS3k0+KmI8URv4YPcyonBL7lB
	krCpm4dKkDWSUyAQ7Y9VzdeUQH+yAoNa6ZzsEvCGrjJrK3D4HqkCruBRpA3GHis+Zza8b8f5U2a
	vJL8k3Z+wvfhi0mzZEH07X5xgePXtEV6bIug+XF8q8p8LwExiOhOBi0DvJrJOf+sG/MlyZ758OL
	vL/6bM4Ugxf5EAHsQHtvOjHqaJdkmrEmmPkQoyk1a1lhLnXa0xyZXtyHrcDgw9D+lXRM9Nu0u7R
	XzPISy+BGEOwx4=
X-Received: by 2002:a05:6402:51d0:b0:65b:f30a:1081 with SMTP id 4fb4d7f45d1cf-65fdddef45fmr6870024a12.26.1772458336913;
        Mon, 02 Mar 2026 05:32:16 -0800 (PST)
Received: from puffmais2.c.googlers.com (221.210.91.34.bc.googleusercontent.com. [34.91.210.221])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65fabf6d1c6sm3282988a12.17.2026.03.02.05.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 05:32:16 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Mon, 02 Mar 2026 13:32:01 +0000
Subject: [PATCH v3 02/11] dt-bindings: power: supply: max17042: support
 shunt-resistor-micro-ohms
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260302-max77759-fg-v3-2-3c5f01dbda23@linaro.org>
References: <20260302-max77759-fg-v3-0-3c5f01dbda23@linaro.org>
In-Reply-To: <20260302-max77759-fg-v3-0-3c5f01dbda23@linaro.org>
To: Hans de Goede <hansg@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
 Purism Kernel Team <kernel@puri.sm>, Sebastian Reichel <sre@kernel.org>, 
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Ramakrishna Pallala <ramakrishna.pallala@intel.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, Juan Yescas <jyescas@google.com>, 
 Amit Sunil Dhamne <amitsd@google.com>, kernel-team@android.com, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Conor Dooley <conor.dooley@microchip.com>
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
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43408-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[linaro.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andre.draszik@linaro.org,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,microchip.com:email,linaro.org:mid,linaro.org:dkim,linaro.org:email]
X-Rspamd-Queue-Id: 273991D9D6F
X-Rspamd-Action: no action

This binding supports the vendor-specific property maxim,rsns-microohm
to describe the value of a shunt resistor required when measuring
currents. shunt-resistor-micro-ohms is a standard property with the
same meaning. Standard properties should be used instead of vendor-
specific ones of similar intention when possible.

Allow this standard property here, while also deprecating the existing
vendor-specific property maxim,rsns-microohm.

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
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
2.53.0.473.g4a7958ca14-goog


