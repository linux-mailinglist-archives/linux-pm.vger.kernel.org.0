Return-Path: <linux-pm+bounces-33198-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B787BB3848E
	for <lists+linux-pm@lfdr.de>; Wed, 27 Aug 2025 16:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 195F77A568E
	for <lists+linux-pm@lfdr.de>; Wed, 27 Aug 2025 14:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E31635A2BF;
	Wed, 27 Aug 2025 14:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dWTiy0/i"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65A135A29C
	for <linux-pm@vger.kernel.org>; Wed, 27 Aug 2025 14:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756303996; cv=none; b=fH9Aj1MQP8TNtgkXnjVFPsEMkHLDf2dDePw8eliaw+dz9zZYl3JRGDAAJnOIZrJClSWEzWseYqXEqaobgi1WTJaeC9Di+YAPGuV4Nu1TdPf7CQ7CkUKSajNRlOoSy9sCtRWY+0aqF/xxgF9ghk/Zbt765H5A0bMJ8GhloI9aLlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756303996; c=relaxed/simple;
	bh=DbwcQqcSgOgf9ZSwsPbdu37ylfuV2VigX8RYWvus3Uo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ja5Yg71Csr01MH4mUbiOXjkILxbZ1E1GjT8hsI1JBpcvexOpZSolmuFqWaLS/wPFv6i4nSqiOmueBGRKlW3rTDjBYPZ5jDLUZFCCaKzbR8zr4wyhBwyd2IPgSr3ix+c62noHDGZY4Xzq4jBB61TaY8A1AU9V7HPb+SP3pKIfFn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dWTiy0/i; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-24636484391so59558415ad.3
        for <linux-pm@vger.kernel.org>; Wed, 27 Aug 2025 07:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756303993; x=1756908793; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oT9Qx0pL0526DK73EqyoLYw0wsYmSjn2bOtkKWj9+LI=;
        b=dWTiy0/irckCaQzk1WuEdn1/rIGs7BUH5HtaVC4UoJeOx0TpCeqeE6kk77pxAcqrnj
         8LojKUuALAEpPlTJymXuhPzon4uOCNgzVgt0TkOgA6Z6gJ5ao7qNO5a0VaRMShCbvqEb
         7Z62nl5DvJ20RiK5OTGZ86B3DOv8vFnsYY+sJzLivJ/iGpVMmBOsweBiRfyJ/72qPJCX
         PwBUcRJOon6Uj9jfopwF3gsWHxnnuYseo58d2oMPKXgA5TBeCfN+sZsEs6MYpfkwete7
         EjDMl/KFvG2qvR/qwNw21N6nT6u+87ofdLzjCfMKz7iNC8r3Su2x+Dx8A/RBkzH8CXtw
         fv/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756303993; x=1756908793;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oT9Qx0pL0526DK73EqyoLYw0wsYmSjn2bOtkKWj9+LI=;
        b=AbmOfy6q5P0L8sDj1PW98CMxNgjU7NOlYNRO919dstoPhvRCbEoFaaTWlPQOWcx34p
         +lXTaB+P3oNhcBYEhcPWMgd/s+His/blLxUdi2dfk7Lca3sfBQ2XhV5ZzXegYJfk06wR
         x1KAYkTsAJ0bICgTVlQxj0l46cbrfsGk7dgZriECjTI/PGhnZzWtX6QH7AE749sRDINK
         Mn3CB4eOMRqL+E9tCYLq01M9TmUkqR/b5afokLy41u/FzJqhFhB5HOaFP5/ob1idY3Z1
         Ky5DsMhaIcZ8/5Sw8DRl0gv86Oi9p+4YQahmBSLdaDwzr0BMUZGbGBxhAElS7w/87pgQ
         MW8A==
X-Forwarded-Encrypted: i=1; AJvYcCUsVLFPNnW19eZj421dRR/URfHKlgAjq03+7yb4bACRQ/bLKQHO1FWfRZ7IWsbwh+XlSdL720enBA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj50VN8SB/+wl54PEX600XUHyRxMTeCEqwfov721Bzfm+ikOvr
	C/LkSyxSc2Iho/aZLnt1ys+nR8BfQ2Rkgwtv4KT0HIIzPo1RwDi2IZGpHuDEVbQiKGygtkW7Zix
	dD0ifWQ==
X-Google-Smtp-Source: AGHT+IGTSg2J3odWqRi5DzWDmdBYNRXtpWLMNIy0mlgNYPFM/YLwHCJkE7ruCavXPIcZq+6RDeJTdDhPxa4=
X-Received: from plan10.prod.google.com ([2002:a17:903:404a:b0:248:7792:b8da])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1a8e:b0:246:620:a0b9
 with SMTP id d9443c01a7336-2462efcaaa3mr229124795ad.61.1756303993097; Wed, 27
 Aug 2025 07:13:13 -0700 (PDT)
Date: Wed, 27 Aug 2025 07:13:11 -0700
In-Reply-To: <20250827023202.10310-3-zhangzihuan@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250827023202.10310-1-zhangzihuan@kylinos.cn> <20250827023202.10310-3-zhangzihuan@kylinos.cn>
Message-ID: <aK8Sd30K64mbN1Nt@google.com>
Subject: Re: [PATCH v2 02/18] KVM: x86: Use __free(put_cpufreq_policy) for
 policy reference
From: Sean Christopherson <seanjc@google.com>
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: "Rafael J . wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Markus Mayer <mmayer@broadcom.com>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, 
	Chanwoo Choi <cw00.choi@samsung.com>, Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, 
	Eduardo Valentin <edubezval@gmail.com>, Keerthy <j-keerthy@ti.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	zhenglifeng <zhenglifeng1@huawei.com>, "H . Peter Anvin" <hpa@zytor.com>, Zhang Rui <rui.zhang@intel.com>, 
	Len Brown <lenb@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Lukasz Luba <lukasz.luba@arm.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Beata Michalska <beata.michalska@arm.com>, 
	Fabio Estevam <festevam@gmail.com>, Pavel Machek <pavel@kernel.org>, Sumit Gupta <sumitg@nvidia.com>, 
	Prasanna Kumar T S M <ptsm@linux.microsoft.com>, Sudeep Holla <sudeep.holla@arm.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, linux-pm@vger.kernel.org, x86@kernel.org, 
	kvm@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-samsung-soc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org, 
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	imx@lists.linux.dev, linux-omap@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Aug 27, 2025, Zihuan Zhang wrote:
> Replace the manual cpufreq_cpu_put() with __free(put_cpufreq_policy)
> annotation for policy references. This reduces the risk of reference
> counting mistakes and aligns the code with the latest kernel style.
> 
> No functional change intended.
> 
> Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
> ---
>  arch/x86/kvm/x86.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index a1c49bc681c4..2a825f4ec701 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -9492,16 +9492,14 @@ static void kvm_timer_init(void)
>  		max_tsc_khz = tsc_khz;
>  
>  		if (IS_ENABLED(CONFIG_CPU_FREQ)) {
> -			struct cpufreq_policy *policy;
> +			struct cpufreq_policy *policy __free(put_cpufreq_policy);
>  			int cpu;
>  
>  			cpu = get_cpu();
>  			policy = cpufreq_cpu_get(cpu);
> -			if (policy) {
> -				if (policy->cpuinfo.max_freq)
> -					max_tsc_khz = policy->cpuinfo.max_freq;
> -				cpufreq_cpu_put(policy);
> -			}
> +			if (policy && policy->cpuinfo.max_freq)
> +				max_tsc_khz = policy->cpuinfo.max_freq;
> +
>  			put_cpu();

Hmm, this is technically buggy.  __free() won't invoke put_cpufreq_policy() until
policy goes out of scope, and so using __free() means the code is effectively:

		if (IS_ENABLED(CONFIG_CPU_FREQ)) {
			struct cpufreq_policy *policy;
			int cpu;

			cpu = get_cpu();
			policy = cpufreq_cpu_get(cpu);
			if (policy && policy->cpuinfo.max_freq)
				max_tsc_khz = policy->cpuinfo.max_freq;
			put_cpu();

			if (policy)
				cpufreq_cpu_put(policy);
		}

That's "fine" because the policy isn't truly referenced after preemption is
disabled, the lifecycle of the policy doesn't rely on preemption being disabled,
and KVM doesn't actually care which CPU is used to get the max frequency, i.e.
this would technically be "fine" too:

		if (IS_ENABLED(CONFIG_CPU_FREQ)) {
			struct cpufreq_policy *policy;
			int cpu;

			cpu = get_cpu();
			policy = cpufreq_cpu_get(cpu);
			put_cpu();

			if (policy && policy->cpuinfo.max_freq)
				max_tsc_khz = policy->cpuinfo.max_freq;

			if (policy)
				cpufreq_cpu_put(policy);
		}

But given that the code we have today is perfectly readable, I don't see any
reason to switch to __free() given that's it's technically flawed.  So I'm very
strongly inclined to skip this patch and keep things as-is.

