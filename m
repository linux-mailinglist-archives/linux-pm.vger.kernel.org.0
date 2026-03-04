Return-Path: <linux-pm+bounces-43613-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPGwEviBqGmYvAAAu9opvQ
	(envelope-from <linux-pm+bounces-43613-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 20:03:20 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C8510206CB4
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 20:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EDBDE303EFFF
	for <lists+linux-pm@lfdr.de>; Wed,  4 Mar 2026 18:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3413DA5BD;
	Wed,  4 Mar 2026 18:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSoWYr20"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DF13D75B9
	for <linux-pm@vger.kernel.org>; Wed,  4 Mar 2026 18:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772650687; cv=none; b=hoFxkTVouKjCM2u9h0NIiDbIozNplD6+/EaDTX9dBAysq0QSc0WxKq850zUiWIlJ7YDl6xeRK+hVCLYZlpDJmPw2YBc9qMccVNZaUWwqeQHGkNFvav2hvKpw+EQEpakqaIwS7ubkkYGUqu1jn/eJBoU7oxRx9Znw+v9HjB8tkcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772650687; c=relaxed/simple;
	bh=Um/z68zG3N61niZpCEIqJtffZwPNsXI2dku/W5e1n1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KBpCD75fXcf+Hb9kYcYo+BnZt369YAMSlqZMiGB2ZP80yJlGyQT2Lv6eYYm5Z0rtENLLo/YfPpsC5BEgnmwHRtgHaSYxhMkXHRG10MXaz5aCpOzp+H0NbQhou/aj0D2/d1FPKdDpUo0ikinLXTmrIs2ScN4kFcR+S/C3I+DEdKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BSoWYr20; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-38a26b4d830so34326311fa.2
        for <linux-pm@vger.kernel.org>; Wed, 04 Mar 2026 10:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772650684; x=1773255484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+X0ubJBSyO/B3iU+P8TQmYBYVQdgv6gVa1x95cmnAWM=;
        b=BSoWYr20bcI3o3JCa9seNp57s083V2y+QhavjlJ3GtJNXMtupOBHmoSXXKFOxT35IB
         fpyDzpUq+Dw9a8juhD86IzkpVG+dVVD6AgCzBs0ClWxJqdzSpnLTcPetrZ+G/NonGKDH
         Y6DGANEVtgOL0NIKIWc14Qq1+3RtWW6IRHzRVHmpq8kv52G8YigIbgdTsqKDAKUxnuSR
         XCTROFJ4hxjEKxEKXavX0RnEZUPUhST7ROb5J9VHsOOY6vayoLe06U5teHkvp46m6yjV
         RywDnGo7q/9BnWOC7k5WiS+0rAMYjCRWXVZ6sHWHTezB1KMwqOifymCuJsVcTNkHxgF6
         s9vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772650684; x=1773255484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+X0ubJBSyO/B3iU+P8TQmYBYVQdgv6gVa1x95cmnAWM=;
        b=TB41zZyd8Fj3Oqm6DaTf9vMT26d9vQwfvU3enV/RLzCtgnDZ0Q9LuIaA8bfoOYN+XC
         wREa/+eYKAQDnF+19C8dWzpmFSW1pr+V0ToiyiAAQ2zxjEohR0PWsgwUmWfJng/olNlV
         kXFPu2SULOfKNkpemh9g3DAYtE9mQv8Ck6hEPRbtAOkxvGTWMMVknuqjWjRSFtjI8KQg
         cYkzyxSf4nAvAYuhuzkDvcB4+2lvjstGWAekOBmElwpzmxz6RKYtKHORqaa+lIO98Zv5
         2s8FW2/Suo2nWLMz7EWexBrjjwHBnp804dffVavuUKsypq/yCRwiDsIxE/Y8VRGrnpXZ
         QrYA==
X-Forwarded-Encrypted: i=1; AJvYcCWsCmfMSy4Gn6VG+ACGu53FWTNRq8vvVD81Fr3YI3lEttFsfgfBrnJSBwYJkasSwYFBzXom+gXT7w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8vYvlN7ujRs7Lm3t2w4NmA8pv6jxAW/z1FBovmPiZ4d46xJE+
	dL3meJ/87AXpUwBd08mfe00DAGh1h/p5VFXDHETEHObdaHd5lAL3qskj
X-Gm-Gg: ATEYQzyFL8ZOAdZGvHmTtvzUrc07IMQo3C7N8VA8YYFnSHh+3wUeS8gu7wtef/6xUl3
	1cC5OCy4IXgkOIwZN9Qwv1r1vPOUEcjAIdWwSU4PM7pEeiimGECE2wb4DnhspzcUDjaGBHMsyUl
	OmaJPafIlHcsPtH/S8VjzZ7ZFxy5cKMJSXlFxaqsff2PQHHhJRtJQpg5ZHlhXHiVhf5itPGX88x
	8YLHWYKKRUK31dUCkaI1lPH46AVOX/p5HjyyGqVugQZ5GbXQxFvjB5ahvI+ql3nKq/bw4Zz3oCm
	/DziIBTo6fwPwrSzdlimfTCQ6SOO/vx+WSdZO+zWVTLUxgRI8hY+yhPwraDm5fH7pGvV7A0a368
	yw3ZSCXMZnS2OdSOQRmxfNVWrxWAcVjesTrRWJHfYq6ZxMP4WYuZiX+CmFQH9rKNxBMmP3as5TA
	DQ04lBMm1E8ar0
X-Received: by 2002:a2e:9e11:0:b0:386:1ce2:1192 with SMTP id 38308e7fff4ca-38a2c5b25cemr17005641fa.20.1772650683643;
        Wed, 04 Mar 2026 10:58:03 -0800 (PST)
Received: from xeon ([188.163.112.72])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a12a6ddd3bsm704985e87.0.2026.03.04.10.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 10:58:03 -0800 (PST)
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
Subject: [PATCH v5 1/7] dt-bindings: embedded-controller: document ASUS Transformer EC
Date: Wed,  4 Mar 2026 20:57:45 +0200
Message-ID: <20260304185751.83494-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260304185751.83494-1-clamor95@gmail.com>
References: <20260304185751.83494-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C8510206CB4
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
	TAGGED_FROM(0.00)[bounces-43613-lists,linux-pm=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[devicetree.org:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,0.0.0.19:email]
X-Rspamd-Action: no action

Document embedded controller used in ASUS Transformer device series.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../asus,tf201-ec-pad.yaml                    | 119 ++++++++++++++++++
 1 file changed, 119 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/embedded-controller/asus,tf201-ec-pad.yaml

diff --git a/Documentation/devicetree/bindings/embedded-controller/asus,tf201-ec-pad.yaml b/Documentation/devicetree/bindings/embedded-controller/asus,tf201-ec-pad.yaml
new file mode 100644
index 000000000000..60b6375864aa
--- /dev/null
+++ b/Documentation/devicetree/bindings/embedded-controller/asus,tf201-ec-pad.yaml
@@ -0,0 +1,119 @@
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
+          - asus,tf600t-ec-dock
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
+              - asus,tf701t-ec-dock
+          - const: asus,tf600t-ec-dock
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
+
+allOf:
+  - $ref: /schemas/power/supply/power-supply.yaml
+  - if:
+      properties:
+        compatible:
+          not:
+            contains:
+              const: asus,tf600t-ec-dock
+    then:
+      required:
+        - interrupts
+        - request-gpios
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


