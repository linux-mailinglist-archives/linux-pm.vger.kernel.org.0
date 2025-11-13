Return-Path: <linux-pm+bounces-37912-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7ADC55F82
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 07:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A40F24E33C1
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 06:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C41F321456;
	Thu, 13 Nov 2025 06:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t0CLmSqu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A107D320A24
	for <linux-pm@vger.kernel.org>; Thu, 13 Nov 2025 06:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763016303; cv=none; b=Wq9LJ1D26/mcSd1Q0JGf17ZBVxcY4rnWhOHgDnEXqFdh/I5kxzGZNlGZMdnc0hkaQrnHUiBTAFDJ+eqTiOy5Bl9twVHhkQHXQhzMBEHqkMoXMzINFqZwofcr6oHlwFOys8rtBIQiggCd2LrXSEIBbSBsdTyBueSQ94kGLTx13tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763016303; c=relaxed/simple;
	bh=zW0U/Jj9Zj5cp+rpQ/nb/eNOgY0kP5K/zUMpKvWQ5VY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pAJkjONfFCk6lWs4mq4wfvTDiNL5A9Bp7lEg5mvb6xwp/kMy5KIHTmexQGKTeebZDuefISs0WOY5icOelvhBbgmRxmfedogUf0sipOoIwBbQIm2pAI0cok7H3oVDl31Nt9+9N1odlUA4JbMg8Ln+zWMhoaF2Ab71pe3Va5IRZ3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t0CLmSqu; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7b852bb31d9so526639b3a.0
        for <linux-pm@vger.kernel.org>; Wed, 12 Nov 2025 22:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763016300; x=1763621100; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TNrsYC8dvbwkQ0q38sJTUQW/VSDJEZpXwI2c7yivRYY=;
        b=t0CLmSqu4ffwnPQ+SDa6MBbM8gxpaZrCgkTr9I5CJJd/J1XhteI4XZ/+k78ZhMpZvn
         XV2wDgApqtAxc0e/Q78cGSpmBk6xdRjX42mcEy9k0mesoe5oexQR3sZZAwk4ffx0eVkA
         ef1WmUpEdGubidEDPTLiXWD6hOcOexkspSH5FzyNalJiE2sB70HmBtHZXlarFBiDnQ3U
         WZtphv6LBBovuTEBBGhh5Rf1RXc/eoPRhEcfYoPhCaKAE2LOM8EjkzBz4GqvZodbplGg
         b3FJMG6/OiYMbKNG8Ft89XlYouuwcwlEhwOunbhNWSrRwcaGOP9bAsrCBkS0V9eFlYdw
         i/iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763016300; x=1763621100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TNrsYC8dvbwkQ0q38sJTUQW/VSDJEZpXwI2c7yivRYY=;
        b=AY1xbv/DRsqQM099BiFm2k5+PdhFxIHFJgTtN3ZGvfwmZYiPyJ4HB+j4/uuQaA+P1a
         2LPn0HrneFGwvXlq/KjjOFqMCGZ3riu5ifKYdBQir+OIZONymMcGb70R6qjnrxc2+nKZ
         40Ao8mIzhxyajhsEsOOBUhG1gJ4RqTqckhpOs1flp4U5pHP3rMZaRyaKrWbn3X1+J392
         +A56x2jhOUaIy+Ui8n5bWDvw1013yiec9VD+veHMQJpGcSIR//nFOmIOUCMRyIlkLGV6
         4SNirk+KUNCy5k8o1E5w2I7A5vTVfknWISyLCf5ImwvjopQtnT93jg3CAor20pPLwyrW
         eQPA==
X-Forwarded-Encrypted: i=1; AJvYcCWOfKIjv7ZggTEJ+TsedXqd3Sa5JrGV1COL+lgCnW0KOVzjaEdG1pxPYBiWACkQkTNM2MkqfnH2VQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwC/OKWS6ta2c9/h/516XBQUxG9nS6mL64RsYVizTQpsZyzi8lv
	iD9uTRilpAZ7LISYROE/NcbapkOaXzinyuefOoQE4dFQ8PqLaArji07FvTYrf1L6P5Q=
X-Gm-Gg: ASbGncsRSHj42WUK5zq/JjMFxbf/99559ZK8DFsHJaWoIb8auwwZF42KbM7/QfoPzwn
	x7OboypKMrQGbWhTE6DK5vkfztVIK4a2ed8muz7lLfMb6b85bFlmwo7j7ChWPYjgEEwZOMnrys/
	ffzGgc2damj8E9TnndXHkmuQ7QyQwxl60/CLZvFWBkCpffrKV5Lot9ZgpctpQtPc2DwToFiDNEC
	c+qKN1Wkuk1rZVmxOOIcjEpKEeQmqXExBH5N39qFDEEBb9joYrDAY3rsNGyc59fJqxR5idyLq6Z
	b+Fe29EwZpnSrIVbXWoIPGklF5peJv6TbocXTDKesQirLO6rmy5RdBX0O+hMcMp9D+xUCTQXxs4
	Df8+jEZYEOEpaP3N5t2Oaea6hZnvnGjNv4jV6QzW2qso/KoiEY/1lb+ALU4+pIbPGKnU34uoBC+
	LC
X-Google-Smtp-Source: AGHT+IG/YrAEmV2pNfg3Yz0x5My5Rp1QA12LboDz6ew0EMfuz/CKACL8CP3RpYoJ2sNr09LmKQyELg==
X-Received: by 2002:a05:6a00:3a0f:b0:7ab:a41:2874 with SMTP id d2e1a72fcca58-7b7a2d91dcdmr6725319b3a.10.1763016299642;
        Wed, 12 Nov 2025 22:44:59 -0800 (PST)
Received: from localhost ([122.172.86.94])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b927151380sm1099354b3a.38.2025.11.12.22.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 22:44:59 -0800 (PST)
Date: Thu, 13 Nov 2025 12:14:56 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Samuel Wu <wusamuel@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, kernel-team@android.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v1] cpufreq: Add policy_frequency trace event
Message-ID: <hslbhy6btkbpsgriafvdq4ligq7vorwcpffaakinqoieroopur@beyq5ouauscf>
References: <20251112235154.2974902-1-wusamuel@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112235154.2974902-1-wusamuel@google.com>

On 12-11-25, 15:51, Samuel Wu wrote:
> The existing cpu_frequency trace_event can be verbose, emitting an event
> for every CPU in the policy even when their frequencies are identical.
> 
> This patch adds a new policy_frequency trace event, which provides a
> more efficient alternative to cpu_frequency trace event. This option
> allows users who only need frequency at a policy level more concise logs
> with simpler analysis.
> 
> Signed-off-by: Samuel Wu <wusamuel@google.com>
> ---
>  drivers/cpufreq/cpufreq.c    |  2 ++
>  include/trace/events/power.h | 21 +++++++++++++++++++++
>  2 files changed, 23 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 4472bb1ec83c..b65534a4fd9a 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -345,6 +345,7 @@ static void cpufreq_notify_transition(struct cpufreq_policy *policy,
>  		pr_debug("FREQ: %u - CPUs: %*pbl\n", freqs->new,
>  			 cpumask_pr_args(policy->cpus));
>  
> +		trace_policy_frequency(freqs->new, policy->cpu);
>  		for_each_cpu(cpu, policy->cpus)
>  			trace_cpu_frequency(freqs->new, cpu);

I don't see much value in almost duplicate trace events. If we feel that a
per-policy event is a better fit (which makes sens), then we can just drop the
trace_cpu_frequency() events and print policy->cpus (or related_cpus)
information along with the per-policy events.

-- 
viresh

