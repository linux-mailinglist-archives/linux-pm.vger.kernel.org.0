Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91C9616698B
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2020 22:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbgBTVHF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Feb 2020 16:07:05 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39008 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729075AbgBTVHF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Feb 2020 16:07:05 -0500
Received: by mail-oi1-f193.google.com with SMTP id z2so29024657oih.6
        for <linux-pm@vger.kernel.org>; Thu, 20 Feb 2020 13:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CEqpM8pTtaa8kBXvkF2afExhU5VE6hhbxQEYZLM9f9o=;
        b=Ogz19Yk9H5XLTzlI+qsBb9pKsbfdiaNb5kF79rjKWhBEiVTuvEgj5EsUj9ruE3km4w
         M+PE0CvSxQ5sgsNeolKQP8tCMFBCNvJRgdjo/gElctJ6SP0CewQp7aYQkEGw+UIjRTFg
         vt7lBLrKyCfnh29JuTNTZnjtzY463oih6WInzqzHqB/+VTDEUTKHp2QCWkiEJKGN7iow
         GRxD4epiqERA1pKy1YHUrVkVjOiGawggCRZrdSWCG75/OcF94SjTlrTUcF4pyRMvzeOy
         uoET6vHol5z9RTvtD7HcW3kJ76gnNqt3KIEMVP5y3cTKAWn//lGtjwd3XD1wjUN3p0Pc
         w2Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CEqpM8pTtaa8kBXvkF2afExhU5VE6hhbxQEYZLM9f9o=;
        b=XBj03VHgt43L3C7WW/xU05G1IGe1ToB48+fjqTH1SsqUzdDexNrJSsCg3roApAqEv/
         h7HAyVKhLBUMf1zeKn3dCItOM3qiKgqH2lU0AJAMNBsL/KpUw8MgSBFztLQAmxoffojD
         ZKgy2RWEM2kbFPaHqVZKd9hmAoV4iJ5XPFktwnT2CJrI/PLhL+A3+Utr+vVroOifFvnv
         1zlkbyfZe1VAiGyVl4XZDRbAx+9j9ohyAbu/hmv/BbYWsBKPL1b9kOifabg3XM3pC5KF
         IeymUtH6ObFcvrwHsV2sNJdC20X46WuG2gHmUv70oE+JMg/vT/jYBVIu84TzoPZQejjZ
         /7MQ==
X-Gm-Message-State: APjAAAV57N4UxyptqGYun6KOuMfp/Z1OPjxQBLUIWB8z6DC2Cqn6lxEi
        t9jkpW0+ZWquoSHjWQ/4aC72NX/tw1QkIPisyBz3gQ==
X-Google-Smtp-Source: APXvYqxP9PKok58LLUUNG7nVhdeqHClNCruXo6w/QQOGtYMT/Kv9n9pcPat7eHyeC0AxTQIEXiJHdcvVDAbN5BCqY34=
X-Received: by 2002:aca:ea43:: with SMTP id i64mr3628425oih.30.1582232824291;
 Thu, 20 Feb 2020 13:07:04 -0800 (PST)
MIME-Version: 1.0
References: <20200218220748.54823-1-john.stultz@linaro.org>
 <20200220052739.87057-1-saravanak@google.com> <CAHp75VfodUCQWRcPB08Qmp8o+BxwL4j4aAgqt9cuJ=mHLLAQyQ@mail.gmail.com>
In-Reply-To: <CAHp75VfodUCQWRcPB08Qmp8o+BxwL4j4aAgqt9cuJ=mHLLAQyQ@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 20 Feb 2020 13:06:28 -0800
Message-ID: <CAGETcx-ZbU2qWTyi_Np_YsgDEBYWk2dhJoYMjxJknZT_FiWvGw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] driver core: Rework logic in __driver_deferred_probe_check_state
 to allow EPROBE_DEFER to be returned for longer
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Todd Kjos <tkjos@google.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Feb 20, 2020 at 2:09 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Thu, Feb 20, 2020 at 7:29 AM Saravana Kannan <saravanak@google.com> wrote:
> > On Tue, Feb 18, 2020 at 4:07 PM John Stultz wrote:
> > > Due to commit e01afc3250255 ("PM / Domains: Stop deferring probe
> > > at the end of initcall"), along with commit 25b4e70dcce9
> > > ("driver core: allow stopping deferred probe after init") after
> > > late_initcall, drivers will stop getting EPROBE_DEFER, and
> > > instead see an error causing the driver to fail to load.
> >
> > Both of those patches were the best solution at that point in time. But
> > the kernel has changed a lot since then. Power domain and IOMMU drivers
> > can work as modules now. We have of_devlink and sync_state().
> >
> > So, while a delay might have been the ideal solution back then, I think
> > we need to work towards removing arbitrary timeouts instead of making
> > the timeout mechanism more elaborate.
> >
> > I think driver_deferred_probe_check_state() logic should boiled down
> > to something like:
>
> ...
>
> > Once we add of_devlink support for power-domains, you won't even hit the
> > genpd error path if you have of_devlink enabled. I believe in the case
> > you are testing DB 845c, of_devlink is enabled?
> >
> > If of_devlink is enabled, the devices depending on the unprobed power
> > domains would be deferred without even calling the driver's probe()
> > function.
> >
> > Adding power-domain support to of_devlink is a 2 line change. I'll send
> > it out soon.
>
> ...
>
> Pardon me for not knowing the OF and devlink stuff in particular, but
> have you had a chance to test your changes on some (rather complex)
> ACPI enabled platforms?
> Would it have any complications there?

Hi Andy,

I'm not sure which changes you are referring to. So I'll try to answer
all possibilities :)

If you are referring to the pseudo code proposal, it's mostly
narrowing down the conditions under which the timeout will matter.
1. It's ignoring the timeout stuff if modules are not supported and
all initcall levels are done.
2. If modules are enabled and of_devlink is enabled, it's making sure
the timeout doesn't apply.

(1) seems like a straightforward assumption. (2) is functionally a NOP
for ACPI based platforms. So I don't think we'd have ACPI specific
complications here.

If you were referring to the "of_devlink support for power-domains"
that also won't have any impact on ACPI platforms because right not it
only runs for OF based systems. So again a NOP for ACPI.

Hope that answers your questions.

Thanks,
Saravana
