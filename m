Return-Path: <linux-pm+bounces-26354-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B616AA01C7
	for <lists+linux-pm@lfdr.de>; Tue, 29 Apr 2025 07:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81C60481776
	for <lists+linux-pm@lfdr.de>; Tue, 29 Apr 2025 05:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD712741C4;
	Tue, 29 Apr 2025 05:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E7+Xl6FC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B55A221F37
	for <linux-pm@vger.kernel.org>; Tue, 29 Apr 2025 05:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745904290; cv=none; b=Vnelhvcp6UxGQ1jplr7UFJ0oAIGPFd/cYb3gZynzQ0bTg8y6IZMSBEOmQm54iGvhqEoR/Oh/ay/vfMP7a5GW2iQkdqUo0+3BIe34KYoQuCxniWLbjshPLhS1KSRS9kW0QM9BqORytYZ1GgoZ7Rz+YQazTPezyCscTlcaoYJE+2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745904290; c=relaxed/simple;
	bh=/KC233azgY3A1MOqq8JrlK5M7xo9FxTg7CclfxXZFos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V3W44FdTkxyVk1xNZKG2t+EpGywTD7hWBokhrTisGt+F/FYQTGIRqqb3LD6XARtFwY3vF6ue1yeEKZJX7gLNs1oc3RPeRxsPw+qqhrjSaOMtsuWUHclG0wH2uCA3hFAwt+EIdjbsgRTi/X7IEF0QcpZ+EtqNnjH7kRdHKs/JIKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E7+Xl6FC; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7376e311086so7541787b3a.3
        for <linux-pm@vger.kernel.org>; Mon, 28 Apr 2025 22:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745904287; x=1746509087; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AEG2jELXd9nNPULNYZssLdKsrgNlc7ll4A8WlMh6fPs=;
        b=E7+Xl6FCajASVSoHt0UJQwDwTAAd26NjQYqa4lw6+yg+N/lS6VEPOlbEYjbLL0CwYT
         vw9IGKxxClC9tWXo8gjw+Xw1p2oETN/rYMQvkyP5sY7hJcz7NEtcTBG+YFRKSfVWqLpE
         vcldfbrbTQrQjDdiGkLs55LJV7WfQeBNPhu5NdCS39Q09vCNmyl7YCKBWUBobWSixKCN
         8lHOogX3XMGKv6qqNDwcZ59NCJz4BRraKrlxgdex087UWOT/EWsHKImigDDZE9UESdIR
         J1qUtTuEII4f7qEv5hAsNiXZcvDBVtkh743GMINQAJGuQRjiMaPLy4aCgkotTvfzHEZ4
         3TgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745904287; x=1746509087;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AEG2jELXd9nNPULNYZssLdKsrgNlc7ll4A8WlMh6fPs=;
        b=hP7lFTUziQddPxV0OUuDKMiZCvGPWvYsyv2kh+fVfhF25D16azAb9qLgBu/bVP0HMn
         LVO7RpxGOkT7Yr5D4yZa1xnhtyIlzVXIpZIUiVWpdw/msZYnWp6zQjxZQamRi8qPcNEu
         4HXjo5XIDrOWE7BZ6asf7yvFTkwt359BnOPc56qdz9NRPgj6XasagTpKY0whVSUZMOU0
         uzOBUlKlbHNx8RkmukPGkw8CkH2L4Grc+Bg2LZYYs+m1zLPJHgrtyt+r9GrEuHHj9D7P
         Nagd/dM2FkvgqThoW4B+FNGnepFziW7cp5N5bdI1get0OGVf+Mu/gRKRLSzNYABDY0I1
         Z3jg==
X-Forwarded-Encrypted: i=1; AJvYcCVGI8/DsUi6AOijqNj0jl/p27wC8bWJp7yBuMaXgvyny7OTjuTJq6fFu9x5270z3kMJmd1BZPKhEQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc4MawhUhSvnSExLfEoleFus7Kk/e0NBh1vAFvdeLWTCptYSF7
	d2IByciXVKnNKwldnjanB5e0O3cFk3jvHC9T/fPjELGBi67fS2jJRorTmVYOAgE=
X-Gm-Gg: ASbGncvDgezps94PIle/6diAKF8YllBXfvYk87ZRkk8wLIKsTW/iB/+Dk559qZdDBC5
	1tdVY3Azh7SncDLF58sUh+RRNrYkIhlwqiAesoar9/e+6Lz/xkX2FA0aSk433x/q413KKVI0CeL
	Ann3z19lQdCC2uxjmpWKjZ8kv+zbw7C8IoIxSWe9po4jFY8kPOCvqpt6m2qs5BOPqXoK/40BnEj
	fvRcqyhQlNr75XmKewxL3T6T7i+kYThU9uOguN7f9RmZUXfgMgM8eVkt9xCf2+iSch7Gbmec6hD
	R1NakjmeSUGqXnn5GuLxNCOdyNTSVJ0yio0i72avvw==
X-Google-Smtp-Source: AGHT+IGacVDQkA79I4oerLjfSwtP2EnSgzoWaq7vlyI+ukjcLDfb1uzKM/LBC1AotrtWGv/r4XmSrA==
X-Received: by 2002:a05:6a00:2410:b0:736:5e6f:295b with SMTP id d2e1a72fcca58-7402715dfc9mr3302755b3a.12.1745904287390;
        Mon, 28 Apr 2025 22:24:47 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25a6b1e7sm9311484b3a.108.2025.04.28.22.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 22:24:46 -0700 (PDT)
Date: Tue, 29 Apr 2025 10:54:44 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Seyediman Seyedarab <imandevel@gmail.com>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v2] cpufreq: fix locking order in store_local_boost to
 prevent deadlock
Message-ID: <20250429052444.zfmfzjirkcaq3edh@vireshk-i7>
References: <20250428171931.1850-1-ImanDevel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428171931.1850-1-ImanDevel@gmail.com>

On 28-04-25, 13:19, Seyediman Seyedarab wrote:
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index acf19b004..5464c8487 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -653,10 +653,7 @@ static ssize_t store_local_boost(struct cpufreq_policy *policy,
>  
>  	policy->boost_enabled = enable;
>  
> -	cpus_read_lock();
>  	ret = cpufreq_driver->set_boost(policy, enable);
> -	cpus_read_unlock();
> -
>  	if (ret) {
>  		policy->boost_enabled = !policy->boost_enabled;
>  		return ret;
> @@ -1045,11 +1042,17 @@ static ssize_t store(struct kobject *kobj, struct attribute *attr,
>  	if (!fattr->store)
>  		return -EIO;
>  
> +	if (fattr == &local_boost)
> +		cpus_read_lock();
> +

Please add a comment as well to explain why this is required here.

>  	down_write(&policy->rwsem);

And please rebase over PM tree's linux-next branch, your patch won't
apply anymore due to recent changes.

>  	if (likely(!policy_is_inactive(policy)))
>  		ret = fattr->store(policy, buf, count);
>  	up_write(&policy->rwsem);
>  
> +	if (fattr == &local_boost)
> +		cpus_read_unlock();
> +
>  	return ret;
>  }

-- 
viresh

