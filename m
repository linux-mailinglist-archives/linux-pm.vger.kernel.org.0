Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D928F31ED1F
	for <lists+linux-pm@lfdr.de>; Thu, 18 Feb 2021 18:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbhBRRQt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Feb 2021 12:16:49 -0500
Received: from mga18.intel.com ([134.134.136.126]:24502 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233602AbhBRQbv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 18 Feb 2021 11:31:51 -0500
IronPort-SDR: bEyzum6oA3kRNfGD43MyymPdSDcJ+YLrFnc3BUYF/gw9kptZX4OG1ZwNBsD3WxCrvDUs5uAT7K
 NywfAw+4poJQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9898"; a="171226748"
X-IronPort-AV: E=Sophos;i="5.81,187,1610438400"; 
   d="scan'208";a="171226748"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2021 08:28:22 -0800
IronPort-SDR: 8wV6FNxP8SE0d4WHFpdRVuaFuCTVydh3gBnRbO6D/bXLTESQYwmiHqSvYcvTGhorUg/aee8is/
 q6876h3NGC7Q==
X-IronPort-AV: E=Sophos;i="5.81,187,1610438400"; 
   d="scan'208";a="367582619"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2021 08:28:21 -0800
Received: from localhost (mtg-dev.jf.intel.com [10.54.74.10])
        by smtp.ostc.intel.com (Postfix) with ESMTP id 25BFD6365;
        Thu, 18 Feb 2021 08:28:21 -0800 (PST)
Date:   Thu, 18 Feb 2021 08:28:21 -0800
From:   mark gross <mgross@linux.intel.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     mazziesaccount@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Sebastian Reichel <sre@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Saravana Kannan <saravanak@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-hwmon@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [RFC PATCH 0/7] Add managed version of delayed work init
Message-ID: <20210218162821.GP154917@linux.intel.com>
Reply-To: mgross@linux.intel.com
References: <cover.1613216412.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1613216412.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Feb 13, 2021 at 01:58:17PM +0200, Matti Vaittinen wrote:
> It's not rare that device drivers need delayed work.
> It's not rare that this work needs driver's data.
> 
> Often this means that driver must ensure the work is not queued when
> driver exits. Usually this is done by ensuring new work is not added and
> then calling cancel_delayed_work_sync() at remove(). In many cases this
> may also require cleanup at probe error path - which is easy to forget.
> 
> It might be helpful for (a) few drivers if there was a work init
 why the (a) and not just a?

> function which would ensure cancel_delayed_work_sync() is called at
> driver exit. So this series implements one on top of devm and replaces
> the obvious cases where only thing remove call-back in a driver does is
> cancelling the work. There might be other cases where we could switch
> more than just work cancellation to use managed version and thus get rid
> of remove.
> 
> Main reson why this is RFC is that I had hard time deciding where this
> function should be introduced. It's not nice to include all device stuff
> in workqueue - because many workqueue users are not interested in
> devices. In same way, not all of the devices are interested in WQs.
> OTOH, adding own file just for this sounds like an overkill.
s/own/one

--mark

> 
> This time I decided that it is more correct that devices use WQs than
> that WQs use devices. Hence the function is introduced in
> include/linux/device.h and drivers/base/devres.c
> 
> --
> 
> Matti Vaittinen (7):
>   drivers: base: Add resource managed version of delayed work init
>   extconn: Clean-up few drivers by using managed work init
>   hwmon: raspberry-pi: Clean-up few drivers by using managed work init
>   platform/x86: gpd pocket fan: Clean-up by using managed work init
>   power: supply: Clean-up few drivers by using managed work init
>   regulator: qcom_spmi-regulator: Clean-up by using managed work init
>   watchdog: retu_wdt: Clean-up by using managed work init
> 
>  drivers/base/devres.c                        | 33 ++++++++++++++++++++
>  drivers/extcon/extcon-gpio.c                 | 14 ++-------
>  drivers/extcon/extcon-intel-int3496.c        | 15 ++-------
>  drivers/extcon/extcon-palmas.c               | 16 +++-------
>  drivers/extcon/extcon-qcom-spmi-misc.c       | 16 +++-------
>  drivers/hwmon/raspberrypi-hwmon.c            | 16 +++-------
>  drivers/platform/x86/gpd-pocket-fan.c        | 16 +++-------
>  drivers/power/supply/axp20x_usb_power.c      | 15 +++------
>  drivers/power/supply/bq24735-charger.c       | 17 +++-------
>  drivers/power/supply/ltc2941-battery-gauge.c | 19 ++++-------
>  drivers/power/supply/sbs-battery.c           | 15 +++------
>  drivers/regulator/qcom_spmi-regulator.c      | 33 +++++---------------
>  drivers/watchdog/retu_wdt.c                  | 21 +++----------
>  include/linux/device.h                       |  5 +++
>  14 files changed, 95 insertions(+), 156 deletions(-)
> 
> 
> base-commit: 92bf22614b21a2706f4993b278017e437f7785b3
> -- 
> 2.25.4
> 
> 
> -- 
> Matti Vaittinen, Linux device drivers
> ROHM Semiconductors, Finland SWDC
> Kiviharjunlenkki 1E
> 90220 OULU
> FINLAND
> 
> ~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
> Simon says - in Latin please.
> ~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
> Thanks to Simon Glass for the translation =] 
