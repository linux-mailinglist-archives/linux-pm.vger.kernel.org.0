Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A483D39714F
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jun 2021 12:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233064AbhFAKWG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Jun 2021 06:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232246AbhFAKWF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Jun 2021 06:22:05 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11405C061574
        for <linux-pm@vger.kernel.org>; Tue,  1 Jun 2021 03:20:22 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id n61so8144951uan.2
        for <linux-pm@vger.kernel.org>; Tue, 01 Jun 2021 03:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9a/4E+eDANu580w78P8HsaohwCi1gc1B4hNnRG6cDxQ=;
        b=am4gi44g3dc3NWry70Tvm4bqq62bJFd848yVYCKumbBnXGCKkTL8lvrEvB5VL30VxG
         PwiqdmH2MKzW1cgE+rbMMzwhPfKiz9tqOcAmfJc2IhEfSXcw3KazRZEHXTsqti8aTsys
         5aD3/7nxJC7YZ9P3rKbUE7n9X0w7XKiRrHK5Z4NBrePfeyGWCxYromgaNr4snXxYFk2j
         YJtUtBc4kveGVVVbdtXxdGIfGjDPai36xB5kTi5CFlakEe9/b86QIOKXaq7ICC99/aGl
         e4KiJgieVP8hBsnPSPLX7HEOq21EwtK6ezEtOankTF9/JWlPbWv8TiH6uosOL0K1sTAQ
         npmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9a/4E+eDANu580w78P8HsaohwCi1gc1B4hNnRG6cDxQ=;
        b=Jys9X/peAz06DOUqWCwZDMKEbNj2OUodl8/tC3RknKuFqm0GWGGLKQSN4zOjoD5VVC
         TxyRgBEARPPhcKup9eefHbOnwsGG2aerxjql0aKZjZcBFNAYZvAjFdqHKm3JNYrEClVO
         icWqYEwU5lNCWPpWtxkuV+LmiKYBLNRa3EmTwew37vW5S+VS/h8p7Q+V4wWiHJFImOEY
         2/jjEsdym1dSckNhfliH3YpTDlCWGdwoWZY6LEAs8sl6gykrBoeu36BURGujavHD9nHG
         BX4GokWKTTupHHALlDtkp15QRUIJtDb3DADxX7CBYrv1LrVKmO2BizIxqS0T71bDegTP
         0JOg==
X-Gm-Message-State: AOAM533HGuG88AgRRdxCRG89mvs0zE95XsheBDuocT+JW5nEPLw05pjL
        HLoO+J7hkYYyVE5MrP+yrJGf5zGtFRZqVNPk7yaQXw==
X-Google-Smtp-Source: ABdhPJz+0nlJ2zXwuh4WAeWuNuwplVezKmdknpmnu9kFopjPZe3Uh6Fdv7a/1HwadzNSOqCd1Nj8VkbG4zTICht8KBw=
X-Received: by 2002:a1f:9542:: with SMTP id x63mr16377461vkd.15.1622542820972;
 Tue, 01 Jun 2021 03:20:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210523231335.8238-1-digetx@gmail.com> <20210523231335.8238-14-digetx@gmail.com>
 <CAPDyKFrto2cosX3Ben_QWCYVqgeoF1Yv=8gEx4Y86WNyjeHvdg@mail.gmail.com>
 <f0b1bea7-0752-5584-8bcc-d8b602f22c13@gmail.com> <CAPDyKFq0EpVjUg9RV7qR3_qywUQHKqStPNSFY==6AFBNC6m3KQ@mail.gmail.com>
 <3d8d195f-d325-1b27-21f4-c1fb593678d1@gmail.com>
In-Reply-To: <3d8d195f-d325-1b27-21f4-c1fb593678d1@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 1 Jun 2021 12:19:44 +0200
Message-ID: <CAPDyKFqktwCWMBDcoa7HDg6aCayPSSYG5QkekaxPaiL6kgAZmQ@mail.gmail.com>
Subject: Re: [PATCH v2 13/14] soc/tegra: pmc: Add core power domain
To:     Dmitry Osipenko <digetx@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        =?UTF-8?Q?Nikola_Milosavljevi=C4=87?= <mnidza@outlook.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
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

On Mon, 31 May 2021 at 22:07, Dmitry Osipenko <digetx@gmail.com> wrote:
>
> 31.05.2021 16:17, Ulf Hansson =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Mon, 24 May 2021 at 22:23, Dmitry Osipenko <digetx@gmail.com> wrote:
> >>
> >> 24.05.2021 20:04, Ulf Hansson =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >>> On Mon, 24 May 2021 at 01:13, Dmitry Osipenko <digetx@gmail.com> wrot=
e:
> >>>>
> >>>> NVIDIA Tegra SoCs have multiple power domains, each domain correspon=
ds
> >>>> to an external SoC power rail. Core power domain covers vast majorit=
y of
> >>>> hardware blocks within a Tegra SoC. The voltage of a power domain sh=
ould
> >>>> be set to a level which satisfies all devices within the power domai=
n.
> >>>> Add support for the core power domain which controls voltage state o=
f the
> >>>> domain. This allows us to support system-wide DVFS on Tegra20-210 So=
Cs.
> >>>> The PMC powergate domains now are sub-domains of the core domain, th=
is
> >>>> requires device-tree updating, older DTBs are unaffected.
> >>>>
> >>>> Tested-by: Peter Geis <pgwipeout@gmail.com> # Ouya T30
> >>>> Tested-by: Paul Fertser <fercerpav@gmail.com> # PAZ00 T20
> >>>> Tested-by: Nicolas Chauvet <kwizart@gmail.com> # PAZ00 T20 and TK1 T=
124
> >>>> Tested-by: Matt Merhar <mattmerhar@protonmail.com> # Ouya T30
> >>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> >>>
> >>> [...]
> >>>
> >>>> +
> >>>> +static int tegra_pmc_core_pd_add(struct tegra_pmc *pmc, struct devi=
ce_node *np)
> >>>> +{
> >>>> +       static struct lock_class_key tegra_core_domain_lock_class;
> >>>> +       struct generic_pm_domain *genpd;
> >>>> +       const char *rname =3D "core";
> >>>> +       int err;
> >>>> +
> >>>> +       genpd =3D devm_kzalloc(pmc->dev, sizeof(*genpd), GFP_KERNEL)=
;
> >>>> +       if (!genpd)
> >>>> +               return -ENOMEM;
> >>>> +
> >>>> +       genpd->name =3D np->name;
> >>>> +       genpd->set_performance_state =3D tegra_pmc_core_pd_set_perfo=
rmance_state;
> >>>> +       genpd->opp_to_performance_state =3D tegra_pmc_core_pd_opp_to=
_performance_state;
> >>>> +
> >>>> +       err =3D devm_pm_opp_set_regulators(pmc->dev, &rname, 1);
> >>>> +       if (err)
> >>>> +               return dev_err_probe(pmc->dev, err,
> >>>> +                                    "failed to set core OPP regulat=
or\n");
> >>>> +
> >>>> +       err =3D pm_genpd_init(genpd, NULL, false);
> >>>> +       if (err) {
> >>>> +               dev_err(pmc->dev, "failed to init core genpd: %d\n",=
 err);
> >>>> +               return err;
> >>>> +       }
> >>>> +
> >>>> +       /*
> >>>> +        * We have a "PMC pwrgate -> Core" hierarchy of the power do=
mains
> >>>> +        * where PMC needs to resume and change performance (voltage=
) of the
> >>>> +        * Core domain from the PMC GENPD on/off callbacks, hence we=
 need
> >>>> +        * to annotate the lock in order to remove confusion from th=
e
> >>>> +        * lockdep checker when a nested access happens.
> >>>> +        */
> >>>
> >>> Can you elaborate a bit more on this?
> >>>
> >>> Are you saying that when the child domain (PMC pwrgate) gets powered
> >>> off, you want to drop its aggregated votes it may hold for the
> >>> performance state, as otherwise it may affect the parent domain (core
> >>> domain)?
> >>
> >> Yes, in particular we want to remove/add the performance vote when clk=
 is disabled/enabled, see tegra_clock_runtime_resume/suspend() of the clk-r=
untimePM driver [1]. I'll send that clk patch separately once this series a=
nd some other tegra-clk patches will be merged, otherwise there are too man=
y dependencies and it's too difficult to review.
> >
> > You are likely correct from the merging point of view, but for
> > completeness I would prefer to look at the whole series. Would you
> > mind folding in some of these changes too?
>
> Sure, I will send those changes once this fundamental patchset will be me=
rged.
>
> >> [1] https://patchwork.ozlabs.org/project/linux-tegra/patch/20201217180=
638.22748-33-digetx@gmail.com/
> >
> > Hmm. In general, the new changes to genpd and the opp library with
> > "performance states" for DVFS, should help to avoid using clock rate
> > notifications.
> >
> > Instead of updating the performance votes from the clock provider
> > driver, the more proper thing would be to let the clock consumer
> > driver (various drivers) to call dev_pm_opp_set_rate() when it needs
> > to move to a new OPP. This also means calling dev_pm_opp_set_rate(dev,
> > 0) when the votes for an OPP can be dropped.
> >
> > In this way, the opp library will call genpd to update the performance
> > state vote for the corresponding device.
>
> This is not sufficient for Tegra because we have individual OPP tables fo=
r the root PLLs, system clocks and device clocks. The device clocks could b=
e muxed to a different PLLs, depending on clk requirements of a particular =
board.

Are you saying that the clock providers for the "root PLLs" and
"system clocks" have OPP tables themselves? If so, would you mind
posting a patch for an updated DT binding for these changes, so it can
be discussed separately?

>
> >> Please see the example lockdep trace in the end of the email that is f=
ixed by the mutex annotation. What we have there is the tegra-host1x device=
 driver that resumes PMC powergate domain on Tegra30, the PMC driver enable=
s clock from the genpd.power_on callback of the powergate domain and this p=
ropagates to the clock's RPM callback which sets the performance vote of th=
e core domain. Hence core domain vote is set from within of the powergate d=
omain.
> >
> > Right, this sounds like a fragile looking path. Are you sure it can't
> > lead into deadlock situations?
>
> The locking was a concern, but turned out that it works nicely for the Te=
gra clk/power tree. This approach may not be suitable for other SoCs.
>
> > In any case, we designed dev_pm_opp_set_rate() (and its friends in
> > genpd) with these locking issues in mind.
>
> The device drivers don't manage the parent clocks directly and OPP core d=
oesn't support this use-case where OPP needs to be applied to a generic/par=
ent PLL clock. Moving the OPP management to the clk driver is the easy solu=
tion which works good in practice for Tegra, it also removes a need to swit=
ch each driver to dev_pm_opp_set_rate() usage.

I admit, if clock consumer drivers could avoid calling
dev_pm_opp_set_rate|opp(), that would be nice. But, as I stated, it's
a fragile path from locking point of view, to call
dev_pm_opp_set_rate|opp() from a clock provider driver. Personally, I
think it's better to avoid it.

More importantly, you also need to convince the clock subsystem
maintainers, that setting an OPP internally from the clock provider
driver is a good idea. As far as I can tell, they have said *no* to
this, since the common clock framework was invented, I believe for
good reasons.

>
> >>> I guess this would be a valid scenario to optimize for, especially if
> >>> you have more than one child domain of the core power domain, right?
> >>>
> >>> If you have only one child domain, would it be sufficient to assign
> >>> ->power_on|off() callbacks for the core domain and deal with the
> >>> performance stare votes from there instead?
> >>
> >> The core domain is the parent domain of the PMC domains + some devices=
 directly belong to the core domain. The GENPD core aggregates the performa=
nce votes from the children domains and from devices of the parent core, th=
is all works great already.
> >>
> >> It sounds to me that you're suggesting to reinvent the aggregation log=
ic within the PMC driver and create a fake hierarchy that doesn't match har=
dware. It won't help the lockdep warning anyways.
> >>
> >> I actually don't quite understand what problem you're trying to solve,=
 could you please explain? The lockdep warning is harmless, we just need to=
 annotate the mutex lock class.
> >>
> >> If you don't feel comfortable with the usage of lockdep_set_class() in=
 the driver, then maybe it should be possible to make it a part of the pm_g=
enpd_init(). For example like we did that for tegra-host1x driver recently =
[2].
> >
> > I was not trying to solve a problem, but was just curious and wanted
> > to ask about the reasons for the lockdep_set_class(), as it simply
> > caught my attention while reviewing.
> >
> > Looks like there may be something fishy going on, but let's see, I may =
be wrong.
> >
> >>
> >> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git=
/commit/?id=3Da24f98176d1efae2c37d3438c57a624d530d9c33
> >>
> >>
> >>  LOCKDEP
> >>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> ...
> >
> > Thanks for sharing the log.
> >
> > Could you perhaps point me to the corresponding DTS files. I would
> > like to understand more about the PM domain hierarchy and where the
> > clock controller may be located.
>
> https://github.com/grate-driver/linux/tree/master has all the latest vers=
ions of patches applied.
>
> For example please see clock@60006000 and pmc@7000e400 nodes of [1].
>
> [1] https://github.com/grate-driver/linux/blob/master/arch/arm/boot/dts/t=
egra30.dtsi

Thanks, that certainly helped me understand better!

I see that you want to add OPP tables to clock provider nodes. As I
said above, an updated DT binding is probably a good idea to discuss
separately.

>
> This is how output of pm_genpd_summary looks like on Tegra30 Nexus 7, whe=
re performance=3Dvoltage:
>
> domain                          status          children                 =
          performance
>     /device                                             runtime status
> -------------------------------------------------------------------------=
---------------------
> heg                             on                                       =
          1000000
>     /devices/soc0/50000000.host1x                       active           =
          1000000
>     /devices/soc0/50000000.host1x/540c0000.epp          suspended        =
          0
>     /devices/soc0/50000000.host1x/54140000.gr2d         suspended        =
          0
> mpe                             off-0                                    =
          0
>     /devices/soc0/50000000.host1x/54040000.mpe          suspended        =
          0
> vdec                            off-0                                    =
          0
>     /devices/soc0/6001a000.vde                          suspended        =
          0
> venc                            off-0                                    =
          0
>     /devices/soc0/50000000.host1x/54080000.vi           suspended        =
          0
>     /devices/soc0/50000000.host1x/54100000.isp          suspended        =
          0
> 3d1                             off-0                                    =
          0
>     /devices/genpd:1:54180000.gr3d                      suspended        =
          0
> 3d0                             off-0                                    =
          0
>     /devices/genpd:0:54180000.gr3d                      suspended        =
          0
> core-domain                     on                                       =
          1000000
>                                                 3d0, 3d1, venc, vdec, mpe=
, heg
>     /devices/soc0/7000f400.memory-controller            unsupported      =
          1000000
>     /devices/platform/tegra_clk_pll_c                   active           =
          1000000
>     /devices/platform/tegra_clk_pll_e                   suspended        =
          0
>     /devices/platform/tegra_clk_pll_m                   active           =
          1000000
>     /devices/platform/tegra_clk_sclk                    active           =
          1000000
>     /devices/platform/tegra_clk_dsia                    suspended        =
          0
>     /devices/platform/tegra_clk_dsib                    suspended        =
          0
>     /devices/platform/tegra_clk_spdif_out               suspended        =
          0
>     /devices/platform/tegra_clk_se                      suspended        =
          0
>     /devices/platform/tegra_clk_hdmi                    suspended        =
          0
>     /devices/platform/tegra_clk_pwm                     active           =
          1000000
>     /devices/platform/tegra_clk_pcie                    suspended        =
          0
>     /devices/platform/tegra_clk_afi                     suspended        =
          0
>     /devices/platform/tegra_clk_vde                     suspended        =
          0
>     /devices/platform/tegra_clk_vi                      suspended        =
          0
>     /devices/platform/tegra_clk_epp                     suspended        =
          0
>     /devices/platform/tegra_clk_mpe                     suspended        =
          0
>     /devices/platform/tegra_clk_nor                     suspended        =
          0
>     /devices/platform/tegra_clk_sdmmc1                  suspended        =
          0
>     /devices/platform/tegra_clk_sdmmc3                  active           =
          950000
>     /devices/platform/tegra_clk_mipi                    suspended        =
          0
>     /devices/platform/tegra_clk_sbc1                    suspended        =
          0
>     /devices/platform/tegra_clk_sbc2                    suspended        =
          0
>     /devices/platform/tegra_clk_sbc3                    suspended        =
          0
>     /devices/platform/tegra_clk_sbc4                    suspended        =
          0
>     /devices/platform/tegra_clk_sbc5                    suspended        =
          0
>     /devices/platform/tegra_clk_sbc6                    suspended        =
          0
>     /devices/platform/tegra_clk_cve                     suspended        =
          0
>     /devices/platform/tegra_clk_tvo                     suspended        =
          0
>     /devices/platform/tegra_clk_tvdac                   suspended        =
          0
>     /devices/platform/tegra_clk_ndflash                 suspended        =
          0
>     /devices/platform/tegra_clk_sata_oob                suspended        =
          0
>     /devices/platform/tegra_clk_sata                    suspended        =
          0
>     /devices/platform/tegra_clk_fuse_burn               suspended        =
          0
>     /devices/platform/tegra_clk_usbd                    active           =
          1000000
>     /devices/platform/tegra_clk_usb2                    suspended        =
          0
>     /devices/platform/tegra_clk_usb3                    suspended        =
          0
>     /devices/soc0/50000000.host1x/54200000.dc           active           =
          1000000
>     /devices/soc0/50000000.host1x/54240000.dc           suspended        =
          0

Okay, to not stall things from moving forward, may I suggest that you
simply drop the call to lockdep_set_class() (and the corresponding
comment) for now.

Then you can continue to post the next parts - and if it turns out
that lockdep_set_class() becomes needed, you can always add it back
then.

Kind regards
Uffe
