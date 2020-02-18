Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 797BB163784
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2020 00:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbgBRXxO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Feb 2020 18:53:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:46044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726716AbgBRXxO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 18 Feb 2020 18:53:14 -0500
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DD1B2465A;
        Tue, 18 Feb 2020 23:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582069993;
        bh=YjCz20u5qK9/aj8t+FGcAcBFISIhsH0FVDLB4Ogpfeg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IqUkCYBHI1LPGm/S4CRCNpyYKg2J7ClmF4QMfFfjs9V+Ntm9qpfPpnzePIe97WX/K
         bcUC7dKjkV59OGb7WOp8QSyaYK8WY09lgcNUWb41IdKny223yk2g/H3WwMu5XQW70W
         Q8zkLqs+mWhtURZYqA/ob4OafZpwrM9rQcUDofQQ=
Received: by mail-qt1-f177.google.com with SMTP id w47so15906576qtk.4;
        Tue, 18 Feb 2020 15:53:13 -0800 (PST)
X-Gm-Message-State: APjAAAX1NtuZgmSFLkF8U0oFBmPrcZls26dXha1ZvaQQ766UqPfD8PuD
        DmXIWnnoRl3IEvF7NxcLv+02VQCAEYb4NspIBA==
X-Google-Smtp-Source: APXvYqxrJE335t2FjR4iBtJ6HJAhgu8z5nJYdc9dkse1UfSdNHwsqTSOPIax8IEVjBHsl64ZV1VYXZbERi+/c9/dMys=
X-Received: by 2002:aed:2344:: with SMTP id i4mr19867956qtc.136.1582069992571;
 Tue, 18 Feb 2020 15:53:12 -0800 (PST)
MIME-Version: 1.0
References: <20200218220748.54823-1-john.stultz@linaro.org>
 <CAL_JsqK5eVCuKiy2R_=5cyEBFM=YvMODqDYrmJxLPyN-Em-++g@mail.gmail.com> <CALAqxLUTNq-Dg5Nd4PozCUx3K0hnVEJYmNnkpnGWGhph8vNr8w@mail.gmail.com>
In-Reply-To: <CALAqxLUTNq-Dg5Nd4PozCUx3K0hnVEJYmNnkpnGWGhph8vNr8w@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 18 Feb 2020 17:53:01 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJuG7ABaZSg=7mr0jHRruoAiWf6vJRD_Ev3DH6BrtpUtg@mail.gmail.com>
Message-ID: <CAL_JsqJuG7ABaZSg=7mr0jHRruoAiWf6vJRD_Ev3DH6BrtpUtg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] driver core: Rework logic in __driver_deferred_probe_check_state
 to allow EPROBE_DEFER to be returned for longer
To:     John Stultz <john.stultz@linaro.org>
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

On Tue, Feb 18, 2020 at 5:21 PM John Stultz <john.stultz@linaro.org> wrote:
>
> On Tue, Feb 18, 2020 at 2:51 PM Rob Herring <robh@kernel.org> wrote:
> >
> > On Tue, Feb 18, 2020 at 4:07 PM John Stultz <john.stultz@linaro.org> wrote:
> > >
> > > Due to commit e01afc3250255 ("PM / Domains: Stop deferring probe
> > > at the end of initcall"), along with commit 25b4e70dcce9
> > > ("driver core: allow stopping deferred probe after init") after
> > > late_initcall, drivers will stop getting EPROBE_DEFER, and
> > > instead see an error causing the driver to fail to load.
> > >
> > > That change causes trouble when trying to use many clk drivers
> > > as modules, as the clk modules may not load until much later
> > > after init has started. If a dependent driver loads and gets an
> > > error instead of EPROBE_DEFER, it won't try to reload later when
> > > the dependency is met, and will thus fail to load.
> > >
> > > This patch reworks some of the logic in
> > > __driver_deferred_probe_check_state() so that if the
> > > deferred_probe_timeout value is set, we will return EPROBE_DEFER
> > > until that timeout expires, which may be after initcalls_done
> > > is set to true.
> > >
> > > Specifically, on db845c, this change (when combined with booting
> > > using deferred_probe_timeout=30) allows us to set SDM_GPUCC_845,
> > > QCOM_CLK_RPMH and COMMON_CLK_QCOM as modules and get a working
> > > system, where as without it the display will fail to load.
> >
> > I would change the default for deferred_probe_timeout to 30 and then
> > regulator code can rely on that.
>
> That is exactly what I do in the following patch! Let me know if you
> have further suggestions for it.

Indeed.

Between the above comment and this comment in patch 2:
/* preserve 30 second interval if deferred_probe_timeout=-1 */

...I was confused.

> > Curious, why 30 sec is fine now when
> > you originally had 2 min? I'd just pick what you think is best. I
> > doubt Mark had any extensive experiments to come up with 30sec.
>
> I had two minutes initially as, due to other delays I still have to
> chase, booting all the way to UI on the db845c can sometimes take
> almost a minute. So it was just a rough safety estimate. But in v2, I
> tested with the 30 second time used by the regulator code, and that
> seemed to work ok.
>
> As long as 30 seconds is working well, I'm ok with it for now (and it
> can be overrided via boot arg). Though from past experience with
> enterprise distros running on servers with tons of disks (which might
> take many minutes to initialize), I'd suspect its likely some
> environments may need much longer.

Those systems aren't going to have a pinctrl or clock driver sitting
in an encrypted RAID partition either. :)

Rob
