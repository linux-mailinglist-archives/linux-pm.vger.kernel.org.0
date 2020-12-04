Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7BC52CEE6E
	for <lists+linux-pm@lfdr.de>; Fri,  4 Dec 2020 13:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730096AbgLDMyx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Dec 2020 07:54:53 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41397 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728668AbgLDMyx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Dec 2020 07:54:53 -0500
Received: by mail-lf1-f67.google.com with SMTP id r24so7469938lfm.8;
        Fri, 04 Dec 2020 04:54:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s01ov5opcnyzf4x1O5fBO8Vti1W7Yid/d9Y3v+rRNR0=;
        b=f3ZHzbMKhiHPBs08M5izqoZSKcd5CY3dY6chJYz/YLs7OI8E0R0qHZjXjZNgDbdVnH
         Y+MNNjVqIT1kowW/PfCfSv4UBVkjPPxgVuDbdIoPJwEUmQrTg7N2XeiKZhhANZdXJKFb
         s29ipVsVEJpX7CYAosyQ46oR7N2GUMI8loBrTyBBPXji3nROz3UczEhmRhIlukjmLqoi
         HkH8XlTV41fqmMnIJgbAhHI5LKhksGvAfVbsjEw5U3vO7EG7rJf1+ogPrUVdHhbTSmFi
         /4J9qwwSUoFF7JYiI/Ycb8ct6LwC40b5jLrwF9IEqLjJcazL98pHIj51ddipez4sXhOw
         ohUQ==
X-Gm-Message-State: AOAM532E4gJBCGXOrz+uU3KeKGLEH6VK158dDCM6U60/7iRyopOloxV5
        Y0D6tRpF0x/W4XDXi+AjdNQ=
X-Google-Smtp-Source: ABdhPJxa/3xsUbth7NczJ/xOZThJVyoTzzGXWMusLwNxVPO3DipC33rJWnSDbKhz1wjlRW7dVGsJyw==
X-Received: by 2002:a19:cbd4:: with SMTP id b203mr454459lfg.506.1607086450890;
        Fri, 04 Dec 2020 04:54:10 -0800 (PST)
Received: from localhost.localdomain (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id o4sm1609553lfo.229.2020.12.04.04.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 04:54:10 -0800 (PST)
Date:   Fri, 4 Dec 2020 14:54:04 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Cong Pham <cpham2403@gmail.com>, rostokus@gmail.com,
        fan.chen@mediatek.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [RFC PATCH v2 6/6] MFD: bd71828: differentiate bd71828 and bd71827
 chargers
Message-ID: <a892b00bd90bcd09e124b3a8e306ededebb64d08.1607085199.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1607085199.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1607085199.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

BD71828 and BD71827 charger blocks have some minor differencies.
Use own name for BD71828 so that charger driver can differentiate
these by device-id.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---

This patch is also provided in this RFC version only for the sake
of the completeness.

 drivers/mfd/rohm-bd71828.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/rohm-bd71828.c b/drivers/mfd/rohm-bd71828.c
index 210261d026f2..fbd6e30136d9 100644
--- a/drivers/mfd/rohm-bd71828.c
+++ b/drivers/mfd/rohm-bd71828.c
@@ -44,7 +44,7 @@ static struct mfd_cell bd71828_mfd_cells[] = {
 	 * BD70528 clock gate are the register address and mask.
 	 */
 	{ .name = "bd71828-clk", },
-	{ .name = "bd71827-power", },
+	{ .name = "bd71828-power", },
 	{
 		.name = "bd71828-rtc",
 		.resources = rtc_irqs,
-- 
2.25.4


-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =] 
