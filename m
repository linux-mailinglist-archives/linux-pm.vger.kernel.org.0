Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA87929DA8A
	for <lists+linux-pm@lfdr.de>; Thu, 29 Oct 2020 00:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388185AbgJ1XYL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Oct 2020 19:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390328AbgJ1XYA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Oct 2020 19:24:00 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E171C0613D1
        for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2020 16:24:00 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id i62so306712vkb.7
        for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2020 16:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=y1LWszpu+vsLMIpACNI5RkrNJ8vWcuOeT19ouqrL6dk=;
        b=gpPJEJdlqQvuf7lgouP6T0cH/F3YsFETEII2GLxOqmupmhhd/zDEgP9m7YmaDU+2fE
         BRh+AVJrnvfFEeUXeO+ZTG1CyWDCQUNwDXqYw/rymDc+gFe6V6ePxgTMTVcovhmPiz0K
         MeeFJkT47pkh+ETSai+YNPK4O9/uJxLroJM8OrVV1M1MWjh6zNUmSYbTN06maru3SA8A
         NT0Y33s/jghoVW3zroaN0zI7oFht2+3WIX/IN3s+6fjFH2HwCkYeZTHa7OElHKVhkhgo
         yJh3dpv6C/LRH0HfIHG5XFtieR/iJ040ucqzQXRm1arx6YLXOB307smvC14KY2ahEC4Y
         0nGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=y1LWszpu+vsLMIpACNI5RkrNJ8vWcuOeT19ouqrL6dk=;
        b=HGEkBjtmFFoMlO2Umf8/7Kbqp7y3V6RkUzczH61od04Y7ckaSOJhe1ewPH+nTa/Kx5
         upY5PrmI9842PfntsVrTCVU1GVbGOCXC2c1EJDWXUA8DMEqamswMmTgXGlzQdP44mGc7
         M4YR3z2PnBro5GLd9YgJVk1Z3be3xilqB+658SdoZOPaXIsdeJ/7BjL+s3RlUuC8WIIJ
         G0SxCx2v4F1F+WsqwBFBw38K3JOSh6eBmN7KURnIBD3wWC/x5Ao01ytd88lw5SL33r0E
         /RWhvzSquz9+vxtbs+9K/nvwk3xMhnemtgn0k2g3PP0+8pcYCPiQDkNZbVDRODGDNG69
         sU+A==
X-Gm-Message-State: AOAM532KSPDBtrGUypimgp+obTrshdbCVv0NbtkBUGia8Fy+1NBR6aQn
        w3WFb31jB7Ji4ZYeRyFtYSMrmt4WH+CvWg==
X-Google-Smtp-Source: ABdhPJykjSPR5YQVpwbkOQvcNJSTUnE8BxG+S2nKmWdl5V2xsV/K9RQ8z/Y/gUlFa/L3dO+EKuEocg==
X-Received: by 2002:aa7:9555:0:b029:152:4b0b:cca with SMTP id w21-20020aa795550000b02901524b0b0ccamr6448373pfq.16.1603878762417;
        Wed, 28 Oct 2020 02:52:42 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id f125sm5090344pfg.149.2020.10.28.02.52.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Oct 2020 02:52:41 -0700 (PDT)
Date:   Wed, 28 Oct 2020 15:22:39 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Stephan Gerhold <stephan@gerhold.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        nks@flawful.org, Georgi Djakov <georgi.djakov@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH V2 2/2] cpufreq: dt: Refactor initialization to handle
 probe deferral properly
Message-ID: <20201028095239.prouhriqr3sykikg@vireshk-i7>
References: <f75c61f193f396608d592ae2a9938264d582c038.1598260050.git.viresh.kumar@linaro.org>
 <CAMuHMdXLQKN5n58NvOp43vhc3ryLXWurBSsmcW9Q=oW502PYOQ@mail.gmail.com>
 <20201013095613.mbgmjwzojg5wxmau@vireshk-i7>
 <CAMuHMdVAJdHVMtK3Sc4sJiJGAwz1J4dKODBFcNzgstaktyKkOw@mail.gmail.com>
 <20201016050347.ers54itzmxgijzsy@vireshk-i7>
 <CAMuHMdUUzoFxbJts3gVC7i5A5daa_TYzKdrGEHho=3a1eeC_ww@mail.gmail.com>
 <20201016080730.h7u3jmlyjbyhqn3t@vireshk-i7>
 <CAMuHMdV1pnE===53_8r596G=9ktw-UMqD3N=T_F34Yk9aw9wWA@mail.gmail.com>
 <20201028054829.42zckdtwvj67tcfl@vireshk-i7>
 <CAMuHMdXnfG8riHYsd9PYSHTDvJ11zQ27y_JJh_9+obUxxLen0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXnfG8riHYsd9PYSHTDvJ11zQ27y_JJh_9+obUxxLen0g@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 28-10-20, 10:49, Geert Uytterhoeven wrote:
> Hi Viresh,
> 
> On Wed, Oct 28, 2020 at 6:48 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > On 27-10-20, 17:29, Geert Uytterhoeven wrote:
> > > On plain v5.9, with #define DEBUG and a few extra debug prints
> > > added, I get:
> > >
> > >     cpufreq_dt: cpufreq_init:164: policy->cpu = 0
> > >     cpufreq_dt: cpufreq_init:165: policy->cpus = 0
> > >     cpufreq_dt: cpufreq_init:166: policy->related_cpus =
> > >     cpufreq_dt: cpufreq_init:167: policy->real_cpus =
> > >     cpu cpu0: dev_pm_opp_of_get_sharing_cpus: Couldn't find opp node.
> > >     of: dev_pm_opp_of_cpumask_add_table:1049
> > >     of: dev_pm_opp_of_cpumask_add_table:1054: cpu 0
> > >     cpu cpu0: dev_pm_opp_of_add_table:954
> > >     cpu cpu0: dev_pm_opp_of_add_table:956:
> > > dev_pm_opp_get_opp_table_indexed() returned (ptrval)
> > >     cpu cpu0: _of_add_opp_table_v1:891
> > >     cpu cpu0: _of_add_opp_table_v1:893: _find_opp_table() returned (ptrval)
> > >     cpu cpu0: _of_add_opp_table_v1:909: 6 entries
> > >     cpu cpu0: dev_pm_opp_get_opp_count:331
> > >     cpu cpu0: dev_pm_opp_get_opp_count:333: _find_opp_table() returned (ptrval)
> > >     cpu cpu0: dev_pm_opp_get_opp_count:342: _get_opp_count() returned 6
> > >     cpu cpu0: dev_pm_opp_get_opp_count:331
> > >     cpu cpu0: dev_pm_opp_get_opp_count:333: _find_opp_table() returned (ptrval)
> > >     cpu cpu0: dev_pm_opp_get_opp_count:342: _get_opp_count() returned 6
> > >     cpu cpu0: dev_pm_opp_get_opp_count:331
> > >     cpu cpu0: dev_pm_opp_get_opp_count:333: _find_opp_table() returned (ptrval)
> > >     cpu cpu0: dev_pm_opp_get_opp_count:342: _get_opp_count() returned 6
> > >     cpu cpu0: Couldn't find proper 'dynamic-power-coefficient' in DT
> > >     cpu cpu0: Couldn't register Energy Model -22
> > >
> > > This happens quite late in the boot sequence, long after cpu1 has been
> > > brought online.
> > > So it finds the v1 opp table for cpu0, which has 6 entries.
> > > The last two messages should be harmless, right?
> >
> > Yes.
> >
> > > So you say cpufreq is not working? How can I verify that?
> >
> > I said it because your earlier logs showed that we defered probed
> > again or the count was 0 and we failed. Something like that.
> >
> > Give output of this to verify if cpufreq is working or not:
> >
> > grep . /sys/devices/system/cpu/cpufreq/policy*/*
> >
> > This will be empty if there is no cpufreq.
> 
> /sys/devices/system/cpu/cpufreq/policy0/affected_cpus:0 1
> /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_cur_freq:375000
> /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_max_freq:1500000
> /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_min_freq:375000
> /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_transition_latency:300000
> /sys/devices/system/cpu/cpufreq/policy0/related_cpus:0 1
> /sys/devices/system/cpu/cpufreq/policy0/scaling_available_frequencies:375000
> 750000 937500 1125000 1312500 1500000
> /sys/devices/system/cpu/cpufreq/policy0/scaling_available_governors:conservative
> ondemand userspace powersave performance schedutil
> /sys/devices/system/cpu/cpufreq/policy0/scaling_cur_freq:375000
> /sys/devices/system/cpu/cpufreq/policy0/scaling_driver:cpufreq-dt
> /sys/devices/system/cpu/cpufreq/policy0/scaling_governor:schedutil
> /sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq:1500000
> /sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq:375000
> /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed:<unsupported>
> 
> So it works in v5.9, but not in v5.10-rc1.
> 
> Bisection says it was broken by commit 90d46d71cce279d8 ("opp: Handle
> multiple calls for same OPP table in _of_add_opp_table_v1()").
> 
> > >     cpu cpu0: dev_pm_opp_get_opp_count:331
> > >     cpu cpu0: dev_pm_opp_get_opp_count:333: _find_opp_table() returned (ptrval)
> > >     cpu cpu0: dev_pm_opp_get_opp_count:342: _get_opp_count() returned 0
> > >     cpu cpu0: OPP table can't be empty
> > >
> > > Wait, _get_opp_count() returns 0?
> >
> > Does this fix it for you as well ?
> >
> > https://lore.kernel.org/lkml/2c73ab54717ef358b118ea0cfb727b1427e7730a.1602648719.git.viresh.kumar@linaro.org/
> 
> Thanks, it does. I had arrived at the same conclusion after bisection.
> 
> > I didn't point you to this earlier as your logs said something else.
> 
> All my logs said _get_opp_count() returns 0.
> 
> > > During s2ram, v5.10-rc1, it redoes most of the above, incl. touching the
> > > PMIC, which it shouldn't due in this phase of system resume:
> > >
> > >     Disabling non-boot CPUs ...
> > >     Enabling non-boot CPUs ...
> > >     cpufreq_dt: cpufreq_init:112: policy->cpu = 1
> > >     cpufreq_dt: cpufreq_init:113: policy->cpus = 1
> > >     cpufreq_dt: cpufreq_init:114: policy->related_cpus =
> > >     cpufreq_dt: cpufreq_init:115: policy->real_cpus =
> > >     of: dev_pm_opp_of_cpumask_add_table:1075
> > >     of: dev_pm_opp_of_cpumask_add_table:1080: cpu 0
> > >     cpu cpu0: dev_pm_opp_of_add_table:980
> > >     cpu cpu0: dev_pm_opp_of_add_table:982:
> > > dev_pm_opp_get_opp_table_indexed() returned f680980b
> > >     cpu cpu0: _of_add_opp_table_v1:914
> > >     cpu cpu0: _of_add_opp_table_v1:916: _find_opp_table() returned a4afd426
> > >     cpu cpu0: _of_add_opp_table_v1:937: 6 entries
> > >     i2c-sh_mobile e60b0000.i2c: Transfer request timed out
> > >
> > > The i2c controller is suspended, this could go boom...
> > >
> > >     i2c-sh_mobile e60b0000.i2c: Transfer request timed out
> > >     i2c-sh_mobile e60b0000.i2c: Transfer request timed out
> > >     i2c-sh_mobile e60b0000.i2c: Transfer request timed out
> > >     i2c-sh_mobile e60b0000.i2c: Transfer request timed out
> > >     i2c-sh_mobile e60b0000.i2c: Transfer request timed out
> > >     of: dev_pm_opp_of_cpumask_add_table:1080: cpu 1
> > >     cpu cpu1: dev_pm_opp_of_add_table:980
> > >     cpu cpu1: dev_pm_opp_of_add_table:982:
> > > dev_pm_opp_get_opp_table_indexed() returned f680980b
> > >     cpu cpu1: _of_add_opp_table_v1:914
> > >     cpu cpu1: _of_add_opp_table_v1:916: _find_opp_table() returned 9087c76d
> > >     cpu cpu1: _of_add_opp_table_v1:937: 6 entries
> > >     i2c-sh_mobile e60b0000.i2c: Transfer request timed out
> > >     i2c-sh_mobile e60b0000.i2c: Transfer request timed out
> > >     i2c-sh_mobile e60b0000.i2c: Transfer request timed out
> > >     i2c-sh_mobile e60b0000.i2c: Transfer request timed out
> > >     i2c-sh_mobile e60b0000.i2c: Transfer request timed out
> > >     i2c-sh_mobile e60b0000.i2c: Transfer request timed out
> > >     cpu cpu0: dev_pm_opp_get_opp_count:331
> > >     cpu cpu0: dev_pm_opp_get_opp_count:333: _find_opp_table() returned f680980b
> > >     cpu cpu0: dev_pm_opp_get_opp_count:342: _get_opp_count() returned 0
> > >     cpu cpu0: OPP table can't be empty
> > >     CPU1 is up
> >
> > Lets make the normal boot work first and see about this later.
> 
> This is also fixed by your patch: the PMIC is no longer accessed while
> suspended.

Ah finally. Thanks, everything worked as expected :)

-- 
viresh
