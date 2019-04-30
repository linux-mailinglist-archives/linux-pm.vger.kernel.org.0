Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04CCCF0AF
	for <lists+linux-pm@lfdr.de>; Tue, 30 Apr 2019 08:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfD3GqT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Apr 2019 02:46:19 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37415 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbfD3GqT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Apr 2019 02:46:19 -0400
Received: by mail-pl1-f194.google.com with SMTP id z8so6287440pln.4;
        Mon, 29 Apr 2019 23:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fjs/QlJccPdiIzSXEBVK27qZZaOYBQoAnxJi1UWQC3c=;
        b=Pa2jzaEEN+Bapthi2w1tlr699nA1as/teMTVtxXU19Gp41NZgTC+ZPicF6OjpQNEws
         SJF4k+/6p8THylT3a+Gn5Plq9uzDjvxHFVGJmDCENK+TG3+0TEg/v7qmRiAy+WoRs7tT
         nqbKY9rArwX9iwiv41zP+T2FZv2lBNnmwUY63WF39LgeH6Iem9KpEKj3I0pG3DZH6lI8
         yGL6rKQzjpDzPAaCCPEIqya5ywTXtP2KwWRzoxZvFOHxBJPcUyInQ+h2kPhzVuUuEMCN
         Wl8ydpDDukpj98Qh3xPLiJLm+oqvsvfimnm7rXYD2+plolOGqD0kmMNeSquLUyWlNZTv
         wcxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fjs/QlJccPdiIzSXEBVK27qZZaOYBQoAnxJi1UWQC3c=;
        b=k+fJx4cYpavOge1oOExB/qNnZcPYt1+foekuOmShJVD9Ti9moGzli4YJ6KQhP0GOF9
         mo6sI8JlVbAX8lACqby6Ri0nvK0wooIGasta7bZozeJLdhwVzp9DxYOmR0huG70vv/J+
         dly5OmMAIy+coMAcDC2VzZP6rqif5rUVSgqo3kzezz9Wsm4JtPAG/ffDArCc9k8sLhFC
         wVL7m1avFWwvZ47XPGkhVofSOCZfBbUyHO47MYLLYvzQvrw3CLujc9EUUCNqMVsoOs15
         T7uBPsifXkXXpoUhbA6ik9WfDoaqlJqqPYQfR2s7F6YFLF68IXqT+R4gu6exIDsz+P2f
         RDMA==
X-Gm-Message-State: APjAAAW4fq/8KHvZh7HvQdPKWy1xfs6ZgIoy1MX1XAM3K8Lew825N7gd
        u06okQ1fmIi12aCdgvG+3U7ayepzXEo=
X-Google-Smtp-Source: APXvYqx9NdgAT7vJ+A6VAcnGARG8Y/LxF90+Qrdv9Cb+womMd0QpIFbTyYw8+iOGP2GTo4rNz6DuRQ==
X-Received: by 2002:a17:902:7590:: with SMTP id j16mr5736546pll.296.1556606778138;
        Mon, 29 Apr 2019 23:46:18 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id a9sm47336010pfo.17.2019.04.29.23.46.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 23:46:16 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Enric Balletbo Serra <enric.balletbo@collabora.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/3] dt-bindings: power: supply: Add bindings for Microchip UCS1002
Date:   Mon, 29 Apr 2019 23:45:57 -0700
Message-Id: <20190430064557.28469-4-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190430064557.28469-1-andrew.smirnov@gmail.com>
References: <20190430064557.28469-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add bindings for Microchip UCS1002 Programmable USB Port Power
Controller with Charger Emulation.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Enric Balletbo Serra <enric.balletbo@collabora.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: Sebastian Reichel <sre@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
---
 .../power/supply/microchip,ucs1002.txt        | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/microchip,ucs1002.txt

diff --git a/Documentation/devicetree/bindings/power/supply/microchip,ucs1002.txt b/Documentation/devicetree/bindings/power/supply/microchip,ucs1002.txt
new file mode 100644
index 000000000000..021fd7aba75e
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/microchip,ucs1002.txt
@@ -0,0 +1,27 @@
+Microchip UCS1002 USB Port Power Controller
+
+Required properties:
+- compatible		: Should be "microchip,ucs1002";
+- reg			: I2C slave address
+
+Optional properties:
+- interrupts-extended	: A list of interrupts lines present (could be either
+			  corresponding to A_DET# pin, ALERT# pin, or both)
+- interrupt-names	: A list of interrupt names. Should contain (if
+			  present):
+			  - "a_det" for line connected to A_DET# pin
+			  - "alert" for line connected to ALERT# pin
+			  Both are expected to be IRQ_TYPE_EDGE_BOTH
+Example:
+
+&i2c3 {
+	charger@32 {
+		compatible = "microchip,ucs1002";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_ucs1002_pins>;
+		reg = <0x32>;
+		interrupts-extended = <&gpio5 2 IRQ_TYPE_EDGE_BOTH>,
+				      <&gpio3 21 IRQ_TYPE_EDGE_BOTH>;
+		interrupt-names = "a_det", "alert";
+	};
+};
-- 
2.20.1

