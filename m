Return-Path: <linux-pm+bounces-20903-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A27A1AF0C
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jan 2025 04:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97952188744E
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jan 2025 03:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DD71D5CD7;
	Fri, 24 Jan 2025 03:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fC6IsEO5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F571D5CDD
	for <linux-pm@vger.kernel.org>; Fri, 24 Jan 2025 03:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737689284; cv=none; b=JrZCUku75aH2JVm4EsWSmY1Vct8xKtRZZsVCwpPh61XoaXYEYwSAU4bhbOn5IvMs0ZEmsPnCXmdrLhHupow7kDsDqFMDtYw64Hj5p7gtfQf8ERG07oR80Aycx1xjytFWAc2IOmiZOyWJSMzjSnEC1DaKwhimZ8i35kkGUj+FjPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737689284; c=relaxed/simple;
	bh=zd5mbJtlJ0Ako1I0wwZyEmzljoZUKIYnq0abszIYUmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g1Z+YrOK2pZfLhQ139/MQNHJCJ15co/qDTEVHIb4m9tG1VKdn0H2LNT0Bpvs7wKb1aSp6RUN/L5Nqc6V4Phorxr5I9Qn0Ot444O7bZCBO9bsoj7mB/DIcN8aKQn5lh6BVb4qTPQQw5VYiM03iBDJoACsApnYLU082bJgC/8DNrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fC6IsEO5; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ee8aa26415so3035540a91.1
        for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2025 19:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737689282; x=1738294082; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1YtHwD+3ED5cGp9BL5t1b6GReiZ2l6fBPO+RUUjVzlU=;
        b=fC6IsEO5tVMzrbH4PBh9WeeGnjsfhz1p77SO41aiSxNJZfIi+1lxjbifJeob8+u/bm
         ggOYrAJba9iggr7PieB0j3d4dOl3aOSMoRb6+x9xhrTCC5fuDvQ1kzWK5zF4E42PH5t+
         p88cX0F0YrjtATDsyiOITQETHP3NKgGO6obO3Ar9DbrTiUyK9gN1Y+bRHnYZbFz0C7Lx
         VdfuyQGVibcwGPzX/usiIZ8NVEClTyvOmUWDQdJQX1V0za7/3fXh4I+11NIvHj5gZZls
         37/i81OZzC3i49NBUk2IjEAyY9tCsquh+QYimTwyW2jAIksBt0Uqet24WnS2BhaSMggh
         bUHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737689282; x=1738294082;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1YtHwD+3ED5cGp9BL5t1b6GReiZ2l6fBPO+RUUjVzlU=;
        b=iNknqpasOgPTECFAHd+OqPhWY4WmY0+Tg2cGJ8HBGxB4zl5eHQ7W9oJqeWCw6Pz7y6
         QHg5mS3QcJb9BwP0Qm+WGReJAOW0Xijx/dK0N4EWjaX8tYr7wfxiR9dUW9Lmobw7p87D
         yaGONpXRIJclsJ3Bx8ttPqdnxmA0P85FZ195x6j81udG54Vy/j90rGLFKdeUpe9JEK2x
         ZIO3aDCYcKCULB7x308IZLiOCifbomRFKqwUv7kA8xAd+yBR/bSTBcI6nwxs5/A7fEVQ
         IULZSFa2rO8LId7XbLsTxx51Xz32QjyFCoH+SRODWPDUIUyuChWo+tA2X+Y5JostyqeJ
         2lMg==
X-Forwarded-Encrypted: i=1; AJvYcCWgD2lFnyIEUNlUnsrFtvqggcfeaRF2NGD673EZE1NjbmE5D9Sbpbi5YuOn8yEkQXz7Feyq+Kze4w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzU7kMiHe4Suj8+7BeXs8olJI1Q8goyrIws4W35Q4I3NNeIwKGM
	g9BI2OvIH95QtTrPfYPOezXFftHwSms8TJGSVHUN/gwwIpoS/bFyzp8IujTGwA4=
X-Gm-Gg: ASbGncuGx/saAHr07y8ysHfwLBb9iaP9IKyPHB5elumVCk2SEZQiS7QH3GRkGo5yOgA
	+RDHN4EFPzjuzv/DAX8591ZIo8L2Qm9ON9xpWMFTSfHO7nk5RnMBVaBrQQTuHec2vq07PgkPmRV
	OevrWTvKDLt3pBfFCpImbskzpjjq54UASqwgZSh/ynSricPpVNhGrculdlWmHuZVLyvAZxIjhbE
	rDKbySmgm9OuOWocL19pqp8q1plg7WuGwI0HOsrEEkVdbb1e+7TrDsgLE48vGwSDck0C8H+90LA
	qBWLQ1k=
X-Google-Smtp-Source: AGHT+IEjcYLFKFT/4zjAgtn0Ur09jWOBQWRSc3NOeyRishuwgqWAN1BJw6YRpnHk99tT5Mt/zypi9A==
X-Received: by 2002:a17:90b:2cc3:b0:2ee:d193:f3d5 with SMTP id 98e67ed59e1d1-2f782c628ddmr46198761a91.7.1737689281866;
        Thu, 23 Jan 2025 19:28:01 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7ffa76ebdsm514831a91.34.2025.01.23.19.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 19:28:01 -0800 (PST)
Date: Fri, 24 Jan 2025 08:57:59 +0530
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
Message-ID: <20250124032759.zo5l7pvdlfttyu5y@vireshk-i7>
References: <20250121084435.2839280-1-beata.michalska@arm.com>
 <20250121084435.2839280-3-beata.michalska@arm.com>
 <20250121105355.sdrgmjv2w2256qfn@vireshk-i7>
 <Z4-6bsDzfe9CLcVf@arm.com>
 <20250122060902.5pgfr5g24jpjrxw3@vireshk-i7>
 <Z5K42yXtcDSZGuUF@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5K42yXtcDSZGuUF@arm.com>

On 23-01-25, 22:47, Beata Michalska wrote:
> Do you mean the new config option? If so, it is in Kconfig.x86 already.
> Unless you have smth else in mind ?

Its good then :)

-- 
viresh

