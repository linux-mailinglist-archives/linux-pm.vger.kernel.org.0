Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D316B1093E8
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2019 20:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbfKYTFN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Nov 2019 14:05:13 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:41409 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfKYTFN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Nov 2019 14:05:13 -0500
Received: by mail-pj1-f65.google.com with SMTP id gc1so7014692pjb.8;
        Mon, 25 Nov 2019 11:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=P19DovHn3w/+n6hilY5zf6aVHKgMGVjkSijfGR+10vI=;
        b=SJO2LxWfQL/RpUPwjCS4HFD6Zi0CFuImYwngKnX2+isiSOQFMhpKZ9dY7m7ErmqtG4
         u8Ew0Quvr1Acigrzp5DqDA33h/fhbBej0bLLtoOm5gDL6ZBBDzASZkK57S4r97WCAUXv
         1kdCIwBr+MtYS4zQmwDjV39T7kR7KNCkvSsrsqnGn/RZtQGEgxclKTjXLcVc0+QlBA8/
         f2OJbsWGWbWcMTTgc86WqTPtoGq/x3aRQUZUATAjf061M9A4fWfzPoEwYDbAmVPYwZZh
         hdK+LgsacNAMnrFVgGKN0l0g8z5n1Wqe46FZrR+84JSKZupFL3Pm9iu8TlcA8gX7ZayR
         lA4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=P19DovHn3w/+n6hilY5zf6aVHKgMGVjkSijfGR+10vI=;
        b=MR47lk1i4lW65AGRT2ggZAn+1T/pdIFruBF3ujWigXHgnsRpqCaxwEj4dK2bednCt4
         vUCIUsUr6LP10F44lzhHh7MeVMftlJdv32NiNPihMzYF1d/Z4lOpKnO06Y8SL7DyHuST
         Di4N8VlHfJiTOsJJOb2NSLB+hH5zkTpWZyZ94KmvYt9pMFkEXu9NLNlspK4e7xDBECvf
         19cVVV0kdpilyS1DwOYL8KzFdZVZI0MEX+m8fYc/Lq/QNfsOTgFwFDdwLYof05DXoOtz
         5BUdPkZ8xc50uYMgK8LrXtP/JnleWd2oBZ3GX+lWx4gjP0b0n39D/q/4OF3HXgkvI0sI
         5D3w==
X-Gm-Message-State: APjAAAUfQYB2k/hin0I8UB/Xv5Jpy/4lW5M0mWJNjpSmgT14B9EparY6
        IRHXV2/ZaIBEKKLqgHIgn1/s6ALNdYf7uju9lew=
X-Google-Smtp-Source: APXvYqzb9QDOJ3vCeMWuto+UJ4Y/4ebOOkTH+Cb5IJCRGIdMR80O9owbytFNwFLnJBA3iU/X2miKDbF+Jt3xD0q+HaQ=
X-Received: by 2002:a17:902:bb84:: with SMTP id m4mr29810736pls.255.1574708710742;
 Mon, 25 Nov 2019 11:05:10 -0800 (PST)
MIME-Version: 1.0
References: <1574604530-9024-1-git-send-email-akinobu.mita@gmail.com>
 <1574604530-9024-2-git-send-email-akinobu.mita@gmail.com> <CAHp75VfGt59F5YbEjctvOm00g+Pws+1jYgVbNLnUE3kq3SZi-A@mail.gmail.com>
 <CAC5umyjzDODZf8ECWDmR6SAY-TNkdJ+a0GZRgOFcPCAMok2Ddg@mail.gmail.com>
In-Reply-To: <CAC5umyjzDODZf8ECWDmR6SAY-TNkdJ+a0GZRgOFcPCAMok2Ddg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 25 Nov 2019 21:05:00 +0200
Message-ID: <CAHp75VdXUKLrnPEnga7An7BnCoGac=XxgWESWyV-ShmK_xiD4g@mail.gmail.com>
Subject: Re: [PATCH 1/8] add header file for kelvin to/from Celsius conversion helpers
To:     Akinobu Mita <akinobu.mita@gmail.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>
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
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Nov 25, 2019 at 4:30 PM Akinobu Mita <akinobu.mita@gmail.com> wrote=
:
> 2019=E5=B9=B411=E6=9C=8824=E6=97=A5(=E6=97=A5) 23:57 Andy Shevchenko <and=
y.shevchenko@gmail.com>:
> > On Sun, Nov 24, 2019 at 4:09 PM Akinobu Mita <akinobu.mita@gmail.com> w=
rote:

> > >  include/linux/thermal.h     |  1 +

> > > --- a/include/linux/thermal.h
> > > +++ b/include/linux/thermal.h
> > > @@ -14,6 +14,7 @@
> > >  #include <linux/idr.h>
> > >  #include <linux/device.h>
> > >  #include <linux/sysfs.h>
> > > +#include <linux/temperature.h>
> > >  #include <linux/workqueue.h>
> > >  #include <uapi/linux/thermal.h>
> >
> > I don't see any users of it. Why did you include?
>
> The rest of this patch series starts using it.
>
> I decided to include <linux/temperature.h> from <linux/thermal.h> because
> the existing <linux/thermal.h> provides the conversion helpers.
>
> However, not all of the thermal drivers require these conversion helpers,
> so we can change to include <linux/temperature.h> from each thermal drive=
r
> instead of including it from <linux/thermal.h>.
>
> Which way do you prefer?

I think users should include new header explicitly.

--=20
With Best Regards,
Andy Shevchenko
