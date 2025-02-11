Return-Path: <linux-pm+bounces-21799-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0EB4A307E8
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 11:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3686D188A5B9
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 10:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527111F2B9C;
	Tue, 11 Feb 2025 10:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="psUIZpjr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE21B1F238D
	for <linux-pm@vger.kernel.org>; Tue, 11 Feb 2025 10:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739268163; cv=none; b=DVf5+RSURHD+lKMEJXVMH2peMNRrmD9DQz7lEC7MbbjFmgvNRXxPERIGt69ijXuOahqtykLY1nJnPclqYInXrRqLMvPLyi5IyWKV3sY7vUu5WJw1l/ShdXC7wJpv0ouw5S/8lWf4zDLl9Xf7AptSYPUPPKWzeSkfji0lHxRNO9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739268163; c=relaxed/simple;
	bh=WDKNPjiPF6VWfA7jc6yUC9uakVSKGaDOa7W6V9I8LtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pZavzPUxbdFDQTAKYjTTz/y+5+Rxwh8AUMF3hNUFOxUODc3rtTKz1iURnZ61r0UheaE+Y/3aMjI8TGAPiiWB0ZI36fIAP6LRw4TTfkTMNzZ0QvyGLfjbhaog+ay0blUks4gerhylk3LQfoOvTKPyi3Wb6hdRMAJnQQUP/CFMSKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=psUIZpjr; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21f62cc4088so58057555ad.3
        for <linux-pm@vger.kernel.org>; Tue, 11 Feb 2025 02:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739268160; x=1739872960; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LawanDDHMjAWuwn6kkbSpPIPu7T1Xm3IJQExiBBX4Uw=;
        b=psUIZpjrkjgUnjkDvLfSw1qSh5P1cTcz9vWQ+XRQQwdnbkJM7Ass3aguA+aZ5xqr97
         MEl5CMS5KtpWpAMWlvbKOc14ZEL8zNNbc3Wf5zKdmxILOpYVx9eZl4EEl2SDd5k4H3VU
         Nfa9Ba3JHrWaZfQpNbWki55FBxad7d+GLiH7lj2DxpXAy9QjXNdYugfiZgSaxV9IKX5N
         WqyV/XkMBNlsOaHfA8sCs90SEjp85OvfPFXRuWvF6d7AbZWquQhGhSBU0sVs7PruDRD4
         evUBN3Xp24K50IA+P4Kbo8MGAcMLtNNY1xTevJ1NUHhpk+YXKbHJJwLK5bLywTbE0cp2
         PkVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739268160; x=1739872960;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LawanDDHMjAWuwn6kkbSpPIPu7T1Xm3IJQExiBBX4Uw=;
        b=lLE/LMR9qrAGMQNzCi1S1b8aMN1ZighBTmCW9CfRnnvJVFLzFcV3knjszYLx3nA2Oi
         nLTF+D7LX0/4w6r1MVXwfQwG0oKLrUDKZM4obprrthVJxard02Wp/0hV+bzNtd6fIDvU
         A4gvVrAds4Lusmc+rgB0L/EkXkgvjGxJHKmh/CDJiSQmDFFGXz/+SsBgUABYcKMKc3Ha
         EtTRoSgfxjABbrlw6gMic/NER4nXHa41gP9gwD0SsDtHWS90RCddVpASw4+ZoSaSLpPI
         yCPOqCopmzPJnHdLwZhL3RYQckMFJkNWlCUmohTgtHNdEHFYm0PH9crN0P3w/bLqTRB0
         1EcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaMnyrVTkjPXUtSvtSRfoc9RykcLprLjKEYxaF/SmQtLVVjlmlNJl1Y5MEwqTGzQpdKQgqBDz0cA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxWx5ukl+yXJTjj3ebCNoZsMIhN46lzLfpcWW3LwSHS9/LBQnzY
	qULVOtcxUk5+rUBBthXJyU28IbFs/OZGaesstuMzKoW2iCQv3dIGA/OydlWkPEQ=
X-Gm-Gg: ASbGncuGwJ8+OeUNYeIJIqQ7dM5j6qwxDci9vqKxZPdG+XuLRT9ifsUmmyo3FV8yOvC
	hqV3/G6+lW2ybsfd2JQNO+aRPZ4xakUjpjhBem29Tm2fIIxwzXbXtnQH38gruMLcybSC3ocjXL/
	yZWH0vgR/H6eNLN/bTt0G4fUy6huEYouvVdLbXgWGHRGiZTT/jKFPZrOq9QWl/CiGOnFxb03NLd
	g6APZCLF8PsNjJm1E8l9pivD+Y+jkkO5gtZKe3S0LlYaOCDhz/vCDzG3mVdSZN3dPVPd5JhC5qJ
	0W/3fey3RrXH1Pk0Zg==
X-Google-Smtp-Source: AGHT+IGxtNiHpfjO6oCMWUcwWUsQX6gTAMRPhPvi+aF+HBTExi++a87MpePgkbA1/PSWJ0O9TmRTVA==
X-Received: by 2002:a17:902:e5ca:b0:21f:6885:2b0b with SMTP id d9443c01a7336-21f68852c6bmr167497965ad.26.1739268160056;
        Tue, 11 Feb 2025 02:02:40 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3653b02dsm92369735ad.74.2025.02.11.02.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 02:02:39 -0800 (PST)
Date: Tue, 11 Feb 2025 15:32:37 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
	Amit Daniel Kachhap <amit.kachhap@gmail.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] thermal/cpufreq_cooling: Remove structure member
 documentation
Message-ID: <20250211100237.r32hu366jbihndbc@vireshk-i7>
References: <20250211084712.2746705-1-daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211084712.2746705-1-daniel.lezcano@linaro.org>

On 11-02-25, 09:47, Daniel Lezcano wrote:
> The structure member documentation refers to a member which does no
> longer exist. Remove it.
> 
> Link: https://lore.kernel.org/all/202501220046.h3PMBCti-lkp@intel.com/
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202501220046.h3PMBCti-lkp@intel.com/
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/thermal/cpufreq_cooling.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
> index 280071be30b1..6b7ab1814c12 100644
> --- a/drivers/thermal/cpufreq_cooling.c
> +++ b/drivers/thermal/cpufreq_cooling.c
> @@ -57,8 +57,6 @@ struct time_in_idle {
>   * @max_level: maximum cooling level. One less than total number of valid
>   *	cpufreq frequencies.
>   * @em: Reference on the Energy Model of the device
> - * @cdev: thermal_cooling_device pointer to keep track of the
> - *	registered cooling device.
>   * @policy: cpufreq policy.
>   * @cooling_ops: cpufreq callbacks to thermal cooling device ops
>   * @idle_time: idle time stats

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

