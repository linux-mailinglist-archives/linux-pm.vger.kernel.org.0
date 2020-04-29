Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD96B1BD56D
	for <lists+linux-pm@lfdr.de>; Wed, 29 Apr 2020 09:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgD2HIt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Apr 2020 03:08:49 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34493 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbgD2HIt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Apr 2020 03:08:49 -0400
Received: by mail-lf1-f65.google.com with SMTP id y3so752510lfy.1;
        Wed, 29 Apr 2020 00:08:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GPA/i1MeghluzvwK9kprDNBofjBWC5kulY4z+64/X/w=;
        b=ALmrVjUBSeYCZKVYKYkGiLlPxlOyj/C/tiNJKvHe/byLyqBEy41sy3tIofvBpVHDGr
         N7eC8z+LAXcJuXPafFTbA3TIu52B3kDpTu6HUSAH/GVRhLbpjwoH4ClMPrGYZhzpJvXE
         NPxDQmshGxk6AeeEKJn8KePX1pQOwdHWp7h8b32YDEAw/aKCEcvmckJVwGddsIyn/q+E
         u8Ge/bfHjFis+rvsYQgGQ8mN9qbfh8M/LG77Zc2d40Iq3G81XhJa0KM3eArYE2HBbmEv
         2W3pIJuqvL62kMXvTv8kzCEzmBMat6WYiYBYG0lbu6uYCktrWlyLQjG7hAFpJl/Cj4pT
         zDWA==
X-Gm-Message-State: AGi0PuZqP72TsVG2xVrRPUZaqnsVUAdCa/PT1CLYlyWB/dov53H+K7jb
        U2Ssb2gFlBVp9RC3hI4Qow/N+9Dc
X-Google-Smtp-Source: APiQypKJUKHitCtd2hf4n0P6AtScizHXUhSATc+VpJMvAMKGH/LF9S4ySEx0M6VsRwpCPlQ/JRpLdA==
X-Received: by 2002:a19:4a15:: with SMTP id x21mr3840498lfa.22.1588144127023;
        Wed, 29 Apr 2020 00:08:47 -0700 (PDT)
Received: from localhost.localdomain (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id z13sm1519205ljn.77.2020.04.29.00.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 00:08:46 -0700 (PDT)
Date:   Wed, 29 Apr 2020 10:07:54 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     sre@kernel.org, robh+dt@kernel.org, broonie@kernel.org,
        lgirdwood@gmail.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v10 11/11] power: supply: KConfig cleanup default n
Message-ID: <b893d0449886a8ffed00bbcc1fcbe34d83b833d3.1586925868.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1586925868.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1586925868.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The "default n" is not needed. Clean the KConfig by removing
"default n".

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---

This was pointed to me first by Randy Dunlap during v4 review.
I cleaned the BD99954 back then.

Also Andy Shevchenko mentioned this to me. So as I was
changing the file anyways... Please just drop this patch out
of the series if you're not Ok with this.

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
