Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 912751093ED
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2019 20:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbfKYTGV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Nov 2019 14:06:21 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45003 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfKYTGV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Nov 2019 14:06:21 -0500
Received: by mail-pg1-f193.google.com with SMTP id e6so7626763pgi.11;
        Mon, 25 Nov 2019 11:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LU40ef0rAaum+eK/P6tsM0HgubIoAsYgjhlVKN9TpQs=;
        b=C8bWlsWYOfJE+eaDIQUHKbAy1HyHWEp+OZ/BByrW20ecGjCJf5WF/yN00gZApPZRmB
         qH/iXLSeK3uUD0vFmXwb+9BOZhbaDZTxfIArmW7Czw/7CIaoqalB2saiWnFL8iDaSmd1
         87JBSvaUTYJIndOKi0bgn25mN6nGEd1/4ktZPPPNQgKWiH6Wfgh17guFFlT8govHRFU2
         jx8ObqaxOpQ9/OI8FaX0FyHZRSJcIe2NRTPE4DZry0Fzu4OP5XZuoGZtg9lDG1irZuzV
         54itsePORLKovCUk+ojFMyGeeJ/GM0Mr/PVqa57M8ukTWE4QNDnLwEVeAy3HpkJ06tFO
         7i9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LU40ef0rAaum+eK/P6tsM0HgubIoAsYgjhlVKN9TpQs=;
        b=bgCEUFaPkpF1zEr3/QCxD4/sIEJJABBz088ZzPO+SFJTJl8DRdUwuJlOneIeoA5HIA
         5LQjbtuFwgQ8dFCSc25znAMcxGyaFWDyeMHsHCGXj9J1aAZiWFc9I5OcuYwu2o0YnDtq
         gwsrr2EOMkcNU6dGPIu8SLir+OQvTvySBGWgs6MzWUguPCKeeAPaejjwniH2PndXnm2O
         pIbuhTua+x15UqkJ73jwHURBEhLQJw6txsvHj2rzI0bNFRUHg749ofy+Dlu5em2GJqSg
         xzqfUeIxPrKUZqBd8JjKWf2YMxEPcerXRZ1f4H24icTnPqqdtZH1oTp0Bxe5235xI+tI
         4SHw==
X-Gm-Message-State: APjAAAUnPQJIhcJn9k0aw6OS6ltxg94ImXGHZ7M+DzXy8ugWC+0Wkult
        t5cGXIGjpOtYCVO8plwr4C0+BIZ1bNSACM5bP4c=
X-Google-Smtp-Source: APXvYqy39ijvq81YlLmNNwHzlG7mr/+qq0TmYtKp519K+Bg6nnf0Ofs1DdS6b75x+HwFkKnFdO2IOzskZloIiG9tpJI=
X-Received: by 2002:a65:5542:: with SMTP id t2mr33354313pgr.74.1574708776962;
 Mon, 25 Nov 2019 11:06:16 -0800 (PST)
MIME-Version: 1.0
References: <1574604530-9024-1-git-send-email-akinobu.mita@gmail.com>
 <1574604530-9024-4-git-send-email-akinobu.mita@gmail.com> <CAHp75VdkhFJZ71FS+DhrKTDPEW7Z-6imRSePm8EhgGF2sgTThg@mail.gmail.com>
 <CAC5umygDcYNd396K=CO7wpfDbESo4Sc39oWjkqu_-hmYbb2R1Q@mail.gmail.com>
In-Reply-To: <CAC5umygDcYNd396K=CO7wpfDbESo4Sc39oWjkqu_-hmYbb2R1Q@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 25 Nov 2019 21:06:06 +0200
Message-ID: <CAHp75VcODtDb8Y-6hrfqMtwSstn2DOYMSxNvdeG8VwYpUQ03uw@mail.gmail.com>
Subject: Re: [PATCH 3/8] platform/x86: asus-wmi: switch to use
 <linux/temperature.h> helpers
To:     Akinobu Mita <akinobu.mita@gmail.com>
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

On Mon, Nov 25, 2019 at 4:32 PM Akinobu Mita <akinobu.mita@gmail.com> wrote=
:
> 2019=E5=B9=B411=E6=9C=8825=E6=97=A5(=E6=9C=88) 4:54 Andy Shevchenko <andy=
.shevchenko@gmail.com>:
> > On Sun, Nov 24, 2019 at 4:09 PM Akinobu Mita <akinobu.mita@gmail.com> w=
rote:

> > > -       value =3D DECI_KELVIN_TO_CELSIUS((value & 0xFFFF)) * 1000;
> > > -
> > > -       return sprintf(buf, "%d\n", value);
> >
> > > +       return sprintf(buf, "%ld\n",
> > > +                      deci_kelvin_to_millicelsius(value & 0xFFFF));
> >
> > Leave it in one line.
>
> It causes this line over 80 characters.

And I don't care.

>  Or do you prefer to save the
> conversion result in 'value' temporarily as before?

No.

--=20
With Best Regards,
Andy Shevchenko
