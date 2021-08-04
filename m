Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2571F3DFE98
	for <lists+linux-pm@lfdr.de>; Wed,  4 Aug 2021 12:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237309AbhHDKAX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Aug 2021 06:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236397AbhHDKAX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Aug 2021 06:00:23 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09445C0613D5
        for <linux-pm@vger.kernel.org>; Wed,  4 Aug 2021 03:00:11 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id k24so696023vsg.9
        for <linux-pm@vger.kernel.org>; Wed, 04 Aug 2021 03:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KZQURuUvCTt1Dtzvc06E1K1bLOJD8iseyaRl8XN5Pfc=;
        b=hLsLtCjOZNf8KRF5d/vdQ9oZuNAoT9Eg3LqcwzTR1WqqPznTHVqfZ7QC5CE4teJJOE
         vJROdJstvA+WA5mLYhAzMDB1DIxd5ywVPl9xMCFBIh1nUiTgw4Ph+dkj8D9SzUXKA6fZ
         sVa8WeDimt4VpSJ8VnXxHAmqb8yztQWS7mn+vpYKF1rfotJmVW8TYetCigqq/FVr7uNx
         531UgugUZQaVtyfqyl9eLDl7+/Lms+2Cc9uwWWjTqJfI79kJFFB8mZjP069zbQcQniDe
         1bMS/4FMCNWGqUH1zGD6cnkYxxDtYopR7XSSzLLSqOsWrvu8ZUZz5EusoKUKcEpo00ps
         0LAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KZQURuUvCTt1Dtzvc06E1K1bLOJD8iseyaRl8XN5Pfc=;
        b=iyBId7Fl4LZJPeHkYLqlIVfJTQ94K6rRLmi5jxgft6V3nJdL9ObaIPlJZ0IR2xRzn4
         h7buMUQd5IbeQW+wMVXpwf4yihEkpIp1a6oM84cvzU7ux/pqqm+BUK/b3nIvigvOC8Va
         5ptlgODOylpKdVBSeSZnPB9/HOFDf5T64rhqjaR1BSEgsju3CfgUNsbkFailE+M9o7y4
         rbUhHMRtQs33vWjXQHu8e1J4ULohLWbVHWeYxT/MwF9EkZKezwycRd1++7ZqupdUhtTr
         diYgWNqsl67ZKF6WDZk7iTQETNOwKibWxKOPmb7mJ2MXnrsuokkUC6ws1mYz3T8vs72A
         IweQ==
X-Gm-Message-State: AOAM530MuQZa2Wlz1Yzcy7VOcKMC6C+prYmVn/jHrOlG/CJNp8lBsqYO
        RVujMaEq3eWqtBss0IbrUG1xIOnM6CL1FsT5Msqq0A==
X-Google-Smtp-Source: ABdhPJxbm5Y/wyGvHg385WeEq/rdxsg9pBpHshQlE18FxBQCwqaKoec7NnZjlIGraYbQyO4/D4SyyrqC1cHImBk2U4o=
X-Received: by 2002:a67:328f:: with SMTP id y137mr16927749vsy.34.1628071210155;
 Wed, 04 Aug 2021 03:00:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210701232728.23591-1-digetx@gmail.com> <20210701232728.23591-3-digetx@gmail.com>
 <CAPDyKFrtWDYJo_NjS8306Z9ykbg7XZ55jC9hKEBMGkcrx1=4kQ@mail.gmail.com> <1034458d-78e0-5036-e278-6fee5d0d75ac@gmail.com>
In-Reply-To: <1034458d-78e0-5036-e278-6fee5d0d75ac@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 4 Aug 2021 11:59:33 +0200
Message-ID: <CAPDyKFoafAk72Kw6X7626Niduaii0V5VM4dGSWmq+e3JTh7VRg@mail.gmail.com>
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

On Mon, 2 Aug 2021 at 20:23, Dmitry Osipenko <digetx@gmail.com> wrote:
>
> 02.08.2021 17:48, Ulf Hansson =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> ...
> >> +       if (!list_empty(&genpd->child_links)) {
> >> +               link =3D list_first_entry(&genpd->child_links, struct =
gpd_link,
> >> +                                       child_node);
> >> +               core_genpd =3D link->parent;
> >> +       } else {
> >> +               core_genpd =3D genpd;
> >> +       }
> >
> > This looks a bit odd to me. A genpd provider shouldn't need to walk
> > these links as these are considered internals to genpd. Normally this
> > needs lockings, etc.
> >
> > Why exactly do you need this?
>
> We have a chain of PMC domain -> core domain, both domains are created
> and liked together by this PMC driver. Devices are attached to either
> PMC domain or to core domain. PMC domain doesn't handle the performance
> changes, performance requests go down to the core domain.

Did I get this right? The core domain is the parent to the PMC domain?

>
> This is needed in order to translate the device's OPP into performance
> state of the core domain, based on the domain to which device is attached=
.

So, the PMC domain doesn't have an OPP table associated with it, but
some of its attached devices may still have available OPPs, which
should be managed through the parent domain (core domain). Correct?

Is there a DT patch in the series that I can look at that shows how
this is encoded?

Hmm, I have the feeling that we should try to manage in some generic
way in genpd, rather than having to deal with it here.

>
> >> +
> >> +       pd_opp_table =3D dev_pm_opp_get_opp_table(&core_genpd->dev);
> >> +       if (IS_ERR(pd_opp_table)) {
> >> +               dev_err(&genpd->dev, "failed to get OPP table of %s: %=
pe\n",
> >> +                       dev_name(&core_genpd->dev), pd_opp_table);
> >> +               ret =3D PTR_ERR(pd_opp_table);
> >> +               goto put_dev_opp;
> >> +       }
> >> +
> >> +       pd_opp =3D dev_pm_opp_xlate_required_opp(opp_table, pd_opp_tab=
le, opp);
> >> +       if (IS_ERR(pd_opp)) {
> >> +               dev_err(&genpd->dev,
> >> +                       "failed to xlate required OPP for %luHz of %s:=
 %pe\n",
> >> +                       rate, dev_name(dev), pd_opp);
> >> +               ret =3D PTR_ERR(pd_opp);
> >> +               goto put_pd_opp_table;
> >> +       }
> >> +
> >> +       /*
> >> +        * The initialized state will be applied by GENPD core on the =
first
> >> +        * RPM-resume of the device.  This means that drivers don't ne=
ed to
> >> +        * explicitly initialize performance state.
> >> +        */
> >> +       state =3D pm_genpd_opp_to_performance_state(&core_genpd->dev, =
pd_opp);
> >> +       gpd_data->rpm_pstate =3D state;
> >
> > Could the above be replaced with Rajendra's suggestion [1], which
> > changes genpd to internally during attach, to set a default
> > performance state when there is a "required-opp" specified in the
> > device  node?
>
> It's not a "static" performance level here, but any level depending on
> h/w state left from bootloader and etc. The performance level
> corresponds to the voltage of the core domain, hence we need to
> initialize the voltage vote before device is resumed.

Why not let the driver deal with this instead? It should be able to
probe its device, no matter what state the bootloader has put the
device into.

To me, it sounds like a call to dev_pm_genpd_set_performance_state()
(perhaps via dev_pm_opp_set_opp() or dev_pm_opp_set_rate()) from the
driver itself, should be sufficient?

I understand that it means the domain may change the OPP during boot,
without respecting a vote for a device that has not been probed yet.
But is there a problem with this?

Kind regards
Uffe
