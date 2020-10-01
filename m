Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35DAE28067D
	for <lists+linux-pm@lfdr.de>; Thu,  1 Oct 2020 20:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729993AbgJASYw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Oct 2020 14:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732415AbgJASYv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Oct 2020 14:24:51 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28BA1C0613D0
        for <linux-pm@vger.kernel.org>; Thu,  1 Oct 2020 11:24:50 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id v60so4725206ybi.10
        for <linux-pm@vger.kernel.org>; Thu, 01 Oct 2020 11:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XFWLdVK9N9NFIOHVs/8vhKHj2fIS3GTg/CaFxSjXctk=;
        b=Aew059fkAp+Fjxi8FMoa2VDuHFwCoc8RUg2mC93yPaL3+G6WqyeCe/OYXtFxJ9F/bF
         abhawBqn6IoI9fd/s1ACg5T4navgpcHID47vxXgtiZJQrwN1okoRvZ7SWdoMlWdHGf8b
         7l/BzGFiNTtNWkFrdmNse/ajKlGE11Mpr2NMtTAOEmPGq+JDQh2N7MjrdJmlj1IMArJu
         Lhp8j/6oN6WFn2BHe0ggaseOrWkhQhPhQiRt/jgW92/8nzsE1owbylbLYypsDJGT7Lp7
         Lliycbn0EMV3RPGi5bu79iCh956GOgjHCUto0egt68iuJEhiSJ0xapqgf69hJWI/dAcO
         u5ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XFWLdVK9N9NFIOHVs/8vhKHj2fIS3GTg/CaFxSjXctk=;
        b=hfDqT3RbU6PRB4SOjXFvdN6IRyMjLYW+2H28Jv1WN2xKnEsk32fBw1wrpK/V6tsVe7
         kaMCeYQjlfGtswhib4tAY0vaew+/3j72Z+QjU7B6VDOwXtTUTx02odkmgfuMXxjSbR64
         2c1vmx4pi6VyNce7LweCw6O9vX2EpHq7fStLjUvOECb6AxxiEtKZTybbyrVadurZpV1X
         le4bVW2mtUB7VRye4iECSGUAA2kcAVPfi3sB0KxmEaiOZm+j+PJEWJn6TI4wXBGi5IHN
         fHDnmVPm8d7XStmObZKruxkADn6I7yZ+VMp+GzVz8n2PcIhaYZOTsJVpats00z0tOEUS
         /5tw==
X-Gm-Message-State: AOAM532jarvP3Io7/X0h79QF0AJe7E0V3+vj3o9+OdWe2vN4Aw1j9T/6
        GdAN0znCQYHcFNzXm1J0UqPbZLsh51i74++aXNX9pw==
X-Google-Smtp-Source: ABdhPJx+6dqKrRNokbyL+usk9lbh8NcAKJaxYRva+AREksVcoXjaIaV5rdakaF0F8CdX9ITBQx20T1qmwcE1/stoG6I=
X-Received: by 2002:a25:c512:: with SMTP id v18mr13017767ybe.20.1601576689002;
 Thu, 01 Oct 2020 11:24:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200924055313.GC9471@atomide.com> <fe0a4fa8-53fc-d316-261f-52f631f12469@ti.com>
 <20200924060826.GE9471@atomide.com> <20200924133049.GH3968@pendragon.ideasonboard.com>
 <20200925115147.GM9471@atomide.com> <20200925115817.GB3933@pendragon.ideasonboard.com>
 <20200930052057.GP9471@atomide.com> <d8d81891-7e22-81a2-19df-6e9a5f8679c4@ti.com>
 <20201001075344.GU9471@atomide.com> <20201001081748.GW9471@atomide.com>
 <20201001082256.GA3722@pendragon.ideasonboard.com> <60ea4b42-fbc2-2b80-7eab-8a236581d4c9@ti.com>
In-Reply-To: <60ea4b42-fbc2-2b80-7eab-8a236581d4c9@ti.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 1 Oct 2020 11:24:12 -0700
Message-ID: <CAGETcx-aiW251dhEXT1GNb9bi6YcX8W=jLBrro5CnPuEjGL09g@mail.gmail.com>
Subject: Re: Slow booting on x15
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tony Lindgren <tony@atomide.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 1, 2020 at 5:56 AM Grygorii Strashko
<grygorii.strashko@ti.com> wrote:
>
>
>
> On 01/10/2020 11:22, Laurent Pinchart wrote:
> > Hi Tony,
> >
> > On Thu, Oct 01, 2020 at 11:17:48AM +0300, Tony Lindgren wrote:
> >> * Tony Lindgren <tony@atomide.com> [201001 07:53]:
> >>> * Peter Ujfalusi <peter.ujfalusi@ti.com> [200930 12:41]:
> >>>> Fwiw on my beagle x15
> >>>>
> >>>> v5.8
> >>>> [    9.908787] Run /sbin/init as init process
> >>>>
> >>>> v5.9-rc7
> >>>> [   15.085373] Run /sbin/init as init process
> >>>>
> >>>>
> >>>> It appears to be 'fixed' in next-20200928: the board does not even boot.
> >>>
> >>> Yeah so it seems :(
> >>>
> >>>> next-20200928 on omap5
> >>>> [    9.936806] Run /sbin/init as init process
> >>>>
> >>>>
> >>>> -rc7 spends most of it's time:
> >>>> [    7.635530] Micrel KSZ9031 Gigabit PHY 48485000.mdio:01: attached PHY driver [Micrel KSZ9031 Gigabit PHY] (mii_bus:phy_addr=48485000.mdio:01, irq=POLL)
> >>>> [   14.956671] cpsw 48484000.ethernet eth0: Link is Up - 1Gbps/Full - flow control off
> >>>> [   15.005211] IP-Config: Complete:
> >>>
> >>> Booting with initcall_debug I see this with current Linux next:
> >>>
> >>> ...
> >>> [    1.697313] cpuidle: using governor menu
> >>> [    1.701353] initcall init_menu+0x0/0xc returned 0 after 0 usecs
> >>> [    1.707458] calling  gpmc_init+0x0/0x10 @ 1
> >>> [    1.711784] initcall gpmc_init+0x0/0x10 returned 0 after 0 usecs
> >>> [    1.717974] calling  omap3_l3_init+0x0/0x10 @ 1
> >>> [    1.722653] initcall omap3_l3_init+0x0/0x10 returned 0 after 0 usecs
> >>> [    1.729201] calling  omap_l3_init+0x0/0x10 @ 1
> >>> [    1.733791] initcall omap_l3_init+0x0/0x10 returned 0 after 0 usecs
> >>> [    1.740314] calling  gate_vma_init+0x0/0x70 @ 1
> >>> [    1.744976] initcall gate_vma_init+0x0/0x70 returned 0 after 0 usecs
> >>> [    1.751522] calling  customize_machine+0x0/0x30 @ 1
> >>> [    3.823114] initcall customize_machine+0x0/0x30 returned 0 after 2011718 usecs
> >>> [    3.830566] calling  init_atags_procfs+0x0/0xec @ 1
> >>> [    3.835583] No ATAGs?
> >>
> >> And the long time above with customize_machine() ends up being
> >> pdata_quirks_init() calling of_platform_populate().
> >
> > That's what the delay is for me (I think I've reported that initially).
> >
> >>> Laurent & Tomi, care to check what you guys see in the slow booting case
> >>> after booting with initcall_debug?
> >>
> >> But maybe the long delay is something else for you guys so please check.
> >
>
> It's all devlink :( Looks like sometimes, improvements (PM) could became so complicated
> that time required to execute such algorithms may completely eliminate all expected benefits.
> Will not be surprised if PM consumption also increased instead of decreasing in some cases.
>
> not sure if it's 100% correct, but below diff reduces boot time
> from 7.6sec to 3.7sec :P
>
> before:
> [    0.053870] cpuidle: using governor menu
> [    2.505971] No ATAGs?
> ...
> [    7.562317] Freeing unused kernel memory: 1024K
>
> after:
> [    0.053800] cpuidle: using governor menu
> [    0.136853] No ATAGs?
> [    3.716218] devtmpfs: mounted
> [    3.719628] Freeing unused kernel memory: 1024K
> [    3.724266] Run /sbin/init as init process
>
> ----
> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> index 071f04da32c8..e0cc37ed46ca 100644
> --- a/drivers/of/platform.c
> +++ b/drivers/of/platform.c
> @@ -481,6 +481,7 @@ int of_platform_populate(struct device_node *root,
>          pr_debug(" starting at: %pOF\n", root);
>
>          device_links_supplier_sync_state_pause();
> +       fw_devlink_pause();
>          for_each_child_of_node(root, child) {
>                  rc = of_platform_bus_create(child, matches, lookup, parent, true);
>                  if (rc) {
> @@ -488,6 +489,7 @@ int of_platform_populate(struct device_node *root,
>                          break;
>                  }
>          }
> +       fw_devlink_resume();
>          device_links_supplier_sync_state_resume();
>
>          of_node_set_flag(root, OF_POPULATED_BUS);
> @@ -538,9 +540,7 @@ static int __init of_platform_default_populate_init(void)
>          }
>
>          /* Populate everything else. */
> -       fw_devlink_pause();
>          of_platform_default_populate(NULL, NULL, NULL);
> -       fw_devlink_resume();

Your analysis is right, but this change is not safe. You'll get an
unlocked linked list trampling if you call it outside of where it's
called now. That's explicitly why I didn't do it the way this patch
does it.

To explain more, if you call fw_devlink_pause/resume() inside
of_platform_populate() you can end up calling it in the context of
another device's probe function. When a device's probe function is
called, a has a bunch of other locks held and you'll cause a deadlock.
To avoid that, I had to use defer_fw_devlink_lock to manage the list
used by fw_devlink_pause/resume().

I'll add more details later. But yeah, this patch isn't safe as is.

-Saravana
