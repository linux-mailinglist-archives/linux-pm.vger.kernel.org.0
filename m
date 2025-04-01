Return-Path: <linux-pm+bounces-24684-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20166A77698
	for <lists+linux-pm@lfdr.de>; Tue,  1 Apr 2025 10:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50D2E3A58EA
	for <lists+linux-pm@lfdr.de>; Tue,  1 Apr 2025 08:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640111EB19B;
	Tue,  1 Apr 2025 08:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Iecj2nKx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C971E47C9
	for <linux-pm@vger.kernel.org>; Tue,  1 Apr 2025 08:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743496739; cv=none; b=dMwPMaTnNVo0AF5X85Mc9z/Uw6vsQNredZb3YE90uhp/0kEMxSnZ4co4oay25/g7VBwCU8F2cVcNGZswXVm795DaTzowzcC9vVyFz0aCqOcfcoenR85/BJBTWwrfw2x7ZT+YZCkvO60/GM+C44QrYzQMAkYSg6wQ2009daxdZYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743496739; c=relaxed/simple;
	bh=+UMzpq3/VcMiqNxd76Kwpr680rC1FTuJOdadFsqvWtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o/6ru+fd3vmaS+JLMpcKMTiy0z+dlsTczeaBBFKBbv1l7Nv0uh/ThlOqLCGlXQh1A/Co8vZ1ZIHpSmRtmOrURZIDW+QkVpoZyXSydRtyeD9pfa+oNMtrbOyP1WY3LEUjR7QPKDEy88HAMB4EYQmlQVDkxCRN3lrukOIgmMxFOOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Iecj2nKx; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2241053582dso82676215ad.1
        for <linux-pm@vger.kernel.org>; Tue, 01 Apr 2025 01:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743496737; x=1744101537; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r1Taw2b+9DYZnr4u5cKg6Ys1jliSkhsn+4gby7I7olg=;
        b=Iecj2nKx7pkwL6a5nvqnukg+FoyHOcwq1tiLJ8Bz1wnTCZahtFRXcOPBqFURSk+MA/
         FUSv6rKaKe3INIi76xAW0FLT79lXxY+QvZm+ohOuHMRL9/J194KSffnYAsI1VL4oUtSQ
         FzC8mHapRhUhKM/m0j1K52W78R8nAtsrbIM7357y0K0RLBd6z1r2OfuLf/AxpzwUdsDj
         ua2QmMnAvAFc2Lb5Z32HSwjtdd3BIcjh8AHvoYk4g/f4FAIoV+cnt9AfLojkMjJ79wix
         K+koxcn/CdRaCAeq3dmoXNHavu9LhMTFnxFsAzfDck2qu9+PuPJMR/DVI9vhlO1QQO9a
         XJ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743496737; x=1744101537;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r1Taw2b+9DYZnr4u5cKg6Ys1jliSkhsn+4gby7I7olg=;
        b=f5FJ1ejkiXvL9IQP4EISeBoo6I8pbWhYlxCkI46J322ZJyhPHKKbl5PfWMkCoSa0Lm
         d0CF2ZmluxlowtXHxQ6fd65PbxyZjxp4t/tYQ4MSZb2Cpt7prINAWdgsI+SP6XSPf7cq
         JnwTBVXXCh3rBM//9Cg3Rk0WhYePCo6exH8NFcYb5cRZvNoRT+UXCGJFA+2hNsWQvsPa
         Kc6e7Jd/jQ4Brx2dJDmSDLh3z3AlqeJfURxCAT23gFdr1mwyLQciCsvWFcMtmX29vWhi
         iPnFr08uiUpfuoPMZvRrxtBc/u50JHizKVavt1cJ/LPwBqZqUiRlc6YCq8cRIVy+ReTX
         t/MA==
X-Gm-Message-State: AOJu0Yz5jLR3pukshucrzyXs6NTUYkWpDvVNcgk7OOiTAT+ZA3vw/xZJ
	Sr8PR4+gla8HTzfD+0Bov4VqDENQul/y4TDwa+uR+mK8MjNo3M9THtyheUmHfxA=
X-Gm-Gg: ASbGncvTbkI3dtl93Ifzfp9o6Y6x11lwHXKbRb0Kf0gzxMf+jvHH5VE1/SrMOmhyijT
	sE/0X6a43saNIKyz7M9cdq7ujbRNd0KTHHR0oSg+4szEFP9R5HSIm9n3Y8mveqglLE8mdmvlDKC
	+tbfTBbkx0siFfTRmc9isxWTb6L/FJrYaEjYPcQXVCibIhGU35kbFsmzvI8cqtW/EHPoRv3nSh9
	yJSeGyQbeKrGts7pe2Laa9QEdPZJlk5HpG11fI0bWaSB3Q6xmCrdD6koDpeUv7t9RnWU0uyXc0F
	XAV2cj+OvoSeWHJcEu0I4WpcTAYLuqzJXo1rRzhiIdRWOw==
X-Google-Smtp-Source: AGHT+IHOoPSYd39+s2P+I5W5gcza3K7JJCd5GqnM6mc219v8oqynZ5VFgBSd9yG4NA+PxlZ6utEL3g==
X-Received: by 2002:a05:6a00:b90:b0:736:42a8:a742 with SMTP id d2e1a72fcca58-73980395331mr17654701b3a.11.1743496736959;
        Tue, 01 Apr 2025 01:38:56 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73970e4cb56sm8319319b3a.77.2025.04.01.01.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 01:38:56 -0700 (PDT)
Date: Tue, 1 Apr 2025 14:08:54 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v1 03/10] cpufreq: Split cpufreq_online()
Message-ID: <20250401083854.6cp2efo7wxvxjcdd@vireshk-i7>
References: <4651448.LvFx2qVVIh@rjwysocki.net>
 <3354747.aeNJFYEL58@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3354747.aeNJFYEL58@rjwysocki.net>

On 28-03-25, 21:41, Rafael J. Wysocki wrote:
>  
> +out_unlock:
>  	up_write(&policy->rwsem);
>  
> +	return ret;
> +
> +out_destroy_policy:
> +	for_each_cpu(j, policy->real_cpus)
> +		remove_cpu_dev_symlink(policy, j, get_cpu_device(j));
> +
> +out_offline_policy:
> +	if (cpufreq_driver->offline)
> +		cpufreq_driver->offline(policy);
> +
> +out_exit_policy:
> +	if (cpufreq_driver->exit)
> +		cpufreq_driver->exit(policy);
> +
> +out_clear_policy:
> +	cpumask_clear(policy->cpus);
> +
> +	goto out_unlock;

Instead of jumping back to the function, won't declaring the label here and
jumping from the earlier code to the end of function more readable ?

                goto out_unlock;
        
        out_destroy_policy:
        	for_each_cpu(j, policy->real_cpus)
        		remove_cpu_dev_symlink(policy, j, get_cpu_device(j));
        
        out_offline_policy:
        	if (cpufreq_driver->offline)
        		cpufreq_driver->offline(policy);
        
        out_exit_policy:
        	if (cpufreq_driver->exit)
        		cpufreq_driver->exit(policy);
        
        out_clear_policy:
        	cpumask_clear(policy->cpus);
        
        out_unlock:
	up_write(&policy->rwsem);
	return ret;
        
Either ways:

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

