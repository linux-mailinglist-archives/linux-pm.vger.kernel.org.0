Return-Path: <linux-pm+bounces-43283-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFK/MaBEoWkirwQAu9opvQ
	(envelope-from <linux-pm+bounces-43283-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 27 Feb 2026 08:15:44 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5749C1B3B3F
	for <lists+linux-pm@lfdr.de>; Fri, 27 Feb 2026 08:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C249130D2D6C
	for <lists+linux-pm@lfdr.de>; Fri, 27 Feb 2026 07:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C263361670;
	Fri, 27 Feb 2026 07:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S6nxxV/N"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D141FF61E
	for <linux-pm@vger.kernel.org>; Fri, 27 Feb 2026 07:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772176514; cv=none; b=luLa4kJlfE48oq6k9TYdk6iFun9ucTn7IWR2HcROn7V6tKmKV5vaWQiUpvOUd0y4/Gc0EXICoxqGcQA0l2fz3q7+yMVdRRR+HXiLu9cj5+wV+YHp/z0oy1v8L4wi1/QPOIymMANbXowNXi5mI+TApLy2vwdgsHGOpct/0kl7+EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772176514; c=relaxed/simple;
	bh=tN/WXJoP7ER+xNNQ3wof85nYFtwctlJaEphC1C0qnK0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UnDHBo3w4XQKn+70XkjYIJfEVyZm3n2pE8tYdbfRaZby46hQm25pMLPfdDM5GZsucTRrtKMypbggxzF75nwjmmUDYRJnXOTNetBkqeA6+wI+KO+rpaHDgaU/OzGyXMpCPGXfodvSzh3ZJTcXYpjKGjmVq4j9s/5sez93yds8qP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S6nxxV/N; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-65fb991d7eeso2419395a12.0
        for <linux-pm@vger.kernel.org>; Thu, 26 Feb 2026 23:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772176511; x=1772781311; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=46zMNmq5bUi3mZ6HnIKgyhoL+nelJFQRkft5kdOS8cA=;
        b=S6nxxV/N10+VtAOO+TfHZ1+41AIEUOqRkUvAnxa8kJzCaeLpp7Ic2AGjcH/m9mCjoa
         rUJnxLv8XvwmUZwRq84xdWQ4M+Yjy/N82cn574oWLW8RoKvJbd0iSBStRq4ZIpkThLv5
         zLiA6vyRct7RaZ5NgbXQ/lKLO/eQ3TAtM+0hCQlq90USZLWXNFaF1/gmHtoheCc4uoPX
         OlInbaau+mG8ZGj1bHIo+KaxNIe34mA9zCdO/mst5gC9HnRMIDYBKEvJ8hVJvnBWBZws
         qcuJ6Uqd8U6YkuV+cOMc82/I43h/7OsneZ13GH2ypQ91orq0XoUnLp3gpP5EMqiw6fzS
         efPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772176511; x=1772781311;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=46zMNmq5bUi3mZ6HnIKgyhoL+nelJFQRkft5kdOS8cA=;
        b=NtHcYr/Krn0dUZaHRy/3G8CugnArlPW/MO+NcRXoYRGgCAxpDSypcfyUEyl6Vf0Fsa
         VsuvMtE/Li0HMRDUlWSqBffXET4COUTgti3jYypbUICM331GDvRS+yRKhP57qDtnQACk
         K3bfCKY2ZlqPMlektH8Kc1VVJrnBVefGhg71PGfIcj/fiNbZY7zHuKY/s8lL+ppvWyrU
         Ai6No0Y8UjoU1+MJidE/ZlGrbphj7ueFXXv2lNGQvKjuWy0rbCS3jQvZDowxRgK4oOA0
         YRmbZRFTW8FLMSpHiVaSytlNim6QFpByK9SkgAIqtveTLSaXMzdl7TBkDZVQs5qQiIwB
         05EQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMwVBxVlkUZ3W+lKPY6cYFsm3RFhPxZPbMD1qEnN00TF1PcPEVFrF69rtjowWmNmE/O0/Pdb4jyg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwgUPLHnO77zmvceAR7E/wMpXX0gGT4+WRCBVMnhDjSF0jmA4QT
	RMC5VFGgVkBA07r66TQmjmUZZohFo74Hb0m4pJUSaB85BLD72SGAWOCW3SVo09yPupE=
X-Gm-Gg: ATEYQzynFjxS5dDIyf+GzVcZMc3Qd++xT/4akm8aWGx6z5wEsjn33EZMQNk63VLWAwL
	TNet5u6vYxwUJFsvscoYM7iAJU1nmZiq0FN0T/KBIROudtU9M5Slh9f6xiFFhmreVfxVin49z5Y
	j+WuJocBYe82i+yCUHKasTgUipa368PewvKqSRpOngBncMtpRFyn+oGe694TKhdiitIjLfEn5yU
	JsUt0ugZKmyl1k2Ewoo6pSkmbeKjYwny8/uFien94salGwMOgOt6YDbuawEIur6Uh6R4Q2fxjxG
	/yiWd3MkXK9rezaWNKy3S616Zadteh864mQIihmvMbMIlGmttxrPfAj/R5aLjGP2a8J6ZSWVrT8
	3YKXO8Ftp0WkXDUQd2KUIU/cJ/EXF+vqTOfjaMM+xMZl9Edx/qYSl0wngM5/+Sf//yK+dTAlGOr
	nxh3Oxge8UAjME1e/i26859HEbMPBq7i96+1sTiMzsjGCCkGcUueJ9mEgntUue6fgE5KKSzXqgX
	YQLYTz43tIDH05C0Q==
X-Received: by 2002:a17:907:3e9c:b0:b87:1839:2600 with SMTP id a640c23a62f3a-b93765109f5mr93414566b.33.1772176511023;
        Thu, 26 Feb 2026 23:15:11 -0800 (PST)
Received: from puffmais2.c.googlers.com (244.175.141.34.bc.googleusercontent.com. [34.141.175.244])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b935aeee867sm124205066b.66.2026.02.26.23.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 23:15:10 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Fri, 27 Feb 2026 07:15:08 +0000
Subject: [PATCH v2 03/11] dt-bindings: power: supply: max17042: drop
 formatting specifier |
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260227-max77759-fg-v2-3-e50be5f191f0@linaro.org>
References: <20260227-max77759-fg-v2-0-e50be5f191f0@linaro.org>
In-Reply-To: <20260227-max77759-fg-v2-0-e50be5f191f0@linaro.org>
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
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43283-lists,linux-pm=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:mid,linaro.org:dkim,linaro.org:email,microchip.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5749C1B3B3F
X-Rspamd-Action: no action

| denotes a literal (preformatted) block and is not necessary here.

Drop them from this file.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
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
2.53.0.473.g4a7958ca14-goog


