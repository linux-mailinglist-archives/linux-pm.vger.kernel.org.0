Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB013E474E
	for <lists+linux-pm@lfdr.de>; Mon,  9 Aug 2021 16:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234723AbhHIOQX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Aug 2021 10:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234474AbhHIOQV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Aug 2021 10:16:21 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A40CC0613D3
        for <linux-pm@vger.kernel.org>; Mon,  9 Aug 2021 07:16:01 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id d6so7086112uav.2
        for <linux-pm@vger.kernel.org>; Mon, 09 Aug 2021 07:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=t2JS4jX4KVJMm969xuIbIakC/VW6X8llepJsV0geS9M=;
        b=xKhQTHUoQoEkz2nG4hDGIk2YR5qF2cuL0MXva/HHrc09x2xW7etRm0fmmaiRrmQINl
         CW5Gi54a+YJYpI10SKFx/DKhsxVFrRv+1JSWObvir9dr99JGouJ4rm1PjR951LC52gVq
         qf8LFqV/dIzJmosJWmHm+QKTq5FOjclQDtJjD1TNStE1sJnwuL649jH/KB6kVj74+RjA
         D0tUK5NxWgbCX4uDvv7mzuz7Z3R/lAIJEuFmNOLhZL2S7/aYdwDpwPghA3zjEabLTf2o
         dWdXyHdGbpd/bfRafYUUqOi76FBqrAJ/TcxbJtxLTsOLd5dkmAmZ3cNPzUer74BGXZ5u
         1VdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=t2JS4jX4KVJMm969xuIbIakC/VW6X8llepJsV0geS9M=;
        b=LkZdv0NF8yy0r34Tk6C9p8gY+56iUzDkdZjcVt8LoHoS7kYYR/AnS46xGcRtlUovCx
         NpYDcjlKC6Acym0pBGuJfKDC6SwRtodAoJozRQP2Aqz3msIdmN/aCvj+eWjzhs/98f8x
         d4KrYLBvi/YTSZLP0SyUMxiwXchsI/8EpF/gRVpoydGMN5RNXYuBt3ucJaS405kZ31YS
         vZiycly/XMh1x0Y0cszfsMp0iE9gjTe/GhQtfRvFzUzqaPuU59y7xbWT2fZO5v/Y0AQT
         TfGzY1dd7jT9uUyIb6tAECnvDyUHTs4vIrsxqszqrXRsW9gtyMF7gY/ordZV8HrYXQSc
         v9Yw==
X-Gm-Message-State: AOAM530SbJrSTrx/fy8e2nWuSFaJtdPU46zls4FsndCmyzNrr7YPAVKY
        9a+Faoux0+dIJTRkQIG3/hOBBaPO+It8bb4sLaaDfQ==
X-Google-Smtp-Source: ABdhPJwUc2DxWbhhzBxKreLdDmySu8RuyfX9ZQYDSbBH2oFtJGj3ctyKbUboWT9zSZ4AsW0BlvGk0WTBojJ8rTp8zc0=
X-Received: by 2002:a9f:25a7:: with SMTP id 36mr15493853uaf.129.1628518559709;
 Mon, 09 Aug 2021 07:15:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210701232728.23591-1-digetx@gmail.com> <20210701232728.23591-3-digetx@gmail.com>
 <CAPDyKFrtWDYJo_NjS8306Z9ykbg7XZ55jC9hKEBMGkcrx1=4kQ@mail.gmail.com>
 <1034458d-78e0-5036-e278-6fee5d0d75ac@gmail.com> <CAPDyKFoafAk72Kw6X7626Niduaii0V5VM4dGSWmq+e3JTh7VRg@mail.gmail.com>
 <a5dfdf59-f5b5-d28e-6b02-b0c860ba8d80@gmail.com>
In-Reply-To: <a5dfdf59-f5b5-d28e-6b02-b0c860ba8d80@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 9 Aug 2021 16:15:23 +0200
Message-ID: <CAPDyKFq+ExjbGrN=yUUXPKfN_fGrwY6EAYn9a6VUFFU_VjhC=g@mail.gmail.com>
Subject: Re: [PATCH v7 02/37] soc/tegra: pmc: Implement attach_dev() of power
 domain drivers
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 4 Aug 2021 at 23:17, Dmitry Osipenko <digetx@gmail.com> wrote:
>
> 04.08.2021 12:59, Ulf Hansson =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Mon, 2 Aug 2021 at 20:23, Dmitry Osipenko <digetx@gmail.com> wrote:
> >>
> >> 02.08.2021 17:48, Ulf Hansson =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >> ...
> >>>> +       if (!list_empty(&genpd->child_links)) {
> >>>> +               link =3D list_first_entry(&genpd->child_links, struc=
t gpd_link,
> >>>> +                                       child_node);
> >>>> +               core_genpd =3D link->parent;
> >>>> +       } else {
> >>>> +               core_genpd =3D genpd;
> >>>> +       }
> >>>
> >>> This looks a bit odd to me. A genpd provider shouldn't need to walk
> >>> these links as these are considered internals to genpd. Normally this
> >>> needs lockings, etc.
> >>>
> >>> Why exactly do you need this?
> >>
> >> We have a chain of PMC domain -> core domain, both domains are created
> >> and liked together by this PMC driver. Devices are attached to either
> >> PMC domain or to core domain. PMC domain doesn't handle the performanc=
e
> >> changes, performance requests go down to the core domain.
> >
> > Did I get this right? The core domain is the parent to the PMC domain?
>
> You got this right.
>
> >>
> >> This is needed in order to translate the device's OPP into performance
> >> state of the core domain, based on the domain to which device is attac=
hed.
> >
> > So, the PMC domain doesn't have an OPP table associated with it, but
> > some of its attached devices may still have available OPPs, which
> > should be managed through the parent domain (core domain). Correct?
>
> Yes, the OPPs are specified only for the core domain.
>
> > Is there a DT patch in the series that I can look at that shows how
> > this is encoded?
>
> See patches which are adding domains and OPPs to DTs:
>
> https://patchwork.ozlabs.org/project/linux-tegra/patch/20210701232728.235=
91-34-digetx@gmail.com/
>
> https://patchwork.ozlabs.org/project/linux-tegra/patch/20210701232728.235=
91-35-digetx@gmail.com/

Thanks, this looks sane to me!

>
> > Hmm, I have the feeling that we should try to manage in some generic
> > way in genpd, rather than having to deal with it here.
>
> Still it requires a platform-specific knowledge. It could be some new
> genpd hook for the initialization. But I don't know what other platforms
> may want to initialize, so it's not clear to me how to make it generic.

Right. We may need some more thinking around this, if needed at all (see be=
low).

>
> >>>> +
> >>>> +       pd_opp_table =3D dev_pm_opp_get_opp_table(&core_genpd->dev);
> >>>> +       if (IS_ERR(pd_opp_table)) {
> >>>> +               dev_err(&genpd->dev, "failed to get OPP table of %s:=
 %pe\n",
> >>>> +                       dev_name(&core_genpd->dev), pd_opp_table);
> >>>> +               ret =3D PTR_ERR(pd_opp_table);
> >>>> +               goto put_dev_opp;
> >>>> +       }
> >>>> +
> >>>> +       pd_opp =3D dev_pm_opp_xlate_required_opp(opp_table, pd_opp_t=
able, opp);
> >>>> +       if (IS_ERR(pd_opp)) {
> >>>> +               dev_err(&genpd->dev,
> >>>> +                       "failed to xlate required OPP for %luHz of %=
s: %pe\n",
> >>>> +                       rate, dev_name(dev), pd_opp);
> >>>> +               ret =3D PTR_ERR(pd_opp);
> >>>> +               goto put_pd_opp_table;
> >>>> +       }
> >>>> +
> >>>> +       /*
> >>>> +        * The initialized state will be applied by GENPD core on th=
e first
> >>>> +        * RPM-resume of the device.  This means that drivers don't =
need to
> >>>> +        * explicitly initialize performance state.
> >>>> +        */
> >>>> +       state =3D pm_genpd_opp_to_performance_state(&core_genpd->dev=
, pd_opp);
> >>>> +       gpd_data->rpm_pstate =3D state;
> >>>
> >>> Could the above be replaced with Rajendra's suggestion [1], which
> >>> changes genpd to internally during attach, to set a default
> >>> performance state when there is a "required-opp" specified in the
> >>> device  node?
> >>
> >> It's not a "static" performance level here, but any level depending on
> >> h/w state left from bootloader and etc. The performance level
> >> corresponds to the voltage of the core domain, hence we need to
> >> initialize the voltage vote before device is resumed.
> >
> > Why not let the driver deal with this instead? It should be able to
> > probe its device, no matter what state the bootloader has put the
> > device into.
> >
> > To me, it sounds like a call to dev_pm_genpd_set_performance_state()
> > (perhaps via dev_pm_opp_set_opp() or dev_pm_opp_set_rate()) from the
> > driver itself, should be sufficient?
>
> We did that in a previous versions of this series where drivers were
> calling devm_tegra_core_dev_init_opp_table() helper during the probe to
> initialize performance state of the domain. Moving OPP state
> initialization into central place made drivers cleaner by removing the
> boilerplate code.

I am not against doing this in a central place, like $subject patch
suggests. As a matter of fact, it makes perfect sense to me.

However, what I am concerned about, is that you require to use genpd
internal data structures to do it. I think we should try to avoid
that.

>
> I can revert back to the previous variant, although this variant works
> well too.

I looked at that code and in that path we end up calling
dev_pm_opp_set_rate(), after it has initialized the opp table for the
device.

Rather than doing the OF parsing above to find out the current state
for the device, why can't you just call dev_pm_opp_set_rate() to
initialize a proper vote instead?

>
> > I understand that it means the domain may change the OPP during boot,
> > without respecting a vote for a device that has not been probed yet.
> > But is there a problem with this?
>
> Domains themselves don't change OPP, there is no problem with that. The
> point is to have cleaner code in the drivers.

Alright, this makes sense to me as well.

Kind regards
Uffe
