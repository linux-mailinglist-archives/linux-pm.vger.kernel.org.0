Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3462B03FC
	for <lists+linux-pm@lfdr.de>; Thu, 12 Nov 2020 12:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbgKLLfL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Nov 2020 06:35:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728063AbgKLLfC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Nov 2020 06:35:02 -0500
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5780C0613D1;
        Thu, 12 Nov 2020 03:35:01 -0800 (PST)
Received: by mail-il1-x143.google.com with SMTP id z2so4905068ilh.11;
        Thu, 12 Nov 2020 03:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yOYDw60h8YDhAuQ4Mgnq0YISTzdOklI+rEHu8VITyMw=;
        b=BMDeApb0RDaOMI305+KWmFhB3osA1OXcZbWAPvRoDU7FRATKp85331vEQ1dQk5ygAx
         mmJAfCQON3S9kgiN83fuhVQho5r8QGq3+FIQ2mvYIS+3F+F1bJpjB3po7SrJlpEUjE5d
         4EZOdAQfNgtUVVY9cjPEmxbtecZLsL+JlqKAuGM+6sIeAuvSMqIxznp9y55cNtxTc1At
         oT43x1UTFfg4dFt2bHRiQFtJ5reu+Tqy2MoVV6nRkeAe885VesTAFs5Vxmt3lxgC2dhC
         0XzO/w7SSWEy4qoRb3Ylc9RDGDdTt5lqMz3JvGksHf2ycZIspTfUsW2TMQWqeMYP5NwN
         j5RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yOYDw60h8YDhAuQ4Mgnq0YISTzdOklI+rEHu8VITyMw=;
        b=j5UIBWARDrNQXi0Q4sXqcBCpUjCBis9C7gB05whm6P8skUkGEFNVtE3jvrpL5pGfJl
         otLNohpZSCVGt1DX9ilWZzLAcOsN0nzUxzfi+4U+1oL2oxOQDD+fG3uksGVpKwT1d2pk
         /+Mimbp3JwcCTL11AYrDCTsqLB4YbFKaYQkdVqgtw6kNaaVsFBQ8h7zTuOHtgRReL4Dn
         Zs9l9jTKUe2veiYZLTtnWS2CY3V2Wa2zB2uX57TO0PeB3tj2eI5H7uwpmlElcYrFhmkZ
         CO+KW9dNIfhUiwktEAuOZQEotlTNyBlnru2BRjmV1c4JYTlfhjx/3yv30jwOfSyzOOsg
         opAg==
X-Gm-Message-State: AOAM533mY+ccYnXbz/VCLTAV+huQYpg28x1x7PW5teQNVP2eMGBfEP3z
        ZTRwNimkUhf1ahLoSb80CVOBkEZWKlG1zohy7R4a2uQq
X-Google-Smtp-Source: ABdhPJwQ5Cyt5HHFJRfHNM4P2RneLcXgsFaaKV79h5Jb9WnQUEaQ11PTRxpMasSiUGWbK5kPn6FZcsy7Z76CpMaorkY=
X-Received: by 2002:a92:290b:: with SMTP id l11mr24025993ilg.46.1605180900344;
 Thu, 12 Nov 2020 03:35:00 -0800 (PST)
MIME-Version: 1.0
References: <20200911123157.759379-1-aford173@gmail.com> <20200911123157.759379-2-aford173@gmail.com>
 <CAHCN7x+NxWbpaZ7j3=CTeVcvtLm5iMVymgTV=LWokZAx=wJA1w@mail.gmail.com>
In-Reply-To: <CAHCN7x+NxWbpaZ7j3=CTeVcvtLm5iMVymgTV=LWokZAx=wJA1w@mail.gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Thu, 12 Nov 2020 06:34:48 -0500
Message-ID: <CAHCN7xJOszyiCniUa8hKM-h8vsQ=jfWPvyrZR5Kx5RPoBof1sA@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: omap2plus_defconfig: Enable OMAP3_THERMAL
To:     linux-pm@vger.kernel.org, Linux-OMAP <linux-omap@vger.kernel.org>
Cc:     Adam Ford-BE <aford@beaconembedded.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Eduardo Valentin <edubezval@gmail.com>,
        Keerthy <j-keerthy@ti.com>, Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Oct 16, 2020 at 11:19 AM Adam Ford <aford173@gmail.com> wrote:
>
> On Fri, Sep 11, 2020 at 7:32 AM Adam Ford <aford173@gmail.com> wrote:
> >
> > With the additional power management options enabled,
> > this patch enables OMAP3_THERMAL by default.
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> > ---
> > V3:  No change
> > V2:  No change
>
> Tony,
>
> Can you apply [2/2] to the OMAP branch?
>
> It looks like 1/2 was applied to the linux-pm [1]

Tony,

The defconfig update doesn't show in your branch.  Is there someone
else I should ping about this?

thanks

>
> thanks,
>
> adam
> [1] - https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/commit/?h=thermal/linux-next&id=5093402e5b449b64f7bbaa09057ce40a8f3c1484
>
>
>
> >
> > diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
> > index fe383f5a92fb..efcc46305a47 100644
> > --- a/arch/arm/configs/omap2plus_defconfig
> > +++ b/arch/arm/configs/omap2plus_defconfig
> > @@ -303,6 +303,7 @@ CONFIG_THERMAL_GOV_FAIR_SHARE=y
> >  CONFIG_THERMAL_GOV_USER_SPACE=y
> >  CONFIG_CPU_THERMAL=y
> >  CONFIG_TI_THERMAL=y
> > +CONFIG_OMAP3_THERMAL=y
> >  CONFIG_OMAP4_THERMAL=y
> >  CONFIG_OMAP5_THERMAL=y
> >  CONFIG_DRA752_THERMAL=y
> > --
> > 2.25.1
> >
