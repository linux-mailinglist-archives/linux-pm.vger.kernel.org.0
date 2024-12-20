Return-Path: <linux-pm+bounces-19569-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0632F9F9057
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2024 11:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D70C71896D84
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2024 10:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F8B1BFE10;
	Fri, 20 Dec 2024 10:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWOU2qXt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DE52C859;
	Fri, 20 Dec 2024 10:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734690983; cv=none; b=dmIR7SZjzN3Ma3m06SvG6qhM/C5vVD7Gko2p3p7Zi+Yavk+xwLOZ3yMiZEY4uXEHbqOjUJpNwx09uDcJ+zDgtui1LYBBZDnIgXzj9ZBRU/5Xb7jhasiAVMaHA+0xrg2D6+xL9FOxZkJXqw5RtxANuQMaCAxfVN4DwlY3cg4GyaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734690983; c=relaxed/simple;
	bh=5ZEY+r5qQ+AMYuZ7XFhExXY/85ImD6gfTOM4YM4hv3w=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fjdQ98zaW6FuDa0Yo2ibogH5MipUZKTa26R9gRl/p8tudlbGOhySyzo27qDC66x5+p1yD27NbsmVG1XMnFupB4NRT1YvkzImujbka2li6/pkR76c/C7KxCYzsfylc386J86CWbaolJJT/Dxo9o9p9Y8M8xezimx3GpZnV4GF/Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NWOU2qXt; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43622354a3eso11991605e9.1;
        Fri, 20 Dec 2024 02:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734690980; x=1735295780; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4AxlDXOdbX1NGFPQpTvVqnJBNKIwf38rf+x+0J3lvQ4=;
        b=NWOU2qXt5X8N138gUGwU0qpi4u3B3X4U7hl2jjHrEdL2TEN3UTZpOUoRehbVHNSHfL
         4RTlXHtD2y0IUWtcaDP4W7zB8FexP6JIjfR+7ZFpfr7H0xtbH+T8272JRQiLgJpb5UR3
         HHyzVQ/xeVuY8fSR0Q3RoqgQgby8L1MNu3nWJyS4N+hbEYMK3QMDw9yTXn4XxR+yRtEU
         TM+s2bYm3ZhiGeTE0k1Y29Gculvs2XvrbqZX5Ah1FCzdtQ8mzoLweX1jdnyMg+pW3d/S
         cStXlhO/NCKN64qx/UwjwEnVplUx2ocISioE6I6YrUPjZqIXRgo6IT0mul/hTTK+A+Xy
         hseg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734690980; x=1735295780;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4AxlDXOdbX1NGFPQpTvVqnJBNKIwf38rf+x+0J3lvQ4=;
        b=uVqyWC7RHqNZONWM39olwk4J8p7/RVUTC+Mzzpg4A/mZvdOeAvi95Vb7zSLcavKoEm
         DynI3VTeqjST7oZzG1EoaZ8SouxvdGU9OtTG7WD0uQYC/hLdzZPfY1QI2z4+1NhSTSOi
         QVYBPmi8gStMSM6HBk1DGIMINlDmTKGJZU1y4gvlqGD3uPkjMrp/uFPXai9KiWW10iZa
         mIBGvUgWs/G4Xy7FkYzjV4AAhukF+ubCvv/Is+Nmdo/y7K5gv7NxwWYiHXT3ekRXtxjg
         sfzxfkujYkUwlvg8kN34Nny18kZ3yppR8vslMHjh2XRMwz7c0c9Gk7ptS3+I96q/v6vQ
         wwFg==
X-Forwarded-Encrypted: i=1; AJvYcCVOWLawhuB2wNIEHeKTaRBakGh1fIvJCyjn3or+JOYMZbmSnwWnSQh+GVxIg2OTCPfk/2fD7GTPqfo=@vger.kernel.org, AJvYcCVm3z3pmlIh3CJLYDrWTqAk0UJ9w9ysRIitpICl2eaUQvjD1wkPAE2yjoS1FERibyedR7G7glQhkTi+GDQB@vger.kernel.org, AJvYcCW2qdQTUgIiOzVXO3QYoDfA3b/5xRwtAmqpveIkelGAPEws3KEPch1+0RJ8Hi8cZEKgtTtoMmjuz223@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8bG6mIw5PklpdxEou6+JIPRTIidVxPA/GmUiE7nxDRGofaoS7
	48QH5tGhm8OLnx0ocbJhYumBATTWwltIyrdn3KIySG4wGLbYd0AO
X-Gm-Gg: ASbGncsEhmU3MQ0WFdz09VCWKbb3s9rBA7Ylm9jZ4PXNVelt3YMRJewLP5sxDexZ9L7
	sb2y0W9EYV70kww1AfuibGk6vEfX25W7lUw/cuvOAaSp9Xj4nHmiPvUsfH/ZvpdIEEHev+V+Z5Z
	riF9jR/bb5cnU/Yakehdl/WonR8kuruFipHrP4Ws/KJ3osjOMt9REc+GJxd647ohl62Sx84e2BO
	gDTiq1m3fMeUX4Ef6fAHXxgqAcY/+sgEgMvxK8SYi6+rY/g7WpDagUEwyYmFKwZ4f5FRY7gjIWc
	mR/ImyoAe/GFWU2W0pz1bCcv8A==
X-Google-Smtp-Source: AGHT+IF2Qdcxxt1R0R++BV7eITFAXb/Wj5U7hOYNI4VeDmzZWOtyS4Gwa0cTfnRVbIHoCAL304lHlQ==
X-Received: by 2002:a5d:59ac:0:b0:386:2fc8:ef86 with SMTP id ffacd0b85a97d-38a221fac08mr2245628f8f.14.1734690980197;
        Fri, 20 Dec 2024 02:36:20 -0800 (PST)
Received: from Ansuel-XPS. (host-80-181-61-65.retail.telecomitalia.it. [80.181.61.65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a2432e587sm823346f8f.95.2024.12.20.02.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 02:36:19 -0800 (PST)
Message-ID: <676548a3.df0a0220.16c730.268c@mx.google.com>
X-Google-Original-Message-ID: <Z2VIo8I6O301MnGy@Ansuel-XPS.>
Date: Fri, 20 Dec 2024 11:36:19 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [PATCH v7 2/2] cpufreq: airoha: Add EN7581 CPUFreq SMCCC driver
References: <20241206211145.2823-1-ansuelsmth@gmail.com>
 <20241206211145.2823-2-ansuelsmth@gmail.com>
 <CAPDyKFovtfR7BiXBfH-79Cyf1=rd-kmOoEnEdMArjGUxSks-Aw@mail.gmail.com>
 <20241213040001.jaqeuxyuhcc73ihg@vireshk-i7>
 <675cb6b2.050a0220.149877.5bab@mx.google.com>
 <CAPDyKFq7c607_NtiEF=4HinL5HABv7+fW9EGi1xfwpOpUPO6Bg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFq7c607_NtiEF=4HinL5HABv7+fW9EGi1xfwpOpUPO6Bg@mail.gmail.com>

On Thu, Dec 19, 2024 at 04:23:52PM +0100, Ulf Hansson wrote:
> On Fri, 13 Dec 2024 at 23:35, Christian Marangi <ansuelsmth@gmail.com> wrote:
> >
> > On Fri, Dec 13, 2024 at 09:30:01AM +0530, Viresh Kumar wrote:
> > > On 12-12-24, 13:01, Ulf Hansson wrote:
> > > > On Fri, 6 Dec 2024 at 22:16, Christian Marangi <ansuelsmth@gmail.com> wrote:
> > > > Hmm, it looks like this needs to be moved and possibly split up.
> > > >
> > > > The provider part (for the clock and power-domain) belongs in
> > > > /drivers/pmdomain/*, along with the other power-domain providers.
> > > >
> > > > Other than that, I was really expecting the cpufreq-dt to take care of the rest.
> > > >
> > > > To me, the above code belongs in a power-domain provider driver. While
> > > > the below should be taken care of in cpufreq-dt, except for the device
> > > > registration of the cpufreq-dt device, I guess.
> > > >
> > > > Viresh, what's your view on this?
> > >
> > > Sure, no issues.. These are all cpufreq related, but don't necessarily belong in
> > > the cpufreq directory.
> > >
> >
> > Problem is really DT schema... I wonder if it's acceptable to push a
> > name-only driver in pmdomain just do detach from cpufreq. The cpufreq
> > driver would manually probe the pmdomain. Is it acceptable?
> >
> > Or do you have alternative solution for this?
> 
> The power-domain provider driver should use the compatible
> "airoha,en7581-cpufreq". This driver should be responsible for
> registering the genpd and the clock.

Is it ok to have clk provider in power-domain driver?

> 
> Potentially, the power-domain provider driver could also register the
> "cpufreq-dt" platform-device. To make this work, we also need to
> extend the cpufreq-dt driver (maybe extend its platform-data too?) to
> be capable of attaching the corresponding cpu-devices to their
> power(perf)-domains. For the moment, this isn't supported, but I think
> it would be nice if it could. Another option, would be to use an
> additional separate name-based cpufreq-driver, as in the
> qcom-cpufreq-nvmem.c, that then becomes responsible for registering
> the cpufreq-dt device.

Well a simple init/exit driver should be ok, we still need to have the
custom function for opp so a specific driver in cpufreq is needed
anyway.

> 
> Viresh, do you have a better approach in mind?
>

If both are ok with this approach I will:
- move pm domain and clock to pmdomain driver directory
- rework the cpufreq driver to an init/exit implementation (no
  compatible) and just register cpufreq-dt with the custom opp
  OPs.

This should work and make everything well organized.

-- 
	Ansuel

