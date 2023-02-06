Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BFB668C84C
	for <lists+linux-pm@lfdr.de>; Mon,  6 Feb 2023 22:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjBFVKk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Feb 2023 16:10:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjBFVKj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Feb 2023 16:10:39 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C051425280
        for <linux-pm@vger.kernel.org>; Mon,  6 Feb 2023 13:10:34 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id 65so4945275iou.3
        for <linux-pm@vger.kernel.org>; Mon, 06 Feb 2023 13:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ei4VFwLuleRaOtoRA5G2QYwC0Oa6+F6aM5uPuhmObpA=;
        b=PlIRFIUWOG3snK2ir5MVbWiqkHxoiQiL87CxnahwXyFLOxkF4QxihR74Xuqis0pyOS
         7/yvGUhMgVSQ2sn6rGAuEblMfRjs4tXiZ6eE0XdjyQNQ9m8QEtNV5bxRkv5ydo2btGv2
         vpfmlKw4l3+o4Et8xGpmNryTdEhrP16dkDshs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ei4VFwLuleRaOtoRA5G2QYwC0Oa6+F6aM5uPuhmObpA=;
        b=rqGoYxHSS+GAV0nixXG+Krau9kff7x/RfEkzXDsAHG0rKH3AMHiRGRAj+c4fszF/KC
         5Cljl+bTtcsEyP5G5DEeIWbNZQD26iY8s5FsZ4+O/2CqfwTVR5Ws811bcINRbM+P/ISK
         teQPLff6K9VBDw/N1MZQeoXvQ9WhbQR1Q7vk7pdARyNrWw979L2FTIBjY2f95QJmkeHg
         J6KGTKvDXjhpX3+JwGNSJoFwX2Ww+MvG4NqVwCvFwFvfV7/u/MspEJF5htWQxQ4PTW5B
         Kk1gnV0TrZtA6aLOujBtFlP4d38T6gApUH8CJ6s/gKnvyeixKqQ04V+EhQo81aR55rBj
         C/zA==
X-Gm-Message-State: AO0yUKWeBDL1HrFq1g8VxZRengIB2bvfW5I2Hk7G0iHw/S4RFHiPRTuz
        8ueFy7W61cBT+qpmyHkC2Rdt9urOuFeNydH0
X-Google-Smtp-Source: AK7set/adgJIbof0PpeLtwOFleE0XDoRpq2A/3Lzpb2MVL9Ac6rrcLWLSbCIVOHuy0M4rQeba4w8dA==
X-Received: by 2002:a5e:a609:0:b0:704:d17c:7dc1 with SMTP id q9-20020a5ea609000000b00704d17c7dc1mr360727ioi.11.1675717833736;
        Mon, 06 Feb 2023 13:10:33 -0800 (PST)
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com. [209.85.166.53])
        by smtp.gmail.com with ESMTPSA id y24-20020a056638039800b003a7d6a0ea4csm3785893jap.151.2023.02.06.13.10.31
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 13:10:31 -0800 (PST)
Received: by mail-io1-f53.google.com with SMTP id r6so4942452ioj.5
        for <linux-pm@vger.kernel.org>; Mon, 06 Feb 2023 13:10:31 -0800 (PST)
X-Received: by 2002:a05:6638:5af:b0:3b1:4f93:69b8 with SMTP id
 b15-20020a05663805af00b003b14f9369b8mr245586jar.117.1675717830923; Mon, 06
 Feb 2023 13:10:30 -0800 (PST)
MIME-Version: 1.0
References: <20230127104054.895129-1-abel.vesa@linaro.org> <Y9v/z8CYik3faHh7@google.com>
 <Y+ErWTyV8CnE3Hl+@linaro.org> <Y+E3T6bozU1K2sFb@google.com>
 <Y+E9Z+/+eCpPK6DE@linaro.org> <CAGETcx99ev_JdgYoifEdUg6rqNCs5LHc-CfwTc7j3Bd_zeizew@mail.gmail.com>
In-Reply-To: <CAGETcx99ev_JdgYoifEdUg6rqNCs5LHc-CfwTc7j3Bd_zeizew@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 6 Feb 2023 13:10:19 -0800
X-Gmail-Original-Message-ID: <CAD=FV=X3nnwuTK2=w7DJfjL_Ai7MiuvTwv8BiVJPMVEWKzR-_g@mail.gmail.com>
Message-ID: <CAD=FV=X3nnwuTK2=w7DJfjL_Ai7MiuvTwv8BiVJPMVEWKzR-_g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/2] PM: domains: Skip disabling unused domains if
 provider has sync_state
To:     Saravana Kannan <saravanak@google.com>
Cc:     Abel Vesa <abel.vesa@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Mon, Feb 6, 2023 at 11:33 AM Saravana Kannan <saravanak@google.com> wrote:
>
> On Mon, Feb 6, 2023 at 9:48 AM Abel Vesa <abel.vesa@linaro.org> wrote:
> >
> >
> > CC'ed Saravana
>
> Thanks. Please do cc me for stuff like this from the start. I skimmed
> the series and I think it's doing one of my TODO items. So, thanks for
> the patch!
>
> I'll take a closer look within a few days -- trying to get through
> some existing fw_devlink stuff.
>
> But long story short, it is the right thing to keep a supplier on
> indefinitely if there's a consumer device (that's not disabled in DT)
> that never gets probed. It's a pretty common scenario -- for example,
> say a display backlight. The default case should be functional
> correctness. And then we can add stuff that allows changing this
> behavior with command line args or something else that can be done
> from userspace.
>
> +1 to what Doug said elsewhere in this thread too. I'm trying to
> consolidate the "when do we give up" decision at the driver core level
> independent of what framework is being used.

I'm not really sure I agree with the above, at least not without lots
of discussion in the community. It really goes against what the kernel
has been doing for years and years in the regulator and clock
frameworks. Those frameworks both eventually give up and power down
resources that no active drivers are using. Either changing the
regulator/clock frameworks or saying that other frameworks should work
in an opposite way seems like a recipe for confusion.

Now, certainly I won't say that the way that the regulator and clock
frameworks function is perfect nor will I say that they don't cause
any problems. However, going the opposite way where resources are kept
at full power indefinitely will _also_ cause problems.

Specifically, let's look at the case you mentioned of a display
backlight. I think you're saying that if there is no backlight driver
enabled in the kernel that you'd expect the backlight to just be on at
full brightness. Would you expect this even if the firmware didn't
leave the backlight on? In any case, why do you say it's more correct?
I suppose you'd say that the screen is at least usable like this.
...except that you've broken a different feature: suspend/resume.
Without being able to turn the backlight off at suspend time the
device would drain tons of power. It could also overheat when you
stuffed it in your backpack and damage the battery or start a fire.
Even if you argue that in the case of the display backlight you're
better off, what about a keyboard backlight? It's pretty easy to use a
laptop without the keyboard backlight and if you didn't have a driver
for it you'd be in better shape leaving it off instead of leaving it
on 100% of the time, even when the device is suspended.

Overall: if a kernel isn't configured for a given driver we shouldn't
be expecting the hardware controlled by that driver to work. The best
we can hope for is that it's at least in a low power state.

In general I think that having a well-defined way to know it's time to
give up and power off anything for which a driver didn't probe needs
to be an important part of any designs here.


> -Saravana
>
> >
> > On 23-02-06 17:22:23, Matthias Kaehlcke wrote:
> > > On Mon, Feb 06, 2023 at 06:31:21PM +0200, Abel Vesa wrote:
> > > > On 23-02-02 18:24:15, Matthias Kaehlcke wrote:
> > > > > Hi Abel,
> > > > >
> > > > > On Fri, Jan 27, 2023 at 12:40:53PM +0200, Abel Vesa wrote:
> > > > > > Currently, there are cases when a domain needs to remain enabled until
> > > > > > the consumer driver probes. Sometimes such consumer drivers may be built
> > > > > > as modules. Since the genpd_power_off_unused is called too early for
> > > > > > such consumer driver modules to get a chance to probe, the domain, since
> > > > > > it is unused, will get disabled. On the other hand, the best time for
> > > > > > an unused domain to be disabled is on the provider's sync_state
> > > > > > callback. So, if the provider has registered a sync_state callback,
> > > > > > assume the unused domains for that provider will be disabled on its
> > > > > > sync_state callback. Also provide a generic sync_state callback which
> > > > > > disables all the domains unused for the provider that registers it.
> > > > > >
> > > > > > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > > > > > ---
> > > > > >
> > > > > > This approach has been applied for unused clocks as well.
> > > > > > With this patch merged in, all the providers that have sync_state
> > > > > > callback registered will leave the domains enabled unless the provider's
> > > > > > sync_state callback explicitly disables them. So those providers will
> > > > > > need to add the disabling part to their sync_state callback. On the
> > > > > > other hand, the platforms that have cases where domains need to remain
> > > > > > enabled (even if unused) until the consumer driver probes, will be able,
> > > > > > with this patch in, to run without the pd_ignore_unused kernel argument,
> > > > > > which seems to be the case for most Qualcomm platforms, at this moment.
> > > > >
> > > > > I recently encountered a related issue on a Qualcomm platform with a
> > > > > v6.2-rc kernel, which includes 3a39049f88e4 ("soc: qcom: rpmhpd: Use
> > > > > highest corner until sync_state"). The issue involves a DT node with a
> > > > > rpmhpd, the DT node is enabled, however the corresponding device driver
> > > > > is not enabled in the kernel. In such a scenario the sync_state callback
> > > > > is never called, because the genpd consumer never probes. As a result
> > > > > the Always-on subsystem (AOSS) of the SoC doesn't enter sleep mode during
> > > > > system suspend, which results in a substantially higher power consumption
> > > > > in S3.
> > > >
> > > > If I get this correctly, one of the providers is missing (doesn't matter
> > > > the reason), in which case, your kernel needs that driver, period. There
> > > > is no reason why you would expect the consumer to work without the
> > > > provider. Or, you could just remove the property in the devicetree node,
> > > > the property that makes the consumer wait for that provider. Anyway, you
> > > > should never end up with a consumer provider relationship in devicetree
> > > > without providing the provider driver.
> > >
> > > I would agree if it was actually a provider that's missing, however it's a
> > > 'missing' consumer that prevents the sync_state() call.
> >
> > Oh, my bad.
> >
> > Still, why would you keep the consumer node enabled in devicetree if you don't
> > intend to allow its driver to ever probe?
> >
> > >
> > > > > I wonder if genpd (and some other frameworks) needs something like
> > > > > regulator_init_complete(), which turns off unused regulators 30s after
> > > > > system boot. That's conceptually similar to the current
> > > > > genpd_power_off_unused(), but would provide time for modules being loaded.
> > > >
> > > > NACK, timeouts are just another hack in this case, specially when we
> > > > have a pretty reliable mechanism like sync_state.
> > >
> > > It does not work properly unless all consumers are probed successfully. It
> > > makes sense to wait some time for the consumers to probe, but not eternally,
> > > it's perfectly valid that a driver for a (potential) consumer is not enabled.
> >
> > Usually, if you have a consumer devicetree node that you consider it
> > should not probe, you should consider disabling that node in your board
> > dts, specially if you don't intend to provide its driver.
> >
> > Again, timeouts are bad all-around. What happens if rootfs doesn't get
> > mounted in time? Will 30 seconds be enough for every scenario? What
> > happens if I want to load the driver (module) for a consumer a day after boot?
> >
> > IMHO, I think even the regulator_init_complete should be switched to some sync
> > state approach.
