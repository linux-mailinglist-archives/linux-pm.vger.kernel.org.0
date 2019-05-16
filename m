Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE59720B06
	for <lists+linux-pm@lfdr.de>; Thu, 16 May 2019 17:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbfEPPXD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 May 2019 11:23:03 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41076 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727568AbfEPPXD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 May 2019 11:23:03 -0400
Received: by mail-pf1-f195.google.com with SMTP id q17so2018085pfq.8
        for <linux-pm@vger.kernel.org>; Thu, 16 May 2019 08:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RatfLeFW1W1PAQOYZjHmZ1EvB3m/ZFWDsSmlE4eB5TA=;
        b=k6skFBX8Cz5Py454S2p2l8dOkOmY/q+Csr4dBPw3M35zGWyLwJSvFgS11iKH3C6V3M
         MTr9CqQc6IhCwwA1J4q3YTUqxBSJZThn4yBYEPQfnL4ytBBRnCdovLJikDvx/Ndkm2b2
         8ej1YfDXFyLJVuw22aUHlaM4ctgPSA88mKGNLjlzmLan1Q7uT0Ez/76NkSJ3ZURJCyq8
         38IxfMxxFLQkE4ydHQHz0l49uxgbicTUjRU2WyKIOBZqqZzKsx1cB9a6+iqyDXW4rSvI
         Nsz4VpwQozesX4/tBzIB0pJIaqKZv/cM8jDxKUHbSB7ks60/IXbzrxv58RfRQkF62Tes
         Kh0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RatfLeFW1W1PAQOYZjHmZ1EvB3m/ZFWDsSmlE4eB5TA=;
        b=fD5t224QMvl9OafCJMCW/iRfJ681/o36l9xX/19FoJHXzovCrl6D9dLvRb4nFWBXG1
         BERu2Jg8bqCI/wKoqzmgZZv7GxNxnF5D5qSYw/p/LAHUP8QIuOwKqxKwj9b9Y2SUeD9e
         k0a9vjZaY/OgVgVycInmd90lgVMg0HVEdFa5lQywAyb1cS/HWaO0sQ40KW+RB3UzymLa
         ZdttedxokIcO+MzbgcgioiqrC63LXeATslD5VRLqVR+AfbwkKVMIMp0yO3pom/2RaFsu
         m8CI/WYpJ/o8GFgFUcmpSR0n4C1q4rwtEAJGA1wrG6WO0WCE2VFUzx+Kr9pj/HkmozL7
         9kHg==
X-Gm-Message-State: APjAAAVeAoueM53WoNNyebpwZCApbBGjGsq9/+Qi7ASjZ7E1sgBV5uoD
        Eq57uEpVuhawMhodWFwxIZHjo87UJJVCiBlHGc8=
X-Google-Smtp-Source: APXvYqxeNr+MdDWiWuHTWTqqy3z5Ly9hhk2u0giMF6RLyo/pDNLlpteGewSk5DyowpxZ2mKTpmRyXPff/IrbrkKM7No=
X-Received: by 2002:a62:1a51:: with SMTP id a78mr53460390pfa.133.1558020182082;
 Thu, 16 May 2019 08:23:02 -0700 (PDT)
MIME-Version: 1.0
References: <1557933437-4693-1-git-send-email-akinobu.mita@gmail.com>
 <1557933437-4693-2-git-send-email-akinobu.mita@gmail.com> <20190515191518.GA21916@localhost.localdomain>
In-Reply-To: <20190515191518.GA21916@localhost.localdomain>
From:   Akinobu Mita <akinobu.mita@gmail.com>
Date:   Fri, 17 May 2019 00:22:51 +0900
Message-ID: <CAC5umyhh7eNHa4D9sndsoB7EgTJZTEL9OTd=a+7x817XvPZ_eQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] nvme: add thermal zone infrastructure
To:     Keith Busch <keith.busch@intel.com>
Cc:     linux-nvme@lists.infradead.org, linux-pm@vger.kernel.org,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

2019=E5=B9=B45=E6=9C=8816=E6=97=A5(=E6=9C=A8) 4:20 Keith Busch <keith.busch=
@intel.com>:
>
> On Thu, May 16, 2019 at 12:17:16AM +0900, Akinobu Mita wrote:
> > +int nvme_thermal_zones_register(struct nvme_ctrl *ctrl)
> > +{
> > +     struct nvme_smart_log *log;
> > +     int ret;
> > +     int i;
> > +
> > +     log =3D kzalloc(sizeof(*log), GFP_KERNEL);
> > +     if (!log)
> > +             return -ENOMEM;
> > +
> > +     ret =3D nvme_get_log(ctrl, NVME_NSID_ALL, NVME_LOG_SMART, 0,
> > +                        log, sizeof(*log), 0);
> > +     if (ret) {
> > +             ret =3D ret > 0 ? -EINVAL : ret;
> > +             goto free_log;
> > +     }
> > +
> > +     for (i =3D 0; i < ARRAY_SIZE(ctrl->tzdev); i++) {
> > +             struct thermal_zone_device *tzdev;
> > +
> > +             if (i && !le16_to_cpu(log->temp_sensor[i - 1]))
> > +                     continue;
> > +             if (ctrl->tzdev[i])
> > +                     continue;
> > +
> > +             tzdev =3D nvme_thermal_zone_register(ctrl, i);
> > +             if (!IS_ERR(tzdev))
> > +                     ctrl->tzdev[i] =3D tzdev;
> > +     }
> > +
> > +free_log:
> > +     kfree(log);
> > +
> > +     return ret;
> > +}
>
> Since this routine is intended for use in the device initialization path,
> the error returns are extra important. We have used < 0 to indicate we
> need to abandon initialization because we won't be able communicate with
> the device if we proceed. Since thermal reporting is not mandatory to
> manage our controllers, out-of-memory or a device that doesn't support
> SMART should just return 0. We should only halt init if the controller
> is unresponsive here.

Make sense.  I'll change the return type to void, and print warning in
case of some errors as Minwoo said in other reply.

> In general, I'm okay with this feature.

OK.  I'll prepare the next version.
