Return-Path: <linux-pm+bounces-25057-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9695BA8360C
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 03:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9362819E838A
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 01:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399C81E5B62;
	Thu, 10 Apr 2025 01:49:58 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6568B1E47A8;
	Thu, 10 Apr 2025 01:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744249798; cv=none; b=AZnqXDUJZV3Ku9U0bOBpHDMBMBsPvoSWtD2gbObpfTvqCSl5HqvlNe9L/YjzFzZIlxuC48rJRavUN4ftYt+canihwx7Q1wm+IoXGHHvAc3+Aku5BlqbAtR8iUt5nZVCVmM7CDPFWNZhjNc77nIxtZ/V/e+6E0HTG7YOe2jFb3r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744249798; c=relaxed/simple;
	bh=TRieDUtur6tqD7TIt0P1Qte9Dz0Gk6EhBPkKkaNJCY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eUr06jejQ+g7dGhPrZNGgBhNujyW9htiVxUvlF/yOLV62OOIhR1GyBKDpE7qGKgh4CLpoWk8Dwc6HNtf6daWrA7uzQd3QeH/0krGdBQnkZW2G4nLogGKYZXmLAH9Pqp0Nx0vbL0jz6OlAH9Bpq/2RvYdJRUPB5eV0nlafktcM0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kerneltoast.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kerneltoast.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-224171d6826so3725765ad.3;
        Wed, 09 Apr 2025 18:49:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744249796; x=1744854596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f7dWhYptZ9ctxRSNQwcxIzgQIhmZf3lcZn2X/1Zf550=;
        b=KYIcvJMJE+Lh2MhmMetsahNWQofPaR6y5+pAOKrDjzUfESP48YCc1UIa7RmvXwWj/5
         ZatiD44/b4dH6I3vrFrKKoyAANM39KEEcRBStSRj5cfxdSwXDrqj2TTTIsUO2kVUhUcV
         +xPvNVCScVtyMv8txrznHZ2ioPXcMz6eP9pgGfz3ykUPlkPPF2OIluLhcJNp0KBACIwe
         gTvJWFDQZfwOy1EGecNMUa0BKPGDbPIe0THyAHYBwVVOl1h1ny4yQNbHa2OmIpv0INHz
         QqRNuvZ2HFWulVH+KbgVRHby1aOo7YbdfCGBDISfzME71r6zEXBzg9bAWkUmtsGL+Mu2
         zoJw==
X-Forwarded-Encrypted: i=1; AJvYcCVUMtikCPoL4PqUyX2ZjckvaGFWSSBVGisKkHFi3rS8qoWnPnzF1sCmFjANAZD0lc35vR9M4XJzWks=@vger.kernel.org, AJvYcCX43T+XozMUEC2biTKrZqAClIBjHepOF+hqdcOsyurWLA/t9Wu/9pYLEfzVR1Bc9z4wCbaSmryG1gHE/xg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz26gaqtn4zGCpP0s5ccMQIAKrG8obLf65sLUb7CEiMbrHCk7tP
	Dq8CzQ020iyIoe5++50YXI/u/WYSBuQYT6jsdpDUOmoQ4LBigPem
X-Gm-Gg: ASbGncuyv9ItnO7LdX7qpHUsywVR0s2MPsTi9DDOs6PJCogzvpITZyf7dabC2WXxLNQ
	CMhNGTEa9rdJQd1wB3cyNX+svFjvIHiwRNbhykmTpJGPxOWtMUOJcwvlZb4MCX8nnUwiPlaSCle
	6d8wHFz5HneEPeLnhgi3U2A5rv+Tqm6Y5sVcEHiRDYe0APgXbc8zCSB9qYujeuqrIxtcKB+m7/9
	2uzP0niSFedmSjBOM6DlevuGdvMW8FZF0q3bb4gQ2Ut4gm7QXvbZrhHf7ObxuSz+bInG2XVVdPH
	nrjtWnUO3eqvQo3wrylO/WhiBOcqsCVCp85RR0ekyKiTEgtqRUS83gmeH1iUrU/1mIbgig==
X-Google-Smtp-Source: AGHT+IGFOB2CKqiyD7Ajpyrvetj6hIb+Umrmi2qGvVFlK+1gaeRNXIHddC2nryxnGzRUIBjpb1oAAw==
X-Received: by 2002:a17:902:d48c:b0:21f:564:80a4 with SMTP id d9443c01a7336-22b42c43a84mr12676685ad.33.1744249795671;
        Wed, 09 Apr 2025 18:49:55 -0700 (PDT)
Received: from sultan-box.localdomain ([142.147.89.201])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7c95cc6sm19118255ad.122.2025.04.09.18.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 18:49:55 -0700 (PDT)
Date: Wed, 9 Apr 2025 18:49:51 -0700
From: Sultan Alsawaf <sultan@kerneltoast.com>
To: Xuewen Yan <xuewen.yan94@gmail.com>
Cc: Stephan Gerhold <stephan.gerhold@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
	Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH 1/2] cpufreq: schedutil: Fix superfluous updates caused
 by need_freq_update
Message-ID: <Z_cjv0EJ45NShYOp@sultan-box.localdomain>
References: <20241212015734.41241-1-sultan@kerneltoast.com>
 <20241212015734.41241-2-sultan@kerneltoast.com>
 <Z_Tlc6Qs-tYpxWYb@linaro.org>
 <Z_U_LN0AtH_n4YtE@sultan-box.localdomain>
 <Z_VTRspvmOUfrawh@linaro.org>
 <CAB8ipk8ARRdR8UPgLqJ3EcAzuE4KNEO=cmLNJLk6thTxdBSHWw@mail.gmail.com>
 <CAB8ipk_Ayqmh=Ch2aH2c+i-q+qdiQ317VBH1kOHYN=R9dt6LOw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB8ipk_Ayqmh=Ch2aH2c+i-q+qdiQ317VBH1kOHYN=R9dt6LOw@mail.gmail.com>

On Wed, Apr 09, 2025 at 07:48:05PM +0800, Xuewen Yan wrote:
> Or can we modify it as follows?
> 
> -->8--
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 1a19d69b91ed..0e8d3b92ffe7 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -83,7 +83,7 @@ static bool sugov_should_update_freq(struct
> sugov_policy *sg_policy, u64 time)
> 
>         if (unlikely(sg_policy->limits_changed)) {
>                 sg_policy->limits_changed = false;
> -               sg_policy->need_freq_update =
> cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS);
> +               sg_policy->need_freq_update = true;
>                 return true;
>         }
> 
> @@ -95,11 +95,15 @@ static bool sugov_should_update_freq(struct
> sugov_policy *sg_policy, u64 time)
>  static bool sugov_update_next_freq(struct sugov_policy *sg_policy, u64 time,
>                                    unsigned int next_freq)
>  {
> -       if (sg_policy->need_freq_update)
> +       if (sg_policy->need_freq_update) {
>                 sg_policy->need_freq_update = false;
> -       else if (sg_policy->next_freq == next_freq)
> -               return false;
> +               if (cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS))
> +                       goto change;
> +       }
> 
> +       if (sg_policy->next_freq == next_freq)
> +               return false;
> +change:
>         sg_policy->next_freq = next_freq;
>         sg_policy->last_freq_update_time = time;

If CPUFREQ_NEED_UPDATE_LIMITS isn't specified, then there's no need to request a
frequency switch from the driver when the current frequency is exactly the same
as the next frequency.

Sultan

