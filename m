Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9A33A995D
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jun 2021 13:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbhFPLiO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Jun 2021 07:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbhFPLiO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Jun 2021 07:38:14 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D089C061760
        for <linux-pm@vger.kernel.org>; Wed, 16 Jun 2021 04:36:07 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id l184so1713002pgd.8
        for <linux-pm@vger.kernel.org>; Wed, 16 Jun 2021 04:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AFNw9Rg5VPuxN2wHcOG+M82kB/OTV/RwGWRWsiLI7hk=;
        b=uJxJhSA45GbGjc4mU6EQzm+JA1rv1Nf/rYnXrafAWklsYnUpciRXuUXb3LNLk/GSsG
         uhcgjKTOEq2Y/o467Kwmp+8lwt3HQpn4hR1rMPUeeFKhjBkKFNcp4aK6Cj9XWf9UY82B
         ii4wKCe3L00EZ5VW94NzrJpfp/ux0/q3LedvvpojQDxHWZDElEgaW0FasGQR0AB1QEV/
         irBcUKKYS6YDTB6zw+hqnexDyErM7FDRTFd45cVWS7vySYhD5HVodguvEGsJIsbM3T7F
         SjIm3+k+ElXfcKNtVutd6/2gBV9dB+5EfytNbPUl5PC23kpZM2UakgTHKzdc8JIlQllz
         jL6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AFNw9Rg5VPuxN2wHcOG+M82kB/OTV/RwGWRWsiLI7hk=;
        b=CVlnmirQzUdQzNn19KCmgiZJeN45EwXWbBdpKesOdt5zHUg+C0hDQKfM56x/ea7EO+
         9u+MMrMMYiBIQfrs45Ufh/9+GyDY4+9a2dhLWayiQkrznhrmzO3immFAZUj+Zd+dXn30
         4cFqatnD8g92UF4uNtNW6VviqGnamRp+XCRlyLoW3UiLIcHgHp8RaohCrEuHhzqo9kK8
         YO5aV5wZOeRgupBEeMX+CLT/1KRXrrlBXGaRiCRzTqIUB5zH2RGLqFmaKNO2BzT8h4sI
         RozJg+Xwz0LJroWxktzc0OkvaYAJ5gDSbBXdrRGaVcNPy8Fll6GwQd4fxPwlGN/TH43S
         SUdQ==
X-Gm-Message-State: AOAM533GmSWGKxv1px6bryzS7F4FXDRPBDMBCA9qnQuEUQIejA4YNljn
        WFZ6it+20UqB3r76ro5JXlNGUg==
X-Google-Smtp-Source: ABdhPJyDgJWFryQu8qjgEB1asImm2xBrDDYrNFz42uSKH0nhqf5exetwlPR/FE3tfHi5sWyvtBnLAA==
X-Received: by 2002:a63:e453:: with SMTP id i19mr4668054pgk.134.1623843366888;
        Wed, 16 Jun 2021 04:36:06 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id i125sm2026393pfc.7.2021.06.16.04.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 04:36:06 -0700 (PDT)
Date:   Wed, 16 Jun 2021 17:06:04 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Qian Cai <quic_qiancai@quicinc.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 2/3] arch_topology: Avoid use-after-free for
 scale_freq_data
Message-ID: <20210616113604.e4kc3jxb7ayqskev@vireshk-i7>
References: <cover.1623825725.git.viresh.kumar@linaro.org>
 <9dba462b4d09a1a8a9fbb75740b74bf91a09a3e1.1623825725.git.viresh.kumar@linaro.org>
 <20210616112544.GA23657@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210616112544.GA23657@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Ionela,

On 16-06-21, 12:25, Ionela Voinescu wrote:
> Please correct me if I'm wrong, but my understanding is that this is
> only a problem for the cppc cpufreq invariance functionality. Let's
> consider a scenario where CPUs are either hotplugged out or the cpufreq
> CPPC driver module is removed; topology_clear_scale_freq_source() would
> get called and the sfd_data will be set to NULL. But if at the same
> time topology_scale_freq_tick() got an old reference of sfd_data,
> set_freq_scale() will be called. This is only a problem for CPPC cpufreq
> as cppc_scale_freq_tick() will end up using driver internal data that
> might have been freed during the hotplug callbacks or the exit path.

For now, yes, CPPC is the only one affected.

> If this is the case, wouldn't the synchronisation issue be better
> resolved in the CPPC cpufreq driver, rather than here?

Hmm, the way I see it is that topology_clear_scale_freq_source() is an API
provided by topology core and the topology core needs to guarantee that it
doesn't use the data any longer after topology_clear_scale_freq_source() is
called.

The same is true for other APIs, like:

irq_work_sync();
kthread_cancel_work_sync();

It isn't the user which needs to take this into account, but the API provider.

There may be more users of this in the future, lets say another cpufreq driver,
and so keeping this synchronization at the API provider is the right thing to do
IMHO.

And from the user's perspective, like cppc, it doesn't have any control over who
is using its callback and how and when. It is very very difficult to provide
something like this at the users, redundant anyway. For example cppc won't ever
know when topology_scale_freq_tick() has stopped calling its callback.

For example this is what cppc driver needs to do now:

+static void cppc_cpufreq_stop_cpu(struct cpufreq_policy *policy,
+                                 unsigned int cpu)
+{
+       struct cppc_freq_invariance *cppc_fi = &per_cpu(cppc_freq_inv, cpu);
+
+       topology_clear_scale_freq_source(SCALE_FREQ_SOURCE_CPPC, cpumask_of(cpu));
+       irq_work_sync(&cppc_fi->irq_work);
+       kthread_cancel_work_sync(&cppc_fi->work);
+}

The driver uses APIs provided by 3 layers, topology, irq-work, kthread and all
must provide these guarantees.

A very similar thing is implemented in kernel/sched/cpufreq.c for example.

-- 
viresh
