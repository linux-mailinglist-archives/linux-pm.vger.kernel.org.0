Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 645EAC48E5
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2019 09:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbfJBHzr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Oct 2019 03:55:47 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38232 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfJBHzr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Oct 2019 03:55:47 -0400
Received: by mail-oi1-f194.google.com with SMTP id m16so16862239oic.5;
        Wed, 02 Oct 2019 00:55:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QclJuRY72MdDp8jaVWHz7GodR3RToc7WJQTayvwTp3c=;
        b=kC2gnKKgX9TajMnfZYHs7kGh3ftILQCnu62FXBp1/4g+OV3bU5YAWapTtwZoU3ZL98
         EikOZla/pyxVR5a01hrz5bex+aCma6AjKm9YLruE//juVRDAoae01csTgnUCjuLcQomY
         PYBCFpQ73HFR2zMuts5LshMdSCaKGNX5gg56D3LRrvR32fH/TdP1AvQiqOOfHPewkJXb
         ekzjeNe+4Aqz3a6oWIfLruKQea0fyWtCUKRsegpiypbuvGcUE+zwcxxkzYUQLo+xoNPC
         o15GyZQ/7IxIO7fCOWQTU+ixBKVpd2mRctybNohdLh+ZgRDP4XnYR5pdFMTnrxgfLdQD
         Qiyw==
X-Gm-Message-State: APjAAAVV1wD+ny6lHFgWvUdtuXGclrmOVkaePmRccVQA+mhlsD82qZe5
        srpARVJRZX373YStAUBjWmIQWhJ02xABiX1kRqc=
X-Google-Smtp-Source: APXvYqyvd7SG7LoMuuKXntk1Mpdg/tvIGEsHdzjmV+zL6w4c+HnQEkMdonbkpe5/j9xp0XcEr8lfOmkRlbGvpFr4Bvc=
X-Received: by 2002:aca:50ca:: with SMTP id e193mr1848851oib.110.1570002945947;
 Wed, 02 Oct 2019 00:55:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190926150406.v1.1.I07a769ad7b00376777c9815fb169322cde7b9171@changeid>
 <20190927044239.589e7c4c@oasis.local.home> <20191001163542.GB87296@google.com>
 <20191001130343.4480afe3@gandalf.local.home> <20191001174235.GC87296@google.com>
 <20191001140846.65d7866c@gandalf.local.home> <20191001193701.GD87296@google.com>
In-Reply-To: <20191001193701.GD87296@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 2 Oct 2019 09:55:33 +0200
Message-ID: <CAJZ5v0iepu-WAdT=kLcXruRGAerjfPqzgxK_003OpjRho4OrPg@mail.gmail.com>
Subject: Re: [PATCH v1] PM / Domains: Add tracepoints
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Douglas Anderson <dianders@chromium.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 1, 2019 at 9:37 PM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> On Tue, Oct 01, 2019 at 02:08:46PM -0400, Steven Rostedt wrote:
> > On Tue, 1 Oct 2019 10:42:35 -0700
> > Matthias Kaehlcke <mka@chromium.org> wrote:
> >
> > > On Tue, Oct 01, 2019 at 01:03:43PM -0400, Steven Rostedt wrote:
> > > > On Tue, 1 Oct 2019 09:35:42 -0700
> > > > Matthias Kaehlcke <mka@chromium.org> wrote:
> > > >
> > > > > How about this instead:
> > > > >
> > > > >   Add tracepoints for genpd_power_on, genpd_power_off and
> > > > >   genpd_set_performance_state. The tracepoints can help with
> > > > >   understanding power domain behavior of a given device, which
> > > > >   may be particularly interesting for battery powered devices
> > > > >   and suspend/resume.
> > > >
> > > > Do you have a use case example to present?
> > >
> > > TBH I'm not looking into a specific use case right now. While
> > > peeking around in /sys/kernel/debug/tracing/events to learn more
> > > about existing tracepoints that might be relevant for my work
> > > I noticed the absence of genpd ones and it seemed a good idea to
> > > add them preemptively. Conceptually they seem similar to the
> > > existing regulator_enable/disable and cpu_idle tracepoints.
> > >
> > > As an abstract use case I could see power analysis on battery
> > > powered devices during suspend. genpd_power_on/off allow to see
> > > which power domains remain on during suspend, and might give
> > > insights for possible power saving options. Examples could be that
> > > a power domain stays unexpectedly on due to a misconfiguration, or
> > > two power domains remain on when it could be only one if you just
> > > moved that one pin/port over to the other domain in the next
> > > hardware revision.
> >
> > If the power management maintainers have no issues with adding these,
> > then neither do I ;-)  It would be them who would pull them in anyway.
>
> Ok, I'll send a new version with the changes you suggested and some more
> info in the commit message, unless PM maintainers raise concerns before
> that.

I have no problems with adding tracepoints (or trace events to be more
precise) in there, but Ulf has been taking care of that code for quite
some time, so his opinion matters more than mine in that respect.
