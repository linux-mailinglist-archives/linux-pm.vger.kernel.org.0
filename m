Return-Path: <linux-pm+bounces-42986-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBQTKFT0m2nk+AMAu9opvQ
	(envelope-from <linux-pm+bounces-42986-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 07:31:48 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5151721EC
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 07:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6C4403023E2C
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 06:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A08C347FD3;
	Mon, 23 Feb 2026 06:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="exVVAmtN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f65.google.com (mail-lf1-f65.google.com [209.85.167.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5AD3451CE
	for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 06:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771828292; cv=none; b=googdaep5TC0Mdhj54ZdrPjZLgvup8eM+jQTLSlCbTloS6kZl3Dz671POp4OEnJVYnO7mKItE7SIwP6dfxYqmUM5BX5qAZ/FR5jfl/UCGcbkq4cYgIIfBgcg2fNkKbifz/HU7ANu61hK8Itn06e5WjNHx8Zeo67myc1sXVLQGSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771828292; c=relaxed/simple;
	bh=fvsNiW04qW3AIrTi8INmyEkzbGKGRZylVzn1kRv9504=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i8p31s3M6ZQshtoJ0LqUqodMkO0nXS0TepCtKm024nNQTCWjWPXccTuyb56gxeXfmYLxunmdqbyizujudNj2h2jB9ycE/wt/7ozxtDOfE8fLnIBth2hlqcXVGNZU8aD2BC91bMvYFJBP9tOgt5BIBwhITvzvHYaczl7xF9s1z8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=exVVAmtN; arc=none smtp.client-ip=209.85.167.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f65.google.com with SMTP id 2adb3069b0e04-59de66fda55so4406308e87.3
        for <linux-pm@vger.kernel.org>; Sun, 22 Feb 2026 22:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771828289; x=1772433089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=baZZ3I83Z7duoBmCyUC4MTXvnHqhUiDCw7gdIgcx7ZU=;
        b=exVVAmtN0qT61Z99T6Ogq1td5k9DMeVl3n24HmPpDe5lOXpofT2UNhmDTzmrg6mQA4
         SsX2Y9ld/dUxZbFoloLiDCh0kaChVRmLdMOyuew5wyr+EYpHfd7RhYmGCkojaaabys8h
         lf1FYGkzUjRjJ4Q7/wilO0toR7DKARkJGD5p6yyzTX64GIQeDuIGKQySFD1gebcnkljq
         LO0SGDv+gBmUJdCzpMFOq3wS7Y6TIqY+fCPQJLCKNZ04HINENuoz1f2X/MGZzAdPqbAh
         MmYMbC7hr+IpgpAOZMWyH6NPD21MMvNg+uUpx3saGtPCxSWqgOyIEMALZvmSBrAFehZf
         qy8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771828289; x=1772433089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=baZZ3I83Z7duoBmCyUC4MTXvnHqhUiDCw7gdIgcx7ZU=;
        b=niYVC/+ttJs6NMoYcKRdh6qzmA7mFwBNsNIrU42kZiYfqc7qAb2lSw2CVl7qzjKUvn
         8g3BMox6W7I/dzyPcObUh+bl0fc2gUW9qPqv1QHw6HEHF83TEUTe85SlGwaWliYCVqMa
         VpzYcVInkmLz2GAyIEXfABd66dzqhwIaMf3momUxUhfkrXlrNk5JpAN/bovR8yy8LjPJ
         zOI9V5PYZ6frQSTHCVCBAp72EVum7JkBFpImsTQTOXSnl9cw9S4gRPMJROQhbOSNQuwW
         XM3KDJpLmajTxrkXGK7lmo2l8u1OukViMhxoHhEaWdpASsR2RljrKxRjWPU0hi/v7RnE
         gltw==
X-Forwarded-Encrypted: i=1; AJvYcCVuxay+TUdF8+91oQGZ7t0EQ7Sk7DLY76MuVsKAZX6kOyiush6Dp/cs1aFVoCvEnbkSDN99RRLabA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb/m1lRQQ/Oeqld4M8Dj55HzLKn6wWA0cb/GE2HEKLUqCTbsNy
	Qm8wUhNnth7U1admYK+lXOGkyTMi4E27VxVQAWyP+PQOt1W45+4ZjmZhq6VUEGVU
X-Gm-Gg: AZuq6aIIG6Woj8LXI4f3OjTGBsB59C16Zhjv6S3Usk5VutZJyM8FODjNlEJFqwhZIS7
	3WhL+yCjKO+CXekN9rt2g3DyuKj0a+kZEJrbrILQXwxg8HLcl6/rFNrRsjfo1Wpnnh+923RkcXU
	PrX6c0HeDp6WOmiqMjQeQ6321H0QckzFCO5yFzzvE2xgok3NpJBSyjWtnokyLBdOATcUu0pOAcN
	yegSzyiePu6VSRnT0iwrmkPQPaW+tp8LoWOIjYgxvQMmI1QPUhGSHa/f3tWP5Zrbbk9i1NJgfIr
	6sZd+lEMwIf1DmIw9yFRuwMBQSJLeV91sNrKjaK74qU/jLeoqsEEs1GA/VIEq2bTGwGftSnBXsM
	fAYvJ+AlVH/ozb4evm2qWPcTay3dQmiA9yYcakaJRuUvpeDC4oZT+9DfMFsEHQ/mZdZWmZtpZ6M
	uzZy7zjdLf0jFx
X-Received: by 2002:a05:6512:4007:b0:59b:6f3a:9c80 with SMTP id 2adb3069b0e04-5a0ed8a5136mr2397079e87.23.1771828289037;
        Sun, 22 Feb 2026 22:31:29 -0800 (PST)
Received: from xeon ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a0eeb14596sm1361320e87.26.2026.02.22.22.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 22:31:28 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Ion Agorria <ion@agorria.com>,
	=?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v4 1/7] dt-bindings: embedded-controller: document ASUS Transformer EC
Date: Mon, 23 Feb 2026 08:30:53 +0200
Message-ID: <20260223063059.11322-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260223063059.11322-1-clamor95@gmail.com>
References: <20260223063059.11322-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-42986-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,agorria.com,rere.qmqm.pl];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clamor95@gmail.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,0.0.0.19:email,devicetree.org:url]
X-Rspamd-Queue-Id: 1A5151721EC
X-Rspamd-Action: no action

Document embedded controller used in ASUS Transformer device series.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../asus,tf201-ec-pad.yaml                    | 105 ++++++++++++++++++
 1 file changed, 105 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/embedded-controller/asus,tf201-ec-pad.yaml

diff --git a/Documentation/devicetree/bindings/embedded-controller/asus,tf201-ec-pad.yaml b/Documentation/devicetree/bindings/embedded-controller/asus,tf201-ec-pad.yaml
new file mode 100644
index 000000000000..6a61c88f9046
--- /dev/null
+++ b/Documentation/devicetree/bindings/embedded-controller/asus,tf201-ec-pad.yaml
@@ -0,0 +1,105 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/embedded-controller/asus,tf201-ec-pad.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ASUS Transformer's Embedded Controller
+
+description:
+  Several Nuvoton based Embedded Controllers attached to an I2C bus,
+  running a custom ASUS firmware, specific to the ASUS Transformer
+  device series.
+
+maintainers:
+  - Svyatoslav Ryhel <clamor95@gmail.com>
+
+allOf:
+  - $ref: /schemas/power/supply/power-supply.yaml
+
+properties:
+  compatible:
+    description:
+      The 'pad' suffix is used for the controller within the tablet, while
+      the 'dock' suffix refers to the controller in the mobile dock keyboard.
+    oneOf:
+      - enum:
+          - asus,sl101-ec-dock
+          - asus,tf101-ec-dock
+          - asus,tf201-ec-pad
+          - asus,tf600t-ec-pad
+
+      - items:
+          - enum:
+              - asus,tf101g-ec-dock
+              - asus,tf201-ec-dock
+              - asus,tf300t-ec-dock
+              - asus,tf300tg-ec-dock
+              - asus,tf300tl-ec-dock
+              - asus,tf700t-ec-dock
+          - const: asus,tf101-ec-dock
+
+      - items:
+          - enum:
+              - asus,tf300t-ec-pad
+              - asus,tf300tg-ec-pad
+              - asus,tf300tl-ec-pad
+              - asus,tf700t-ec-pad
+          - const: asus,tf201-ec-pad
+
+      - items:
+          - enum:
+              - asus,p1801-t-ec-pad
+              - asus,tf701t-ec-pad
+          - const: asus,tf600t-ec-pad
+
+  reg:
+    description:
+      The ASUS Transformer EC has a main I2C address and an associated
+      DockRAM device, which provides power-related functions for the
+      embedded controller. Both addresses are required for operation.
+    minItems: 2
+
+  reg-names:
+    items:
+      - const: ec
+      - const: dockram
+
+  interrupts:
+    maxItems: 1
+
+  request-gpios:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+  - request-gpios
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      embedded-controller@19 {
+        compatible = "asus,tf201-ec-dock", "asus,tf101-ec-dock";
+        reg = <0x19>, <0x1b>;
+        reg-names = "ec", "dockram";
+
+        interrupt-parent = <&gpio>;
+        interrupts = <151 IRQ_TYPE_LEVEL_LOW>;
+
+        request-gpios = <&gpio 134 GPIO_ACTIVE_LOW>;
+
+        monitored-battery = <&dock_battery>;
+      };
+    };
+...
-- 
2.51.0


