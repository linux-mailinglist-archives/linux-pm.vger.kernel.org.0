Return-Path: <linux-pm+bounces-10308-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E90C091EDEE
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 06:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C8C9B2149A
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 04:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2468335A5;
	Tue,  2 Jul 2024 04:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GtDjdeYG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4663481F
	for <linux-pm@vger.kernel.org>; Tue,  2 Jul 2024 04:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719895024; cv=none; b=CvBpAr8/vUjr8Bs+1/QHEf7LkbJ5JDIlO2KJktblRP7PXQLdhfKQG5Fhyk+g8u9GYzMT5b+u9GK/qj6Kgc0pnLAm4IP4Rk5TS7hTMtZhCIcEHnHplj5oXHxyyVPA5xKFAjK/X8yp/tMwWRyInFOeFgCX1XKEqzFp+oYtuySH2Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719895024; c=relaxed/simple;
	bh=COdofZI0yLe7Qei1B6Qkb1Szy1SP27VggR/s5mibXQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gH56onhKUEN6h/KvmEHQnQuiDYJLvYRExc3Z2aEtVqSuAP5vK73YRDJ5AVE9ksUSUC1V07Rc84B4a6zy2r0zKh8vy7vlYuhgRZtFPSaoNSgZ1YJ7+McqLdp5EB6IuzGHu5Xi5assc089mznUpQ5JAmAZKjTdDvmtjkgzEkNza6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GtDjdeYG; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1f9aa039327so21722425ad.2
        for <linux-pm@vger.kernel.org>; Mon, 01 Jul 2024 21:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719895021; x=1720499821; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7wJUnGUJSkYxsQGi1RA4irnfeYuwiGT6Z1uOT3kzXFA=;
        b=GtDjdeYGK4BC0yJkyn3ns2mqWmG5FIqQFq7QJ09IvM441Zex4Zrtbo7cqrSP5liWev
         T3Kg8seqh6RwMarmSgWSE+gDjplF2ixQkzeIslLRiL52KTOBAiAofUPOIkPmIqv8OH/+
         aJAWfOe9t2igz0y7k/0ko0kSP/DRD3t9ZoKyW2BWVspF4LRsxQ4myVgyPiLK+APpLkWG
         mS74caXNzAYsauDctp2FuIzJBYwKPUu7NaSADBw2/atc6ePg/SzlKxFwRU6OXiR+Kzi8
         Zuw2OCwsroLJM5B+Tq/kUtzA+fBSr06sONK4qdHW2VdwfiJPRKdldOjRy6py35cbOnUd
         RYng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719895021; x=1720499821;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7wJUnGUJSkYxsQGi1RA4irnfeYuwiGT6Z1uOT3kzXFA=;
        b=WAe5HsYAehKwiMuA2FipvZhZkMef3dgtkbhv5/BFia2A8Hlgi3qza0tlAl/XtH/n2P
         ij6DNP5HgFjiluiV6ozKwTMzXnYDOSRwvN62VskrwOxdKVFU3ZzqlMGs/BlTD8ROsa3f
         fjK3I64BkLTojzgV65KzcVgp6oZFFcsw9h8Rlknh4z+DKyP4bAUfyhA9vN5al94Tlh9P
         p9dveyEM+JN9Teh8dRMHHAerF8SW4c+8BAULgXQlTZA1EH32OG7pqQtHed9ZDndy7azA
         MjY1XhMR0wmybHtbf89ZSP2Q2gATA8O0BcXBs9fQTU8iaQAsxV+GkPTHB9cPMh9sykla
         RrWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzTLPoCh5BgiTXZW1gST3O6wGLuqeJAZPFRasMor2v6BLC5kZqjxL1cw/SRp4Ttj2y3KTpPXDELZzaNcKcSStI/w0I6N5aiTc=
X-Gm-Message-State: AOJu0Yw971QmKWhZ3EZAEhdlmS93lgUlB19IgVcr92eZ0ixoLq6Unr0+
	RDY1OQV8Gi6qHL8Vw51yY1UWH1RtSkaG5CgB1kQ5EWYCP8bda9o5ovxVNd0Anw/AsjST6SQaiEs
	4
X-Google-Smtp-Source: AGHT+IGg5crGPbSnlDPvZdZlEHxAc+4TJ6Al2n+BlUolTHf0JpxXwT5dxv/2p5/mvOy1DIjwWyg1Bw==
X-Received: by 2002:a17:903:41cb:b0:1fa:bcb:3da4 with SMTP id d9443c01a7336-1fadbc96936mr47120155ad.33.1719895021462;
        Mon, 01 Jul 2024 21:37:01 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10e2197sm73664065ad.63.2024.07.01.21.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 21:37:00 -0700 (PDT)
Date: Tue, 2 Jul 2024 10:06:58 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Raphael Gallais-Pou <rgallaispou@gmail.com>
Cc: "'Rafael J . Wysocki'" <rafael@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-pm@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: docs: Add missing scaling_available_frequencies
 description
Message-ID: <20240702043658.jwumgakxplddqlnx@vireshk-i7>
References: <20240701171040.369030-1-rgallaispou@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701171040.369030-1-rgallaispou@gmail.com>

On 01-07-24, 19:10, Raphael Gallais-Pou wrote:
> Add a description of the scaling_available_frequencies attribute in
> sysfs to the documentation.
> 
> Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
> ---
>  Documentation/admin-guide/pm/cpufreq.rst | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/admin-guide/pm/cpufreq.rst b/Documentation/admin-guide/pm/cpufreq.rst
> index 6adb7988e0eb..fe1be4ad88cb 100644
> --- a/Documentation/admin-guide/pm/cpufreq.rst
> +++ b/Documentation/admin-guide/pm/cpufreq.rst
> @@ -267,6 +267,10 @@ are the following:
>  ``related_cpus``
>  	List of all (online and offline) CPUs belonging to this policy.
>  
> +``scaling_available_frequencies``
> +	List of available frequencies of the CPUs belonging to this policy
> +	(in kHz).
> +
>  ``scaling_available_governors``
>  	List of ``CPUFreq`` scaling governors present in the kernel that can
>  	be attached to this policy or (if the |intel_pstate| scaling driver is

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

