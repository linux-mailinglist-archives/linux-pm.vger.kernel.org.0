Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10E7631B822
	for <lists+linux-pm@lfdr.de>; Mon, 15 Feb 2021 12:40:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbhBOLjR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Feb 2021 06:39:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:55574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229802AbhBOLjO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 15 Feb 2021 06:39:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 169C464DE0;
        Mon, 15 Feb 2021 11:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613389113;
        bh=jmmj+Sj/0CdSrHbS95/UtmVOin2tjnR3EAmcJtWDvMw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2mO/lP34yJ55Ulq4sZSmsz3l1aChIoTWHld0y66VyK36nAWf6SFBD7HyBx/0HmFtr
         3WPGf0rnBuGU9wj6EpgaU/xiNaTYHmLE0B81mhLF8f4sNVZRBeKtdzT1K1mrazfANZ
         mN1bdJ4CVBm6IP5IMcNX6DrMvbOU4K6FnTHsKAhU=
Date:   Mon, 15 Feb 2021 12:31:22 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "sre@kernel.org" <sre@kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "wens@csie.org" <wens@csie.org>,
        "saravanak@google.com" <saravanak@google.com>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "jroedel@suse.de" <jroedel@suse.de>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "agross@kernel.org" <agross@kernel.org>,
        "cw00.choi@samsung.com" <cw00.choi@samsung.com>
Subject: Re: [RFC PATCH 1/7] drivers: base: Add resource managed version of
 delayed work init
Message-ID: <YCpbit8W3xsvb37Q@kroah.com>
References: <cover.1613216412.git.matti.vaittinen@fi.rohmeurope.com>
 <1230b0d2ba99ad546d72ab079e76cb1b3df32afb.1613216412.git.matti.vaittinen@fi.rohmeurope.com>
 <2fb4b305-a93f-f91e-3001-dab5057e39cc@redhat.com>
 <084893a3-0071-13e9-5ce6-b7b027e6cd2a@roeck-us.net>
 <16140f5b-c504-1c07-9f0c-3813d686d157@redhat.com>
 <74ec29cb5780e93cca3d4cdec221c65e764c8a3e.camel@fi.rohmeurope.com>
 <400d3e82-a76e-136c-0e03-ed7e40608e2a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <400d3e82-a76e-136c-0e03-ed7e40608e2a@redhat.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Feb 15, 2021 at 11:37:26AM +0100, Hans de Goede wrote:
> Hi,
> 
> On 2/15/21 8:22 AM, Vaittinen, Matti wrote:
> > 
> > On Sat, 2021-02-13 at 16:59 +0100, Hans de Goede wrote:
> >> Hi,
> >>
> >> On 2/13/21 4:27 PM, Guenter Roeck wrote:
> >>> On 2/13/21 7:03 AM, Hans de Goede wrote:
> >>> [ ... ]
> >>>> I think something like this should work:
> >>>>
> >>>> static int devm_delayed_work_autocancel(struct device *dev,
> >>>> struct delayed_work *w,
> >>>> 					void (*worker)(struct
> >>>> work_struct *work)) {
> >>>> 	INIT_DELAYED_WORK(w, worker);
> >>>> 	return devm_add_action(dev, (void (*action)(void
> >>>> *))cancel_delayed_work_sync, w);
> >>>> }
> >>>>
> >>>> I'm not sure about the cast, that may need something like this
> >>>> instead:
> >>>>
> >>>> typedef void (*devm_action_func)(void *);
> >>>>
> >>>> static int devm_delayed_work_autocancel(struct device *dev,
> >>>> struct delayed_work *w,
> >>>> 					void (*worker)(struct
> >>>> work_struct *work)) {
> >>>> 	INIT_DELAYED_WORK(w, worker);
> >>>> 	return devm_add_action(dev,
> >>>> (devm_action_func)cancel_delayed_work_sync, w);
> >>>
> >>> Unfortunately, you can not type cast function pointers in C. It is
> >>> against the C ABI.
> >>> I am sure it is done in a few places in the kernel anyway, but
> >>> those are wrong.
> >>
> >> I see, bummer.
> > 
> > I think using devm_add_action() is still a good idea.
> 
> Yes, we could also just have a 1 line static inline function to do
> the function-cast. Like this:
> 
> static inline void devm_delayed_work_autocancel_func(void *work)
> {
> 	cancel_delayed_work_sync(work);
> }
> 
> static inline int devm_delayed_work_autocancel(struct device *dev, struct delayed_work *w, void (*worker)(struct work_struct *work))
> {
> 	INIT_DELAYED_WORK(w, worker);
> 	return devm_add_action(dev, devm_delayed_work_autocancel_func, w);
> }
> 
> Both functions will then simply be compiled out in files which do not
> use them.
> 
> >> If we add a devm_clk_prepare_enable() helper that should probably be
> >> added
> >> to drivers/clk/clk-devres.c and not to drivers/base/devres.c .
> >>
> >> I also still wonder if we cannot find a better place for this new
> >> devm_delayed_work_autocancel() helper but nothing comes to mind.
> > 
> > I don't like the idea of including device.h from workqueue.h - and I
> > think this would be necessary if we added
> > devm_delayed_work_autocancel() as inline in workqueue.h, right?
> 
> Yes.
> 
> > I also see strong objection towards the devm managed clean-ups.
> 
> Yes it seems that there are some people who don't like this, where as
> others do like them.
> 
> > How about adding some devm-helpers.c in drivers/base - where we could
> > collect devm-based helpers - and which could be enabled by own CONFIG -
> > and left out by those who dislike it?
> 
> I would make this something configurable through Kconfig, but if
> go the static inline route, which I'm in favor of then we could just
> have a:
> 
> include/linux/devm-cleanup-helpers.h
> 
> And put everything (including kdoc texts) there.
> 
> This way the functionality is 100% opt-in (by explicitly including
> the header if you want the helpers) which hopefully makes this a
> bit more acceptable to people who don't like this style of cleanups.
> 
> I would be even happy to act as the upstream maintainer for such a
> include/linux/devm-cleanup-helpers.h file, I can maintain it as part
> of the platform-drivers-x86 tree (with its own MAINTAINERS entry).
> 
> Greg, would this be an acceptable solution to you ?

I don't know, sorry, let's revisit this after 5.12-rc1 is out, with a
patch set that I can review again, and we can go from there as I can't
do anything until then...

thanks,

greg k-h
