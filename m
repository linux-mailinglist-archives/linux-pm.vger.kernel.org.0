Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEE571637E0
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2020 00:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbgBRX6m (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Feb 2020 18:58:42 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33858 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726749AbgBRX6m (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Feb 2020 18:58:42 -0500
Received: by mail-oi1-f193.google.com with SMTP id l136so22045517oig.1
        for <linux-pm@vger.kernel.org>; Tue, 18 Feb 2020 15:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BYrqyCEJwlM1H84f5pK3yPeUzz0eyZbQZCpRWLIo3KE=;
        b=qHKRx/BfxY4lRyCCYkG76kGDxYDMR8ijpBdAzI1ItmvWQdEbzda2VltX//GfyqMGVf
         /AOzGJJTixCWMBhxSGjaQGkCIFUtcFqyd7fPAzTSuZKZcOkKbcu7LwpeLKzgRq2+eG2L
         /ZlBkw7W1xXkjOj5i4UO7Wsq3VQ1Zbuur89DU4RP1d2XfuvlvwiUmiosiJ3lzpoC7VFz
         GSBlrQtpNya65OYl7JDB4TUftNJmmbudyNiF6OHhNINcImdFPWP502KocCoapr8djI+x
         ERr4DafsOzjSVQpFuXmtrliGW83njYIO/LeU+o9LkNYNitVF7poWToOljUBQTnLhgETm
         vaig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BYrqyCEJwlM1H84f5pK3yPeUzz0eyZbQZCpRWLIo3KE=;
        b=uTjwgoEi0O/05/6Bl1V+m+DXXaKNNDq6xoVoNP6mmB/jKQ6bewp606SmZtldVOH33z
         ftc1q0/E1MXZv0ACYw9h63p/z+Sjk/xU+zP3QAFWkmiGGVPJRGPviuDzwwCMv0d7+p8o
         uelbA9AG6L1hZCj71+u0EAQRjnYabBhIMTkg0Wd5vKUSH+yRxLntclE7NUsNOFnUX2Q1
         7fuRkto0m4tYo9i/+3ylGXwbhyFtLXmrBDNyoyUFrNw6n5aGqYlJLHnkw8d7pcdhxOCB
         SG7uT0VHtg7Db0s4s0vFKv4GNsABedAGqHxbGD6BTWOI1tGOXuFkEGMukc6ji0ukHh7w
         Gh+A==
X-Gm-Message-State: APjAAAU4OloUApz24QWNCHbIZEnsAlRJaoUNmXWR9CeBt3VcsyMS2pLd
        tsBBQRqK8whW2IA8djcVhfK4M+xYrnBeUSWGfau5Ew==
X-Google-Smtp-Source: APXvYqwoBWUossAPCMCNSpCQ8wSY14d6wpUe/NjKuJFsdFy8DJahI96MiWo6F1ASc3ciEOZr8twY6/KNbKM+lKxkzh4=
X-Received: by 2002:aca:1a05:: with SMTP id a5mr2990340oia.97.1582070321416;
 Tue, 18 Feb 2020 15:58:41 -0800 (PST)
MIME-Version: 1.0
References: <20200218220748.54823-1-john.stultz@linaro.org>
 <CAL_JsqK5eVCuKiy2R_=5cyEBFM=YvMODqDYrmJxLPyN-Em-++g@mail.gmail.com>
 <CALAqxLUTNq-Dg5Nd4PozCUx3K0hnVEJYmNnkpnGWGhph8vNr8w@mail.gmail.com> <CAL_JsqJuG7ABaZSg=7mr0jHRruoAiWf6vJRD_Ev3DH6BrtpUtg@mail.gmail.com>
In-Reply-To: <CAL_JsqJuG7ABaZSg=7mr0jHRruoAiWf6vJRD_Ev3DH6BrtpUtg@mail.gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 18 Feb 2020 15:58:30 -0800
Message-ID: <CALAqxLWVCshaPnHR3U0mZLna6zbac-RKC3ZcqvqEK8f446=0sA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] driver core: Rework logic in __driver_deferred_probe_check_state
 to allow EPROBE_DEFER to be returned for longer
To:     Rob Herring <robh@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Todd Kjos <tkjos@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Feb 18, 2020 at 3:53 PM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Feb 18, 2020 at 5:21 PM John Stultz <john.stultz@linaro.org> wrote:
> >
> > On Tue, Feb 18, 2020 at 2:51 PM Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Tue, Feb 18, 2020 at 4:07 PM John Stultz <john.stultz@linaro.org> wrote:
> > > >
> > > > Due to commit e01afc3250255 ("PM / Domains: Stop deferring probe
> > > > at the end of initcall"), along with commit 25b4e70dcce9
> > > > ("driver core: allow stopping deferred probe after init") after
> > > > late_initcall, drivers will stop getting EPROBE_DEFER, and
> > > > instead see an error causing the driver to fail to load.
> > > >
> > > > That change causes trouble when trying to use many clk drivers
> > > > as modules, as the clk modules may not load until much later
> > > > after init has started. If a dependent driver loads and gets an
> > > > error instead of EPROBE_DEFER, it won't try to reload later when
> > > > the dependency is met, and will thus fail to load.
> > > >
> > > > This patch reworks some of the logic in
> > > > __driver_deferred_probe_check_state() so that if the
> > > > deferred_probe_timeout value is set, we will return EPROBE_DEFER
> > > > until that timeout expires, which may be after initcalls_done
> > > > is set to true.
> > > >
> > > > Specifically, on db845c, this change (when combined with booting
> > > > using deferred_probe_timeout=30) allows us to set SDM_GPUCC_845,
> > > > QCOM_CLK_RPMH and COMMON_CLK_QCOM as modules and get a working
> > > > system, where as without it the display will fail to load.
> > >
> > > I would change the default for deferred_probe_timeout to 30 and then
> > > regulator code can rely on that.
> >
> > That is exactly what I do in the following patch! Let me know if you
> > have further suggestions for it.
>
> Indeed.
>
> Between the above comment and this comment in patch 2:
> /* preserve 30 second interval if deferred_probe_timeout=-1 */
>
> ...I was confused.
>

Sorry. I added that out of an abundance of caution to avoid breaking
things if someone booted specifying deferred_probe_timeout=-1 as a
boot argument, since that would cause the regulator timeout to likely
never expire.

> > > Curious, why 30 sec is fine now when
> > > you originally had 2 min? I'd just pick what you think is best. I
> > > doubt Mark had any extensive experiments to come up with 30sec.
> >
> > I had two minutes initially as, due to other delays I still have to
> > chase, booting all the way to UI on the db845c can sometimes take
> > almost a minute. So it was just a rough safety estimate. But in v2, I
> > tested with the 30 second time used by the regulator code, and that
> > seemed to work ok.
> >
> > As long as 30 seconds is working well, I'm ok with it for now (and it
> > can be overrided via boot arg). Though from past experience with
> > enterprise distros running on servers with tons of disks (which might
> > take many minutes to initialize), I'd suspect its likely some
> > environments may need much longer.
>
> Those systems aren't going to have a pinctrl or clock driver sitting
> in an encrypted RAID partition either. :)

Fair enough. Not today.. but it's always only a matter of time between
"that's ridiculous!" and "oh, we need that!" :)

thanks
-john
