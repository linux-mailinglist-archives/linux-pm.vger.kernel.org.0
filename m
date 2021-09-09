Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0723F405A06
	for <lists+linux-pm@lfdr.de>; Thu,  9 Sep 2021 17:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236488AbhIIPGi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Sep 2021 11:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232656AbhIIPGh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Sep 2021 11:06:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFFF3C061575;
        Thu,  9 Sep 2021 08:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XatBdf6kvwVA+XoD7v6XgWyLVTuT1t7NiBgGj7BPRz4=; b=fVfKmjXsBlDx/NmKPltkuBLD68
        74R78+5rvHbUz+2liXm+xSAeny4dVvaSyJs6hGhvfe21kbTEYOtpZt4QuTkal1W/vn3RSlYOr22Oa
        XCm8R42DpeKvfgDCC/1Y2sSJPUkepf9knmd93wegg5wNwa67utvKFHvw1xCl6zhFsHi0cj4F1TVv6
        RnEq4nAf3HxOG+4pZPLOP4LSMHkVL0hcNvx2VPw1Z7mVGe7LwWo4OQI5nUeH/5288XEPTTwDu5I+3
        9xvSspaGoxFhDYO+pivk3SoSx8KycZ0wZdlQnAwl6Gch8RjVt73M8NQF+e54QCPli6hrbvYTtJ9X3
        zot/pIog==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mOLal-00A8Cr-7E; Thu, 09 Sep 2021 15:04:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D1E75300094;
        Thu,  9 Sep 2021 17:03:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BA39720D13711; Thu,  9 Sep 2021 17:03:54 +0200 (CEST)
Date:   Thu, 9 Sep 2021 17:03:54 +0200
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
Message-ID: <YToiWpGxHV5oE2z8@hirez.programming.kicks-ass.net>
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

> +static int pstate_init_perf(struct amd_cpudata *cpudata)
> +{
> +	u64 cap1;
> +
> +	int ret = rdmsrl_safe_on_cpu(cpudata->cpu, MSR_AMD_CPPC_CAP1,
> +				     &cap1);
> +	if (ret)
> +		return ret;
> +
> +	/* Some AMD processors has specific power features that the cppc entry
> +	 * doesn't indicate the highest performance. It will introduce the
> +	 * feature in following days.
> +	 */

Wrong comment style; also imagine reading this comment half a year from
now...

> +	WRITE_ONCE(cpudata->highest_perf, amd_get_highest_perf());
> +
> +	WRITE_ONCE(cpudata->nominal_perf, CAP1_NOMINAL_PERF(cap1));
> +	WRITE_ONCE(cpudata->lowest_nonlinear_perf, CAP1_LOWNONLIN_PERF(cap1));
> +	WRITE_ONCE(cpudata->lowest_perf, CAP1_LOWEST_PERF(cap1));
> +
> +	return 0;
> +}
