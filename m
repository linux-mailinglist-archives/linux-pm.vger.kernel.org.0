Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA2636D1A6A
	for <lists+linux-pm@lfdr.de>; Fri, 31 Mar 2023 10:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbjCaIh1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 31 Mar 2023 04:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbjCaIgn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 31 Mar 2023 04:36:43 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85A91D931
        for <linux-pm@vger.kernel.org>; Fri, 31 Mar 2023 01:35:19 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id v20-20020a05600c471400b003ed8826253aso4339591wmo.0
        for <linux-pm@vger.kernel.org>; Fri, 31 Mar 2023 01:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680251705;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2eM9F2Ux8ijetoy1aUe1DlA6v+PK0BvM3d2NvEyh+tc=;
        b=gQVJsVy7NCZuVzYpLt8LnlTZ4QiBCAvEtswZR5oJW7Ax0HOgbVCS1q7DduvuSrz3QB
         pLE1CWF04GtF3enverLrqHldhVlUiSzPI7jrCSXgCi8UbDyMtPe3IkVfZ/GyjLRNwIpm
         /ujMu4TZMw9sO2KrNxxvotVxPY8pNrd2cZ+rxfIlO1AGdIvXdy/mWIQx2vBfL7KdoUDl
         0ZqApcxpBmf6hsRwz4UwQhP9pGz9VYRQa9EqPOw/udhpkAp/VDerl/tq65d5+3IX/Zho
         UMY82QBbst7fDEeY2LrSQCea+YXbhisFv4q8WpzBVbD+tTkWIamYbAGIdiAl8cUCfiN1
         MdvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680251705;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2eM9F2Ux8ijetoy1aUe1DlA6v+PK0BvM3d2NvEyh+tc=;
        b=GUsG0XbOrvELO9XhzbR7NHiirnXmMikAFXTUs5ROm4YN3m39o7gA334gVaMJGgTogd
         I7H1E+/uJZfd2FexNykE/zjLHY+kp5NrEGUwXnrzb/93PFDmMbEpmeCcRQ7bkL6e1pAN
         zzwgnPTmlmCC6bWSQOShNfupQf6S3tkeA7yjEWk/mVpIv52+FEU6SmtmHlUYR8F/DdKo
         Y1NHzCOCsycV+VC4pyPGfWoelT7p7JEB6l+O5tVFdWpcAy67ZNuNbyxZV0HzkiA83ZHZ
         ZY6tk70zMxuEXOGQPxyexziP1jWh05BsLS8OwjCRBCIEYOQmGubejqzBHxOsX4Ii9c+c
         NcPQ==
X-Gm-Message-State: AO0yUKVbfaJpdGZO0rIUauou2lZ0AL6VF5YVnCBrL1K8WzCx3s2APAi6
        KjhrksbtYr2Bo84Laphf7o6Raw==
X-Google-Smtp-Source: AK7set+0JKF+ryMPRRbzb3BibnuUin7VHaHaaeXAUI+4vnrO4VZbOg/l2Mv5uhL3uMmOeMoG9uBNTQ==
X-Received: by 2002:a05:600c:280e:b0:3ed:551b:b78f with SMTP id m14-20020a05600c280e00b003ed551bb78fmr19188054wmb.4.1680251705130;
        Fri, 31 Mar 2023 01:35:05 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id e11-20020a5d4e8b000000b002cde626cd96sm1563153wru.65.2023.03.31.01.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 01:35:04 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Fri, 31 Mar 2023 10:34:53 +0200
Subject: [PATCH RFC 15/20] dt-bindings: gpio: gpio_oxnas: remove obsolete
 bindings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230331-topic-oxnas-upstream-remove-v1-15-5bd58fd1dd1f@linaro.org>
References: <20230331-topic-oxnas-upstream-remove-v1-0-5bd58fd1dd1f@linaro.org>
In-Reply-To: <20230331-topic-oxnas-upstream-remove-v1-0-5bd58fd1dd1f@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Sebastian Reichel <sre@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-mtd@lists.infradead.org, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Due to lack of maintainance and stall of development for a few years now,
and since no new features will ever be added upstream, remove the
OX810 and OX820 gpio bindings.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../devicetree/bindings/gpio/gpio_oxnas.txt        | 47 ----------------------
 1 file changed, 47 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/gpio_oxnas.txt b/Documentation/devicetree/bindings/gpio/gpio_oxnas.txt
deleted file mode 100644
index 966514744df4..000000000000
--- a/Documentation/devicetree/bindings/gpio/gpio_oxnas.txt
+++ /dev/null
@@ -1,47 +0,0 @@
-* Oxford Semiconductor OXNAS SoC GPIO Controller
-
-Please refer to gpio.txt for generic information regarding GPIO bindings.
-
-Required properties:
- - compatible: "oxsemi,ox810se-gpio" or "oxsemi,ox820-gpio"
- - reg: Base address and length for the device.
- - interrupts: The port interrupt shared by all pins.
- - gpio-controller: Marks the port as GPIO controller.
- - #gpio-cells: Two. The first cell is the pin number and
-   the second cell is used to specify the gpio polarity as defined in
-   defined in <dt-bindings/gpio/gpio.h>:
-      0 = GPIO_ACTIVE_HIGH
-      1 = GPIO_ACTIVE_LOW
- - interrupt-controller: Marks the device node as an interrupt controller.
- - #interrupt-cells: Two. The first cell is the GPIO number and second cell
-   is used to specify the trigger type as defined in
-   <dt-bindings/interrupt-controller/irq.h>:
-      IRQ_TYPE_EDGE_RISING
-      IRQ_TYPE_EDGE_FALLING
-      IRQ_TYPE_EDGE_BOTH
- - gpio-ranges: Interaction with the PINCTRL subsystem, it also specifies the
-   gpio base and count, should be in the format of numeric-gpio-range as
-   specified in the gpio.txt file.
-
-Example:
-
-gpio0: gpio@0 {
-	compatible = "oxsemi,ox810se-gpio";
-	reg = <0x000000 0x100000>;
-	interrupts = <21>;
-	#gpio-cells = <2>;
-	gpio-controller;
-	interrupt-controller;
-	#interrupt-cells = <2>;
-	gpio-ranges = <&pinctrl 0 0 32>;
-};
-
-keys {
-	...
-
-	button-esc {
-		label = "ESC";
-		linux,code = <1>;
-		gpios = <&gpio0 12 0>;
-	};
-};

-- 
2.34.1

