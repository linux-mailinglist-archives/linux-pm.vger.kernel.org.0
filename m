Return-Path: <linux-pm+bounces-9063-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9552B906695
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 10:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 870891C23A6A
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 08:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741921411E3;
	Thu, 13 Jun 2024 08:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZcsTWxZ/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54841411CF
	for <linux-pm@vger.kernel.org>; Thu, 13 Jun 2024 08:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718267044; cv=none; b=j01clUcEed9uHyHstCuGPoxKFpscI/KnX3a3UABqHs34cdPXWNBOdVgIGeAzvvGDw0psbElxQz9/J0fVxRXx71uomPHNFhEyXw82mTPGFOrA1u17NdK9+nPjy++MC7tBdZjXeLTB8XI1zJpTG2C/4uVBfArC/xMl2CydJBOU4ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718267044; c=relaxed/simple;
	bh=SIXy0OVo9Ic8KFZ/rn3UzCvwZsGmegStum4r9dLd0MA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aX+t72jJXSK6tvTrN1imUOhhZE54ciEJR+wCTZ3omsjj+P4fjRIXvrwk8+epJ0a2BD0RVXwsWNjh2HWgagLLC+tLMG8CUrCY7N7lFdjBUKDN6E4aRQr7mcdjkBGWbmiqh3W0wSp4w5pKMuGGv1OfiAyr+vFc0KrFQYBOFZGShaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZcsTWxZ/; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f717608231so5932015ad.2
        for <linux-pm@vger.kernel.org>; Thu, 13 Jun 2024 01:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718267042; x=1718871842; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6+6+usDYkKQ0dlRkIjPmNIUEs1/Vzw2x1ftt6wqnSBw=;
        b=ZcsTWxZ/AVvWADOSv446QKYPpXqpquprnHzmEODXnqV1Rcdl2sdWQtSWwyrf4t19Ar
         ywNK6uG4ndeTruubLGsJRM8d5V/ejijEVI0qNCNoWpINqdw9ohcRIG1Rtr+W4B4bA0Nt
         em4AoigM57PYp8qoUOatVBsbu6b21itqpJD3uE7DPGZtTVfJTtuArpVdKmqdhPofiEj2
         Rkd5hIKtbHQU2SrSrepfGiL7/uvE1rutg7SO8bigfsikWwequJq5Psvz+Yedug4tD02z
         EkWaIJc60nE1RyfKa9SQUYJgIEhD9tmiTjFceBNjbybRwTROy5t4okQ5eJCXlSEIvozN
         IAGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718267042; x=1718871842;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6+6+usDYkKQ0dlRkIjPmNIUEs1/Vzw2x1ftt6wqnSBw=;
        b=BbpPWgK/AAx3H0+rsvPcijwTVWxUx0mvzTqmitOTtGgPk9wuE/03OOWiF+6m7bkJP/
         6ihNdzL0eexyZfAtFCbk5SNhYnocj2OW9sF6GnreHRgcrd73TGV35LHnEXRlOqCtN2yV
         8iayDjPp7apcb7dGIca6lHppBUJt5SGqw/Vx9vadnalzGCDCip5BmxH3FkipM/+T64Yk
         M7fACA8050YFhhZrrNOQ0RfYn3kRd4dOajiF50qIZJB0Wj5yex10QfwK0myybaF+xgPO
         vMPhLMCh+kGBUbbRzgRE7I3lB0zHnv5kB3UjFvQkvSWj1ii5pCte9T+Y2dsbgJ6jsaWU
         bl/A==
X-Forwarded-Encrypted: i=1; AJvYcCW0jWaXJaIplfZ8Ftr71/7Ar0haRd2+H5v2YOB41kpQWvtjHy4KX4S8lUzWqU0GioM/aO1tW7zRTK9EjaP4WfPivftv9CX6aA0=
X-Gm-Message-State: AOJu0Ywz4ex3rYNg83i4ITZd4wHVYB8g62Sp5UpQiuno/4cug9xtrAOi
	Ux8i/pspbLaB6qkuN5yWGW3SDVVekqJGdz6UMJTMNQD5o9odvz4nXEq0MmoROdOau5LkNXJziVG
	l
X-Google-Smtp-Source: AGHT+IG4MTtMkaeKeX34MtAXDNnMxyZUxgfTfij1uPHLxnH5Fnw3tqztPzx96qne3pXbOmKxJVeEnQ==
X-Received: by 2002:a17:902:ecc2:b0:1f6:4ea9:6a71 with SMTP id d9443c01a7336-1f83b5f2374mr49510225ad.23.1718267041796;
        Thu, 13 Jun 2024 01:24:01 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f15a9csm7793055ad.222.2024.06.13.01.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 01:24:00 -0700 (PDT)
Date: Thu, 13 Jun 2024 13:53:58 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: ionela.voinescu@arm.com, Beata Michalska <beata.michalska@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	len.brown@intel.com, vanshikonda@os.amperecomputing.com,
	sumitg@nvidia.com, vincent.guittot@linaro.org
Subject: Re: [PATCH 1/1] cpufreq: Rewire arch specific feedback for
 cpuinfo/scaling_cur_freq
Message-ID: <20240613082358.yq2lui6vc35xi53t@vireshk-i7>
References: <20240603081331.3829278-1-beata.michalska@arm.com>
 <20240603081331.3829278-2-beata.michalska@arm.com>
 <20240603114811.oio3uemniib5uaa2@vireshk-i7>
 <CAJZ5v0j1bqhmKrJirw+WgEVDdszZ9xQSgmfazVKMVa8H6_5TSw@mail.gmail.com>
 <20240606085513.pptx5dtjcvvg3zo4@vireshk-i7>
 <CAJZ5v0it5vZvzkbErkGOVruPbkxgr8VMTgQzsncpdQmvCOfBng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0it5vZvzkbErkGOVruPbkxgr8VMTgQzsncpdQmvCOfBng@mail.gmail.com>

On 07-06-24, 16:21, Rafael J. Wysocki wrote:
> On Thu, Jun 6, 2024 at 10:55 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > What about this, hopefully this doesn't break any existing platforms
> > and fix the problems for ARM (and others):
> >
> > - scaling_cur_freq:
> >
> >   Returns the frequency of the last P-state requested by the scaling
> >   driver from the hardware.
> 
> This would change the behavior for intel_pstate in the passive mode AFAICS.
> 
> ATM it calls arch_freq_get_on_cpu(), after the change it would return
> policy->cur which would not be the same value most of the time.  And
> in the ->adjust_perf() case policy->cur is not updated by it even.

Yeah, we would need to do the below part to make it work.

> >  For set_policy() drivers, use the ->get()
> >   callback to get a value that can provide the best estimate to user.
> >
> >   To make this work, we can add get() callback to intel and amd pstate
> >   drivers, and use arch_freq_get_on_cpu().
> >
> >   This will keep the current behavior intact for such drivers.
> 
> Well, the passive mode thing would need to be addressed then.

Right. So this would keep the behavior of the file as is for all platforms and
simplify the core.

> > - cpuinfo_cur_freq:
> >
> >   Currently this file is available only if the get() callback is
> >   available. Maybe we can keep this behavior as is, and expose this
> >   now for both the pstate drivers (once above change is added). We
> >   will be left with only one driver that doesn't provide the get()
> >   callback: pasemi-cpufreq.c
> 
> I would rather get rid of it completely.

cpuinfo_cur_freq itself ? I thought such changes aren't allowed as they may end
up breaking userspace tools.

> >   Coming back to the implementation of the file read operation, I
> >   think the whole purpose of arch_freq_get_on_cpu() was to get a
> >   better estimate (which may not be perfect) of the frequency the
> >   hardware is really running at (in the last window) and if a platform
> >   provides this, then it can be given priority over the ->get()
> >   callback in order to show the value to userspace.
> 
> There was a reason to add it and it was related to policy->cur being
> meaningless on x86 in general (even in the acpi-cpufreq case), but
> let's not go there.

Right.

> Hooking this up to cpuinfo_cur_freq on x86 wouldn't make much sense
> IMV because at times it is not even close to the frequency the
> hardware is running at.  It comes from the previous tick period,
> basically, and the hardware can adjust the frequency with a resolution
> that is orders of magnitude higher than the tick rate.

Hmm. If that is the concern (which looks valid), how come it makes sense to do
the same on ARM ? Beata, Ionela ?

I thought, just like X86, ARM also doesn't have a guaranteed way to know the
exact frequency anymore and AMUs are providing a better picture, and so we are
moving to the same.

If we don't want it for X86, then it can be done with help of a new driver flag
CPUFREQ_NO_CPUINFO_SCALING_FREQ, instead of the availability of the get()
callback.

> Well, this sounds nice, but the changes are a bit problematic.
> 
> If you don't want 3 files, I'd drop cpuinfo_cur_freq and introduce
> something else to replace it which will expose the
> arch_freq_get_on_cpu() return value and will be documented
> accordingly.

Well it is still meaningful to show the return value of the ->get() callback
where the hardware provides it.

> Then scaling_cur_freq can be (over time) switched over to returning
> policy->cur in the cases when it is meaningful and -ENODATA otherwise.
> 
> This would at least allow us to stop making up stuff.

Maybe a third file, just for arch_freq_get_on_cpu() is not that bad of an idea
:)

-- 
viresh

