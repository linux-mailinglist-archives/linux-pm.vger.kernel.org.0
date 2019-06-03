Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3F2933306
	for <lists+linux-pm@lfdr.de>; Mon,  3 Jun 2019 17:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729229AbfFCPD0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 3 Jun 2019 11:03:26 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38555 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729038AbfFCPD0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Jun 2019 11:03:26 -0400
Received: by mail-pg1-f196.google.com with SMTP id v11so8442077pgl.5
        for <linux-pm@vger.kernel.org>; Mon, 03 Jun 2019 08:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zfKPWs9DI0gj2Gee5+3PZiBBkJ3QPhZ/MlK8qG7t904=;
        b=GQMXVW3eqZlFNIYcTpUyenkaeL/AqvKFQOclt3pDaDN2pdAcXOTNb3fhiradhdOZqM
         Z7/oGl61kpdkBp9vsHuiSYPddsgWQeXQE2dN4IP5SzHSjw8Fdh8VQ6DwSLItukWHpH1z
         xZ7yPWhOBODBZhkn5yf0igqNvhzaoTHI9XoI9D2oGJK5G4zXSaRfxiMkWfLKuuIiy+Wh
         Q8SuKcz96844AxRKshNWiJrIO2YQBVYlFo12CPwjfkaX3J65G3OB4SrJE1iAGoY9GGYo
         Fn9wQUqP53v6yC6HIKIkABJNYzNb/1+jbbv9LlNg5XNmhE9mrau6DNMfZbDipgpldwuj
         GEJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zfKPWs9DI0gj2Gee5+3PZiBBkJ3QPhZ/MlK8qG7t904=;
        b=jb7ynXtxzfN9lVw0ccmn7waetNkEC1nT+nz5J3Ddk0KiCS407qGV1E9b5oOIabJQAt
         wqirhAloOwrpxp7B+r58sVzalf96SMvNGXRGqn1ydQNwaIbBeX7rEaa0c0UApWouRGFZ
         ansZ1ycFdllAJ0sVts2SSrG9B3iODqmw3Cf7ckfdRe+iiEkk/JGvFa1w+q4GzihpBqOq
         u2NL63ot7FTB0okfXRSyo+b5pTDcw4AVkqa6oZJlyXJT//osobJaZuF2+xvR7dLcOnQl
         nBr3KJT1Muu1jnFKy5mp1dlWPc8tGIKHChaHE2/kPyCFEtq3OY6gNB1P6OKjsz46MwDX
         LMcw==
X-Gm-Message-State: APjAAAV2xhkpsfes1kXHlFiGOrpJIOkNr+4tlvi5Iqs+BuAgmhbgoEid
        Me/56CTlKSWCLUZhsfNqTHU6Io+VzNILYUuh8ls=
X-Google-Smtp-Source: APXvYqzS/9HGeFNjomQijw4zTeLo+dJcgruYgiXSm5a14L1rKgKFVhodIQ7rO36aJdp8vxPT82TkOd4pPhcIIzPWniY=
X-Received: by 2002:aa7:8b4d:: with SMTP id i13mr32545860pfd.233.1559574205796;
 Mon, 03 Jun 2019 08:03:25 -0700 (PDT)
MIME-Version: 1.0
References: <1558454649-28783-1-git-send-email-akinobu.mita@gmail.com>
 <1558454649-28783-3-git-send-email-akinobu.mita@gmail.com>
 <20190524023520.GC1936@localhost.localdomain> <CAC5umyhCHJrzSSEy3NF38BhRQ9FSjVr8YfjChN-_3pVR5QwXsA@mail.gmail.com>
 <20190603021821.GA8354@localhost.localdomain>
In-Reply-To: <20190603021821.GA8354@localhost.localdomain>
From:   Akinobu Mita <akinobu.mita@gmail.com>
Date:   Tue, 4 Jun 2019 00:03:14 +0900
Message-ID: <CAC5umygO0mKVJ5R4MhYTz44zVHvjkYSvrtT7=D1Rx2td-koeTQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] nvme: add thermal zone infrastructure
To:     Eduardo Valentin <edubezval@gmail.com>
Cc:     linux-nvme@lists.infradead.org, linux-pm@vger.kernel.org,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Kenneth Heitke <kenneth.heitke@intel.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

2019=E5=B9=B46=E6=9C=883=E6=97=A5(=E6=9C=88) 11:18 Eduardo Valentin <edubez=
val@gmail.com>:

> > > Do we have something more meaningful or descriptive here? A more
> > > interesting type would be a string that could remind of the sensor
> > > location. Unless nvme_temp0 is enough to understand where this
> > > temperature is coming from, I would ask to get something more
> > > descriptive.
> >
> > The SMART log page defines composite temperature and temperature sensor=
 1
> > through temperature sensor 8.  So I think nvme_temp1 to nvme_temp8 are
> > descriptive.  And I personally prefer 'nvme_temp0' rather than
> > 'nvme_composite_temp'.
>
> I was leaning towards something even more descriptive. nvme_temp0 means
> what? Usually we want something more meaningful, Is this a co-processor?
> Is this a disk? what exactly nvme_temp0 really represents?

It's vendor specific. The NVMe spec only says a controller reports the
composite temperature and temperature sensor 1 through 8.
It doesn't define which part of the device (CPUs, DRAM, NAND, or else)
should implement temperature sensors and how the composite temperature is
calculated from implemented sensors.

I have three NVMe devices from different vendors.

The device A provides only composite temperature.

The device B provides composite temperature and temperature sensor 1.
Both temperatures are always same.

The device C provides the composite temperature and temperature sensor 1,
2, and 5.  For example, the smart log reports
Composite temperature : 43 C
Temperature Sensor 1  : 45 C
Temperature Sensor 2  : 41 C
Temperature Sensor 5  : 65 C

> > BTW, if we have more than two controllers, we'll have same type names
> > in the system.  So I'm going to append instance number after 'nvme'.
> > (e.g. nvme0_temp0).
> >
> > > > +     tzdev =3D thermal_zone_device_register(type, 1, 1, ctrl, &nvm=
e_tz_ops,
> > > > +                                          &nvme_tz_params, 0, 0);
> > >
> > > Have you considered if there is a use case for using of-thermal here?
> >
> > Is it possible to specify the device node properties for the pci device=
s?
> > If so, of-thermal zone devices are very useful.
> >
>
> Yeah, I guess that would depend on the PCI device node descriptor that
> the sensor is going to be embedded, not of-thermal. But I would expect
> that DT has already a good enough DT descriptors for PCI devices, can
> you check that?

I can find the examples for ath9k and ath10k pcie wireless devices.
(Documentation/devicetree/bindings/net/wireless/qca,ath9k.txt and
qcom,ath10k.txt)

> > I think normal thermal zone devices and of-thermal zone devices can
> > co-exist. (i.e. add 'tzdev_of[9]' in nvme_ctrl and the operations are
> > almost same with the normal one)
>
> Right, that is usually the case for drivers that have a real need to
> support both. Most of the drivers from embedded systems would prefer
> to keep only DT probing. But if you have a use case to support non-DT
> probing, yes, your driver would need to support both ways.

Distro kernels for x86 usually disables CONFIG_OF.  So we need both.
