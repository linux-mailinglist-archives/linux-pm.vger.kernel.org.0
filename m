Return-Path: <linux-pm+bounces-25526-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB80A8B2F4
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 10:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20820189EE76
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 08:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DA022D7A1;
	Wed, 16 Apr 2025 08:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tQTIoTgN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF59347B4
	for <linux-pm@vger.kernel.org>; Wed, 16 Apr 2025 08:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744790908; cv=none; b=AD+cJLbGKW+0scN9enk1fBNxzv6bFWp30m5hEdxg2MyakLlu8RNDX12Pj1YG+QsLZgCpKkTxv1DrzNbAthneleEdx2p7abl5LmK6c0/76hL8miL1UAglu2eM/oAvfBpauEtt6Y7+MbgeOrBr03aLxsVdyGLar2b/LUUk6rgPV3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744790908; c=relaxed/simple;
	bh=cISqzIV2rgmQuFECu6naEw6ahnHMaxpCS8NBxarpuTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tI3a/DjG3Rt9EpcL8DigUju9ztvrLroq6LWB52IX5cdreCX8/xj4aJsK/c8mEALLZ5xops1ZWnTT9jW/YqodPDo/NnO1RZlI7ZPDfi65/md2ZZ41pikBqyAnzOJd8JpwFvYajIu5SbNZgMtpNnzWOJuGmq3UA7ipnH1qe0/3UWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tQTIoTgN; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22928d629faso63178865ad.3
        for <linux-pm@vger.kernel.org>; Wed, 16 Apr 2025 01:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744790906; x=1745395706; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kmSfwQ+4oMYT6Kcqo2GkIzn25RS/V98reH2HMxWJJ1E=;
        b=tQTIoTgNqAXrldVnYkxogF62Z+ZlQyDqc2J0yfJ4ymfY0EKOxKgkWd5Ry7DLfvbBEj
         2Qvzkzc/SeNL82IPXzfPMNOdnJX+bKPJRaDCM8V6VJEN5Miw3hNYaHH2RkIVFNG5F1ct
         BLckGogd3SidOrpGdqs8bOuFTJMgkyUrbyCx2iEZoHQaLc8WFxuZBQxIpSjXAMXLWWO8
         Hf1uepXj5lFF6C78eh0NjPYu9wxZKWwTZEl5LtRxhwjnpNnls+8moRRBcaWpuwtG1Jkl
         K2hzK13e9RGBV7WfgnRW23jrTlcbRCBVMjRDDuWuv1JQOGcBsoVgP63V0UgF3LSLZuH5
         pq8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744790906; x=1745395706;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kmSfwQ+4oMYT6Kcqo2GkIzn25RS/V98reH2HMxWJJ1E=;
        b=M0hHd66OQ7wN50qmMSSIJpFkmtkGuUkDcgg8a7WN3CbLjgpvq7bJDXbGcAnuiM/Oht
         UnEwwBOPW8fx/exXOSRpYOWKOngKStd+Yozdh0aOn4CXDyuMF2U8KvKfyk6pCC5OGqrJ
         e+Lj9mEc7ZxHGfOCAEwGok8iQI+PfB1KMFkZYaMWZZFLibV2AaApU0YGecXVZ9XS6601
         HXJYgnRmU81qcPFV0EN+3N+BvHBp02Q2orUENb4ZiDepchqIFc9ev2wlFUCZP+arQ5lx
         ji23z+TX9tj4Z4j/C2846k5mV/xd1iaBpk3eIyCdMMc0Dkk9Vb/pM8A+x/S7CZzEFRxp
         /t2g==
X-Forwarded-Encrypted: i=1; AJvYcCUZc8FpMqAOL0bI3aq6n88sKiAirC4iPP//dwJ9zVIdj76eMK+3s86hkLxlOvbfZUyu1xgMOSU0zw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyY2lyln9E4+rsPY3CUrc5rn/vZCFhL+rOiP8IviUgoqaAavgPg
	fz2eS+USiAcH5IkN0onNh/UgWr4JCIGMxGe1tY7tdIp8HVxpPOOJ6z275DRZq3s=
X-Gm-Gg: ASbGncsOsLI0u+iXmmXsWs5AvkZYxZCeFMGvxzggBTJ22QZgYQeeqeMVCEiISXDIPfl
	qqJzBvX9oLBntoQZ8tcdY4Fm4xuIJTzpeheCq0OpXpgI0dISsdc/nFDPypYL9gupfbu9sHm0nJ0
	ePaVugK8PVKK2yT412nokGpNvQ9PqU5u2TmI8y29fJo0/ZveLHYH2CLmRiF8a1yzCwH18tUWyNU
	kG2PRn8/3mqOI8MWR/NAqPzwxXEbaVPcg1iiYRH2Q+GEWwGkfWq0qa1yRFTZ/6ayCGusBwMT/N1
	JxH1pa0vSQVE8UrAvOADPhBCXYMnyxBNBg1ahH1qSw==
X-Google-Smtp-Source: AGHT+IE6TlfbDAIcOi0+kKiF9dSLIx1avDG6iWMigbvyHt10Iqv0HYIjEVBLNqGX+RGWKXXryiaNag==
X-Received: by 2002:a17:902:f643:b0:223:44c5:4eb8 with SMTP id d9443c01a7336-22c35964dc7mr16617625ad.32.1744790906135;
        Wed, 16 Apr 2025 01:08:26 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33fa5f4dsm8011945ad.121.2025.04.16.01.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 01:08:25 -0700 (PDT)
Date: Wed, 16 Apr 2025 13:38:23 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
Cc: Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, stable@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] cpufreq: cppc: Fix invalid return value in .get()
 callback
Message-ID: <20250416080823.o6urglwgm4qdx263@vireshk-i7>
References: <20250413101142.125173-1-maz@kernel.org>
 <23466140-5d0c-435f-8e73-d1c4826930ec@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23466140-5d0c-435f-8e73-d1c4826930ec@huawei.com>

On 14-04-25, 09:35, zhenglifeng (A) wrote:
> On 2025/4/13 18:11, Marc Zyngier wrote:
> > diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> > index b3d74f9adcf0b..cb93f00bafdba 100644
> > --- a/drivers/cpufreq/cppc_cpufreq.c
> > +++ b/drivers/cpufreq/cppc_cpufreq.c
> > @@ -747,7 +747,7 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
> >  	int ret;
> >  
> >  	if (!policy)
> > -		return -ENODEV;
> > +		return 0;
> >  
> >  	cpu_data = policy->driver_data;
> >  
> 
> Reviewed-by: Lifeng Zheng <zhenglifeng1@huawei.com>

Applied. Thanks.

-- 
viresh

