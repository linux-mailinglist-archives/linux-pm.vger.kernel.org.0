Return-Path: <linux-pm+bounces-30764-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF01B038BE
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jul 2025 10:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65DA1189D2B2
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jul 2025 08:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6D22376EF;
	Mon, 14 Jul 2025 08:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="cQC6Icyw"
X-Original-To: linux-pm@vger.kernel.org
Received: from jpms-ob02-os7.noc.sony.co.jp (jpms-ob02-os7.noc.sony.co.jp [211.125.139.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0BD1FECB4;
	Mon, 14 Jul 2025 08:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.125.139.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752480519; cv=none; b=LnC7fls1qXql8dTRoPFjo9EA0GMI3yw+SlHKIbThXzuWevK+k4rUEK5sFWSycN+O0Gsgzk2SYIc8hOeDE+dMd72tGfm2Q34vNi73sDOeG+DvfcN38iv+kX3P92ueMII8tBAmPEXMR2uqRJYTS+SasKW3KZEJR3IWJwOeyGU3Yzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752480519; c=relaxed/simple;
	bh=o/I9ED/6RYXiA0gj4CHZ4R9Zuwm0EsxA4Q+MJceqOdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tSSNI8b0rORwz7e+IYvnE+0iDrdRxAsnAWba4acliz+S08Lf6GQOHhJO0w5h8iNDUanQeHD1Yx7f8Sqh/XXbbE5CeDnZks3zFuvV42wbdJMszXZEFZ8HSq7jD+/TkuiqiRw6UM444/PY1Zxy4SZ6IKbyEykjUeMBkwLP9QTdrCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=fail smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=cQC6Icyw; arc=none smtp.client-ip=211.125.139.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=sony.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1752480516; x=1784016516;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KK8q8fL86i3SFNr8AqR/QJFlAoxKfHCpjRRUJZxX4N0=;
  b=cQC6IcywV6fNn4/8X2xbRb5UbCruwX1EtBnqwyzOVm1Q2XNZDNMVwuZS
   7OxXpYVMVoJyWcpzsm8lXoGaS9W3MsI1Vuo+PsL4UvGev2nhWE8tW96yK
   aTCDt9argH3dyLNsqAbEz9vboxUw8cBoY5cMWfHytEdVlOfaezjifjKyN
   RUUH+bE6YMzm7Yx42uGV4K90ViCD5Fr/OATdSrINmiEYjKs5kFANlbDOy
   rUX2tXKTeZ5NOBRlXJoKlcsTeZGR5DeSleNpAYqOtAa5h6R6g2ECBMLc/
   R4awkRMU/jylsw9T5qhuozRAVDyxqK4fGvEvhyYbuXeeXPza2ZRfzcLYZ
   w==;
Received: from unknown (HELO jpmta-ob01-os7.noc.sony.co.jp) ([IPv6:2001:cf8:acf:1104::6])
  by jpms-ob02-os7.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 16:58:27 +0900
X-IronPort-AV: E=Sophos;i="6.16,310,1744038000"; 
   d="scan'208";a="7055890"
Received: from unknown (HELO JPC00244420) ([IPv6:2001:cf8:1:573:0:dddd:eb3e:119e])
  by jpmta-ob01-os7.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 16:58:27 +0900
Date: Mon, 14 Jul 2025 16:58:24 +0900
From: Shashank Balaji <shashank.mahadasyam@sony.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Russell Haley <yumpusamongus@gmail.com>
Subject: Re: [PATCH v1] cpufreq: intel_pstate: Always use HWP_DESIRED_PERF in
 passive mode
Message-ID: <aHS4oFDFUhQcuZj6@JPC00244420>
References: <6173276.lOV4Wx5bFT@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6173276.lOV4Wx5bFT@rjwysocki.net>

Hi Rafael,

On Mon, Jun 16, 2025 at 08:19:19PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> In the passive mode, intel_cpufreq_update_pstate() sets HWP_MIN_PERF in
> accordance with the target frequency to ensure delivering adequate
> performance, but it sets HWP_DESIRED_PERF to 0, so the processor has no
> indication that the desired performance level is actually equal to the
> floor one.  This may cause it to choose a performance point way above
> the desired level.
> 
> Moreover, this is inconsistent with intel_cpufreq_adjust_perf() which
> actually sets HWP_DESIRED_PERF in accordance with the target performance
> value.
> 
> Address this by adjusting intel_cpufreq_update_pstate() to pass
> target_pstate as both the minimum and the desired performance levels
> to intel_cpufreq_hwp_update().
> 
> Fixes: a365ab6b9dfb ("cpufreq: intel_pstate: Implement the ->adjust_perf() callback")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/intel_pstate.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -3249,8 +3249,8 @@
>  		int max_pstate = policy->strict_target ?
>  					target_pstate : cpu->max_perf_ratio;
>  
> -		intel_cpufreq_hwp_update(cpu, target_pstate, max_pstate, 0,
> -					 fast_switch);
> +		intel_cpufreq_hwp_update(cpu, target_pstate, max_pstate,
> +					 target_pstate, fast_switch);
>  	} else if (target_pstate != old_pstate) {
>  		intel_cpufreq_perf_ctl_update(cpu, target_pstate, fast_switch);
>  	}

The patch looks good to me. In fact, I'm surprised this is not how it has always
been :)

Here are two tests to look at the power consumption and performance implications.
The tests were run on a Intel Core Ultra 5 135H machine with 6.16-rc5 defconfig +
CONFIG_CPU_FREQ_GOV_POWERSAVE + CONFIG_CPU_FREQ_GOV_CONSERVATIVE.

Both the idle power consumption test and the CPU stressor power consumption test
were run with the powersave, performance, conservative, and ondemand governors
on all the cores.

We don't expect any changes in the powersave and performance governors because
they have strict_target set. So in their case, the change is:

	min_perf     = target        min_perf     = target
	desired_perf = 0        =>   desired_perf = target
	max_perf     = target        max_perf     = target

So, that change does nothing. We only expect to see a change in the conservative
and ondemand governors, which is confirmed by the test results.

In summary, this patch lowers idle power consumption with conservative and
ondemand governors by 9%. There are no significant energy or duration changes
with any of the governors for the stress-ng cpu stressor.

1. Idle power consumption

Monitor average power usage every minute for six minutes:

turbostat --Summary --quiet --show PkgWatt --interval 60 --num_iterations 6

+--------------+-------------------+-------+---------+
|              |     Average power (W)     |         |
+   Governor   +-------------------+-------+ Change  +
|              | Before            | After |         |
+--------------+-------------------+-------+---------+
| Powersave    | 7                 | 7.1   | ~0%     |
| Performance  | 11.85             | 11.85 | ~0%     |
| Conservative | 8.1               | 7.35  | -9%     |
| Ondemand     | 7.55              | 6.85  | -9%     |
+--------------+-------------------+-------+---------+

2. CPU stressor's power consumption

Run stress-ng's matrixprod cpu stressor on each of the cores for 5 million bogo
ops (fixed workload), with a cpu load of 50%, so that there's some leeway for
frequency tuning by the governor. At the default 100% cpu load, the frequency
would just shoot up to the maximum.

turbostat --quiet --Summary --Joules --show Pkg_J \ 
	stress-ng --cpu $(nproc) --cpu-ops 5000000 --cpu-load 50 \
		  --cpu-method matrixprod --metrics-brief

+--------------+------------+--------------+------------+--------------+--------+-----------+
|              |          Before           |           After           |      Change        |
+   Governor   +------------+--------------+------------+--------------+--------+-----------+
|              | Energy (J) | Duration (s) | Energy (J) | Duration (s) | Energy | Duration  |
|--------------+------------+--------------+------------+--------------+--------+-----------+
| Powersave    | 10680      | 773          | 10691      | 776          | 0%     | 0%        |
| Performance  | 11753      | 409          | 11723      | 405          | 0%     | -1%       |
| Conservative | 11815      | 409          | 11922      | 414          | 1%     | 1%        |
| Ondemand     | 11803      | 408          | 11814      | 409          | 0%     | 0%        |
+--------------+------------+--------------+------------+--------------+--------+-----------+

Tested-by: Shashank Balaji <shashank.mahadasyam@sony.com>

Thanks,
Shashank

