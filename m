Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6CC20E72
	for <lists+linux-pm@lfdr.de>; Thu, 16 May 2019 20:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbfEPSK7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 May 2019 14:10:59 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36731 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbfEPSK7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 May 2019 14:10:59 -0400
Received: by mail-io1-f67.google.com with SMTP id e19so3366769iob.3;
        Thu, 16 May 2019 11:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rrGlTyg4XJrCjk7zo+Wrsd+XH074LHjGtQBQcTuoJf8=;
        b=e6Rkx2rEJlR6Pl2yJlIYa/FZ2zIzhZ5FqSoNux6pGC2cWT4VG3VtLz0dC5EFO+ax7A
         fnQ487yNANJ4O3ukMIjS/hevihf6hMlG7XZiS0NrWZO5kEc4q5O0oEVjmpxG0OZCY6V5
         jp53iKg3oyxCYy/xDgCqzVCQtwOz2SS08UbDDQU/grZbTGPJsiebIM3zJ/GlhCEaiUAD
         0TI/2THjAlSnQDJwcCVgMXgPh+COK2Et6tK9Rq4XMzIt/5XZz9bqaxvHyv/QiPi/sOdb
         IPh1Za3RIy24L4KLOQVCjvobjLNRpFwByWSFLzJLaNrUcxcQ0RPZ7WmYiqUvcLHgMkT8
         WOMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rrGlTyg4XJrCjk7zo+Wrsd+XH074LHjGtQBQcTuoJf8=;
        b=b+1CETYyolkvuNcOvAeSM/ERwzR+IYUzfIcrdeBa9L44MCZ49YVIWdaIUdnwSuP3sT
         ejOjWoO7TSsqXUnIHIBNqVF0/+Fu2BwnDA8YkPvkqS+dM2vXy5yE+aAcR9m6iI9zr9ab
         2KXephf6f98r1fhRFomLVec9O5+RJrFqdz/qHqzwC2XldissUEvdgMiPPY6E0Y7MMir5
         uUTxS2Qarj9I/UflDUBDaPqzZ4XTthHTRFm1serHD1vUFKdoNmjtAV/dF+xm9y729o+v
         O742vBFoltMwo56BdxB/Zh0op4zMBOuiSCgdCy0IqxJcmj1kuU2mFsgrOTen8n+fwJRD
         UWCw==
X-Gm-Message-State: APjAAAVKIB8rPAwhmAp+8gWn0TGA9tw4Jxq+USvzAZSXDgkeZvthEGnx
        /dooZa9WnR0shFXJBv9MBJpyUWPmnRgkI1t/0qQ=
X-Google-Smtp-Source: APXvYqyN7uANqDZJ6+qL41HrSGltOXSAYi6UW1Aa3IiAikG26LjBrhhWgLXP44A77oh8vNwx8s4k5mvjhxpuwUynad8=
X-Received: by 2002:a5d:9616:: with SMTP id w22mr1735164iol.40.1558030258541;
 Thu, 16 May 2019 11:10:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190512082614.9045-1-tiny.windzz@gmail.com> <20190512082614.9045-3-tiny.windzz@gmail.com>
 <20190512133930.t5txssl7mou2gljt@flea> <20190512214128.qjyys3vfpwdiacib@core.my.home>
 <20190516150252.hf4u3bloo37chy6q@flea>
In-Reply-To: <20190516150252.hf4u3bloo37chy6q@flea>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Fri, 17 May 2019 02:10:47 +0800
Message-ID: <CAEExFWu-T2mGQ9Teo7TQOcJsEzXi_dB=S8CFv7MiwHyu5z4-ow@mail.gmail.com>
Subject: Re: [PATCH 2/3] thermal: sun50i: add thermal driver for h6
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        catalin.marinas@arm.com, will.deacon@arm.com,
        bjorn.andersson@linaro.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        paulmck@linux.ibm.com, stefan.wahren@i2se.com,
        Linux PM <linux-pm@vger.kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Andy Gross <andy.gross@linaro.org>, rui.zhang@intel.com,
        devicetree@vger.kernel.org, marc.w.gonzalez@free.fr,
        Eduardo Valentin <edubezval@gmail.com>,
        enric.balletbo@collabora.com, robh+dt@kernel.org,
        Jonathan.Cameron@huawei.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        olof@lixom.net, David Miller <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, May 16, 2019 at 11:03 PM Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
>
> Hi,
>
> On Sun, May 12, 2019 at 11:41:28PM +0200, Ond=C5=99ej Jirman wrote:
> > > > +static int tsens_get_temp(void *data, int *temp)
> > > > +{
> > > > + struct tsensor *s =3D data;
> > > > + struct tsens_device *tmdev =3D s->tmdev;
> > > > + int val;
> > > > +
> > > > + regmap_read(tmdev->regmap, tmdev->chip->temp_data_base +
> > > > +             0x4 * s->id, &val);
> > > > +
> > > > + if (unlikely(val =3D=3D 0))
> > > > +         return -EBUSY;
> > >
> > > I'm not sure why a val equals to 0 would be associated with EBUSY?
> >
> > Thermal zone driver can (will) call get_temp before we got the
> > first interrupt and the thermal data. In that case val will be 0.
> >
> > Resulting in:
> >
> >  (val + offset) * scale =3D (-2794) * -67 =3D 187198
> >
> > 187=C2=B0C and immediate shutdown during boot - based on cirtical
> > temperature being reached.
> >
> > Busy here means, get_temp does not yet have data. Thermal zone
> > driver just reports any error to dmesg output.
>
> Ah, that makes sense.
>
> I guess if we're switching to an interrupt-based driver, then we can
> just use a waitqueue, or is get_temp supposed to be atomic?
I think get_temp should not be bloacked.

Yangtao
>
> Maxime
>
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
