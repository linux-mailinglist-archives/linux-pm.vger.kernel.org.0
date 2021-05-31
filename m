Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AEB6395B98
	for <lists+linux-pm@lfdr.de>; Mon, 31 May 2021 15:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbhEaNW3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 May 2021 09:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232157AbhEaNUX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 May 2021 09:20:23 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7802C061345
        for <linux-pm@vger.kernel.org>; Mon, 31 May 2021 06:18:02 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id l12so900631uai.0
        for <linux-pm@vger.kernel.org>; Mon, 31 May 2021 06:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0kiA/djYgopisCEoPEc1VVGK9NnlXuTuQN3cSOOv10c=;
        b=RIk3MqIZGL/1MRmCsFcbvDOrePvzah8anu2l4fHgBF58z/s8i9OoyuW0xERsPeYa/y
         lqrHzYs4vq3ErYIn6yrMtmPmWv1yl2Z3t5TqTA8LuaTEccf6G5+7mNdceQWSut5AKyVJ
         ImIB3TiAe67HuAhO7jE7J8okBwmfrNQ16kATPC1uiIlqzndhIrMFc6PyBW56jeCQfSqg
         TK2i2f29Onu+ZwqqS8OA7+3sQqB9sOqcXd4T5Tl6QqsBCdD9w6+BLdfdGFNvNtSUyMeu
         6YM18nDk6GYkyIFuqPcgZSYmINrOxh8ABZZwfq/nnL4epY2/a9RX6Yv21R5eFdE5RvRp
         1ojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0kiA/djYgopisCEoPEc1VVGK9NnlXuTuQN3cSOOv10c=;
        b=jsqetpZIcJPxqLz4lCUtPQ1o8FVH+4OoexubVIRDeEbAW0sWtRarWAaa/xKOW2seFb
         hMqYa5qTvB/C+R3xtm750FsfM2YmnZinNwFUC4g41hvE9b0qO2OO+brDznqdjgXmVJTB
         QbWqSZGQc/KhbMfk14vV0OBX6K1X2WxGmZLL2Yn5f9Tp4X2A6DlzMuCdrD2jonxLIlKH
         U7pMSeLzJeKduQOfjVsuuloUGo5mG5PVmF6xpeQv/ChIK+nH8d6kmcr+067QSrNm8oln
         7HnL074Gm8VGchHO2j+IFgQaxWmErxjn58XGTccf4qtFonEhmt57yXDTIBHtjTNn6bJ5
         QN4w==
X-Gm-Message-State: AOAM532O1vG8rNhdDncN4g2YiJEsY6MZbswOFQlJEmGe0SHquowAep97
        zO4zxWmYWnFyTXas3/yKh0TOpUzJE20X5ddV9fgynQ==
X-Google-Smtp-Source: ABdhPJz3VoCnoUITku1d1/D6mME6LnMWJm0weinsXpBYkReFh3ZzqEgOyNPQLyQngZTRHChx8vt7LbJX27dzO0mb5Js=
X-Received: by 2002:ab0:12a:: with SMTP id 39mr9889704uak.19.1622467081738;
 Mon, 31 May 2021 06:18:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210523231335.8238-1-digetx@gmail.com> <20210523231335.8238-14-digetx@gmail.com>
 <CAPDyKFrto2cosX3Ben_QWCYVqgeoF1Yv=8gEx4Y86WNyjeHvdg@mail.gmail.com> <f0b1bea7-0752-5584-8bcc-d8b602f22c13@gmail.com>
In-Reply-To: <f0b1bea7-0752-5584-8bcc-d8b602f22c13@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 31 May 2021 15:17:24 +0200
Message-ID: <CAPDyKFq0EpVjUg9RV7qR3_qywUQHKqStPNSFY==6AFBNC6m3KQ@mail.gmail.com>
Subject: Re: [PATCH v2 13/14] soc/tegra: pmc: Add core power domain
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        =?UTF-8?Q?Nikola_Milosavljevi=C4=87?= <mnidza@outlook.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Paul Fertser <fercerpav@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 24 May 2021 at 22:23, Dmitry Osipenko <digetx@gmail.com> wrote:
>
> 24.05.2021 20:04, Ulf Hansson =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Mon, 24 May 2021 at 01:13, Dmitry Osipenko <digetx@gmail.com> wrote:
> >>
> >> NVIDIA Tegra SoCs have multiple power domains, each domain corresponds
> >> to an external SoC power rail. Core power domain covers vast majority =
of
> >> hardware blocks within a Tegra SoC. The voltage of a power domain shou=
ld
> >> be set to a level which satisfies all devices within the power domain.
> >> Add support for the core power domain which controls voltage state of =
the
> >> domain. This allows us to support system-wide DVFS on Tegra20-210 SoCs=
.
> >> The PMC powergate domains now are sub-domains of the core domain, this
> >> requires device-tree updating, older DTBs are unaffected.
> >>
> >> Tested-by: Peter Geis <pgwipeout@gmail.com> # Ouya T30
> >> Tested-by: Paul Fertser <fercerpav@gmail.com> # PAZ00 T20
> >> Tested-by: Nicolas Chauvet <kwizart@gmail.com> # PAZ00 T20 and TK1 T12=
4
> >> Tested-by: Matt Merhar <mattmerhar@protonmail.com> # Ouya T30
> >> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> >
> > [...]
> >
> >> +
> >> +static int tegra_pmc_core_pd_add(struct tegra_pmc *pmc, struct device=
_node *np)
> >> +{
> >> +       static struct lock_class_key tegra_core_domain_lock_class;
> >> +       struct generic_pm_domain *genpd;
> >> +       const char *rname =3D "core";
> >> +       int err;
> >> +
> >> +       genpd =3D devm_kzalloc(pmc->dev, sizeof(*genpd), GFP_KERNEL);
> >> +       if (!genpd)
> >> +               return -ENOMEM;
> >> +
> >> +       genpd->name =3D np->name;
> >> +       genpd->set_performance_state =3D tegra_pmc_core_pd_set_perform=
ance_state;
> >> +       genpd->opp_to_performance_state =3D tegra_pmc_core_pd_opp_to_p=
erformance_state;
> >> +
> >> +       err =3D devm_pm_opp_set_regulators(pmc->dev, &rname, 1);
> >> +       if (err)
> >> +               return dev_err_probe(pmc->dev, err,
> >> +                                    "failed to set core OPP regulator=
\n");
> >> +
> >> +       err =3D pm_genpd_init(genpd, NULL, false);
> >> +       if (err) {
> >> +               dev_err(pmc->dev, "failed to init core genpd: %d\n", e=
rr);
> >> +               return err;
> >> +       }
> >> +
> >> +       /*
> >> +        * We have a "PMC pwrgate -> Core" hierarchy of the power doma=
ins
> >> +        * where PMC needs to resume and change performance (voltage) =
of the
> >> +        * Core domain from the PMC GENPD on/off callbacks, hence we n=
eed
> >> +        * to annotate the lock in order to remove confusion from the
> >> +        * lockdep checker when a nested access happens.
> >> +        */
> >
> > Can you elaborate a bit more on this?
> >
> > Are you saying that when the child domain (PMC pwrgate) gets powered
> > off, you want to drop its aggregated votes it may hold for the
> > performance state, as otherwise it may affect the parent domain (core
> > domain)?
>
> Yes, in particular we want to remove/add the performance vote when clk is=
 disabled/enabled, see tegra_clock_runtime_resume/suspend() of the clk-runt=
imePM driver [1]. I'll send that clk patch separately once this series and =
some other tegra-clk patches will be merged, otherwise there are too many d=
ependencies and it's too difficult to review.

You are likely correct from the merging point of view, but for
completeness I would prefer to look at the whole series. Would you
mind folding in some of these changes too?

>
> [1] https://patchwork.ozlabs.org/project/linux-tegra/patch/20201217180638=
.22748-33-digetx@gmail.com/

Hmm. In general, the new changes to genpd and the opp library with
"performance states" for DVFS, should help to avoid using clock rate
notifications.

Instead of updating the performance votes from the clock provider
driver, the more proper thing would be to let the clock consumer
driver (various drivers) to call dev_pm_opp_set_rate() when it needs
to move to a new OPP. This also means calling dev_pm_opp_set_rate(dev,
0) when the votes for an OPP can be dropped.

In this way, the opp library will call genpd to update the performance
state vote for the corresponding device.

>
> Please see the example lockdep trace in the end of the email that is fixe=
d by the mutex annotation. What we have there is the tegra-host1x device dr=
iver that resumes PMC powergate domain on Tegra30, the PMC driver enables c=
lock from the genpd.power_on callback of the powergate domain and this prop=
agates to the clock's RPM callback which sets the performance vote of the c=
ore domain. Hence core domain vote is set from within of the powergate doma=
in.

Right, this sounds like a fragile looking path. Are you sure it can't
lead into deadlock situations?

In any case, we designed dev_pm_opp_set_rate() (and its friends in
genpd) with these locking issues in mind.

>
> > I guess this would be a valid scenario to optimize for, especially if
> > you have more than one child domain of the core power domain, right?
> >
> > If you have only one child domain, would it be sufficient to assign
> > ->power_on|off() callbacks for the core domain and deal with the
> > performance stare votes from there instead?
>
> The core domain is the parent domain of the PMC domains + some devices di=
rectly belong to the core domain. The GENPD core aggregates the performance=
 votes from the children domains and from devices of the parent core, this =
all works great already.
>
> It sounds to me that you're suggesting to reinvent the aggregation logic =
within the PMC driver and create a fake hierarchy that doesn't match hardwa=
re. It won't help the lockdep warning anyways.
>
> I actually don't quite understand what problem you're trying to solve, co=
uld you please explain? The lockdep warning is harmless, we just need to an=
notate the mutex lock class.
>
> If you don't feel comfortable with the usage of lockdep_set_class() in th=
e driver, then maybe it should be possible to make it a part of the pm_genp=
d_init(). For example like we did that for tegra-host1x driver recently [2]=
.

I was not trying to solve a problem, but was just curious and wanted
to ask about the reasons for the lockdep_set_class(), as it simply
caught my attention while reviewing.

Looks like there may be something fishy going on, but let's see, I may be w=
rong.

>
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3Da24f98176d1efae2c37d3438c57a624d530d9c33
>
>
>  LOCKDEP
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  WARNING: possible recursive locking detected
>  5.13.0-rc3-next-20210524-00202-g80a288f17147-dirty #7935 Tainted: G     =
   W
>  --------------------------------------------
>  kworker/u8:2/96 is trying to acquire lock:
>  c202e494 (&genpd->mlock){+.+.}-{3:3}, at: genpd_runtime_resume+0x95/0x17=
4
>
>                but task is already holding lock:
>  c35d9454 (&genpd->mlock){+.+.}-{3:3}, at: genpd_runtime_resume+0x95/0x17=
4
>
>                other info that might help us debug this:
>   Possible unsafe locking scenario:
>
>         CPU0
>         ----
>    lock(&genpd->mlock);
>    lock(&genpd->mlock);
>
>                 *** DEADLOCK ***
>
>   May be due to missing lock nesting notation
>
>  5 locks held by kworker/u8:2/96:
>   #0: c2024ea8 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_o=
ne_work+0x15a/0x600
>   #1: c2a31f20 (deferred_probe_work){+.+.}-{0:0}, at: process_one_work+0x=
15a/0x600
>   #2: c35f04d8 (&dev->mutex){....}-{3:3}, at: __device_attach+0x29/0xdc
>   #3: c35d9454 (&genpd->mlock){+.+.}-{3:3}, at: genpd_runtime_resume+0x95=
/0x174
>   #4: c13fbbcc (prepare_lock){+.+.}-{3:3}, at: clk_prepare_lock+0x17/0xac
>
>                stack backtrace:
>  CPU: 0 PID: 96 Comm: kworker/u8:2 Tainted: G        W         5.13.0-rc3=
-next-20210524-00202-g80a288f17147-dirty #7935
>  Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
>  Workqueue: events_unbound deferred_probe_work_func
>  [<c010d1cd>] (unwind_backtrace) from [<c0109639>] (show_stack+0x11/0x14)
>  [<c0109639>] (show_stack) from [<c0ba6dab>] (dump_stack_lvl+0x97/0xb0)
>  [<c0ba6dab>] (dump_stack_lvl) from [<c017b24f>] (__lock_acquire+0x7fb/0x=
2534)
>  [<c017b24f>] (__lock_acquire) from [<c017d75b>] (lock_acquire+0xf3/0x424=
)
>  [<c017d75b>] (lock_acquire) from [<c0bb0daf>] (__mutex_lock+0x87/0x7f4)
>  [<c0bb0daf>] (__mutex_lock) from [<c0bb1535>] (mutex_lock_nested+0x19/0x=
20)
>  [<c0bb1535>] (mutex_lock_nested) from [<c0669ced>] (genpd_runtime_resume=
+0x95/0x174)
>  [<c0669ced>] (genpd_runtime_resume) from [<c0660167>] (__rpm_callback+0x=
7b/0xc8)
>  [<c0660167>] (__rpm_callback) from [<c06601cd>] (rpm_callback+0x19/0x60)
>  [<c06601cd>] (rpm_callback) from [<c065fde3>] (rpm_resume+0x47f/0x65c)
>  [<c065fde3>] (rpm_resume) from [<c066000f>] (__pm_runtime_resume+0x4f/0x=
78)
>  [<c066000f>] (__pm_runtime_resume) from [<c05857f7>] (clk_pm_runtime_get=
.part.0+0x13/0x54)
>  [<c05857f7>] (clk_pm_runtime_get.part.0) from [<c05881e9>] (clk_core_set=
_rate_nolock+0x81/0x1cc)
>  [<c05881e9>] (clk_core_set_rate_nolock) from [<c0588353>] (clk_set_rate+=
0x1f/0x44)
>  [<c0588353>] (clk_set_rate) from [<c0597cd3>] (tegra_powergate_prepare_c=
locks+0x2f/0x94)
>  [<c0597cd3>] (tegra_powergate_prepare_clocks) from [<c059a4d1>] (tegra_p=
owergate_power_up+0x45/0xec)
>  [<c059a4d1>] (tegra_powergate_power_up) from [<c0ba7211>] (tegra_genpd_p=
ower_on+0x2b/0x50)
>  [<c0ba7211>] (tegra_genpd_power_on) from [<c0667231>] (_genpd_power_on+0=
x6d/0xb8)
>  [<c0667231>] (_genpd_power_on) from [<c066999d>] (genpd_power_on.part.0+=
0x85/0xf0)
>  [<c066999d>] (genpd_power_on.part.0) from [<c0669cfb>] (genpd_runtime_re=
sume+0xa3/0x174)
>  [<c0669cfb>] (genpd_runtime_resume) from [<c0660167>] (__rpm_callback+0x=
7b/0xc8)
>  [<c0660167>] (__rpm_callback) from [<c06601cd>] (rpm_callback+0x19/0x60)
>  [<c06601cd>] (rpm_callback) from [<c065fde3>] (rpm_resume+0x47f/0x65c)
>  [<c065fde3>] (rpm_resume) from [<c066000f>] (__pm_runtime_resume+0x4f/0x=
78)
>  [<c066000f>] (__pm_runtime_resume) from [<c065675f>] (__device_attach+0x=
83/0xdc)
>  [<c065675f>] (__device_attach) from [<c0655d55>] (bus_probe_device+0x5d/=
0x64)
>  [<c0655d55>] (bus_probe_device) from [<c06560b7>] (deferred_probe_work_f=
unc+0x63/0x88)
>  [<c06560b7>] (deferred_probe_work_func) from [<c0139993>] (process_one_w=
ork+0x1eb/0x600)
>  [<c0139993>] (process_one_work) from [<c0139fcf>] (worker_thread+0x227/0=
x3bc)
>  [<c0139fcf>] (worker_thread) from [<c0140ab3>] (kthread+0x13f/0x15c)
>  [<c0140ab3>] (kthread) from [<c0100159>] (ret_from_fork+0x11/0x38)
>  Exception stack(0xc2a31fb0 to 0xc2a31ff8)

Thanks for sharing the log.

Could you perhaps point me to the corresponding DTS files. I would
like to understand more about the PM domain hierarchy and where the
clock controller may be located.

Kind regards
Uffe
