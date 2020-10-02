Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0EE281A12
	for <lists+linux-pm@lfdr.de>; Fri,  2 Oct 2020 19:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388327AbgJBRtA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 2 Oct 2020 13:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387602AbgJBRtA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Oct 2020 13:49:00 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91EBBC0613E4
        for <linux-pm@vger.kernel.org>; Fri,  2 Oct 2020 10:48:59 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id s19so1749271ybc.5
        for <linux-pm@vger.kernel.org>; Fri, 02 Oct 2020 10:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QS77N6+CVhOOVc5MzAkxD23OY8NSVhkBewUyPpHdYlc=;
        b=K7c10yve+m/Ym4Ka9KOtXjRc9l7h/9hkwYlCtP8U1y4i6VsUSwagmYsszDYzzPWyAP
         doQk7cUQ9E4iFl5joVcME6pkx0+Pj0NsYO3HE/qyf6VtbK2Diua2nRDGfeOBwoWALiim
         +Ebyf6fiS6NK0ZzNY7ZIsUiq/eTsSs7/ZOWOi3yFac6jJuSuHA4dSGIgkHWCbpBogq9q
         eYFwMnw1+qz+fp/jKT6fALkj+dHmdwbAH14KNPVxicedjtSDsBGonfJnlK3l+dBoLnRC
         PE82kdBmi+UIMhTe/CkBfifxDFqTUbuUX0IJm9YVYH55/UwM/DFQdEknfpHW3ogGenQe
         rVPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QS77N6+CVhOOVc5MzAkxD23OY8NSVhkBewUyPpHdYlc=;
        b=Vbv7CK0HlRKUKcMX+XBok9K0i4OYYHet1jS1lMUXDuvH8306/tqr7DHZz9U3D5NgA/
         sQwrFm10Z2Ip+1I2AIeR+66KoCcTkl6BDX8sH4y+2Sl1s0Gld6CeiP4cFZ0GJMihmRgS
         WF5NbMo3COZW3f1rBOB2zCTSwT1ZU+ZeFA42/mMq+vxSUulqKpuuDo6hzGPoflm+UBdg
         ykGyfynJ4ZBUtxK2utCurebsxsRlUGMDjMOcJecqUFVmNAI3fFL9SEII1C4xZk2tSGin
         Oki68MEZwbGAsPlogntN9PM4Oab8qY06/RgWtkv1vUnaaesXQ7m3HxorvVmk8B25nHqB
         HBJQ==
X-Gm-Message-State: AOAM533JFkUm8FEmvdauq8K94p1qW2SOJ0XpNHhJjOJjV55/aBzJ5hob
        nNDl1Ct+VZF/wl+7tdbmpp3I1n/ATblQDeXlI8l8fw==
X-Google-Smtp-Source: ABdhPJyK6MpLcp9s4wybIfKzU+/XBpBlE4yS0Lf4BV1uGhjLp79GVzaBk0S/XxweTFTrs7362+sisG6zJp8OI284NSw=
X-Received: by 2002:a05:6902:725:: with SMTP id l5mr4087154ybt.346.1601660938079;
 Fri, 02 Oct 2020 10:48:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAGETcx8owDP_Bu4oNCyHEsME8XpKygxghm8+yNc2RyMA4wyjCA@mail.gmail.com>
 <20201001225952.3676755-1-saravanak@google.com> <20201001231922.GG3722@pendragon.ideasonboard.com>
 <17bdc3f0-d816-151a-fef2-88cd38fc8621@ti.com> <e0ef8816-11ea-3a1a-cac6-14b9f6c92bcf@ti.com>
In-Reply-To: <e0ef8816-11ea-3a1a-cac6-14b9f6c92bcf@ti.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 2 Oct 2020 10:48:22 -0700
Message-ID: <CAGETcx-wkZZQyfnkc59e2ECg_kho-O_c2ms4OOtM4=-Hd125+Q@mail.gmail.com>
Subject: Re: [PATCH v1] of: platform: Batch fwnode parsing in the
 init_machine() path
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Android Kernel Team <kernel-team@android.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Oct 2, 2020 at 8:03 AM 'Grygorii Strashko' via kernel-team
<kernel-team@android.com> wrote:
>
>
>
> On 02/10/2020 14:40, Grygorii Strashko wrote:
> >
> >
> > On 02/10/2020 02:19, Laurent Pinchart wrote:
> >> Hi Saravana,
> >>
> >> Thank you for the patch.
> >>
> >> On Thu, Oct 01, 2020 at 03:59:51PM -0700, Saravana Kannan wrote:
> >>> When commit 93d2e4322aa7 ("of: platform: Batch fwnode parsing when
> >>> adding all top level devices") optimized the fwnode parsing when all top
> >>> level devices are added, it missed out optimizing this for platform
> >>> where the top level devices are added through the init_machine() path.
> >>>
> >>> This commit does the optimization for all paths by simply moving the
> >>> fw_devlink_pause/resume() inside of_platform_default_populate().
> >>
> >> Based on v5.9-rc5, before the patch:
> >>
> >> [    0.652887] cpuidle: using governor menu
> >> [   12.349476] No ATAGs?
> >>
> >> After the patch:
> >>
> >> [    0.650460] cpuidle: using governor menu
> >> [   12.262101] No ATAGs?
> >>
> >> :-(
> >
> > This is kinda expected :( because omap2 arch doesn't call of_platform_default_populate()
> >
> > Call path:
> > board-generic.c
> >   DT_MACHINE_START()
> >     .init_machine    = omap_generic_init,
> >
> >   omap_generic_init()
> >     pdata_quirks_init(omap_dt_match_table);
> >          of_platform_populate(NULL, omap_dt_match_table,
> >                   omap_auxdata_lookup, NULL);
> >
> > Other affected platforms
> > arm: mach-ux500
> > some mips
> > some powerpc
> >
> > there are also case when a lot of devices placed under bus node, in such case
> >   of_platform_populate() calls from bus drivers will also suffer from this issue.
> >
> > I think one option could be to add some parameter to _populate() or introduce new api.
> >
> > By the way, is there option to disable this feature at all?
> > Is there Kconfig option?
> > Is there any reasons why such complex and time consuming code added to the kernel and not implemented on DTC level?
> >
> >
> > Also, I've came with another diff, pls check.
> >
> > [    0.000000] Booting Linux on physical CPU 0x0
> > [    0.000000] Linux version 5.9.0-rc6-01791-g9acba6b38757-dirty (grygorii@grygorii-XPS-13-9370) (arm-linux-gnueabihf-gcc (GNU Toolcha0
> > [    0.000000] CPU: ARMv7 Processor [412fc0f2] revision 2 (ARMv7), cr=10c5387d
> > [    0.000000] CPU: div instructions available: patching division code
> > [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction cache
> > [    0.000000] OF: fdt: Machine model: TI AM5718 IDK
> > ...
> > [    0.053443] cpuidle: using governor ladder
> > [    0.053470] cpuidle: using governor menu
> > [    0.089304] No ATAGs?
> > ...
> > [    3.092291] devtmpfs: mounted
> > [    3.095804] Freeing unused kernel memory: 1024K
> > [    3.100483] Run /sbin/init as init process
> >
> >
> >
> > ------ >< ---
> > diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> > index 071f04da32c8..4521b26e7745 100644
> > --- a/drivers/of/platform.c
> > +++ b/drivers/of/platform.c
> > @@ -514,6 +514,12 @@ static const struct of_device_id reserved_mem_matches[] = {
> >          {}
> >   };
> >
> > +static int __init of_platform_fw_devlink_pause(void)
> > +{
> > +       fw_devlink_pause();
> > +}
> > +core_initcall(of_platform_fw_devlink_pause);
> > +
> >   static int __init of_platform_default_populate_init(void)
> >   {
> >          struct device_node *node;
> > @@ -538,9 +544,7 @@ static int __init of_platform_default_populate_init(void)
> >          }
> >
> >          /* Populate everything else. */
> > -       fw_devlink_pause();
> >          of_platform_default_populate(NULL, NULL, NULL);
> > -       fw_devlink_resume();
> >
> >          return 0;
> >   }
> > @@ -548,6 +552,7 @@ arch_initcall_sync(of_platform_default_populate_init);
> >
> >   static int __init of_platform_sync_state_init(void)
> >   {
> > +       fw_devlink_resume();
>
> ^ it seems has to be done earlier, like
> +static int __init of_platform_fw_devlink_resume(void)
> +{
> +       fw_devlink_resume();
> +       return 0;
> +}
> +device_initcall_sync(of_platform_fw_devlink_resume);

This will mean no device will probe until device_initcall_sync().
Unfortunately, I don't think we can make such a sweeping assumption.

-Saravana
