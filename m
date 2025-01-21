Return-Path: <linux-pm+bounces-20769-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4283BA17C4D
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2025 11:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6215C162AE6
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2025 10:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75A11F0E32;
	Tue, 21 Jan 2025 10:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mHhxAHcE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF9C1BEF82
	for <linux-pm@vger.kernel.org>; Tue, 21 Jan 2025 10:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737456839; cv=none; b=Khd2hEtos5Shb5/zqVd1nez4Lk3o5ALW+zVds6c9btTIHyqpd77iH051LDIiIrh+UYfF2UEHQDWTG17P5i4v+lnCibk3fxd/Ws9Wdrq6Q1pDd/16MusB6hnmy+zVRJR0+EdC2nCrEqrVtSiGben1Yd992/RsEJdR7aGywrQbbIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737456839; c=relaxed/simple;
	bh=0ynwDrtDkg1RPfVG987QiweEJhmx1Sy57xEmZffD17M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sf9Dq7cpOeCJ31XJi5Htie4z8SZbQczYC+HILwVlT/bqWhn/fdEwtSFPRdgV27fn5/7N1zt9OQOVyjlXkMsb4GMORXQ+9sOts1beJ875CQtjFnSnk/WACuz1BJjGQftpudKbgRrs1MKWuKo0houd+zqkyjzEQyZJrHhEPp++MbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mHhxAHcE; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2166651f752so125538095ad.3
        for <linux-pm@vger.kernel.org>; Tue, 21 Jan 2025 02:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737456837; x=1738061637; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ENcOYGqRioU/9ihcSEEFfnUaDfvEIG5xAfpIwJ8DI8A=;
        b=mHhxAHcEvNSvxr3GKPuedsXvO/+WZfQnBwyK7ZP8uG8XulGcMVXxRQCL7bI2AYQ3yj
         pxRdtTHsYAYUZee8xP1xkkxMVigmLmeLfAIU9Y/p347jey6h8OA/Od17V0iZvxbtZicC
         tDF9aaAeQ6sJW/D9DjKQV8L77XnPpLzFvy+9gJ2MgvqhOJUgdBje7gicyno0CERWAQ6t
         +Ga7B0AARoJny0yUrbtKMx79Sa/hRyZ8HW3m6k/B1IRkvh4fYkioeBs2DusPTBEEkXjJ
         ab/+taNiM+Wn75oj3fexoP9p7aSGlffY+7CYC2hp5cj09O5StU8gP0EIHWsxIVm7qCl4
         DknA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737456837; x=1738061637;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ENcOYGqRioU/9ihcSEEFfnUaDfvEIG5xAfpIwJ8DI8A=;
        b=KRXgmzMtVKUS0Sx+hBnUMK9PBoLz2tMw0BG/KZ303p7yyeKONdQFTVah6ibXNfQUWr
         YW4fgolwtb78T1lc3sOUQ5YMApaEvGsOCxcpvBA5iMyxQo8OOgM06WcWwTowN5v0PB87
         2TI1VAM1ml4O/uUtpUGQWxctzSsaLFKqWhQc51SCgFoy7S29KauRQHVeTgq5Vw05j3GG
         /r1BU3AK9endTrfuScho4t1Jk5T82XZB8segJAURy3tVpkzBduudv3ynxR6yVT94cntB
         Q2UFRuqWv3vib31VEDAn9epOrYTNDyr+V4CiEZQDlMFhZxFRAUJccBVUyUUmfKRc6vld
         mk4g==
X-Forwarded-Encrypted: i=1; AJvYcCXwfSq+6DWZD18YBkXd4ZmVZvxFZfA+K/txQB4Cg0ywINV7ZLyOKdOtANUqfwRZ4AiNYFs0N+hZdQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj7/GlgexXdriijDFpOvq1Ed8+hqPswQyV6k+Mdku+VTujsLr3
	Ugc5jxoJA0wiDCY9ZXvOrOdaCc8I8z64KlshYBMfjjTOzfV/nqivqiW6UKcWM3U=
X-Gm-Gg: ASbGncvC2e8nblmYb0iBk0vErkPkfpn8NBOkDpqPYbGrJHqd+ZKlhh39TceTO8Cu6AU
	u3R1SiwBJDIc3+qJQtqh9MWDJlDJTeZxwLuaFKsKGebYRdTAaanoHr8fkEneM9Ck75jjfx1gw+7
	wCip+1rIpQ7dVRtXVaTjHhu5iZbdH9Aafxiau1mEemrBFjVooyHsRrAqKQ6J3LZObbny0s3oM92
	peYih63t00XDYix/20soAdz6obLIx0/0r64vkFaKZ2UnMqOxHo2MfwOveVT/SnUetND0TU+
X-Google-Smtp-Source: AGHT+IEuSER7ZHNDig6EsFOlbiWEGwJUjzQk6/UxpR2ZgEZDY1r5dRIoJzux0fIbg2I24q8x/2ZFgg==
X-Received: by 2002:a17:903:32c9:b0:216:46f4:7e3d with SMTP id d9443c01a7336-21c3550f34emr265771255ad.15.1737456837580;
        Tue, 21 Jan 2025 02:53:57 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2ceb767asm75949395ad.84.2025.01.21.02.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 02:53:56 -0800 (PST)
Date: Tue, 21 Jan 2025 16:23:55 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Beata Michalska <beata.michalska@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org, ionela.voinescu@arm.com,
	sudeep.holla@arm.com, will@kernel.org, catalin.marinas@arm.com,
	rafael@kernel.org, sumitg@nvidia.com, yang@os.amperecomputing.com,
	vanshikonda@os.amperecomputing.com, lihuisong@huawei.com,
	zhanjie9@hisilicon.com, Jonathan Corbet <corbet@lwn.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>, Phil Auld <pauld@redhat.com>,
	x86@kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v9 2/5] cpufreq: Introduce an optional cpuinfo_avg_freq
 sysfs entry
Message-ID: <20250121105355.sdrgmjv2w2256qfn@vireshk-i7>
References: <20250121084435.2839280-1-beata.michalska@arm.com>
 <20250121084435.2839280-3-beata.michalska@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250121084435.2839280-3-beata.michalska@arm.com>

On 21-01-25, 08:44, Beata Michalska wrote:
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 6f45684483c4..b2a8efa83c98 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -733,12 +733,20 @@ __weak int arch_freq_get_on_cpu(int cpu)
>  	return -EOPNOTSUPP;
>  }
>  
>  static ssize_t show_scaling_cur_freq(struct cpufreq_policy *policy, char *buf)
>  {
>  	ssize_t ret;
>  	int freq;
>  
> -	freq = arch_freq_get_on_cpu(policy->cpu);
> +	freq = IS_ENABLED(CONFIG_CPUFREQ_ARCH_CUR_FREQ)
> +		? arch_freq_get_on_cpu(policy->cpu)
> +		: 0;
> +
>  	if (freq > 0)
>  		ret = sysfs_emit(buf, "%u\n", freq);
>  	else if (cpufreq_driver->setpolicy && cpufreq_driver->get)

Maybe this should be a separate commit ? And also I am not very happy
with the new kconfig option. I don't want others to use it as we want
to get rid of this for X86 too eventually. Making it a kconfig option
allows anyone to enable it and then depend on it without us knowing..

Rather just write it as "if (x86)", with a comment on what we plan to
do with it in few release cycles.

-- 
viresh

