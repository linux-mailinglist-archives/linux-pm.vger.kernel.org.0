Return-Path: <linux-pm+bounces-43247-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGJWNi5IoGkuhwQAu9opvQ
	(envelope-from <linux-pm+bounces-43247-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 26 Feb 2026 14:18:38 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 690211A642A
	for <lists+linux-pm@lfdr.de>; Thu, 26 Feb 2026 14:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC3F1311FD35
	for <lists+linux-pm@lfdr.de>; Thu, 26 Feb 2026 13:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C81314A86;
	Thu, 26 Feb 2026 13:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PkM9zRLi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E881D31812F
	for <linux-pm@vger.kernel.org>; Thu, 26 Feb 2026 13:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772111503; cv=none; b=BXmbsdTbtYTDLSDHxonSJIFhvfPkIIlaBGQV9yojBR+gFm/Cv6e2p+4b8So/7l00BKqcuLr4gxFdU7zDsAoMxkzzTyWFbd71v7A18IaJxbWCSaDLjCBfXbdDmX57mhOnykhVFbm6WIJ+fMsVivN+7uiouynlKEevjGgURyFp5AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772111503; c=relaxed/simple;
	bh=dpB7vybHvYaNtOG9GSlOptAD2SNLEmw7Ly6KU3/DX4w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TAln7APuX2WpTK4Z6+JhIWK/b5iKrNnOGFNDpKokm9c5PIh6wNggAWm9zi1VbsGzZyL9gN2K0b1Ex1wOqmgGOXUoNYOZ3UgOqoNV/P42kDcTSJTUpr/6JBPTwRJhZlgcGzzCMqFungUfevmV8VGE5f1G0olVztwTX4/8PyoGvlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PkM9zRLi; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b8f92f3db6fso132532566b.0
        for <linux-pm@vger.kernel.org>; Thu, 26 Feb 2026 05:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772111499; x=1772716299; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MekPWwkWKFvLogZKhB0/TS01+mJvLYjH2vhAYXNAKWE=;
        b=PkM9zRLiAtgHknPed1anzYkhPyN16ZhWDuLO6YvR99zno6pRQWQg5mbFyZd0ICh9Os
         Z1Il9DpcajaddvBuNuX+rMz0EtqI5jq7oENGRVgcCSfvzRNsd/yafWAOrHhNTb9XavJ5
         777dks2fqFI4ZCeQzVAgnVPgfe/EpXmZtUhSIvIFfLaH4fjD29TYxxcLU49qI3J4UARs
         NlrqAFAYwxG+yDFan+J8kLGXQ+ejlMszxUVPr2T6B4jrVOzpRyUs+16KZmTTzwYVSv7L
         GltH5Qewost/H5IqHJjsNX4ev91Cr+jySFbFwnwAbfFSwWXUuaeDHbzduzfzGiHky/iw
         aHhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772111499; x=1772716299;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MekPWwkWKFvLogZKhB0/TS01+mJvLYjH2vhAYXNAKWE=;
        b=EYSIr0KyNTx4ua4DLxgNONrGuOTlw//qkO5HsCsVNjkTf2Suo27Lf/+LkGzVSmFQ3Z
         3T1NTixWHL3AQUUarmcJv5ltAkvUb73VYwIkKgcqaWEjcqZu0O92n/nZejOtjRQ9raaZ
         fc81SSO2zMXhI+0EYFRqzEMq5w6EEjB59tu/iFs4Q3KPcTyJJD+WaIpP5cjsutCFZEuZ
         wAR7qSgams8ywV3yemhfftwpVeoXwNluXmDrDGxzh1onhLyBrQkU2qACZKc2cG8QHcV9
         Tqaa6kaSSbKQ1IPl9uwqlQUG6Wp+i9i1qbnRm/YgVuLOBqGuWINkq7Qu5qTysB8hDK5i
         +afA==
X-Forwarded-Encrypted: i=1; AJvYcCVwRw5OH1LHzEsaNZFz6Lzjxu85qNYwnuNhqnIG/b1GQFry8tw5EET8lFOvJ6DM7NHT6LVVAsnAcg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxOJTN6Cz1KOwoYa4NfJ4t9li3Y8q/pFFT9/OtAnEkiLVddv1jM
	ijhvpn3ndvid+rJy00Hg4cJMwO+yw1oHWJeGYu1pWMYoDhfA1ywY6RHKHt29UQmY2Pg=
X-Gm-Gg: ATEYQzzaHc4nxjIarlqQifRGMLAdgS4I/8tsEY/BCHtjrAb0uSB0SUHoYfL5TN1TSWl
	gwkD0ZN3ch5QU5JXzA5YOX1Qad6hobpQ/BwimzCpc2ucUXgYOKTtMVA0C3a6Qg5e5GlcONgEGZs
	PjQezjG4da1P2lCwb3OG6Hs+pr+UUO6XxQE+VPARl3gaWuZMygyAvjwPPeePhHsYgks3ltGyw9I
	hHfe+oP516plNHzqW+YARAGV8sW3PenkBr3OfWjL+C8uYaHcy/EMw2BAuCnh9ZGtfUfsktrewG1
	rKidc67M2ij6O4dt406qE2DWYuuXR5cGwpD1L0MS+E/jqxMpsRfzcb/NH+ysfXkikd/1tZfKHii
	+ZAB/wvqiGLSGtzf8nrsbiLZVkaHGCK0PQeDFRiCY35rW/LTId/DatAZSn1CFt8+h06XvmR2DbT
	WeNKl3QthnJeDL+oBygcjMAv3h8C/burKErJxZP8NwVg8pWNiXJOtXJU8h4lYNRdcHUmzfn48oV
	b5f/oaJNGsTbsI42Q==
X-Received: by 2002:a17:907:3e21:b0:b87:15a7:85f7 with SMTP id a640c23a62f3a-b90819c0881mr1458659466b.15.1772111499094;
        Thu, 26 Feb 2026 05:11:39 -0800 (PST)
Received: from puffmais2.c.googlers.com (244.175.141.34.bc.googleusercontent.com. [34.141.175.244])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b935ac73d2asm55125866b.26.2026.02.26.05.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 05:11:38 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 26 Feb 2026 13:11:37 +0000
Subject: [PATCH 03/11] dt-bindings: power: supply: max17042: drop
 formatting specifier |
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260226-max77759-fg-v1-3-ff0a08a70a9f@linaro.org>
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
	TAGGED_FROM(0.00)[bounces-43247-lists,linux-pm=lfdr.de];
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
X-Rspamd-Queue-Id: 690211A642A
X-Rspamd-Action: no action

| denotes a literal (preformatted) block and is not necessary here.

Drop them from this file.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 .../devicetree/bindings/power/supply/maxim,max17042.yaml     | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml
index 25ea8e19b980..242b33f2bcba 100644
--- a/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml
+++ b/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml
@@ -28,7 +28,7 @@ properties:
 
   interrupts:
     maxItems: 1
-    description: |
+    description:
       The ALRT pin (or FG_INTB pin on MAX77759), an open-drain interrupt.
 
   shunt-resistor-micro-ohms:
@@ -39,31 +39,31 @@ properties:
   maxim,rsns-microohm:
     deprecated: true
     $ref: /schemas/types.yaml#/definitions/uint32
-    description: |
+    description:
       Resistance of rsns resistor in micro Ohms (datasheet-recommended value is 10000).
       Defining this property enables current-sense functionality.
 
   maxim,cold-temp:
     $ref: /schemas/types.yaml#/definitions/uint32
-    description: |
+    description:
       Temperature threshold to report battery as cold (in tenths of degree Celsius).
       Default is not to report cold events.
 
   maxim,over-heat-temp:
     $ref: /schemas/types.yaml#/definitions/uint32
-    description: |
+    description:
       Temperature threshold to report battery as over heated (in tenths of degree Celsius).
       Default is not to report over heating events.
 
   maxim,dead-volt:
     $ref: /schemas/types.yaml#/definitions/uint32
-    description: |
+    description:
       Voltage threshold to report battery as dead (in mV).
       Default is not to report dead battery events.
 
   maxim,over-volt:
     $ref: /schemas/types.yaml#/definitions/uint32
-    description: |
+    description:
       Voltage threshold to report battery as over voltage (in mV).
       Default is not to report over-voltage events.
 

-- 
2.53.0.414.gf7e9f6c205-goog


