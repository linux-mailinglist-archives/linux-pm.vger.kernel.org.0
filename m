Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC603108FF3
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2019 15:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbfKYOaM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Nov 2019 09:30:12 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35462 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727666AbfKYOaL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Nov 2019 09:30:11 -0500
Received: by mail-lf1-f65.google.com with SMTP id r15so8260115lff.2;
        Mon, 25 Nov 2019 06:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LKjdexg+LkffG26VUSsNwV+tvqoIqAg7PNu5vMgemIs=;
        b=uZG2o2nYUojcIlyWe8PXU+6To4lKeOe9RblB9GWLBDHP0ROIwlChkyw0SKs6JtiR1f
         MD2l3RucqTGhVbOhYG1uBeE6ZOOh5kvcDBIIW2cMvMhIgT707IS2IweaA8uIIlMxwob4
         DAmhCFqI+PYiMm5hgaQ7NH9ImizHriobDG60zsBWOlJpMTIMpk23p6obVPnKF8D9Jd0w
         Msd9NGRiv37kIRGnA1gDRLcvLDRdl8ucZ9K+rextcluWC7tAWJIYhcuQ2TuAL99qtP0E
         /KglPy0CcvOGFbyFrFpEgQV034Asp79um1Jn3oKBEstlAvZsFeBNDmVdfz7fqdwJAI4u
         0TmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LKjdexg+LkffG26VUSsNwV+tvqoIqAg7PNu5vMgemIs=;
        b=RoS16EbS50y/ne2DmgxUQVEN0ydRLE8a6cXHUyxZkBYcloZjPLBAuukm4x5iPZPtce
         d8J8Vi+QD63zRueElYp8h8R1VBBlxMnvBZx63awClZcb7rkm59s29C3Udg6vEyInlWgC
         HZ6G8eSjxf/SvWaCBupu2R9L1l1OL1Hk5Mzjwr637NBQCCogs2XXFnqX0IDpI5KV+X9/
         spCt1pvERl03jNp/CpZP7FAVcn8sY2VNbJrtlUQSC+9xhsFoer7GhCe/nKdejYqQGrRJ
         BsvXn/A4dIgj0II0/i4OLcE6A2ByBaOir4f3f8odk/korGZUK/YvecnKzvVmLK979SDc
         cLXg==
X-Gm-Message-State: APjAAAWDIuOS2JHT/+lM/EUteBcFkU5iXTQ1nl3psDHo5Zfu3mn2tDCY
        B12axCioLVDBu3duMqrm7WDOA4sKq44BokgP1TU=
X-Google-Smtp-Source: APXvYqwNQ1gDP49zPYN8njc+j07Y/QD6fHpbzABV0vcBHhUVmveHtPabf233H4srJ1klzQkQ15yydwmm2QnzFdfBd1w=
X-Received: by 2002:ac2:428d:: with SMTP id m13mr14985341lfh.64.1574692208081;
 Mon, 25 Nov 2019 06:30:08 -0800 (PST)
MIME-Version: 1.0
References: <1574604530-9024-1-git-send-email-akinobu.mita@gmail.com>
 <1574604530-9024-2-git-send-email-akinobu.mita@gmail.com> <CAHp75VfGt59F5YbEjctvOm00g+Pws+1jYgVbNLnUE3kq3SZi-A@mail.gmail.com>
In-Reply-To: <CAHp75VfGt59F5YbEjctvOm00g+Pws+1jYgVbNLnUE3kq3SZi-A@mail.gmail.com>
From:   Akinobu Mita <akinobu.mita@gmail.com>
Date:   Mon, 25 Nov 2019 23:29:56 +0900
Message-ID: <CAC5umyjzDODZf8ECWDmR6SAY-TNkdJ+a0GZRgOFcPCAMok2Ddg@mail.gmail.com>
Subject: Re: [PATCH 1/8] add header file for kelvin to/from Celsius conversion helpers
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

2019=E5=B9=B411=E6=9C=8824=E6=97=A5(=E6=97=A5) 23:57 Andy Shevchenko <andy.=
shevchenko@gmail.com>:
>
> On Sun, Nov 24, 2019 at 4:09 PM Akinobu Mita <akinobu.mita@gmail.com> wro=
te:
> >
> > There are several helper macros to convert kelvin to/from Celsius in
> > <linux/thermal.h> for thermal drivers.  These are useful for any other
> > drivers or subsystems, but it's odd to include <linux/thermal.h> just f=
or
> > the helpers.
> >
> > This adds a new <linux/temperature.h> that provides the equivalent inli=
ne
> > functions for any drivers or subsystems.  It is intended to replace the
> > helpers in <linux/thermal.h>.
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
> >  include/linux/temperature.h | 39 +++++++++++++++++++++++++++++++++++++=
++
>
> >  include/linux/thermal.h     |  1 +
>
>
> > --- a/include/linux/thermal.h
> > +++ b/include/linux/thermal.h
> > @@ -14,6 +14,7 @@
> >  #include <linux/idr.h>
> >  #include <linux/device.h>
> >  #include <linux/sysfs.h>
> > +#include <linux/temperature.h>
> >  #include <linux/workqueue.h>
> >  #include <uapi/linux/thermal.h>
>
> I don't see any users of it. Why did you include?

The rest of this patch series starts using it.

I decided to include <linux/temperature.h> from <linux/thermal.h> because
the existing <linux/thermal.h> provides the conversion helpers.

However, not all of the thermal drivers require these conversion helpers,
so we can change to include <linux/temperature.h> from each thermal driver
instead of including it from <linux/thermal.h>.

Which way do you prefer?
