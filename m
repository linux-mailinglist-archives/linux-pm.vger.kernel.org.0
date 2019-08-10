Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 318F388872
	for <lists+linux-pm@lfdr.de>; Sat, 10 Aug 2019 07:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbfHJF3i (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 10 Aug 2019 01:29:38 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37417 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfHJF3h (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 10 Aug 2019 01:29:37 -0400
Received: by mail-pg1-f194.google.com with SMTP id d1so14035867pgp.4;
        Fri, 09 Aug 2019 22:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=H2tnHPalIp9fh2DhSzr0mzewVRlNnFoVrBrcA4HDoA0=;
        b=osEaRM/awWZ4WLe5JMXKzOCsoTrczswa5Bo5mnVciwewqdioAOOsH0ycz5lcmtSG8f
         8iUp+HhGi6e2ec+73M0lfnzwpuJ/NBfRoXwTcOrxd7y+lgkMqxdrKI2uVd+nzaErnxUk
         iCue7pUwPCkdjFrXVijMnLUcQVP5lv0AZLd4uf36YjJrBuPlU7zH4uPTnbdFC0EnHc23
         UV6pbAxQxIpeQt1KB4AN3p9eWLw4/lQ8Ychsbx9r1t4Kcz4yQmOtd3v8Ngnr+7SYl8xz
         RyAAYI2pbE3Dp78iZHSiAaD4AGhwoyDhG7eLGGqOVgIchH6N2G2njfryjnrjXDh4/9Gz
         OhOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=H2tnHPalIp9fh2DhSzr0mzewVRlNnFoVrBrcA4HDoA0=;
        b=BnLJ7Dqtt36bJWDI8qZTJVrDu4qQviIq0T75xP4jJnsZ6j7eqvJ+qsRw5Ym7gtx6Pb
         ++yLbzw0NftMSbb7oEzG1istQvgKux1Jw7iUS+yg7s1bjbb4F/9s+CdEj4j1UNycrh1T
         HYC/le5i7ebSPTroMW03skGyzQvqblLDD12SmqgL17YaNK+UvG7jy0axEn1vd+/7vlyq
         0w+nleO6PhL9kXFFX2spSbn+C5jupeUInjW6ZdrxZMluxLLt6xc3CX3arg/NHy/vABLq
         BJsCZjSI25j8XE0czRvK1zJqg2tpvYI4zuQLVh1cDCE39c7OsPZYQskIRSj/Sei5RMvr
         P0oQ==
X-Gm-Message-State: APjAAAXyOWXJcEL8KP3IM4YCa+BYWeK4I1KOfYLqpaRaiJdXS5P6OsdR
        TJJkN96XC+AJR/eXpLc1FsE=
X-Google-Smtp-Source: APXvYqyCyAszXCVppy900Pfp410ttd5Apzw/e8hURBIejOOVEiT7DU9J+hYVzPCVmknr0H7fMYIsiA==
X-Received: by 2002:a17:90a:fb98:: with SMTP id cp24mr2640494pjb.48.1565414977200;
        Fri, 09 Aug 2019 22:29:37 -0700 (PDT)
Received: from localhost ([202.182.106.211])
        by smtp.gmail.com with ESMTPSA id v14sm106463565pfm.164.2019.08.09.22.29.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Aug 2019 22:29:36 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, maxime.ripard@bootlin.com, wens@csie.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, Jonathan.Cameron@huawei.com,
        nicolas.ferre@microchip.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v5 06/18] thermal: sun8i: get ths init func from device compatible
Date:   Sat, 10 Aug 2019 05:28:17 +0000
Message-Id: <20190810052829.6032-7-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190810052829.6032-1-tiny.windzz@gmail.com>
References: <20190810052829.6032-1-tiny.windzz@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There are some differences in register initialization for
different socs. So we get different initialization functions
from device compatible.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/thermal/sun8i_thermal.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
index f338fa25b98e..ad877b54f58e 100644
--- a/drivers/thermal/sun8i_thermal.c
+++ b/drivers/thermal/sun8i_thermal.c
@@ -59,6 +59,7 @@ struct ths_thermal_chip {
 	int		scale;
 	int		ft_deviation;
 	int		temp_data_base;
+	int		(*init)(struct ths_device *tmdev);
 };
 
 struct ths_device {
@@ -356,7 +357,7 @@ static int sun8i_ths_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
-	ret = sun50i_h6_thermal_init(tmdev);
+	ret = tmdev->chip->init(tmdev);
 	if (ret)
 		return ret;
 
@@ -394,6 +395,7 @@ static const struct ths_thermal_chip sun50i_h6_ths = {
 	.scale = -67,
 	.ft_deviation = SUN50I_H6_FT_DEVIATION,
 	.temp_data_base = SUN50I_H6_THS_TEMP_DATA,
+	.init = sun50i_h6_thermal_init,
 };
 
 static const struct of_device_id of_ths_match[] = {
-- 
2.17.1

