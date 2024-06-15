Return-Path: <linux-pm+bounces-9234-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B52919099CD
	for <lists+linux-pm@lfdr.de>; Sat, 15 Jun 2024 22:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8811C1C210DA
	for <lists+linux-pm@lfdr.de>; Sat, 15 Jun 2024 20:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF13061FE5;
	Sat, 15 Jun 2024 20:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gUK7lec6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD3161FC7;
	Sat, 15 Jun 2024 20:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718482193; cv=none; b=hRD1MOV68VS4rJbJMe9Nc6jbF/Kid8rr9hdbEhvLvlIH1uVbwUTSnLSagGZ8QJsi5Mlk2iVinYNSrzxZNQSqlENLj9xNFTIZygBrnMl4jdso2Bx4fQJU18Z7zsoqomzTQczXyG0hMmsGJy0ESsyIDMWQKhz7witQt62Zo6DbdoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718482193; c=relaxed/simple;
	bh=+ZCC1LjssyKOXgoyALPO/y5fpHApzr2s/7Sn8j4wp9s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mFqi2+jrWV7a83Oc1nB2HRNODWoJA3kKFWSmIdTpu/SF5FIfoWkIU4VA2gZt9zVcXZkUdj+JeHiJmmpj4sK336Czsl7x+n4tpKDy2JKpBVttCR7/hMkoREaUgFlVjF7qmKFiFUKRxPDyLfF4wAVdwyCGxv+zloJv9HBxiz7G9cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gUK7lec6; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2eaafda3b5cso39664571fa.3;
        Sat, 15 Jun 2024 13:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718482190; x=1719086990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YEsbeDNGK/vB8KJ4o8p9x15wpBpC+5Utf0VzUSNFjJE=;
        b=gUK7lec6jc1itWIv/ciEhBBtNYvUuq+N8V4QrxWD5mErB5AF34rKhr1ZF+s5MdLc1W
         XJ2pipiQRku7g7P3BBsvW5aanBlhBNmxGJqliVm98RGMWUTi5RRiqWdVB+WZD1lfp+R6
         xsDPvVY+2mXUDDdUSixtSXf7DuYxBiU/i2Wox8c68Nk3fEN7PtfkZiqIsZWGqCP+cGCR
         mTVVSYs5f85HJ+mSJJfAj53b2pan2B/qqcKYpfxuNjWMB44M/LZDqAE286/su2PWya5n
         vInz2vlADZhA5Ebo18CJAd6dbcjDE+8MElKERKZisB9eNVU8JZmtVbAzombf3ziSj7ck
         TMFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718482190; x=1719086990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YEsbeDNGK/vB8KJ4o8p9x15wpBpC+5Utf0VzUSNFjJE=;
        b=vbXXMDUC+Rp3vykYJ/s22NZmCR1TVKR7MdL5UTxxWhjpZ3m7e+Ep6PGinkNd07Q9DQ
         1zSYxT1QRC/y0jpBsKn0p6FTjdaF3asQrBUZCbgRPxhjQ6Edire0uIq8sHrzaXy6IkJK
         RM7HrxTbXJSDPVqMleFOB3KiBKzKBMxmtq9J7DDp44kf6TRItp+OA7XKZ2SmQFfgyFbE
         brihzjpND0mj0339P0GSGLEYWxNEsJo4Hj97jyHvUWrsh2AoqIQ2oADtxjswEmof4kNX
         3ivltl3CCEwTiau6mf/KayieEdYiWUjUipWW/bWBGMKtYzqOOukRgv/cd1tRjnlWE4w0
         Awtw==
X-Forwarded-Encrypted: i=1; AJvYcCWPNN6E4pdZheMHov5oaTget/jRFvuJEMAcJbv7lW8vB5mZjwhdyMMc8JxvviM+IozUM3EOZuoQu9SnPfnjo4kaPpZHkl8scw3vy/aj3ciU2ddCymP3RMBp56h7vFNDun/lZQaBHDdZJ+RKHtzOi1n2/UTqokKafiHu4SQ/5ihhEqw8
X-Gm-Message-State: AOJu0YwlVHivSiidU81rTBSkg528Q5lVbd+jflfyZVlZmYxb1h78kskr
	syy6ZkQmxWfnnkXCIa9CFAwxOfqf6qSrTvZfeF2Vz80f+rCoCOKL
X-Google-Smtp-Source: AGHT+IFyduCJ9OWc4CE+0x8Xtm85FI0A4xvZ4Zf9gCMXQkDV74e2PZGm93JXo5dyn+L2kepz3fo6Hg==
X-Received: by 2002:a2e:99c8:0:b0:2ec:1f9f:215a with SMTP id 38308e7fff4ca-2ec1f9f2405mr13768011fa.34.1718482189706;
        Sat, 15 Jun 2024 13:09:49 -0700 (PDT)
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f641a666sm108510915e9.45.2024.06.15.13.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jun 2024 13:09:49 -0700 (PDT)
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: 
Cc: Dimitri Fedrau <dima.fedrau@gmail.com>,
	Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: power: supply: add support for MAX17201/MAX17205 fuel gauge
Date: Sat, 15 Jun 2024 22:09:31 +0200
Message-Id: <20240615200933.162394-2-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240615200933.162394-1-dima.fedrau@gmail.com>
References: <20240615200933.162394-1-dima.fedrau@gmail.com>
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
 .../bindings/power/supply/maxim,max1720x.yaml | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/maxim,max1720x.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max1720x.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max1720x.yaml
new file mode 100644
index 000000000000..4414bc6f214f
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/maxim,max1720x.yaml
@@ -0,0 +1,51 @@
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
+properties:
+  compatible:
+    const: maxim,max1720x
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
+      max17201@36 {
+        compatible = "maxim,max1720x";
+        reg = <0x36>, <0xb>;
+        reg-names = "m5", "nvmem";
+        interrupt-parent = <&gpio0>;
+        interrupts = <31 IRQ_TYPE_LEVEL_LOW>;
+        status = "okay";
+      };
+    };
-- 
2.39.2


