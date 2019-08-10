Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB61888A6
	for <lists+linux-pm@lfdr.de>; Sat, 10 Aug 2019 07:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725847AbfHJFcg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 10 Aug 2019 01:32:36 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41671 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbfHJFcg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 10 Aug 2019 01:32:36 -0400
Received: by mail-pl1-f193.google.com with SMTP id m9so45610661pls.8;
        Fri, 09 Aug 2019 22:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=71DUVtj5Cvg/Wok9dZsUDEqRY7qzU/CKNT9zSocN+ao=;
        b=oH/Pf9MtSMDZkluj4qQKlvh6Kv8FriGzPN9CjiWS1WBhMkpRogJ5AYRzjRkOt+MO9y
         DensadzKBFHj3agCJgnb3xMpazh9MI43ilUc0NXpzI7eyC0gmIAhzJp5zvR0IQrsdymo
         nJIPKVISeubH+rufmf3Lc/KYui2pUCc3Zyhu8DXu9KDooJesZmLnC+5g1bJlVOetHSS1
         Woq5wOdnef8MHDFi4DP/rUQLksb2NhiKvjWqfWI6ehlkuoq12Kn+A80ApJodRlFiTsUR
         1fy4fS7ySH71Gaelyza0+EmuwftY6JgenWu8GsFN/nwMdBTweYeMYDt6TksRya0JxO5C
         3SCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=71DUVtj5Cvg/Wok9dZsUDEqRY7qzU/CKNT9zSocN+ao=;
        b=V29Dr9ILk6NhD4XdXoSr2FUkFgOFvVTNnu7Uqy2HRCClB09UkTe1K+H0swzb588c4e
         Hhwfn5p//+3qdlxpcXgdmZb61/E7UuOkkHIndToKYPuPpm4kfb5+uHGBIUeO0jdTGUvf
         Tb2Abu4P5Tjy4HVWOn/2w0MuqtIEW4zza7DAKrLhuFjUGQvR+koLI2e3vckugOb1bRJu
         DYRrEtm+6Lnrd/k10wrYNrBIfu+ALWqDc7EwJpieyxuwEyYIdQDKLdSADEb6KUyLKhhR
         xaqam4jVT1Mzql4BSv6qKQq6thGlEGu5Dak5qvlamYQQdTClrQqkvHuOW8KWMYoSblhB
         wBIg==
X-Gm-Message-State: APjAAAX3DVBEGBdSx4UeCkIO67DST8Fehr81bKkobu2oibhh1+0+ynI+
        vf9ymKJjRICuPX+ZNpAa6kQ=
X-Google-Smtp-Source: APXvYqzx2x2due+dcKfhyyCVT9miXzJYXimf/VWFq0pAMOqAFhvOtdO+BDXCCX1MutojsCyob5lLGg==
X-Received: by 2002:a17:902:4383:: with SMTP id j3mr16103296pld.69.1565415155840;
        Fri, 09 Aug 2019 22:32:35 -0700 (PDT)
Received: from localhost ([202.182.106.211])
        by smtp.gmail.com with ESMTPSA id 16sm26554443pfc.66.2019.08.09.22.32.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Aug 2019 22:32:35 -0700 (PDT)
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
Date:   Sat, 10 Aug 2019 05:32:32 +0000
Message-Id: <20190810053232.6125-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
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

