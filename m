Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0C910CB37
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2019 16:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbfK1PC0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Nov 2019 10:02:26 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40712 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbfK1PC0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Nov 2019 10:02:26 -0500
Received: by mail-pg1-f194.google.com with SMTP id e17so13022467pgd.7;
        Thu, 28 Nov 2019 07:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/yK+bP/ZquyDqTbwLOoQFt7m4Vf6MNFvYmMx+oPcx0U=;
        b=mslmdNSSudE7yrNxVl9gLKm+PW7faAyM+eH7GAB9JmUxunrZ+delEqNm4/4ejVIm5R
         6A5ngV7ImLhf+KfUj3ECrYK2CM9yXjTX3V5eI2cMxq+8if3m3CelEq6oXt3EyoWAHau9
         2gAH1IOUpTOUyYQ8lI4m/+7Ivw/GDUGd3qiZ3R3pBEz4IN/eQ8tdI/9op3ZUewTeoCd8
         tV8D6Hgp1CryCOZsHcgWKckLtcxCEnAjEtlgrDkkBy3CZJh//UQYr3sJp2k/U6Ppla8E
         Ks9XUiSVHgPIcCpmMxw+IWteo2+p2EWvcNJA7+zoeviWLLedA4ku1VpbfrpkL8xh3fNN
         eRlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/yK+bP/ZquyDqTbwLOoQFt7m4Vf6MNFvYmMx+oPcx0U=;
        b=Ep7Z4MOrMxQp5HXaeDCArD8lNMB5XH8F25hXmAHUtoB+grvNAvWmsB3I+5SWr8Gmf7
         VtpU+gOaELFiNjxLbtuj3RBN50AZGK6eEgfReqwqOQa7k2OuSN2uIY96ZV9R5jWgXk0D
         1Uaj1dluHzU2y9zLUyYj9JKEiQZw2MlTPDG0JdNvprFk9GaP8/wT/Kt2b39fka+/dQ3L
         pfJERhrg+GWzxNtjv/swXxr4l4twBAzSlH0ZKx8CbeEsyzc3Gj7bdtqylJTHIb+omLBv
         GU9U9iGjv1HPDSlJx0/HlZVx1Y7tSa7c+aPbnD4UUbTnJEgi8iIuoEp0GF5XSUY512GV
         j3ZA==
X-Gm-Message-State: APjAAAWaNvmSDb/IhEyzrSjx0y5ihJezj4EPUPjbA2Ig/5Yb+k8y+5bz
        sfxbVVabol8XqsHtB3Hair7ztAnQYxQM3fJgfLQ=
X-Google-Smtp-Source: APXvYqzI7Qf+yzT4pAOOBFmdCFGcdvppyFYuVIaWxgTEMPPJrdcAYC6dW5CPkHAinmujdN25OW+CtNH57+kcSY3ry0o=
X-Received: by 2002:a65:6118:: with SMTP id z24mr11995545pgu.203.1574953345343;
 Thu, 28 Nov 2019 07:02:25 -0800 (PST)
MIME-Version: 1.0
References: <1574952879-7200-1-git-send-email-akinobu.mita@gmail.com> <1574952879-7200-5-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1574952879-7200-5-git-send-email-akinobu.mita@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 28 Nov 2019 17:02:15 +0200
Message-ID: <CAHp75VdswWO9r5zO=Tph7GF0qtxXVXBQFeNQ3etTDj+8hNhV3Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] platform/x86: intel_menlow: switch to use
 <linux/temperature.h> helpers
To:     Akinobu Mita <akinobu.mita@gmail.com>
Cc:     Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        linux-hwmon@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sujith Thomas <sujith.thomas@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Nov 28, 2019 at 4:55 PM Akinobu Mita <akinobu.mita@gmail.com> wrote:
>
> This switches the intel_menlow driver to use deci_kelvin_to_celsius() and
> celsius_to_deci_kelvin() in <linux/temperature.h> instead of helpers in
> <linux/thermal.h>.
>
> This is preparation for centralizing the kelvin to/from Celsius conversion
> helpers in <linux/temperature.h>.
>
> This also removes a trailing space, while we're at it.
>

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Cc: Sujith Thomas <sujith.thomas@intel.com>
> Cc: Darren Hart <dvhart@infradead.org>
> Cc: Andy Shevchenko <andy@infradead.org>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Amit Kucheria <amit.kucheria@verdurent.com>
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Keith Busch <kbusch@kernel.org>
> Cc: Jens Axboe <axboe@fb.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> ---
> * v2
> - include <linux/temperature.h> explicitly from thermal drivers
> - fix s/temprature/temperature/ typo in commit log
> - don't mix up another fix (format string for cellsius value)
>
>  drivers/platform/x86/intel_menlow.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/platform/x86/intel_menlow.c b/drivers/platform/x86/intel_menlow.c
> index b102f6d..12c1094 100644
> --- a/drivers/platform/x86/intel_menlow.c
> +++ b/drivers/platform/x86/intel_menlow.c
> @@ -20,6 +20,7 @@
>  #include <linux/pci.h>
>  #include <linux/pm.h>
>  #include <linux/slab.h>
> +#include <linux/temperature.h>
>  #include <linux/thermal.h>
>  #include <linux/types.h>
>
> @@ -302,8 +303,10 @@ static ssize_t aux_show(struct device *dev, struct device_attribute *dev_attr,
>         int result;
>
>         result = sensor_get_auxtrip(attr->handle, idx, &value);
> +       if (result)
> +               return result;
>
> -       return result ? result : sprintf(buf, "%lu", DECI_KELVIN_TO_CELSIUS(value));
> +       return sprintf(buf, "%lu", deci_kelvin_to_celsius(value));
>  }
>
>  static ssize_t aux0_show(struct device *dev,
> @@ -332,8 +335,8 @@ static ssize_t aux_store(struct device *dev, struct device_attribute *dev_attr,
>         if (value < 0)
>                 return -EINVAL;
>
> -       result = sensor_set_auxtrip(attr->handle, idx,
> -                                   CELSIUS_TO_DECI_KELVIN(value));
> +       result = sensor_set_auxtrip(attr->handle, idx,
> +                                   celsius_to_deci_kelvin(value));
>         return result ? result : count;
>  }
>
> --
> 2.7.4
>


-- 
With Best Regards,
Andy Shevchenko
