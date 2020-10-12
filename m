Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4989A28B573
	for <lists+linux-pm@lfdr.de>; Mon, 12 Oct 2020 15:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729297AbgJLNFI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Oct 2020 09:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729054AbgJLNFI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Oct 2020 09:05:08 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA31C0613D1
        for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2020 06:05:07 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id q5so17466127wmq.0
        for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2020 06:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XlL7umVsvWUu9nC85NmIJJazhDfhIvxS22WEywbwFsQ=;
        b=tmRYrzcgKlzAUQKgP5vXL9/uTTj7B/U9f0202gf3G2SLvMnx87gE1KviAzRDfa8QX/
         HCwSellky3Y8J5DozzR6KX7VZQOLBD/jORIAj8cGGdvCoZu92TJjNlQj3h8QnZYfX5Ln
         44oCi3Ixv0AJbVa7MF/B2Nz21Nf74thJ6GOz8VVyfQ+lbZfAXWPuja//CDmOjR2rqyh3
         AqXDj8eHPBmUhTIvnZJB6Qpf3vW5eTEBErBlGKdUUw4V+JwfxBrBInm1KjG5aEvGL22X
         CPKWlcctVUb9/sZU9oaNzezZKHlwcr36YeIBCZIf1BI7azSCqFVGZJ3SM5LAG7ZX2kte
         9EoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XlL7umVsvWUu9nC85NmIJJazhDfhIvxS22WEywbwFsQ=;
        b=V7IZ3ZDMPAPLkfVBv0yz4yl8E/nBMfPcr8tTxp4EW4wvNwLiLbig3Xfb5PsfytmHne
         0BVhromajinb5md+mW/x0SDqZYKpjYfbPMF+xpoemPPcp7Um2QJYitB8fdr6sHDih95n
         lQ+AG6q0F83AKxHbz5R47KlhTqkDMco0nw8Uj3t5dy5vQla8A4z8PV+vYJPWbJ7ps4aD
         ikPXV7H5uwRODwRsJ3ewOJskgv8akADXa589dH5E1n7DYYRRNtT0fmRg98IInsqfDe9L
         YG3iRZfRmbA+heBOwAWhpc8uxKPL48GvRwBlgiVo8zKUmoia9jZbnYR4ddo8bxYXnuUx
         /90w==
X-Gm-Message-State: AOAM530ZCHegpy7QjQJQEBqwxX91TWFlXVQbVAeUye2wpG/9UtmPjxpG
        1ijv1IxfvovxQz1ycD/ZIyfcag==
X-Google-Smtp-Source: ABdhPJxvJGKO6cr1CfvjsY4aqYWIxii9Fm+gSpkgy8mfxVH6cieqbEh1hQqbAuo5sPR/uY0zrz+PeA==
X-Received: by 2002:a1c:1b15:: with SMTP id b21mr11006430wmb.143.1602507905993;
        Mon, 12 Oct 2020 06:05:05 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:f693:9fff:fef4:a7ef])
        by smtp.gmail.com with ESMTPSA id 64sm4434430wmd.3.2020.10.12.06.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 06:05:05 -0700 (PDT)
Date:   Mon, 12 Oct 2020 14:05:01 +0100
From:   Quentin Perret <qperret@google.com>
To:     zhuguangqing83@gmail.com
Cc:     lukasz.luba@arm.com, quentin.perret@arm.com, rjw@rjwysocki.net,
        pavel@ucw.cz, len.brown@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        zhuguangqing <zhuguangqing@xiaomi.com>
Subject: Re: [PATCH] PM / EM: consult something about cpumask in
 em_dev_register_perf_domain
Message-ID: <20201012130501.GA3366383@google.com>
References: <20201012124136.4147-1-zhuguangqing83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012124136.4147-1-zhuguangqing83@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Monday 12 Oct 2020 at 20:41:36 (+0800), zhuguangqing83@gmail.com wrote:
> From: zhuguangqing <zhuguangqing@xiaomi.com>
> 
> Hi, Lukasz, Quentin
>   I have three questions to consult about cpumask in energy_model.c.

OK, let's see if we can help :)

> 1, The first one is about the meanings of the following two parameters,
> [1] and [2].
> [1]: "cpumask_t *cpus" in function em_dev_register_perf_domain(): Pointer
> to cpumask_t, which in case of a CPU device is obligatory. It can be taken
> from i.e. 'policy->cpus'.
> [2]: "unsigned long cpus[]" in struct em_perf_domain: Cpumask covering the
> CPUs of the domain. It's here for performance reasons to avoid potential
> cache misses during energy calculations in the scheduler and simplifies
> allocating/freeing that memory region.
> 
> From the current code, we see [2] is copied from [1]. But from comments,
> accorinding to my understanding, [2] and [1] have different meanings.
> [1] can be taken from i.e. 'policy->cpus', according to the comment in the
> defination of struct cpufreq_policy, it means Online CPUs only. Actually,
> 'policy->cpus' is not always Online CPUs.
> [2] means each_possible_cpus in the same domain, including phycical
> hotplug cpus(just possible), logically hotplug cpus(just present) and
> online cpus.
>
> 
> So, the first question is, what are the meanings of [1] and [2]?
> I guess maybe there are the following 4 possible choices.
> A), for_each_possible_cpu in the same domain, maybe phycical hotplug
> B), for_each_present_cpu in the same domain, maybe logically hotplug
> C), for_each_online_cpu in the same domain, online
> D), others

So, if the comments are confusing we should update them, but from the EM
framework perspective, all cpumasks must be the _possible_ CPUs in the
domain. It's up to the clients (e.g. the scheduler) to deal with hotplug
and so on, but the EM framework should cover non-online CPUs too.

> 2, The second question is about the function em_dev_register_perf_domain().
> If multiple clients register the same performance domain with different
> *dev or *cpus, how should we handle?
> 
> int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
> 			struct em_data_callback *cb, cpumask_t *cpus)
> 
> For example, say cpu0 and cpu1 are in the same performance domain,
> cpu0 is registered first. As part of the init process,
> em_dev_register_perf_domain() is called, then *dev = cpu0_dev,
> *cpus = 01b(cpu1 is initially offline). It creates a em_pd for cpu0_dev.
> After a while, cpu1 is online, em_dev_register_perf_domain() is called
> again as part of init process for cpu1, then *dev =cpu1_dev,
> *cpus = 11b(cpu1 is online).  In this case, for the current code,
> cpu1_dev can not get its em_pd.

As per the above, the registration should be done once, with the mask of
all possible CPUs in the domain. If CPUs 0 and 1 share the same domain, a
single call to em_dev_register_perf_domain() should be sufficient to
register both of them at once.

> 3, The third question is, how can we ensure cpu_dev as follows is not
> NULL? If we can't ensure that, maybe we should add a check before using
> it.
> /kernel/power/energy_model.c
> 174) static int em_create_pd(struct device *dev, int nr_states,
> 175)                    struct em_data_callback *cb, cpumask_t *cpus)
> 176) {
> 199)    if (_is_cpu_device(dev))
> 200)            for_each_cpu(cpu, cpus) {
> 201)                    cpu_dev = get_cpu_device(cpu);
> 202)                    cpu_dev->em_pd = pd;
> 203)            }

And that should not be necessary as we check for the !dev case at the
top of em_dev_register_perf_domain(). Or were you thinking about
something else?

Thanks,
Quentin
