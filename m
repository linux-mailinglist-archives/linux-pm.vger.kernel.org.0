Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 087C786F90
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2019 04:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732708AbfHICQP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Aug 2019 22:16:15 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38330 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729418AbfHICQO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Aug 2019 22:16:14 -0400
Received: by mail-pf1-f195.google.com with SMTP id y15so45181903pfn.5
        for <linux-pm@vger.kernel.org>; Thu, 08 Aug 2019 19:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=a/1ruBHpVt1jTKAf0TMhUUwHx4NvRraYwQZo6GfSVdo=;
        b=eTYKcvZclF2mMygBExsdVr8uQ39XImTZpvwxdzuJFUrwvnE8abhTW+W9gsCG57Z9X8
         rxoFxWAEfkg+q7jBAGOkZdQ40J6JzsQt1/4KB2PfNQPXK+ytgI41WcpbBEsi34qqvwAT
         lhac3eXaCR/13s1Tsc3tgSn7aWy22eiv/dQqJEaHSHVYVvZLqEABjJMNHgD2kXp1E4Nf
         ZakzsZ7uwpWEefKBNvYa+nnWbnXAnO6QmgnAKqdvRG1QdktLm/qTmfHsc7TRReUPdadn
         1sac74YI0B8976EX9CVI8WSY6OojDG9mUSejDHx/LM9QJ+Ego1YMwgCzcF7Zh1ACY3+j
         WBtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a/1ruBHpVt1jTKAf0TMhUUwHx4NvRraYwQZo6GfSVdo=;
        b=gPym/ippp66BXSK95DPffpuBQbd+70+/WqLEuLmbg6wJ5f4MHQLlUOqcxlOqxrTY0g
         jjcd5IaMYoBttO7/1YpXBLc6+MfbGjy3F12UeBd4s0TMQ6u5ZL6Yn45s+h5vZA1C2aOZ
         nPoZz5vEogoEJEsP05CvYuTtVK7x5QeiS+PLwm/Bp+1IfoyvLGFmgsI7wUGko7jq25J3
         I0Zg0qXs5PbfhplbYWwMIF5Ms1Jq/ncjJ/hWUOwyWdsSZCD21ivBBjBa2rf5iEQLzGub
         k8FwcTcV9nZ9OSdMNZPIgC0tIzZV2d7CelXz3VPnmdBcS7HjOPBQd0OWCVOPB3thkUDQ
         3Tow==
X-Gm-Message-State: APjAAAUQR4z2npBrbQyipWUxVG7Y7rkWtCpOmxzgWQg2eL/6jrQzvTAz
        lBOunkTE33hodm7SznvUSr/UNg==
X-Google-Smtp-Source: APXvYqxjFIjKEG2YLl39xJG9/4t10wZbRfOIyNBGmfhWSGuOXgrpO7JTwqWuk4mpETywH4ktBbQbEQ==
X-Received: by 2002:a17:90a:de02:: with SMTP id m2mr7070396pjv.18.1565316973979;
        Thu, 08 Aug 2019 19:16:13 -0700 (PDT)
Received: from localhost ([122.172.76.219])
        by smtp.gmail.com with ESMTPSA id a3sm97786667pfo.49.2019.08.08.19.16.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Aug 2019 19:16:12 -0700 (PDT)
Date:   Fri, 9 Aug 2019 07:46:07 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Doug Smythies <dsmythies@telus.net>
Cc:     linux-pm@vger.kernel.org,
        'Vincent Guittot' <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, 'Rafael Wysocki' <rjw@rjwysocki.net>,
        'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>,
        'Len Brown' <lenb@kernel.org>
Subject: Re: [PATCH V4 2/2] cpufreq: intel_pstate: Implement QoS supported
 freq constraints
Message-ID: <20190809021607.j4qj3jm72gbisvqh@vireshk-i7>
References: <70fce19e43bb825c3b2546e1211d262a59ae7378.1565161495.git.viresh.kumar@linaro.org>
 <e789eceae3f32a66fff923daeb85b33b88f21fe1.1565161495.git.viresh.kumar@linaro.org>
 <000601d54e05$e93d0130$bbb70390$@net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000601d54e05$e93d0130$bbb70390$@net>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08-08-19, 09:25, Doug Smythies wrote:
> On 2019.08.07 00:06 Viresh Kumar wrote:
> Tested by: Doug Smythies <dsmythies@telus.net>
> Thermald seems to now be working O.K. for all the governors.

Thanks for testing Doug.

> I do note that if one sets
> /sys/devices/system/cpu/cpufreq/policy*/scaling_max_freq
> It seems to override subsequent attempts via
> /sys/devices/system/cpu/intel_pstate/max_perf_pct.
> Myself, I find this confusing.
> 
> So the question becomes which one is the "master"?

No one is master, cpufreq takes all the requests for frequency
constraints and tries to set the value based on aggregation of all. So
for max frequency, the lowest value wins and is shown up in sysfs.

So, everything looks okay to me.

> > +static void update_qos_request(enum dev_pm_qos_req_type type)
> > +{
> > +	int max_state, turbo_max, freq, i, perf_pct;
> > +	struct dev_pm_qos_request *req;
> > +	struct cpufreq_policy *policy;
> > +
> > +	for_each_possible_cpu(i) {
> > +		struct cpudata *cpu = all_cpu_data[i];
> > +
> > +		policy = cpufreq_cpu_get(i);
> > +		if (!policy)
> > +			continue;
> > +
> > +		req = policy->driver_data;
> > +		cpufreq_cpu_put(policy);
> > +
> > +		if (!req)
> > +			continue;
> > +
> > +		if (hwp_active)
> > +			intel_pstate_get_hwp_max(i, &turbo_max, &max_state);
> > +		else
> > +			turbo_max = cpu->pstate.turbo_pstate;
> > +
> > +		if (type == DEV_PM_QOS_MIN_FREQUENCY) {
> 
> Is it O.K. to assume if the passed op code is
> not DEV_PM_QOS_MIN_FREQUENCY
> then it must have been
> DEV_PM_QOS_MAX_FREQUENCY
> ?
> 
> It is within this patch, but what about in future?

Yes, because it is called locally there is no need to add another if
statement here. And reviews should catch it in future and I don't
expect it to change much anyway.

> > +			perf_pct = global.min_perf_pct;
> > +		} else {
> > +			req++;
> > +			perf_pct = global.max_perf_pct;
> > +		}
> > +
> > +		freq = DIV_ROUND_UP(turbo_max * perf_pct, 100);
> > +		freq *= cpu->pstate.scaling;
> > +
> > +		if (dev_pm_qos_update_request(req, freq))
> > +			pr_warn("Failed to update freq constraint: CPU%d\n", i);
> 
> I get many of these messages (4520 so far, always in groups of 8 (I have 8 CPUs)),
> and have yet to figure out exactly why. It seems to actually be working fine.

Because of something I missed. dev_pm_qos_update_request() can return
1, when the constraint value gets changed. Will fix this patch.

-- 
viresh
