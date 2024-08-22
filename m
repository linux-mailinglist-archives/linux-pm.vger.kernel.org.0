Return-Path: <linux-pm+bounces-12700-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7370695ACF0
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 07:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A4121F2337D
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 05:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206B752F74;
	Thu, 22 Aug 2024 05:37:00 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CD42E3EE;
	Thu, 22 Aug 2024 05:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724305020; cv=none; b=GrVMRKooIX7sbF2gCQ9THg8U5JBSTk5c/0cOtTwnB3IG5bKuv8HfDhY6zLfPnAxAlCvdWifxmqJeNH2pMsklQqzKfdUyDyS+wIhDfUObwH995b9heU3VEr6jQIJNF32C4bOBLFB//vcWyN/KYj/CiulZ40cLFbq7l/26FPI4z4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724305020; c=relaxed/simple;
	bh=KPOxtiKo5x8eJszu3Twv8hgyaXlqavRyVwS6OTA8qrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ojquKu/dXa6gTyRkvv6gc57STGqDiaG/FpqtRcqP9qFQl+MIXmmxANwXu1Cw5+2WE2zx6QXqJalu9yO+eAH+aPNwm4ZdfS+7+B1EDqJ7Bb1IEuf/I2luGuCW2XHh1vGR1uOlA8CyFj1LFpRoGou6TEEIIxdhdxtiYQzAOlCaXCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kerneltoast.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kerneltoast.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-709339c91f9so268627a34.0;
        Wed, 21 Aug 2024 22:36:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724305017; x=1724909817;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oyW4TRGPQxi6X8KZLrjHz14wtL6cqlbDd7KpbHD+axQ=;
        b=C9n6uyF+nNUrPGvF6xLFZxbjqiaUxpw62cW3vXuNvkrZNTzlkbDO6DAAJUwVJnH80G
         lvIvwBpAfzIb8JhKUj9bo5ZEffCV8AsY1oGMxIcjOTMrB4NR7Ys6+ykuPEt+SGG736FH
         T/lS7kBeRb/kGisXoDjc9HGvJI/oTXW+rmq7aoWiTMZ8VQeSlsn5GY/IOYjIpCTG0gN3
         hquDr4IqWSzVx7HxeNQxgzN7r+hf0hkMXoJVfjsg0x1+wosO6q9k+p6XdvxLK3poowV3
         KnVra58cDpW6kYQZme5VyfGSwnMypNJiyPXFf/EXGtU3sPCSNT+G8sKY6YGpY+L2N9Ir
         oPEA==
X-Forwarded-Encrypted: i=1; AJvYcCWs9y/8VzTdy9Xy3vf1JG1xXA6uiLMsXk8XwX12ZlCRhbwnAztoiUBJm745Ym58JfQ0Do4GBR510GNxECg=@vger.kernel.org, AJvYcCXYe8c32yeN3YJSnI1IPUSB2vRUDoZ2yqzcbQQHnlyZvyGt8nSqw6SyXLqBlRUmuu+POrO1+q9t8d8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPXntyboR5XD+iM4XltZgqlGCmLow4r7k9wx7P6YAoB2LuebUY
	APWEZQFZhXoOdpvPXi39m55qquBT3eYUBnN9Ofip+//5s/jR3Esr
X-Google-Smtp-Source: AGHT+IGCWj5tGsuQ+vZM5hyLnQGYRlRmUiNpvzMvUP/IALZR5Cd3jB3npUJHRS4vXG4RgbCTDsUdJQ==
X-Received: by 2002:a05:6830:b88:b0:709:32c3:68ef with SMTP id 46e09a7af769-70df888ce24mr4950610a34.30.1724305017334;
        Wed, 21 Aug 2024 22:36:57 -0700 (PDT)
Received: from sultan-box.localdomain ([142.147.89.224])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70e03ad4bf9sm171329a34.48.2024.08.21.22.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 22:36:57 -0700 (PDT)
Date: Wed, 21 Aug 2024 22:36:52 -0700
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
Subject: Re: [RFC PATCH 03/16] sched/pelt: Add a new function to approximate
 runtime to reach given util
Message-ID: <ZsbOdOf7jHTvVXPj@sultan-box.localdomain>
References: <20240820163512.1096301-1-qyousef@layalina.io>
 <20240820163512.1096301-4-qyousef@layalina.io>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820163512.1096301-4-qyousef@layalina.io>

On Tue, Aug 20, 2024 at 05:34:59PM +0100, Qais Yousef wrote:
> It is basically the ramp-up time from 0 to a given value. Will be used
> later to implement new tunable to control response time  for schedutil.
> 
> Signed-off-by: Qais Yousef <qyousef@layalina.io>
> ---
>  kernel/sched/pelt.c  | 21 +++++++++++++++++++++
>  kernel/sched/sched.h |  1 +
>  2 files changed, 22 insertions(+)
> 
> diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
> index 2ce83e880bd5..06cb881ba582 100644
> --- a/kernel/sched/pelt.c
> +++ b/kernel/sched/pelt.c
> @@ -487,3 +487,24 @@ unsigned long approximate_util_avg(unsigned long util, u64 delta)
>  
>  	return sa.util_avg;
>  }
> +
> +/*
> + * Approximate the required amount of runtime in ms required to reach @util.
> + */
> +u64 approximate_runtime(unsigned long util)
> +{
> +	struct sched_avg sa = {};
> +	u64 delta = 1024; // period = 1024 = ~1ms
> +	u64 runtime = 0;
> +
> +	if (unlikely(!util))
> +		return runtime;

Seems like this check can be removed since it's covered by the loop condition.

> +
> +	while (sa.util_avg < util) {
> +		accumulate_sum(delta, &sa, 1, 0, 1);
> +		___update_load_avg(&sa, 0);
> +		runtime++;
> +	}

I think this could be a lookup table (probably 1024 * u8), for constant-time
runtime approximation.

> +
> +	return runtime;
> +}
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 294c6769e330..47f158b2cdc2 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -3065,6 +3065,7 @@ unsigned long sugov_effective_cpu_perf(int cpu, unsigned long actual,
>  				 unsigned long max);
>  
>  unsigned long approximate_util_avg(unsigned long util, u64 delta);
> +u64 approximate_runtime(unsigned long util);
>  
>  /*
>   * Verify the fitness of task @p to run on @cpu taking into account the
> -- 
> 2.34.1
> 

Cheers,
Sultan

