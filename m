Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B231D424FC6
	for <lists+linux-pm@lfdr.de>; Thu,  7 Oct 2021 11:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240233AbhJGJNJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Oct 2021 05:13:09 -0400
Received: from mga03.intel.com ([134.134.136.65]:9876 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231661AbhJGJNH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 7 Oct 2021 05:13:07 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10129"; a="226156583"
X-IronPort-AV: E=Sophos;i="5.85,354,1624345200"; 
   d="scan'208";a="226156583"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2021 02:11:13 -0700
X-IronPort-AV: E=Sophos;i="5.85,354,1624345200"; 
   d="scan'208";a="590075333"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2021 02:11:09 -0700
Received: from andy by smile with local (Exim 4.95)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1mYPQg-009Tan-2D;
        Thu, 07 Oct 2021 12:11:06 +0300
Date:   Thu, 7 Oct 2021 12:11:06 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Lee Jones <lee.jones@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v1 0/6] Introduce power off call chain API
Message-ID: <YV65qsQPtQfWvE9W@smile.fi.intel.com>
References: <20211007060253.17049-1-digetx@gmail.com>
 <CAHp75VeHC5M-Rv+wvJQEvmtfX0k7fP6uremGHFMnd8kEqPnBpw@mail.gmail.com>
 <e7763b75-205c-4e9f-ecdc-a32571a4b822@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e7763b75-205c-4e9f-ecdc-a32571a4b822@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 07, 2021 at 11:52:46AM +0300, Dmitry Osipenko wrote:
> 07.10.2021 10:18, Andy Shevchenko пишет:
> > On Thu, Oct 7, 2021 at 9:05 AM Dmitry Osipenko <digetx@gmail.com> wrote:

...

> >> This
> >> is a somewhat simplified version which doesn't try to convert whole kernel
> >> to the new API at once, but solves immediate practical problem that we
> > 
> > problems
> > 
> >> have on Nexus 7 Android tablet where device needs to chain power off
> > 
> > tablets where the device
> 
> Thank you for the corrections, so far there is one problem and one tablet :)

Then use "the Nexus 7 Android tablet" :-)

> > Immediate question here is how do you see the plan of spreading this.
> > I.o.w. can you put an explanation that you have checked, let's say
> >> 80% current users, and they may be converted like [example
> > placeholder] without any special tricks?
> 
> The rough plan is:
> 
> 1. Add new API.
> 2. Convert drivers to the new API per subsystem.

I would suggest to show that you are actually into it by converting a couple of
the subsystems for the starter.

> 3. Expose do_kernel_restart().
> 4. Replace pm_power_off() with do_kernel_poweroff() per arch/, making
> power off similar to the restart that uses do_kernel_restart().
> 5. Remove do_kernel_restart() from kernel/reboot.c
> 
> Majority of pm_power_off() users shouldn't need the chaining and
> pm_power_off() doesn't conflict with the new API, so there is no need to
> rush the conversion.
> 
> The single-link chain users could be converted to the new API directly,
> this will remove some global variables. But at first should be better to
> gain more users who actually need the chained power off since they may
> have very specific requirements not covered by the current variant of
> the API and will be easier to evolve API with less users.

All above in one or another form should be in cover letter.

-- 
With Best Regards,
Andy Shevchenko


