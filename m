Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0757EB44
	for <lists+linux-pm@lfdr.de>; Mon, 29 Apr 2019 22:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729290AbfD2UBY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Apr 2019 16:01:24 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35093 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729237AbfD2UBX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Apr 2019 16:01:23 -0400
Received: by mail-pl1-f195.google.com with SMTP id w24so5601507plp.2;
        Mon, 29 Apr 2019 13:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fjs/QlJccPdiIzSXEBVK27qZZaOYBQoAnxJi1UWQC3c=;
        b=hSld9bPgi0+ZmNCHh9hnHGpNMcDXCftcytcMT1RzD2U1rt0bU172xGf7bgK5faVFn8
         rqF98o+Eo4O0NXgCIcjuKW4NnBDG8jSuQXzRs8Gq+vHThFW4AAkK/VS92htnAOg2adFe
         HXFHF2jGt08vwpZK+QBIcMUkPW8/SNtJbuB3PalIawRRyaQHyqR4c0E0UxaATRynTdgE
         rLfXMgCcuyPqJC3Du2Nu7nwWWEhaiowJOqDTpMGxfftE6WjXqUuhGlfo8nC8WXTEOiuR
         u/XsS8iMM6+l/1czLCulk/9VLEKnarf3qPwrJHxC6rVdDkoPRKKjgBbSKUUDx1RPJZk1
         fEhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fjs/QlJccPdiIzSXEBVK27qZZaOYBQoAnxJi1UWQC3c=;
        b=UNfFb+4sGRNY0CvYAxpSq4euQhB6AZCe0fmQn7mVhGIn3aoL8j4nOBbdpovHkbrKpd
         ANwx6GsILVLXxQoTzhKlw3sk/mPPcjmC5AP7jhyTK1Wj0VvEYn+nCbXVUObWCvsw2hFg
         TUF9nVbCzljLe38Cb2ym/1QZ81GrribsrflUO1MsYfP58B4l6NjiJegC68eXItUIQvil
         a9CRiYFIHiGkhPkrcyOJ+7eApk9bqrEnupIXQ8SoQIoN/kkf0ism/JCqp5BQwp8lZr2W
         7QP5QJthpat0j7zYwqB7cwXgo3IROYq61MEwM1Py4L7jGNJbBtrak7bsy72B6xkbRjW7
         B1iQ==
X-Gm-Message-State: APjAAAXg1dOkB3zQQ4LYNOc0b1F9Rn3rRQYKJTg05iQ5D/ft3k8SWeuV
        dNf/f1Or9D1q+APTWwc3LCupF5qFpk8=
X-Google-Smtp-Source: APXvYqxZjfcO2EalYj0Q7+j0oedHQQMbWISZdRRv5eS3XyyL99Z1PQQIx0oTARKAYgrEEpWaB5jlyw==
X-Received: by 2002:a17:902:968c:: with SMTP id n12mr18925998plp.105.1556567641492;
        Mon, 29 Apr 2019 12:54:01 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id l2sm39841783pgl.2.2019.04.29.12.53.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 12:54:00 -0700 (PDT)
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
Subject: [PATCH v3 3/3] dt-bindings: power: supply: Add bindings for Microchip UCS1002
Date:   Mon, 29 Apr 2019 12:53:49 -0700
Message-Id: <20190429195349.20335-4-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190429195349.20335-1-andrew.smirnov@gmail.com>
References: <20190429195349.20335-1-andrew.smirnov@gmail.com>
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

