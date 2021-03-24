Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0519347475
	for <lists+linux-pm@lfdr.de>; Wed, 24 Mar 2021 10:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbhCXJWL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Mar 2021 05:22:11 -0400
Received: from mail-lj1-f169.google.com ([209.85.208.169]:33397 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234656AbhCXJVl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Mar 2021 05:21:41 -0400
Received: by mail-lj1-f169.google.com with SMTP id 15so29354212ljj.0;
        Wed, 24 Mar 2021 02:21:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l2s71zdl6Ez98egv6WkHsjsQArym1MCaFt9Bj1GaoS0=;
        b=K3OvwEycIC0XpaaCvpF++8gju9Ah9k7fSw3hnRM21LEANwkJpC/qatgYxvcQSoZb4d
         lxIEfnxTrXvRwm2M0rGY90is5o1n8R27GLyw+NaqINwDEGQ3YG4d6QC45hviCJ3QTrM3
         OorOSU8m2ja6YzIvu6hTfJah6tsk4ozTFTdU027fWIJqlCRP4+Z+7vi5YkXUaid1Zylv
         GvKMt2qt3V34d5gvVLcYdfqvUyFmylN1R8SUqsVQBkZ7emplw/IgxehARctahAeVZEmu
         0fgt3hATY8KUpeGk3G0MFBlNXwCV2bv3A31BOBDJ+bNOtMnayHfAQDncNJVcMkyNZbNV
         Ypfg==
X-Gm-Message-State: AOAM530Gl8fToYGHoA1fTD8LAG5fFln80KD7m07ALoca3D+tWWzKaKu3
        B37BfB+I7YoorEnTWPr3bxI=
X-Google-Smtp-Source: ABdhPJz4zboU+CsWwucsqAkmbqnwBVmwnmhni1ldEaRx3beredWRDGvpSSnUAHa6PMiMiShXmZmMxQ==
X-Received: by 2002:a2e:9a0a:: with SMTP id o10mr1488317lji.432.1616577700292;
        Wed, 24 Mar 2021 02:21:40 -0700 (PDT)
Received: from localhost.localdomain (dc7vkhyyyyyyyyyyyyyby-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::2])
        by smtp.gmail.com with ESMTPSA id i12sm181191lfv.220.2021.03.24.02.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 02:21:39 -0700 (PDT)
Date:   Wed, 24 Mar 2021 11:21:34 +0200
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
Subject: [PATCH 2/2] power: supply: axp20x_usb_power: fix work-queue init
Message-ID: <a774ca25010b7c932c07f22ce8a548466705c023.1616574973.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1616574973.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1616574973.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The commit 6d0c5de2fd84
("power: supply: Clean-up few drivers by using managed work init")
Re-introduced wrong order of initializing work-queue and requesting
the IRQs which was originally fixed by the commit b5e8642ed95f
("power: supply: axp20x_usb_power: Init work before enabling IRQs")

In addition this caused the work queue to be initialized twice.

Fix it again.

Fixes: 6d0c5de2fd84 ("power: supply: Clean-up few drivers by using managed work init")

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Reported-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/power/supply/axp20x_usb_power.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index 4259709e3491..e954970b50e6 100644
--- a/drivers/power/supply/axp20x_usb_power.c
+++ b/drivers/power/supply/axp20x_usb_power.c
@@ -594,7 +594,11 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
 	power->axp20x_id = axp_data->axp20x_id;
 	power->regmap = axp20x->regmap;
 	power->num_irqs = axp_data->num_irq_names;
-	INIT_DELAYED_WORK(&power->vbus_detect, axp20x_usb_power_poll_vbus);
+
+	ret = devm_delayed_work_autocancel(&pdev->dev, &power->vbus_detect,
+					   axp20x_usb_power_poll_vbus);
+	if (ret)
+		return ret;
 
 	if (power->axp20x_id == AXP202_ID) {
 		/* Enable vbus valid checking */
@@ -647,10 +651,6 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
 		}
 	}
 
-	ret = devm_delayed_work_autocancel(&pdev->dev, &power->vbus_detect,
-					   axp20x_usb_power_poll_vbus);
-	if (ret)
-		return ret;
 	if (axp20x_usb_vbus_needs_polling(power))
 		queue_delayed_work(system_power_efficient_wq, &power->vbus_detect, 0);
 
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
