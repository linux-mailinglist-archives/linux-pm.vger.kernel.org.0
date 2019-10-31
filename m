Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75C95EB7D2
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2019 20:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729312AbfJaTNA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 31 Oct 2019 15:13:00 -0400
Received: from vps.xff.cz ([195.181.215.36]:46168 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729296AbfJaTNA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 31 Oct 2019 15:13:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1572549177; bh=FBhBhCbprAZVkPZ3QAQvStNaQNJCu5ZanEhE9s1mTjM=;
        h=Date:From:To:Cc:Subject:References:X-My-GPG-KeyId:From;
        b=hCM/GltDpo77xYTpaz5/dMejRWcp59srCsks7ySNzk7z79SyUnRSfnGdVP5DlrOpR
         1ip+EBcUGDaNCK/biB6v8CbSlFIlqVZTyRqOaNPsSiM08tOHV1BKrSXrIv6dKpRsSJ
         jVyh+iOa7L3nh1tSDQgOAVE7UuRJ/AB0EBdoG/ys=
Date:   Thu, 31 Oct 2019 20:12:57 +0100
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     linux-sunxi <linux-sunxi@googlegroups.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        "open list:ALLWINNER CPUFREQ DRIVER" <linux-pm@vger.kernel.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-sunxi] [PATCH] cpufreq: sun50i: Fix CPU speed bin
 detection
Message-ID: <20191031191257.j7bpxx5xyot2ay2i@core.my.home>
Mail-Followup-To: =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        "open list:ALLWINNER CPUFREQ DRIVER" <linux-pm@vger.kernel.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20191031181359.282617-1-megous@megous.com>
 <CAJiuCcdZqpoXKuupk_w3F1npZgCHDgb=+Fdd1ukKA22K2PJ6Ww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJiuCcdZqpoXKuupk_w3F1npZgCHDgb=+Fdd1ukKA22K2PJ6Ww@mail.gmail.com>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Thu, Oct 31, 2019 at 07:55:43PM +0100, Clément Péron wrote:
> Hi Ondrej,
> 
> On Thu, 31 Oct 2019 at 19:14, Ondrej Jirman <megous@megous.com> wrote:
> >
> > I have failures to boot on Orange Pi 3, because this driver determined
> > that my SoC is from the normal bin, but my SoC only works reliably with
> > the OPP values for the slowest bin.
> >
> > Looking at BSP code, I found that efuse values have following meanings
> > on H6:
> >
> > - 0b000 invalid (interpreted in vendor's BSP as normal bin)
> > - 0b001 slowest bin
> > - 0b011 normal bin
> > - 0b111 fastest bin
> 
> Maybe have some defines will be more readable no ?
> https://megous.com/git/linux/tree/drivers/soc/sunxi/sunxi-sid.c?h=h6-4.9-bsp#n213

Hmm, Alwwinner is really funny. Unused macros that just confuse things.

#if defined(CONFIG_ARCH_SUN50IW6)
#define TYPE_SB (0b001)
#define TYPE_NB (0b010)
#define TYPE_FB (0b011)
#else
#define TYPE_SB (0b001)
#define TYPE_NB (0b011)
#define TYPE_FB (0b111)
#endif

So for H6 they define special bin values and actually use different ones
in code. Fun.

I've sent out some testing program to Armbian forums, so hopefully, we'll
collect some real efuse_values from real SoCs, to see what's really being
used in the wild. If we see value 0b010, the BSP code is probably just
wrong.

Interestingly, TYPE_NB 0b010 would be interpreted as normal bin even with
the current BSP code, and TYPE_FB would be misdetected as TYPE_NB.

> #define SUN50I_NVEM_INVALID_CPU_OPP (0b000)
> #define SUN50I_NVEM_LOW_CPU_OPP (0b001)
> #define SUN50I_NVEM_NORMAL_CPU_OPP (0b011)
> #define SUN50I_NVEM_HIGH_CPU_OPP (0b111)

I'd rather not describe meanings just yet, until we get some real-world
data from H6 owners.

https://forum.armbian.com/topic/9368-orangepi-3-h6-allwiner-chip/?do=findComment&comment=88439

regards,
	o.

> Regards,
> Clément
> 
> >
> > Let's play it safe and interpret 0 as the slowest bin, but fix detection
> > of other bins to match vendor code.
> >
> > Fixes: f328584f7bff ("cpufreq: Add sun50i nvmem based CPU scaling driver")
> > Signed-off-by: Ondrej Jirman <megous@megous.com>
> > ---
> >
> > See https://megous.com/git/linux/tree/drivers/soc/sunxi/sunxi-sid.c?h=h6-4.9-bsp#n484
> > and https://megous.com/git/linux/tree/drivers/cpufreq/sunxi-cpufreq.c?h=h6-4.9-bsp#n428
> > (1 is substracted from soc_bin number here!)
> >
> >  drivers/cpufreq/sun50i-cpufreq-nvmem.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/cpufreq/sun50i-cpufreq-nvmem.c b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> > index df35ef3ef567..41dad03e245c 100644
> > --- a/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> > +++ b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> > @@ -71,9 +71,12 @@ static int sun50i_cpufreq_get_efuse(u32 *versions)
> >         efuse_value = (*speedbin >> NVMEM_SHIFT) & NVMEM_MASK;
> >         switch (efuse_value) {
> >         case 0b0001:
> > -               *versions = 1;
> > +               *versions = 0;
> >                 break;
> >         case 0b0011:
> > +               *versions = 1;
> > +               break;
> > +       case 0b0111:
> >                 *versions = 2;
> >                 break;
> >         default:
> > --
> > 2.23.0
> >
> > --
> > You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> > To view this discussion on the web, visit https://groups.google.com/d/msgid/linux-sunxi/20191031181359.282617-1-megous%40megous.com.
