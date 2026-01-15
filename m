Return-Path: <linux-pm+bounces-40899-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3501D225CD
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jan 2026 05:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0FE1C301D644
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jan 2026 04:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784722C15A9;
	Thu, 15 Jan 2026 04:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rC4GMEL6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EF02857CD
	for <linux-pm@vger.kernel.org>; Thu, 15 Jan 2026 04:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768450464; cv=none; b=ZkmGdpYVIlOBAYTksKCtn2IOT0pVXxJfCHellUH5ixRlijZu7SvjpmCYaBSwJGoA3CyZ9FLh2sbEWMco/8Zh4F5zrzshHcqXraEtqkhIe8ldoiwl4k9RokrAPZ0KH/syYahaAMNsyCjD4mJdzGqPWnsngnGKkMtE4hwI8O42Pm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768450464; c=relaxed/simple;
	bh=iQXAcib2oRD600WPIfM+1RfvWKx32iOPMF/YK+XRJ64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SeiI9UzrkxvXZ+pCrSkZNWRm0/pVyrgXRhpBBEw1rh6LqU+hulZHoirdMotYbOkHci9auAW3mdvXhn2DqzfgESHb3oMwSnXse1OAtZk+alVOFGHGc/2YhyaUDcoYRreNqZSWxiY+Tt/L43rbmpiAgnMTHqJGQ3TbvPh4ozrhEqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rC4GMEL6; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2a0fe77d141so3937505ad.1
        for <linux-pm@vger.kernel.org>; Wed, 14 Jan 2026 20:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768450462; x=1769055262; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ttW/0VPnzpmGU5Uwq1WgWZISL693I/ws1/HEZYT9FVc=;
        b=rC4GMEL6ULZlhjo27obeCMRfycHfYMd78bh8RyHKikAhFBNAgK69UFyq1raK8TWhQf
         ZwAUVpboXaLmO8/ZaRM0oRhUR1bwO6+ZuFKP80kJAoUkFkVR+nxGwhQ8dhtj7LezJYXZ
         3zEaoynd3qXgKII0+JwudoxcIGFR13AOK7leLT3OISvGxCq2wSNcPQTwkZHbZhPhp1yI
         tPCO/nxZPJwEL2pWx4KyDHWxG7de4x8vBykBgW/b8XBAYwywIqpC0uO0E2GCw7gquUHx
         C8fSOWf7TQiU/8aP7Yi4gMp21baY4DeplqJeMXJx5fxrlrOeOSNeVF/Abfi4LnPB8Iim
         VX8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768450462; x=1769055262;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ttW/0VPnzpmGU5Uwq1WgWZISL693I/ws1/HEZYT9FVc=;
        b=KlOw5E5AXMxjvCLa0xeu/H+fiJFOvnCMYxITpvSyEfNyERHIvI/A1EY8B7Is6tL77j
         HoghtHmWgtujk+pbkf5Uw5kpnW6wa4GPJXFkdVY59DvkNNSlTJmwcgqCXypVieYsrmbT
         fjx+br915ORsDLdZHCKc1sfDB5WiHMiFgneRjd/H8U0kFD1p1vCZ8rcEU0lXiQY7cIOd
         GyDoAOZtJveJp20f8pcZ0X3wOQBfRBONPzSXuacUmiNZus66hncNhTU6mTT/JyY3TQtS
         FdI0SIRYpMCEHk2uyOpE3bvARXrDK7kNl++P/GBDzOqNN98mfrxqEYmt0NrSOtIgyrkZ
         uS7A==
X-Forwarded-Encrypted: i=1; AJvYcCVqJ87489VMFsEMiIA+dmhm4k2vy6ImWLUyzAm2ce/wkfotTK3LYqDPja0nz3G/luk/XPvkduAbyg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzIHN3lAP/MssWqLPcHPhObHxZJ+P5TyzSGaXas85MBicdW0TTD
	/exRNrHe5aqkBfQdzp4Ptw7KO+WBX7pvMwtQXU4SiQWjWALnezmPevlupTvEFpP1iMk=
X-Gm-Gg: AY/fxX4fWmZds4cf20cvOiy+x4RTKTdBDSN0pzJgGmOMR2xiL2678FD7fnf17FnYcVN
	FXvo9hyMA001GMl/BndqOcuLMkiPcdS69VmPhnXFFWp3kIeUYPM/bodDCasVCDYRiUWC45gjR7c
	pXg/r+Ibko5Ah8Eiciy+SEeWLhysxScIyTHE3MksQnlMZsaqMB7wP+G5SChEcnMuIW8W/zbo3Cg
	NlBMjfYSG38ybxlXNe1zJBXlAieZ5lkvM+TdqwihRzzmBtPQqmxg8AcUKZ1FnAsBu2Z0Podgh2R
	Q3A/NboRHNmt+4qof/WPpHXD6jBFQuRlRyaKFf8e2NMqe8EAFQYY5lMUikk/gDJQcBjf88vgEJq
	A1aQ/0lXlNPKuQh+mZ0b6RpYKHLRj1ERQouhHjQVjw+FAmZx/gYfDh85LRagXr5fCU1NvgWp66C
	DkuBx0FsV3flg=
X-Received: by 2002:a17:903:189:b0:298:4ee2:19f3 with SMTP id d9443c01a7336-2a599e51d5fmr51014125ad.49.1768450462206;
        Wed, 14 Jan 2026 20:14:22 -0800 (PST)
Received: from localhost ([122.172.80.63])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cb2d6csm242276725ad.64.2026.01.14.20.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 20:14:21 -0800 (PST)
Date: Thu, 15 Jan 2026 09:44:19 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Huang Rui <ray.huang@amd.com>, 
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Len Brown <lenb@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, Bert Karwatzki <spasswolf@web.de>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, Perry Yuan <perry.yuan@amd.com>
Subject: Re: [PATCH v2 2/2] cpufreq: Pass the policy to
 cpufreq_driver->adjust_perf()
Message-ID: <bqvpt465nowq3jipfsciaoafjpjhu42l63vi6p67qscwx5oil4@t2tkh2u5giuy>
References: <20260114085113.21378-1-kprateek.nayak@amd.com>
 <20260114085113.21378-3-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114085113.21378-3-kprateek.nayak@amd.com>

On 14-01-26, 08:51, K Prateek Nayak wrote:
> cpufreq_cpu_get() can sleep on PREEMPT_RT in presence of concurrent
> writer(s), however amd-pstate depends on fetching the cpudata via the
> policy's driver data which necessitates grabbing the reference.
> 
> Since schedutil governor can call "cpufreq_driver->update_perf()"
> during sched_tick/enqueue/dequeue with rq_lock held and IRQs disabled,
> fetching the policy object using the cpufreq_cpu_get() helper in the
> scheduler fast-path leads to "BUG: scheduling while atomic" on
> PREEMPT_RT [1].
> 
> Pass the cached cpufreq policy object in sg_policy to the update_perf()
> instead of just the CPU. The CPU can be inferred using "policy->cpu".
> 
> The lifetime of cpufreq_policy object outlasts that of the governor and
> the cpufreq driver (allocated when the CPU is onlined and only reclaimed
> when the CPU is offlined / the CPU device is removed) which makes it
> safe to be referenced throughout the governor's lifetime.
> 
> Reported-by: Bert Karwatzki <spasswolf@web.de>
> Closes:https://lore.kernel.org/all/20250731092316.3191-1-spasswolf@web.de/ [1]
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>

Ahh, you need to fix the Rust binding as well. Minor change there.

-- 
viresh

