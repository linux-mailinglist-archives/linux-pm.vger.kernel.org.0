Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A965E2C086
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2019 09:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbfE1Hp7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 May 2019 03:45:59 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33410 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbfE1Hp7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 May 2019 03:45:59 -0400
Received: by mail-lj1-f196.google.com with SMTP id w1so16734984ljw.0;
        Tue, 28 May 2019 00:45:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AqCbj+PvdF23UrKqSJAv31hwd4U45LJaqwM+eNLDJ3M=;
        b=nMji94foU88CwozI5MqZAp75FohaMXC/RQMGAFKxXkyls2EQCwtkGHu8WybWQwFHyk
         szM7HghMNBGWaTGQh6FDNs7uCRmEiEA+hYXxm7BjJo+VJVIpsHW+lSujfjDCAg4HWBWy
         9QKm/+AITn1eiPas7WbJGk/vXlgXkYVqT9xOMKidaXesbNZi/KjRKhao1xkprQ9maaDz
         sO4fslFKKYc9ZGuqzWlNxLXdgcN4v6FdxI8lV8SeUuuLsNqHqizhS16qdk4X5cjCprJG
         EVlfpt41zFTlwbYq1CT4geu78uqw02osYUeKtpGPNSwTuHDCQ4havRCmzsn2Qn+9G8T8
         5naA==
X-Gm-Message-State: APjAAAVknhqNYYXBeS7UFrh3hZlRIetapErfHBAVF3uIIsyxe0iaQ3LV
        G4Ie0iL3Xpch4/BOo87pmIpYSoeF644G2UyrDUI=
X-Google-Smtp-Source: APXvYqwnoCo6SJTjNhrqM6Tn9L0kCkH7psfShIb3MEMqL6q3sprsI8Mw18tbRD01Q1Glqdb0OIELkMMx9S+RytEI1MM=
X-Received: by 2002:a2e:9185:: with SMTP id f5mr34080351ljg.51.1559029557096;
 Tue, 28 May 2019 00:45:57 -0700 (PDT)
MIME-Version: 1.0
References: <5cec74e8.1c69fb81.37335.9d7b@mx.google.com> <0edab48f-06e5-9ed8-09be-7c9976ae1afb@collabora.com>
In-Reply-To: <0edab48f-06e5-9ed8-09be-7c9976ae1afb@collabora.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 28 May 2019 09:45:45 +0200
Message-ID: <CAMuHMdUF1Csi1ZMccOj=kurijMLcA6G+TP_spsE+fnMvZR71Vw@mail.gmail.com>
Subject: Re: linusw/for-next boot bisection: v5.2-rc1-8-g73a790c68d7e on rk3288-veyron-jaq
To:     Guillaume Tucker <guillaume.tucker@collabora.com>
Cc:     Elaine Zhang <zhangqing@rock-chips.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Mark Brown <broonie@kernel.org>,
        Matt Hart <matthew.hart@linaro.org>, mgalka@collabora.com,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Guillaume,

On Tue, May 28, 2019 at 9:13 AM Guillaume Tucker
<guillaume.tucker@collabora.com> wrote:
> On 28/05/2019 00:38, kernelci.org bot wrote:
> > * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> > * This automated bisection report was sent to you on the basis  *
> > * that you may be involved with the breaking commit it has      *
> > * found.  No manual investigation has been done to verify it,   *
> > * and the root cause of the problem may be somewhere else.      *
> > * Hope this helps!                                              *
> > * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> >
> > linusw/for-next boot bisection: v5.2-rc1-8-g73a790c68d7e on rk3288-veyron-jaq
> >
> > Summary:
> >   Start:      73a790c68d7e Merge branch 'devel' into for-next
> >   Details:    https://kernelci.org/boot/id/5cebf03d59b514dd627a3629
> >   Plain log:  https://storage.kernelci.org//linusw/for-next/v5.2-rc1-8-g73a790c68d7e/arm/multi_v7_defconfig/gcc-8/lab-collabora/boot-rk3288-veyron-jaq.txt
> >   HTML log:   https://storage.kernelci.org//linusw/for-next/v5.2-rc1-8-g73a790c68d7e/arm/multi_v7_defconfig/gcc-8/lab-collabora/boot-rk3288-veyron-jaq.html
> >   Result:     28694e009e51 thermal: rockchip: fix up the tsadc pinctrl setting error
> >
> > Checks:
> >   revert:     PASS
> >   verify:     PASS
> >
> > Parameters:
> >   Tree:       linusw
> >   URL:        https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git/
> >   Branch:     for-next
> >   Target:     rk3288-veyron-jaq
> >   CPU arch:   arm
> >   Lab:        lab-collabora
> >   Compiler:   gcc-8
> >   Config:     multi_v7_defconfig
> >   Test suite: boot
> >
> > Breaking commit found:
> >
> > -------------------------------------------------------------------------------
> > commit 28694e009e512451ead5519dd801f9869acb1f60
> > Author: Elaine Zhang <zhangqing@rock-chips.com>
> > Date:   Tue Apr 30 18:09:44 2019 +0800
> >
> >     thermal: rockchip: fix up the tsadc pinctrl setting error
>
> This commit has now been reverted in mainline.  Would it be OK
> for you to rebase your for-next branch on v5.2-rc2 or cherry-pick
> the revert to avoid recurring bisections?
>
> Ideally this should have been fixed or reverted in mainline
> before v5.2-rc1 was released, or even earlier when this was first
> found in -next on 13th May.  Unfortunately it was overlooked and
> then spread to other branches like yours.

I'm afraid it's gonna spread to even more for-next branches, as most
subsystem maintainers base their for-next branch on the previous rc1
release.  Typically maintainers do not rebase their for-next branches,
and do not cherry-pick fixes, unless they are critical for their
subsystem.  So you can expect this to show up in e.g. the m68k for-next
branch soon...

Can't you mark this as a known issue, to prevent spending cycles on the
same bisection, and sending out more bisection reports for the same
issue?

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
