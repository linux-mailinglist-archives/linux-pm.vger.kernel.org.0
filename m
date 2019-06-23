Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19EAE4FCE6
	for <lists+linux-pm@lfdr.de>; Sun, 23 Jun 2019 18:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbfFWQmY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 23 Jun 2019 12:42:24 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44536 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbfFWQmY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 23 Jun 2019 12:42:24 -0400
Received: by mail-pl1-f193.google.com with SMTP id t7so5490150plr.11;
        Sun, 23 Jun 2019 09:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QeuzSFtFULNoQbGg4hqLSd4xmo0B4o8ksbknu1n0KZM=;
        b=WX3Yrc0OvQ8B4sl+cSv2hgv3FAi1TFu+BMpDsDcgG2niFAPlDuUCFFhgZT32h1myEe
         OtI8aFmwrPENLyEXeOboC0R5ChT8PcsJwGPZdcnK3obduopK7EL8O618V8I3vX87FsGM
         W+SifyHWCKQJGj9xfXnzDbwRP+jNnE/bFXZgvpt3bw7BxHfNUZmo+7zeM6pjWJHXyh59
         5nF4UUTVWkTN3xE34blNimLRleCmmRIMDrVgnf3u251YCFwHLS9r0nQs/ukEinAW4XTE
         iIpCgUsg22Bwbo+a6b9zUJ3sewCrvqe41ug9HGsuSntXfo2ffqGkG7r/D6iJaaZIFqCb
         /Glg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QeuzSFtFULNoQbGg4hqLSd4xmo0B4o8ksbknu1n0KZM=;
        b=lOqXxhIkZXFS+9a0s/uUhueEnIcq7zJrH7hh3D08kJLU5LQSAZnMWGdpT/McSwhEva
         hkUQpmeln2ncxc1plzNTBi13aHSssYWIayCMPzC8BLenZOUVsVJdVvcuRWiUMVt6fpxi
         EJO2cxDmG5I1ySlJmKwPjyrwYTS/jNQfUH/JLHACZe43zOf1CSB53fwB2WVdlz2K+oLr
         zq/qDiOWMTGGyMaI/gYxEQpkRQpNQ/9Bn3T6sG9bQpiOXdUpCiENYeG1NRGN9Duw433l
         Jj8C3vth3P++S5TDThXwg/iuz+dit1yJFExQsvWmd5yf0sAsJaJJITv4y2JbQVE063k+
         Ueng==
X-Gm-Message-State: APjAAAWiTngzjkPJvOGtCxs4HPSGqqQYN7pTl+g9CcVe4OBaMD+bST5W
        Am0QjPRVH/rLfBe29sveF1mrtiBKMWA=
X-Google-Smtp-Source: APXvYqwmAwNO0tRQc1DYoa+hJd5YtKf6VLWWVmJUG+ZzCkzrIkvCUZwARJRuxYe6faj0d1GPkbIWBg==
X-Received: by 2002:a17:902:6b02:: with SMTP id o2mr48701805plk.133.1561308143647;
        Sun, 23 Jun 2019 09:42:23 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id e6sm9766388pfn.71.2019.06.23.09.42.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 23 Jun 2019 09:42:23 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, maxime.ripard@bootlin.com, wens@csie.org,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        mchehab+samsung@kernel.org, linus.walleij@linaro.org,
        nicolas.ferre@microchip.com, paulmck@linux.ibm.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v4 06/11] thermal: sun8i: get ths init func from device compatible
Date:   Sun, 23 Jun 2019 12:42:01 -0400
Message-Id: <20190623164206.7467-7-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190623164206.7467-1-tiny.windzz@gmail.com>
References: <20190623164206.7467-1-tiny.windzz@gmail.com>
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
index e473a5651436..59acbbac76e4 100644
--- a/drivers/thermal/sun8i_thermal.c
+++ b/drivers/thermal/sun8i_thermal.c
@@ -59,6 +59,7 @@ struct ths_thermal_chip {
 	int		scale;
 	int		ft_deviation;
 	int		temp_data_base;
+	int		(*init)(struct ths_device *tmdev);
 };
 
 struct ths_device {
@@ -362,7 +363,7 @@ static int sun8i_ths_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
-	ret = sun50i_thermal_init(tmdev);
+	ret = tmdev->chip->init(tmdev);
 	if (ret)
 		return ret;
 
@@ -400,6 +401,7 @@ static const struct ths_thermal_chip sun50i_h6_ths = {
 	.scale = -67,
 	.ft_deviation = SUN50I_H6_FT_DEVIATION,
 	.temp_data_base = SUN50I_H6_THS_TEMP_DATA,
+	.init = sun50i_thermal_init,
 };
 
 static const struct of_device_id of_ths_match[] = {
-- 
2.17.1

