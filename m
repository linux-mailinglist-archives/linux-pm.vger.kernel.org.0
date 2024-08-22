Return-Path: <linux-pm+bounces-12699-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FAE95ACDF
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 07:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6EFA1C22851
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 05:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3902161FC5;
	Thu, 22 Aug 2024 05:30:04 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E24558BB;
	Thu, 22 Aug 2024 05:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724304604; cv=none; b=PT+I82wVJtxzOowFzqW67Gcc8w0ioYcp283frihwcnBUc4QAZQbxaRaOLk7L092QfOnrGNirAm2j4j+2/6dhT6zSKwVq7FXUp+RaQWXVy5R6nqzf6rWCKhDyR66gMvW/g4RewdV7xcKHE9MlXBwGHlfYlQaVRMo2rPcS1I4YTRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724304604; c=relaxed/simple;
	bh=epM428OpHUafAd7fsZTEdiCGGMpAeXQZsMfOjY6Y+G0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ERW61wr1MMARQnGND9bMv5AFwZrOs28tFPY2spxMt7iMQoOJ0drG00vkaEnktpVW68zG6aUyMK+G8TbdiqdmaOclVxJGCx+VvN63TxHjv76HWiZIDbZ48y4DnxNc3Gzl2kIyUYRarouZ3pV+X7LsHl+niUj4G1tYdg5yf0iJDFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kerneltoast.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kerneltoast.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5d5c7f23f22so288100eaf.0;
        Wed, 21 Aug 2024 22:30:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724304601; x=1724909401;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4DH+JK/58q2Wi7Mk1VPRdbq/7ID5n14zsspxYzBb8yc=;
        b=HbSWaozB++rpjYYpcCZu4nRosBs7ZVJvr5ek9QbXGdASGAxBDceJnTcGMpm08dp7+4
         a3brURTe7cj0RObjbriMjoVg5nxujIKC96GeTxBsGlsZ+O0zu9jmhqOsHWXhbbb47zln
         UUxLJyAnSKAGPNmWqCQQvmzmsgkITHjVq/WRBHIyYbveRoaMt3S0EYa4IjkToB8LKAI4
         EwYiTjs41YJqhspaqDM84TfNw9BKxs+s8ZCfYYja2MFWJYOsxHTOrskuUelruDsh144B
         MxBvC8t7jO1GMSxGeW5JwbrMIhLlACFEVvC/Piaw7UlpM/yY2Nqut1Yap24MTwXCQ2Zy
         rC4g==
X-Forwarded-Encrypted: i=1; AJvYcCUVZ6RNnsdsAHGqwVFOZ2zX893W9X4tPBFtk8EBl9qbLYrRG903Rgg6PFWFbCM4AdFCQ6w0Go97qX0=@vger.kernel.org, AJvYcCVN+r6lI9KFx+DdTD0IYaGIocbDpZnVHDvV3rYKr9MMVRn1LKyJha83DZkAEasBqqavLK+DBDP+2wBuOaI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4q4rY9mEmKmsg52/KCm8wlrl5okSrre37677JKZvOgnn10CkH
	dWbNtKyMZ0yPvKW3A1miDZt0GElxjjYY4bbN03rPxvAOIb5ErQ10
X-Google-Smtp-Source: AGHT+IFp3gLZOY6Z00/2GAYLazJDg0SK1tv4Lk28SnUSav9jUVjsEmRI9VY0iziPH+3uYH7aR2dC+w==
X-Received: by 2002:a05:6820:82c:b0:5dc:9800:a443 with SMTP id 006d021491bc7-5dca03d01b0mr5516563eaf.1.1724304601302;
        Wed, 21 Aug 2024 22:30:01 -0700 (PDT)
Received: from sultan-box.localdomain ([142.147.89.224])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5dcb5de8220sm161386eaf.16.2024.08.21.22.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 22:30:00 -0700 (PDT)
Date: Wed, 21 Aug 2024 22:29:56 -0700
From: "Sultan Alsawaf (unemployed)" <sultan@kerneltoast.com>
To: Qais Yousef <qyousef@layalina.io>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	John Stultz <jstultz@google.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 14/16] sched/schedutil: Ignore dvfs headroom when
 util is decaying
Message-ID: <ZsbM1IiZyAuv7xz_@sultan-box.localdomain>
References: <20240820163512.1096301-1-qyousef@layalina.io>
 <20240820163512.1096301-15-qyousef@layalina.io>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820163512.1096301-15-qyousef@layalina.io>

On Tue, Aug 20, 2024 at 05:35:10PM +0100, Qais Yousef wrote:
> It means we're being idling or doing less work and are already running
> at a higher value. No need to apply any dvfs headroom in this case.
> 
> Signed-off-by: Qais Yousef <qyousef@layalina.io>
> ---
>  kernel/sched/cpufreq_schedutil.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 318b09bc4ab1..4a1a8b353d51 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -9,6 +9,7 @@
>  #define IOWAIT_BOOST_MIN	(SCHED_CAPACITY_SCALE / 8)
>  
>  DEFINE_PER_CPU_READ_MOSTLY(unsigned long, response_time_mult);
> +DEFINE_PER_CPU(unsigned long, last_update_util);
>  
>  struct sugov_tunables {
>  	struct gov_attr_set	attr_set;
> @@ -262,15 +263,19 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
>   * Also take into accounting how long tasks have been waiting in runnable but
>   * !running state. If it is high, it means we need higher DVFS headroom to
>   * reduce it.
> - *
> - * XXX: Should we provide headroom when the util is decaying?
>   */
>  static inline unsigned long sugov_apply_dvfs_headroom(unsigned long util,  int cpu)
>  {
> -	unsigned long update_headroom, waiting_headroom;
> +	unsigned long update_headroom, waiting_headroom, prev_util;
>  	struct rq *rq = cpu_rq(cpu);
>  	u64 delay;
>  
> +	prev_util = per_cpu(last_update_util, cpu);
> +	per_cpu(last_update_util, cpu) = util;
> +
> +	if (util < prev_util)
> +		return util;
> +
>  	/*
>  	 * What is the possible worst case scenario for updating util_avg, ctx
>  	 * switch or TICK?
> -- 
> 2.34.1
> 

Hmm, after the changes in "sched: cpufreq: Remove magic 1.25 headroom from
sugov_apply_dvfs_headroom()", won't sugov_apply_dvfs_headroom() already decay
the headroom gracefully in step with the decaying util? I suspect that abruptly
killing the headroom entirely could be premature depending on the workload, and
lead to util bouncing back up due to the time dilation effect you described in
the cover letter.

Cheers,
Sultan

