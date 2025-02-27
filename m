Return-Path: <linux-pm+bounces-23134-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB792A48986
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 21:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6E3916DDEE
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 20:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0722F27181D;
	Thu, 27 Feb 2025 20:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YnHlJzwu"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE9C26FA7B;
	Thu, 27 Feb 2025 20:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740686949; cv=none; b=f/QMeIiSW5MxqzQXtERIFTpGSE+BJLCvwpW2Vsv6Q3VhAgAi0SQ55O9T9mE1dnXjpzFGs72SCr+umpmRmuDYG6NcuP2wLU7IyXqJxqc9UWVExG5gISbTMU4xg6a+9V/SqLPrj7RYe4g51ixxDt1KeFZKi50MXTDwfhbIoQ1cBfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740686949; c=relaxed/simple;
	bh=j5VRDcgqEaXuWIDavjd4YEFkmlI9dTVUxhcuv8TxV1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YpQZxBS1F6sdr4r+PxXmfzrmKnjX0C8tlNIGJIoUUsCp+BHyDP6z6Q/04pW8xfGH5kuEZ+8xqRPkTTNJ70GyLZutCqvhNBaJibH1Z4zEQSfTRXtfcYStiBqQCNz3TxMX7IAWkqsWynfYOhr3JKDQmXlgPhA9UBrnfYBAgYi0fQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YnHlJzwu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A482C4CEE4;
	Thu, 27 Feb 2025 20:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740686949;
	bh=j5VRDcgqEaXuWIDavjd4YEFkmlI9dTVUxhcuv8TxV1Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YnHlJzwuNAhrmOtUQIOONlXKaDukIwGkh5SrT+AZR/hmITYF8E+hdIpjGMviggUAj
	 drRRRPU+0AG9uF7+Y4DAsDNah8z1NEGiynbb4H7ZmAMNCtqMAPnrEG0/FOhod04EkA
	 U4ma/Mnk6WCTXvtBPcsBSlNVHumJohdP7s+1dB7bS3+4Ek6MDDTe+rDOOTWJOBoHw7
	 88UWXpeCccf5vEyjP4aC80SfJnsy4m7ljKWtpGIkinhTaVHGH1AKbnN9aIZYuM++b4
	 snIDmnGQv2ZxWJoUBIBmwAuOY6ko8JXBsH0MG2WGHgZeI3Q2ACG+RqLz0uhhZvCWq4
	 NJ3Oif7ZQ51KA==
Message-ID: <d1fc8fea-5a2c-4b38-949c-8063cb76fadf@kernel.org>
Date: Thu, 27 Feb 2025 14:09:08 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/19] cpufreq/amd-pstate: Move perf values into a
 union
To: kernel test robot <lkp@intel.com>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
 "(open list:X86 ARCHITECTURE (32-BIT AND 64-BIT))"
 <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20250226074934.1667721-5-superm1@kernel.org>
 <202502272001.nafS0qXq-lkp@intel.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <202502272001.nafS0qXq-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/27/2025 06:59, kernel test robot wrote:
> Hi Mario,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on amd-pstate/bleeding-edge]
> [cannot apply to rafael-pm/linux-next rafael-pm/bleeding-edge tip/x86/core amd-pstate/linux-next linus/master v6.14-rc4 next-20250227]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Mario-Limonciello/cpufreq-amd-pstate-Invalidate-cppc_req_cached-during-suspend/20250226-155545
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git bleeding-edge
> patch link:    https://lore.kernel.org/r/20250226074934.1667721-5-superm1%40kernel.org
> patch subject: [PATCH v5 04/19] cpufreq/amd-pstate: Move perf values into a union
> config: i386-buildonly-randconfig-003-20250227 (https://download.01.org/0day-ci/archive/20250227/202502272001.nafS0qXq-lkp@intel.com/config)
> compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250227/202502272001.nafS0qXq-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202502272001.nafS0qXq-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>     In file included from drivers/cpufreq/amd-pstate.c:51:
>     In file included from drivers/cpufreq/amd-pstate-trace.h:15:
>     In file included from include/linux/trace_events.h:6:
>     In file included from include/linux/ring_buffer.h:5:
>     In file included from include/linux/mm.h:2224:
>     include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
>       504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
>           |                            ~~~~~~~~~~~~~~~~~~~~~ ^
>       505 |                            item];
>           |                            ~~~~
>     include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
>       511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
>           |                            ~~~~~~~~~~~~~~~~~~~~~ ^
>       512 |                            NR_VM_NUMA_EVENT_ITEMS +
>           |                            ~~~~~~~~~~~~~~~~~~~~~~
>>> drivers/cpufreq/amd-pstate.c:914:41: warning: variable 'nominal_freq' is uninitialized when used here [-Wuninitialized]
>       914 |                 perf.lowest_perf = freq_to_perf(perf, nominal_freq, min_freq);
>           |                                                       ^~~~~~~~~~~~
>     drivers/cpufreq/amd-pstate.c:902:38: note: initialize the variable 'nominal_freq' to silence this warning
>       902 |         u32 min_freq, max_freq, nominal_freq, lowest_nonlinear_freq;
>           |                                             ^
>           |                                              = 0
>     3 warnings generated.
> 
> 
> vim +/nominal_freq +914 drivers/cpufreq/amd-pstate.c
> 
>     891	
>     892	/*
>     893	 * amd_pstate_init_freq: Initialize the nominal_freq and lowest_nonlinear_freq
>     894	 *			 for the @cpudata object.
>     895	 *
>     896	 * Requires: all perf members of @cpudata to be initialized.
>     897	 *
>     898	 * Returns 0 on success, non-zero value on failure.
>     899	 */
>     900	static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
>     901	{
>     902		u32 min_freq, max_freq, nominal_freq, lowest_nonlinear_freq;
>     903		struct cppc_perf_caps cppc_perf;
>     904		union perf_cached perf;
>     905		int ret;
>     906	
>     907		ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
>     908		if (ret)
>     909			return ret;
>     910		perf = READ_ONCE(cpudata->perf);
>     911	
>     912		if (quirks && quirks->lowest_freq) {
>     913			min_freq = quirks->lowest_freq;
>   > 914			perf.lowest_perf = freq_to_perf(perf, nominal_freq, min_freq);
>     915			WRITE_ONCE(cpudata->perf, perf);
>     916		} else
>     917			min_freq = cppc_perf.lowest_freq;
>     918	
>     919		if (quirks && quirks->nominal_freq)
>     920			nominal_freq = quirks->nominal_freq;
>     921		else
>     922			nominal_freq = cppc_perf.nominal_freq;
>     923	
>     924		min_freq *= 1000;
>     925		nominal_freq *= 1000;
>     926	
>     927		WRITE_ONCE(cpudata->nominal_freq, nominal_freq);
>     928	
>     929		max_freq = perf_to_freq(perf, nominal_freq, perf.highest_perf);
>     930		lowest_nonlinear_freq = perf_to_freq(perf, nominal_freq, perf.lowest_nonlinear_perf);
>     931		WRITE_ONCE(cpudata->lowest_nonlinear_freq, lowest_nonlinear_freq);
>     932	
>     933		/**
>     934		 * Below values need to be initialized correctly, otherwise driver will fail to load
>     935		 * max_freq is calculated according to (nominal_freq * highest_perf)/nominal_perf
>     936		 * lowest_nonlinear_freq is a value between [min_freq, nominal_freq]
>     937		 * Check _CPC in ACPI table objects if any values are incorrect
>     938		 */
>     939		if (min_freq <= 0 || max_freq <= 0 || nominal_freq <= 0 || min_freq > max_freq) {
>     940			pr_err("min_freq(%d) or max_freq(%d) or nominal_freq(%d) value is incorrect\n",
>     941				min_freq, max_freq, nominal_freq);
>     942			return -EINVAL;
>     943		}
>     944	
>     945		if (lowest_nonlinear_freq <= min_freq || lowest_nonlinear_freq > nominal_freq) {
>     946			pr_err("lowest_nonlinear_freq(%d) value is out of range [min_freq(%d), nominal_freq(%d)]\n",
>     947				lowest_nonlinear_freq, min_freq, nominal_freq);
>     948			return -EINVAL;
>     949		}
>     950	
>     951		return 0;
>     952	}
>     953	
> 

The series is getting close (I think just one more patch needing review).

So if no other feedback for the series needing other fixes I will squash 
this in to fix this issue when the series is merged.

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index bd8bcda4e6eb0..034ee40681b4c 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -915,6 +915,12 @@ static int amd_pstate_init_freq(struct amd_cpudata 
*cpudata)
                 return ret;
         perf = READ_ONCE(cpudata->perf);

+       if (quirks && quirks->nominal_freq)
+               nominal_freq = quirks->nominal_freq;
+       else
+               nominal_freq = cppc_perf.nominal_freq;
+       nominal_freq *= 1000;
+
         if (quirks && quirks->lowest_freq) {
                 min_freq = quirks->lowest_freq;
                 perf.lowest_perf = freq_to_perf(perf, nominal_freq, 
min_freq);
@@ -922,13 +928,7 @@ static int amd_pstate_init_freq(struct amd_cpudata 
*cpudata)
         } else
                 min_freq = cppc_perf.lowest_freq;

-       if (quirks && quirks->nominal_freq)
-               nominal_freq = quirks->nominal_freq;
-       else
-               nominal_freq = cppc_perf.nominal_freq;
-
         min_freq *= 1000;
-       nominal_freq *= 1000;

         WRITE_ONCE(cpudata->nominal_freq, nominal_freq);


