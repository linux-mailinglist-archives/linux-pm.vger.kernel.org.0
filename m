Return-Path: <linux-pm+bounces-29045-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E80FADFD2B
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jun 2025 07:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB4B71716EC
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jun 2025 05:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329E7242D8D;
	Thu, 19 Jun 2025 05:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u11Km7ns"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F206E374D1
	for <linux-pm@vger.kernel.org>; Thu, 19 Jun 2025 05:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750312083; cv=none; b=Uprf7MOJn9DRkqll1b6Q0EhC1WontCDoV0WeC/4AMlJFZ9s7yYt1L/HWLrM82psjvIBVHe/iiMcIaR0rkKzfo6K+okZI3yJH/KoB1iMCC8xvcCHG9E2JOjjGEvgwBB9d0gPvZPIfs8F511xlo9R3yOCWymhMZRXAWC4q5BS33bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750312083; c=relaxed/simple;
	bh=G1pBc79YHeOc8teFMiWj0r25pQg23ExTkVNwbJHUxeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pZPB3pQbae/AXEBr9gIZT4SWtEqyPA45twt9yefwEq4Mx35AIuUCiE1kLfqqYoa7/KjwVTZOAFdXgt3zbNoRozcQTcoVl31PU+Ckz1wvFcdmqCvWlGMBIbd3+0vzILJWo8DvEi6e7OTxCmlBAmz6q1KobKZe1Tqc1a/XaldIybw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u11Km7ns; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-23636167b30so4212495ad.1
        for <linux-pm@vger.kernel.org>; Wed, 18 Jun 2025 22:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750312080; x=1750916880; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=w06pRHUxpM/QQNGaUX6TLUa1ZCwsg87mdzg1cVqYuMY=;
        b=u11Km7nsRaFeAjr6NcA2cCOpcGPPe4gPB6F60BFTa2SDqFGAo/kEDOERtAErFJ7OZT
         wqfPAFeif9DFvTX+y+awgweW1sf3x9kePNlLY7bXKapDEaGctVBYMJzrWr6uq5/WniSy
         qEgLXfYR6pJrKhoXIr8mb+CzbIs+WI+sU4t0NdRJRQMzrQfUCSqwl1T8kWVtSZzwJUmI
         44sQH5wDEqWGDTOIbx0Mi4GhGPCcCvKI/1iSiwCnAdXPnwiNVzT6kzxBiZ3wc+Rs9nnl
         mBaY8iisvG2UCZMREpb2Nb1JgzHG4p76lc/k/1ApqGPj48K25lM3BWaPqyBspvvWaN+j
         n4Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750312080; x=1750916880;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w06pRHUxpM/QQNGaUX6TLUa1ZCwsg87mdzg1cVqYuMY=;
        b=paknFwb2FV5cCFObXlNAPFlgA5u3H7EpRGhZAHQDBTOz0pv2+HfMtCsCTc++ifSrwW
         uouowntulZjggTgAX/evV5Tyz1ew+zc+B2Cguh3z00eU+jHiIgZADrGJZ3S5HXjoFmwW
         zUC5V/Z86Ms5G+juv4UDu7gwqYp1QBgj5p89HEAPgWzOXf1vC/t49CCyDIzFMwRxWDS3
         YAv4mQsWnZ1073UtNS7+6T8sSBdEcnmI7rM9oel8gBkMYQnTatrRS6R2CTqQAD0fbG9u
         FzBYe1rTX8KsjLlbIxv0rZ4mGWeFg8faMyWe/W1IY/ue9jdIwsrcv0RwMSosAcH45O5z
         Xfaw==
X-Forwarded-Encrypted: i=1; AJvYcCWYsssToOaB9NyXFfE8wzCuVW2p2tW+y0o8GOOkv30kgzDrMb2V5pKtLldQXJJR/NOgsH4JllUvBw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa9AvA7cF2CrIi5TTpHXU2cYqz3wi+nzYrnw0+PLg8ARnDVFBQ
	R/6PtPfibjBkUVTxCoYgZNKD7vptcOZ1CHGkv9XlvL+17H6h042TVU+cpN7xk5aHnDs=
X-Gm-Gg: ASbGncvrhD74K+5ZUWypdRI2QksFHu6aZVxvKVIYGDWFUZ4rvh41l3p0Zc+NC5q5aeX
	2ZywxKaQxLhvnuhlrXEs2DWsH0tLgc70u9nLENTMiQAc6Mm1CMmC6ZfLbY10ZdmiGtPxRgpE2tH
	fYvuvFIDcnDnJ7WUJQNVukpK3mf/hQuMggmI+LUQQ59vVY18SYIdTHXUoIGi8a/TKHCbke62Pso
	/dffsMYkNzPtmeqz59C4lQLIjWMDFz7Ur4HoeGjBX7vuSuB1oj2du85IN3McyafXyG/LlC6zHQP
	njJ6WcVVaVohr3MaDSMyVmjo9zWyWGoGYscyfr4MeReQqclkoRqfjwpK+6LnL9M=
X-Google-Smtp-Source: AGHT+IF25Vmp36Sdt4Pjj6dvxhJMSBF+fxUEb8+u1l4GZz3Fuz0LFMidJsQ+FCmOU1nj7dvp8f6VIw==
X-Received: by 2002:a17:902:e788:b0:235:2375:7e94 with SMTP id d9443c01a7336-2366b3c5b99mr313228455ad.24.1750312080362;
        Wed, 18 Jun 2025 22:48:00 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2fe1680c54sm12206227a12.47.2025.06.18.22.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 22:47:59 -0700 (PDT)
Date: Thu, 19 Jun 2025 11:17:57 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "zhenglifeng (A)" <zhenglifeng1@huawei.com>, robert.moore@intel.com,
	lenb@kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linuxarm@huawei.com, jonathan.cameron@huawei.com,
	zhanjie9@hisilicon.com, lihuisong@huawei.com, yubowen8@huawei.com
Subject: Re: [PATCH 0/3] cpufreq: CPPC: Some optimizations for cppc_cpufreq.c.
Message-ID: <20250619054757.5nxaeckvmaiji5gn@vireshk-i7>
References: <20250526113057.3086513-1-zhenglifeng1@huawei.com>
 <9c82abca-0772-444c-8122-59a953c83984@huawei.com>
 <CAJZ5v0hyMANsOwskEUi1c3XB+heE6z0_-Dk1nqnw-SbZ0dM3zA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hyMANsOwskEUi1c3XB+heE6z0_-Dk1nqnw-SbZ0dM3zA@mail.gmail.com>

On 18-06-25, 21:06, Rafael J. Wysocki wrote:
> On Tue, Jun 17, 2025 at 4:33 AM zhenglifeng (A) <zhenglifeng1@huawei.com> wrote:
> >
> > Gentle ping.
> >
> > On 2025/5/26 19:30, Lifeng Zheng wrote:
> > > This patch series makes some minor optimizations for cppc_cpufreq.c to
> > > makes codes cleaner.
> > >
> > > Lifeng Zheng (3):
> > >   cpufreq: CPPC: Remove cpu_data_list
> > >   cpufreq: CPPC: Return void in populate_efficiency_class()
> > >   cpufreq: CPPC: Remove forward declaration of
> > >     cppc_cpufreq_register_em()
> > >
> > >  drivers/cpufreq/cppc_cpufreq.c | 59 +++++++++-------------------------
> > >  include/acpi/cppc_acpi.h       |  1 -
> > >  2 files changed, 15 insertions(+), 45 deletions(-)
> 
> I've started to process this because it has been sent to linux-acpi
> and then I realized that Viresh should take it, but since I've applied
> it already, I may as well queue it up for 6.17.
> 
> Viresh, please let me know if you have any concerns about it.

I applied this before I saw your email.. Please keep it, I will drop it. Thanks.

-- 
viresh

