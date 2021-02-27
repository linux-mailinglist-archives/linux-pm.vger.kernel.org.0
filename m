Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA25D326DE2
	for <lists+linux-pm@lfdr.de>; Sat, 27 Feb 2021 17:36:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhB0QgT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 27 Feb 2021 11:36:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:60780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229999AbhB0QgS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 27 Feb 2021 11:36:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 15C0F64E56;
        Sat, 27 Feb 2021 16:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614443736;
        bh=pThp2YUgioKYQbON2ROnR85+avA0x0gvTYbNYvNV6vY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IMTwSCAaYbowhVS5Ca4ty45IBUiAriKlT4GDmENMgW5L1Jr+FGS+UjN+dOJiUTXG7
         yAafWli/v4hfgzkeXop+a1V+VnlOrmxoAkSPE+D3Ws3nX3aVd4HS/9fL031ziYkwo/
         2pWeZet15MgSqd02hEAz7gnTLXlpxq+Avldx991O+q9Dh+14OtD8FS0T2kMhoT/mDJ
         QA5i5jBMGQbEge+2fuzdpco7COx3SWE+STQHy0D3q14+yW+M+rnue5NcsUJLdYXtHX
         eKmFWMzh8xg6Rk75ORhGMKCvJU7Q/Zx7baZnbLi6ucseadHg305WDxar4KsYKZoL4L
         F+ttLs9BETv8A==
Received: by mail-ed1-f43.google.com with SMTP id bd6so1609104edb.10;
        Sat, 27 Feb 2021 08:35:35 -0800 (PST)
X-Gm-Message-State: AOAM532187yUpS9HP2geGEwCIF7GVpLH5e+mw60ePng5YA2DbRLYo7BT
        VhUe0v1C5KIi6RukFKWZkQdE9a+xU/Tm/Wirrrc=
X-Google-Smtp-Source: ABdhPJxQm0jaP77z6+UGYSa5Hs2fDfI5iQdZ+h9KP1qAoa6iJSIhOcfec28JA/ljt5drqEwpIlE72Fd14uxdzUWYqek=
X-Received: by 2002:a05:6402:10ce:: with SMTP id p14mr8645979edu.348.1614443734715;
 Sat, 27 Feb 2021 08:35:34 -0800 (PST)
MIME-Version: 1.0
References: <20200828153100.19006-1-krzk@kernel.org> <CAGTfZH3+mxBXzVp5Wz=F6nbx3bfubrmJozVzVdt8s1e45WQOqg@mail.gmail.com>
In-Reply-To: <CAGTfZH3+mxBXzVp5Wz=F6nbx3bfubrmJozVzVdt8s1e45WQOqg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Sat, 27 Feb 2021 17:35:23 +0100
X-Gmail-Original-Message-ID: <CAJKOXPdw=2MMT+5=_TtOqEwPA8s40J21eYXfzv8Whk7F8uF9dw@mail.gmail.com>
Message-ID: <CAJKOXPdw=2MMT+5=_TtOqEwPA8s40J21eYXfzv8Whk7F8uF9dw@mail.gmail.com>
Subject: Re: [PATCH] devfreq: rk3399_dmc: Simplify with dev_err_probe()
To:     Chanwoo Choi <chanwoo@kernel.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, 29 Aug 2020 at 15:10, Chanwoo Choi <chanwoo@kernel.org> wrote:
>
> On Sat, Aug 29, 2020 at 12:31 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >
> > Common pattern of handling deferred probe can be simplified with
> > dev_err_probe().  Less code and the error value gets printed.
> >
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> >  drivers/devfreq/rk3399_dmc.c | 20 ++++++--------------
> >  1 file changed, 6 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
> > index 027769e39f9b..35b3542f1f7b 100644
> > --- a/drivers/devfreq/rk3399_dmc.c
> > +++ b/drivers/devfreq/rk3399_dmc.c
> > @@ -324,22 +324,14 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
> >         mutex_init(&data->lock);
> >
> >         data->vdd_center = devm_regulator_get(dev, "center");
> > -       if (IS_ERR(data->vdd_center)) {
> > -               if (PTR_ERR(data->vdd_center) == -EPROBE_DEFER)
> > -                       return -EPROBE_DEFER;
> > -
> > -               dev_err(dev, "Cannot get the regulator \"center\"\n");
> > -               return PTR_ERR(data->vdd_center);
> > -       }
> > +       if (IS_ERR(data->vdd_center))
> > +               return dev_err_probe(dev, PTR_ERR(data->vdd_center),
> > +                                    "Cannot get the regulator \"center\"\n");
> >
> >         data->dmc_clk = devm_clk_get(dev, "dmc_clk");
> > -       if (IS_ERR(data->dmc_clk)) {
> > -               if (PTR_ERR(data->dmc_clk) == -EPROBE_DEFER)
> > -                       return -EPROBE_DEFER;
> > -
> > -               dev_err(dev, "Cannot get the clk dmc_clk\n");
> > -               return PTR_ERR(data->dmc_clk);
> > -       }
> > +       if (IS_ERR(data->dmc_clk))
> > +               return dev_err_probe(dev, PTR_ERR(data->dmc_clk),
> > +                                    "Cannot get the clk dmc_clk\n");
> >
> >         data->edev = devfreq_event_get_edev_by_phandle(dev, 0);
> >         if (IS_ERR(data->edev))
> > --
> > 2.17.1
> >
>
> Applied it. Thanks.

Hi Chanwoo,

Do you know what happened with this patch? You replied that it is
applied but I cannot find it in the Linus' or next trees.


Best regards,
Krzysztof
