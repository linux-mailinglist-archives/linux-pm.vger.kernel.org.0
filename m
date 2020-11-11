Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D36B2AEE1A
	for <lists+linux-pm@lfdr.de>; Wed, 11 Nov 2020 10:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgKKJvO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Nov 2020 04:51:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgKKJvL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Nov 2020 04:51:11 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1477C0613D4
        for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2020 01:51:10 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id j5so704980plk.7
        for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2020 01:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HRhA/9/dWDo5po8jcoZ8JRpSSGgd2ewUSLF6VW3aj9I=;
        b=wiBeiEDmShIVDqF3zPzEIH56Oj+TQiU3sHEjdStNgmjYioOs8x0j89pLGPE1S1pPdB
         VnPYf6QEgtHeW3kBOyGLT/LbjWS1GdXEjrwaKdFyttpKd2dUcHKzlcyPMqOBi8KHTFcd
         4p19jmoq2bdFj8qj0Ujm6zyf8C3ADjOGjIJsEHl93DbvVi67tnFJMpIflgki3PyUwgS3
         7LrU75tZGlaTpPZb5sIteCiLUT0kXbddaVQAVlh25Q1Y2ZOOiiullfFxzsp7tePF8Fnk
         YxFGcZSvK9U8UOeOfT2Jo5YvxvDfvFNcAz6BM5AwS30Yuxu49Gqj3+XgpQSooJkK5CTH
         eHCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HRhA/9/dWDo5po8jcoZ8JRpSSGgd2ewUSLF6VW3aj9I=;
        b=HbGYsYYKA2QMkVrXNXgpJ8x+/2DCquTk6Pyu3nTFs21o47Qc32NuHygwgomVBULfC9
         ef84elrDRObOdhyEcJQ/7taT/Jxvs1taRrLlp/uxEF0SR0UuAvYpf08A6VE44iVNn44S
         BC4mQgSafgVXol6oZ0EfJe8kz86XMJfmtyGb1ZiyL+8wy/t3wY1L022ZVHoXvlG6Jllh
         E0in5anPp59ZpLWHnYMjwBBU0iOoEXQlD6SR+I0gbTEiKCinXLkheJpIeKjMgI8p0F5c
         Ag60TydK1Wm9x/xbA+7LPjm61kcd+AwOTFreroPtFjBUJQgWIZziWgnOWiCAIsF5Qypf
         RAgg==
X-Gm-Message-State: AOAM532/N+rAyOsZdldAU0UjQn7AU9q59+GOn/JCKcAw+seD7DzDZq03
        AjOrUR1fb2uUVravcTrUwxHwpw==
X-Google-Smtp-Source: ABdhPJyy+YswJOhFdT8EBhMSAIQUSlQljZAOzPQtGgNfhVcb5qtVtJC22dSbp0OSqejC7zSnvQOEmg==
X-Received: by 2002:a17:90b:1741:: with SMTP id jf1mr3047963pjb.144.1605088270466;
        Wed, 11 Nov 2020 01:51:10 -0800 (PST)
Received: from localhost ([122.172.12.172])
        by smtp.gmail.com with ESMTPSA id c3sm1863531pjv.27.2020.11.11.01.51.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Nov 2020 01:51:09 -0800 (PST)
Date:   Wed, 11 Nov 2020 15:21:07 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Thomas Renninger <trenn@suse.de>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: stats: Switch to ktime and msec instead of
 jiffies and usertime
Message-ID: <20201111095107.fanba37rgls536xn@vireshk-i7>
References: <0e0fb542b6f6b26944cb2cf356041348aeac95f6.1605006378.git.viresh.kumar@linaro.org>
 <1832747.5iOEhN7m9D@c100>
 <20201111051350.qxevqcca5775h2xa@vireshk-i7>
 <2047155.4hzcE6bcFl@c100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2047155.4hzcE6bcFl@c100>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11-11-20, 09:13, Thomas Renninger wrote:
> Am Mittwoch, 11. November 2020, 06:13:50 CET schrieb Viresh Kumar:
> > On 10-11-20, 13:53, Thomas Renninger wrote:
> > > Am Dienstag, 10. November 2020, 12:07:37 CET schrieb Viresh Kumar:
> > > > The cpufreq and thermal core, both provide sysfs statistics to help
> > > > userspace learn about the behavior of frequencies and cooling states.
> > > > 
> > > > This is how they look:
> > > > /sys/devices/system/cpu/cpufreq/policy0/stats/time_in_state:1200000 399
> > > > 
> > > > The results look like this after this commit:
> > > > /sys/devices/system/cpu/cpufreq/policy0/stats/time_in_state:1200000 3830
> > > 
> > > How would userspace know whether it's ms or 10ms?
> 
> Again:
> How would userspace know whether it's ms or 10ms?

Yeah, I understand the problem you are pointing at.

> > > whatabout a new file with the same convention as cooling devices (adding ms):
> > Keeping two files for same stuff is not great, and renaming the file
> > breaks userspace ABI.
> 
> No exactly the other way around:
> - Renaming, breaks the userspace ABI.
> - Two files would be the super correct way to go:

Yes, but then this is just some stats which a very limited number of
people should be using and so ...

>   - Deprecate the old file and keep the 10ms around for some years
>     ./Documentation/ABI/obsolete
>   - Add the new interface and document it in:
>    ./Documentation/ABI/testing
> 
> As this is about a minor cpufreq_stat debug file, it is enough if
> you rename to:
> > /sys/devices/system/cpu/cpufreq/policy0/stats/time_in_state_ms

... I agree about this. Just rename the file accordingly. Which will
also make sure that everyone follows that something got changed in the
kernel.

> > I already fixed this recently and stats don't appear empty for fast
> > switch anymore.
> 
> Then cpufreq_stats could be a module again?

No, not really. This is some code that needs to get called from
cpufreq core, without any notifiers and as fast as possible as we may
be in scheduler's hot path. So the module thing isn't going to work
now.

-- 
viresh
