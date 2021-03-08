Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 071903314E5
	for <lists+linux-pm@lfdr.de>; Mon,  8 Mar 2021 18:31:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbhCHRbY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Mar 2021 12:31:24 -0500
Received: from mail-oi1-f169.google.com ([209.85.167.169]:38192 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbhCHRbG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Mar 2021 12:31:06 -0500
Received: by mail-oi1-f169.google.com with SMTP id v192so4211936oia.5
        for <linux-pm@vger.kernel.org>; Mon, 08 Mar 2021 09:31:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TBVCG1ZD4KE7c1W/+nlBm/O+FnLojlB4EYfOS+v0z/o=;
        b=AXyAL8tql11Lhtnxl7t7++fCXDsH1qAK0pwy3KDYQDoHcD2MNvMPVuWIWiAwfnb20g
         v0rrsCN7kmAfuqDUdjWL6QP3r0NIQVS4NQzTF4Z1tlD62vFGfwbvQWg72qGwaCIO7/9R
         ALwlAOonWKObld/UDdnzt3DWaccr804MQQJxT9qCjYmZiuaCeKyDoGWymMevT3TnENNB
         kRrrP95zIV1lZq/7O4ALNmVVy6GOvP1PLchwjAHl0+Fr3DdiUFnuh0mACfww6BaWepRC
         XLSYeDYisLO9Ye2D6cXRbp4zzTvc4shKhnnetxEi8YTTzIJTc8ifUtMu9Dd3f4D3OKCm
         t1Ag==
X-Gm-Message-State: AOAM530dO3V7cpglKgFfLJpihO8R1C0bUGoFtEBdh4VkozRSWZsjdAsv
        S35XahxDcoKuwhD+/3JlaSp1JVaqWAUy+S1GNG+XWT2iizI=
X-Google-Smtp-Source: ABdhPJzOA/CA88oSU9hE56AKFk64QJ3rvUSGsc5tLEJgG6zvz2wV066JMGTNA5izk8HRJlW0afQLg5XitH/myN4vFig=
X-Received: by 2002:aca:f245:: with SMTP id q66mr17435693oih.69.1615224666177;
 Mon, 08 Mar 2021 09:31:06 -0800 (PST)
MIME-Version: 1.0
References: <20210305080748.GA17954@lst.de> <CAJZ5v0gjO24-Gb-8ejTCkS2z6MFR7ZVAbYveVPkW1B_71u-LsQ@mail.gmail.com>
 <357ec08b83bef385162c23f37b4efa439a120947.camel@intel.com>
 <20210308075048.GA983@lst.de> <CAJZ5v0hRef89EyU8nvbU0UXYHcd7gjk1e4BLDYCzKH7WSNBsWw@mail.gmail.com>
In-Reply-To: <CAJZ5v0hRef89EyU8nvbU0UXYHcd7gjk1e4BLDYCzKH7WSNBsWw@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 8 Mar 2021 18:30:55 +0100
Message-ID: <CAJZ5v0ic8V3rFfB=1mxa6ynpvkGzq-cFqsPN-Ybb=OJpEXS4RQ@mail.gmail.com>
Subject: Re: driver notification when switching between battery vs AC power?
To:     Christoph Hellwig <hch@lst.de>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Mar 8, 2021 at 4:29 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Mon, Mar 8, 2021 at 8:50 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > On Sun, Mar 07, 2021 at 09:53:06PM +0800, Zhang Rui wrote:
> > > Thanks for adding me in the loop.
> > >
> > > Yes, an ACPI notifier callback should be sufficient for this purpose.
> > >
> > > Usually, we get an ACPI notification upon AC plug/unplug, so what we
> > > need in the NVMe driver is to get the notification and then get the
> > > status of AC adapter. As ACPI AC driver always sends the AC events to
> > > acpi notifier chain, what we need is
> > > a) define a notifier callback, and in the notifier callback
> > >    1. ignore non-AC devices,
> > >    2. get AC status, you can refer to acpi_ac_get_state()
> > > b) register the notifier cb to ACPI notifier chain, by invoking
> > >    register_acpi_notifier()
> >
> > Not my direct priority now, but would there be any objections to
> > wire up a power_source_notifier method in struct dev_pm_ops to
> > avoid boilerplate code and ACPI dependencies in drivers?
>
> That would work for me,

Kind of on a second thought, the convention around dev_pm_ops is that
if the given callback is provided by the device's bus type, it will be
invoked from there and not directly from the driver, and the
bus-type-level callback is expected to decide whether or not to invoke
the driver one.

If that doesn't match the envisioned power_source_notifier handling,
dev_pm_ops may not be the most suitable location for it.  It may be
better to add something to struct device_driver directly.

> unless there is something more generic than
> the ACPI-based notification mechanism already in the power supply
> framework.  Sebastian?
