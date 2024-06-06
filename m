Return-Path: <linux-pm+bounces-8681-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2349D8FDF75
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 09:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB29D2881B6
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 07:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1353B13B7A9;
	Thu,  6 Jun 2024 07:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HHWp8mxF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A40913AA42
	for <linux-pm@vger.kernel.org>; Thu,  6 Jun 2024 07:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717658437; cv=none; b=sRvFOaT3KDqj0SPgVefGfE7BkTQ4ycJ48Nju8n+SzmC5pyx0i1c/jNeFlmQHtemb9Djd6lZ1j+Efkne/X/lisW0Ktc4iPUT+Az5L/5Qim5TJpu0Uk5oOEhMLmrF0884lD7dMAu6FupYkx7FNobRP5V7xjIH5BgYDAKm2oKm3mOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717658437; c=relaxed/simple;
	bh=E1UEL5t44rjWMroslFhKMMvwn7TQfKD6dRQVyrgGjGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JUGAVnBnd2X5QJCdCU59p416FEE/3eNs49J6FzmpNHfrc68eA2vhPjfaGN1pqrifDAWqZsdpXM67bE21mbH1rFDD9drU4q9qF+J1mURxDBECEJFu2kJ9unKMJHyYh1Bx2DyOYW2e74ESRGlvryvWK3RyDhb5WRyRCtSl4AoAlWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HHWp8mxF; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-25071c66178so320988fac.0
        for <linux-pm@vger.kernel.org>; Thu, 06 Jun 2024 00:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717658434; x=1718263234; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MFC1pyOlym/b5PhJaLl2pSzHoJdyGjWFMkMHwggkOGg=;
        b=HHWp8mxFzCgxUbpUYDEVUziaQ0Dt6DpmRIe+kp+SsWABN8ICrJe/UGhGzmLMQYN2ZR
         vcWv25DEoQSqO/rY2FYBSaMfeZAsj4HM1iajfbAXHYj/z3gj9bb5tgxZPZPWIPnl/2Js
         oqFbJ33s8PyglO6X4xhmc5BtR7KZige/sWDOk+8X5AJDNMRBJR4VxroEjjVw2IcXayuH
         RDi+tamJ0rBf3VFaMIvhnu4CWFZIQfi5giZbcrUWC1FYsSMI7dQvtMkpj5Rp9mS+J1kw
         YuxrhucAt2ftWuC1oi41F2L650ZbaN0i51KxrRu6L68iXi54z+X9kBt2/KY4dV3utpIA
         X+oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717658434; x=1718263234;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MFC1pyOlym/b5PhJaLl2pSzHoJdyGjWFMkMHwggkOGg=;
        b=PfXiZDElBmRdGfQKbS4++o3xJJzi+w6lfOcm2RWLdyyxEWHV7GMnwDP7r7icre2Eal
         jT58Ruqpzi7dun3CryAI1gBegiOq4a8Phrez4Fw/5iKhNglIJ0B/CPTcofr4QIRHwMuZ
         4L24dyel+YC9MLiOEVHf4uyDwZgNABe/hMQeSlJFSwfRXSBWJK6yV8L6cOZtiBHWABC/
         tsFuTE0/XoEIViL491EVuGYnpRd/cMuhRMVPzSAatrvErdmu5QzttRmOGq4vQixCTUvA
         OgLnNXQUHPSggPq5rpYxfJfMUB2mkg9fU4BEi45Bv9DEh8rPOuB0yLh00Rh7LNQzy0i9
         j7Rg==
X-Forwarded-Encrypted: i=1; AJvYcCUtrWEh8s20wlPLvvCP/ede7+bFmF9Mvr537GpdqOQUeIZ+QMw24SM76U9+KzfwPlpg7nVoopCu+1m+d1EQ2nnj3hRlJWovj78=
X-Gm-Message-State: AOJu0YysOmDCDCVOmWbANZoo8L2cA/pE6BvKCTQWEcWONa0ufaNZiTKD
	VqAuyr2ek8d6/Vvf7+EZ6/3czirJ2o/sJnVWTNpzY5dUD4FvD/VbkxUpMTWnt/Y=
X-Google-Smtp-Source: AGHT+IFR27xMNkX9j6IYL/hxtDye3ZPMcS2DU0AeJAwbcGFpmW/2yupDkFD5vmiG+5sQzof0a11KtA==
X-Received: by 2002:a05:6870:612c:b0:24f:ccbd:75e with SMTP id 586e51a60fabf-25122094c30mr5531086fac.43.1717658434284;
        Thu, 06 Jun 2024 00:20:34 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-703fd372a82sm557353b3a.27.2024.06.06.00.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 00:20:33 -0700 (PDT)
Date: Thu, 6 Jun 2024 12:50:31 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Ionela Voinescu <ionela.voinescu@arm.com>
Cc: "liwei (JK)" <liwei728@huawei.com>,
	Beata Michalska <beata.michalska@arm.com>,
	Vanshidhar Konda <vanshikonda@os.amperecomputing.com>,
	rafael@kernel.org, al.stone@linaro.org, ashwin.chaugule@linaro.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	liwei391@huawei.com, liaoyu15@huawei.com
Subject: Re: [PATCH] cpufreq/cppc: changing highest_perf to nominal_perf in
 cppc_cpufreq_cpu_init()
Message-ID: <20240606072031.lxr7tykl7sdgjwva@vireshk-i7>
References: <20240428092852.1588188-1-liwei728@huawei.com>
 <20240429104945.esdukn6ayudgyumc@vireshk-i7>
 <ZjoBrF4bAK5ukm7H@arm.com>
 <be312b75-eede-44f5-b7f3-b50f50c6fb56@huawei.com>
 <ZmB1qKucR5fXk100@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmB1qKucR5fXk100@arm.com>

On 05-06-24, 15:26, Ionela Voinescu wrote:
> > > > > 		cpufreq_start_governor() // governor: performance
> > > > > 			new_freq = cpufreq_driver->get() // if new_freq == policy->max
> > > > > 			if (policy->cur != new_freq)
> > > > > 			cpufreq_out_of_sync(policy, new_freq)
> > > > > 				...
> > > > > 				policy->cur = new_freq
> > > I believe the problem is here   ^^^^^^^^^^^^^^^^^^^^^^.
> > > 
> > > cpufreq_verify_current_freq() should not update policy->cur unless a
> > > request to change frequency has actually reached the driver. I believe
> > > policy->cur should always reflect the request, not the actual current
> > > frequency of the CPU.

There are times when the core doesn't have any prior information about
the frequency, for example at driver probe time and resume. And so
needs to set policy->cur by reading it from the hardware.

> > > Given that new_freq is the current (hardware) frequency of the CPU,
> > > obtained via .get(), it can be the nominal frequency, as it is in your
> > > case, or any frequency, if there is any firmware/hardware capping in
> > > place.
> > > 
> > > This causes the issue in your scenario, in which __cpufreq_driver_target()
> > > filters the request from the governor as it finds it equal to policy->cur,
> > > and it believes it's already set by hardware.

I am still not sure why mismatch happens at boot time here.

> > > This causes another issue in which scaling_cur_freq, which for some
> > > systems returns policy->cur, ends up returning the hardware frequency of
> > > the CPUs, and not the last frequency request, as it should:
> > > 
> > > "scaling_cur_freq
> > > Current frequency of all of the CPUs belonging to this policy (in kHz).
> > > 
> > > In the majority of cases, this is the frequency of the last P-state
> > > requested by the scaling driver from the hardware using the scaling
> > > interface provided by it, which may or may not reflect the frequency
> > > the CPU is actually running at (due to hardware design and other
> > > limitations)." [1]

There is discussion going on about this in another thread [1] now.

> > > Therefore policy->cur gets polluted with the hardware frequency of the
> > > CPU sampled at that one time, and this affects governor decisions, as
> > > in your case, and scaling_cur_freq feedback as well. This bad value will
> > > not change until there's another .target() or cpufreq_out_of_sync()
> > > call, which will never happen for fixed frequency governors like the
> > > performance governor.

--
viresh

[1] https://lore.kernel.org/all/20240603081331.3829278-2-beata.michalska@arm.com/

