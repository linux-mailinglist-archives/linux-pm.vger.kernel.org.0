Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 529D221D5A3
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jul 2020 14:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729621AbgGMMQo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jul 2020 08:16:44 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44402 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbgGMMQo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jul 2020 08:16:44 -0400
Received: by mail-ot1-f68.google.com with SMTP id 5so9296289oty.11;
        Mon, 13 Jul 2020 05:16:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pO75K6jp9I0TgVd5uiJ2Fq8Rt2TkoAscNvbsoxxq4gc=;
        b=dPWa6aQZgW7DGcWueb0oDzNGa1E+TbEIvYUXVbCEdclJbzvViyU+bANV1337iivQSx
         8lLqLCt7h9X/BPhvZey6kO4jL17Ky1I9XRD1LGUYxTJ7U6gVQRcdlRWBWxFrEetBVoHO
         bpkCze66VeDJ9CmNmsWqM91+BIpArS84TDeHPMieh5Dq650r4l8HPxHjyplI2LGs/9FS
         7c7U9GLYHihG8JX+YXU8VPNSYUgQQcCBF1Y7OgGdZJzcEov9OX32r2VrUosRHQy4yxCH
         dc2EI6RGNy5ZNqwLLSNJSsJd4hWKvEdquVDANHVvjIFX2Aa8XdlSekHufEXZ37S1MOJI
         HaFw==
X-Gm-Message-State: AOAM532PD7cmMoPfOrUrF5L1ydYM0cNGKeb4Zldk+vHUQwPbiZEQf57L
        GTLWYc0H6BuLQODq4yB/bVns/kgs6N4kQnSrWok=
X-Google-Smtp-Source: ABdhPJww6iKdpqCo7i0DLnnBg8yn+ASnskqRd8nMWT8j5w3LUd+Vv/EmoEO2GQob/q2uJhtuznO0DPhZzhOpQWxyyg0=
X-Received: by 2002:a9d:590a:: with SMTP id t10mr33047434oth.262.1594642603476;
 Mon, 13 Jul 2020 05:16:43 -0700 (PDT)
MIME-Version: 1.0
References: <2016232.ihCVsphvri@kreacher> <2988949.NgUrjYMkJj@kreacher> <000801d65634$14f0ecb0$3ed2c610$@net>
In-Reply-To: <000801d65634$14f0ecb0$3ed2c610$@net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 13 Jul 2020 14:16:32 +0200
Message-ID: <CAJZ5v0gmzUAXavNY=hFnG+983sQWWuAJhCeJBumD3mmt79cepg@mail.gmail.com>
Subject: Re: [PATCH 2/2] cpufreq: intel_pstate: Use passive mode by default
 without HWP
To:     Doug Smythies <dsmythies@telus.net>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jul 9, 2020 at 11:01 PM Doug Smythies <dsmythies@telus.net> wrote:
>
> Hi Rafael,
>
> As you may or may not recall, I am attempting to untangle
> and separate multiple compounding issues around the
> intel_pstate driver and HWP (or not).
>
> Until everything is figured out, I am using the following rules:
>
> . never use x86_energy_perf_policy.
> . For HWP disabled: never change from active to passive or via versa, but rather do it via boot.
> . after boot always check and reset the various power limit log bits that are set.
> . never compile the kernel (well, until after any tests), which will set those bits again.
> . never run prime95 high heat torture test, which will set those bits again.
> . try to never do anything else that will set those bits again.
>
> On 2020.03.28 05:58 Rafael J. Wysocki wrote:
> >
> > From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> >
> > After recent changes allowing scale-invariant utilization to be
> > used on x86, the schedutil governor on top of intel_pstate in the
> > passive mode should be on par with (or better than) the active mode
> > "powersave" algorithm of intel_pstate on systems in which
> > hardware-managed P-states (HWP) are not used, so it should not be
> > necessary to use the internal scaling algorithm in those cases.
> >
> > Accordingly, modify intel_pstate to start in the passive mode by
> > default if the processor at hand does not support HWP of if the driver
> > is requested to avoid using HWP through the kernel command line.
> >
> > Among other things, that will allow utilization clamps and the
> > support for RT/DL tasks in the schedutil governor to be utilized on
> > systems in which intel_pstate is used.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  Documentation/admin-guide/pm/intel_pstate.rst | 32 ++++++++++++++++-----------
> >  drivers/cpufreq/intel_pstate.c                |  3 ++-
> >  2 files changed, 21 insertions(+), 14 deletions(-)
> >
> > diff --git a/Documentation/admin-guide/pm/intel_pstate.rst b/Documentation/admin-
> > guide/pm/intel_pstate.rst
> > index ad392f3aee06..39d80bc29ccd 100644
> > --- a/Documentation/admin-guide/pm/intel_pstate.rst
> > +++ b/Documentation/admin-guide/pm/intel_pstate.rst
> > @@ -62,9 +62,10 @@ on the capabilities of the processor.
> >  Active Mode
> >  -----------
> >
> > -This is the default operation mode of ``intel_pstate``.  If it works in this
> > -mode, the ``scaling_driver`` policy attribute in ``sysfs`` for all ``CPUFreq``
> > -policies contains the string "intel_pstate".
> > +This is the default operation mode of ``intel_pstate`` for processors with
> > +hardware-managed P-states (HWP) support.  If it works in this mode, the
> > +``scaling_driver`` policy attribute in ``sysfs`` for all ``CPUFreq`` policies
> > +contains the string "intel_pstate".
> >
> >  In this mode the driver bypasses the scaling governors layer of ``CPUFreq`` and
> >  provides its own scaling algorithms for P-state selection.  Those algorithms
> > @@ -138,12 +139,13 @@ internal P-state selection logic to be less performance-focused.
> >  Active Mode Without HWP
> >  ~~~~~~~~~~~~~~~~~~~~~~~
> >
> > -This is the default operation mode for processors that do not support the HWP
> > -feature.  It also is used by default with the ``intel_pstate=no_hwp`` argument
> > -in the kernel command line.  However, in this mode ``intel_pstate`` may refuse
> > -to work with the given processor if it does not recognize it.  [Note that
> > -``intel_pstate`` will never refuse to work with any processor with the HWP
> > -feature enabled.]
> > +This operation mode is optional for processors that do not support the HWP
> > +feature or when the ``intel_pstate=no_hwp`` argument is passed to the kernel in
> > +the command line.  The active mode is used in those cases if the
> > +``intel_pstate=active`` argument is passed to the kernel in the command line.
>
> ???
> I can not see anywhere in the code where the kernel command line argument
> "intel_pstate=active" is dealt with.

My bad, sorry about this.

I'll send a patch to fix this issue shortly.

Thanks!
