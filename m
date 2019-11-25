Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 233B6109018
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2019 15:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbfKYOfE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Nov 2019 09:35:04 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40261 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728026AbfKYOfE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Nov 2019 09:35:04 -0500
Received: by mail-lf1-f67.google.com with SMTP id v24so11191757lfi.7;
        Mon, 25 Nov 2019 06:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mOb7drR/WTWufTxzUC4FI8sP3G8txIhCN7WbUI3E994=;
        b=Vm9h9oP4w8AakWL2fpCxlWT8rExaAbM1+kSqScdhnmQG1luK1zgK6Jdlquh2waUpHm
         RyapDHjTaFbxM32TvEKBApfC1ZzIfq/ddxiMGvmNPWU0jFOQofKhnhYGIuenJEo9NJh9
         YX2bY8OEFxZZX8p9ZDUh6bY4c82EAlazeV2P8fpk65wyUCN40/3CF2zqDgvCI9J5uoGb
         VKByqCEAwySpm39p8W7jQycG9Ufsh4BO/IRn6fvYXWpFXgXbxwED9tePDWk/RURVP+jw
         qqckozcfMLX8scEKBgiP+kWniBitb80gZKNMZDbv2qBWO5nZ5Og9dSZxDpWX4Q9R82r2
         nR7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mOb7drR/WTWufTxzUC4FI8sP3G8txIhCN7WbUI3E994=;
        b=BWS72isxoJFecucUVHSBpRs92apOmc3ZsPKaAH+pLc5MFKY7ZMPnCZH6aonPJ+P2DA
         6HHzgOcAaOExmOVYGFVd+opzZ8TzUY5mbF1ojKEVFt9j1eK45kJ7Bbt9XhQyYczdc6CO
         AocSsLKCpFTJKXlNET5a9o0Xh+bvubHC2qrZapHK9K8ZrBgfs+3nDPsjbiIiPlC+Omrj
         yzQHtPPkR8h5iM0mJ7syD4PpDFWlavUCjDwd8Rv5n7juWdoFNOxlw5mnj8bPIgsKgWCG
         PMcnqcs9f/lVFnD+tt93o3+HCcLtBl+wXAjdqQIfWOI3CjLFJOQBk0k4+82LkkqLcBob
         FMhQ==
X-Gm-Message-State: APjAAAUgJqu0B8cV+FiNxM9MdbVGtq5ebx7DttBrUz7VsvQzbNq2G+7g
        oKSBliEdAEHobKAgcusXjW+iufseBraCOzjQZdQ=
X-Google-Smtp-Source: APXvYqzbXX4EpoK9rwjhMiOUCyPCyQLDSuvkp+U1kLrHk/9+VVPTL0+HDaQ9/gLUpO6yoEMWsqdZTWB6OqR8naZMiq0=
X-Received: by 2002:ac2:428d:: with SMTP id m13mr15000406lfh.64.1574692501816;
 Mon, 25 Nov 2019 06:35:01 -0800 (PST)
MIME-Version: 1.0
References: <1574604530-9024-1-git-send-email-akinobu.mita@gmail.com>
 <1574604530-9024-5-git-send-email-akinobu.mita@gmail.com> <CAHp75VfOUiN_2bW+o-AqGmAY32mmdNxP54B2f2+gj0NTEr9FTQ@mail.gmail.com>
In-Reply-To: <CAHp75VfOUiN_2bW+o-AqGmAY32mmdNxP54B2f2+gj0NTEr9FTQ@mail.gmail.com>
From:   Akinobu Mita <akinobu.mita@gmail.com>
Date:   Mon, 25 Nov 2019 23:34:50 +0900
Message-ID: <CAC5umygc95VBWz1L5CTZO9kmkZL2MCEL2_z9d2TJ6Ow5+fKYPw@mail.gmail.com>
Subject: Re: [PATCH 4/8] platform/x86: intel_menlow: switch to use
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

2019=E5=B9=B411=E6=9C=8825=E6=97=A5(=E6=9C=88) 4:58 Andy Shevchenko <andy.s=
hevchenko@gmail.com>:
>
> On Sun, Nov 24, 2019 at 4:09 PM Akinobu Mita <akinobu.mita@gmail.com> wro=
te:
> >
> > This switches the intel_menlow driver to use deci_kelvin_to_celsius() a=
nd
> > celsius_to_deci_kelvin() in <linux/temperature.h> instead of helpers in
> > <linux/thermal.h>.
> >
> > This is preparation for centralizing the kelvin to/from Celsius convers=
ion
> > helpers in <linux/temprature.h>.
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
> >  drivers/platform/x86/intel_menlow.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/platform/x86/intel_menlow.c b/drivers/platform/x86=
/intel_menlow.c
> > index b102f6d..6313591 100644
> > --- a/drivers/platform/x86/intel_menlow.c
> > +++ b/drivers/platform/x86/intel_menlow.c
> > @@ -302,8 +302,10 @@ static ssize_t aux_show(struct device *dev, struct=
 device_attribute *dev_attr,
> >         int result;
> >
> >         result =3D sensor_get_auxtrip(attr->handle, idx, &value);
> > +       if (result)
> > +               return result;
> >
> > -       return result ? result : sprintf(buf, "%lu", DECI_KELVIN_TO_CEL=
SIUS(value));
> > +       return sprintf(buf, "%ld", deci_kelvin_to_celsius(value));
>
> Can you explain the change %lu to %ld?

Isn't it possible for aux values to be lower than 0 degrees Celsius?

> >  }
> >
> >  static ssize_t aux0_show(struct device *dev,
> > @@ -332,8 +334,8 @@ static ssize_t aux_store(struct device *dev, struct=
 device_attribute *dev_attr,
> >         if (value < 0)
> >                 return -EINVAL;
> >
> > -       result =3D sensor_set_auxtrip(attr->handle, idx,
> > -                                   CELSIUS_TO_DECI_KELVIN(value));
>
> > +       result =3D sensor_set_auxtrip(attr->handle, idx,
> > +                                   celsius_to_deci_kelvin(value));
>
> How come the first line has been changed?

Because the trailing space is removed.  I'll mention it in the commit log.
