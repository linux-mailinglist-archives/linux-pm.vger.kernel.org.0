Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0922A1C8258
	for <lists+linux-pm@lfdr.de>; Thu,  7 May 2020 08:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725857AbgEGGQb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 May 2020 02:16:31 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36376 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbgEGGQb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 May 2020 02:16:31 -0400
Received: by mail-lf1-f66.google.com with SMTP id t2so3437367lfc.3;
        Wed, 06 May 2020 23:16:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8nkzaJ/iCAYbYLaQ1Jp7RPwOzPpYlnqGXh5SHsicXIw=;
        b=I81PsCchp1maePFYSKuEJXxTzjgj02EFbaIPTQ4uwwp3t8mjEdv4Xne6eQcL4zL648
         zV1J+Ngb6c+X+x/PLkgnqXkHr/qDTmo0qWdmExi4TdjP1HKNjPlVB4ZMLA0jjbsRD9GD
         PM2G/vtNwO3LvN8oILF9Zd4Nnw5WysAbtfs2mbf7b/sVucEhGUC1NjNPM7aaYbb66s8I
         EF8fitR9yh/NHZ/pratbmIfRyXzAj4im0oEJ5xMO/toE/9T6cevtzvoQ0ATovlZ2SA1+
         i81OMWesE87qrp8q1bYaFBELp7adt5qVHGj5c20tFbWL1xtgTAiH89OhNDv9/MZKzv1U
         jQsg==
X-Gm-Message-State: AGi0Pub633IBX4tWgVrNhmw9LfVzenkMooy0E8pBKE2bVNKZrV1uxzcS
        N2QOdRh0TsZt7A9Q/t0cKbk=
X-Google-Smtp-Source: APiQypJy4yZ712jfRehgS9av5N4b+n6yuCkM88E5HWxP4luWuw6AxlOV+JxcESUWYB/YDziTzQ28Rg==
X-Received: by 2002:ac2:5df9:: with SMTP id z25mr4581784lfq.125.1588832187549;
        Wed, 06 May 2020 23:16:27 -0700 (PDT)
Received: from localhost.localdomain (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id y9sm2637683ljy.31.2020.05.06.23.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 23:16:27 -0700 (PDT)
Date:   Thu, 7 May 2020 09:15:40 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     lgirdwood@gmail.com, broonie@kernel.org, sre@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v11 11/11] power: supply: KConfig cleanup default n
Message-ID: <8e37fa0e22d4db4cc26892b17620dab2d6c8bd66.1588829892.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1588829892.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1588829892.git.matti.vaittinen@fi.rohmeurope.com>
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
