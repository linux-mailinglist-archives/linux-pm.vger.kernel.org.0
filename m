Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 388F434746E
	for <lists+linux-pm@lfdr.de>; Wed, 24 Mar 2021 10:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbhCXJVi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Mar 2021 05:21:38 -0400
Received: from mail-lj1-f173.google.com ([209.85.208.173]:44961 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbhCXJVX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Mar 2021 05:21:23 -0400
Received: by mail-lj1-f173.google.com with SMTP id u9so1630285ljd.11;
        Wed, 24 Mar 2021 02:21:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+gMqvRolEZnnoKM5KaXGodkWheXP+g5d9dALKOnmgGY=;
        b=X1E4lFdv2nLEJRifNEVhs5Z0ev/zG0yIPj6Ug+EODpET30WXbBmsvadutVpr92uYKo
         3+lVkAMULIFBds0zhZ9fXbL0PNu8mEduX3Ww7sDZrTS+EXYJFwD7mQZg/g1pR0KAu3ZI
         tg+pD/iUSI0HjafjEuLt2+vQBhOYpdBX+4iXJNb2URs1BLMDqSxzQPqHZsoGn8XUhRjK
         hIh+MWWylRNXHR9Pl0GRwxekH5T+1H8WOBoUiWJ79k9ibV46Utfo3PR3Yd64qfSfp2Mr
         sfDYEBvKtFmsVgt8d2jgNcv2wA4MMaU5cN9gep0utZ4Pw8e5zOvG8UnxKqHzOMNpMARF
         /cfQ==
X-Gm-Message-State: AOAM533YNmN7TZX/Xk8L61WNOT8GOH3B+38X4PplSY6Ze5C0kJlq8SKX
        DBNadl8vSH7IzxcWLcP92Ww=
X-Google-Smtp-Source: ABdhPJwAk8NX4Fjgxdj3cpFu2LhijJDIo2BxsTSTwgO1c7egREXS33T7qJcmSQqEbdjyHTIRc+4M3A==
X-Received: by 2002:a2e:b7c1:: with SMTP id p1mr1498436ljo.198.1616577682372;
        Wed, 24 Mar 2021 02:21:22 -0700 (PDT)
Received: from localhost.localdomain (dc7vkhyyyyyyyyyyyyyby-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::2])
        by smtp.gmail.com with ESMTPSA id e9sm236846ljj.52.2021.03.24.02.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 02:21:22 -0700 (PDT)
Date:   Wed, 24 Mar 2021 11:21:16 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sebastian Reichel <sre@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 1/2] extcon: extcon-gpio: Log error if work-queue init fails
Message-ID: <bfd893701ac3d239fef856d2f589063983422100.1616574973.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1616574973.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1616574973.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add error print for probe failure when resource managed work-queue
initialization fails.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Suggested-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/extcon/extcon-gpio.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/extcon/extcon-gpio.c b/drivers/extcon/extcon-gpio.c
index 4105df74f2b0..8ea2cda8f7f3 100644
--- a/drivers/extcon/extcon-gpio.c
+++ b/drivers/extcon/extcon-gpio.c
@@ -114,8 +114,10 @@ static int gpio_extcon_probe(struct platform_device *pdev)
 		return ret;
 
 	ret = devm_delayed_work_autocancel(dev, &data->work, gpio_extcon_work);
-	if (ret)
+	if (ret) {
+		dev_err(dev, "Failed to initialize delayed_work");
 		return ret;
+	}
 
 	/*
 	 * Request the interrupt of gpio to detect whether external connector
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
