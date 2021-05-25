Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B98AC390043
	for <lists+linux-pm@lfdr.de>; Tue, 25 May 2021 13:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbhEYLsj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 May 2021 07:48:39 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:43263 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbhEYLsi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 May 2021 07:48:38 -0400
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 27D0A6001B;
        Tue, 25 May 2021 11:47:02 +0000 (UTC)
Date:   Tue, 25 May 2021 13:47:02 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sebastian Reichel <sre@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-power@fi.rohmeurope.com, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 2/9] rtc: bd70528: Drop BD70528 support
Message-ID: <YKzjtml4GL+dhP6j@piout.net>
References: <cover.1621937490.git.matti.vaittinen@fi.rohmeurope.com>
 <2beaa677bde0f9516f366b97e91419598f1dfde4.1621937490.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2beaa677bde0f9516f366b97e91419598f1dfde4.1621937490.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 25/05/2021 13:14:09+0300, Matti Vaittinen wrote:
> The only known BD70528 use-cases are such that the PMIC is controlled
> from separate MCU which is not running Linux. I am not aware of
> any Linux driver users. Furthermore, it seems there is no demand for
> this IC. Let's ease the maintenance burden and drop the driver. We can
> always add it back if there is sudden need for it.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> 
> ---
> My heart is a bit less bleeding when I see how much simpler this RTC
> driver became..
> Please let me know if some of you think the driver is needed.
> ---
>  drivers/rtc/Kconfig       |   4 +-
>  drivers/rtc/rtc-bd70528.c | 316 ++------------------------------------
>  2 files changed, 13 insertions(+), 307 deletions(-)
> 
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index d8c13fded164..398899217626 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -502,10 +502,10 @@ config RTC_DRV_M41T80_WDT
>  
>  config RTC_DRV_BD70528
>  	tristate "ROHM BD70528, BD71815 and BD71828 PMIC RTC"
> -	depends on MFD_ROHM_BD71828 || MFD_ROHM_BD70528 && (BD70528_WATCHDOG || !BD70528_WATCHDOG)
> +	depends on MFD_ROHM_BD71828

This won't apply as I applied b0ddc5b17005 ("rtc: bd70528: fix BD71815
watchdog dependency") yesterday...

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
