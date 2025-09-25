Return-Path: <linux-pm+bounces-35329-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC02B9E014
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 10:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69C8E2E73E1
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 08:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B952472A5;
	Thu, 25 Sep 2025 08:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="BJwfBHdB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D922D18B0A;
	Thu, 25 Sep 2025 08:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758788134; cv=none; b=WqQWnQeCALoSmFPVW/K29gMrqyy5LrNRqzyWZPuFANDF+hloWSL2XU0Vmg4X8QbV6Un2CrnbQDFaPCQmlWOuykQjGYF1cV+FoHvpNzv3kViDXx9UYKk5vUSQIgDsEplA66lwexBqgUKAsSgt94FjvACaeWWS1iXr8OKQRfuOoLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758788134; c=relaxed/simple;
	bh=ytGIoAdzQk/wcFAsVSdQ3TMNCOmOcnzTxLKF8ChiFEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=djIfdPlIsJnQya93yM/WkuGXmsNw2CsOnpqlauQG/9UGCMnXzeI6vPedA3ZQSjgLTDQBKl3oz8nJTXOIYdpLHgTJnbLD38PMqgtbErxk49AEjohr9r/rO5uKXcQEjV0dP/Ob4tBU7IlVyDgow9XboeWAHbFb+xQs/rRTIhj6X1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=BJwfBHdB; arc=none smtp.client-ip=1.95.21.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=llc5Tzmiyn3WcyN6milw9L2Jj4aG8Ta8h37lSKaIw0g=;
	b=BJwfBHdBswAXaYDNikbNDyekrBYDA75lsTGI0yABpFtZCjupEwgEal46jy/V0E
	wjEqIcnDt0qGkABzZUOfsmxYyjGu+WV3oWEmX/UORsEXFtgaWsPuoO+beHWmYBZN
	6hIGPr862QbL9jpNpdqdusj3F880BzTRAOOkbmGa65dzA=
Received: from dragon (unknown [])
	by gzsmtp3 (Coremail) with SMTP id M88vCgD3tG6T99RoezswBQ--.12403S3;
	Thu, 25 Sep 2025 16:04:37 +0800 (CST)
Date: Thu, 25 Sep 2025 16:04:35 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>, Qais Yousef <qyousef@layalina.io>,
	Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] cpufreq: Handle CPUFREQ_ETERNAL with a default
 transition latency
Message-ID: <aNT3k9OK82USu4n8@dragon>
References: <20250922125929.453444-1-shawnguo2@yeah.net>
 <12764935.O9o76ZdvQC@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <12764935.O9o76ZdvQC@rafael.j.wysocki>
X-CM-TRANSID:M88vCgD3tG6T99RoezswBQ--.12403S3
X-Coremail-Antispam: 1Uf129KBjvJXoW3Xw45Cw4rJw4UXr1fWFWUXFb_yoW3CrWUpF
	Waqw42y3W8tF4DJw1xGr4UuF1rXFn7A3yUKF1UGrnYqr4UA3Z0q3WUKryrtFW5A34kJF45
	AFyDtw15WF4UArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRhiSLUUUUU=
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiEgvTZWjU7Mcn0gAAsN

On Mon, Sep 22, 2025 at 08:31:56PM +0200, Rafael J. Wysocki wrote:
> What about the appended (untested) change instead?

I'm trying to address a regression with a fix to be ported for stable
kernel.  Not really sure it's a good idea to mix up with cleanup
changes.

Shawn

> 
> With a follow-up one to replace CPUFREQ_ETERNAL with something internal
> to CPPC.
> 
> ---
>  Documentation/admin-guide/pm/cpufreq.rst                  |    4 ----
>  Documentation/cpu-freq/cpu-drivers.rst                    |    3 +--
>  Documentation/translations/zh_CN/cpu-freq/cpu-drivers.rst |    3 +--
>  Documentation/translations/zh_TW/cpu-freq/cpu-drivers.rst |    3 +--
>  drivers/cpufreq/cppc_cpufreq.c                            |   14 ++++++++++++--
>  drivers/cpufreq/cpufreq-dt.c                              |    2 +-
>  drivers/cpufreq/imx6q-cpufreq.c                           |    2 +-
>  drivers/cpufreq/mediatek-cpufreq-hw.c                     |    2 +-
>  drivers/cpufreq/scmi-cpufreq.c                            |    2 +-
>  drivers/cpufreq/scpi-cpufreq.c                            |    2 +-
>  drivers/cpufreq/spear-cpufreq.c                           |    2 +-
>  include/linux/cpufreq.h                                   |    7 ++++---
>  12 files changed, 25 insertions(+), 21 deletions(-)
> 
> --- a/Documentation/admin-guide/pm/cpufreq.rst
> +++ b/Documentation/admin-guide/pm/cpufreq.rst
> @@ -274,10 +274,6 @@ are the following:
>  	The time it takes to switch the CPUs belonging to this policy from one
>  	P-state to another, in nanoseconds.
>  
> -	If unknown or if known to be so high that the scaling driver does not
> -	work with the `ondemand`_ governor, -1 (:c:macro:`CPUFREQ_ETERNAL`)
> -	will be returned by reads from this attribute.
> -
>  ``related_cpus``
>  	List of all (online and offline) CPUs belonging to this policy.
>  
> --- a/Documentation/cpu-freq/cpu-drivers.rst
> +++ b/Documentation/cpu-freq/cpu-drivers.rst
> @@ -109,8 +109,7 @@ Then, the driver must fill in the follow
>  +-----------------------------------+--------------------------------------+
>  |policy->cpuinfo.transition_latency | the time it takes on this CPU to	   |
>  |				    | switch between two frequencies in	   |
> -|				    | nanoseconds (if appropriate, else	   |
> -|				    | specify CPUFREQ_ETERNAL)		   |
> +|				    | nanoseconds                          |
>  +-----------------------------------+--------------------------------------+
>  |policy->cur			    | The current operating frequency of   |
>  |				    | this CPU (if appropriate)		   |
> --- a/Documentation/translations/zh_CN/cpu-freq/cpu-drivers.rst
> +++ b/Documentation/translations/zh_CN/cpu-freq/cpu-drivers.rst
> @@ -112,8 +112,7 @@ CPUfreq核心层注册一个cpufreq_driv
>  |                                   |                                      |
>  +-----------------------------------+--------------------------------------+
>  |policy->cpuinfo.transition_latency | CPU在两个频率之间切换所需的时间，以  |
> -|                                   | 纳秒为单位（如不适用，设定为         |
> -|                                   | CPUFREQ_ETERNAL）                    |
> +|                                   | 纳秒为单位                    |
>  |                                   |                                      |
>  +-----------------------------------+--------------------------------------+
>  |policy->cur                        | 该CPU当前的工作频率(如适用)          |
> --- a/Documentation/translations/zh_TW/cpu-freq/cpu-drivers.rst
> +++ b/Documentation/translations/zh_TW/cpu-freq/cpu-drivers.rst
> @@ -112,8 +112,7 @@ CPUfreq核心層註冊一個cpufreq_driv
>  |                                   |                                      |
>  +-----------------------------------+--------------------------------------+
>  |policy->cpuinfo.transition_latency | CPU在兩個頻率之間切換所需的時間，以  |
> -|                                   | 納秒爲單位（如不適用，設定爲         |
> -|                                   | CPUFREQ_ETERNAL）                    |
> +|                                   | 納秒爲單位                    |
>  |                                   |                                      |
>  +-----------------------------------+--------------------------------------+
>  |policy->cur                        | 該CPU當前的工作頻率(如適用)          |
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -308,6 +308,16 @@ static int cppc_verify_policy(struct cpu
>  	return 0;
>  }
>  
> +static unsigned int get_transition_latency(unsigned int cpu)
> +{
> +	unsigned int transition_latency_ns = cppc_get_transition_latency(cpu);
> +
> +	if (transition_latency_ns == CPUFREQ_ETERNAL)
> +		return CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS / NSEC_PER_USEC;
> +
> +	return transition_latency_ns / NSEC_PER_USEC;
> +}
> +
>  /*
>   * The PCC subspace describes the rate at which platform can accept commands
>   * on the shared PCC channel (including READs which do not count towards freq
> @@ -330,12 +340,12 @@ static unsigned int cppc_cpufreq_get_tra
>  			return 10000;
>  		}
>  	}
> -	return cppc_get_transition_latency(cpu) / NSEC_PER_USEC;
> +	return get_transition_latency(cpu);
>  }
>  #else
>  static unsigned int cppc_cpufreq_get_transition_delay_us(unsigned int cpu)
>  {
> -	return cppc_get_transition_latency(cpu) / NSEC_PER_USEC;
> +	return get_transition_latency(cpu);
>  }
>  #endif
>  
> --- a/drivers/cpufreq/cpufreq-dt.c
> +++ b/drivers/cpufreq/cpufreq-dt.c
> @@ -104,7 +104,7 @@ static int cpufreq_init(struct cpufreq_p
>  
>  	transition_latency = dev_pm_opp_get_max_transition_latency(cpu_dev);
>  	if (!transition_latency)
> -		transition_latency = CPUFREQ_ETERNAL;
> +		transition_latency = CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS;
>  
>  	cpumask_copy(policy->cpus, priv->cpus);
>  	policy->driver_data = priv;
> --- a/drivers/cpufreq/imx6q-cpufreq.c
> +++ b/drivers/cpufreq/imx6q-cpufreq.c
> @@ -442,7 +442,7 @@ soc_opp_out:
>  	}
>  
>  	if (of_property_read_u32(np, "clock-latency", &transition_latency))
> -		transition_latency = CPUFREQ_ETERNAL;
> +		transition_latency = CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS;
>  
>  	/*
>  	 * Calculate the ramp time for max voltage change in the
> --- a/drivers/cpufreq/mediatek-cpufreq-hw.c
> +++ b/drivers/cpufreq/mediatek-cpufreq-hw.c
> @@ -309,7 +309,7 @@ static int mtk_cpufreq_hw_cpu_init(struc
>  
>  	latency = readl_relaxed(data->reg_bases[REG_FREQ_LATENCY]) * 1000;
>  	if (!latency)
> -		latency = CPUFREQ_ETERNAL;
> +		latency = CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS;
>  
>  	policy->cpuinfo.transition_latency = latency;
>  	policy->fast_switch_possible = true;
> --- a/drivers/cpufreq/scmi-cpufreq.c
> +++ b/drivers/cpufreq/scmi-cpufreq.c
> @@ -294,7 +294,7 @@ static int scmi_cpufreq_init(struct cpuf
>  
>  	latency = perf_ops->transition_latency_get(ph, domain);
>  	if (!latency)
> -		latency = CPUFREQ_ETERNAL;
> +		latency = CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS;
>  
>  	policy->cpuinfo.transition_latency = latency;
>  
> --- a/drivers/cpufreq/scpi-cpufreq.c
> +++ b/drivers/cpufreq/scpi-cpufreq.c
> @@ -157,7 +157,7 @@ static int scpi_cpufreq_init(struct cpuf
>  
>  	latency = scpi_ops->get_transition_latency(cpu_dev);
>  	if (!latency)
> -		latency = CPUFREQ_ETERNAL;
> +		latency = CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS;
>  
>  	policy->cpuinfo.transition_latency = latency;
>  
> --- a/drivers/cpufreq/spear-cpufreq.c
> +++ b/drivers/cpufreq/spear-cpufreq.c
> @@ -182,7 +182,7 @@ static int spear_cpufreq_probe(struct pl
>  
>  	if (of_property_read_u32(np, "clock-latency",
>  				&spear_cpufreq.transition_latency))
> -		spear_cpufreq.transition_latency = CPUFREQ_ETERNAL;
> +		spear_cpufreq.transition_latency = CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS;
>  
>  	cnt = of_property_count_u32_elems(np, "cpufreq_tbl");
>  	if (cnt <= 0) {
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -26,12 +26,13 @@
>   *********************************************************************/
>  /*
>   * Frequency values here are CPU kHz
> - *
> - * Maximum transition latency is in nanoseconds - if it's unknown,
> - * CPUFREQ_ETERNAL shall be used.
>   */
>  
> +/* Represents unknown transition latency */
>  #define CPUFREQ_ETERNAL			(-1)
> +
> +#define CPUFREQ_DEFAULT_TANSITION_LATENCY_NS	NSEC_PER_MSEC
> +
>  #define CPUFREQ_NAME_LEN		16
>  /* Print length for names. Extra 1 space for accommodating '\n' in prints */
>  #define CPUFREQ_NAME_PLEN		(CPUFREQ_NAME_LEN + 1)
> 
> 
> 
> 


