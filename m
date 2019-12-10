Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C05111859C
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2019 11:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfLJKyy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Dec 2019 05:54:54 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37982 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbfLJKyy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Dec 2019 05:54:54 -0500
Received: by mail-pg1-f195.google.com with SMTP id a33so8510731pgm.5
        for <linux-pm@vger.kernel.org>; Tue, 10 Dec 2019 02:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6wZ16IH1A9NyRD5fnDKH63peTgh6qtt54eLX5G96R5U=;
        b=ofsrWUgVw5ZqhHjNXxeX/tvbL+zyIccsUNDeGyG7DEzMsIJ+l+a0N5JIEBbP2+grXF
         DErG5nCx4vFVMEwyDiiWs+7mJ5rpruqcGFjhb1BW1m74UI6RYyO7Nk3zC9OBxm6+Ikiv
         Y28ltLYeFCvYXor5V7QUAMEYxlkf6ojtmfwQTqDc14Lu8P5YzrVy/uSGfuJSAS5M4Fbg
         lqo/5JOSGMC4mg4yIY8ahfIlGS3DcJav1dU9P88+XhefLyucsl4LI+KLuqlDXCfK5Ztt
         EJEvoR1WyDJdUP1Uw9GRN1wEO601vJbVv/KwbKmQod05sW99uRlugPTQG+OFHmovcurX
         d7Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6wZ16IH1A9NyRD5fnDKH63peTgh6qtt54eLX5G96R5U=;
        b=qVCryOhD+ilsGSrQ5m3oIvVLD246F0xQ9VIhr2rFvrEOEULskZWmnckNXyOknvcMuv
         KqF/8b68LTMVUTm5v2v+QO7bXw35ld/GKeeJoeNNlUUrCnD5EHp+XSNvU1yKfYP3XF2v
         Yymwy+hgc//w55fff4juvP7znA1v0uCqglLiRFwu3j++QgTfGYl/9tG2OfNtD06HO5DZ
         ubXiyBMC5upefTFedYpr25NxAJmYYMErqAFhagmJOiz1L/B/HMhVgkyCRnWrmm7mQ9Ft
         Ssa9/CSIm27JC+wfZViGZk3HA9xvxfsr0fF2VxNZ7sVl/a7Np4tsw4/plbkRvzxblY2+
         rs6Q==
X-Gm-Message-State: APjAAAWG8CPi9kCiEwpNCOBlNv9IthApcczznUJam7yzY04sZUwQlqiC
        6ZHq544q18B4/CE0JV3gkUWCPg==
X-Google-Smtp-Source: APXvYqwDPmLd8XKcxBHAmmtiid01/5TmRf7UFcayg4G8R//Y3Y3HBdA4kCcTCsqbbKayfEjH29a93Q==
X-Received: by 2002:a63:334f:: with SMTP id z76mr23475918pgz.277.1575975293811;
        Tue, 10 Dec 2019 02:54:53 -0800 (PST)
Received: from localhost ([122.171.112.123])
        by smtp.gmail.com with ESMTPSA id j10sm2643814pjb.14.2019.12.10.02.54.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Dec 2019 02:54:52 -0800 (PST)
Date:   Tue, 10 Dec 2019 16:24:50 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Anson Huang <anson.huang@nxp.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>
Subject: Re: About CPU hot-plug stress test failed in cpufreq driver
Message-ID: <20191210105450.avv2gvygl7kj5auu@vireshk-i7>
References: <DB3PR0402MB39165E1B832597ADBAB241AAF55C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <40413247.HltoIgKm8r@kreacher>
 <DB3PR0402MB3916C7E77C885343B2B961CFF55B0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <5310126.hg2rr5Fjtk@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5310126.hg2rr5Fjtk@kreacher>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10-12-19, 11:39, Rafael J. Wysocki wrote:
> Index: linux-pm/kernel/sched/cpufreq.c
> ===================================================================
> --- linux-pm.orig/kernel/sched/cpufreq.c
> +++ linux-pm/kernel/sched/cpufreq.c
> @@ -5,6 +5,8 @@
>   * Copyright (C) 2016, Intel Corporation
>   * Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>   */
> +#include <linux/cpufreq.h>
> +
>  #include "sched.h"
>  
>  DEFINE_PER_CPU(struct update_util_data __rcu *, cpufreq_update_util_data);
> @@ -57,3 +59,19 @@ void cpufreq_remove_update_util_hook(int
>  	rcu_assign_pointer(per_cpu(cpufreq_update_util_data, cpu), NULL);
>  }
>  EXPORT_SYMBOL_GPL(cpufreq_remove_update_util_hook);
> +
> +/**
> + * cpufreq_this_cpu_can_update - Check if cpufreq policy can be updated.
> + * @policy: cpufreq policy to check.
> + *
> + * Return 'true' if:
> + * - the local and remote CPUs share @policy,
> + * - dvfs_possible_from_any_cpu is set in @policy and the local CPU is not going
> + *   offline (in which it is not expected to run cpufreq updates any more).
> + */
> +bool cpufreq_this_cpu_can_update(struct cpufreq_policy *policy)
> +{
> +	return cpumask_test_cpu(smp_processor_id(), policy->cpus) ||
> +		(policy->dvfs_possible_from_any_cpu &&

> +		 rcu_dereference_sched(*this_cpu_ptr(&cpufreq_update_util_data)));

I somehow feel that doing this particular check in cpufreq_update_util() maybe
better. Or maybe we can call cpufreq_this_cpu_can_update() itself right from
cpufreq_update_util() instead and remove it from multiple places in the
governors.

-- 
viresh
