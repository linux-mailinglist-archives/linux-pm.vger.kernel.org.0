Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83C672E280
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2019 18:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbfE2QrU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 May 2019 12:47:20 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42954 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbfE2QrU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 May 2019 12:47:20 -0400
Received: by mail-pf1-f194.google.com with SMTP id r22so1981509pfh.9
        for <linux-pm@vger.kernel.org>; Wed, 29 May 2019 09:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4Tv6+Gs1+EQ5+P4YCY4cdNnU3gxm7lIyvRNXI6TMLyQ=;
        b=G81QM3OsXRTmIPE0lZDNPld9Gjec7ThwCiarz3PlcrNtprZJRRJbRzKS1iZ5UFwg2E
         SKHZT2obo9Sa2W1v4pOGqQPxO5ViDtPUTois9dSsPBVysA9ZujxoayloHZvSdjPSmYuw
         kETUz0mTnFhMjuT0aYwUysqPdTsySiZqLVg/8zjj3lCo7mF0NUt8aEtWb8MR2QHiAChW
         snSwaK59AbMikcsiL63JKsMdVg5XTjPv9QJGeUep3YxtHXwuwZ5pOZeroRJulvnxRgeF
         kPXv8EEv3VzP7II13egjiTNzuaNP/11dWfA+vE8z3Jqa4+V1a59bcteOv0Dq2seSSagh
         0zDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4Tv6+Gs1+EQ5+P4YCY4cdNnU3gxm7lIyvRNXI6TMLyQ=;
        b=K2A3Ybz87TCTlW+3IcSP3SazRk44ZQ0NjF/jpQ68SACx1NyJSa0stnjzBBvXOxvu0z
         FR0zGImNgdnPDU3oFZCAUmqdi0JcOhZ+swSub7DVrMyBsuVoCjgE3W+x5CEbOf4C8EJC
         bPUuA9ne7YKB8EW65xOooZ4ReCBQPSaCPpq5EGE6mYFu0i1xtTSU5mDktmYBzQ2zfHXk
         cdr2e5AcuG/6CNHW37hsMrMaqr7KoLHqXaHB0/9g0jdXJF8KYATMOBAu741yfQSBcZ7u
         RBr1rJRdzMbE1pFMz9AsrxHkpaQW3ZPgma6wuDuH9ygiOCdwLckslXzIiGN4y3SED04G
         EG3A==
X-Gm-Message-State: APjAAAXORPHd/KV/Hj7zJhaX0yRUa34IhZgJA/h9LM4RTr2XGW4y1bhp
        BILh+2zgnrAt1pMYzW+qh7Nf/+WnigwwXeVvRXk=
X-Google-Smtp-Source: APXvYqxN3FUqJ2Jtgk9qZ+mXgZN0IunAk+t8P2x9TLTwoLRzR6cF1cOOR6Ye44qr/bs4cSb2x1s7nd30zWLnZexKot8=
X-Received: by 2002:a17:90a:d681:: with SMTP id x1mr4681224pju.13.1559148439268;
 Wed, 29 May 2019 09:47:19 -0700 (PDT)
MIME-Version: 1.0
References: <1558888143-5121-1-git-send-email-akinobu.mita@gmail.com>
 <1558888143-5121-3-git-send-email-akinobu.mita@gmail.com> <20190529151517.GC28274@minwooim-desktop>
In-Reply-To: <20190529151517.GC28274@minwooim-desktop>
From:   Akinobu Mita <akinobu.mita@gmail.com>
Date:   Thu, 30 May 2019 01:47:08 +0900
Message-ID: <CAC5umyhusw+sQOn5H7ZMP=aVi00GY7R_Jff6447R=yXyUpjFoQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] nvme: add thermal zone devices
To:     Minwoo Im <minwoo.im.dev@gmail.com>
Cc:     linux-nvme@lists.infradead.org, linux-pm@vger.kernel.org,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Kenneth Heitke <kenneth.heitke@intel.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

2019=E5=B9=B45=E6=9C=8830=E6=97=A5(=E6=9C=A8) 0:15 Minwoo Im <minwoo.im.dev=
@gmail.com>:
>
> > +/**
> > + * nvme_thermal_zones_register() - register nvme thermal zone devices
> > + * @ctrl: controller instance
> > + *
> > + * This function creates up to nine thermal zone devices for all imple=
mented
> > + * temperature sensors including the composite temperature.
> > + * Each thermal zone device provides a single trip point temperature t=
hat is
> > + * associated with an over temperature threshold.
> > + */
> > +static int nvme_thermal_zones_register(struct nvme_ctrl *ctrl)
> > +{
> > +     struct nvme_smart_log *log;
> > +     int ret;
> > +     int i;
> > +
> > +     log =3D kzalloc(sizeof(*log), GFP_KERNEL);
> > +     if (!log)
> > +             return 0; /* non-fatal error */
>
> Do we need to print something like warning here? If kzalloc() fails, it
> would be good to be distinguished between the nvme failure and internal
> failure like this.

We usually remove the error message on kmalloc failure because it's
redundant as long as we don't set __GFP_NOWARN.

> > +
> > +     ret =3D nvme_get_log(ctrl, NVME_NSID_ALL, NVME_LOG_SMART, 0,
> > +                        log, sizeof(*log), 0);
> > +     if (ret) {
> > +             dev_err(ctrl->device, "Failed to get SMART log: %d\n", re=
t);
> > +             /* If the device provided a response, then it's non-fatal=
 */
> > +             if (ret > 0)
> > +                     ret =3D 0;
>
> It seems like that nvme_init_identify() is just check the internal error
> which is in negative value now as you have posted.  Why don't we just
> return the value of "ret" itself without updating it to 0 ?

Both ways work for me.

I personally prefer not to return (leak) the nvme status code from
foo_register() function.

> > +             goto free_log;
> > +     }
> > +
> > +     for (i =3D 0; i < ARRAY_SIZE(ctrl->tzdev); i++) {
> > +             struct thermal_zone_device *tzdev;
> > +             int temp;
> > +
> > +             if (i)
> > +                     temp =3D le16_to_cpu(log->temp_sensor[i - 1]);
> > +             else
> > +                     temp =3D get_unaligned_le16(log->temperature);
> > +
> > +             /*
> > +              * All implemented temperature sensors report a non-zero =
value
> > +              * in temperature sensor fields in the smart log page.
> > +              */
> > +             if (!temp)
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
> > +
> > +/**
> > + * nvme_thermal_zones_unregister() - unregister nvme thermal zone devi=
ces
> > + * @ctrl: controller instance
> > + *
> > + * This function removes the registered thermal zone devices and symli=
nks.
> > + */
> > +static void nvme_thermal_zones_unregister(struct nvme_ctrl *ctrl)
> > +{
> > +     int i;
> > +
> > +     for (i =3D 0; i < ARRAY_SIZE(ctrl->tzdev); i++) {
> > +             struct thermal_zone_device *tzdev =3D ctrl->tzdev[i];
> > +             char name[20];
>
> Simple query here :)
>
> If we are not going to allow the name of link exceed the length of its
> own device name like nvmeX_tempY, then can we THERMAL_NAME_LENGTH macro
> here?  If the name of link is not exactly about the device name itself,
> then it's fine.  What do you think about it ?

Of course we can use THERMAL_NAME_LENGTH here.  But this char array is
used only for the symbolic link name.
It's not used for thermal cooling device type, thermal zone device type,
or thermal governor name.  So I just used a random constant to avoid
confusion.
