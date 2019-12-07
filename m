Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6EB115D62
	for <lists+linux-pm@lfdr.de>; Sat,  7 Dec 2019 16:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfLGP5n (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 7 Dec 2019 10:57:43 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37973 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbfLGP5n (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 7 Dec 2019 10:57:43 -0500
Received: by mail-lf1-f68.google.com with SMTP id r14so7540375lfm.5;
        Sat, 07 Dec 2019 07:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Je89gn9Q33N1bQFYrGaEqfD0jxx0/nSksznx2FYdLRo=;
        b=kfxCaGz3BFFjxhySlBbB1rX7RnA+phJJ7Rlwo401EHiOvqjh8Rrl9zgB6A/5jITfiw
         JIDFTET279F+3PbIOotOjoFTaAcpj/Zsdq3YhKa0NcfVWjCQn4Wudd6BzkMHwMrua6MX
         RDMDHP0cp/QKJjtmKZWzfNU8DNYOqavLfHnp7VRL4Sh4wzxUjWmAAGOkapb1AQmzSF8u
         fO8hWbT117wrhI5jFPTTV1oMunDO6PTjFB2YhnlXd56A9YKeS89TT5twl6onaf531CuO
         F1GwfKiq4i3Slxfy7ZxUfxCAqdMgp8BpMWyreOA8DLFznEJnhJR6afmfmJ974Av40PSM
         aYAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Je89gn9Q33N1bQFYrGaEqfD0jxx0/nSksznx2FYdLRo=;
        b=dv/KpUTm4jboGKCMzZCePl/O90jyz8a3rVaHRwag1ArzV04cwRyGn3exArSw0i4MUA
         b1Lro8ZNUGQCF6Ul8P4pCEu0K0gKLq0DlQIuBup4/YsXSdtKGufWRwkkwqGYv0lxz4Xy
         S7xwZHzHOmZobVlMVzfOlNUloorrJaE5lepbgusVhp7CEQTDM9YWnGDjmRSMAgnJrXMG
         pTl5QB7Fyn0Yyjht3iP3Tf3f2EpoHbISH8LJPQUY/iiZHSBYdC0jqkFYBirH47FKIUdZ
         ddSxDS3bV777Wsj2gSS6jIWzJrMYB0B7hOPRrswVuBBOu042CUgy7VjOwHFE5hfNz9SX
         eIYg==
X-Gm-Message-State: APjAAAVaIuEcVlQmetkrv/8tR0MW6qP/hcLa8v8O+iTQHCBDTaYae9pW
        Ufabs9/BFMkenZ5QzvzG12prMYdsfNJv09Cs6CU=
X-Google-Smtp-Source: APXvYqxsWOaKlGm5uRNPyXWJqzOcQQ+4DK7/As8ZTt5LTrrPFjXpZV9Yojk2f9aZg/lfYutTMjnq2W8ffejEbamHl3A=
X-Received: by 2002:a05:6512:75:: with SMTP id i21mr10706021lfo.98.1575734260036;
 Sat, 07 Dec 2019 07:57:40 -0800 (PST)
MIME-Version: 1.0
References: <1574952879-7200-1-git-send-email-akinobu.mita@gmail.com>
 <1574952879-7200-2-git-send-email-akinobu.mita@gmail.com> <5f85f65c-78b6-0b63-f975-a216f9823985@linaro.org>
In-Reply-To: <5f85f65c-78b6-0b63-f975-a216f9823985@linaro.org>
From:   Akinobu Mita <akinobu.mita@gmail.com>
Date:   Sun, 8 Dec 2019 00:57:28 +0900
Message-ID: <CAC5umyg3J98ntrezxskdKTgdP-WsL9VjtzHpXxyxGxTZxcaQ8A@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] add header file for kelvin to/from Celsius
 conversion helpers
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        linux-hwmon@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sujith Thomas <sujith.thomas@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Zhang Rui <rui.zhang@intel.com>,
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

2019=E5=B9=B412=E6=9C=887=E6=97=A5(=E5=9C=9F) 1:49 Daniel Lezcano <daniel.l=
ezcano@linaro.org>:
>
> On 28/11/2019 15:54, Akinobu Mita wrote:
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
> > * v2
> > - add deci_kelvin_to_millicelsius_with_offset() in linux/temperature.h
> > - stop including linux/temperature.h from linux/thermal.h
> >
> >  include/linux/temperature.h | 51 +++++++++++++++++++++++++++++++++++++=
++++++++
> >  1 file changed, 51 insertions(+)
> >  create mode 100644 include/linux/temperature.h
> >
> > diff --git a/include/linux/temperature.h b/include/linux/temperature.h
> > new file mode 100644
> > index 0000000..679e70a
> > --- /dev/null
> > +++ b/include/linux/temperature.h
> > @@ -0,0 +1,51 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef _LINUX_TEMPERATURE_H
> > +#define _LINUX_TEMPERATURE_H
>
> It sounds strange to create a temperature file just for a few conversion
> functions. Why not create an units.h file, so some more conversions
> could be added later (not necessarily related to temperature) ?

Fine with me.

> > +#include <linux/kernel.h>
> > +
> > +#define ABSOLUTE_ZERO_MILLICELSIUS -273150
> > +
> > +static inline long kelvin_to_millicelsius(long t)
>
> Why 'long' ?

There's no specific reason, but the existing DECI_KELVIN_TO_CELSIUS() in
linux/thermal.h converts to 'long'.

Do you prefer changing 'long' to 'int'?

> > +{
> > +     return t * 1000 + ABSOLUTE_ZERO_MILLICELSIUS;
> > +}
> > +
> > +static inline long millicelsius_to_kelvin(long t)
> > +{
> > +     return DIV_ROUND_CLOSEST(t - ABSOLUTE_ZERO_MILLICELSIUS, 1000);
>
> Please don't duplicate these operations, just do the conversion to the
> right unit and then call a single function.
>
> Replace the constant by macros like what we find in time64.h.
>
> eg.
> #define MILLICELSIUS_PER_CELCIUS 1000

How about this?

#define ABSOLUTE_ZERO_MILLICELSIUS -273150

static inline long milli_kelvin_to_millicelsius(long t)
{
        return t + ABSOLUTE_ZERO_MILLICELSIUS;
}

static inline long millicelsius_to_milli_kelvin(long t)
{
        return t - ABSOLUTE_ZERO_MILLICELSIUS;
}

#define MILLIDEGREE_PER_DEGREE 1000
#define MILLIDEGREE_PER_DECIDEGREE 100

static inline long kelvin_to_millicelsius(long t)
{
        return milli_kelvin_to_millicelsius(t * MILLIDEGREE_PER_DEGREE);
}

static inline long millicelsius_to_kelvin(long t)
{
        t =3D millicelsius_to_milli_kelvin(t);

        return DIV_ROUND_CLOSEST(t, MILLIDEGREE_PER_DEGREE);
}

static inline long deci_kelvin_to_celsius(long t)
{
        t =3D milli_kelvin_to_millicelsius(t * MILLIDEGREE_PER_DECIDEGREE);

        return DIV_ROUND_CLOSEST(t, MILLIDEGREE_PER_DEGREE);
}

static inline long celsius_to_deci_kelvin(long t)
{
        t =3D millicelsius_to_milli_kelvin(t * MILLIDEGREE_PER_DEGREE);

        return DIV_ROUND_CLOSEST(t, MILLIDEGREE_PER_DECIDEGREE);
}

/**
 * deci_kelvin_to_millicelsius_with_offset - convert Kelvin to Celsius
 * @t: temperature value in decidegrees Kelvin
 * @offset: difference between Kelvin and Celsius in millidegrees
 *
 * Return: temperature value in millidegrees Celsius
 */
static inline long deci_kelvin_to_millicelsius_with_offset(long t, long off=
set)
{
        return t * MILLIDEGREE_PER_DECIDEGREE - offset;
}

static inline long deci_kelvin_to_millicelsius(long t)
{
        return milli_kelvin_to_millicelsius(t * MILLIDEGREE_PER_DECIDEGREE)=
;
}

static inline long millicelsius_to_deci_kelvin(long t)
{
        t =3D millicelsius_to_milli_kelvin(t);

        return DIV_ROUND_CLOSEST(t, MILLIDEGREE_PER_DECIDEGREE);
}

> So you can really do the cleanup in all the drivers, like removing:

OK.  I'll try as much as possible.
