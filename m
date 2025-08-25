Return-Path: <linux-pm+bounces-32966-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F14AB335AF
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 06:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E02071B21DB8
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 04:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBAAD253956;
	Mon, 25 Aug 2025 04:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QiHmOUzg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECA41C4A0A
	for <linux-pm@vger.kernel.org>; Mon, 25 Aug 2025 04:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756097808; cv=none; b=J94yk6JU6eHL43ULYr82Mf85vynH/0lfarD6Fje44nWNxlpvobx8Yf2pcGmQu6LUHLV1NEWjPRzM6Plh5FxTvro0azqZHDtnFaWUtax/V9tChE82lnBRHO61HGRmZNZytbdxSS1Nb72xp/hSh0RPkLh0vPLslzvg2sEhXgSpRws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756097808; c=relaxed/simple;
	bh=5I5emsoasSGYMQYjrmKTvp+4GnV3GfMEYFcm5BGc304=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lOCchnYpMzNaolkpzcmt7PBFvhyM8CbzCy/Yr8oRkVo14K3orPQ1acBqsHAb1DXL3MkPmZwiMFiyDQjSrnfwm6xM08FoxVHD0+X4/zZvJP0JQHlEE9i9bn3EdoSFbmVHrpUXVkmcezzYxKYRUdNefbJwXZbAKMT9ZOP3zW1qROY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QiHmOUzg; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b475dfb4f42so2643316a12.0
        for <linux-pm@vger.kernel.org>; Sun, 24 Aug 2025 21:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756097805; x=1756702605; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Nn5hdQ52sFt9aeXF9yASEnTdR4TK2NpcO83dNRAIXDI=;
        b=QiHmOUzgUrxhnH5cya2/kEj+2ZoSiB4Gn7ECKWZHXq0k4hZfbcdBSGNUn5AWAX/q+i
         3ag4bx3BDU2DgyzyaksOqtDPSNAh2TW8xFpc8MUVfDj3A78MAZoN0MHinfcgB8tuTjdO
         bdcEci6BuOkzrj/ytwm8tqg31BeKH8s4jfdYE59QxoQTn9Q0lndM9ouxXWGQxGrU/TVD
         9BA6PGexq3ChExUnQm21sIQM0MfU/SPlhD/CxX5s5yLlnao8PS1Dlgy9mKxvywoUx7wb
         9mkSkW4f2MiOkL9cDNsCkoQjy5mUpLB0nrQoZCSkM9pocMIeKsuMT0wzIp8xn71EpN4i
         nNZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756097805; x=1756702605;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nn5hdQ52sFt9aeXF9yASEnTdR4TK2NpcO83dNRAIXDI=;
        b=SoYB45IYgMazHOySneW/rcVUyYgfoiOYwnVGnZgNp80clIwtXLNxhQC43qBBpSMQm0
         oDvwti1xCA+ibGdT+9vVPM8qzDF4Uxm6AYkqAKs5PbW2z4xTeowPUJSWF/cilSBNSgsG
         OxZQ0vlgSgl5JK33Sb+IqOdRv0KYw+rws4WLx+AylwtWypGEhVOmoCfQyKQWU4ozl0Qt
         yoFUgofTJHtf75b0dNjA9tZm/1q+jFZ322/xoU4sAFVToISZ9YT6iJK5Mpd1Do6CWyX4
         a/PxoTmWKd5R5TAjMQgMbD5do0n3tw3zyh6L0SehQPvpofwfY7wqX+JGkOfbvEMc22TS
         1NKA==
X-Forwarded-Encrypted: i=1; AJvYcCX2+ObeVZRGbXdjiAi75QfQvUC4swGCj9KY1qKlJOen7kNPvERCC+YA80OWLbehoRcZgKdixwaWoQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwRDx9hFCqxyq2/bLWiyDw5/tYcB2tJo7eGqLxbfUWLamihhewI
	wz9EhupN26xFSI+oleNqoArHpbYFr00ZG+l8GP0SHoCaOFdMNNZHMvUF8R+xj00fhFg=
X-Gm-Gg: ASbGncvE+jUVJyTcXFn1BJEbNBsSXe3DVeZN2mqPQkQ2z+6GEaWWEJon2aRPMZKPAsO
	j90LK7Sb27AerydhSVZ14fyogr12N1alo1ySpli2tViyDnkViQRrEwxqxAL7wnJ1RtcoKHQ5HX1
	w61e8SIBwAWAXSXyNl+k9xiTOW40HFj+ZnqV5WVAedr9+tLphxanBBiS5PJq7EcQmeP5U0zeb0u
	TiU0Rs1f5aJNde5Bru9bYRM64oLQHqXfVa4YKzlIDcL9lY9jj7uPR06lFUHMObT/V5IqIGNyCAj
	TwwARz+VaHkR/J4bi//vCZ9IarA4qI2GzR5UxoFaMT5mk4ZOrSPdamziu9/SIqniLGDREt6bsqZ
	BJtxWc0hHRxeDn8LGNfvOXNIy
X-Google-Smtp-Source: AGHT+IHBpKNx6ZAMY6igw9fblWtX3oz6z3/u0C9tOCrVTWeSsHlWo1lfect2GuNIBpq3YHar5IiKlA==
X-Received: by 2002:a17:903:3c2b:b0:240:3e72:efb3 with SMTP id d9443c01a7336-2462ef6ad6fmr159665325ad.43.1756097805039;
        Sun, 24 Aug 2025 21:56:45 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246687b0c61sm56323385ad.56.2025.08.24.21.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 21:56:44 -0700 (PDT)
Date: Mon, 25 Aug 2025 10:26:41 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Prashant Malani <pmalani@google.com>
Cc: open list <linux-kernel@vger.kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Beata Michalska <beata.michalska@arm.com>
Subject: Re: [PATCH 1/2] cpufreq: Add driver flag to avoid initial frequency
 verification
Message-ID: <20250825045641.o2thjvs3xyuxavyk@vireshk-i7>
References: <20250823001937.2765316-1-pmalani@google.com>
 <20250823001937.2765316-3-pmalani@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250823001937.2765316-3-pmalani@google.com>

On 23-08-25, 00:17, Prashant Malani wrote:
> Some cpufreq drivers have a get() function which can return an unreliable
> frequency. This can cause issues when switching governors. For instance,
> a CPU would be on performance governor and have it's frequency (and
> policy->cur) set to max. When the governor is switched to userspace, the
> policy->cur is re-used, but it is checked against the frequency returned
> by the driver's get() function. If it's different, the frequency will
> get set to the new (incorrect) value.
> 
> To avoid this, add a flag that avoids this verify step on governor start
> if the cpufreq driver opts in to it.
> 
> Since there are no users of this flag, no functional changes are
> introduced here.
> 
> Cc: Beata Michalska <beata.michalska@arm.com>
> Signed-off-by: Prashant Malani <pmalani@google.com>
> ---
>  drivers/cpufreq/cpufreq.c |  3 ++-
>  include/linux/cpufreq.h   | 10 ++++++++++
>  2 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index b8937737d096..72e6552a40ea 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2482,7 +2482,8 @@ int cpufreq_start_governor(struct cpufreq_policy *policy)
>  
>  	pr_debug("%s: for CPU %u\n", __func__, policy->cpu);
>  
> -	cpufreq_verify_current_freq(policy, false);
> +	if (!(cpufreq_driver->flags & CPUFREQ_DONT_VERIFY_FREQ_ON_GOVERNOR_START))
> +		cpufreq_verify_current_freq(policy, false);

I don't think it is okay to do this to hide a driver's failure to
return the right frequency. What about all the other places where
get() is still used ? Won't that cause similar issues elsewhere ?

The driver must be fixed for this, not the core. The core is doing the
right thing here, asking the driver to return the current frequency.
If the driver is unsure, it can just return the current frequency from
policy->cur instead.

-- 
viresh

