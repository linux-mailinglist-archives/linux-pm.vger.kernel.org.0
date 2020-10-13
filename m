Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 178A828C79D
	for <lists+linux-pm@lfdr.de>; Tue, 13 Oct 2020 05:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729111AbgJMDkh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Oct 2020 23:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727831AbgJMDkh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Oct 2020 23:40:37 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9EBC0613D0;
        Mon, 12 Oct 2020 20:40:37 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id y1so6395197plp.6;
        Mon, 12 Oct 2020 20:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding:content-language:thread-index;
        bh=9MhRZAedylu9vwMnX0stOllS6CiVUi1ZAX06b3mgjU0=;
        b=F0jZw9SpGT2EhMWVHtFSakopuC2SqUZ72YTe25dNAGoxdGiAuYzd1D9uara/95KWfW
         3sD5nhPt8lgSpgRA8suyFGc6ZDtQAQszXavREC0nkoFuyhlDrsdWSUhgys5OI71jCV46
         t7MAlBWPNJzW9lmx22xH4EbtrnUpu/hjzFSxDFuzk4+gukZXnHvkEZB7Oqg7x+Ojw+yc
         r3gEO6lKv+rL2QP2N1vl7xGCHhxbzT2y74ykbEPjHBVeXsx7lYI73w/mjhQUsUnaaVve
         6Jl/ej+p2xiFxp5RRyYFudTxDcLyRq2++GrUZgVNkMY11kANvvNXymVjvhbT5dPpKehw
         /haA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding:content-language:thread-index;
        bh=9MhRZAedylu9vwMnX0stOllS6CiVUi1ZAX06b3mgjU0=;
        b=bvxZlxOXNRlMRWQQNH7ubBp43YjPpq7w7lAoS4rus4vlPxQrxdn6I/w2E93R7NtFNy
         XAD5RrWOxkKwQGlWIVWwcLx09NwF+TH1srQ46IWow7wL115bJztcUQAcqvjI9t/+MsrQ
         249hgq6vs72I5SQZFKSlOrcDW6EB7uLr47yx/id1KZlfXXlVwCbsPexjek597ut0Fviy
         C4jDfMPyYE9Am0V2Gpm7sbM9iWQ/n6or70Mj75iJE6AaM9nlyAkEOZrYN1IT5a39veYG
         tjjxthorDPClb1NyZXuaTddqc1TGwB3qQN5xQGJm+syZXUegxGnfb+22xXg3RptcaVk8
         K1Lw==
X-Gm-Message-State: AOAM530f45I7InblwP1DmV7HwypYIs12xqTBW8znNlCfdl9ypiULcZXb
        a9gvbbRFfjS4DTN+RM0cKH0nFJVtSknJVA==
X-Google-Smtp-Source: ABdhPJxhU4GJbmrzclA3y4LRr8OHSN7xnaSxJ5W1PHPbhZTjoGs5ITALY3vw15SkVzpDe48fFKtuCA==
X-Received: by 2002:a17:902:9890:b029:d2:2f2a:584e with SMTP id s16-20020a1709029890b02900d22f2a584emr26848676plp.29.1602560437040;
        Mon, 12 Oct 2020 20:40:37 -0700 (PDT)
Received: from DESKTOPIUKEMQD ([209.9.72.212])
        by smtp.gmail.com with ESMTPSA id g13sm20464911pgd.82.2020.10.12.20.40.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Oct 2020 20:40:36 -0700 (PDT)
From:   "zhuguangqing83" <zhuguangqing83@gmail.com>
To:     "'Quentin Perret'" <qperret@google.com>
Cc:     <lukasz.luba@arm.com>, <rjw@rjwysocki.net>, <pavel@ucw.cz>,
        <len.brown@intel.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "'zhuguangqing'" <zhuguangqing@xiaomi.com>
Subject: Re: [PATCH] PM / EM: consult something about cpumask in em_dev_register_perf_domain
Date:   Tue, 13 Oct 2020 11:40:31 +0800
Message-ID: <098a01d6a112$9cd7f410$d687dc30$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AdahAmo3046yVeRlQAq1r9STFu9v+A==
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


> 
> Hi,
> 
> On Monday 12 Oct 2020 at 20:41:36 (+0800), zhuguangqing83@gmail.com wrote:
> > From: zhuguangqing <zhuguangqing@xiaomi.com>
> >
> > Hi, Lukasz, Quentin
> >   I have three questions to consult about cpumask in energy_model.c.
> 
> OK, let's see if we can help :)
> 

Thanks for your help and review.

> > 1, The first one is about the meanings of the following two parameters,
> > [1] and [2].
> > [1]: "cpumask_t *cpus" in function em_dev_register_perf_domain():
Pointer
> > to cpumask_t, which in case of a CPU device is obligatory. It can be
taken
> > from i.e. 'policy->cpus'.
> > [2]: "unsigned long cpus[]" in struct em_perf_domain: Cpumask covering
the
> > CPUs of the domain. It's here for performance reasons to avoid potential
> > cache misses during energy calculations in the scheduler and simplifies
> > allocating/freeing that memory region.
> >
> > From the current code, we see [2] is copied from [1]. But from comments,
> > accorinding to my understanding, [2] and [1] have different meanings.
> > [1] can be taken from i.e. 'policy->cpus', according to the comment in
the
> > defination of struct cpufreq_policy, it means Online CPUs only.
Actually,
> > 'policy->cpus' is not always Online CPUs.
> > [2] means each_possible_cpus in the same domain, including phycical
> > hotplug cpus(just possible), logically hotplug cpus(just present) and
> > online cpus.
> >
> >
> > So, the first question is, what are the meanings of [1] and [2]?
> > I guess maybe there are the following 4 possible choices.
> > A), for_each_possible_cpu in the same domain, maybe phycical hotplug
> > B), for_each_present_cpu in the same domain, maybe logically hotplug
> > C), for_each_online_cpu in the same domain, online
> > D), others
> 
> So, if the comments are confusing we should update them, but from the EM
> framework perspective, all cpumasks must be the _possible_ CPUs in the
> domain. It's up to the clients (e.g. the scheduler) to deal with hotplug
> and so on, but the EM framework should cover non-online CPUs too.
> 

I see, from the EM framework perspective, all cpumasks must be the
_possible_ CPUs in the domain. But up to the clients (e.g. the scheduler),
'policy->cpus' maybe not the _possible_ CPUs. For example, in the function
scmi_cpufreq_init() which calls em_dev_register_perf_domain(),
'policy->cpus'
is got from scmi_get_sharing_cpus() and cpufreq_online(), including CPUs
satisfied the following three conditions at the same time which means
_present_ CPUs according to my understanding.
1) _possible_
2) if (get_cpu_device(cpu))
3) in the same domain

> > 2, The second question is about the function
em_dev_register_perf_domain().
> > If multiple clients register the same performance domain with different
> > *dev or *cpus, how should we handle?
> >
> > int em_dev_register_perf_domain(struct device *dev, unsigned int
nr_states,
> > 			struct em_data_callback *cb, cpumask_t *cpus)
> >
> > For example, say cpu0 and cpu1 are in the same performance domain,
> > cpu0 is registered first. As part of the init process,
> > em_dev_register_perf_domain() is called, then *dev = cpu0_dev,
> > *cpus = 01b(cpu1 is initially offline). It creates a em_pd for cpu0_dev.
> > After a while, cpu1 is online, em_dev_register_perf_domain() is called
> > again as part of init process for cpu1, then *dev =cpu1_dev,
> > *cpus = 11b(cpu1 is online).  In this case, for the current code,
> > cpu1_dev can not get its em_pd.
> 
> As per the above, the registration should be done once, with the mask of
> all possible CPUs in the domain. If CPUs 0 and 1 share the same domain, a
> single call to em_dev_register_perf_domain() should be sufficient to
> register both of them at once.
> 

I just saw your discussion in https://lkml.org/lkml/2020/2/7/479, it
mentioned
"PM_EM ignores hotplug ATM. Perhaps we should document that somewhere ..."

So, if PM_EM still ignores hotplug now, then the registration should be done
once,
with the mask of all possible CPUs in the domain. If PM_EM consider hotplug
in
the future, then we should consider the case that
em_dev_register_perf_domain()
will be called more than once with different input parameters *dev or/and
*cpus.
And the CPU mask might not be all possible CPUs in the domain.

> > 3, The third question is, how can we ensure cpu_dev as follows is not
> > NULL? If we can't ensure that, maybe we should add a check before using
> > it.
> > /kernel/power/energy_model.c
> > 174) static int em_create_pd(struct device *dev, int nr_states,
> > 175)                    struct em_data_callback *cb, cpumask_t *cpus)
> > 176) {
> > 199)    if (_is_cpu_device(dev))
> > 200)            for_each_cpu(cpu, cpus) {
> > 201)                    cpu_dev = get_cpu_device(cpu);
> > 202)                    cpu_dev->em_pd = pd;
> > 203)            }
> 
> And that should not be necessary as we check for the !dev case at the
> top of em_dev_register_perf_domain(). Or were you thinking about
> something else?
> 
> Oh I think I read that one wrong, but the conclusion should be the same,
> at least on Arm64 -- all _possible_ CPUs should be registered early
> enough for that not to be an issue.
>
>Did you observe anything wrong there for your use-case?
> 

I did not observe anything wrong for my use-case. But I think it's possible
in
theory that cpu_dev maybe NULL. I observe that in the function
scmi_cpufreq_init(), before calling em_dev_register_perf_domain(),
'policy->cpus' can be ensure that all the cpu_dev in CPU mask are not NULL.
But maybe we can not ensure all the clients do the check.  This could happen
if the arch did not set up cpu_dev since this CPU is not in cpu_present mask
and the driver did not send a correct CPU mask during registration.

> Thanks,
> Quentin

