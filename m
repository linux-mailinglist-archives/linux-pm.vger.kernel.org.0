Return-Path: <linux-pm+bounces-20783-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC75A18BB7
	for <lists+linux-pm@lfdr.de>; Wed, 22 Jan 2025 07:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0128816BB38
	for <lists+linux-pm@lfdr.de>; Wed, 22 Jan 2025 06:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F32190674;
	Wed, 22 Jan 2025 06:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IVpNeB+p"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D3418E361
	for <linux-pm@vger.kernel.org>; Wed, 22 Jan 2025 06:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737526148; cv=none; b=KRTxF2I/P180YBZh32CoOSJ0VMGY3vFwkhgMkTX7O6wGw30jZA2jRbnv/qF55z4hGhTcm+LkBeo5HII8l0qYMdWo5w2AXTxL8r6ZGUYe7wUIgO+5daZncSp1/yChxrafdA3aEjlH70orkL8cwL9pkwGxcEmemDhFP7IhkFUFisM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737526148; c=relaxed/simple;
	bh=yAbgVwaidCeS/8gAa93k/4bOn7go95kWYRGKPVMdhao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B+qZfTttaLTnKik/t0sjxyXpTSXgqCvCKK3ZP+LQz6ELSlX++mzhcQs9K7A7bPwUA7KT8WHGgQaWIUd3hD81ILV5fRQZN/82/XV5moFuS3epaoEElJ71I/yeDqUl0OTqQzbTa/j+3cs4qfazqW9dr3M1CN8qPnS0bKVPZzEveL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IVpNeB+p; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2163dc5155fso123969395ad.0
        for <linux-pm@vger.kernel.org>; Tue, 21 Jan 2025 22:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737526146; x=1738130946; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hu1FBq6m+bKSyxVrg1AK520/zGRA5VRp+1CZ8HCEcTA=;
        b=IVpNeB+pxamgr8j71nzD3kR7k2WHq3E5Eh2I1COcZ58Its1/PWVQGqEOgtYjGZwsmP
         /p3iDaSrVqTC4O/AQrafTyRvP5Ci4kPTZeQHFZTbw7BbAUk3/Ka82h2nTHz+fXleCp0g
         jtIGwTQCwPV+pB8f7PdoKXD88+Sw71ko2sfTbZrDi3yWh2Iu+EMAJeMoUalaDiOE2c+8
         2QxAXml986v0DHnRcEl/SiRfZIyzjdhTOxWWIm3nh+Ku2nKHLZLkTIPElIeteCXoDwZj
         sRJo8e5adlEVfgT3CxP4U+qIWIQsJWmOLJzPzQHGBoHNFkFHt0ASA8xOVnEF1ywzRRAD
         glYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737526146; x=1738130946;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hu1FBq6m+bKSyxVrg1AK520/zGRA5VRp+1CZ8HCEcTA=;
        b=NF2FjJOryY8k0xNqiJiuj6c5sO/dsWD7SlgayfrX+OcmxNZdgYUhTG7vJma9eLSjue
         6FdZs1tqbeRPZMXuxgJZaRZCjJA8flCZ0W9GoaCCzL4dcu8O7TYN7aJNhb2cCHRjEvsa
         FwjPncK2oMKsmc01/WUgMm/r5pXWL5TE3XbwRPLzD+PpgU8fW/GhtPhPkeHJH8X8Im0+
         UiaG0e1eewPLrKygctcROTDloi+y1l9Qy99t333k5vxVNbIVN/FHSgp3wRyxDG6SAQk5
         cOBsIBqeasHjRMaNhwa+JuH0t7wvMCzKI56b4a3m9vBnPRC/4mc/t1VK3S8PRZxaKMhO
         IvxQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1CpvRqupT+XHrTzwS/0dGrrMxjUpzMJSixWzJbHYuukGM4iw1hwL51AXznikpObxL70N47/vFRg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxRQo1M2k38XlkAZWYrCpJyMPbmKh8s29vF4uDoDcoJjjW9F1Ys
	MIhLVkse5gK547JsKl56/QCNQj+tRRmP8q9rdfQ5LCNLymLIaJiNT1t1O3tVv4k=
X-Gm-Gg: ASbGnculkSWJ5Bb8kdQaGskm5WQzAVBIeqsnwIcwCbcVRqsVm3jOQCUw7ouXJiQhQfm
	hunFBMoCCESIHDqOiC92dCkfPX18RdToyrKfAQ5nmLP+BVmwUC8TbAihmDj+j1+Ut2icp2giDl3
	OWmrVbJp/jqnpkWuW21YLv7/YMVR26tsE593kNiNZhgd6IUHrLHDi8z1480LGlF3yX95kDuhSI7
	LJeI8YYuOd9hbMjbTXWFBMdGzuqxQ/yrb7HC5wB7/RGR0EYKWG00vMGAwZ/IpbmXalt5tzV
X-Google-Smtp-Source: AGHT+IHSJSlo3/oMvXCYUQyNeEOcz3KKCPVH+2Nq0e8HvWx+muYZ0l67x8Jr4dRyzyqkWmyMQacOtg==
X-Received: by 2002:a05:6a00:288e:b0:727:3935:dc83 with SMTP id d2e1a72fcca58-72daf950d22mr24987927b3a.10.1737526145753;
        Tue, 21 Jan 2025 22:09:05 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab849e1bsm10121392b3a.80.2025.01.21.22.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 22:09:05 -0800 (PST)
Date: Wed, 22 Jan 2025 11:39:02 +0530
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
Message-ID: <20250122060902.5pgfr5g24jpjrxw3@vireshk-i7>
References: <20250121084435.2839280-1-beata.michalska@arm.com>
 <20250121084435.2839280-3-beata.michalska@arm.com>
 <20250121105355.sdrgmjv2w2256qfn@vireshk-i7>
 <Z4-6bsDzfe9CLcVf@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4-6bsDzfe9CLcVf@arm.com>

On 21-01-25, 16:17, Beata Michalska wrote:
> On Tue, Jan 21, 2025 at 04:23:55PM +0530, Viresh Kumar wrote:
> > On 21-01-25, 08:44, Beata Michalska wrote:
> > > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > > index 6f45684483c4..b2a8efa83c98 100644
> > > --- a/drivers/cpufreq/cpufreq.c
> > > +++ b/drivers/cpufreq/cpufreq.c
> > > @@ -733,12 +733,20 @@ __weak int arch_freq_get_on_cpu(int cpu)
> > >  	return -EOPNOTSUPP;
> > >  }
> > >  
> > >  static ssize_t show_scaling_cur_freq(struct cpufreq_policy *policy, char *buf)
> > >  {
> > >  	ssize_t ret;
> > >  	int freq;
> > >  
> > > -	freq = arch_freq_get_on_cpu(policy->cpu);
> > > +	freq = IS_ENABLED(CONFIG_CPUFREQ_ARCH_CUR_FREQ)
> > > +		? arch_freq_get_on_cpu(policy->cpu)
> > > +		: 0;
> > > +
> > >  	if (freq > 0)
> > >  		ret = sysfs_emit(buf, "%u\n", freq);
> > >  	else if (cpufreq_driver->setpolicy && cpufreq_driver->get)
> > 
> > Maybe this should be a separate commit ? And also I am not very happy
> Initially it was supposed to be one, but then the rest of the series justifies
> the changes so it made sense to send those in one go.
> > with the new kconfig option. I don't want others to use it as we want
> > to get rid of this for X86 too eventually. Making it a kconfig option
> > allows anyone to enable it and then depend on it without us knowing..
> > 
> > Rather just write it as "if (x86)", with a comment on what we plan to
> > do with it in few release cycles.
> Right, those changes are based on discussion in [1].

Ahh I see.. What about making it depend on X86 for now, as we really
don't want new users to use it ?

-- 
viresh

