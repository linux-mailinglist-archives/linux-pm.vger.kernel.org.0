Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9EE2DF61D
	for <lists+linux-pm@lfdr.de>; Sun, 20 Dec 2020 17:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbgLTQm1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 20 Dec 2020 11:42:27 -0500
Received: from mail-ot1-f53.google.com ([209.85.210.53]:37724 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727112AbgLTQm0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 20 Dec 2020 11:42:26 -0500
Received: by mail-ot1-f53.google.com with SMTP id o11so6772504ote.4;
        Sun, 20 Dec 2020 08:42:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uMR8UsOOJm/t0/BOhlXp0IthO+C1BPZiiQ0XR2+w7ww=;
        b=tN4EttWdmxiS6dAbsrwdkDa8g0SkhM+tMitDgKwse15nmbt7NwxspFaQ/YOe3wMXqc
         TRmRg3OE05AbI1AgMuZsY1vrRjFpYbUOLhxchjPIEud4ooZsU9mtqWsdNKiidBZ2Nfaw
         NGsRzJ8SVA+r4rWTQDcHqCZ/kIKrpfTmPFO6its6kemJtZZxnBF1LQX0Q1SQBLMq7kQ3
         ujGywnmNMkvHFjvZVl/cHKRVGVLe2wp/j1PCnGKMVmXTEjeupg2x3sDfgOucvqTM3SLa
         h1ZmpVptmpICbodn6fFtP1cZHdK4CMxJJENWSeJH9jKwY7VwI7lysNLaZmamR8xUYSHS
         SBKw==
X-Gm-Message-State: AOAM533++AxVjw6f4PjXTKV0JMpQwvIZFr7C4Tv6ks++BIrGY86W2bPM
        OqJfJRi6BomaedVDNmyZVLOL0F7E908l9ERSQi8=
X-Google-Smtp-Source: ABdhPJxu1NdQ2VEEArUeKHXHU7STlJr8bQSiHLupXAthuz+qkIMoCfQJFz8lBMF+7/LsFVi3fOFkILZwTDH18FoJqZ4=
X-Received: by 2002:a9d:67da:: with SMTP id c26mr9552050otn.321.1608482505856;
 Sun, 20 Dec 2020 08:41:45 -0800 (PST)
MIME-Version: 1.0
References: <4600970.KDbqdY64fy@kreacher> <dffbe4d3d56f29a985d84dcb9e48c7f6fba0514c.camel@linux.intel.com>
In-Reply-To: <dffbe4d3d56f29a985d84dcb9e48c7f6fba0514c.camel@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sun, 20 Dec 2020 17:41:30 +0100
Message-ID: <CAJZ5v0jemyvcEFr1n=ZTBnisOW2K2MfhkxJmppEfqqogYcNbmA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Use most recent guaranteed
 performance values
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Dec 19, 2020 at 6:21 AM srinivas pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Thu, 2020-12-17 at 20:17 +0100, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > When turbo has been disabled by the BIOS, but HWP_CAP.GUARANTEED is
> > changed later, user space may want to take advantage of this
> > increased
> > guaranteed performance.
> >
> > HWP_CAP.GUARANTEED is not a static value.  It can be adjusted by an
> > out-of-band agent or during an Intel Speed Select performance level
> > change.  The HWP_CAP.MAX is still the maximum achievable performance
> > with turbo disabled by the BIOS, so HWP_CAP.GUARANTEED can still
> > change as long as it remains less than or equal to HWP_CAP.MAX.
> >
> > When HWP_CAP.GUARANTEED is changed, the sysfs base_frequency
> > attribute shows the most recent guaranteed frequency value. This
> > attribute can be used by user space software to update the scaling
> > min/max limits of the CPU.
> >
> > Currently, the ->setpolicy() callback already uses the latest
> > HWP_CAP values when setting HWP_REQ, but the ->verify() callback will
> > restrict the user settings to the to old guaranteed performance value
> > which prevents user space from making use of the extra CPU capacity
> > theoretically available to it after increasing HWP_CAP.GUARANTEED.
> >
> > To address this, read HWP_CAP in intel_pstate_verify_cpu_policy()
> > to obtain the maximum P-state that can be used and use that to
> > confine the policy max limit instead of using the cached and
> > possibly stale pstate.max_freq value for this purpose.
> >
> > For consistency, update intel_pstate_update_perf_limits() to use the
> > maximum available P-state returned by intel_pstate_get_hwp_max() to
> > compute the maximum frequency instead of using the return value of
> > intel_pstate_get_max_freq() which, again, may be stale.
> >
> > This issue is a side-effect of fixing the scaling frequency limits in
> > commit eacc9c5a927e ("cpufreq: intel_pstate: Fix
> > intel_pstate_get_hwp_max()
> > for turbo disabled") which currected
> corrected

Right, thanks!
