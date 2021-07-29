Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC7CB3DA782
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jul 2021 17:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237910AbhG2PY6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Jul 2021 11:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238094AbhG2PYr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Jul 2021 11:24:47 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C39AC0617A3
        for <linux-pm@vger.kernel.org>; Thu, 29 Jul 2021 08:24:00 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id h18so6286346ilc.5
        for <linux-pm@vger.kernel.org>; Thu, 29 Jul 2021 08:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vr3x2S2ad3bEabZ4cAaFlDASrLr43fOgpwuX6i/1qV4=;
        b=T3+uQNic9EooPybGPjiaBEbXoSCQC03G5yZQ9K6kNLDEPwT1gFqXYeXvczYk/MjOiV
         rPBCBpCy7fFl+eXH7fPQyXZBK1X6Q7hDlfeQvyjZqNBhVL+rACxEZ+eoFZa45AoP0VWK
         koqBsEor2bboQ8B6e9HxVuDPGzzeNTAUW2qKVLBrAvfRwOIabiPVbwavNg13Q0XVPQkq
         iuEOSXwz/YhOYnDfa1HOWu1HXK/TjLSOJOI9elXe20wEBtXu5TwcVwxHEDbkZf6Y3Vlw
         zfKK77Hk6UevXuFwV5lHfOFibTQP1ZvszVYL6LdUCeZtW7Opo7aQIkQAJ4kpzY3sgjAF
         +YVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vr3x2S2ad3bEabZ4cAaFlDASrLr43fOgpwuX6i/1qV4=;
        b=M6Wxz1U8j+WQZ7MNxhWadganDPhbILUNscMYXKZfaa9Bj/eyj8rAoqWa6ZQRX2HyuE
         a941wHWx1EUFpyWGXQ/UDeVWKrpveK5UGzloyYOoxSVymPBaaNNcC5fbnmU67MHwcviY
         uTqCnvQLgT4XXfYfQpq09JMKmeSr/8KO9BtnYXGC2Ti8swOTj4dPK/NzoFLnSnIwG4w3
         KQRu4RMPZzav1GxP658PyRTXH9gk0cGd6a5rDlDzhDYUqkxuYa4sPgq0lFQvNN+efUiE
         5kDAQQ3ct8H2cTCIHRQrTWtpqD8fC5TVX6oE9391CYg0y8CC2lexUMn5shESwSzCfO2D
         T4Gw==
X-Gm-Message-State: AOAM531ewKlyFl/gBeobckvzyDGMvqfltqJ4zIMKMsId4rMggMOItbBJ
        1bEhcAteX/+WxZvg2q6bNlz14e/tW0vnJuY17zFX2810BMY=
X-Google-Smtp-Source: ABdhPJwcv8eRvN2OcA2xpvSBStU8L6+W10VSuM5aiJfcv61xtopfdtWCVwQ9jMeLMTuBlJ+7mvhjstd8xvKqI2H1DnY=
X-Received: by 2002:a92:b74d:: with SMTP id c13mr4095746ilm.176.1627572239293;
 Thu, 29 Jul 2021 08:23:59 -0700 (PDT)
MIME-Version: 1.0
References: <1867445.PYKUYFuaPT@kreacher> <000801d78322$e9b94980$bd2bdc80$@telus.net>
 <CAJZ5v0jashhvE4vRNAft1qfZ_Ud==tG1Yh29ad7BSfhk5xjx4A@mail.gmail.com>
 <2178828.iZASKD2KPV@kreacher> <CAAYoRsVko5jG=xqH=KTochqQu95i7PDo_6f1LCPGvAP0=XdVTA@mail.gmail.com>
In-Reply-To: <CAAYoRsVko5jG=xqH=KTochqQu95i7PDo_6f1LCPGvAP0=XdVTA@mail.gmail.com>
From:   Doug Smythies <dsmythies@telus.net>
Date:   Thu, 29 Jul 2021 08:23:48 -0700
Message-ID: <CAAYoRsWQ25O=7msQfvH5qRRK80JrpfLOQdG2BQrGx9_wpOX_wQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] cpuidle: teo: Rework the idle state selection logic
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        dsmythies <dsmythies@telus.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 28, 2021 at 11:34 PM Doug Smythies <dsmythies@telus.net> wrote:
>
> On Wed, Jul 28, 2021 at 10:47 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > On Wednesday, July 28, 2021 3:52:51 PM CEST Rafael J. Wysocki wrote:
> > > On Tue, Jul 27, 2021 at 10:06 PM Doug Smythies <dsmythies@telus.net> wrote:
> > > >
> > > > Hi Rafael,
> > > >
> > > > Further to my reply of 2021.07.04  on this, I have
> > > > continued to work with and test this patch set.
> > > >
> > > > On 2021.06.02 11:14 Rafael J. Wysocki wrote:
> > > >
> > > > >This series of patches addresses some theoretical shortcoming in the
> > > > > TEO (Timer Events Oriented) cpuidle governor by reworking its idle
> > > > > state selection logic to some extent.
> > > > >
> > > > > Patches [1-2/5] are introductory cleanups and the substantial changes are
> > > > > made in patches [3-4/5] (please refer to the changelogs of these two
> > > > > patches for details).  The last patch only deals with documentation.
> > > > >
> > > > > Even though this work is mostly based on theoretical considerations, it
> > > > > shows a measurable reduction of the number of cases in which the shallowest
> > > > > idle state is selected while it would be more beneficial to select a deeper
> > > > > one or the deepest idle state is selected while it would be more beneficial to
> > > > > select a shallower one, which should be a noticeable improvement.
> > > >
> > > > I am concentrating in the idle state 0 and 1 area.
> > > > When I disable idle state 0, the expectation is its
> > > > usage will fall to idle state 1. It doesn't.
> > > >
> > > > Conditions:
> > > > CPU: Intel(R) Core(TM) i5-10600K CPU @ 4.10GHz
> > > > HWP: disabled
> > > > CPU frequency scaling driver: intel_pstate, active
> > > > CPU frequency scaling governor: performance.
> > > > Idle configuration: As a COMETLAKE processor, with 4 idle states.
> > > > Sample time for below: 1 minute.
> > > > Workflow: Cross core named pipe token passing, 12 threads.
> > > >
> > > > Kernel 5.14-rc3: idle: teo governor
> > > >
> > > > All idle states enabled: PASS
> > > > Processor: 97 watts
> > > > Idle state 0 entries: 811151
> > > > Idle state 1 entries: 140300776
> > > > Idle state 2 entries: 889
> > > > Idle state 3 entries: 8
> > > >
> > > > Idle state 0 disabled: FAIL <<<<<
> > > > Processor: 96 watts
> > > > Idle state 0 entries: 0
> > > > Idle state 1 entries: 65599283
> > > > Idle state 2 entries: 364399
> > > > Idle state 3 entries: 65112651
> > >
> > > This looks odd.
> > >
> > > Thanks for the report, I'll take a look at this.
> >
> > I have found an issue in the code that may be responsible for the
> > observed behavior and should be addressed by the appended patch (not
> > tested yet).
> >
> > Basically, the "disabled" check in the second loop over states in
> > teo_select() needs to exclude the first enabled state, because
> > there are no more states to check after that.
> >
> > Plus the time span check needs to be done when the given state
> > is about to be selected, because otherwise the function may end up
> > returning a state for which the sums are too low.
> >
> > Thanks!
> >
> > ---
> >  drivers/cpuidle/governors/teo.c |   26 ++++++++++++++------------
> >  1 file changed, 14 insertions(+), 12 deletions(-)
> >
> > Index: linux-pm/drivers/cpuidle/governors/teo.c
> > ===================================================================
> > --- linux-pm.orig/drivers/cpuidle/governors/teo.c
> > +++ linux-pm/drivers/cpuidle/governors/teo.c
> > @@ -404,25 +404,27 @@ static int teo_select(struct cpuidle_dri
> >                         intercept_sum += bin->intercepts;
> >                         recent_sum += bin->recent;
> >
> > -                       if (dev->states_usage[i].disable)
> > +                       if (dev->states_usage[i].disable && i > idx0)
> >                                 continue;
> >
> >                         span_ns = teo_middle_of_bin(i, drv);
> > -                       if (!teo_time_ok(span_ns)) {
> > -                               /*
> > -                                * The current state is too shallow, so select
> > -                                * the first enabled deeper state.
> > -                                */
> > -                               duration_ns = last_enabled_span_ns;
> > -                               idx = last_enabled_idx;
> > -                               break;
> > -                       }
> >
> >                         if ((!alt_recent || 2 * recent_sum > idx_recent_sum) &&
> >                             (!alt_intercepts ||
> >                              2 * intercept_sum > idx_intercept_sum)) {
> > -                               idx = i;
> > -                               duration_ns = span_ns;
> > +                               if (!teo_time_ok(span_ns) ||
> > +                                   dev->states_usage[i].disable) {
> > +                                       /*
> > +                                        * The current state is too shallow or
> > +                                        * disabled, so select the first enabled
> > +                                        * deeper state.
> > +                                        */
> > +                                       duration_ns = last_enabled_span_ns;
> > +                                       idx = last_enabled_idx;
> > +                               } else {
> > +                                       idx = i;
> > +                                       duration_ns = span_ns;
> > +                               }
> >                                 break;
> >                         }
>
> Hi Rafael,
>
> I tried the patch and when I disabled idle state 0
> got, very similar to before:
>
> Idle state 0 disabled: FAIL
> Processor: 95 watts
> Idle state 0 entries: 0
> Idle state 1 entries: 65,475,534
> Idle state 2 entries: 333144
> Idle state 3 entries: 65,247,048
>
> However, I accidently left it for about 30 minutes
> and noticed:
>
> Idle state 0 disabled:
> Processor: 83 watts
> Idle state 0 entries: 0
> Idle state 1 entries: 88,706,831
> Idle state 2 entries: 100
> Idle state 3 entries: 662
>
> I went back to unmodified kernel 5.13-rc3 and

Sorry, 5.14-rc3.

> let it run longer with idle state 0 disabled, and
> after 30 minutes it had changed but nowhere
> near as much:
>
> Idle state 0 disabled:
> Processor: 87 watts
> Idle state 0 entries: 0
> Idle state 1 entries: 70,361,020
> Idle state 2 entries: 71219
> Idle state 3 entries: 27,249,975

Addendum: So far the workflow used for this
thread has been event based. If I switch to
a timer based workflow, everything works as
expected for both kernels, 5.14-rc3 unmodified
and modified with the patch from herein.

... Doug
