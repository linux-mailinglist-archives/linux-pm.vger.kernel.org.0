Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 261D88889B
	for <lists+linux-pm@lfdr.de>; Sat, 10 Aug 2019 07:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbfHJFaa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 10 Aug 2019 01:30:30 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41530 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbfHJFaa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 10 Aug 2019 01:30:30 -0400
Received: by mail-pf1-f195.google.com with SMTP id m30so47130797pff.8;
        Fri, 09 Aug 2019 22:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=N97E8/sjLzhDk5t0PaLYKP9s4xc14haiY7F1jTT8rvA=;
        b=ZRbyXiUF6gmLzn1OgJc7h/Hf+DW3O8LRQKGyeBgbf6cqioGR47ZdLTH5+11AfvdCyw
         LKGQlCR3NKbdJNpn0FF82vptUjuhz65HyJEUwbSyswVoS7XeEMR9BBewfeZ5YihKwcR0
         dyTwCU8PO3jfRvxduaepqLwpC8rv3pxjzlTECubkKfxGhMDxhWgFulkJcbki9tbr/x+Q
         1i1D6xhTKJK4sqe/TzvhCLOgmdy6cf9YUhRbidBKHpn+pSD3x/rsNfvtjPnyY93A6eg2
         heBRqnvyzd304Vgkt1CKz6HpVF1wmxDQ3zm0mVfsaVMZ210ACYsWhKp7p02Wz40JhgNV
         A/SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=N97E8/sjLzhDk5t0PaLYKP9s4xc14haiY7F1jTT8rvA=;
        b=qRUd5lCzZm4EhuWNuMg3apDsFiy4AqcSZI7xXWHoEDTgKZ+rhxZXoUPaZDvSHSQtcf
         XsoP8mPw7n1EVVTS6E60KhZhQjNyFb7cnE1DA0M+ellBGDFKs+WJWT6zyRsFSAU3XtCE
         08H0z6M/S+K/ZaYEQAe1LdGVEef8yTbJA20KFhr7h0sNIrBbt6IHo0XM8Bja0C3FDH3r
         jiJhYYZMOUFN9dEd/nAZt0skZNKQ3+LmFSk3BFdkPtBsnGCci7iYAUhw30Lxe69/SE9v
         lUDRVPv0fRMEqIgnE4KG0jwgtRX4z1up1INcHMcKw3hum442X9EGpYt9RIkprjYC5AHu
         NX2A==
X-Gm-Message-State: APjAAAX/9G+rGsFeCBme0bgmr/JVMTpHb0Yx1SAxIbjN8ZdP6ez/MFk8
        y5qfxH9gs9mMou8oLz7OEEQ=
X-Google-Smtp-Source: APXvYqxQJC2cov0AZI9Zc6L1PoOKHIqa7mOVzuvWNzU+GwSLSgVq2r0q65Ii4MJWgZcDi6gXhannTw==
X-Received: by 2002:a62:e315:: with SMTP id g21mr26135824pfh.225.1565415029673;
        Fri, 09 Aug 2019 22:30:29 -0700 (PDT)
Received: from localhost ([202.182.106.211])
        by smtp.gmail.com with ESMTPSA id z13sm6999252pjn.32.2019.08.09.22.30.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Aug 2019 22:30:29 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, maxime.ripard@bootlin.com, wens@csie.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, Jonathan.Cameron@huawei.com,
        nicolas.ferre@microchip.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH v5 18/18] thermal: sun8i: add support for Allwinner R40 thermal sensor
Date:   Sat, 10 Aug 2019 05:28:29 +0000
Message-Id: <20190810052829.6032-19-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190810052829.6032-1-tiny.windzz@gmail.com>
References: <20190810052829.6032-1-tiny.windzz@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Icenowy Zheng <icenowy@aosc.io>

The thermal sensor in Allwinner R40 SoC is quite similar to the one in
Allwinner A64 SoC, with only slightly different temperature calculation
formula.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 drivers/thermal/sun8i_thermal.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
index 78a888d85cba..0de9a56c3775 100644
--- a/drivers/thermal/sun8i_thermal.c
+++ b/drivers/thermal/sun8i_thermal.c
@@ -529,6 +529,17 @@ static const struct ths_thermal_chip sun8i_h3_ths = {
 	.irq_ack = sun8i_h3_irq_ack,
 };
 
+static const struct ths_thermal_chip sun8i_r40_ths = {
+	.sensor_num = 3,
+	.offset = -2222,
+	.scale = -113,
+	.has_mod_clk = true,
+	.temp_data_base = SUN8I_THS_TEMP_DATA,
+	.calibrate = sun8i_h3_ths_calibrate,
+	.init = sun8i_h3_thermal_init,
+	.irq_ack = sun8i_h3_irq_ack,
+};
+
 static const struct ths_thermal_chip sun50i_a64_ths = {
 	.sensor_num = 3,
 	.offset = -2170,
@@ -563,6 +574,7 @@ static const struct ths_thermal_chip sun50i_h6_ths = {
 
 static const struct of_device_id of_ths_match[] = {
 	{ .compatible = "allwinner,sun8i-h3-ths", .data = &sun8i_h3_ths },
+	{ .compatible = "allwinner,sun8i-r40-ths", .data = &sun8i_r40_ths },
 	{ .compatible = "allwinner,sun50i-a64-ths", .data = &sun50i_a64_ths },
 	{ .compatible = "allwinner,sun50i-h5-ths", .data = &sun50i_h5_ths },
 	{ .compatible = "allwinner,sun50i-h6-ths", .data = &sun50i_h6_ths },
-- 
2.17.1

