Return-Path: <linux-pm+bounces-9620-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D33990F6AF
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 21:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63D361C244E7
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 19:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673DB15886B;
	Wed, 19 Jun 2024 19:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y3Q41HtG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC945157E9F;
	Wed, 19 Jun 2024 19:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718824056; cv=none; b=dmUIPLdsaafxILF6pMlIyaxsXsJVuHvKp6N/s3QSQ+TSxq6kB/wWx47gasxkZaxQULchYccGvgqUv35vvb0Dj4cSnBFMASykyrDD/DXz5RFWeaJiy6HBhcSnG4U7Q2Mi9d21uHHXyE7vFpHiFpzQQ/eHM4o716Oc57JwfF8Cn2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718824056; c=relaxed/simple;
	bh=OHTKHbgDcUuDM9WSWEkCdSCCkh+hGLUoc2e6+HLVrcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m8KMsLXQ8IoyLsLON7MtDl5S30FlUOs8ymUZiGt7VpJ3y0bwQaEBT7ZPxQaO3mXkIehQ4AMsHQ4gW/6Ix8/s49AurFsWgbCUe2PSDLV23VdHTITGPsNYFpeI7CpaMvUZO+Wb6gtTTye8ajNDpMcVVqde2j/nFqP7Wzu7MeOoPeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y3Q41HtG; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1f9a78c6c5dso813585ad.1;
        Wed, 19 Jun 2024 12:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718824054; x=1719428854; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wraK3ONwierAgU4rsIO3Kh5gYCqXGYxY/0XrGpiX86Q=;
        b=Y3Q41HtGXzn/9nqwq6RQw5vKH7LrXYKfBXJALBkt6d9rbdEcPupMjmDkwwcs9QOSnp
         Z1pNH9+m+GvppejgFXnVRGD7doN+r2PTfwyW8VFObLw3dpzT3OqW+xsPGhIXpdpsqF4Z
         hWd0L6ChZuM6EPT0+anHnHusDH0GVN/Avn2NM3qTHzCb2rG4uic9kSGiy02UM465Vk1B
         UpLAokLejkO5TOYtX5TDjSJfGZXEtb5YuT9svtjHlK4+tEp3oe6qU+Pow8O2qRj2LQHl
         hEmNuwz5iiG3CyUQy0bJ3T/QbMuJLzb6slGHdmIA6ZhQfGdaJ00bxT1EtFy4vHBkNz0D
         QaMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718824054; x=1719428854;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wraK3ONwierAgU4rsIO3Kh5gYCqXGYxY/0XrGpiX86Q=;
        b=TooaMJbIVx2ETY6RjuOM7U8UmxEnrG1/alUi/NEvHm0eZWiO0xkU7yBSwbwum36QHE
         5ylLoYSEmmJGepvMSULemJI0twDWzVAlLSWBdrB6SrOUpa3LS3q9IwsxILBqy7eHEWfx
         jT3fKDzGvWuTo3k/h1VyemilcfU2TFyVnYXeoets4q+QxcA4aYJNW2h3MVZ62L8yu1MV
         rk4cmj2ZOrhyTf5yd3MhLw+u3tBLrNC4RlYCj+ER0bgJhdIq6GMOWArPnhCI84Ky3DxN
         Jds1rvrvLPXr7Q/FHogXheIuaIK0Cyj2U14J93ZkiBIK8kvmEuiXLeVoglJzJKDaeXNf
         0oIA==
X-Forwarded-Encrypted: i=1; AJvYcCWTaAQE2vvpz4+SiePlXyCgu5gwYmKJzWIbi6YYSHYkCVS0JNLuvOtW3OVEaBdfEWDvnbRmEJLeqTfqdLqtxVAxKKuE3e9ErpQGNR9qa0ENrUTNNp8BBo53s/e3CTjFAIRR+1tsMb4=
X-Gm-Message-State: AOJu0YzpuY+n4/Wrzc+wW9af9jFECDUkGFJNNsLTUIvlIBSUODnXh39l
	l+MBV25ni4JwBSc+1z6gLR2Ys9dKWqFVvSfy5pbj3FZYl89cTA6S
X-Google-Smtp-Source: AGHT+IFbPfbQOoO+ZhzVOsj/iXop22+2lvzkY0qWIhHiXpL5mXfhLa0lgfgGaFlPCpIcgmo3lz9BgA==
X-Received: by 2002:a17:902:d581:b0:1f9:93fe:a1ea with SMTP id d9443c01a7336-1f9aa4335cbmr37736955ad.35.1718824054152;
        Wed, 19 Jun 2024 12:07:34 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f29011sm121227925ad.249.2024.06.19.12.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 12:07:33 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 19 Jun 2024 09:07:32 -1000
From: Tejun Heo <tj@kernel.org>
To: Christian Loehle <christian.loehle@arm.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
	void@manifault.com, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, mingo@redhat.com, peterz@infradead.org,
	David Vernet <dvernet@meta.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH 1/2] cpufreq_schedutil: Refactor sugov_cpu_is_busy()
Message-ID: <ZnMrVmutooN-YwL1@slm.duckdns.org>
References: <20240619031250.2936087-1-tj@kernel.org>
 <20240619031250.2936087-2-tj@kernel.org>
 <0c0073ef-3fe3-4c9f-9a86-5c42336b3da1@arm.com>
 <ZnMqNHzCaAmolxkK@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnMqNHzCaAmolxkK@slm.duckdns.org>

On Wed, Jun 19, 2024 at 08:57:56AM -1000, Tejun Heo wrote:
> Hello, Christian.
> 
> On Wed, Jun 19, 2024 at 03:07:32PM +0100, Christian Loehle wrote:
> > > +	if (sugov_hold_freq(sg_cpu) && next_f < sg_policy->next_freq &&
> > >  	    !sg_policy->need_freq_update) {
> > >  		next_f = sg_policy->next_freq;
> > >  
> > 
> > Not necessarily related to your changes, but in case you're touching this
> > again, maybe sugov_hold_freq() could be the last condition?
> 
> I'll update the patch so that sugov_hold_freq() is the last condition.

Oh, looking at the code again, this would lead to behavior change, right? It
changes the period over which non-idleness is measured. Maybe that's okay
but seems out-of-scope for a refactoring patch. I'll leave it as-is.

> > And do we want something like
> > #ifdef CONFIG_NO_HZ_COMMON                                                      
> > else
> > 	sg_cpu->saved_idle_calls = tick_nohz_get_idle_calls_cpu(sg_cpu->cpu);
> > #endif
> > here?
> 
> I have no idea but if something like the above is necessary, it'd probably
> fit better in the #else definition of sugof_hold_freq() or just move the
> #ifdef inside the function body so that the common part is outside?

and ->saved_idle_calls isn't even defined if !NO_HZ_COMMON and is only used
to determine whether to hold frequency, so the above doesn't seem necessary
either.

Thanks.

-- 
tejun

