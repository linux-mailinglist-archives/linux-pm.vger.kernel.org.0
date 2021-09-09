Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 152FE4059FB
	for <lists+linux-pm@lfdr.de>; Thu,  9 Sep 2021 17:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240266AbhIIPDJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Sep 2021 11:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236843AbhIIPDE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Sep 2021 11:03:04 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DA0C061575;
        Thu,  9 Sep 2021 08:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/Y5MADjdN8PfBLXXdisZCNOGIKICg1o3R1wg6sLA0F0=; b=n0r32pBAY1IV9h2w7DoeJMyOoS
        H1Rzt3uYTOlPQMqb6PcKGFYj7Dny0GAtWGm26Cvk+BNSHpAHOF3wSOaZZ11F0o0NwUcE7iK/8RvIK
        Fn5DWktzPwzi/oeVOBQpSB8Tdv5qwyzV/xovHdUrVgc0SfiL8IW7P+R8mN/zt0j6YNxV9IPLJabG+
        zm0KJLt+3y/nrrW2G47diDSC8/AyVLeGM9AOzRZaNlYXIjq+FDt+dDpSXr/y50lfaqZ4B8moxgUm8
        IcKz9DYX15I29Y/oPAv3iJ9SthEsSAlwNlzjphTEHQLrjb/MBthxEedADbaB7zuRmtsx4M551+6uL
        Sm8VwI8g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mOLYc-001tWu-Rb; Thu, 09 Sep 2021 15:01:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D7CA130004C;
        Thu,  9 Sep 2021 17:01:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BFB5E20C09044; Thu,  9 Sep 2021 17:01:41 +0200 (CEST)
Date:   Thu, 9 Sep 2021 17:01:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Huang Rui <ray.huang@amd.com>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@kernel.org>,
        linux-pm@vger.kernel.org, Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH 04/19] cpufreq: amd: introduce a new amd pstate driver to
 support future processors
Message-ID: <YToh1Vhei2PyhlW+@hirez.programming.kicks-ass.net>
References: <20210908150001.3702552-1-ray.huang@amd.com>
 <20210908150001.3702552-5-ray.huang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210908150001.3702552-5-ray.huang@amd.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Sep 08, 2021 at 10:59:46PM +0800, Huang Rui wrote:

> +struct amd_pstate_perf_funcs {
> +	int (*enable)(bool enable);
> +	int (*init_perf)(struct amd_cpudata *cpudata);
> +	void (*update_perf)(struct amd_cpudata *cpudata,
> +			    u32 min_perf, u32 des_perf,
> +			    u32 max_perf, bool fast_switch);
> +};

> +static int
> +amd_pstate_enable(struct amd_pstate_perf_funcs *funcs, bool enable)
> +{
> +	if (!funcs)
> +		return -EINVAL;
> +
> +	return funcs->enable(enable);
> +}

> +static int amd_pstate_init_perf(struct amd_cpudata *cpudata)
> +{
> +	struct amd_pstate_perf_funcs *funcs = cpufreq_get_driver_data();
> +
> +	if (!funcs)
> +		return -EINVAL;
> +
> +	return funcs->init_perf(cpudata);
> +}

> +static int
> +amd_pstate_update_perf(struct amd_cpudata *cpudata, u32 min_perf,
> +		       u32 des_perf, u32 max_perf, bool fast_switch)
> +{
> +	struct amd_pstate_perf_funcs *funcs = cpufreq_get_driver_data();
> +
> +	if (!funcs)
> +		return -EINVAL;
> +
> +	funcs->update_perf(cpudata, min_perf, des_perf,
> +			   max_perf, fast_switch);
> +
> +	return 0;
> +}

> +static struct amd_pstate_perf_funcs pstate_funcs = {
> +	.enable = pstate_enable,
> +	.init_perf = pstate_init_perf,
> +	.update_perf = pstate_update_perf,
> +};

> +static int __init amd_pstate_init(void)
> +{
> +	int ret;
> +	struct amd_pstate_perf_funcs *funcs;

> +
> +	funcs = &pstate_funcs;

What is the purpose of this seemingly pointless indirection? Showing off
how good AMD hardware is at doing retpolines or something?
