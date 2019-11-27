Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFF1210AF64
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2019 13:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfK0MOG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Nov 2019 07:14:06 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39302 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfK0MOF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Nov 2019 07:14:05 -0500
Received: by mail-pf1-f194.google.com with SMTP id x28so10905119pfo.6
        for <linux-pm@vger.kernel.org>; Wed, 27 Nov 2019 04:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7BbLhqWTTG2Etn1jUokhvCpbFC9M+0mSaR7SHkjHB38=;
        b=MJV43KtfU5dh6w6aXoZKp8+WYygfis1sjvm07Kl9Wd2wNneinEn9vQZrPavzQrE2CW
         An4nyqIzxlGj2Uo04rQvD5QQ8E2bKZvL3K7REcobBBGj+ZIeP45pAwN51u05YbYjMYpI
         k0cJPlotmo9gi6yJxu6kZX7dwVfqaZoZ0xos/iPV1VMqs84HRBSw0mfakGzaZU7YJjT7
         /enzk9H6qXC02B3XolxZ9hyB0j/3AKfz03WOdPpltou7SEkO3bdeCatGXYnCp3Nml1f+
         Px8qwJrGFvmCqWMZvTF+k1Vcxj8wZf+r6TJgOp3FB3DagUvJWrOycjBoRDKl7DkFqDGF
         PtXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7BbLhqWTTG2Etn1jUokhvCpbFC9M+0mSaR7SHkjHB38=;
        b=psIa6S0yDBECs2LSryOvAfFRDJ+FxZsUbR+XH/S3fNQGU7RFwxmqVyaovxEreOEZCD
         EfsSX7b+CBC9To1SxeL27+A1XiWIXQUPIv3l+zTqStoAS4DNn/9r4gzQvkNuqZoLouQh
         6e0LkacR26O2OfFocmF85y0jGmx5WZAZtptO/b7u/eQIQLZlNfDOzByiXh2hNhMzr7X5
         MzE1fXNr+2cMFXnB+MdSz8uHJ/ArOeKR0sY5WfbFvOxjRddQf0p1lPlRrfob+7tQ+o1P
         NlNIvwVV1wSekf2eT8xB16L9UmG6GOHbWWJHUtXVNjVTBa/QCepRHCEBgGirBkAYpwO0
         qIhw==
X-Gm-Message-State: APjAAAWHTU9jYEfK1q5IVt3ERSIQ1bRbhhszccBqqO9xenYeNipdOdtP
        M3+jBUrpn95IJL8ygaUzmFlcpQ==
X-Google-Smtp-Source: APXvYqwzOguWLwbfuOMSUTEFzH0IEWbfLeEU8s4GwdBdvUFeC/cQe/AC6XVbhE9JsWqq2Fvg6hcDAw==
X-Received: by 2002:a62:2a4c:: with SMTP id q73mr46113496pfq.94.1574856844848;
        Wed, 27 Nov 2019 04:14:04 -0800 (PST)
Received: from localhost ([122.171.112.123])
        by smtp.gmail.com with ESMTPSA id z10sm16126812pgg.39.2019.11.27.04.14.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Nov 2019 04:14:04 -0800 (PST)
Date:   Wed, 27 Nov 2019 17:44:02 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: vexpress-spc: Fix wrong alternation of
 policy->related_cpus during CPU hp
Message-ID: <20191127121402.vd3tul4gmqm6qtyb@vireshk-i7>
References: <20191127114801.23837-1-dietmar.eggemann@arm.com>
 <20191127120816.GC29301@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191127120816.GC29301@bogus>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 27-11-19, 12:08, Sudeep Holla wrote:
> On Wed, Nov 27, 2019 at 12:48:01PM +0100, Dietmar Eggemann wrote:
> > Since commit ca74b316df96 ("arm: Use common cpu_topology structure and
> > functions.") the core cpumask has to be modified during cpu hotplug
> > operations.
> >
> > ("arm: Fix topology setup in case of CPU hotplug for CONFIG_SCHED_MC")
> > [1] fixed that but revealed another issue on TC2, i.e in its cpufreq
> > driver.
> >
> > During CPU hp stress operations on multiple CPUs, policy->related_cpus
> > can be altered. This is wrong since this cpumask should contain the
> > online and offline CPUs.
> >
> > The WARN_ON(!cpumask_test_cpu(cpu, policy->related_cpus)) in
> > cpufreq_online() triggers in this case.
> >
> > The core cpumask can't be used to set the policy->cpus in
> > ve_spc_cpufreq_init() anymore in case it is called via
> > cpuhp_cpufreq_online()->cpufreq_online()->cpufreq_driver->init().
> >
> > An empty online() callback can be used to avoid that the init()
> > driver function is called during CPU hotplug in so that
> > policy->related_cpus will not be changed.
> >
> 
> Unlike DT based drivers, it not easy to get the fixed cpumask unless we
> add some mechanism to extract it based on clks/OPP added. I prefer
> this simple solution instead.

I will call this a work-around for the problem and not really the
solution, though I won't necessarily oppose it. There are cases which
will break even with this solution.

- Boot board with cpufreq driver as module.
- Offline all CPUs except CPU0.
- insert cpufreq driver.
- online all CPUs.

Now there is no guarantee that the last online will get the mask
properly, if I have understood the problem well :)

But yeah, who does this kind of messy work anyway :)

FWIW, we need a proper way (may be from architecture code) to find
list of all CPUs that share clock line.

-- 
viresh
