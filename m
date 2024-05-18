Return-Path: <linux-pm+bounces-7969-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4988C92FC
	for <lists+linux-pm@lfdr.de>; Sun, 19 May 2024 00:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 667F5B20D49
	for <lists+linux-pm@lfdr.de>; Sat, 18 May 2024 22:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385C56CDCA;
	Sat, 18 May 2024 22:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="ToFpam+K"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4388F49;
	Sat, 18 May 2024 22:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716070053; cv=none; b=cA22B4yoBylDpZ02Lo3iBDrICKu/cvuC8JLg9mIzvBnel92skxeRl7KkHpWRtGwATmS3u/28/UrQ4mnKMxnLbp63Miv1NWcGuPB7GPvWdNa0WtZr18KrQ6jC9pUxSfIs4dBMARrDdpmBviZcyYnZXsYuvYo0WdqNa9pDP69HeI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716070053; c=relaxed/simple;
	bh=7WZoC8Cv9EUhQkWgeAytRxfMcPYt+SStwinFuIc4Sy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mcTf/3ryJ3n49G3o9uh+GAR3WwtwYVhRr7oVyT7zsOoVEjCPGcaGNLcRlfCge0p7gw2knjCjlCeCJzyZi3XFIszFSemuQg2CnuKJVzQXENBSrm+8jW2KlKPmyzrN5SQ7e0tbYdqjSHXG42k5odG9iyN/NI4QQDBbk5tZxBG3o/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=ToFpam+K; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1716070044;
	bh=7WZoC8Cv9EUhQkWgeAytRxfMcPYt+SStwinFuIc4Sy0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ToFpam+KIVz5AUTeBcEhAT2PgruryZpzQ+fU+2O06JwRPsg4+BLVX+SbUuenIbL6A
	 H/4KG0Z3F1C6ODmhqsmKO3GqTbiFKWD9hJ00qc2fsyw17QZEmaW0o+IBEcQ0kpS81V
	 TVpnC3iHkPUq6hvJXKiy8vlr3ZWntMT27nbldhUA=
Date: Sun, 19 May 2024 00:07:24 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: stable@vger.kernel.org
Cc: rafael.j.wysocki@intel.com, Mario.Limonciello@amd.com, 
	viresh.kumar@linaro.org, Ray.Huang@amd.com, gautham.shenoy@amd.com, 
	Borislav.Petkov@amd.com, Alexander.Deucher@amd.com, Xinmei.Huang@amd.com, 
	Xiaojian.Du@amd.com, Li.Meng@amd.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Perry Yuan <perry.yuan@amd.com>
Subject: Re: [PATCH] cpufreq: amd-pstate: fix the highest frequency issue
 which limit performance
Message-ID: <4212df0b-5797-42a8-9c64-3e03851293b5@t-8ch.de>
References: <20240508054703.3728337-1-perry.yuan@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240508054703.3728337-1-perry.yuan@amd.com>

Hi stable team,

Please backport the mainline commit
bf202e654bfa ("cpufreq: amd-pstate: fix the highest frequency issue which limits performance")
to the 6.9 stable series.

It fixes a performance regression on AMD Phoenix platforms.

It was meant to get into the 6.9 release or the stable branch shortly
after, but apparently that didn't happen.

On 2024-05-08 13:47:03+0000, Perry Yuan wrote:
> To address the performance drop issue, an optimization has been
> implemented. The incorrect highest performance value previously set by the
> low-level power firmware for AMD CPUs with Family ID 0x19 and Model ID
> ranging from 0x70 to 0x7F series has been identified as the cause.
> 
> To resolve this, a check has been implemented to accurately determine the
> CPU family and model ID. The correct highest performance value is now set
> and the performance drop caused by the incorrect highest performance value
> are eliminated.
> 
> Before the fix, the highest frequency was set to 4200MHz, now it is set
> to 4971MHz which is correct.
> 
> CPU NODE SOCKET CORE L1d:L1i:L2:L3 ONLINE    MAXMHZ   MINMHZ       MHZ
>   0    0      0    0 0:0:0:0          yes 4971.0000 400.0000  400.0000
>   1    0      0    0 0:0:0:0          yes 4971.0000 400.0000  400.0000
>   2    0      0    1 1:1:1:0          yes 4971.0000 400.0000 4865.8140
>   3    0      0    1 1:1:1:0          yes 4971.0000 400.0000  400.0000
> 
> v1->v2:
>  * add test by flag from Gaha Bana
> 
> Fixes: f3a052391822 ("cpufreq: amd-pstate: Enable amd-pstate preferred core support")
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218759
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> Tested-by: Gaha Bana <gahabana@gmail.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 2db095867d03..6a342b0c0140 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -50,7 +50,8 @@
>  
>  #define AMD_PSTATE_TRANSITION_LATENCY	20000
>  #define AMD_PSTATE_TRANSITION_DELAY	1000
> -#define AMD_PSTATE_PREFCORE_THRESHOLD	166
> +#define CPPC_HIGHEST_PERF_PERFORMANCE	196
> +#define CPPC_HIGHEST_PERF_DEFAULT	166
>  
>  /*
>   * TODO: We need more time to fine tune processors with shared memory solution
> @@ -326,6 +327,21 @@ static inline int amd_pstate_enable(bool enable)
>  	return static_call(amd_pstate_enable)(enable);
>  }
>  
> +static u32 amd_pstate_highest_perf_set(struct amd_cpudata *cpudata)
> +{
> +	struct cpuinfo_x86 *c = &cpu_data(0);
> +
> +	/*
> +	 * For AMD CPUs with Family ID 19H and Model ID range 0x70 to 0x7f,
> +	 * the highest performance level is set to 196.
> +	 * https://bugzilla.kernel.org/show_bug.cgi?id=218759
> +	 */
> +	if (c->x86 == 0x19 && (c->x86_model >= 0x70 && c->x86_model <= 0x7f))
> +		return CPPC_HIGHEST_PERF_PERFORMANCE;
> +
> +	return CPPC_HIGHEST_PERF_DEFAULT;
> +}
> +
>  static int pstate_init_perf(struct amd_cpudata *cpudata)
>  {
>  	u64 cap1;
> @@ -342,7 +358,7 @@ static int pstate_init_perf(struct amd_cpudata *cpudata)
>  	 * the default max perf.
>  	 */
>  	if (cpudata->hw_prefcore)
> -		highest_perf = AMD_PSTATE_PREFCORE_THRESHOLD;
> +		highest_perf = amd_pstate_highest_perf_set(cpudata);
>  	else
>  		highest_perf = AMD_CPPC_HIGHEST_PERF(cap1);
>  
> @@ -366,7 +382,7 @@ static int cppc_init_perf(struct amd_cpudata *cpudata)
>  		return ret;
>  
>  	if (cpudata->hw_prefcore)
> -		highest_perf = AMD_PSTATE_PREFCORE_THRESHOLD;
> +		highest_perf = amd_pstate_highest_perf_set(cpudata);
>  	else
>  		highest_perf = cppc_perf.highest_perf;
>  
> -- 
> 2.34.1
> 

