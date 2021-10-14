Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8062E42DBEE
	for <lists+linux-pm@lfdr.de>; Thu, 14 Oct 2021 16:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbhJNOoL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Oct 2021 10:44:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:35512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231470AbhJNOoL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 14 Oct 2021 10:44:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5B93A60EE9;
        Thu, 14 Oct 2021 14:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634222526;
        bh=dmfd2MuQY22RzdahVfe9KKp/jyEcm9gCy2Ks6yLRUWU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cZqtm+TtI3eovIBFvso3cBUcpUTR/kJaqUbyF9AvaTET+KqAibBKC3lCxnNRxNY1G
         IdxkYndwGQic/IPItWbrMC4NUHZoyRA9jVa845t4Xu/j/LR3nBUn0+CubDlpaw8S7/
         arXPmhpOcbrEPm5ksYqlFMkgR8tHbzojJoehb6rI5yWigYEzx+6oSzBlNNUh357WNr
         tVQaIAd7VJ3AYCiBgbhjnSJRvWFxMwU417B8q7TE4e+3Bw45TOxuj7C4e1KDPNj7HJ
         Cp+Lfcgaj4L7YgqToHCkf72msel+SrRyKlikiwUoHAsuLYiOhVq7HoRDkf3FmkkCWS
         1lTccfTlFw5fQ==
Received: by mail-wr1-f52.google.com with SMTP id o20so20312313wro.3;
        Thu, 14 Oct 2021 07:42:06 -0700 (PDT)
X-Gm-Message-State: AOAM532izvmwe1/fBdLQdi08N1vQ544byKH2SEq7B4YEZ/pWvmzKuA38
        7Ec8oHQY/9qtCSpapy78W+WqfxRyj88U8lMGF+o=
X-Google-Smtp-Source: ABdhPJwL/h5Sri4pwrd2PxdHKn45McGzMfaCXtw0zgNGUqVJCKGPWzbaf1LtiCzv9Du9OkoY4P4Wz46aYgfFTfjjjGA=
X-Received: by 2002:a05:600c:208:: with SMTP id 8mr19357999wmi.173.1634222524731;
 Thu, 14 Oct 2021 07:42:04 -0700 (PDT)
MIME-Version: 1.0
References: <20211013160125.772873-1-arnd@kernel.org> <2fdbd732-2496-2267-6636-2f682c39e928@gmail.com>
In-Reply-To: <2fdbd732-2496-2267-6636-2f682c39e928@gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 14 Oct 2021 16:41:48 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2jwJb_B8y3juin74kpW5cRJb2GQrYyTW8qJ+9y-x0cmQ@mail.gmail.com>
Message-ID: <CAK8P3a2jwJb_B8y3juin74kpW5cRJb2GQrYyTW8qJ+9y-x0cmQ@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: tegra: add ARCH_SUSPEND_POSSIBLE dependency
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thierry Reding <treding@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        He Ying <heying24@huawei.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 14, 2021 at 12:25 AM Dmitry Osipenko <digetx@gmail.com> wrote:
>
> 13.10.2021 19:01, Arnd Bergmann =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > Some StrongARM processors don't support suspend, which leads
> > to a build failure with the tegra cpuidle driver:
> >
> > WARNING: unmet direct dependencies detected for ARM_CPU_SUSPEND
> >   Depends on [n]: ARCH_SUSPEND_POSSIBLE [=3Dn]
> >   Selected by [y]:
> >   - ARM_TEGRA_CPUIDLE [=3Dy] && CPU_IDLE [=3Dy] && (ARM [=3Dy] || ARM64=
) && (ARCH_TEGRA [=3Dn] || COMPILE_TEST [=3Dy]) && !ARM64 && MMU [=3Dy]
> >
> > arch/arm/kernel/sleep.o: in function `__cpu_suspend':
> > (.text+0x68): undefined reference to `cpu_sa110_suspend_size'
> >
> > Add an explicit dependency to make randconfig builds avoid
> > this combination.
> >
> > Fixes: faae6c9f2e68 ("cpuidle: tegra: Enable compile testing")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  drivers/cpuidle/Kconfig.arm | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
> > index 2cc3c208a180..af97992eaa82 100644
> > --- a/drivers/cpuidle/Kconfig.arm
> > +++ b/drivers/cpuidle/Kconfig.arm
> > @@ -100,6 +100,7 @@ config ARM_MVEBU_V7_CPUIDLE
> >  config ARM_TEGRA_CPUIDLE
> >       bool "CPU Idle Driver for NVIDIA Tegra SoCs"
> >       depends on (ARCH_TEGRA || COMPILE_TEST) && !ARM64 && MMU
> > +     depends on ARCH_SUSPEND_POSSIBLE
> >       select ARCH_NEEDS_CPU_IDLE_COUPLED if SMP
> >       select ARM_CPU_SUSPEND
> >       help
> >
>
> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>

Thanks!

I realized now that we should drop the '&& MMU' after my fix, for both
the tegra and qualcomm drivers, reverting the change from 498ba2a8a275
("cpuidle: Fix ARM_QCOM_SPM_CPUIDLE configuration") that got failed
to fix this problem. I'll resend it as a series of three patches with your =
R-b
on this patch.

On a related note, I now see that the "||COMPILE_TEST" bit for the
arm-specific cpuidle drivers is not all that useful because we can curently
not hit that on non-ARM machines at all. I'll try changing that as well, bu=
t
this is probably nontrivial.

        Arnd
