Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5410B109002
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2019 15:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbfKYOcJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Nov 2019 09:32:09 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38762 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728026AbfKYOcJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Nov 2019 09:32:09 -0500
Received: by mail-lf1-f65.google.com with SMTP id q28so11198143lfa.5;
        Mon, 25 Nov 2019 06:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oGTTnKM0xwW7nj0x0MrfZUkr7TGce1cyBxrsce9fTz0=;
        b=kH6P1Kq2tBKFD4TQmcJWpSKJ6Hagdx11zVsv7mKgsiJXkYyHhoViKTtr3sadCGlZeL
         ehG6P1sCdCzZo3us3xttS17NdAC8JuBBBu2/iHQHjk8KzF1TRPEoa9TufBvSCutEj6SK
         DTxiSmYqOGBeDhSdnKY5GbiaPiWFTYTvf2gAf/wwtRybSNHMzyBBw40snnTXoxI4sRMI
         vzaeJsp/QYlJSyBYc4SrInm75e+vgf6lqgniLQF9GS50M7g9kv3GU6xrf0oHtXtlAHcb
         O1ZQEL9IRYyXdMr5mW0EVkKldcYv1mblryWchjlQGlCXJhYrUhbajFSRdHW0YGcxIxAf
         JO/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oGTTnKM0xwW7nj0x0MrfZUkr7TGce1cyBxrsce9fTz0=;
        b=TAKvXm2f8ClRCu3oINqkmY5SN4o7bZXxe+oma3oHX+CWHyywJuOThmtold3I6mcRC3
         OYhpy3orKQQf4jTlBJEigon1srR7j8UK3pGTHKK8yBqCh4u8yB1kdjGQuJyhfkNSj2da
         FQZ3ProgQzfopJC0hMQWjhriYQ2wPOp2tzTWO4C3swxbgyX5L1oTyiSfdqOLPgXfF7nI
         NGlTgpV8/rWKmuIQKyByNOFQ6WutR1i+ERF2jr4Ps0F0xSbYN6T6HdxEr01Faol2/hkR
         scjS4WVZ5zV+i8BS2YIYIBTQ18cNwMohL96BT+JqmR0j0f/Kh4iBABpmThvvS33hRtkR
         UJgA==
X-Gm-Message-State: APjAAAU9TNlSYbnhudW76ry/XoDIUGHLoFBTc16p1+W+SqB+DaL86ki6
        kP/kp8IpUuMpJK7BkaZYOqjlZ24k4g05Rxzf8IU=
X-Google-Smtp-Source: APXvYqxEZzHQPIyjGRJIRceOVV99/gHLbc042Znh/KAbP8bMgC3AKDkjIZgHKxBU2iKFp3ecyEUrHxfT37I88etCPEI=
X-Received: by 2002:ac2:41d8:: with SMTP id d24mr6024078lfi.98.1574692327003;
 Mon, 25 Nov 2019 06:32:07 -0800 (PST)
MIME-Version: 1.0
References: <1574604530-9024-1-git-send-email-akinobu.mita@gmail.com>
 <1574604530-9024-4-git-send-email-akinobu.mita@gmail.com> <CAHp75VdkhFJZ71FS+DhrKTDPEW7Z-6imRSePm8EhgGF2sgTThg@mail.gmail.com>
In-Reply-To: <CAHp75VdkhFJZ71FS+DhrKTDPEW7Z-6imRSePm8EhgGF2sgTThg@mail.gmail.com>
From:   Akinobu Mita <akinobu.mita@gmail.com>
Date:   Mon, 25 Nov 2019 23:31:55 +0900
Message-ID: <CAC5umygDcYNd396K=CO7wpfDbESo4Sc39oWjkqu_-hmYbb2R1Q@mail.gmail.com>
Subject: Re: [PATCH 3/8] platform/x86: asus-wmi: switch to use
 <linux/temperature.h> helpers
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
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
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

2019=E5=B9=B411=E6=9C=8825=E6=97=A5(=E6=9C=88) 4:54 Andy Shevchenko <andy.s=
hevchenko@gmail.com>:
>
> On Sun, Nov 24, 2019 at 4:09 PM Akinobu Mita <akinobu.mita@gmail.com> wro=
te:
> >
> > The asus-wmi driver doesn't implement the thermal device functionality
> > directly, so including <linux/thermal.h> just for DECI_KELVIN_TO_CELSIU=
S()
> > is a bit odd.
> >
> > This switches the asus-wmi driver to use deci_kelvin_to_millicelsius() =
in
> > <linux/temperature.h>.
> >
> > Cc: Sujith Thomas <sujith.thomas@intel.com>
> > Cc: Darren Hart <dvhart@infradead.org>
> > Cc: Andy Shevchenko <andy@infradead.org>
> > Cc: Zhang Rui <rui.zhang@intel.com>
> > Cc: Eduardo Valentin <edubezval@gmail.com>
> > Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Cc: Amit Kucheria <amit.kucheria@verdurent.com>
> > Cc: Jean Delvare <jdelvare@suse.com>
> > Cc: Guenter Roeck <linux@roeck-us.net>
> > Cc: Keith Busch <kbusch@kernel.org>
> > Cc: Jens Axboe <axboe@fb.com>
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Sagi Grimberg <sagi@grimberg.me>
> > Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> > ---
> >  drivers/platform/x86/asus-wmi.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asu=
s-wmi.c
> > index 821b08e..6a1a2f9 100644
> > --- a/drivers/platform/x86/asus-wmi.c
> > +++ b/drivers/platform/x86/asus-wmi.c
> > @@ -33,7 +33,7 @@
> >  #include <linux/seq_file.h>
> >  #include <linux/platform_data/x86/asus-wmi.h>
> >  #include <linux/platform_device.h>
> > -#include <linux/thermal.h>
> > +#include <linux/temperature.h>
> >  #include <linux/acpi.h>
> >  #include <linux/dmi.h>
> >
> > @@ -1512,9 +1512,8 @@ static ssize_t asus_hwmon_temp1(struct device *de=
v,
> >         if (err < 0)
> >                 return err;
> >
> > -       value =3D DECI_KELVIN_TO_CELSIUS((value & 0xFFFF)) * 1000;
> > -
> > -       return sprintf(buf, "%d\n", value);
>
> > +       return sprintf(buf, "%ld\n",
> > +                      deci_kelvin_to_millicelsius(value & 0xFFFF));
>
> Leave it in one line.

It causes this line over 80 characters.  Or do you prefer to save the
conversion result in 'value' temporarily as before?
