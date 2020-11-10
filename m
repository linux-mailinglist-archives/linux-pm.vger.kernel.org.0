Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4A862AD6FC
	for <lists+linux-pm@lfdr.de>; Tue, 10 Nov 2020 13:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729908AbgKJM74 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Nov 2020 07:59:56 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36187 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbgKJM7z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Nov 2020 07:59:55 -0500
Received: by mail-ot1-f68.google.com with SMTP id n89so1169714otn.3;
        Tue, 10 Nov 2020 04:59:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nQJTAdZ1adBsQ8C+kbyZpy76IwyPcxh02MnCTX/G32M=;
        b=eUoq5h7WdKBQY9bZOt/rWgaNknaR+NAds5bAB+mEB9Uy9h1FjgXPZsjTiaBaoW7NIf
         vkFkmo9iL0D4vrSe0RQv2rR0NZWR2ipUADo5O9b5giv5bL+pmLLqnw05J9SHbx7NuqHu
         T98RymeYRVrYTIrzOHF3A4ulcKbrUt8zqgTg46aELBanYiASoP2yG8oizQQ28lVC517I
         wuaFuOkreXFNCfu0cWWzqzImRCRD1hMq5FlzJlZIibj00lZEmgrdVUYvO1OjviJuk/7J
         ma0knsaVLYwzlwuKLNYnAXP7XSiMkylJdp+MiXLRYrQVhuTZx/aNC0c8ZHsyMDJniZ9B
         WpwA==
X-Gm-Message-State: AOAM530K9HoCRyKTErOlrPKu52kio8mE3M2qAogWXqpzL5FuOhA90Z+9
        kKUfRk6s9z99bUHeo0s/Og+4oE/1XYHos12Zw28TBzqW
X-Google-Smtp-Source: ABdhPJzUgNv59oHa/4ibKbYfwMT74tdKKWstSZKGVCl5k3qih2inBZhq4GNYsjklXLUcM6g/NQIwrNANvQvhHyZtIq4=
X-Received: by 2002:a9d:16f:: with SMTP id 102mr14776795otu.206.1605013195114;
 Tue, 10 Nov 2020 04:59:55 -0800 (PST)
MIME-Version: 1.0
References: <0e0fb542b6f6b26944cb2cf356041348aeac95f6.1605006378.git.viresh.kumar@linaro.org>
In-Reply-To: <0e0fb542b6f6b26944cb2cf356041348aeac95f6.1605006378.git.viresh.kumar@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 10 Nov 2020 13:59:42 +0100
Message-ID: <CAJZ5v0hqxzE3c6Nz7f=23OBYPA7z-pJaSwk9JGTFTr1SYDFubg@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: stats: Switch to ktime and msec instead of
 jiffies and usertime
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Thomas Renninger <trenn@suse.com>,
        Shuah Khan <shuah@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Nov 10, 2020 at 12:07 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> The cpufreq and thermal core, both provide sysfs statistics to help
> userspace learn about the behavior of frequencies and cooling states.
>
> This is how they look:
>
> /sys/devices/system/cpu/cpufreq/policy0/stats/time_in_state:208000 11
> /sys/devices/system/cpu/cpufreq/policy0/stats/time_in_state:432000 147
> /sys/devices/system/cpu/cpufreq/policy0/stats/time_in_state:729000 1600
> /sys/devices/system/cpu/cpufreq/policy0/stats/time_in_state:960000 879
> /sys/devices/system/cpu/cpufreq/policy0/stats/time_in_state:1200000 399
>
> /sys/class/thermal/cooling_device0/stats/time_in_state_ms:state0 4097
> /sys/class/thermal/cooling_device0/stats/time_in_state_ms:state1 8932
> /sys/class/thermal/cooling_device0/stats/time_in_state_ms:state2 15868
> /sys/class/thermal/cooling_device0/stats/time_in_state_ms:state3 1384
> /sys/class/thermal/cooling_device0/stats/time_in_state_ms:state4 103
>
> Here, state0 of thermal corresponds to the highest frequency of the CPU,
> i.e. 1200000 and state4 to the lowest one.
>
> While both of these try to show similar kind of data (which can still be
> very much different from each other), the values looked different (by a
> factor of 10, i.e. thermal's time_in_state is almost 10 times that of
> cpufreq time_in_state).
>
> This comes from the fact that cpufreq core displays the time in usertime
> units (10 ms).
>
> It would be better if both the frameworks displayed times in the same
> unit as the users may need to correlate between them and different
> scales just make it awkward. And the choice of thermal core for that
> (msec) seems to be a better choice as it is easier to read.
>
> The thermal core also does the stats calculations using ktime, which is
> much more accurate as compared to jiffies used by cpufreq core.
>
> This patch updates the cpufreq core to use ktime for the internal
> calculations and changes the units of time_in_state to msec.

Well, this may confuse user space using the stats today.

>
> The results look like this after this commit:
>
> /sys/devices/system/cpu/cpufreq/policy0/stats/time_in_state:208000 13
> /sys/devices/system/cpu/cpufreq/policy0/stats/time_in_state:432000 790
> /sys/devices/system/cpu/cpufreq/policy0/stats/time_in_state:729000 12492
> /sys/devices/system/cpu/cpufreq/policy0/stats/time_in_state:960000 13259
> /sys/devices/system/cpu/cpufreq/policy0/stats/time_in_state:1200000 3830
>
> /sys/class/thermal/cooling_device0/stats/time_in_state_ms:state0 3888
> /sys/class/thermal/cooling_device0/stats/time_in_state_ms:state1 13432
> /sys/class/thermal/cooling_device0/stats/time_in_state_ms:state2 12336
> /sys/class/thermal/cooling_device0/stats/time_in_state_ms:state3 740
> /sys/class/thermal/cooling_device0/stats/time_in_state_ms:state4 0
>
> FWIW, tools/power/cpupower/ does consume the time_in_state values from
> the sysfs files but it is independent of the unit of the time and didn't
> require an update.

But whoever uses cpupower may be confused.
