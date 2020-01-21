Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3DDA143A84
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2020 11:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbgAUKJB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Jan 2020 05:09:01 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39934 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728512AbgAUKJA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jan 2020 05:09:00 -0500
Received: by mail-wr1-f66.google.com with SMTP id y11so2458048wrt.6
        for <linux-pm@vger.kernel.org>; Tue, 21 Jan 2020 02:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8os47Jh+iH/mWhGJOKaN0Ikowvgw7Dsg6piAesimf+8=;
        b=iNHLk9Soh1BgMmomizmi4fIcor2oN/NsBEzYcXn39v8n4anlIoYM5pz+LSafgd8Spu
         f+S7jCQINFEBJ4GDG4xVgihL44c++E/0Tg7Shs1Ps4QiMQ+Do8ke4XZtb91mtCCPSb17
         8jgPfcy7ylRBXPBUjDLzy7qpdgFjobOdmL+AyehNXUbus45Wmkzcz9npQK6FoRh2lfld
         RgloPfjLJuxfGsc3KMrRsmMDzHu36mcWyIeIyYDOEtja0RuhZt+1QHUg64Sy4nQtummn
         SwblUn6R1sIWp1O85xu9BZGrKNkVu0yj2lUWmC2wFXq9newsw22roQLk7hwpoD5DrjFT
         RJtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8os47Jh+iH/mWhGJOKaN0Ikowvgw7Dsg6piAesimf+8=;
        b=DxnDDQ4CCObJ1boFbkN2mdaKJgXe1qEEBotEkRjpyRC4ImBKI2TIBNi0UhqJ2qwvhM
         WLTeVP81JQ8lDrGo603+ULmkTfgnXesvYeHN9zqXOVjkw6f5JPAe6meQir7bTrAJeTl5
         GOvvayPLMHrmdT5oknLzqBLIvK29bEjTBhhf2jcuHcO84YC4IUdfp4BQlgz1B3MHFr4k
         2NGWOJGjVgm5YOLGi8oXd3nzWn/At4UU6d81vSR6JXg0YZD8C5+HwRopUMd3V4kP5U6O
         A1pzjaUVZkg+flk5GueZfo0SMs+z7gJPfCQpJ5cYLa+icdPwdb2LfGUw90dFUbBzzJtj
         bexQ==
X-Gm-Message-State: APjAAAWOJY4714XWvCHEIyWLAPaHsCwCRQg0+x6qbs6XF8VH7YeMwV7r
        sM4i9sTSyA24nAXMMQWhCYlU4Q==
X-Google-Smtp-Source: APXvYqzMOzjFtDVGl6edwO/7tSb9RrQo9+Hb9CFGAJn1i1sGI47f1x+xTj047nTS+b5NOSYS7F4xnw==
X-Received: by 2002:adf:fcc4:: with SMTP id f4mr4493720wrs.247.1579601338751;
        Tue, 21 Jan 2020 02:08:58 -0800 (PST)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id u18sm51454016wrt.26.2020.01.21.02.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 02:08:58 -0800 (PST)
Date:   Tue, 21 Jan 2020 10:08:54 +0000
From:   Quentin Perret <qperret@google.com>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-imx@nxp.com, Morten.Rasmussen@arm.com, Chris.Redpath@arm.com,
        ionela.voinescu@arm.com, javi.merino@arm.com,
        cw00.choi@samsung.com, b.zolnierkie@samsung.com, rjw@rjwysocki.net,
        sudeep.holla@arm.com, viresh.kumar@linaro.org, nm@ti.com,
        sboyd@kernel.org, rui.zhang@intel.com, amit.kucheria@verdurent.com,
        daniel.lezcano@linaro.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        kernel@pengutronix.de, khilman@kernel.org, agross@kernel.org,
        bjorn.andersson@linaro.org, robh@kernel.org,
        matthias.bgg@gmail.com, steven.price@arm.com,
        tomeu.vizoso@collabora.com, alyssa.rosenzweig@collabora.com,
        airlied@linux.ie, daniel@ffwll.ch, patrick.bellasi@matbug.net
Subject: Re: [PATCH 1/4] PM / EM: and devices to Energy Model
Message-ID: <20200121100854.GB157387@google.com>
References: <20200116152032.11301-1-lukasz.luba@arm.com>
 <20200116152032.11301-2-lukasz.luba@arm.com>
 <17b77e0c-9455-0479-d37b-c57717c784c7@arm.com>
 <20200120152804.GB164543@google.com>
 <453034e5-f7b9-20f7-4e26-5d0d7164edd1@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <453034e5-f7b9-20f7-4e26-5d0d7164edd1@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Monday 20 Jan 2020 at 16:20:49 (+0000), Lukasz Luba wrote:
> On 1/20/20 3:28 PM, Quentin Perret wrote:
> > Agreed, this looks a bit confusing. It should be trivial to make
> > em_dev_get() (or whatever we end up calling it) work for CPUs too,
> > though. And we could always have a em_cpu_get(int cpu) API that is a
> > basically a wrapper around em_dev_get() for convenience.
> 
> The problem not only here is that we have a CPU index 'int cpu'
> and if we ask for device like:
> 
> struct device *dev = get_cpu_device(cpu);
> 
> It might be not the same device that was used during the
> registration, when we had i.e. 4 CPUs for the same policy:
>
> int cpu_id = cpumask_first(policy->cpus);
> struct device *cpu_dev = get_cpu_device(cpu_id);
> em_register_perf_domain(cpu_dev, nr_opp, &em_cb);
> 
> That's why the em_cpu_get() is different than em_get_pd(), mainly by:
> if (cpumask_test_cpu(cpu, em_span_cpus(em_pd)))
> 
> It won't be simple wrapper, let me think how it could be handled
> differently than it is now.

Right so I suppose the easiest solution would be to do the opposite of
my first suggestion. That is, make em_get_pd() call em_cpu_get() if the
device is a CPU device, or proceed to the PD list iteration for other
devices. And em_cpu_get() can remain as you originally suggested (that
is, iterate over the PDs and test the mask).

That should ensure em_get_pd() always works, em_cpu_get() is still there
handy for the scheduler and such, and the two EM lookup functions (for
CPUs or for devices) are kept cleanly separated.

Thoughts ?

Thanks,
Quentin
