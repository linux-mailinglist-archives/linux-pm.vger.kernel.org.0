Return-Path: <linux-pm+bounces-9381-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01CDD90B9FD
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 20:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95C972823DA
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 18:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B660198A33;
	Mon, 17 Jun 2024 18:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mgP2OO5W"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC5416FF50;
	Mon, 17 Jun 2024 18:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718649961; cv=none; b=kU6wUPhhcJ2KSypCSr5xKtLDX/9J1se9/S/zD+V5yj8dLl9z8T5hVh0i7TneOmjLu58AroRQrHdn3nStvqlTxqN4AGEGCN+C3LG4sWpZor+WwVGrl6ZLgdhJWDUiVvrkCtJn+AwdRc9NmrrOHF6AhuAvKNRRxdWMNsnAe7vikok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718649961; c=relaxed/simple;
	bh=ViIwbEpDuDeKjR6Uhuw79YaKWjv72bRo83JfpFXNpbk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LQ6Z0fJRa6eg5rhSHoGi3vnCVHiWMS1kQyjQ9J7V770F2uSQYLRQjah5BV7b3o8KytnKK8dhYP11cJrPcZWpl+xlrbC4dprVn4NwyGjpmltR3hcz9DLwnOGiO32a8XY928+5FRviI+OJKKLZqNIMY2yEE2J+a/mB2B2H/vub+1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mgP2OO5W; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3609e730be5so159958f8f.1;
        Mon, 17 Jun 2024 11:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718649958; x=1719254758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U7LGxavlodmRw1dUauljrcGcc+zn8iI3h6YX5bKli6Y=;
        b=mgP2OO5Wlw+oMKvAzylTHPgKhlBEQ4uHM5ZoO/pLI5kAgkrPirP6ybWVF8bakYAq/C
         EMFUXRJ3NvhNm4z6BwVvhstessPDw2JgeE8pt0s3doFQyi6aNdJRhu6g4TjAfM0qO7O1
         XJTPVPaw73RXqY4IWsEPdSPKpE5sVx9ZZurVocnCmbUMRIFf5o4wyxL+SnK3MyQFadck
         KuFs9Z8zfZWdFAg6dwVlse+mFfgjYd0+JNL7di/VkxGO1fu+EpkL6KZmrTztKf5JFazn
         L3EYR9qEbU/N8Kj447fm6DDVrsYZi6CRw5iQCLi+cx0UJYGptitzyUIQEzB/bJ2kNnm4
         7zxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718649958; x=1719254758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U7LGxavlodmRw1dUauljrcGcc+zn8iI3h6YX5bKli6Y=;
        b=gu+w1xcM++as64yDOrDjJ+xEOqYTlgRNpGyznJp5QmwIVryrW8HTHzlxTUrUKPr+rk
         wPMoiM8jY1iSYE6KrdojNbq1nB3s+OnPQIyEdOk1CwcbR0wNaUvfr5JWkGMYBlJzMqK5
         ljWKgs6nH1t6eILZT5p6zgM7TeNA6XmVBPTY5xXBnz0KI6cL+L1+i6dLhA/hGVl1Mdlc
         WEoTLo7Hu6X0cA2QZfKePmxksd8bc2pB7P5gqI/uemoHpEcxCXdmUaNUktper1Uuyoou
         inxRKVCriWsvOi51tsGee8XMtCBQ41rOkFYskFD6g1teBrFmbsXCM8+BD4wijGCYvyK5
         t7vw==
X-Forwarded-Encrypted: i=1; AJvYcCVM2kC6Ka3ciNXVkkq/14k9DodIVrMN2MhJLLiuKSWfd3c/3S9XJUKfb4sA+WtziHGCsHV9U8pKaA4hk/dZfSlFLfSrfnZ3pY8/suE30tYjMF7EE3XEi8EVAHj3o3pfUnikfO2Mw8wOUcJNz8IBdiKoXbQ9L0HQttT1bmHSiEzularQ
X-Gm-Message-State: AOJu0YwwR7pvgRMtaRwfatKCqlQ32KbiVFzH+yUexqkLKJp+9KHlo5po
	tx396kkGlSVZg+AUEEen7L+cTcBAAPPAoX3AkwCYIzQ9odzjNRIr
X-Google-Smtp-Source: AGHT+IFxexkW7sOgXfMrYhcWnVL44fxW2+pIQVsKJcsQKFKlXWN7uDX/Eu4PcnGEt7azqVWbLVNnkQ==
X-Received: by 2002:a05:6000:1043:b0:360:7574:d6bc with SMTP id ffacd0b85a97d-3609ea6154cmr402603f8f.14.1718649957934;
        Mon, 17 Jun 2024 11:45:57 -0700 (PDT)
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360750f249csm12410327f8f.75.2024.06.17.11.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 11:45:57 -0700 (PDT)
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: 
Cc: Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
	Dimitri Fedrau <dima.fedrau@gmail.com>
Subject: [PATCH v4 1/2] dt-bindings: power: supply: add support for MAX17201/MAX17205 fuel gauge
Date: Mon, 17 Jun 2024 20:45:03 +0200
Message-Id: <20240617184504.304211-2-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240617184504.304211-1-dima.fedrau@gmail.com>
References: <20240617184504.304211-1-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding documentation for MAXIMs MAX17201/MAX17205 fuel gauge.

Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
---
 .../bindings/power/supply/maxim,max1720x.yaml | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/maxim,max1720x.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max1720x.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max1720x.yaml
new file mode 100644
index 000000000000..52467af5388a
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/maxim,max1720x.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/maxim,max1720x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim MAX1720x fuel gauge
+
+maintainers:
+  - Dimitri Fedrau <dima.fedrau@gmail.com>
+
+allOf:
+  - $ref: power-supply.yaml#
+
+properties:
+  compatible:
+    enum:
+      - maxim,max17201
+      - maxim,max17205
+
+  reg:
+    items:
+      - description: ModelGauge m5 registers
+      - description: Nonvolatile registers
+
+  reg-names:
+    items:
+      - const: m5
+      - const: nvmem
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - reg-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      fuel-gauge@36 {
+        compatible = "maxim,max17201";
+        reg = <0x36>, <0xb>;
+        reg-names = "m5", "nvmem";
+        interrupt-parent = <&gpio0>;
+        interrupts = <31 IRQ_TYPE_LEVEL_LOW>;
+      };
+    };
-- 
2.39.2


