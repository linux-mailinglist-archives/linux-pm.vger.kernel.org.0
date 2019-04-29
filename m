Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 545E7DBA3
	for <lists+linux-pm@lfdr.de>; Mon, 29 Apr 2019 07:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbfD2FsK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Apr 2019 01:48:10 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46083 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727332AbfD2FsJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Apr 2019 01:48:09 -0400
Received: by mail-pg1-f193.google.com with SMTP id n2so4593458pgg.13;
        Sun, 28 Apr 2019 22:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fjs/QlJccPdiIzSXEBVK27qZZaOYBQoAnxJi1UWQC3c=;
        b=MHr5iFRw+tp+gqiL3I3y4eiNAWoHTeP+vDeAwqND73yHii7k0YdDk4QJXrkSgDsXXh
         WI9oP9MFw6VNcWwFRwYeu19g0O/ihRMgUXX8RDekZAAYwEd6GqF0KZvw8fmdgzIDXF4d
         uZpbr6VVFPTTdhcazRIDYl3EmgY4r67PaMKYE04XF3NMzrA441VRqG4JfhzQZxWhMCPl
         C5vJ+Bj/mv+gVUljMAEV+lzaK4/Q6qwUmsPINDN2DNeYClJve9RZjW1redqzcctclzwP
         Ez/UH8DpqFmD4lmSkfe8/Ek9gNxN/WOJj1+Bdq7F1PHSKdCRFy5jXF459ckeNbvUtv2y
         bZaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fjs/QlJccPdiIzSXEBVK27qZZaOYBQoAnxJi1UWQC3c=;
        b=K8v8E8G+rtjKlEJiAQV0Di1EHdWYrMKUrejk9r4uRSf894JJ3NpL1RUoH/miwksgQd
         JFUzY/mBAJgnYu1uCKUFxF+PX1kl6pQMOJwMCoLoaQi7gGMOZanmCw6VuDORfVZ0G7bV
         mfHz1L+oeC9CQZ7wUMsUwc0mVeJqQdkb39eE8ezPsIA2Gxk8R9JsUU/dLq+izMANy6+B
         YTnBdb1eYdeqbkzw/Px3baiMwI3vWyIFw/OrCbeee3v49+jhZztFsLsv+eEnZZRdBphW
         C6w+HMIRi0mg3TtPHnltIAbxCcUGSvMGMJKFEjykUPO6ud5Bh9GqtzN7wYefCajLlbzr
         fTXw==
X-Gm-Message-State: APjAAAWsMuju657FT2iLIRaLLZlmPhrKqzhMXnr7f4f4y+tSSIOfyySd
        ds+hYecR4TX1PEiC5aRAnLG1OAS3uwg=
X-Google-Smtp-Source: APXvYqxF/KdEF10+njoKQkhrf1cNzcNM8W+SyXl+dItO+8/5IZT0o2KfXzp6CnOAqYV0yslD/zFzEA==
X-Received: by 2002:a65:4183:: with SMTP id a3mr57054240pgq.121.1556516888732;
        Sun, 28 Apr 2019 22:48:08 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id g10sm37856567pgq.54.2019.04.28.22.48.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Apr 2019 22:48:07 -0700 (PDT)
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
Subject: [PATCH v2 3/3] dt-bindings: power: supply: Add bindings for Microchip UCS1002
Date:   Sun, 28 Apr 2019 22:47:41 -0700
Message-Id: <20190429054741.7286-4-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190429054741.7286-1-andrew.smirnov@gmail.com>
References: <20190429054741.7286-1-andrew.smirnov@gmail.com>
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

