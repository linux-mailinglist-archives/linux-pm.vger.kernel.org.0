Return-Path: <linux-pm+bounces-41065-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 92435D39DDB
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 06:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2B8F300A354
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 05:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FADA33032C;
	Mon, 19 Jan 2026 05:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aN32r5M0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC591C7012
	for <linux-pm@vger.kernel.org>; Mon, 19 Jan 2026 05:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768801072; cv=none; b=SU1/fzIG0gEEZHit6KhgldWQaTNBMw2aS0Zq/533rABkoTecylootdyl0x0GuHeOZ/yh6KJxJjhnrDEgG8tdMndC74uzjwfCssG6PhprtbX2byudvXhPal+pvTcfWEELD5fFzuETdXvfc5bqSSOziBhvxV4geo2ZV3zmTo7b/kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768801072; c=relaxed/simple;
	bh=kpZ6kpUv/7LKQiaUs7sFoIfYQd0e2AXe/uijT3vOfW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TEHALItCSqUsVscSa1xAfQnsGmE94wLoqOh1sSqydN16L5lAVAkdGU8sGnNsqj0Rtwa+Vkk/3lN64F12eo3aXrA717qyh6sDGjvg1/CPmJR5VM7VG52Gi7sHzRyS8zgNVQ5ONhrB3m8oBJPtLSFPSvBkeI0epT/FfEMnBTEKoeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aN32r5M0; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a1022dda33so23609145ad.2
        for <linux-pm@vger.kernel.org>; Sun, 18 Jan 2026 21:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768801070; x=1769405870; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rV07savPRO0IKbzKw21+aHwR+cCqLisS1/gIxq8rFVs=;
        b=aN32r5M0+IYay5flQUpiovdjwzlOwX4ikkWLriAJV5DLlcr7Th5sxrXH+SLd2l40YE
         4j27zrpyKMso/mYQch954DuE9KUOlNTNUU5J7UiUvUEeyFzIw1fND1KzwVuK+W/BiyY6
         KisfHfjJaPn7l99XX0UIkWgZT9rBOqDCiLF64k5hnxGXW1ZS++lC0cfM00gcL4JjQVko
         RwY3kNa9F02BX37gxGKUSAP6uTcL+eEDc+AnMxz+tDXTzEk4NgHcaBZgTWMc2M978bRU
         hr7FqIzuedrjPNZE3OLHJy726Ncr0aPTr7GuVZLlsLUS06dIFdXGgMgFw9LNMHKqztNm
         gXKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768801070; x=1769405870;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rV07savPRO0IKbzKw21+aHwR+cCqLisS1/gIxq8rFVs=;
        b=vnrVrgHb2mdHbEPjTXnjR9u9hZV5g4+cmkzcZqT+m9Qz8nFF2ZaVvGnFSoR5NuPXbA
         tN99CZveDTzecWayBmX6+zk4o0/8Nio57G4psehITuBGSqXT35zUUQrWUz6oB2ljWh2F
         rbkoODFDn7KSdD+IDiO5ULmqCySx0JytZlUgXQ4NYLbNVhf4k4WwEIVbUtUdACYpG8hP
         ifig5q9FmLgB9SOGSActEQdvBy3TyCKWNbWl5XvATQFrhzFzLznEtFIfZQWueOjPm8AC
         sD8XrfJ/HGsNHmSxikgis8/3YaB9zlWtJn4GKaljaJQB906MSz+CC7c1eebyJxo5326m
         Fy7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWXxNiqLWla28oWiJPk/uEDi6Z3LdxHa6Xk9RQ9mz8h/dxrgNX4XRp640TVsig3Uxc8e2NOCpL5wQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu3tP54OmLb4wYOdIjd9ayXQ7c4uSfQVSjf7bsJl15ixtMq5QJ
	3D4lv9Z7V1OkCfVTME0zwG1fCqeJUc47B88TfXDGQbxfrtK4smNdVhphhdqJsQZIZ6A=
X-Gm-Gg: AZuq6aISLafP9wHokBLF+OcXx4BFHDQnXiwT3bm3ME/3mHMCTn1YtxG0XxocAdw0JJt
	h1/8tZMKwos55rukL/OIFx3GPBkW3unJB3kiyZgbmwIkMnvWVgKdUQEekXMvDPL+tywHQKJfqbR
	nO0pJSYZaUKjWKYO+uXou6/IIWJODOHn7k5WMd3w5SQQgSjuO6dwUmiUgWY+eCKYgrY2OC2MY7T
	+NPvakSXykHEc4SLp4IxX1LxgQEVsqyKdRLBbKjiaN0xnRn47OU1XljcTprnr5p2kNbFgHunLZ1
	vaCZUgI5M/5XMLdTggV/Mkf+hWItr0AUcsZFKRVejLceniRUesR5ZtxnVmQnHO6gUG9hWa9ENYQ
	+Pys6MuOKXWQTKSZPmtYgIjHXqsFehXy5ar0Iv+RX8NjMiR58Oxr2V4W3D1tPOBCPz4TzXC2+76
	O3O2wL2Zls4Ak=
X-Received: by 2002:a17:903:28d:b0:298:efa:511f with SMTP id d9443c01a7336-2a7176c5c7amr104119265ad.39.1768801070083;
        Sun, 18 Jan 2026 21:37:50 -0800 (PST)
Received: from localhost ([122.172.80.63])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7190eee4fsm81033725ad.42.2026.01.18.21.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 21:37:49 -0800 (PST)
Date: Mon, 19 Jan 2026 11:07:47 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Ben Segall <bsegall@google.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Kieran Bingham <kbingham@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Mel Gorman <mgorman@suse.de>, 
	Michael Ellerman <mpe@ellerman.id.au>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Nicholas Piggin <npiggin@gmail.com>, "Paul E . McKenney" <paulmck@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Uladzislau Rezki <urezki@gmail.com>, Valentin Schneider <vschneid@redhat.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Xin Zhao <jackzxcui1989@163.com>, linux-pm@vger.kernel.org, linux-s390@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 07/15] cpufreq: ondemand: Simplify idle cputime
 granularity test
Message-ID: <rnnx7nges4otjixz4n62q7vtgrdcphepbkpmdntupbdft2yvi7@b3ong66tikoh>
References: <20260116145208.87445-1-frederic@kernel.org>
 <20260116145208.87445-8-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116145208.87445-8-frederic@kernel.org>

On 16-01-26, 15:52, Frederic Weisbecker wrote:
> cpufreq calls get_cpu_idle_time_us() just to know if idle cputime
> accounting has a nanoseconds granularity.
> 
> Use the appropriate indicator instead to make that deduction.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  drivers/cpufreq/cpufreq_ondemand.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
> index a6ecc203f7b7..2d52ee035702 100644
> --- a/drivers/cpufreq/cpufreq_ondemand.c
> +++ b/drivers/cpufreq/cpufreq_ondemand.c
> @@ -334,17 +334,12 @@ static void od_free(struct policy_dbs_info *policy_dbs)
>  static int od_init(struct dbs_data *dbs_data)
>  {
>  	struct od_dbs_tuners *tuners;
> -	u64 idle_time;
> -	int cpu;
>  
>  	tuners = kzalloc(sizeof(*tuners), GFP_KERNEL);
>  	if (!tuners)
>  		return -ENOMEM;
>  
> -	cpu = get_cpu();
> -	idle_time = get_cpu_idle_time_us(cpu, NULL);
> -	put_cpu();
> -	if (idle_time != -1ULL) {
> +	if (tick_nohz_enabled) {
>  		/* Idle micro accounting is supported. Use finer thresholds */
>  		dbs_data->up_threshold = MICRO_FREQUENCY_UP_THRESHOLD;
>  	} else {

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

