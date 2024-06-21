Return-Path: <linux-pm+bounces-9756-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C91191261F
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 14:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD5601C258E4
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 12:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA05154BFE;
	Fri, 21 Jun 2024 12:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M4CG7Atv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E74152E0A;
	Fri, 21 Jun 2024 12:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718974674; cv=none; b=ixa04SWDsFTmtcEtHQ3ZRmVcuWOMTqmSaVborFujV3yFTP3+VDlpt6lNTngN8IL9qHfEJ4zCGOhjNNc+zDfAUvmXbbj0gjnVspD49V9l6mVqT+A66ZhW5gUKhLGAfHOknJ6OwX++qfg1ExXJ9foakbYYHYd5FrSTa8jfcrDKNNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718974674; c=relaxed/simple;
	bh=7y2gis8NbFMigGag4TJQW2xENiLAF81rhNNPK51Yw8M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ggI+4KSRJYQio0udD+mqC4t6YTcHmoWHvUBdQ8oIMQbRlWQzh9d3/eTXzpYc4KRtVIwYIN4OR5Il6EnOxF2TkFuYASEL8k6EN6sjoXoL24iAPck5BLVFUhSP+MwcirXxsA+F7hvykEpwZB+7SQgKkvcTI7IaQzX36W/5NyjqSSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M4CG7Atv; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a6f13dddf7eso246722666b.0;
        Fri, 21 Jun 2024 05:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718974671; x=1719579471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j9TZfUi3/Xsz1Ab9mlAU0VCjTlqiJeuJUUECFkI88cM=;
        b=M4CG7Atvyg/7hHfgk85odsHqYhUBeEjM+YBIEW+cgOL6tPghcwgrXerK61LlQBC8pN
         ez42+q2npMWvjX+FgLQN00IIxEIUpKG5WuBTSjNebFZcNDcscQylIGIOR5A5d7nsfZ1i
         +FPaekVcErZ/+mCgubqji6n7ewx6iPHzom3lsh03fRvNDSvwT5imDbYWFjO9XM/0pgTD
         K626NdV7ZTWeSAvV6SX8XZvAr86/hFsPIMmXe5H8Gegs0BOo30f0okZNlpdSBR8hFF2s
         VdQ6faHdfhhFqz11CeDhYFsFSwVQKSTeLd0YsufHnWMaU5IRnVqslCkPsKSDxk21DW7O
         H0AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718974671; x=1719579471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j9TZfUi3/Xsz1Ab9mlAU0VCjTlqiJeuJUUECFkI88cM=;
        b=axzjHbGZahJqmeVuCJRFivFg1IKFAXa/G9l+GExdLQ08GIFIVtlxVHnl9HOr7W1Fwi
         G5ZuTVpmXiEkgBmZmb5o+lqgyOhHviQ+CbIHcNfjkskxFSGzRJ8PF2wK1geTufY/8X56
         zn+EUUniyBTN5KgoJCEchjPmA5ySYyiUnIXXOW8+i26Q2d8qF9i7rgEsD5QQfSiLJI/g
         4KRIdE7yRrx0ymRj/xwfRLID/QD7oCZK7yIJ6JlWUhdgHDRrlaIjQFLVOwC8nVmUSbwt
         qgZZ5QlzYoBo2gLuD8zznS5/KYo1z7jSaThGiIN+siO/MzY+8SM2b1XElrg57/vlMjbY
         qRyw==
X-Forwarded-Encrypted: i=1; AJvYcCW4v6i9P7TS2jUBW0H+Fc4rVE5rED4d7W+YeJAK1XEHnYa8wV6+XyQgOZIs5qJLmziYX6h1qWPanVrMK+BsK+3YGUawpHMUe5kqLC386MZ1Bls4x6HkoR+uJsn6AiJEkbx5zAKZoD0ESGwP9CydPMpdAM0e7J5T2/uR77KQHZzqwJ06
X-Gm-Message-State: AOJu0YzwL5WSaBX4wFNE1n8wCWE4uvaBy6T035ykvDZvU6Zvmdv7H3GF
	qTqblEtUpfh9/xlRB0DT77VzfrYqrFc0gaKiCd6iK3uzIoB+MQDR4A4Zww==
X-Google-Smtp-Source: AGHT+IGyso/Aiq9WgvdVhu22V3UG19VODOc42g1ZSrrJGC2/iL9b1/z3uft8gAVqMs/OPOZOQ3qFpQ==
X-Received: by 2002:a17:907:d383:b0:a6e:fad9:6dbb with SMTP id a640c23a62f3a-a6fab058a39mr633365066b.0.1718974670760;
        Fri, 21 Jun 2024 05:57:50 -0700 (PDT)
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fcf548eafsm81226266b.116.2024.06.21.05.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 05:57:50 -0700 (PDT)
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
Subject: [PATCH v5 1/2] dt-bindings: power: supply: add support for MAX17201/MAX17205 fuel gauge
Date: Fri, 21 Jun 2024 14:57:43 +0200
Message-Id: <20240621125744.363564-2-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240621125744.363564-1-dima.fedrau@gmail.com>
References: <20240621125744.363564-1-dima.fedrau@gmail.com>
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
 .../bindings/power/supply/maxim,max1720x.yaml | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/maxim,max1720x.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max1720x.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max1720x.yaml
new file mode 100644
index 000000000000..dc3e0e7cb2ce
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/maxim,max1720x.yaml
@@ -0,0 +1,58 @@
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
+    oneOf:
+      - const: maxim,max17201
+      - items:
+          - enum:
+              - maxim,max17205
+          - const: maxim,max17201
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
+unevaluatedProperties: false
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


