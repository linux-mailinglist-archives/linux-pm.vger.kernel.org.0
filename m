Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD0AD1084D7
	for <lists+linux-pm@lfdr.de>; Sun, 24 Nov 2019 20:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfKXT6B (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 24 Nov 2019 14:58:01 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44753 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbfKXT6B (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 24 Nov 2019 14:58:01 -0500
Received: by mail-pg1-f193.google.com with SMTP id e6so5952524pgi.11;
        Sun, 24 Nov 2019 11:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dkRSUp4LWvNPm+vfZgEiYDvglJm3beCRxL71deUAo/A=;
        b=QOscabZbSDR/sllFcuyMh2fWkaut3t5bOuY0nM8nOMKiyZG47JOoS081/sEHP6TiSj
         uGU32SMvZMtWe7va8tydQDaKyPTujE/Uyyg2LN5+d6IkKB5zwwzTWFwIQXzl7vDR53ov
         qMpnw6eDrkP0065xCLc0cF8tbAz8CZympuICLaAj16lD1w8IYzBxaS9CqyvEvAY1LITb
         A4/c1jqiNY62vbqQdyjhHiY02iU7tjNwKnEe0xffiquj+SOzSW0R0tDQxzr4TZf36xb9
         BTdBTQgr4qL+qn6RAGZ3KS8xnq3EnmUYHcuAv8yiowvBPu+SZ53MJQanBy0DM/sw+3u3
         Fhlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dkRSUp4LWvNPm+vfZgEiYDvglJm3beCRxL71deUAo/A=;
        b=UKuhZpfvISuyU9zZY07CLkqh+sP+CjzyGpohiyi2duvGfSGjY4VfH8GoApdGZ3cdvA
         y+DO2PP4CRGmZ4DaOo4BCDIgaLqpwyxuLoJ1wPUpv9ffXAeQHYvccV7Xf2X7lDTYldHM
         +g2HkMqJUSxGDUit1cG4JYAYy6X74KUtHDu/RLjknkARKhUIZJ5ujbKSGRtLB+IW8V7a
         Iul3MvSyIbYm8QjKAILtlwTT/dp3whIUwVgctDN6pHU0pTTcY/v0eDydvzsW6YKqoLu/
         MqWwg5zNwixndUXaCDVsYfvJgl8NoG9ubq6tGR5Tzf47xPaYXTTF9kEZJsZcXKl+Ces8
         C8zQ==
X-Gm-Message-State: APjAAAVFLzYpUdcTxxS6dQgujkjISDw2bffDyXZCfNl1f/anXIUKVazf
        GSpouErij0miFJf4PeasGdoE4/ALT98oalvc711V1RNT
X-Google-Smtp-Source: APXvYqzZWhn8q4bZQQp+nT7h6x2ELej7bYnsrWqD8H+1zhdVeihgLHB4jq7aMAZW914Rfqu8lIObgLw+MrjOOlyJyzk=
X-Received: by 2002:a65:6118:: with SMTP id z24mr29135288pgu.203.1574625480441;
 Sun, 24 Nov 2019 11:58:00 -0800 (PST)
MIME-Version: 1.0
References: <1574604530-9024-1-git-send-email-akinobu.mita@gmail.com> <1574604530-9024-5-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1574604530-9024-5-git-send-email-akinobu.mita@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 24 Nov 2019 21:57:49 +0200
Message-ID: <CAHp75VfOUiN_2bW+o-AqGmAY32mmdNxP54B2f2+gj0NTEr9FTQ@mail.gmail.com>
Subject: Re: [PATCH 4/8] platform/x86: intel_menlow: switch to use
 <linux/temperature.h> helpers
To:     Akinobu Mita <akinobu.mita@gmail.com>
Cc:     Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        linux-hwmon@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sujith Thomas <sujith.thomas@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
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

On Sun, Nov 24, 2019 at 4:09 PM Akinobu Mita <akinobu.mita@gmail.com> wrote:
>
> This switches the intel_menlow driver to use deci_kelvin_to_celsius() and
> celsius_to_deci_kelvin() in <linux/temperature.h> instead of helpers in
> <linux/thermal.h>.
>
> This is preparation for centralizing the kelvin to/from Celsius conversion
> helpers in <linux/temprature.h>.
>
> Cc: Sujith Thomas <sujith.thomas@intel.com>
> Cc: Darren Hart <dvhart@infradead.org>
> Cc: Andy Shevchenko <andy@infradead.org>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Eduardo Valentin <edubezval@gmail.com>
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
>  drivers/platform/x86/intel_menlow.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/platform/x86/intel_menlow.c b/drivers/platform/x86/intel_menlow.c
> index b102f6d..6313591 100644
> --- a/drivers/platform/x86/intel_menlow.c
> +++ b/drivers/platform/x86/intel_menlow.c
> @@ -302,8 +302,10 @@ static ssize_t aux_show(struct device *dev, struct device_attribute *dev_attr,
>         int result;
>
>         result = sensor_get_auxtrip(attr->handle, idx, &value);
> +       if (result)
> +               return result;
>
> -       return result ? result : sprintf(buf, "%lu", DECI_KELVIN_TO_CELSIUS(value));
> +       return sprintf(buf, "%ld", deci_kelvin_to_celsius(value));

Can you explain the change %lu to %ld?

>  }
>
>  static ssize_t aux0_show(struct device *dev,
> @@ -332,8 +334,8 @@ static ssize_t aux_store(struct device *dev, struct device_attribute *dev_attr,
>         if (value < 0)
>                 return -EINVAL;
>
> -       result = sensor_set_auxtrip(attr->handle, idx,
> -                                   CELSIUS_TO_DECI_KELVIN(value));

> +       result = sensor_set_auxtrip(attr->handle, idx,
> +                                   celsius_to_deci_kelvin(value));

How come the first line has been changed?

>         return result ? result : count;
>  }
>
> --
> 2.7.4
>


-- 
With Best Regards,
Andy Shevchenko
