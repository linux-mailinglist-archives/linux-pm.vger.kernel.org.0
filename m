Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31CAD132AE
	for <lists+linux-pm@lfdr.de>; Fri,  3 May 2019 19:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbfECRBT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 May 2019 13:01:19 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45518 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727173AbfECRBS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 May 2019 13:01:18 -0400
Received: by mail-io1-f68.google.com with SMTP id b3so60849iob.12;
        Fri, 03 May 2019 10:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=izUOytrD/6vCLXtnYXrSOEU0tJ3aaxN2wrj4VtrzroE=;
        b=Q+EROpgHt2pkaaJDcfZW92rZgLkKosuKl1kSjcKZtjYk7lESQhpz/EQzKNPC/Sx0hd
         TFoiX95eQhUof0vZe9VjCygm6JyBxBdu8Ox3aeT65/YcQikO0I85ad8cKKwMzjafNjGQ
         kvFx7Oi062cPWGSfeNJTVL6tNFbWN8aqqW85BTKurCQ6B3zQA/q4ZzRv/HpqzmqHTuTW
         vr/X8GUBtGJdZU/6bD3waed0WbjB2TPgPOgk5nzCIw6F11S3Cdaedx5hUlcGleb3k7wm
         9G3MTfAH3GUnZNenmSBLF11e9rES0Vm0ScW9JiNVsD+wf5UuX4o1qnCfItvUmq6qMSKm
         HYbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=izUOytrD/6vCLXtnYXrSOEU0tJ3aaxN2wrj4VtrzroE=;
        b=P6Sxtv04s15/NGfrzmNjqdZO/yFZFHj9V9V9HoYpUYAJno8lmUJtoKWOVJu8GffcXk
         CZtz2f5f01C+CwoQ9oZoAf6GzExDMtuK1xSQ4YfbjokWPVd7yQSkWVO5iyS++KqVekYJ
         SS5J4ntX6d0J98MnZ1eqJuCBcVYRhUBEClR1l0ApOtGbXWBZPYNBbTkejS/DwV+xp7qn
         sl0CXRkaqZZ/yP47aF9BIRsDHF7Q9iQz00ZE+DOYONejHNCdOgCDPETCcIbMVsX/fWOd
         KRAI/xnqpgOCz2FHLg7+624M+ICvv1RT6RLLbQ8/5CB2VA2D6C/1kLJlGdSQZQNbHBCS
         QyDQ==
X-Gm-Message-State: APjAAAXGgcQwYVPNS4IS36FhBvzovzPIoGYrzN7unjUSo91BFy2owZ4o
        uVob082cvT6DPA/Noob2ffnCxTKb
X-Google-Smtp-Source: APXvYqyplCXcR0zpaUlaB1SJRHyFngk+mBqcYrBr90Wy2Ds/+0r5cgUEIMQV9ZyMabcqChC2vQxcag==
X-Received: by 2002:a05:6602:20c3:: with SMTP id 3mr8207645ioz.111.1556902877655;
        Fri, 03 May 2019 10:01:17 -0700 (PDT)
Received: from localhost.localdomain (182-254-181-166.mobile.uscc.com. [166.181.254.182])
        by smtp.gmail.com with ESMTPSA id n184sm1342588itc.28.2019.05.03.10.01.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 May 2019 10:01:16 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Enric Balletbo Serra <enric.balletbo@collabora.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 3/3] dt-bindings: power: supply: Add bindings for Microchip UCS1002
Date:   Fri,  3 May 2019 10:00:42 -0700
Message-Id: <20190503170042.19334-4-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190503170042.19334-1-andrew.smirnov@gmail.com>
References: <20190503170042.19334-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add bindings for Microchip UCS1002 Programmable USB Port Power
Controller with Charger Emulation.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Reviewed-by: Rob Herring <robh+dt@kernel.org>
Cc: Enric Balletbo Serra <enric.balletbo@collabora.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
---
 .../power/supply/microchip,ucs1002.txt        | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/microchip,ucs1002.txt

diff --git a/Documentation/devicetree/bindings/power/supply/microchip,ucs1002.txt b/Documentation/devicetree/bindings/power/supply/microchip,ucs1002.txt
new file mode 100644
index 000000000000..1d284ad816bf
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
+- interrupts		: A list of interrupts lines present (could be either
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
2.21.0

