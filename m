Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3D0429AA9
	for <lists+linux-pm@lfdr.de>; Tue, 12 Oct 2021 02:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbhJLA7W (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Oct 2021 20:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbhJLA7V (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Oct 2021 20:59:21 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D13CC061745
        for <linux-pm@vger.kernel.org>; Mon, 11 Oct 2021 17:57:20 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id e3so27848465wrc.11
        for <linux-pm@vger.kernel.org>; Mon, 11 Oct 2021 17:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HrgUn3DKWZ7MmEFAtfrRtljQYBgKoJersDhT1IC80/A=;
        b=UEKN7SJXViOLIpLUXMBH07yr+kRk8wq5gTyFGoRE9r/FfKxtpz90BaWEbcHVPJTR+Y
         w3CJ9ax6XuCP17QkvRiHebrKOWNpsE6iP52Rhpg0RR3WkVxEg1M0jg15XvxKDUHcIbur
         e8keyInu70XI7fBsNIbfwYeDeCAXSUjjdc+x1oBfqO9tGNVoundVn061eSZ8eXdX2CNH
         NVLTH6b0Q9FknSZwTJkUnMY9RS6nobK5nSvBdOMnEQxtLWZl3N30Aplx64MB5xu5Yllt
         ExVR+pq5IzSAyx8UrIKM6vymfK6gKs5RMfClfn0HIQFJqfpHva/9F/pW/k1MGliyTYm7
         F3Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HrgUn3DKWZ7MmEFAtfrRtljQYBgKoJersDhT1IC80/A=;
        b=Q7c41g/LcQXgznq/1iANuCkGml0NoFC228IX74aRdEY2DtNiK3rMYndonUv4Fkp+bJ
         b4g6vhRajSsb8lwe4KHnGvnKcpAyX9vzRv2zJDLZXI94/sJKHRk61Ke5pLQEuy5BI8qE
         bShzV0bZiYWbEM/E5ZEs37OSfB+Yf9M8HTBIKRwOkTOz9n5SooXQG8VsGn0GHX8x1lRE
         H9xhwxGBMhcybXRi77kT4ZLx1kkZji3rDw6Qu/67/749KVtoEB7sqprsXEcR8U7LFDBd
         fb9UfDcL/Xiuc5P0328X5MGfQ5YdcZZCq9l3LyBURzbrQnKtu19kIXFKcFCUo2DkKoMx
         UiKQ==
X-Gm-Message-State: AOAM533bXP5RppN+mgw+33Bo3/eNHQgVyB+AOy8GDLF8hTEDfe+nRl2r
        i5Da+st8SsDCa7mhmTFVym8NtoEH6yiVj75ke891KQ==
X-Google-Smtp-Source: ABdhPJy5yhEg/btymR3HWU0OoY+qjByL1JaTFyQZv+6vFuoAim6fy3oSWALXbcuYsLKqzjndh2ylpK3x0o1HO6ZuqKE=
X-Received: by 2002:a7b:c742:: with SMTP id w2mr2508708wmk.61.1634000239044;
 Mon, 11 Oct 2021 17:57:19 -0700 (PDT)
MIME-Version: 1.0
References: <20211011081820.1135261-1-anup.patel@wdc.com> <20211011081820.1135261-2-anup.patel@wdc.com>
 <4300884.9bbH7Ay9ha@diego>
In-Reply-To: <4300884.9bbH7Ay9ha@diego>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 12 Oct 2021 06:27:07 +0530
Message-ID: <CAAhSdy1L+FDipvx=FYEX91J0VK092i=p7uGVZGyeZTBtzPEADA@mail.gmail.com>
Subject: Re: [PATCH v8 1/8] RISC-V: Enable CPU_IDLE drivers
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Sandeep Tripathy <milun.tripathy@gmail.com>,
        Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Liush <liush@allwinnertech.com>,
        DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Anup Patel <anup.patel@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 12, 2021 at 4:46 AM Heiko St=C3=BCbner <heiko@sntech.de> wrote:
>
> Hi Anup,
>
> Am Montag, 11. Oktober 2021, 10:18:13 CEST schrieb Anup Patel:
> > We force select CPU_PM and provide asm/cpuidle.h so that we can
> > use CPU IDLE drivers for Linux RISC-V kernel.
> >
> > Signed-off-by: Anup Patel <anup.patel@wdc.com>
> > ---
> >  arch/riscv/Kconfig                |  7 +++++++
> >  arch/riscv/configs/defconfig      |  1 +
> >  arch/riscv/configs/rv32_defconfig |  1 +
> >  arch/riscv/include/asm/cpuidle.h  | 24 ++++++++++++++++++++++++
> >  arch/riscv/kernel/process.c       |  3 ++-
> >  5 files changed, 35 insertions(+), 1 deletion(-)
> >  create mode 100644 arch/riscv/include/asm/cpuidle.h
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index 8de2afb460f7..d02f1f5a2431 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -46,6 +46,7 @@ config RISCV
> >       select CLONE_BACKWARDS
> >       select CLINT_TIMER if !MMU
> >       select COMMON_CLK
> > +     select CPU_PM if CPU_IDLE
> >       select EDAC_SUPPORT
> >       select GENERIC_ARCH_TOPOLOGY if SMP
> >       select GENERIC_ATOMIC64 if !64BIT
> > @@ -564,5 +565,11 @@ source "kernel/power/Kconfig"
> >
> >  endmenu
> >
> > +menu "CPU Power Management"
> > +
> > +source "drivers/cpuidle/Kconfig"
> > +
> > +endmenu
> > +
> >  source "arch/riscv/kvm/Kconfig"
> >  source "drivers/firmware/Kconfig"
>
> another issue, the "arch/riscv/kvm/Kconfig" line above comes from a
> commit that is not in the riscv-tree at all but in the kvm-tree [0],
> making this patch fail to apply onto riscv/for-next alone.
>
> If you have multiple independent patch series in flight, like shown in
> the github branch you references, it might be easier to base each on
> top of the relevant branch cleanly and after one gets applied rebase
> the other ones.

I know I have been doing that but this time accidently picked the wrong
branch to rebase upon.

Thanks for trying.

Regards,
Anup

>
> That way you're not dependent on the others going in first and also
> people can test patch series individually without too much hassle.
>
> Thanks
> Heiko
>
>
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git/com=
mit/?h=3Dnext&id=3D99cdc6c18c2d815e940e81b9b477d469bdd41788
>
>
