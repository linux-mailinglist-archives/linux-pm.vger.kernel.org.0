Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 533181387AF
	for <lists+linux-pm@lfdr.de>; Sun, 12 Jan 2020 19:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733064AbgALSNB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 12 Jan 2020 13:13:01 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:37634 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732957AbgALSNA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 12 Jan 2020 13:13:00 -0500
Received: by mail-io1-f67.google.com with SMTP id k24so7185688ioc.4;
        Sun, 12 Jan 2020 10:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uet7UosEM0x42r0t79COTHjDMTaGXqxwiypPdPTlDvQ=;
        b=Arz/bOllwZ22bxNSvvZEKI4wuhd+Jl5Z+SuR7m/iyTibT48MlrRs9YkZ8LBFAZFigk
         OXvInp/riYoGpU2D2NVxQU6ZRyJ6t6sVHzEoA1wimW9gaB4vuOdGCWC7C3qErPNml+7j
         /fuM93zY5RODQBrAUXb0VBXAZO7UkgQNEJOFSU6gUL1SKGzrJ7HMs84IVJhDprX72vpc
         twqszPUVCaxGBJEcXPm7Bgn4l5Im5005oJdHXolSAt0kjl3tW6sZTeyXwROvOPYh29Po
         zxk0g8Tj/4dXdsgoQjfTqQKuydqMFhHfsDdksF+jpulbTILiwSDIR20Vat4ugmSEV3Q/
         5RXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uet7UosEM0x42r0t79COTHjDMTaGXqxwiypPdPTlDvQ=;
        b=uE3oYoS8xCltgqsc0zqOA+WQxjzAqCl0hTdJwMQb3OoomZ8VLBRhd5f8UDYf5HIt3G
         mFBT3dLrB0/4pex6BgocREwLyxKsScUf/XpAl7YgoAnXELAeihSmPZJDLyPAaN888V9F
         T9eJwALRmz9OL6DleDnQjc3OdlevMuRl4X5cxFao9koRJ/SH8OcW3xOYnVSawbnqPiUy
         zFxOc2W/5LZDlE9UUiPAUHOuZ/v9cAzb+DpCPXI3v2PE3aywStwYXhUnASwP9jLt9GHM
         qRM27cP5pEmxwVQOEKPtuiTINyIfCMZp/4SdsWOgPqJZ8E/kg8r3dhk7yQI3k6v4UhX6
         KcCw==
X-Gm-Message-State: APjAAAXqNJk0+9NE/dGkmZgdNWTzqa7h3eMGzDFuayIWb68w1XLRpBWh
        l9AJ87CfhA1T9XB5YmJO9y/ppxSbVsj/cPiI2mA=
X-Google-Smtp-Source: APXvYqyxYgfM9TzQjZ5G0/d9Cs3I3vTG8Gsfi7Q8Mud+a3lGLWo1Q1n9O9mPklIwqu323vLFytx1rJU9eX8URzspP3M=
X-Received: by 2002:a6b:c410:: with SMTP id y16mr9421191ioa.18.1578852780237;
 Sun, 12 Jan 2020 10:13:00 -0800 (PST)
MIME-Version: 1.0
References: <20191228171904.24618-1-tiny.windzz@gmail.com> <CAGb2v67YPLy_qFuLKKMFytPEdFRUazoNfsQ1tYj8z3WVSRqC3Q@mail.gmail.com>
 <CAEExFWtkPBhqT-wteE0_bC=QqaTyuvAcj_4SMOLjYAdc6p4tkg@mail.gmail.com>
 <CAGb2v673PM_3QazNWBKYd=4pumyyyE3XFmwa4LY7qFt2=QwEVQ@mail.gmail.com> <CAEExFWtaeiX0bq6VO5294w8vCtnnNDDB0HA_nvR19adg=KFANQ@mail.gmail.com>
In-Reply-To: <CAEExFWtaeiX0bq6VO5294w8vCtnnNDDB0HA_nvR19adg=KFANQ@mail.gmail.com>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Mon, 13 Jan 2020 02:12:49 +0800
Message-ID: <CAEExFWsGZD=Hm3OWmTLmKu82VDfG31y3ENJz7CfRHENqT8jJUw@mail.gmail.com>
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

HI Daniel:

On Sun, Jan 12, 2020 at 2:08 AM Frank Lee <tiny.windzz@gmail.com> wrote:
>
> On Tue, Jan 7, 2020 at 11:15 AM Chen-Yu Tsai <wens@csie.org> wrote:
> >
> > On Tue, Jan 7, 2020 at 12:14 AM Frank Lee <tiny.windzz@gmail.com> wrote:
> > >
> > > HI Chen-Yu.
> > >
> > > On Mon, Jan 6, 2020 at 12:32 PM Chen-Yu Tsai <wens@csie.org> wrote:
> > > >
> > > > On Sun, Dec 29, 2019 at 1:19 AM Yangtao Li <tiny.windzz@gmail.com> wrote:
> > > > >
> > > > > Expose sun8i thermal as a HWMON device.
> > > > >
> > > > > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > > > > ---
> > > > >  drivers/thermal/sun8i_thermal.c | 6 ++++++
> > > > >  1 file changed, 6 insertions(+)
> > > > >
> > > > > diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
> > > > > index 23a5f4aa4be4..619e75cb41b0 100644
> > > > > --- a/drivers/thermal/sun8i_thermal.c
> > > > > +++ b/drivers/thermal/sun8i_thermal.c
> > > > > @@ -20,6 +20,8 @@
> > > > >  #include <linux/slab.h>
> > > > >  #include <linux/thermal.h>
> > > > >
> > > > > +#include "thermal_hwmon.h"
> > > > > +
> > > > >  #define MAX_SENSOR_NUM 4
> > > > >
> > > > >  #define FT_TEMP_MASK                           GENMASK(11, 0)
> > > > > @@ -477,6 +479,10 @@ static int sun8i_ths_register(struct ths_device *tmdev)
> > > > >                                                              &ths_ops);
> > > > >                 if (IS_ERR(tmdev->sensor[i].tzd))
> > > > >                         return PTR_ERR(tmdev->sensor[i].tzd);
> > > > > +
> > > > > +               if (devm_thermal_add_hwmon_sysfs(tmdev->sensor[i].tzd))
> > > > > +                       dev_warn(tmdev->dev,
> > > > > +                                "Failed to add hwmon sysfs attributes\n");
> > > >
> > > > Maybe you want a hard failure instead?
> > >
> > > I don't quite understand what you mean.
> > > What do you think should be done?
> >
> > Return an error instead of just printing a warning.
>
> Sometimes, even if hwmon fails to add, it can still work as a thermal driver.
> At this time, I don't really want to interrupt the registration of the
> thermal driver.
>
> Anyone else's opinion here?
>

What's your point? Can you choose this patch?

MBR,
Yangtao
