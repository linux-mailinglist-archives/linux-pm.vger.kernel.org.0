Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B085B11207D
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2019 01:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbfLDACY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Dec 2019 19:02:24 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46873 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbfLDACY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Dec 2019 19:02:24 -0500
Received: by mail-ot1-f68.google.com with SMTP id g18so4654683otj.13;
        Tue, 03 Dec 2019 16:02:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=loDjeEqvdAPDUJ1PtnrAtrQds3vuyfNIYlvIHMVmJeQ=;
        b=un4I3yMj/WElUB4CFI0sbd9AiA2PDtsP9MCrtetbGJTVf5WyHir/8xt2VeImOKhGXN
         U+LKerQmKENJeTRRgq5boNLBfdJ4694Okg183MiME2pQBTHOKUMxVaqIm4Suxo51CUOn
         ib0HOfN+/TijFZ7Fway52OH7Y9+ODic72QeaDmlhdShCgH9gBefe2SUKPkQ1VZqEpBHQ
         9kldEkVxjAZWbS3lQ9Eyfa4dHX3CJvJYS3nGishCxTSFMw6JN+sfOS5NpDiv7OVFmq0k
         NfGWVdkfTNSo6of9f6CF8fWaYPvLto6Q+9nMeJaP9nko49TrH+KN9ZfbGXrZrnOpg2jr
         UNlQ==
X-Gm-Message-State: APjAAAXwD181Y3NzjJSr/8V4Iu13yBg6/9+uQv8odXwHYIcNukDB50B5
        hU3Dd0QBcD3TdJ6J2QYyAoJbUMKOQThQ4NWCUGPPvbtt
X-Google-Smtp-Source: APXvYqxS4uMWC9P7L0sz4VxaxXH7oxpwEkU3BDelyKz/0EUVqosU0WUezzrL1HjJUi5ff+Iyrcnqmc1/R1xSN+u25j8=
X-Received: by 2002:a05:6830:95:: with SMTP id a21mr440242oto.167.1575417742980;
 Tue, 03 Dec 2019 16:02:22 -0800 (PST)
MIME-Version: 1.0
References: <20191128160314.2381249-1-thierry.reding@gmail.com>
 <20191128163623.GA2382107@ulmo> <2310325.iNVD75376c@kreacher>
 <4149037.GOuMSCS4uT@kreacher> <20191129094303.GB2770902@ulmo>
 <CAJZ5v0hhMSmLBr+M5CxCrfrcJHH2DzYkRFJBVyBymP0xs35Yzw@mail.gmail.com> <20191129120719.GF2771912@ulmo>
In-Reply-To: <20191129120719.GF2771912@ulmo>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 4 Dec 2019 01:02:11 +0100
Message-ID: <CAJZ5v0hAQ5g72NRxa_xykqVuWsetCb=u9qoTgmF4kHcEzhiVZQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] PM / runtime: Allow drivers to override runtime PM
 behaviour on sleep
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Nov 29, 2019 at 1:07 PM Thierry Reding <thierry.reding@gmail.com> wrote:
>
> On Fri, Nov 29, 2019 at 11:22:08AM +0100, Rafael J. Wysocki wrote:
> >

[cut]

Sorry for the delay.

First off, let me note that I have seen your most recent patches and
thanks for taking the feedback into account, much appreciated!

Nevertheless, I feel that I need to address the below, because it is
really important.

> > Preventing a device from suspending should never be a functional
> > problem.  It may be an energy-efficiency problem, but that's something
> > for user space to consider before writing "on" to a device's control
> > file.
>
> That's really a question of how you define suspension.

In general, yes.

However, if you talk about PM-runtime, there are definitions of
"suspended" and "active" in there already.  Namely, in the PM-runtime
context, "suspended" means "may not be accessible to software" whereas
"active" means "software can access it".

> In the case of
> display drivers we have the somewhat unfortunate situation that in most
> SoCs the display "device" is actually represented by a collection of
> different devices. On Tegra specifically, for example, you have a couple
> of display controllers, then some "encoders" that take pixel streams
> from the display controllers and encode them into some wire format like
> LVDS, HDMI, DSI or DP.
>
> Prohibiting suspension of any of the individual devices causes problems
> because it effectively makes the whole composite display device not
> suspendable.

For PM-runtime, that shouldn't be a problem at all.

PM-runtime is all about (possibly) saving energy by powering down
devices that are not in use.  In particular, It is not about powering
down any devices on demand for any reason other than idleness.
Therefore in PM-runtime a situation in which a given device cannot be
suspended at all is regarded as normal, even though that may not be
desirable for energy-efficiency reasons.  It just means that the
device is in use by somebody all the time.  Moreover, PM-runtime is
designed to make it possible to resume devices at any time (as long as
the hardware works as expected), as soon as they are needed, modulo
some possible delays.  Actually, that's the purpose of a significant
part of the PM-runtime framework.

Accordingly, device drivers may refuse to suspend devices, but
refusing to resume a device is not expected by PM-runtime.

If writing "on" to the "control" file of a device does not cause it to
be resumed (if suspended) and to stay in the "active" meta-state until
"auto" is written to that file, you cannot really claim that
PM-runtime is working correctly on your system.

> Doing so in turn usually means that you can't change the
> display configuration anymore because devices need to be powered up and
> down in order to change the configuration.
>
> I consider powering up and down the devices a form of suspension. Hence
> it seemed natural to implement using runtime PM.

Unfortunately, that's not the case.

The purpose of PM-runtime is to allow idle devices to be put into
power states in which it may not be safe to access them and to make
them go back into the "accessible and responsive" state whenever
software wants/needs to access them in a coordinated fashion.  IOW, it
kind of is a counterpart of CPU idle time management.

> It sounds to me like userspace preventing runtime PM is problematic in
> most scenarios that involve composite devices because it makes all of
> the interactions between the devices a bit complicated.

Even so, that's how it works.

User space can expect to be able to block runtime suspend of devices
at any level of device hierarchy, at least for diagnostics if nothing
else, end the kernel is responsible for ensuring that.

> > > but I would end up reimplementing some of the same concepts. I'd
> > > rather use something that's supported by the PM core and that might be
> > > useful to other drivers than reinvent the wheel.
> >
> > Which doesn't have to be by using PM-runtime suspend for the handling
> > of system-wide suspend, at least in my view.
>
> Well, runtime PM is very convenient for this, though. It would allow the
> same code paths to be used in all cases.

The same low-level power-up and power-down code can be used in all
cases, but PM-runtime is not low-level enough.  It is also
opportunistic, so if you need to power down a device for reasons other
than "natural" idleness, PM-runtime is not the right tool for that
task.

Of course, PM-runtime callbacks can invoke the low-level power-up and
power-down code, but as you said there are reasons for powering down
devices not just because they happen to be idle.  System-wide suspend
is one of them.
