Return-Path: <linux-pm+bounces-9416-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E113890C7A8
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 12:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 025181C219BB
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 10:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC97155359;
	Tue, 18 Jun 2024 09:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="h66dmzV1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2217155340;
	Tue, 18 Jun 2024 09:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718701736; cv=none; b=Kl4nuurcNFaxcfL8VbELjffEBuYibZIJ8o0Hup3DUk4e1Rr/QKv18VnleGJTjXKUyn1WKjcTeD7xPe34UgmfK3BxzLS/BX9N56MRxoJow/E+D+RmTjWjRgE5qj8Bo83E5Sj3s750TYe3HKE9oMMyIrU9M8kUo+bUl1lD4XiEmDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718701736; c=relaxed/simple;
	bh=ibg/TSn3XVuIPsjHFrVcSVX2WZYqIPpPJA8VAWqcYNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FKhsVxwoanXGF56zatS0cqqujSRa5J4kq0t2plim08s+VJ+fiU0Wqa8O/USD2VPNlRSI14WsiW4jfux4rLqOHzl+nGyC30EQIuHNYTPyVJfJgUprD/0LjjZi5e9mN0T/q3FT5uXCupJ5fzDcoIgh2TU0g4X+6sJRFNmaSDCOQHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=h66dmzV1; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C83AC40E019D;
	Tue, 18 Jun 2024 09:08:50 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id msATsPTnibFW; Tue, 18 Jun 2024 09:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1718701727; bh=jOzQmB/KDQFxLeE/zX1ETjPV0siUZZrf0fVp8n/NlKw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h66dmzV1qn+G/i4qc7WeAeYl9HfJIW8BAl9G1xdA/gFG5LoVcu9QsSjWTRvgwGDDR
	 rXMV2AhN//lqTo4r+VelXDcN+jNrsA8FQOMthFaH8v1Ii79XLFDviHQRs0LGDm61In
	 IpMrVJ+rgL6I18mL3EtSSqYJOXI0qP8Jl6ttUy8SG0abYn3C6/4+ACbWnexSxH7Y2/
	 3v44WjbB1esAJ8sle3YVPlzOzZr8EaTjMHFPyAib7e6/AYTWr89XAAuaQUpRMuHIt6
	 NdreXYodu7QnZAOcahNifRF7h1oKyotUWV1TRZQjEbTPC2xu67XsT9CoUoHdflkTCT
	 mtEF94uoHHQpg5eON/SPDfRXL8sEjAwValc61xK37/EwLRlKKRunHwl/a4HNTnCnXn
	 SYK4HmPFyiTx9HF8/7vmIQUt4IXGHjHR9O+/hwkhqkHOI7mEbIf6skA43/yvnkWGlU
	 vf/1Q1YzWa54hjl0d8xbNCRKQTrd8iC2N+MpheOMb54Up4b95jMLEKyASPXDoV9irB
	 jDpb5nO9mXmLnleQBsu/xLc5905//v70HzODZfxUXDY9FOvHZWb7TttJ+QT6sVv/kT
	 YFrt0ncO+n+D1KmZJVXy/xHSOeFqvVJd/tf01d8pBbCE4G+Vsf4flPRLjowj6Hx+8d
	 ceK52TQo0KL/+8TakWOGB8Y4=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8F90F40E0219;
	Tue, 18 Jun 2024 09:08:37 +0000 (UTC)
Date: Tue, 18 Jun 2024 11:08:36 +0200
From: Borislav Petkov <bp@alien8.de>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, tglx@linutronix.de,
	mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH 2/2] cpufreq: intel_pstate: Support highest performance
 change interrupt
Message-ID: <20240618090836.GBZnFOlFurqQiLeI7a@fat_crate.local>
References: <20240618035122.438822-1-srinivas.pandruvada@linux.intel.com>
 <20240618035122.438822-3-srinivas.pandruvada@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240618035122.438822-3-srinivas.pandruvada@linux.intel.com>

On Mon, Jun 17, 2024 at 08:51:21PM -0700, Srinivas Pandruvada wrote:
> +	status_mask = HWP_GUARANTEED_PERF_CHANGE_STATUS;
> +	if (boot_cpu_has(X86_FEATURE_HWP_HIGHEST_PERF_CHANGE))

s/boot_cpu_has/cpu_feature_enabled/g

> +		status_mask |= HWP_HIGHEST_PERF_CHANGE_STATUS;
> +
>  	rdmsrl_safe(MSR_HWP_STATUS, &value);
> -	if (!(value & 0x01))
> +	if (!(value & status_mask))
>  		return;
>  
>  	spin_lock_irqsave(&hwp_notify_lock, flags);
> @@ -1668,17 +1675,25 @@ static void intel_pstate_disable_hwp_interrupt(struct cpudata *cpudata)
>  		cancel_delayed_work_sync(&cpudata->hwp_notify_work);
>  }
>  
> +#define HWP_GUARANTEED_PERF_CHANGE_REQ BIT(0)
> +#define HWP_HIGHEST_PERF_CHANGE_REQ    BIT(2)
> +
>  static void intel_pstate_enable_hwp_interrupt(struct cpudata *cpudata)
>  {
> -	/* Enable HWP notification interrupt for guaranteed performance change */
> +	/* Enable HWP notification interrupt for performance change */
>  	if (boot_cpu_has(X86_FEATURE_HWP_NOTIFY)) {
> +		u64 interrupt_mask = HWP_GUARANTEED_PERF_CHANGE_REQ;
> +
>  		spin_lock_irq(&hwp_notify_lock);
>  		INIT_DELAYED_WORK(&cpudata->hwp_notify_work, intel_pstate_notify_work);
>  		cpumask_set_cpu(cpudata->cpu, &hwp_intr_enable_mask);
>  		spin_unlock_irq(&hwp_notify_lock);
>  
> +		if (boot_cpu_has(X86_FEATURE_HWP_HIGHEST_PERF_CHANGE))a

Ditto.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

