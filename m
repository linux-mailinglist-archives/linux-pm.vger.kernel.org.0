Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E68F425629B
	for <lists+linux-pm@lfdr.de>; Fri, 28 Aug 2020 23:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgH1Vrn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Aug 2020 17:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbgH1Vrl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Aug 2020 17:47:41 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380BCC061264
        for <linux-pm@vger.kernel.org>; Fri, 28 Aug 2020 14:47:41 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id n23so466909otq.11
        for <linux-pm@vger.kernel.org>; Fri, 28 Aug 2020 14:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O1rtOVVZTmOiLPUX5y+uamzdccZJCnIu4DK04RrHtrw=;
        b=VqvDd/7JFJoefDnYMDd2TnyWSeNLC0c+tjwlXhfGi7Vr5XBCIXjWeQTN7ktw/f3JlW
         L8n0EnP4ai7P5w/pGbf0OKl8qGyXDV/uccgr+DtB9WD3906b4faaiDn/QMmRuoSgjyJ2
         nnhMkrwUTxKGnhf40Ppjk8Bwb4Nwkdt2Hh30lRCdCiGiVLUpAtML9UfNsMuyOHLqKtJV
         Jy8FhnvcJzxu85ibASKpleexf/WWmDegSfu1FQzzE3PUze7xY1wHbGjPYFfVLejZWH0L
         WdqzUFhQNBf6+c6LclO8fnlu6ORYB3+dPyavBA5FkK5cwYvKxeXKNfdpw1EDfvcKB3oM
         6Oxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O1rtOVVZTmOiLPUX5y+uamzdccZJCnIu4DK04RrHtrw=;
        b=Zmjoqqus8sctVnc/p/qXufBq7+0K5/6TRBVthwOnhHJe5ChAju7LJ68+fd7bTLGDqJ
         hnW1tIiwswMi6eSvhLkGO2nAaYhKcFckMIEUCnu/HyxWBa8N/v9suygcVnT1ImetoFFb
         z+wMFuu3WOj7Tvuz8kNVdl4WXhB2bztbitvTmeVFrp0tW6oIO7OvQ5VQAyplxVjczbe8
         S2Xg7GtEF0gnoMjLylo1RpG3eolZX5dX3v9OK+fbBpP+PC60YEN4o4HoYOVJxVD0iO/G
         aGv8ouyHRFN2FWANi5BuI2fGasGNppHhpCpDaTT3v7cW9Tf0GCW/HegSsynC+GaSU/SA
         kaaQ==
X-Gm-Message-State: AOAM530oiDC9K4z8ja6jTjfyr18iulVrnWk7AVOwHVqQHMXxYxzQVeZF
        A2Ypn3ZAj+/MToVO1DlO0awzuXtQrbuFoiat+5fwQA==
X-Google-Smtp-Source: ABdhPJyMeFzXcU8ZYWbFliiFHaaxRlttnm8/Tw1m92IbDIMbgCL+hffrDsJOTSvlWzGztVIo6kzT1O4fvBLlhbuQVi8=
X-Received: by 2002:a9d:7846:: with SMTP id c6mr452529otm.221.1598651260423;
 Fri, 28 Aug 2020 14:47:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200808043512.106865-1-john.stultz@linaro.org> <20200828120154.GA1674264@ulmo>
In-Reply-To: <20200828120154.GA1674264@ulmo>
From:   John Stultz <john.stultz@linaro.org>
Date:   Fri, 28 Aug 2020 14:47:27 -0700
Message-ID: <CALAqxLWHc1Vx5eHS02EePb_dJheG+d9yi2Vfop74mWfQUB-hdA@mail.gmail.com>
Subject: Re: [RFC][PATCH] pinctrl: Rework driver_deferred_probe_check_state()
 evaluation since default timeout has changed
To:     Thierry Reding <treding@nvidia.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Saravana Kannan <saravanak@google.com>,
        Todd Kjos <tkjos@google.com>, Len Brown <len.brown@intel.com>,
        Pavel Machek <pavel@ucw.cz>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Aug 28, 2020 at 5:02 AM Thierry Reding <treding@nvidia.com> wrote:
>
> On Sat, Aug 08, 2020 at 04:35:12AM +0000, John Stultz wrote:
> > In commit bec6c0ecb243 ("pinctrl: Remove use of
> > driver_deferred_probe_check_state_continue()"), we removed the
> > use of driver_deferred_probe_check_state_continue() which
> > effectively never returned -ETIMED_OUT, with the
> > driver_deferred_probe_check_state() function that had been
> > reworked to properly return ETIMED_OUT when the deferred probe
> > timeout expired. Along with that change, we set the default
> > timeout to 30 seconds.
> >
> > However, since moving the timeout to 30 seconds caused some
> > issues for some users with optional dt links, we set the
> > default timeout back to zero - see commit ce68929f07de ("driver
> > core: Revert default driver_deferred_probe_timeout value to 0")
> >
> > This in essence changed the behavior of the pinctrl's usage
> > of driver_deferred_probe_check_state(), as it now would return
> > ETIMED_OUT by default. Thierry reported this caused problems with
> > resume on tegra platforms.
> >
> > Thus this patch tweaks the pinctrl logic so that it behaves as
> > before. If modules are enabled, we'll only return EPROBE_DEFERRED
> > while we're missing drivers linked in the DT.
> >
> > Cc: linux-pm@vger.kernel.org
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Cc: Thierry Reding <treding@nvidia.com>
> > Cc: Mark Brown <broonie@kernel.org>
> > Cc: Liam Girdwood <lgirdwood@gmail.com>
> > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Cc: Saravana Kannan <saravanak@google.com>
> > Cc: Todd Kjos <tkjos@google.com>
> > Cc: Len Brown <len.brown@intel.com>
> > Cc: Pavel Machek <pavel@ucw.cz>
> > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > Cc: Kevin Hilman <khilman@kernel.org>
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Cc: Rob Herring <robh@kernel.org>
> > Fixes: bec6c0ecb243 ("pinctrl: Remove use of driver_deferred_probe_check_state_continue()")
> > Fixes: ce68929f07de ("driver core: Revert default driver_deferred_probe_timeout value to 0")
> > Reported-by: Thierry Reding <thierry.reding@gmail.com>
> > Signed-off-by: John Stultz <john.stultz@linaro.org>
> > ---
> >  drivers/pinctrl/devicetree.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/pinctrl/devicetree.c b/drivers/pinctrl/devicetree.c
> > index c6fe7d64c913..09ddf567ccb4 100644
> > --- a/drivers/pinctrl/devicetree.c
> > +++ b/drivers/pinctrl/devicetree.c
> > @@ -129,9 +129,8 @@ static int dt_to_map_one_config(struct pinctrl *p,
> >               if (!np_pctldev || of_node_is_root(np_pctldev)) {
> >                       of_node_put(np_pctldev);
> >                       ret = driver_deferred_probe_check_state(p->dev);
> > -                     /* keep deferring if modules are enabled unless we've timed out */
> > -                     if (IS_ENABLED(CONFIG_MODULES) && !allow_default &&
> > -                         (ret == -ENODEV))
> > +                     /* keep deferring if modules are enabled */
> > +                     if (IS_ENABLED(CONFIG_MODULES) && !allow_default)
> >                               ret = -EPROBE_DEFER;
> >                       return ret;
> >               }
>
> I posted almost exactly the same patch a couple of days ago since I
> hadn't noticed this:
>
>         https://patchwork.ozlabs.org/project/linux-gpio/patch/20200825143348.1358679-1-thierry.reding@gmail.com/
>
> I like that slightly better because it keeps the "ret < 0" condition,
> which I think is perhaps a bit more future-proof. Thinking about it, I'm
> not sure your version above is entirely correct. For example if the call
> to driver_deferred_probe_check_state() were to ever return 0, we might
> still be returning -EPROBE_DEFER here.

Yea. I agree that your patch is preferred.

> That's not something that happens currently, but I suspect that these
> implications will be easy to overlook.
>
> Actually... I think it might be best to just bring back (albeit perhaps
> in a modified form) driver_deferred_probe_check_state_continue() because
> we're now basically doing exactly what that was supposed to do: special-
> casing the case where we do want to continue returning -EPROBE_DEFER in
> some special cases.

Is it likely that the special case situation is common?  It seems
having the driver do the special casing in its code (even better, with
an explanation for why that driver needs it) will be better then
having multiple similar hooks that don't have clear explanations that
drivers are likely to mix up.

thanks
-john
