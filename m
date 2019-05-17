Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B45D221C50
	for <lists+linux-pm@lfdr.de>; Fri, 17 May 2019 19:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbfEQRUG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 May 2019 13:20:06 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:51323 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfEQRUG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 May 2019 13:20:06 -0400
Received: by mail-it1-f196.google.com with SMTP id m3so9390802itl.1;
        Fri, 17 May 2019 10:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qrLPWyXtnI2gfzaw9iUqYTDRhEhLKXZoqwNA1fL2LAQ=;
        b=PVLNgjcKPNwuCYgyauLWAWQrbFXd/kKCQoF0bXX5cMltLR7fks84XgVP9aZZbfishf
         qA1LlwrEEXBuZPwQvyocwKzNmRInN+wqQOWAWuG+YIki49m7RHhvCA+F8PBQgKPenhI2
         qPJ4eUvcWlE6HJ4q0j9W001nsUtte7prJuBZTU1nlQRKwKBlE4odUnnKHBmhRkJLf0ZB
         l8CYE6vPxhKetIqu7wPGSDrsBoDVinT/sCwDVzrVrhKIND4nJvNzgjJTMAmkFZdcfHYh
         DIDYAwoZNktDZOAkxRSjcQXkVdiXsZuMSJpjBC882SGpOYDSiZRVl5I32G0xTmBpsrE0
         fzAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qrLPWyXtnI2gfzaw9iUqYTDRhEhLKXZoqwNA1fL2LAQ=;
        b=smMInCgU/7JAPXW9Dx+F2nUCuFzdbBITaSOJ2JRQ/WP0SAR4XhdyHQwg1lV1ep20kU
         PpFKwddB80De89DkOiid+mPCafw69s/du0m6FvJ++QrqlZSpnmVB+dnWThEQUVr/UQbk
         d97pu+OboFAhdpsvGyOLJ4FMxCUvTGqlyVyfEMUB+2Ew1M8dqiuV2EQuUZnAXFSTvAfe
         KPzPa/aqZIed+BZzNhULBvlbgFjxbv1QLR02irpPEz5Kg/e88RRNopaugjhnbc7tgU2O
         qkkBu3LbA1vxOlEsuOxSIFV8wAf3NW4ET/Sf558u4fa6qJ4IQ7UNn1KLl8YILvP9u5d2
         Jeng==
X-Gm-Message-State: APjAAAVNbLAWt8QfZo543aaY0AzL5ibSj8fYq34waoYLNBcHoHvUn9hM
        JV83mbSyOHSnaxnjgvQSmA+TiV3BbdZN6uyfCik=
X-Google-Smtp-Source: APXvYqy9MqNMwuRaX+ELq5rB4d1R7KQAB9+kT1JeKI6HQFvZCY3iw6/M+suGjbSFqWtAaTTx+zCY9kBtBlyqxKMmsos=
X-Received: by 2002:a05:660c:7cd:: with SMTP id e13mr12523632itl.40.1558113605643;
 Fri, 17 May 2019 10:20:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190512082614.9045-1-tiny.windzz@gmail.com> <20190512082614.9045-3-tiny.windzz@gmail.com>
 <20190512133930.t5txssl7mou2gljt@flea> <20190512214128.qjyys3vfpwdiacib@core.my.home>
 <20190516150252.hf4u3bloo37chy6q@flea> <CAEExFWu-T2mGQ9Teo7TQOcJsEzXi_dB=S8CFv7MiwHyu5z4-ow@mail.gmail.com>
 <20190517073151.mz6hcmzubk7iqfre@flea>
In-Reply-To: <20190517073151.mz6hcmzubk7iqfre@flea>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Sat, 18 May 2019 01:19:54 +0800
Message-ID: <CAEExFWtban8Fjw6aZ5gdeC2GNk1vdqFoaJB_o-JtYZ_z70AJcQ@mail.gmail.com>
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

On Fri, May 17, 2019 at 3:32 PM Maxime Ripard <maxime.ripard@bootlin.com> w=
rote:
>
> On Fri, May 17, 2019 at 02:10:47AM +0800, Frank Lee wrote:
> > > On Sun, May 12, 2019 at 11:41:28PM +0200, Ond=C5=99ej Jirman wrote:
> > > > > > +static int tsens_get_temp(void *data, int *temp)
> > > > > > +{
> > > > > > + struct tsensor *s =3D data;
> > > > > > + struct tsens_device *tmdev =3D s->tmdev;
> > > > > > + int val;
> > > > > > +
> > > > > > + regmap_read(tmdev->regmap, tmdev->chip->temp_data_base +
> > > > > > +             0x4 * s->id, &val);
> > > > > > +
> > > > > > + if (unlikely(val =3D=3D 0))
> > > > > > +         return -EBUSY;
> > > > >
> > > > > I'm not sure why a val equals to 0 would be associated with EBUSY=
?
> > > >
> > > > Thermal zone driver can (will) call get_temp before we got the
> > > > first interrupt and the thermal data. In that case val will be 0.
> > > >
> > > > Resulting in:
> > > >
> > > >  (val + offset) * scale =3D (-2794) * -67 =3D 187198
> > > >
> > > > 187=C2=B0C and immediate shutdown during boot - based on cirtical
> > > > temperature being reached.
> > > >
> > > > Busy here means, get_temp does not yet have data. Thermal zone
> > > > driver just reports any error to dmesg output.
> > >
> > > Ah, that makes sense.
> > >
> > > I guess if we're switching to an interrupt-based driver, then we can
> > > just use a waitqueue, or is get_temp supposed to be atomic?
> >
> > I think get_temp should not be bloacked.
>
> Why not?

Maybe, I am wrong. I also want to know if we should do this.

Yangtao

>
> Maxime
>
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
