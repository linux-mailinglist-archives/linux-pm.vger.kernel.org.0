Return-Path: <linux-pm+bounces-21289-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7070A25739
	for <lists+linux-pm@lfdr.de>; Mon,  3 Feb 2025 11:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7607D1883BFD
	for <lists+linux-pm@lfdr.de>; Mon,  3 Feb 2025 10:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A33A200BA1;
	Mon,  3 Feb 2025 10:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QXMWhBNU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D532A1A4
	for <linux-pm@vger.kernel.org>; Mon,  3 Feb 2025 10:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738579696; cv=none; b=uk9oFrKEQCrpeBDfqJqoPKo1fYFoUgiRexkAJ5lzC6U9lFAsLZPjx59J8y88umIZ6viCsfS7N1OP2IlV6SkaB36SJ26fpKp2sVOKg39cr+KYZXIGLISIusHgSqSKcti9NkJJNR37n/Mh2ePgnDqYsdc5bqcYTF7D8CNUiPlybNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738579696; c=relaxed/simple;
	bh=YftWJvMEiCrtU5t0NNHpr/TqaN2EQ4xndBtIueES2+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y2bE/+9f9lhN6NHtA7puth4zwx0FZ89BdgVEVWEanmeY8t/ljWCqkPvnbPRnI06N+72xNsncSqc1qAv/zuq4GH+rvMAbe9q7+VlbQ2UsilUsb828cXpbupWQHbHDvbI/Kow31EycKpZq0HKIBbaS8ZlQTq5mzD4fAy7CoA98huU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QXMWhBNU; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21628b3fe7dso74297285ad.3
        for <linux-pm@vger.kernel.org>; Mon, 03 Feb 2025 02:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738579694; x=1739184494; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gF2Dk3poPY+nrxVh06MJWOuCS3vPdRofLnME4nsAnhM=;
        b=QXMWhBNUdyF5WG8oFyXRS9wizW4Xb/X3WMlBpz9NShI27ay70yuPhkEGA80Sc8LeDW
         yEHuwB6C4qlLWpxfJ4YYxwrRRqFmVT0uMTAxfU2tXEhgZrg58aoO7EsTkS601VWlAvWV
         5Wm/uLsDHjwFgilIbmG+sz4wK1HdWORxCxG01TcWA1zcvaGjhFx3qZBq2qxhwMDL9Ghp
         orCDpSu1AQhsLPK/Xcqv0LdLVu6QHiD70zT+oyCbqlCa5XeSbimMQqBCVqmhB1Avn1Dk
         79Nz/s1+EX5d2ZADDbZ4ckmC0j+w5CzKpqkKNR6Aj2+oGH6kC0g3NJw+3UZl18a8rOK7
         bdtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738579694; x=1739184494;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gF2Dk3poPY+nrxVh06MJWOuCS3vPdRofLnME4nsAnhM=;
        b=m0KWqNK4KrkYt5e9UCM6sIJktsQ+9GwVoUtkUI37TrxAr93gCkedUufZ9JxpygkKT9
         hI3qy2q7xMnS8q1p0QErGvMbyDkuOpf6YELKwQ9tLFa8bGw+fTFOCAeC0izv7fWsWIMH
         xkh7cOBNWhF0YwaTP69kewqleuCS9IaMQUxJHqa6oqU95yxE+17I3Q/+xxhS0ihv7Io5
         icDX4Z69rFPLuXHt2t6WcHIZw/FqxJijls2xNt9QGsPU/e2O7+hFnGPQSupFkbJpB+LR
         mxz0qws+UFEPThavN2jwX6oA57NpaO9C5AVz4Mt+1tI9z1pSCyP+6qsC1YPhu1WXhluO
         k0wA==
X-Forwarded-Encrypted: i=1; AJvYcCWKetIIUorMUVryt2R95oE1Eow7Wc11q4tFEel7G8x52ES0YETu5fLONIA/ppRKjZnbxBaPwdAVAQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxRE1D5oBSlzGBE2yAqRcEMs8F8Fudia/rjdIwcn8UArzJ8joPu
	n+1GY2dDIwE9oMFIL62OaSLz7vhhDvu6moY7b8+CYH7do5uv6njQp9RwCXEi7Ls=
X-Gm-Gg: ASbGncuUVkMq4IWdo+NgnfG/0qsrKkitBBbbyY2DgI7dD+XrXLucfq7ljG296EdBO2U
	GLmrZbvOUtgTUCoJRV/GbrJhW8CV+tBDfeMOwj5SnB8nwX2893sauZ+4ZXpjcusmqGao/LpkWvN
	VWZxI+YqNf3vfAvuPfTWbRqRA/7AThtMHkUIWeGHR5pHLvdDc6iQQfoFbXH800+kd7IBqQHf0ca
	JN3D5Ss2gfNR6ClUflJhEhJXUhXasLNTVyc+5NA8JT7ycQ0hEpnjiuQWr3k8ErTyAgpuIXPzm+g
	wmnryQAu0Y8PLOzGoA==
X-Google-Smtp-Source: AGHT+IGvgmZj4iMs//4PywYkmHglzukdY/RJQs6+MV/dRwLE0yHlCexXqr6pZLgRoeNoE22HgiI4WA==
X-Received: by 2002:a17:902:d483:b0:216:7d22:f69 with SMTP id d9443c01a7336-21dd7e04887mr334779115ad.50.1738579694119;
        Mon, 03 Feb 2025 02:48:14 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de3303f74sm72593165ad.201.2025.02.03.02.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 02:48:13 -0800 (PST)
Date: Mon, 3 Feb 2025 16:18:11 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Cc: gautham.shenoy@amd.com, mario.limonciello@amd.com, rafael@kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] cpufreq/amd-pstate: Remove unnecessary driver_lock in
 set_boost
Message-ID: <20250203104811.ccf3pj53cjlhwvti@vireshk-i7>
References: <20250130085251.155146-1-dhananjay.ugwekar@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250130085251.155146-1-dhananjay.ugwekar@amd.com>

On 30-01-25, 08:52, Dhananjay Ugwekar wrote:
> set_boost is a per-policy function call, hence a driver wide lock is
> unnecessary. Also this mutex_acquire can collide with the mutex_acquire
> from the mode-switch path in status_store(), which can lead to a
> deadlock. So, remove it.
> 
> Signed-off-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
> ---
> PS: This patch should ideally go before [1], as that patch uncovers this 
> bug and actually leads to a deadlock when switching the amd_pstate driver 
> mode.
> [1] https://lore.kernel.org/linux-pm/e16c06d4b8ffdb20e802ffe648f14dc515e60426.1737707712.git.viresh.kumar@linaro.org/
> ---
>  drivers/cpufreq/amd-pstate.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index d5be51bf8692..93788bce7e6a 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -740,7 +740,6 @@ static int amd_pstate_set_boost(struct cpufreq_policy *policy, int state)
>  		pr_err("Boost mode is not supported by this processor or SBIOS\n");
>  		return -EOPNOTSUPP;
>  	}
> -	guard(mutex)(&amd_pstate_driver_lock);
>  
>  	ret = amd_pstate_cpu_boost_update(policy, state);
>  	refresh_frequency_limits(policy);

Applied. Thanks.

-- 
viresh

