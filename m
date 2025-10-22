Return-Path: <linux-pm+bounces-36621-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB8BBFA116
	for <lists+linux-pm@lfdr.de>; Wed, 22 Oct 2025 07:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 48C46346C2C
	for <lists+linux-pm@lfdr.de>; Wed, 22 Oct 2025 05:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CB72EC0AD;
	Wed, 22 Oct 2025 05:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EA4JWB16"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4A72EBDF9
	for <linux-pm@vger.kernel.org>; Wed, 22 Oct 2025 05:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761111306; cv=none; b=fyKb64R9Xv8B29TnfIGNC4k5cdFmSDsFlMbnVMo/6VFUOGoMOi/xnhHmMgjpLU4fMHI1ON4eDffQCqdCL0mojGQ6r1au35g2uURrwjDf40+ka4TwFKyoPBqDmdM4tCqQyVpk3S6FfXg06kmh+dgiLFbDA94sJocHG5OyCz8TEoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761111306; c=relaxed/simple;
	bh=Yfli7nrNGWAirNBDg6CXZHLXMoqOZK8KHRWfvR153kE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fjkJpZF50RTU5O5sKabmMWyiswcL60jd+C14hpV+uhYvOYPBcamB8kWT7ZH9jVfcH+sich5FqLNSgNcsUpZDD19qzEQoOtyoXU982gH8/XLTp8X6i+ukK1zyX/dTCyaoKi4l2cdHwyU5vrsJYC0TN8SONG9j/f3X4J8FtDMslCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EA4JWB16; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-27c369f898fso91617875ad.3
        for <linux-pm@vger.kernel.org>; Tue, 21 Oct 2025 22:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761111302; x=1761716102; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=56ezGE6Ds9KP53wZYmYW6a4SSoZf29RYPFd4r32eFsg=;
        b=EA4JWB16r+NXgjHMeMN9NN9KSu5R9Yy8KCxl56vrgzUuc27h1WpYbekyKs+ngvf9E6
         YpCEaSjFsZqtKKfIR1Ue70YGGJ9nYuBDXFecfpdrhbxJdTQ+nn/VMC9oqoVsDd40p22f
         Ez3Lq5AxcYC280OcvMweY60pM+McAPT2MaBL+pHBXNtixInkzvh2RpLuC5XkD2VlMgyC
         pGgFj606MBeT3mQM8LTJ98jLyjvJi91wfE80JCFpjtcBMm5FgTYh3kOlK7x63zezL0UJ
         EZf5ahL87tSLqOSuxv1gZAPCzM2mTMv5wiFvFHGJhvUJeFZwM0WYnmXHcnR/wulCKIfN
         zDsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761111302; x=1761716102;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=56ezGE6Ds9KP53wZYmYW6a4SSoZf29RYPFd4r32eFsg=;
        b=bJTwmVJvkApDOyTprmL16bzA7fHBXjIXOLCwGYPFg0HErTLqDuLnJEVCIndjBHsy5z
         OS5iLftZVSkRgteEZyrdsI9hcvmCnnFpZ7jkq45bndkTHQRx/zKG5qP2nrmfLCyLLSQN
         /+nxKB3V/3yZ/8HWPA9VUv2ik8xTLFkAsyMUrJsgQOyjTUbp6uo5rYwj/43IcjMVG8Kd
         hhtRjGzrtaBPqTNPRf9D31ZbVNiAmvl2gQZ5b2ATektK4Re8AAg0bRg0paHRm8f+9cSq
         OXvcpLQdjkNmbb1rPgeiJbtlyNTyHZyZ65hVMzyQC8C7XiDvEN8zXuoldic7Jsf0AOhI
         aYUA==
X-Forwarded-Encrypted: i=1; AJvYcCVhnEcGM2d7xhz+M5XEieSWAwCPFEXjS/HiryKfsn9o3vM+OdJ1d0IBfsSCPVO162uXZ1n0b90PtQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwEXqmPi+Rm1D0nImVy3bePuawI+M2A80Uea68E+BbpY77ye3PG
	JfOrfL5+5iOMfeYBb1eI+yXwtskgOctOFHtGy41aa4/5t3iVooLpAAu7hcGFAIUGlrM=
X-Gm-Gg: ASbGncvcQQAq7ZwkOsHVQKFMYpZ7yKehDcnRaMaWLT21kxJPHNswq6p1+70E2SQN/65
	ojHNjyS1ut0WKTlHAxbNJSHq0J9/C11kLkdsJhcINZVi2hWRXr+IVXEmvJRSdgEcXwuM+KD0qmy
	zxyUtIeKlvbVsAR3uRIr5/TSELTtifR54mpH7tYdEp7e776j7MSSRmePx4aYL/ObEa8/71ZRYJI
	B54adhmJh5JptOKx/cFjiA0wlEJnfVlhXx+JjYahZ2L9zmQsXFiOakeC/WqEic+sF8MfsGjEqpX
	5cRRcuVTgkyv4hg24YkRvzLdBoFR2Wktk36anD3ArQDUH6/9QJMcph6Q7rSQYSzWgPCL8og0Nwy
	kYjDh0W8UQiLEsUKSWO0ZiJPqp4Dzem3AIJPpc9AxROOiCwlvsgUbM9bMFRwzR+L0q22WPf0+7L
	rWI1ziquLqxXd2
X-Google-Smtp-Source: AGHT+IGnVjE3oW9jfoMl45fRu62Au+V7hXBYTBJW0Xz1osI8MZwsrdpeSGQan//AK1Laa1HoxY0dkg==
X-Received: by 2002:a17:902:ce07:b0:290:a3b9:d4c7 with SMTP id d9443c01a7336-290ca121944mr241503655ad.30.1761111302331;
        Tue, 21 Oct 2025 22:35:02 -0700 (PDT)
Received: from localhost ([122.172.87.183])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a766745dasm11961911a12.14.2025.10.21.22.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 22:35:01 -0700 (PDT)
Date: Wed, 22 Oct 2025 11:04:59 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	linux-hardening@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: Replace deprecated strcpy in
 cpufreq_unregister_governor
Message-ID: <rgk3oym7r2gkx4gjqsot3n55s4jtlgyl7vayutaneyuqegybzl@njlf3ohiykjq>
References: <20251017153354.82009-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017153354.82009-2-thorsten.blum@linux.dev>

On 17-10-25, 17:33, Thorsten Blum wrote:
> strcpy() is deprecated; assign the NUL terminator directly instead.
> 
> Link: https://github.com/KSPP/linux/issues/88
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/cpufreq/cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 852e024facc3..0d3e77cf96a7 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2550,7 +2550,7 @@ void cpufreq_unregister_governor(struct cpufreq_governor *governor)
>  	for_each_inactive_policy(policy) {
>  		if (!strcmp(policy->last_governor, governor->name)) {
>  			policy->governor = NULL;
> -			strcpy(policy->last_governor, "\0");
> +			policy->last_governor[0] = '\0';
>  		}
>  	}
>  	read_unlock_irqrestore(&cpufreq_driver_lock, flags);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

