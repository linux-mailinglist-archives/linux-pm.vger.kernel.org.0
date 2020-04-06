Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 770E019EF63
	for <lists+linux-pm@lfdr.de>; Mon,  6 Apr 2020 04:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgDFCzy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 5 Apr 2020 22:55:54 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:40861 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbgDFCzx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 5 Apr 2020 22:55:53 -0400
Received: by mail-pj1-f67.google.com with SMTP id kx8so5828913pjb.5
        for <linux-pm@vger.kernel.org>; Sun, 05 Apr 2020 19:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tRSResKY5MQWGvJUDvh5Jnjxm56SAjdebaRotPHHpCg=;
        b=lZWRyNYnQi//4szFgMc008z18IP5tNRpMgc3HuT+c7pmDFFNX94iv3ueDXig87aFXA
         iUALmrl5yIrORMFaCXwnrl29XRBJ2QjoDVCZxckyS1cX4eEg0uoi60ZKoBVFWHjtZgWC
         MURluOkeZZi7s8BFaY8v7lZbJryDClJzpArMwFIsZUHaiviLfF60sisB952HgQRi6vo/
         OneRPtwbIbAJZOAwDrKxOG0OeUrqiJjmqBId1wAwWqwwVxwLoLkkUsgleTzNqBVcDESK
         EEsvOeeP4+AtFzxeKYxmBcAWlenmoFRGuOVFPe3iUGtwxci9v3VRLTbC9VQ68nVcZ37a
         jjhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tRSResKY5MQWGvJUDvh5Jnjxm56SAjdebaRotPHHpCg=;
        b=JpqGfAXN6x692X0SSLeGlGHiG2qt4yL7g/E4zC5b9iaCeyIzIU32V4NUF6AzHZGi63
         Q04diBYceZpjZ/QdLS0SObsI4UVdfW537ct7yemaNiWT1Asnoj/6hhtYZqfU2aCwQbsV
         R5TXX0MrHK/A206wNK5NOHil3KQgzG1o3HTS5DWmJD/n8fdKBa4H7WTsYy50iQKxFhpz
         xO6qaGRrtjsO75JlYEnaMFTAucBRrk25SPCPzM+7K+ibvEQ+LE00OVWvkcgSZkobv23M
         jpX48G6hjVXXQiCjNkaJZcqXM40uLfKd5HTSL9WhaGhKczyUpio0gUTxs/i47FX5DhO6
         0ETg==
X-Gm-Message-State: AGi0PuZrCpGzZiXiycyXj5PUj99obHsyXoUhupSu6qOnLvZfVpCT6UEI
        RgUdbYJ93NgXBa5YudelAd8iMvR8j5U=
X-Google-Smtp-Source: APiQypKMsRmy3TwpbSKrGtn3ztUTrpFALfP24RtI9OcbG/4dhlsbPmzjN1B9TXyH4L743RxjaNTVrA==
X-Received: by 2002:a17:90a:2663:: with SMTP id l90mr21796440pje.188.1586141752009;
        Sun, 05 Apr 2020 19:55:52 -0700 (PDT)
Received: from localhost ([122.171.118.46])
        by smtp.gmail.com with ESMTPSA id f200sm10503930pfa.177.2020.04.05.19.55.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Apr 2020 19:55:51 -0700 (PDT)
Date:   Mon, 6 Apr 2020 08:25:49 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     sumitg <sumitg@nvidia.com>
Cc:     rjw@rjwysocki.net, catalin.marinas@arm.com, will@kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com, talho@nvidia.com,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bbasu@nvidia.com, mperttunen@nvidia.com
Subject: Re: [TEGRA194_CPUFREQ Patch 2/3] cpufreq: Add Tegra194 cpufreq driver
Message-ID: <20200406025549.qfwzlk3745y3r274@vireshk-i7>
References: <1575394348-17649-1-git-send-email-sumitg@nvidia.com>
 <1575394348-17649-2-git-send-email-sumitg@nvidia.com>
 <20200326115023.xy3n5bl7uetuw7mx@vireshk-i7>
 <d233b26b-6b50-7d41-9f33-a5dc151e0e7d@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d233b26b-6b50-7d41-9f33-a5dc151e0e7d@nvidia.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 05-04-20, 00:08, sumitg wrote:
> 
> 
> On 26/03/20 5:20 PM, Viresh Kumar wrote:
> > On 03-12-19, 23:02, Sumit Gupta wrote:
> > > diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
> > > +enum cluster {
> > > +     CLUSTER0,
> > > +     CLUSTER1,
> > > +     CLUSTER2,
> > > +     CLUSTER3,
> > 
> > All these have same CPUs ? Or big little kind of stuff ? How come they
> > have different frequency tables ?
> > 
> T194 SOC has homogeneous architecture where each cluster has two symmetric
> Carmel cores and and not big little. LUT's are per cluster and all LUT's
> have same values currently. Future SOC's may have different LUT values per
> cluster.

LUT ?

> > > +     MAX_CLUSTERS,
> > > +};

> > > +static unsigned int tegra194_get_speed_common(u32 cpu, u32 delay)
> > > +{
> > > +     struct read_counters_work read_counters_work;
> > > +     struct tegra_cpu_ctr c;
> > > +     u32 delta_refcnt;
> > > +     u32 delta_ccnt;
> > > +     u32 rate_mhz;
> > > +
> > > +     read_counters_work.c.cpu = cpu;
> > > +     read_counters_work.c.delay = delay;
> > > +     INIT_WORK_ONSTACK(&read_counters_work.work, tegra_read_counters);
> > > +     queue_work_on(cpu, read_counters_wq, &read_counters_work.work);
> > > +     flush_work(&read_counters_work.work);
> > 
> > Why can't this be done in current context ?
> > 
> We used work queue instead of smp_call_function_single() to have long delay.

Please explain completely, you have raised more questions than you
answered :)

Why do you want to have long delays ?

> > > +static int tegra194_cpufreq_init(struct cpufreq_policy *policy)
> > > +{
> > > +     struct tegra194_cpufreq_data *data = cpufreq_get_driver_data();
> > > +     int cluster = get_cpu_cluster(policy->cpu);
> > > +
> > > +     if (cluster >= data->num_clusters)
> > > +             return -EINVAL;
> > > +
> > > +     policy->cur = tegra194_fast_get_speed(policy->cpu); /* boot freq */
> > > +
> > > +     /* set same policy for all cpus */
> > > +     cpumask_copy(policy->cpus, cpu_possible_mask);
> > 
> > You are copying cpu_possible_mask mask here, and so this routine will
> > get called only once.
> > 
> > I still don't understand the logic behind clusters and frequency
> > tables.
> > 
> Currently, we use same policy for all CPU's to maximize throughput. Will add
> separate patch later to set policy as per cluster. But we are not using that
> in T194 due to perf reasons.

You can't misrepresent the hardware this way, sorry.

Again few questions, I understand that you have multiple clusters
here:

- All clusters will always have the frequency table ?
- All clusters are capable of having a different frequency at any
  point of time ? Or they will always run at same freq ?

> > > +     freqs.old = policy->cur;
> > > +     freqs.new = tbl->frequency;
> > > +
> > > +     cpufreq_freq_transition_begin(policy, &freqs);
> > > +     on_each_cpu_mask(policy->cpus, set_cpu_ndiv, tbl, true);
> > 
> > When CPUs share clock line, why is this required for every CPU ?
> > Per core NVFREQ_REQ system register is written to make frequency
> requests for the core. Cluster h/w then forwards the max(core0, core1)
> request to cluster NAFLL.

You mean that each cluster can set frequency independently ?

If all the clusters can run at independent frequencies but you still
want them to run at same frequency, then that can be done with a
single set of governor tunables, which is the default anyway. So this
should just work for you.

I will not be reviewing the v2 version you sent for now as that is
most likely wrong anyway.

-- 
viresh
