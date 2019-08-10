Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30EF98888C
	for <lists+linux-pm@lfdr.de>; Sat, 10 Aug 2019 07:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbfHJFaJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 10 Aug 2019 01:30:09 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35838 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfHJFaI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 10 Aug 2019 01:30:08 -0400
Received: by mail-pg1-f193.google.com with SMTP id n4so5123079pgv.2;
        Fri, 09 Aug 2019 22:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=71DUVtj5Cvg/Wok9dZsUDEqRY7qzU/CKNT9zSocN+ao=;
        b=AHZ5OqTYDdsovC5n1BNsaS8kgOU6oa6y2cAM5Wbguuqk5X5JFfCB99NyHGj1db+4X6
         MdEl7N+AOMFOoTs6oYVoU/1LtNcBNYKSFh/+dcZryJAp6056TKQKoZKWgELUPsA/t+RU
         7mZeZnDlpJoV8qs/Fekb/eNC5INfy6h3z9PXVNwktXZjAtaIRvOAuFQTodDeVeyRTMMI
         c9sYeO6khNfyyoCr0gwVC/M6JZvyLAbXKVKzHnkA7bJSqXHlBS3k7WTu0XfCnBu1tJ5J
         dGASctZiWvoOEgrrTdIyvM1NBcDFX4TzCg75DRXDb7lYZiGB2YcX6EfvWA9XSIXjpFD0
         r70A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=71DUVtj5Cvg/Wok9dZsUDEqRY7qzU/CKNT9zSocN+ao=;
        b=B3Ws9koyjE3QbWyyGIoz3oPb6x1YvEYpl6jzwIk799Ej/qPZQP2x63CPvpYMCUHRKC
         amKnKi5hf0nkvQ4Sf1JAi5AN5BmvgU69DduriCjKi1cz8FNDU9RR9AKmZkRc+ekMzY4E
         zo3op/p4zEbg8wspBSAEqZdFvET38qG47+OEYiAPAlKv8Xx0sAn4NzGv9ZHhPX1mOGkm
         ehgKbOvSZDbQYsk5/ZfCEM+9vtoVDzppsri9lGg+Z8SOr/+SsRrL991DN4I/QaNd7nSk
         Jtx/x4SEYS1wHOS7FuBltpHnaWjHNUwS2EKVenHvapzYdJX0UD5OLQGei+ZlHtrHmLIe
         2tAA==
X-Gm-Message-State: APjAAAUh6TyeWsuIQqdWS+i0+frIh9bm8MxnW/oKduEuWkcIc/vrPd5B
        3ZxiTXq6a4LnpJJJaxEufCA=
X-Google-Smtp-Source: APXvYqy0SbXHrw7PFXc5NqzKKuYBZBqpPz4Kx438X2kv6H5qephacghobTnQMk+4EBLFALhrbhee5Q==
X-Received: by 2002:aa7:8d98:: with SMTP id i24mr25671345pfr.199.1565415007779;
        Fri, 09 Aug 2019 22:30:07 -0700 (PDT)
Received: from localhost ([202.182.106.211])
        by smtp.gmail.com with ESMTPSA id o12sm6113304pjr.22.2019.08.09.22.30.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Aug 2019 22:30:07 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, maxime.ripard@bootlin.com, wens@csie.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, Jonathan.Cameron@huawei.com,
        nicolas.ferre@microchip.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH v5 13/18] thermal: sun8i: add thermal driver for A64
Date:   Sat, 10 Aug 2019 05:28:24 +0000
Message-Id: <20190810052829.6032-14-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190810052829.6032-1-tiny.windzz@gmail.com>
References: <20190810052829.6032-1-tiny.windzz@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Vasily Khoruzhick <anarsoul@gmail.com>

Thermal sensor controller in A64 is similar to H3, but it has 3 sensors.
Extend H3 functions to add support for multiple sensors.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 drivers/thermal/sun8i_thermal.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
index 41ce8cdc0546..3259081da841 100644
--- a/drivers/thermal/sun8i_thermal.c
+++ b/drivers/thermal/sun8i_thermal.c
@@ -515,6 +515,17 @@ static const struct ths_thermal_chip sun8i_h3_ths = {
 	.irq_ack = sun8i_h3_irq_ack,
 };
 
+static const struct ths_thermal_chip sun50i_a64_ths = {
+	.sensor_num = 3,
+	.offset = -2170,
+	.scale = -117,
+	.has_mod_clk = true,
+	.temp_data_base = SUN8I_THS_TEMP_DATA,
+	.calibrate = sun8i_h3_ths_calibrate,
+	.init = sun8i_h3_thermal_init,
+	.irq_ack = sun8i_h3_irq_ack,
+};
+
 static const struct ths_thermal_chip sun50i_h6_ths = {
 	.sensor_num = 2,
 	.offset = -2794,
@@ -528,6 +539,7 @@ static const struct ths_thermal_chip sun50i_h6_ths = {
 
 static const struct of_device_id of_ths_match[] = {
 	{ .compatible = "allwinner,sun8i-h3-ths", .data = &sun8i_h3_ths },
+	{ .compatible = "allwinner,sun50i-a64-ths", .data = &sun50i_a64_ths },
 	{ .compatible = "allwinner,sun50i-h6-ths", .data = &sun50i_h6_ths },
 	{ /* sentinel */ },
 };
-- 
2.17.1

