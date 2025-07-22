Return-Path: <linux-pm+bounces-31252-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB840B0D19B
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jul 2025 08:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 133A77A15AD
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jul 2025 06:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C18628D8F5;
	Tue, 22 Jul 2025 06:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ee9+xFLY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD5517741
	for <linux-pm@vger.kernel.org>; Tue, 22 Jul 2025 06:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753164238; cv=none; b=o1IEf6Ex2cSqfjPdJyhUNPTBNUUD5h5X6Pqv8d/Udmrfa1/H+Kh1WMTaKzBFQJ9f1cR9TFjzT1sMVrdSmFJCX8DixY0LPuk2nNb2AHfgxtUFtyVljllL4n7tItBQq924vNKVwOgj6DhpgXjOiCmfVK+jHkG93hvadai9CrL0URw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753164238; c=relaxed/simple;
	bh=GZjdihGuJGAFsi3c7Tuyi3hZXAwLdDcTrI1HUVatZyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=at9CYDRLHQmSZ4iauljQ7+QryWI4fgeMv7iYFnMwcnTNP9ykjdcZAQyOz7xPSqUKGWg88sPksQoY2DnLH98nVd1qe9tvMNUPCs/8LzOpOXqgJbTYhSbjW7yg6EVU8V13j6z9JNjVC+xXTgj6ufqKXPLqrvDNPKK2cbnqH1oEeFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ee9+xFLY; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b34a8f69862so3951890a12.2
        for <linux-pm@vger.kernel.org>; Mon, 21 Jul 2025 23:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753164236; x=1753769036; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mN4Wd/8Z+JBMvOvxD7RVTn6Zo5Ijr5YoqAraprQU8NY=;
        b=Ee9+xFLYdhRzNyuf/2E0QyRRFABjMT0cdk9hRByl4P7gZv3AXGubfAv3eKDVxcS2P3
         PwFB5VC9+JW8+hZnWqiFJJwga62nPIzmYhkJilNfDgDhEoZB47qFTiCR3cwOux1Q3FYL
         BSCNcpRQBJcRPr4Um/wg2z1IwxQ3YA1B2SM0AUhWCpORW45458K6g5Xp4SrcUV+epwBq
         Iluk7I1wJekq9ix4Z8XLVHitBGj9O8wq1ZQHQZ5XgyOQAqNBeUrOIDLo8BISq/g+QKNp
         sGS3zNJrhPNc+n5XxteKkvsFgpE5ZESh/ELCUEKwZ5V+QaQBXRB/pXVa9eaZt+vxVaWq
         fuaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753164236; x=1753769036;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mN4Wd/8Z+JBMvOvxD7RVTn6Zo5Ijr5YoqAraprQU8NY=;
        b=WaaLSCGNgtFVSbqhBeKM0reZuCR0Y4ZTbxEx3w+2/v8J1yo+0BAlDjlavYQqoZy1/L
         n0X6X4WU+MJVR4ADv1gqlmfrY+89CvdU6QpoBQTOh1XtgSXks8Dj8sSW+jrZwuJdDfSO
         dcfcS62ZnPAoIvPe1tqHtatuC1wkCbiNZofKkcpTbTnHbAYFsFdyiq18aMnAGlxzaEM2
         hQNibfs+UlzM8hxAvRmaAPG3qQBBYc5tHGm0X/VjBaD7pLD7D9j6Ar82fWlbjndAdFWS
         2HEnNzj3xIjXIR0IpZceuL2BVgz9KO3TEU1DuDARjTfgZnyzLDr2M1MMv3ST741oWdER
         L/NQ==
X-Forwarded-Encrypted: i=1; AJvYcCV852f+JTjONQmwhsideTBKrFbk1uOBV4ptlT0/oqAmya3tBELesBSObuVW4nMv54RiP4KPeuF4FQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyCI+kXPNeDC00msv/rCRF/EBvNmQaOF75teZV41n8lQUs1i/++
	YRWVY1sa6/4zM6D0y3Il64w8qxTNzXctgryNB/M91HqqAP1DGcQlpr0ewHSv4rIQweM=
X-Gm-Gg: ASbGncv+2nlJtPx8B4mJ7wkf+YT0qMixHfg0WSRw1Cg4crGXYyoHVpMUR307rqvSdAl
	WUwtzygG8JvTtaNx3t8X/Bd9/dz1PRVnD5vLjZmMwG1bSrbM0kqRdsw/6FnPiglEKktqRXsR54W
	s8bJIoi1iK8NagN1cTc26xx/KOUn9AEDu0Glh44XxTsDYGlVUKuFpNMbPuT8pzFKL/iKUd+DJWB
	jKbAUDbBrEZU5RpZLRELUsPBXusP37j9AQZWJ9AMP3AeWDwattxEoc/CnFtFzS+t39ZQpSGoRjL
	bz0SN6HQyzAD5vehrvpGzyS+je+wDu0O4yatZi/7/mfIPDRGPoL2iu7K1R2WlkCeEQhSSgmw3Hl
	qyJQiGF6N4zfgJYZ5dNmI3pF6tAN6J28/uA==
X-Google-Smtp-Source: AGHT+IGch7eThJUqL2zofbOetD37MUdqzx6uZ9i1unPSssEuWKh4MhkSQXdr9UAtN8dn5bb6iURClg==
X-Received: by 2002:a17:90b:514e:b0:311:ea13:2e6d with SMTP id 98e67ed59e1d1-31c9f4d0f24mr33580017a91.29.1753164235686;
        Mon, 21 Jul 2025 23:03:55 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b60ec68sm68358355ad.83.2025.07.21.23.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 23:03:55 -0700 (PDT)
Date: Tue, 22 Jul 2025 11:33:52 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Prashant Malani <pmalani@google.com>
Cc: open list <linux-kernel@vger.kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Beata Michalska <beata.michalska@arm.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH] cpufreq: CPPC: Mark driver with NEED_UPDATE_LIMITS flag
Message-ID: <20250722060352.pdwk2nrrth4uph2s@vireshk-i7>
References: <20250722055611.130574-2-pmalani@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722055611.130574-2-pmalani@google.com>

On 22-07-25, 05:55, Prashant Malani wrote:
> AMU counters on certain CPPC-based platforms tend to yield inaccurate
> delivered performance measurements on systems that are idle/mostly idle.
> This results in an inaccurate frequency being stored by cpufreq in its
> policy structure when the CPU is brought online. [1]
> 
> Consequently, if the userspace governor tries to set the frequency to a
> new value, there is a possibility that it would be the erroneous value
> stored earlier. In such a scenario, cpufreq would assume that the
> requested frequency has already been set and return early, resulting in
> the correct/new frequency request never making it to the hardware.
> 
> Since the operating frequency is liable to this sort of inconsistency,
> mark the CPPC driver with CPUFREQ_NEED_UPDATE_LIMITS so that it is always
> invoked when a target frequency update is requested.
> 
> [1] https://lore.kernel.org/linux-pm/20250619000925.415528-3-pmalani@google.com/
> 
> Cc: Beata Michalska <beata.michalska@arm.com>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Prashant Malani <pmalani@google.com>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index a1fd0ff22bc5..4a17162a392d 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -910,7 +910,7 @@ static struct freq_attr *cppc_cpufreq_attr[] = {
>  };
>  
>  static struct cpufreq_driver cppc_cpufreq_driver = {
> -	.flags = CPUFREQ_CONST_LOOPS,
> +	.flags = CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_UPDATE_LIMITS,
>  	.verify = cppc_verify_policy,
>  	.target = cppc_cpufreq_set_target,
>  	.get = cppc_cpufreq_get_rate,

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

