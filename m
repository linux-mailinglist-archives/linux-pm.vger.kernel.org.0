Return-Path: <linux-pm+bounces-12020-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6528894C806
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2024 03:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00A58B23575
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2024 01:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA0B846F;
	Fri,  9 Aug 2024 01:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="eKh4swDw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7252F22
	for <linux-pm@vger.kernel.org>; Fri,  9 Aug 2024 01:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723166654; cv=none; b=CQdLOU47uCU5o3QGu7wYNIbHpYQJIKjnJfqIE3ZvoRmlEo3/lN7s012Xat3ChKwoAuke4fqYj46ZCtlTP25TlGi61cDuofD9R9H8AkXNEO8Z4yv/elVEtrkm0N9mcZyT6nS6n4md1YsKrgv4QhRLZ6FiC3kZi/F90NQD+5HukuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723166654; c=relaxed/simple;
	bh=5sMRSEGHhX6hM7Lqbgyzh2dlJiH8TkNpPOJdAC3U/i0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MRW3ceXQumomcrBmkIcdEpKU6aLdyiAzpT/Ye5C5Rnrsr/qj+SkzEFfELQWDHLDP1MzyUN8xEop7XNvIOkQP+5Un3OOWpvxovQC3M0FrMxnZGJX798joSVwwetmPl70FbYQ6V3qOqOsLXmPxrmdMVNKBYthIa11HPl+ULE+8H78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=eKh4swDw; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-428119da952so10486565e9.0
        for <linux-pm@vger.kernel.org>; Thu, 08 Aug 2024 18:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1723166651; x=1723771451; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eiqur0cQF6dXhXSH6QQag81bl9bx0sSpLVlcr1hSsyw=;
        b=eKh4swDwdNoRd85gFrkVIi7etCudYqAH9p9WXG9TGQK8Ib+jUFktvxhtdtCcus4EGS
         E+O99w/pxJtCeJq3RjxEkVyPG7ZbBExXnIh9Q8ZXWNuJMOiem/VsDIURiwLX/bmz9u9C
         JFGGhYqVn+cEm8ZH93AMUle2LkCB3UVNMH504gOLb5fAtbbCHgoOnxpS+DMAbgKwurid
         hef9j0ixu5DL/us5x3PW1/vBan8gDZ/P7/+FfM51lj9fN+1DG075eL8nFzrmLklzpcPG
         eCU+GizA1VRzmclFjL7vj2450AP311Jp69uJpbu5CGPdpDbTb31JOjyiw2WFg+Sq/Fb0
         L8SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723166651; x=1723771451;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eiqur0cQF6dXhXSH6QQag81bl9bx0sSpLVlcr1hSsyw=;
        b=aSZC40Jj3vJmqgUWGYWjcm4Gu+6CV61etaqudzA8XqmPxihAbNkJH/naT9NIR0DszV
         NiWqConWxafCfYO8KS5miIupWvzndZyHjrDtb/qh/ykSygjQeG+vOZpS+K9tBy6UTeih
         OBUZJXYwGSY+kmz6FiwUL5SfzRr+VjqjMn49NVemaMYnlcyyugao8tV+TOCM96mvqp4g
         IWntNQcOlxzfZ0nF1fx3p2DPcFatxECbGkOLMcAAxRbAamB1VJGuQRvkI1FJq5vDgtHz
         IjXwUHDzigCRfh8gQK8Zc4tj/Zw61y8OzZMUXmKGWxMVbX6gqUQ3jHZc0npCDgCVrHj3
         GdWg==
X-Forwarded-Encrypted: i=1; AJvYcCXi7NGw310lQinT3WdGLGxy6WTfXvLDc4C7v9Q4i9zT4Oa4zACV9Jd6kCFvdmP8EA5TKpJsirrMWl7wMmbhO1/kmKJbZUgZyG8=
X-Gm-Message-State: AOJu0YzS1cxidn6MpLveFME293eMv+Q93paBYWYPKlHre52K/IKXn9Ki
	+2Rfyr+38gaiVbi8fOKyVd3H3DRmNk0hNwrnchYtfhvra4aHV6KXEp2IkJ+V6JCwMb6RyyeR90J
	7
X-Google-Smtp-Source: AGHT+IGKVDJqQ7YfCkQO0dSAc0md48hziG70wZXmG3S8av/tAjSnSxxRMgZ9BKzrSMIK7svDA/QJPg==
X-Received: by 2002:a05:600c:1988:b0:426:54c9:dfed with SMTP id 5b1f17b1804b1-4290af0a334mr29455355e9.28.1723166651339;
        Thu, 08 Aug 2024 18:24:11 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290598e5adsm102736845e9.25.2024.08.08.18.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 18:24:11 -0700 (PDT)
Date: Fri, 9 Aug 2024 02:24:10 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-pm@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] sched/cpufreq: Use USEC_PER_SEC for deadline task
Message-ID: <20240809012410.marjxrio3sjequnn@airbuntu>
References: <3c726cf5-0c94-4cc6-aff0-a453d840d452@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3c726cf5-0c94-4cc6-aff0-a453d840d452@arm.com>

Adding more sched folks to CC

On 08/06/24 14:41, Christian Loehle wrote:
> Convert the sugov deadline task attributes to use the available
> definitions to make them more readable.
> No functional change.
> 
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> ---
>  kernel/sched/cpufreq_schedutil.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index eece6244f9d2..012b38a04894 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -654,9 +654,9 @@ static int sugov_kthread_create(struct sugov_policy *sg_policy)
>  		 * Fake (unused) bandwidth; workaround to "fix"
>  		 * priority inheritance.
>  		 */
> -		.sched_runtime	=  1000000,
> -		.sched_deadline = 10000000,
> -		.sched_period	= 10000000,
> +		.sched_runtime	= USEC_PER_SEC,
> +		.sched_deadline = 10 * USEC_PER_SEC,
> +		.sched_period	= 10 * USEC_PER_SEC,

I think NSEC_PER_MSEC is the correct one. The units in
include/uapi/linux/sched/types.h is not specified. Had to look at
sched-deadline.rst to figure it out.

Assuming I didn't get it wrong, mind adding the unit to types.h too?


Thanks!

--
Qais Yousef

>  	};
>  	struct cpufreq_policy *policy = sg_policy->policy;
>  	int ret;
> -- 
> 2.34.1

