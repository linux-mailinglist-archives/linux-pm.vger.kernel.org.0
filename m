Return-Path: <linux-pm+bounces-20214-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA33DA090FF
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 13:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 057EC3AC111
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 12:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DAFE212F8A;
	Fri, 10 Jan 2025 12:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qd0qGUHo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27A1212B2E;
	Fri, 10 Jan 2025 12:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736512796; cv=none; b=IxJXqmrFmgxCoOSfsk+sJ5P+ffXJlg71o75/0x7MTjnGr5rxUmJFlbiATRfjsTumjWaDO2U0ksb64Ms/CB+W2lrkD+J0pSrfMUTNutNzYOA4HyZXYdH4StYnHQOZjZrV4PpsJoVpgUaDfgLHMjf7Fy4wQdyu2Bc0h2NvKIjxKc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736512796; c=relaxed/simple;
	bh=crbDy9TcYlFgxkktOCBvsCJ28c9NCNTFHJyn/05eIYs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GRqrK2H9VlreSifaqSw1iysImaqcQqwv8uHCBHcRqUcNs3hd5l+bKfd6l8/Kqzo4ybm38Ep6W/gq8DKYwD7UmmX+/OqZQiJ0NdS/+LLKVM7+Vzrq1QPaVstO9SBzYEK21b/+S0e77Tgep34yM9KIvU+yQeV2IlJTS1vtws78zk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qd0qGUHo; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43635796b48so13065355e9.0;
        Fri, 10 Jan 2025 04:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736512793; x=1737117593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iZ8T9tfgTsZH3qi3WJce9KzBqzpoMJY1MEAfLWSlohI=;
        b=Qd0qGUHoje7cRBN5slvHbTRNgTwSQvEoVmil60WLWcDNnAlhxleMC/cu6Yz/1rWYK+
         HbjwhXyidbcb2TTKsEF5rAEkQ1QVqb6aDLBxqHwbqL7MGVx89dNgvxk6uOnomtseI2Va
         2MDuMNClQBcXJtczvJLo6NINg+JwEhtq8K0NQS/nQa7x2wnCUgtlaOt7sdjQjs0YvIGo
         xGXObQAo0feTBZ+kGnMduqpAmTpFRNk6yTyzQXxptK/0jpBQSO7YYRarY39R5NvQXTzc
         e7HjZWK2rZmGRGV7jzp1aEXqx+88lBECWk3w30TcWaet3inzWLhMrFOZ1s4QmiOlTFMp
         koug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736512793; x=1737117593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iZ8T9tfgTsZH3qi3WJce9KzBqzpoMJY1MEAfLWSlohI=;
        b=v8MiJZHsSCCWx7sJmYIMANYp1maSOkPRsvI3xmSTalYnQIeVvQdzYa8yG8qr9rkZXB
         Xur27AUTNbsJlBjclfo24ejs1c/Crh/I26HieyVVY9tq5DPW6g2/SjxnQzP/ZPq1Q7Oj
         pDDWn2zRsO2D/0CS20gm1Avj6qnU6VyMT8hxuq5WL2qv0/BMnKvWcO09fSbRtFmx+dNt
         f3grUAxwIVyt7rYQaW/iIyk7ti6OoSAtiKkbkKX54pm6tIQ87zI1sfltGwIxlRsoI0qp
         M3zGKxTKaB3ytdqn4naxQzfS2ZtXJ0HCPwpRU+4FFYPb3yViQftpcb20uwWm909rm8ot
         EyCg==
X-Forwarded-Encrypted: i=1; AJvYcCVGO8H6r3g1DS2JWQfnpd6zdnMxJhscyrf+ENJeH+TobWQkyOBXRBV/mqwjLnL1eCuX4XIcjlntLauD7w==@vger.kernel.org, AJvYcCVowBa2lXfb4VwRXQ3zMhMubtFTlQYzu7nheXjg/GUPlBgpC4DV0irLeDDkX2RWkJMmXH+AeFblVrCRDDUS@vger.kernel.org, AJvYcCW6M8K7KtjrtvyAQdtCslQxRRUbir2CWsP7OBZl+wdxWl5KfUmrWo5u94H98dMXuBx7L8165z443t17@vger.kernel.org, AJvYcCXVYa75DlDX5Ej/7l7LYsR4RJ0QxAkZpksONsMEeNzzie9tacx2DaP6BdidZVOWoaYMxOzdoT7RZYg=@vger.kernel.org, AJvYcCXo8Xame1pakIvOHscV6sMjlegOq5OY739MEOe2g4PcH8Sf+aaU5tdf1R7Sx30SlGD5CqxGsc8I1a70@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbwa4TcXsBq66ssfqKXKj/OlHSsBH21gY8mTaA66oG4Q7FnFaj
	Axjh9GbPCjMKhbCu2f1nPrw7N/5H8CzdNkYH61ShkwepehAOqCjd
X-Gm-Gg: ASbGncubESJ8P0lN7Iaxq5ZO9ZIBZHjg0z1Wjcwov+bzK6RMA0Pr6Ba6IiVB+erp1V2
	yiSpZUTCmR6X5FqsRAihlFbo7luq+EffyRGrfxmpp7tOrPUlysI6cLzbCHwSS4GzsClPfQa6EU/
	YYG8AG2Pp5TxiltR+kEVewBabvK3sohxgWhg4HCoC5PPLOWG9nI28+5MPk6BWLgNcaySznC9vxl
	cupN3X5W0Aor4RqUoRkYV/xe8dRyR+QUnQvO/kbpWQwarPciMxcZcDu3EpGjgK+6D2MsnHqXuWy
	rynOeVmlzOo=
X-Google-Smtp-Source: AGHT+IFy0YLTGe8F+nl8LnieqDiyiyRbcR5k0ayFI05mSwXqdMMGbUO+5rrLK2qTd/ypLoKxWRGH+Q==
X-Received: by 2002:a05:600c:5028:b0:434:fa73:a906 with SMTP id 5b1f17b1804b1-436e9d6fe9emr53361615e9.4.1736512792992;
        Fri, 10 Jan 2025 04:39:52 -0800 (PST)
Received: from localhost.localdomain (185.174.17.62.zt.hu. [185.174.17.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2da6401sm86738715e9.2.2025.01.10.04.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 04:39:52 -0800 (PST)
From: Andras Szemzo <szemzo.andras@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Maxime Ripard <mripard@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH 10/12] dt-bindings: phy: allwinner: add v853 usb phy
Date: Fri, 10 Jan 2025 13:39:21 +0100
Message-Id: <20250110123923.270626-11-szemzo.andras@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250110123923.270626-1-szemzo.andras@gmail.com>
References: <20250110123923.270626-1-szemzo.andras@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document Allwinner v853 USB phy.

Signed-off-by: Andras Szemzo <szemzo.andras@gmail.com>
---
 .../phy/allwinner,sun8i-v853-usb-phy.yaml     | 89 +++++++++++++++++++
 1 file changed, 89 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/allwinner,sun8i-v853-usb-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/allwinner,sun8i-v853-usb-phy.yaml b/Documentation/devicetree/bindings/phy/allwinner,sun8i-v853-usb-phy.yaml
new file mode 100644
index 000000000000..773c3f476db8
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/allwinner,sun8i-v853-usb-phy.yaml
@@ -0,0 +1,89 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/allwinner,sun8i-v853-usb-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Allwinner V853 USB PHY
+
+maintainers:
+  - Chen-Yu Tsai <wens@csie.org>
+  - Maxime Ripard <mripard@kernel.org>
+
+properties:
+  "#phy-cells":
+    const: 1
+
+  compatible:
+    const:
+	- allwinner,sun8i-v853-usb-phy
+
+  reg:
+    items:
+      - description: PHY Control registers
+      - description: PHY PMU0 registers
+
+  reg-names:
+    items:
+      - const: phy_ctrl
+      - const: pmu0
+
+  clocks:
+    maxItems: 1
+    description: USB OHCI PHY bus clock
+
+  clock-names:
+    const: usb0_phy
+
+  resets:
+    maxItems: 1
+    description: USB OHCI reset
+
+  reset-names:
+    const: usb0_reset
+
+  usb0_id_det-gpios:
+    maxItems: 1
+    description: GPIO to the USB OTG ID pin
+
+  usb0_vbus_det-gpios:
+    maxItems: 1
+    description: GPIO to the USB OTG VBUS detect pin
+
+  usb0_vbus_power-supply:
+    description: Power supply to detect the USB OTG VBUS
+
+  usb0_vbus-supply:
+    description: Regulator controlling USB OTG VBUS
+
+required:
+  - "#phy-cells"
+  - compatible
+  - clocks
+  - clock-names
+  - reg
+  - reg-names
+  - resets
+  - reset-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/clock/sun8i-v853-ccu.h>
+    #include <dt-bindings/reset/sun8i-v853-ccu.h>
+
+    usbphy: phy@4100400 {
+        #phy-cells = <1>;
+        compatible = "allwinner,sun8i-v853-usb-phy";
+        reg = <0x4100400 0x100>,
+              <0x4101800 0x100>;
+        reg-names = "phy_ctrl",
+                    "pmu0";
+        clocks = <&ccu CLK_USB_OHCI>;
+        clock-names = "usb0_phy";
+        resets = <&ccu RST_USB_PHY>;
+        reset-names = "usb0_reset";
+        usb0_id_det-gpios = <&pio 5 6 GPIO_ACTIVE_HIGH>;
+    };
-- 
2.39.5


