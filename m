Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1383B2CC3FE
	for <lists+linux-pm@lfdr.de>; Wed,  2 Dec 2020 18:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387649AbgLBRkK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Dec 2020 12:40:10 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33140 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730836AbgLBRkK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Dec 2020 12:40:10 -0500
Received: by mail-ot1-f66.google.com with SMTP id b18so1800308ots.0;
        Wed, 02 Dec 2020 09:39:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tka6NXMWUhwZ2GkXMJAmEqAo04rklmyCqGj4K23JgnI=;
        b=FkLehLuH9/PjQ0nCEkZUbnWdQRLgHQQt4RNLcrdTSoMcctVVuhGkR6pbmNYvS+kOAi
         DsWt/DKthZcaLcsJQbvICriecYK3V0C2MFym7afnkAGX6A4yKyh5o0cOOHVBeyTCoWxm
         6yiByAW2OUgjzAo0SPZiVF1z994hfwuw2GtVHzT/MPlt9L0lFm8ucv2aFHz0teJ7jxKE
         P306JWDpAg4cEAe0ZKMVtM4NGRhTiOHtZBQEyfhWhYOSXfzU7nj4h5xLzjeF15LBCyCK
         Q9Ab/sReJKWy8dXp4Q7PM2gS3wGa3XMf1PKbFsLkWE/3O7T4G4DMc5WTNQixqkOhx+5V
         QcpA==
X-Gm-Message-State: AOAM530dTaz6TB1wZLy28zBCt3OK2YzIODfUeXF5chWLmXANSc1V8uii
        uOUFLaYw7lUTxA4Jf1nNT322yuztU0aBsXnSSS4=
X-Google-Smtp-Source: ABdhPJzswQBe3taBRqg9cPGNfgA/yb5tM2YE6VWyUuG4TbTtslSxpWyFKAJDKYHYVC9IyMIIwcO5z5OZXPaSttfI0Po=
X-Received: by 2002:a9d:171a:: with SMTP id i26mr2672660ota.260.1606930768936;
 Wed, 02 Dec 2020 09:39:28 -0800 (PST)
MIME-Version: 1.0
References: <1817571.2o5Kk4Ohv2@kreacher> <2174134.tL5yAn4CWt@kreacher> <000901d6c8c3$fa8386f0$ef8a94d0$@net>
In-Reply-To: <000901d6c8c3$fa8386f0$ef8a94d0$@net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 2 Dec 2020 18:39:14 +0100
Message-ID: <CAJZ5v0ghoOs=TwBTMNUk_A_8CwO5wzpwHUjyUwAdajMQpeUoqg@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/2] cpufreq: Add special-purpose fast-switching
 callback for drivers
To:     Doug Smythies <dsmythies@telus.net>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Giovanni Gherdovich <ggherdovich@suse.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Dec 2, 2020 at 4:59 PM Doug Smythies <dsmythies@telus.net> wrote:
>
> Hi Rafael,
>
> On 2020.11.30 10:37 Rafael J. Wysocki wrote:
>
> > First off, some cpufreq drivers (eg. intel_pstate) can pass hints
> > beyond the current target frequency to the hardware and there are no
> > provisions for doing that in the cpufreq framework.  In particular,
> > today the driver has to assume that it should allow the frequency to
>
> Forgot the important "not":

Right, thanks for noticing that!

> today the driver has to assume that it should allow not the frequency to
>
> > fall below the one requested by the governor (or the required capacity
> > may not be provided) which may not be the case and which may lead to
> > excessive energy usage in some scenarios.
> >
> > Second, the hints passed by these drivers to the hardware neeed not
>
> s/neeed/need

Yup, thanks!

> ...
>
> O.K. this is good.
>
> The problem with my basic CPU frequency verses load test with the
> schedutil governor is that it is always so oscillatory it is pretty
> much not possible to conclude anything. So I re-worked the test
> to look at Processor Package Power load instead.
>
> In a previous e-mail [1] I had reported the power differences
> for one periodic load at one frequency, as a (apparently cherry picked)
> example. Quoted:
>
> > schedutil governor:
> > acpi-cpufreq: good
> > intel_cpufreq hwp: bad    <<<<< Now good, with this patch set.

OK, great!

> > intel_cpufreq no hwp: good
> > ...
> > periodic workflow at 347 hertz.
> > ~36% load at 4.60 GHz (where hwp operates)
> > ~55% load at 3.2 GHz (where no hwp operates)
> >
> > intel_cpufreq hwp: 9.6 processor package watts. 45.8 watts on the mains to the computer.
> > intel_cpufreq no hwp: ~6 processor package watts. ~41 watts on the mains to the computer. (noisy)
>
> So this time, I only have power/energy data, and a relatively easy way to compress all 12,000
> samples into some concise summary is to simply find the average power for the entire experiment:
>
> Legend:
> hwp: Kernel 5.10-rc6, HWP enabled; intel_cpufreq; schedutil (always)
> rjw: Kernel 5.10-rc6 + this patch set, HWP enabled; intel_cpu-freq; schedutil
> no-hwp: Kernel 5.10-rc6, HWP disabled; intel_cpu-freq; schedutil
> acpi-cpufreq: Kernel 5.10-rc6, HWP disabled; acpi-cpufreq; schedutil
>
> load work/sleep frequency: 73 Hertz:
> hwp: Average: 12.00822 watts
> rjw: Average: 10.18089 watts
> no-hwp: Average: 10.21947 watts
> acpi-cpufreq: Average:  9.06585 watts
>
> load work/sleep frequency: 113 Hertz:
>
> hwp: Average: 12.01056
> rjw: Average: 10.12303
> no-hwp: Average: 10.08228
> acpi-cpufreq: Average:  9.02215
>
> load work/sleep frequency: 211 Hertz:
>
> hwp: Average: 12.16067
> rjw: Average: 10.24413
> no-hwp: Average: 10.12463
> acpi-cpufreq: Average:  9.19175
>
> load work/sleep frequency: 347 Hertz:
>
> hwp: Average: 12.34169
> rjw: Average: 10.79980
> no-hwp: Average: 10.57296
> acpi-cpufreq: Average:  9.84709
>
> load work/sleep frequency: 401 Hertz:
>
> hwp: Average: 12.42562
> rjw: Average: 11.12465
> no-hwp: Average: 11.24203
> acpi-cpufreq: Average: 10.78670
>
> [1] https://marc.info/?l=linux-pm&m=159769839401767&w=2
>
> My tests results graphs:
> Note: I have to code the web site, or I get hammered by bots.
> Note: it is .com only because it was less expensive than .org
> 73 Hertz:
> Double u double u double u dot smythies dot .com/~doug/linux/s18/hwp/k510-rc6/su73/
> 113 Hertz:
> Double u double u double u dot smythies dot .com/~doug/linux/s18/hwp/k510-rc6/su113/
> 211 Hertz:
> Double u double u double u dot smythies dot .com/~doug/linux/s18/hwp/k510-rc6/su211/
> 347 Hertz:
> Double u double u double u dot smythies dot .com/~doug/linux/s18/hwp/k510-rc6/su347/
> 401 Hertz:
> Double u double u double u dot smythies dot .com/~doug/linux/s18/hwp/k510-rc6/su401/

Thanks for the data, this is encouraging!
