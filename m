Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 883AA296E0F
	for <lists+linux-pm@lfdr.de>; Fri, 23 Oct 2020 13:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S463275AbgJWL6A (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Oct 2020 07:58:00 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42301 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S463270AbgJWL56 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Oct 2020 07:57:58 -0400
Received: by mail-ot1-f66.google.com with SMTP id h62so1031287oth.9;
        Fri, 23 Oct 2020 04:57:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VPZjENjZEQI2fdov67q7C96gjcEt4c20fJuNO1dmeTg=;
        b=MCavkfte2QIAy9FNEi0zBESEyCcfDV7eQO4BXievJ7SNan2VQu2JsHj1Nr5gd7SqqM
         /Z0uEHw4KkZXAVI+9vmaEEMgqHZ9qworUfcLyslC2vkNGUrB2lKNri8YBLt3UInrKplt
         roIOVgCcBXOLM02wu00HxciSnKVvRPQzxSA/jUTRHZ5QVXFa5RzerHf+miL2hjKcyDSx
         evJ1XJbm5faAbtpOHhCfJz9V6uHhnVZXGB4WhcDbCCKOEBbdoAH8cE+FH/d8q0gAmagd
         TduceW8X1ZY+s3Iv3qGf/lzJTCtZx3V8XFZxSC2CP3lJHen2VuWZLk53+CtpzT9CekLm
         VXtg==
X-Gm-Message-State: AOAM532GcGMZM3yjQ3ROQfHDsO6AyPue5NYon3knHI/yJrqmmRhrsjjV
        NE+BTxtHJ3hSQZubj5Z/EasWTPJAbHFxuIwattk=
X-Google-Smtp-Source: ABdhPJwzYVko2+WxG5doBROxXZMkD/iOiNfDHtR232x78k1VRbQ8g9LcOKBX8+LyRL0GCnNOeW8msfnuO3K9Ylqq1zI=
X-Received: by 2002:a9d:734f:: with SMTP id l15mr1347856otk.260.1603454277339;
 Fri, 23 Oct 2020 04:57:57 -0700 (PDT)
MIME-Version: 1.0
References: <1666263.spd1I39WAV@kreacher> <76352140.UXiy1LajID@kreacher> <20201023061018.euom3sfxw7uvtmya@vireshk-i7>
In-Reply-To: <20201023061018.euom3sfxw7uvtmya@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 23 Oct 2020 13:57:44 +0200
Message-ID: <CAJZ5v0iRgRx-WH3qddkLnpWxFCihSehNcfiQ6zqGoPGm36e=9Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] cpufreq: intel_pstate: Avoid missing HWP max updates
 in passive mode
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Oct 23, 2020 at 8:10 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 22-10-20, 13:57, Rafael J. Wysocki wrote:
> > Index: linux-pm/drivers/cpufreq/cpufreq.c
> > ===================================================================
> > --- linux-pm.orig/drivers/cpufreq/cpufreq.c
> > +++ linux-pm/drivers/cpufreq/cpufreq.c
> > @@ -2182,6 +2182,9 @@ int __cpufreq_driver_target(struct cpufr
> >       pr_debug("target for CPU %u: %u kHz, relation %u, requested %u kHz\n",
> >                policy->cpu, target_freq, relation, old_target_freq);
> >
> > +     if (cpufreq_driver->target)
> > +             return cpufreq_driver->target(policy, target_freq, relation);
> > +
> >       /*
> >        * This might look like a redundant call as we are checking it again
> >        * after finding index. But it is left intentionally for cases where
> > @@ -2194,9 +2197,6 @@ int __cpufreq_driver_target(struct cpufr
> >       /* Save last value to restore later on errors */
> >       policy->restore_freq = policy->cur;
> >
> > -     if (cpufreq_driver->target)
> > -             return cpufreq_driver->target(policy, target_freq, relation);
> > -
> >       if (!cpufreq_driver->target_index)
> >               return -EINVAL;
>
> From what I understood, you want your driver to get notified about
> policy->min/max changes and right now they are making it work from
> within the target() callback.

Not exactly.

The driver needs to update some internal upper and lower boundary
values along with the target freq and skipping the update when target
freq doesn't change prevents it from doing that.

The policy min and max changes are communicated to the driver via the
governor ->limits() callback and that can only call
__cpufreq_driver_target() then or defer the update to the next
->fast_switch() invocation.  Either way, the driver needs to have a
chance to carry out the full update even if the target frequency
doesn't change, but the policy min or max limits may have changed.

> Your commit log talks about policy->max and powersave combination,

Yes, it does, because that's a very clearly visible symptom.

> I think the same will be true in case of policy->min and performance ?

It might in theory, but it is not in practice, because the HWP min is
set to the target freq (and the target freq is already clamped between
the policy min and max).

But generally speaking you are right, this would be a problem for any
driver having to update some internal upper and lower boundary
settings along with the target freq.

> And also with any other governor (like schedutil) if the target_freq doesn't change for a while.

Well, yes.

A change of one of the limits that doesn't cause the target to change
may be missed in general.

> And IMHO, this change is more like a band-aid which is going to remove
> the check of target != cur for all target() type drivers (which aren't
> many) and it feels like a penalty on them (which is also there for
> intel-cpufreq without hwp), and that we will get into the same problem
> for target_index() drivers as well if they want to do something
> similar in future, i.e. skip checking for same-freq.
>
> Maybe adding a new flag for the cpufreq-driver for force-updates would
> be a better solution ? Which will make this very much driver
> dependent.

Fair enough, I'll add a driver flag for that.

Also I split the patch into the core part and the driver-specific part
for clarity.

Thanks!
