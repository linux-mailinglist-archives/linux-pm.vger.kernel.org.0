Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 660B71315D9
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jan 2020 17:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbgAFQOR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Jan 2020 11:14:17 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:35452 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgAFQOQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Jan 2020 11:14:16 -0500
Received: by mail-io1-f67.google.com with SMTP id h8so2091959iob.2;
        Mon, 06 Jan 2020 08:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ua8KbVa3SpqdzIiSYVNEkoWrUMKqMyXBPCO7dg4wRmM=;
        b=iX0itlbNib8LJTsR58U9neHGgr8BcFiZamBCdiKqTV/MgHPWreFYWG/jjAzwCAdE6U
         kDcEWzmnTj4viodfQL2WcIJ7ojijDtrPM5vITc973VYGhwRQdYfXSkaDpgrgQaD7eI51
         4V5q/dBeGzaf40deLdBQYr1MzIabhv/i/c3/T/1hpyBG8XC04FVibOIQLDFDV4iXo7PX
         GK7mrNVXQyLOK/sN95ph2JjCOAXKYrDAJgaoZr+zT99xf2/vwk1ceLISS4IzWTVv94aG
         LxuCvPTKb4mhePCa1HazQxUQDlsxTOlQ3BM3ZsfjMHUiCl6/YLjzXM62nggj/X6rj2bn
         wz5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ua8KbVa3SpqdzIiSYVNEkoWrUMKqMyXBPCO7dg4wRmM=;
        b=HP3ofrleudOqTEZBlRgsgTcFe7g670g+UDW1IrnyJYbunZKpgcp0PzUePihwGpYVlP
         sF1PtyJWUENT/DHxoCzRwjQViJAQQkJMGLQu9uDBYnmtjX6b6EfG4BcHqIlAY0oO0d1Z
         fG4HV0RAJhoZceEBo5kZydOot6IeBQJlQZQgqkFY9JWs+ipe3h2YRtoNeBtGk68SbFnW
         vFwvPq3efKdXVMGEX/WbCwLR7u8dyQWDFFnsyVEGeikuZQErOtmzlfb+FNNu59TWnp+M
         DigbFryJqi8SZhP+Gc1Mq1H+CMujmdgjWYYtQVFDmqCNASOYXwaKtxd8aQ9hvJqcwLo1
         Td+g==
X-Gm-Message-State: APjAAAX8CXC/z5bxGw/Y8KMwviLzIhK+LQsCRG+aPwumg0Mb0NjKDaBv
        5X6oj9ZHWTRPfFntmCPHoxm4WUnxnG035C6YFIkmEWw7OLs=
X-Google-Smtp-Source: APXvYqwMmvRtJEJHpP4WEIRufRFbnxvhprQMCYZCdCDsymhg7qLrojfb/BpnvNceW/wU1BrtqwwdcB45nQJVIVKkGZk=
X-Received: by 2002:a6b:c410:: with SMTP id y16mr64355721ioa.18.1578327255375;
 Mon, 06 Jan 2020 08:14:15 -0800 (PST)
MIME-Version: 1.0
References: <20191228171904.24618-1-tiny.windzz@gmail.com> <CAGb2v67YPLy_qFuLKKMFytPEdFRUazoNfsQ1tYj8z3WVSRqC3Q@mail.gmail.com>
In-Reply-To: <CAGb2v67YPLy_qFuLKKMFytPEdFRUazoNfsQ1tYj8z3WVSRqC3Q@mail.gmail.com>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Tue, 7 Jan 2020 00:14:03 +0800
Message-ID: <CAEExFWtkPBhqT-wteE0_bC=QqaTyuvAcj_4SMOLjYAdc6p4tkg@mail.gmail.com>
Subject: Re: [PATCH] thermal: sun8i: Add hwmon support
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Maxime Ripard <mripard@kernel.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

HI Chen-Yu.

On Mon, Jan 6, 2020 at 12:32 PM Chen-Yu Tsai <wens@csie.org> wrote:
>
> On Sun, Dec 29, 2019 at 1:19 AM Yangtao Li <tiny.windzz@gmail.com> wrote:
> >
> > Expose sun8i thermal as a HWMON device.
> >
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > ---
> >  drivers/thermal/sun8i_thermal.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
> > index 23a5f4aa4be4..619e75cb41b0 100644
> > --- a/drivers/thermal/sun8i_thermal.c
> > +++ b/drivers/thermal/sun8i_thermal.c
> > @@ -20,6 +20,8 @@
> >  #include <linux/slab.h>
> >  #include <linux/thermal.h>
> >
> > +#include "thermal_hwmon.h"
> > +
> >  #define MAX_SENSOR_NUM 4
> >
> >  #define FT_TEMP_MASK                           GENMASK(11, 0)
> > @@ -477,6 +479,10 @@ static int sun8i_ths_register(struct ths_device *tmdev)
> >                                                              &ths_ops);
> >                 if (IS_ERR(tmdev->sensor[i].tzd))
> >                         return PTR_ERR(tmdev->sensor[i].tzd);
> > +
> > +               if (devm_thermal_add_hwmon_sysfs(tmdev->sensor[i].tzd))
> > +                       dev_warn(tmdev->dev,
> > +                                "Failed to add hwmon sysfs attributes\n");
>
> Maybe you want a hard failure instead?

I don't quite understand what you mean.
What do you think should be done?

MBR,
Yangtao

>
> ChenYu
>
> >         }
> >
> >         return 0;
> > --
> > 2.17.1
> >
