Return-Path: <linux-pm+bounces-18221-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB48A9DC0A0
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2024 09:41:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21000B2099F
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2024 08:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539B91662EF;
	Fri, 29 Nov 2024 08:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uTyFxjVu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49FD161321
	for <linux-pm@vger.kernel.org>; Fri, 29 Nov 2024 08:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732869676; cv=none; b=Kfgr3F2CPiKCQe67wlKzc1Vzh8ocksm+K5JXOf3Buury4Nsztmhth6kXz+XRwnVrGC4STywWO7NPaiOY2KSR8qBRL+4VUmySqMMM4+unMtIwhehJNwzeWqmBwMVZAZ3p5smiH1wYEcaAbONh3OFDkjmV2Lho4AuoMrNh/roIJC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732869676; c=relaxed/simple;
	bh=7DUtd75xdBGIj0fyWgDLUpPB07zHBJIM/NDe7IrC2jE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CPqHtS9+oke6vYeG6HQIkc3AZguQqA8d65XxoP4Zs7OuZ6usStMQyaIfUC4xTfvgVlmh0q4bfO5dFg1N0STMFMPCq8v/7NV0LNb3E13jwBcw3Hs46XblvWIeTaFFp9mhQcRMP+mD5RF8/WW9RP6yW9086AQ8LbJnZAH57riiH5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uTyFxjVu; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-212776d6449so15154965ad.1
        for <linux-pm@vger.kernel.org>; Fri, 29 Nov 2024 00:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732869674; x=1733474474; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ua08itlNT1SHCtREOy/qtqXKvLOkks4jIn2aZch620M=;
        b=uTyFxjVuWRJytGnI0IwaXSGWxHFViM6d2QVmzsTt6kg2dXlgQGm/CaxqDhy9L7OTeF
         taw9rl6uMw1w3hSUdUWR3ALf0j1LmuopggjQZ5avS7t5KatmoPXEHlrvktGTyP5r8GBB
         4nzj8WS1UiDUdN9aKMr8CMH30i+zhcWHn4UWFFISSmqVxJHWgS6xvFnLERSM+SGsID7s
         chyoa3Gb+nEbQp7VhQ2wJ8a1La+D5MjKmffoDncex8vwty1I9Sfznj3NbMV9GnIiKMdA
         q8+yTTdAfvKoBHgxIxzed4Nf8cjkjew26cQcLfGBksDUjfGRwzaBBvGX5/W5fMegsH6+
         ucLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732869674; x=1733474474;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ua08itlNT1SHCtREOy/qtqXKvLOkks4jIn2aZch620M=;
        b=q4eB3QFnIrUAlYFubZlS05X9PvSN0U/Yu+GcuEc1+xA6Ks5+biakyrClGk3G7aE0k3
         QIgpNk3ViBkKNfO43jMPs6ijIPBtrjPMi0MxuJYYUTT5EUPHQKvSIEPHg++XiqvUes2K
         0kpyZKZlDK3qhSDJuMgnAsLb+XScLGU/DrS0sz50KvVpuv3cU5DNJgDVplTYVgsLXd8Y
         1+AouIx503+pym19LV/VPFBpsxFcx0y2x+NfTMuhVMBvSCGryzCEiRAhw5pEM+sTac0m
         ytwl1FWzgvw9+bp41X5Kvxp7s6Qe92KD5L7cHO3ESFBBj/EOzHwpMRNPCNrWAgoRtXcX
         FXSQ==
X-Forwarded-Encrypted: i=1; AJvYcCULoGmghMWSEv+iV0Q6rzzz70sxy+7zWNSVA0dMFTg6RUSkqOeTZ7Q3FGRO/pRsZr80/Oa/C2nBqw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2LvTJVJRBP5/ALO8hmuDLsAVjTEW8E7MSReBZgWJU18uE3cIz
	F6d+MBT1AH1+sy7I3X+SdHGins7PQxxc0iuUEL6kTFgeRXOa+ICHT9mtDqZv03o=
X-Gm-Gg: ASbGnctNAThe3dPvQGcKnEodywUex6zF4AfsGKYLLMjDRlDVWKT1cpKXM6ivCLHFdVM
	Gv8VS/Jmy6qQNas6EwWya+PS95BwSfkRcwBePY0iN7WQlY3M40RZYI4V5U2u/9lxkrQLQLfT5Iu
	Na7s0phD8I9npQKlK1ppvGiaXemWFqQIXFWZ+KwbmY1KBOInhpO2KfsMoeN1bGTufb42QC+8jPW
	lGdky9seqWOn1Mf78S5SzT6nz0ZZ3934yv/43Udk9sXkrURdqV9
X-Google-Smtp-Source: AGHT+IHt88htp1V5FejLAaRGGVGWdc3kx1MdmnWhz5bW4J4RdhEdxoxP75JgbFzMrURNpD1QDKs5JQ==
X-Received: by 2002:a17:90b:1dd2:b0:2ea:4578:46cf with SMTP id 98e67ed59e1d1-2ee094cb814mr13155649a91.30.1732869674054;
        Fri, 29 Nov 2024 00:41:14 -0800 (PST)
Received: from localhost ([122.172.86.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee2b01af0fsm2739995a91.22.2024.11.29.00.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 00:41:13 -0800 (PST)
Date: Fri, 29 Nov 2024 14:11:11 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] OPP: fix dev_pm_opp_find_bw_*() when bandwidth table
 not initialized
Message-ID: <20241129084111.ifwak4y4irxjnpru@vireshk-i7>
References: <20241128-topic-opp-fix-assert-index-check-v1-0-cb8bd4c0370e@linaro.org>
 <20241128-topic-opp-fix-assert-index-check-v1-2-cb8bd4c0370e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241128-topic-opp-fix-assert-index-check-v1-2-cb8bd4c0370e@linaro.org>

On 28-11-24, 11:07, Neil Armstrong wrote:
> If a driver calls dev_pm_opp_find_bw_ceil/floor() the retrieve bandwidth
> from the OPP table but the bandwidth table was not created because the
> interconnect properties were missing in the OPP consumer node, the
> kernel will crash with:
> Unable to handle kernel NULL pointer dereference at virtual address 0000000000000004
> ...
> pc : _read_bw+0x8/0x10
> lr : _opp_table_find_key+0x9c/0x174
> ...
> Call trace:
>   _read_bw+0x8/0x10 (P)
>   _opp_table_find_key+0x9c/0x174 (L)
>   _find_key+0x98/0x168
>   dev_pm_opp_find_bw_ceil+0x50/0x88
> ...
> 
> In order to fix the crash, create an assert function to check
> if the bandwidth table were created before trying to get a
> bandwidth with _read_bw().
> 
> Fixes: add1dc094a74 ("OPP: Use generic key finding helpers for bandwidth key")
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/opp/core.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 8692e8ce05b7c31a725ea3a7928f238c7a1d6f51..178780e294dad49c22d866930efb7b8b13ae2d61 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -114,6 +114,14 @@ static bool assert_clk_index(struct opp_table *opp_table, int index)
>  	return opp_table->clk_count > index;
>  }
>  
> +/*
> + * Returns true if bandwidth table is large enough to contain the bandwidth index.
> + */
> +static bool assert_bandwidth_index(struct opp_table *opp_table, int index)
> +{
> +	return opp_table->path_count > index;
> +}
> +
>  /**
>   * dev_pm_opp_get_bw() - Gets the bandwidth corresponding to an opp
>   * @opp:	opp for which bandwidth has to be returned for
> @@ -913,7 +921,8 @@ struct dev_pm_opp *dev_pm_opp_find_bw_ceil(struct device *dev, unsigned int *bw,
>  	unsigned long temp = *bw;
>  	struct dev_pm_opp *opp;
>  
> -	opp = _find_key_ceil(dev, &temp, index, true, _read_bw, NULL);
> +	opp = _find_key_ceil(dev, &temp, index, true, _read_bw,
> +			     assert_bandwidth_index);
>  	*bw = temp;
>  	return opp;
>  }
> @@ -944,7 +953,8 @@ struct dev_pm_opp *dev_pm_opp_find_bw_floor(struct device *dev,
>  	unsigned long temp = *bw;
>  	struct dev_pm_opp *opp;
>  
> -	opp = _find_key_floor(dev, &temp, index, true, _read_bw, NULL);
> +	opp = _find_key_floor(dev, &temp, index, true, _read_bw,
> +			      assert_bandwidth_index);
>  	*bw = temp;
>  	return opp;
>  }

Applied. Thanks.

-- 
viresh

