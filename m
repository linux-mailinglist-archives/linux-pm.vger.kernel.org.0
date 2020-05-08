Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBCC01CB406
	for <lists+linux-pm@lfdr.de>; Fri,  8 May 2020 17:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgEHPxe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 May 2020 11:53:34 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34027 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbgEHPxe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 May 2020 11:53:34 -0400
Received: by mail-lj1-f195.google.com with SMTP id f11so2201725ljp.1;
        Fri, 08 May 2020 08:53:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8nkzaJ/iCAYbYLaQ1Jp7RPwOzPpYlnqGXh5SHsicXIw=;
        b=LUkcLwWidk6sCHwjSNN4smSJQ5VDtsgdIg0XQkbWD5jqPQmG0AN4jemuXzM1tscwAB
         YxaCVyjG1jvCwDRBwgPD3kSzi1XjWxZVcEFMaxod1SHbT2Hy67o7rSk5KSwICA1Vjx4T
         cOWAm67rNBEerlTVKv5KIDAjXRldY5LcxN8bh6EvdY6u3uYcC+DOyaU47QCq1Wd12zT0
         8NG/1YzxeU50nMD76vIrunxPqA+X5Q+d9E/T45Gy3JjjqJKLc9bgCFf2ARFChsc1XKjK
         Kd4XRA1bssxAsOQTrV337xCrcb34vNSVBdihgTyQ3mGM8nc6UtY3T3/YpYtxHnLSlUNF
         wWrQ==
X-Gm-Message-State: AOAM531I2Fr0A/4lU6zvBb1QNjxCyLtFSxIre4EA3hI0aD7YdV0pDXs6
        rWmc9wRLJegkvTMJ3TIKVrc=
X-Google-Smtp-Source: ABdhPJykawVthKA++HuKwY93ddj1Vp0zwGwnkvtvioVOTa8ECsfDKqpcDtlk0+UxUMHl794x+DEWzw==
X-Received: by 2002:a2e:992:: with SMTP id 140mr2177645ljj.188.1588953211899;
        Fri, 08 May 2020 08:53:31 -0700 (PDT)
Received: from localhost.localdomain (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id g11sm1480975ljg.24.2020.05.08.08.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 08:53:31 -0700 (PDT)
Date:   Fri, 8 May 2020 18:52:45 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     lgirdwood@gmail.com, broonie@kernel.org, sre@kernel.org,
        brendanhiggins@google.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v12 11/11] power: supply: KConfig cleanup default n
Message-ID: <499fc4aaac216c92fb43e51f688d072e937faf8c.1588944082.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1588944082.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1588944082.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The "default n" is not needed as it is, well, default. Clean
the KConfig by removing "default n".

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

---

This was pointed to me first by Randy Dunlap during v4 review.
Also Andy Shevchenko mentioned this to me. So as I was
changing the file anyways... Please just drop this patch out
of the series if you're not Ok with this.
---
 drivers/power/supply/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index ec028e47c3c2..04821d8c9e43 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -660,7 +660,6 @@ config CHARGER_RT9455
 config CHARGER_CROS_USBPD
 	tristate "ChromeOS EC based USBPD charger"
 	depends on CROS_USBPD_NOTIFY
-	default n
 	help
 	  Say Y here to enable ChromeOS EC based USBPD charger
 	  driver. This driver gets various bits of information about
@@ -696,7 +695,6 @@ config CHARGER_BD70528
 	tristate "ROHM bd70528 charger driver"
 	depends on MFD_ROHM_BD70528
 	select LINEAR_RANGES
-	default n
 	help
 	  Say Y here to enable support for getting battery status
 	  information and altering charger configurations from charger
-- 
2.21.0


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
