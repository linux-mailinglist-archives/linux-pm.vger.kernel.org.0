Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E35810AF42
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2019 13:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbfK0MHt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Nov 2019 07:07:49 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39774 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbfK0MHt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Nov 2019 07:07:49 -0500
Received: by mail-pg1-f194.google.com with SMTP id b137so8411065pga.6
        for <linux-pm@vger.kernel.org>; Wed, 27 Nov 2019 04:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=K2kUt+3Utv0U/lxz9Sn3u3UBpoDUITVmuY7QcGVxNzk=;
        b=TFiRlUNuKgtzuenkN7FjwVpZDCmhS3ME+j1NHP+zQLLgsZSTQI7Y+H1jzhCjaVATdj
         ACslhGynFMAoB0PCZYTJkn7wDFXmf5JpoF/NX+saZwsMAVpESmzLGkqTGoZICjaj8QZF
         NsOeLxvY2SQLU8jihNN9ZutsKem3btGs/pUtlzYfAqE/AF1wEMv8eZO5WJyKBbs4GXX4
         oSEjaSptzKuqD0eXtcwvwJaIBgTci4YNIAzELApikP9ajvAMkzEVjbf9oYpNdcQzXqpG
         Ckv6oNSCP9c9oWzIjO6pNDQ8lQCYfbfYWFB1zov5oH1o84nj+MCCBuTSgvxFOuuTOAUB
         jp+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K2kUt+3Utv0U/lxz9Sn3u3UBpoDUITVmuY7QcGVxNzk=;
        b=K8ZlM+hg9nwDu95mFzXvz5Rs2AeMyl55MhjbnxMjdSuMWt6RpJkBBMwzOTYthhro5H
         qkfaFPvGkCW6Mx/eloJK42hqkPblAIVOWeKKa1VoKUPS6V/w++BIrWxcJgSQfxY+quyf
         ucorZUoNQKOLF+Ohw5BclMPxXuqzr8acWHMcSKCrZIDa1pHPGR9lnURqyTSs2Jk0Gepm
         8xbgXw9Oj/Z0ytdTxLhzLLhl0+QNVtZzZ1ePb3oA7Nu4Z90VbUcZVNeh6HCOqtC2d26r
         9kibpJXNxFW3ZP8eWMOTnGJPQkdLkJyvnFu7r/ZdPu+tEB4LpqGh5hGboy/21IItlADK
         nFQw==
X-Gm-Message-State: APjAAAXy+gXtU/gQ5bjwP82eZBTnT8+SIPDd0PUXVY+agP6MmHYiR2Vh
        q6Z+K1urJ5EXlmlzavyUP5NRhA==
X-Google-Smtp-Source: APXvYqzFJ3B2yRMuuWQYTrYHx8R6FxyuQQYlBZvpMqZgQZbJIZXWuMoIq2kRJTwIF2oUjuAhccJ11Q==
X-Received: by 2002:a63:1402:: with SMTP id u2mr4604261pgl.224.1574856467322;
        Wed, 27 Nov 2019 04:07:47 -0800 (PST)
Received: from localhost ([122.171.112.123])
        by smtp.gmail.com with ESMTPSA id s7sm1273794pfe.22.2019.11.27.04.07.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Nov 2019 04:07:46 -0800 (PST)
Date:   Wed, 27 Nov 2019 17:37:44 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: vexpress-spc: Fix wrong alternation of
 policy->related_cpus during CPU hp
Message-ID: <20191127120744.iivgw25nixovfj7i@vireshk-i7>
References: <20191127114801.23837-1-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191127114801.23837-1-dietmar.eggemann@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 27-11-19, 12:48, Dietmar Eggemann wrote:
> Since commit ca74b316df96 ("arm: Use common cpu_topology structure and
> functions.") the core cpumask has to be modified during cpu hotplug
> operations.
> 
> ("arm: Fix topology setup in case of CPU hotplug for CONFIG_SCHED_MC")
> [1] fixed that but revealed another issue on TC2, i.e in its cpufreq
> driver.
> 
> During CPU hp stress operations on multiple CPUs, policy->related_cpus
> can be altered. This is wrong since this cpumask should contain the
> online and offline CPUs.
> 
> The WARN_ON(!cpumask_test_cpu(cpu, policy->related_cpus)) in
> cpufreq_online() triggers in this case.
> 
> The core cpumask can't be used to set the policy->cpus in
> ve_spc_cpufreq_init() anymore in case it is called via
> cpuhp_cpufreq_online()->cpufreq_online()->cpufreq_driver->init().
> 
> An empty online() callback can be used to avoid that the init()
> driver function is called during CPU hotplug in so that
> policy->related_cpus will not be changed.
> 
> Implementing an online() also requires an offline() callback.
> 
> Tested on TC2 with CPU hp stress test (CPU hp from multiple CPUs at
> the same time).
> 
> [1]
> https://lore.kernel.org/r/20191127103353.12417-1-dietmar.eggemann@arm.com
> 
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

Wanna provide any fixes tag ?

> ---
>  drivers/cpufreq/vexpress-spc-cpufreq.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

This is 5.5 material or 5.6 ?

-- 
viresh
