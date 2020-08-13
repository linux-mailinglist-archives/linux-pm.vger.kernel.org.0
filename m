Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 870D424393C
	for <lists+linux-pm@lfdr.de>; Thu, 13 Aug 2020 13:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgHMLTK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Aug 2020 07:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbgHMLTJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Aug 2020 07:19:09 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8B8C061385
        for <linux-pm@vger.kernel.org>; Thu, 13 Aug 2020 04:19:08 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id h19so5717729ljg.13
        for <linux-pm@vger.kernel.org>; Thu, 13 Aug 2020 04:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qcVxyjLOc1XVQD85n/+izIou9HNM43cYVLg/SeyZZMI=;
        b=bNUdBuTwV/3TZ/Z2ohABO3rXzw8ixSfjeDWsfXjjDrX20nyzrlw+kFWqi3ovJUynzQ
         T1jyIFdxNfWCxLqjjyxSHXr5s0oW5LxFuvCml7jlfGz/Es56tr8LGQJ0Ayd8iqZPt9ZY
         PsDEcqKEmN8WW+xd7XLaSVnCibx6LBsuymT1hEUj+XD/gGeGo2ourVChPri6ZJkqQOVR
         ceDCAPqSkGUMysZ8x4Jtlz5llwNp3sqtR86ChhD8zQbr6L7twY6lDI+UEQ3DiEXxQa/F
         8Qku+cOjt+2i4dOy7CD3axyIFL6EvdiknM+KuArG/9J4BcsypOjwY3z7KRAA02hS0wBv
         06Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qcVxyjLOc1XVQD85n/+izIou9HNM43cYVLg/SeyZZMI=;
        b=onFVA6OVSr4KzHwoyfaKECSAnB+M9PY/DKNRzfP510l3EqRc+7Ntk0rEY1EpIg/srz
         CMqPyFsGJNIc4ecCZSTM3oyBFS07MQiI2aA5UO0C5d1AvWBXS516QSo+z9cLTn0fM9nO
         x5yFL8GtIo1ofvZTidefYpFmY4BX1nhA0FezZdowrrL1nP9ScWkIxegCFcqlWtInIpPX
         WC/IDYkalabOvbej0/mFzW5x99YicstMAt6KqBecTDTN4V1UnzWG38zMR4nSWGq7e0uW
         pLYpKhdjSFL8IUYqyKyUOwkOjsunXjMHuli5MJJeHPAGkUQBIzTot4nS72lv7emTo5YU
         gahg==
X-Gm-Message-State: AOAM533Kz72HBf63tDt4mxBpVaS35x6WzZJOb68TRqr2Yep1fSoOEhB9
        PDa6fj2Xe8AS7+CTZbAxaClDz1+kdPwenT5ncfx8EQ==
X-Google-Smtp-Source: ABdhPJzYfGbMEn7r8RSAZZZ27h0Qx8uCYkmnUIyQdLzHLY2mY0DXgQIKq5PcNQCWG8lcb6/k/8aEZqf77v7vU/NmbRA=
X-Received: by 2002:a05:651c:91:: with SMTP id 17mr1857137ljq.173.1597317546530;
 Thu, 13 Aug 2020 04:19:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200725181404.18951-1-ansuelsmth@gmail.com> <20200725181404.18951-2-ansuelsmth@gmail.com>
 <CAHLCerMc8yUjh9qwUCa=jMZHs18GC4qeS3rqT1_6K90QJd=nVA@mail.gmail.com> <006f01d66fe1$e6c0d450$b4427cf0$@gmail.com>
In-Reply-To: <006f01d66fe1$e6c0d450$b4427cf0$@gmail.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Thu, 13 Aug 2020 16:48:55 +0530
Message-ID: <CAP245DWuMh6Bkv7P4Y6mV3n59KFyCGKoy7e00E9d9ijR_rr1WA@mail.gmail.com>
Subject: Re: [RFC PATCH v5 1/7] drivers: thermal: tsens: Add VER_0 tsens version
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Aug 11, 2020 at 6:48 PM <ansuelsmth@gmail.com> wrote:
>
>
>
> > -----Messaggio originale-----
> > Da: Amit Kucheria <amit.kucheria@linaro.org>

> >
> > >                         if (IS_ERR(priv->rf[i]))
> > >                                 return PTR_ERR(priv->rf[i]);
> > >                 }
> > > @@ -775,12 +800,80 @@ int __init init_common(struct tsens_priv
> > *priv)
> > >                         goto err_put_device;
> > >         }
> > >
> > > -       priv->rf[TSENS_EN] = devm_regmap_field_alloc(dev, priv->srot_map,
> > > -                                                    priv->fields[TSENS_EN]);
> > > -       if (IS_ERR(priv->rf[TSENS_EN])) {
> > > -               ret = PTR_ERR(priv->rf[TSENS_EN]);
> > > -               goto err_put_device;
> > > +       if (tsens_version(priv) >= VER_0_1) {
> > > +               priv->rf[TSENS_EN] = devm_regmap_field_alloc(
> > > +                       dev, priv->srot_map, priv->fields[TSENS_EN]);
> > > +               if (IS_ERR(priv->rf[TSENS_EN])) {
> > > +                       ret = PTR_ERR(priv->rf[TSENS_EN]);
> > > +                       goto err_put_device;
> > > +               }
> > > +
> > > +               priv->rf[SENSOR_EN] = devm_regmap_field_alloc(
> > > +                       dev, priv->srot_map, priv->fields[SENSOR_EN]);
> > > +               if (IS_ERR(priv->rf[SENSOR_EN])) {
> > > +                       ret = PTR_ERR(priv->rf[SENSOR_EN]);
> > > +                       goto err_put_device;
> > > +               }
> > > +               priv->rf[INT_EN] = devm_regmap_field_alloc(
> > > +                       dev, priv->tm_map, priv->fields[INT_EN]);
> > > +               if (IS_ERR(priv->rf[INT_EN])) {
> > > +                       ret = PTR_ERR(priv->rf[INT_EN]);
> > > +                       goto err_put_device;
> > > +               }
> > > +       } else {
> >
> > Let's not create two big sections with if-else for 8960 and everything
> > else. For example, what is wrong with using common code for TSENS_EN?
> >
> > If the concern is memory wasted trying to allocate fields not present
> > on this older platform, perhaps consider adding a check in the loop to
> > break early in case of 8960?
> >
>
> About TSENS_EN the old platform doesn't have SROT so I need to use TM_MAP.
> Should I set the srot map to match the tm map so we can use the common function?
> Aside from this problem, I will try to remove the big if-else.

Ick. I guess srot_map and tm_map pointing to the same region is the
lesser of two evils? It makes it so this will be constrained to a
single place in init_common().
