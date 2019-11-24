Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1DE21084D2
	for <lists+linux-pm@lfdr.de>; Sun, 24 Nov 2019 20:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfKXTyi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 24 Nov 2019 14:54:38 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36942 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbfKXTyi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 24 Nov 2019 14:54:38 -0500
Received: by mail-pg1-f196.google.com with SMTP id b10so5969681pgd.4;
        Sun, 24 Nov 2019 11:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xgxN+slUElCQpDuU8fsY3BZMJxer4zKWxWFoQzMGtA4=;
        b=N9k+kyqVqvVAuU5pmVcD05y0P7ep7fkeAyzpfnA8hS2146dGHNMBjSFR9uiJV8PHu0
         9aJTs33ZWmukHbhGxkM9JoSH+maOgpdQdyDSpGppnHZX79oYQ1DMEBvvya80yKdDrCRn
         UAhC+xeK8nbxYIHlDlIctzaYwHAhcTTcuw140chiI8mR8MQJetOiFzuSlX+qXYuNjuPC
         ALXFb25TaINXA4BSo6hqgC/27e33SJxaQdfegL7mzSgjFC+vMNyCowgMcV3yJvVEhnK/
         XomI1mA4ZMdgY4R282CGbCovH0hL0rqqQ49vvktIoDg5pRbcoXH8+heiUYIo3ezzqGn8
         h4QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xgxN+slUElCQpDuU8fsY3BZMJxer4zKWxWFoQzMGtA4=;
        b=IhwXRKubOganLFxgcRgjm6iIMRqHslwtRSlBMIdKPCphg8ZBt83RYS7tySIfi99QkL
         KXW6z+79ICJyEV0hllHhe/4PFPISJh1K9Ccboy/NYO7MaCLV+HubkDdK1J+cTExCcJfo
         YsyhEtPJIEP9MxgSHtYyeQP9wbIc4t93O+heiTWUycUrFoIlmX0G2h2hvCoRz6BGYfRL
         knpW/IhjUrRGBNKCNyRoRknnGPhg/YJ4J2DpcoFJUqkD/krJGrEmevK8ggW8aP+qxuC2
         DauNkxCeeikw801tve/WEEc6fFPFUH8b9U+322Bn3uXM8fCcUwuK0NzV/eqr/ZEHs58M
         I3xg==
X-Gm-Message-State: APjAAAWusOhB2ONbj02EtfKuklYtSDk2kCpm+LEhKmusvflmXtFATqm4
        A04VjrhfHe1KZ1rY2Vp0BzWCuwLPFyA9kAM4Szs=
X-Google-Smtp-Source: APXvYqynJhSAT+cBLFOG35mXdSu5donpoINx1X4oii7KCRStNIR2N5Cf8Hh5JzERBkyy6grUixES2mbAfr5mZU7d3zM=
X-Received: by 2002:a62:168f:: with SMTP id 137mr31383941pfw.151.1574625277865;
 Sun, 24 Nov 2019 11:54:37 -0800 (PST)
MIME-Version: 1.0
References: <1574604530-9024-1-git-send-email-akinobu.mita@gmail.com> <1574604530-9024-4-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1574604530-9024-4-git-send-email-akinobu.mita@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 24 Nov 2019 21:54:26 +0200
Message-ID: <CAHp75VdkhFJZ71FS+DhrKTDPEW7Z-6imRSePm8EhgGF2sgTThg@mail.gmail.com>
Subject: Re: [PATCH 3/8] platform/x86: asus-wmi: switch to use
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
> The asus-wmi driver doesn't implement the thermal device functionality
> directly, so including <linux/thermal.h> just for DECI_KELVIN_TO_CELSIUS()
> is a bit odd.
>
> This switches the asus-wmi driver to use deci_kelvin_to_millicelsius() in
> <linux/temperature.h>.
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
>  drivers/platform/x86/asus-wmi.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index 821b08e..6a1a2f9 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -33,7 +33,7 @@
>  #include <linux/seq_file.h>
>  #include <linux/platform_data/x86/asus-wmi.h>
>  #include <linux/platform_device.h>
> -#include <linux/thermal.h>
> +#include <linux/temperature.h>
>  #include <linux/acpi.h>
>  #include <linux/dmi.h>
>
> @@ -1512,9 +1512,8 @@ static ssize_t asus_hwmon_temp1(struct device *dev,
>         if (err < 0)
>                 return err;
>
> -       value = DECI_KELVIN_TO_CELSIUS((value & 0xFFFF)) * 1000;
> -
> -       return sprintf(buf, "%d\n", value);

> +       return sprintf(buf, "%ld\n",
> +                      deci_kelvin_to_millicelsius(value & 0xFFFF));

Leave it in one line.

With above,
Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>

>  }
>
>  /* Fan1 */
> --
> 2.7.4
>


-- 
With Best Regards,
Andy Shevchenko
