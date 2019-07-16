Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAB4F6A507
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2019 11:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730520AbfGPJgX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jul 2019 05:36:23 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:47017 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbfGPJgX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jul 2019 05:36:23 -0400
Received: by mail-ot1-f66.google.com with SMTP id z23so20302602ote.13;
        Tue, 16 Jul 2019 02:36:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+FC2gEuUssDgT4OS9oZYvaF6YcJNLaJUbd2YY7jMw8g=;
        b=QmCFoo6VCz8IOkHgPSpcoqQWh+6+c5jLwenSihKGXh6DEUTZnFt0hcwjv8jOZwpdsQ
         Q72RlhXvSAaWtFv+gGjRiInPP5SRQDTIC2jGAxO9Vpovp+IAoSTjrK68x7KruDRgFDmU
         Gzcoyin4uJ7sDyh6YMHQDwjTbWvQg+1rNghbfZhAIbmW6iCS9P7wJ1cZQJeKrFytGPQ5
         IDfm3NhlRpYOQU69brga67tl4mqPpHEIea6Goa4nPB4kLxz9CYMfG6zXggNS4pQgqHQ+
         A/yrDBZTaNxVkCFTpcNqd7WeXlYg4DFZfH6SydWW+0Oy9yNedH8FebtGK5I5BU/qqWCC
         FsIQ==
X-Gm-Message-State: APjAAAV403nWomNA1v/kRJhLsgYh68YEc7xOEpesv22Q1TibDoNw/yT6
        X5qbTvDMYMLYalPj7+i5o6g0POhUALB5/GmMVvc=
X-Google-Smtp-Source: APXvYqye2+Yv37nNrcFQcvVln6e3m1X/j98CGzS3EPlCaDhA5GjsKAwkzyxHc/KXubRpuEM050HrcaBQEwoNGF3DgEA=
X-Received: by 2002:a05:6830:8a:: with SMTP id a10mr18293432oto.167.1563269781832;
 Tue, 16 Jul 2019 02:36:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190715203651.GA7513@kroah.com> <20190715214348.81865-1-trong@android.com>
 <CAJZ5v0gEzZkbeLFtW5yadwxBryvL3vWcUoQTkUy3VkxiTV+UrA@mail.gmail.com>
 <20190716021102.GA8310@kroah.com> <CAJZ5v0hxKeK-eDEs1rGP0ZYbbCHa0q5=ZPMVCemYVHGL48Q=pg@mail.gmail.com>
 <20190716083926.GA2505@kroah.com>
In-Reply-To: <20190716083926.GA2505@kroah.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 16 Jul 2019 11:36:10 +0200
Message-ID: <CAJZ5v0iHoxWoQF5xbmo2Ry0b_vb_sdh9__8aPwugDwx=q_+RWg@mail.gmail.com>
Subject: Re: [PATCH v4] PM / wakeup: show wakeup sources stats in sysfs
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Tri Vo <trong@android.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Hridya Valsaraju <hridya@google.com>, sspatil@google.com,
        kaleshsingh@google.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 16, 2019 at 10:39 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jul 16, 2019 at 10:30:48AM +0200, Rafael J. Wysocki wrote:
> > On Tue, Jul 16, 2019 at 4:13 AM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Mon, Jul 15, 2019 at 11:48:27PM +0200, Rafael J. Wysocki wrote:
> > > > On Mon, Jul 15, 2019 at 11:44 PM Tri Vo <trong@android.com> wrote:
> > > > >
> > > > > Userspace can use wakeup_sources debugfs node to plot history of suspend
> > > > > blocking wakeup sources over device's boot cycle. This information can
> > > > > then be used (1) for power-specific bug reporting and (2) towards
> > > > > attributing battery consumption to specific processes over a period of
> > > > > time.
> > > > >
> > > > > However, debugfs doesn't have stable ABI. For this reason, create a
> > > > > 'struct device' to expose wakeup sources statistics in sysfs under
> > > > > /sys/class/wakeup/<name>/.
> > > > >
> > > > > Introduce CONFIG_PM_SLEEP_STATS that enables/disables showing wakeup
> > > > > source statistics in sysfs.
> > > >
> > > > I'm not sure if this is really needed, but I'll let Greg decide.
> > >
> > > You are right.  Having zillions of config options is a pain, who is
> > > going to turn this off?
> > >
> > > But we can always remove the option before 5.4-rc1, so I'll take this
> > > as-is for now :)
> > >
> > > > Apart from this
> > > >
> > > > Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > thanks for the review!  I'll wait for 5.3-rc1 to come out before adding
> > > this to my tree.
> >
> > So it occurred to me that maybe it's better if I apply it?  After all,
> > this is PM material. :-)
>
> Heh, true, feel free to add:
>         Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> to the patch then.

I will, thank you!
