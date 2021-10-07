Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B472424FEC
	for <lists+linux-pm@lfdr.de>; Thu,  7 Oct 2021 11:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240517AbhJGJVY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Oct 2021 05:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240518AbhJGJVS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Oct 2021 05:21:18 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5915EC061760
        for <linux-pm@vger.kernel.org>; Thu,  7 Oct 2021 02:19:25 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id y26so22376944lfa.11
        for <linux-pm@vger.kernel.org>; Thu, 07 Oct 2021 02:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lm42Xwh2Jm/bg7CFlkLuIvFq/6TymtSrcpKOF86TZ4E=;
        b=kHtkBo9ZhQK5B1g4gzDepRMdzKt0BA7KDm9S+bG1ZgKaspEmsSEi4cACZ4QVhoSXMX
         LAfkFrgrWPpYUQwgbd/jFB/KmVdrQAyHi9LRYCkY0mLjcj0rcs/pG+L9ji8mf5hkwZWm
         oCET0LSGZwPR2S/Po4ecuyfXN/LJokwrNRtgoDL7jxNUmhQLR1EDjkk9LPBIRez4RyVc
         eTHY3LyShSYeeYkfxXuXf+koCknCWj8EK3Cs9ygH5Mk1jcwi12qvbyJ7fIHV9isXv1Us
         jGyfzeq8NNyvrlER3/UOZSyUDyr38dWbguKbn5rCOcG20K3+07f6jhOEXzDPnPAMKvBl
         2ylg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lm42Xwh2Jm/bg7CFlkLuIvFq/6TymtSrcpKOF86TZ4E=;
        b=uy2x5dpLDfQnnGQ6h0n6iz2ddWJqI6VwJBqWBw7G9wqzEI358telMU+LfGKUaKvDYV
         xFICr5D5vEMf//mUTuditalfd+SfiBfQGmUmnnhU76bFlDtfMIlR1Vb6u0ndEJNiMkYv
         64TCa+hFtfBYagMC2qwP3SyqLhAwEUfrZGPrGQZrpqoEfJGwgjkbk0z+7BOqqJRzIQPO
         JPaYXTW3OIOqGDN7vFWdRGb2Xj+I6q5/Vm4+Kq/IWlkAecxvI5iY4yOCNEMewP4XQB3l
         n7gST9U2lI9TWn/nz951RcPCAiMZ7dlfztkvCjMlymqeHa3ryyqombVHTArSF80rphNp
         WR0Q==
X-Gm-Message-State: AOAM532VIEYbjFtvAUMJwSqPWYHU09rrnmAMqCQGaMsYHXoydpi317/N
        cQZuEY5qsVqWq75SKSh6H7BP2A7KHHueTBK+YcfnNg==
X-Google-Smtp-Source: ABdhPJyLVYNwO6wH7UjbrvAKZXt6rP/z5UNYySvnmg5CD1b+EuFOoKR5sbXNeY4a58mDR28IUl9i55ImMkilW9q3b14=
X-Received: by 2002:a05:6512:3095:: with SMTP id z21mr3161687lfd.167.1633598363639;
 Thu, 07 Oct 2021 02:19:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210926224058.1252-1-digetx@gmail.com> <20210926224058.1252-7-digetx@gmail.com>
 <CAPDyKFq+LS4Jr1GyC-a-tGWPzGH0JxfJ9wKY=uQEBGYm952azw@mail.gmail.com>
 <24101cd6-d3f5-1e74-db39-145ecd30418b@gmail.com> <CAPDyKFreK7976PJL-1zySoza_yXM7rMQ64aODWUZ+U3L-uCa0w@mail.gmail.com>
 <4bdba8a2-4b9b-ed7d-e6ca-9218d8200a85@gmail.com> <74a47158-e2e4-5fd0-3f37-0b50d4ead4d9@gmail.com>
 <CAPDyKFr2-f1wM+6jF9vWJ-Nq80Zg1Z3qFP6saULOrBi1270HGw@mail.gmail.com>
 <b06bf794-b8b3-417b-58ef-4d815ca86c95@gmail.com> <4c7b1a4c-c136-3650-8f77-9f98caa506f7@gmail.com>
 <2dd6bffc-9817-f4b1-0b92-f82f22fcf79a@gmail.com>
In-Reply-To: <2dd6bffc-9817-f4b1-0b92-f82f22fcf79a@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 7 Oct 2021 11:18:47 +0200
Message-ID: <CAPDyKFox6THcxDouW2T7F2W__ZcoJP5GeG+H_a4NQmSqAFZ_oQ@mail.gmail.com>
Subject: Re: [PATCH v13 06/35] clk: tegra: Support runtime PM and power domain
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Peter Chen <peter.chen@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Nishanth Menon <nm@ti.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        linux-staging@lists.linux.dev, linux-pwm@vger.kernel.org,
        linux-mmc <linux-mmc@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Lucas Stach <dev@lynxeye.de>, Stefan Agner <stefan@agner.ch>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        David Heidelberg <david@ixit.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 7 Oct 2021 at 01:21, Dmitry Osipenko <digetx@gmail.com> wrote:
>
> 07.10.2021 01:01, Dmitry Osipenko =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > 07.10.2021 00:14, Dmitry Osipenko =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >> 06.10.2021 15:43, Ulf Hansson =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >>> On Wed, 6 Oct 2021 at 00:43, Dmitry Osipenko <digetx@gmail.com> wrote=
:
> >>>>
> >>>> 06.10.2021 01:19, Dmitry Osipenko =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >>>> ...
> >>>>> I reproduced the OFF problem by removing the clk prepare/unprepare =
from
> >>>>> the suspend/resume of the clk driver and making some extra changes =
to
> >>>>> clock tree topology and etc to trigger the problem on Nexus 7.
> >>>>>
> >>>>> tegra-pmc 7000e400.pmc: failed to turn off PM domain heg: -13
> >>>>>
> >>>>> It happens from genpd_suspend_noirq() -> tegra_genpd_power_off() ->=
 clk
> >>>>> -> GENPD -> I2C -> runtime-pm.
> >>>>>
> >>>>> -13 is EACCES, it comes from the runtime PM of I2C device. RPM is
> >>>>> prohibited/disabled during late (NOIRQ) suspend by the drivers core=
.
> >>>>
> >>>> My bad, I double-checked and it's not I2C RPM that is failing now, b=
ut
> >>>> the clock's RPM [1], which is also unavailable during NOIRQ.
> >>>
> >>> Yes, that sounds reasonable.
> >>>
> >>> You would then need a similar patch for the tegra clock driver as I
> >>> suggested for tegra I2C driver. That should solve the problem, I
> >>> think.
> >>>
> >>>>
> >>>> [1]
> >>>> https://elixir.free-electrons.com/linux/v5.15-rc4/source/drivers/clk=
/clk.c#L116
> >>>>
> >>>> Previously it was I2C RPM that was failing in a similar way, but cod=
e
> >>>> changed a tad since that time.
> >>>
> >>> Alright. In any case, as long as the devices gets suspended in the
> >>> correct order, I think it should be fine to cook a patch along the
> >>> lines of what I suggest for the I2C driver as well.
> >>>
> >>> It should work, I think. Although, maybe you want to avoid runtime
> >>> resuming the I2C device, unless it's the device belonging to the PMIC
> >>> interface, if there is a way to distinguish that for the driver.
> >>
> >> Ulf, thank you very much for the suggestions! I was thinking about thi=
s
> >> all once again and concluded that the simplest variant will be to just
> >> remove the suspend ops from the clk driver since neither of PLLs requi=
re
> >> high voltage. We now have voltage bumped to a nominal level during
> >> suspend by Tegra's regulator-coupler driver and it's much higher than
> >> voltage needed by PLLs. So the problem I was trying to work around
> >> doesn't really exist anymore.
> >
> > I hurried a bit with the conclusion, keep forgetting that I need to
> > change the clock tree in order to test it all properly :/ It's not fixe=
d
> > yet.
> >
>
> Please let me iterate once again. The problem we currently have is that
> clock may be enabled during NOIRQ time. In order to enable clock, it
> needs to be prepared. In order to prepare clock, the clock's device
> needs to be runtime-resumed. The runtime PM is unavailable at the NOIRQ
> time.
>
> To solve this problem we need to prepare clock beforehand.
>
> The clock will stay prepared during suspend, but this is not a problem
> since all the clocks we care about don't require high voltage and
> voltage is guaranteed to be bumped high during suspend by Tegra's
> regulator-coupler driver anyways.
>
> So everything we need to do is to keep clocks prepared. There are two
> options how to do that:
>
> [1] this patch which explicitly prepares clocks using clk API.
>
> [2] Use runtime PM API, like this:
>
> static const struct dev_pm_ops tegra_clock_pm =3D {
>         SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_resume_and_get, pm_runtime_put=
)
> };
>
> Ulf, are you now okay with the current variant [1] of the patch or you
> prefer the second [2] option more?

I prefer option [2]. The clock_prepare|unprepare() thingy in option
[1], looks more like an odd workaround to me.

Does that make sense to you as well?

Kind regards
Uffe
