Return-Path: <linux-pm+bounces-19999-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A8BA037A6
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 07:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 590AF1883726
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 06:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B66B1DE895;
	Tue,  7 Jan 2025 06:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rQnJ1KHB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E16214B087
	for <linux-pm@vger.kernel.org>; Tue,  7 Jan 2025 06:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736230105; cv=none; b=nfrBpBgsQ7ii05iQqd0BcHV3FBKC0ci/6i7R4Y1pXIz1h36/CS0cUpOD1jbeBuCiltFN2UUOX2sZRuVMpid4egEtbsi2QkQ/pxfr0mDbiaJGe4M5UDcMQ8/omdIFl8Q2YnoLKSh23dQeAvmnvrVnyXUVKK2O6NeVBLYX0w3PeN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736230105; c=relaxed/simple;
	bh=VS9qyTpm0NHAnTVUOSBX00MYP1T33vQl1HRH5Qy3wos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kd7Y9+BZ3dzir2O9t8Y/sfWkqIrhTAyBElOw+qiTshf0IAqgGGVYWLm2fCCZYnhxWIccwUBpElizUZRYKsyJXR+6lBvyHDNBRTMbAuOAIVBWOXboBBi1JcbyXGRyFS1AXKOVImn75KV+6FetFBb6DwxG8sDIBF8znHPPTm4o+tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rQnJ1KHB; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2ef760a1001so21898834a91.0
        for <linux-pm@vger.kernel.org>; Mon, 06 Jan 2025 22:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736230101; x=1736834901; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DsHp9HptvobYVTliaXz3nZfPBhLe8scvTf+LV1A53pg=;
        b=rQnJ1KHBmnrKFk37XH2POfR6SiT10EwJ5gWW/ZuzFTx86iMrRL2b9HliitBZ3vfe5u
         oSbxW6jS1fVcblBXJ613vTdsNjBhUs+I/2wUonUVkUYliAJRv4hqJb9jmzWazJ/15NAj
         RDIVXvM9K3jGss5BHq5fJ2InNpYmX0mEUDA62VMvyLhOrrTmkAed0MWB9IxUNi58GSvp
         cmD85XD91P6dXwwYI1qDh0XCKCgji2gfpoh4fG/XOzZKViRF3UG41/ZLFXk1XVSfjQzN
         slsNv5lScEren99INDrU6ZzATMInzLI4CjXIEeiZORHXVptLGVeezVJznmfD8K3PEJh0
         5zQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736230101; x=1736834901;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DsHp9HptvobYVTliaXz3nZfPBhLe8scvTf+LV1A53pg=;
        b=JjCYWT4Jc98cdpJR76UU4+49Yz9fm/3aS3oEKXf0VQYI0HjmMOVSopK2icDXTt3bsc
         Rj8DUQp+CvnnfXcKfmpC21cgKoBzGvt26JACcRfKVPzGVC6LVk/IDJwdeW6bcz9zkf2T
         qDDi4H06N1T2BMG7236bFpukHymVIXF+g6H+GdwTgYomVVbiQTWkjChUisKpf6e4hX9c
         6Sh0pmgWUYGDdV7S5od+45yx/rd/pm0t/ItiR8ipjC66pBs+C6RHR1Mf4H7Cr9e/03o4
         Nmc06ZsgGxA8NdeM5+X/IXOHnfMqPdmmQekHEdiFNEbMsMuciSN0RHbvj7kKNOWCjsV/
         A5YA==
X-Forwarded-Encrypted: i=1; AJvYcCWUMH3PjdnorVS4/p+G5UFoMDmoTQIx2yrKNHE2fNgjm6/jmSO9zfCr5EUw0TmB5aqsdQF5ClA3yg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxaasQpKloN9gxTiWC6c0h80gXUSEPLn2dFEcTfsHNbRR9YlcpF
	Hy49ELtBTTqrnaVXSXnKS3tWKFArUCBMHnGejfenis4LBH0gHcXz5VMTRS3Kikg=
X-Gm-Gg: ASbGnctgD8qcm/4Cge7t76JqYsm7I5wtuhr5y+A+jWeyuwYbdHmWq7ZcIqt7v5p/JpD
	SdViaR7Qw4A2/c3+X6EnjOu1diljP6jUinIJvGmviBPR3NFwSc7K2Yw9r3UvVsqk6H0ypWhlXgK
	hy7ZqjOax8qAMWx22thCTGYRcw+g5qgbQ8H8iQGCZNFTNnkDz5RcXLbuYQ+PQuMXqdapwyeWLg8
	8bAyCE8GE3ay7ArSCO2HlnQHFVJMkwmFz1co9AIbL0o23dMY+P9kSmDHk8=
X-Google-Smtp-Source: AGHT+IEIrqnKsXOdxdP/li2nFliyhIvOyX87MA01rjA9KVvm+4JFN/zGI6Uu+8ZmIHDx3LBJpsF7yQ==
X-Received: by 2002:a17:90b:540f:b0:2ee:6db1:21d3 with SMTP id 98e67ed59e1d1-2f452ec922bmr84769333a91.25.1736230101508;
        Mon, 06 Jan 2025 22:08:21 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f4477c8578sm34706428a91.20.2025.01.06.22.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 22:08:20 -0800 (PST)
Date: Tue, 7 Jan 2025 11:38:18 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Cc: vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH] OPP: OF: Fix an OF node leak in _opp_add_static_v2()
Message-ID: <20250107060818.26njlqo77ivfqgez@vireshk-i7>
References: <20250107054453.2889332-1-joe@pf.is.s.u-tokyo.ac.jp>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107054453.2889332-1-joe@pf.is.s.u-tokyo.ac.jp>

On 07-01-25, 14:44, Joe Hattori wrote:
> _opp_add_static_v2() leaks the obtained OF node reference when
> _of_opp_alloc_required_opps() fails. Add an of_node_put() call in the
> error path.
> 
> Fixes: 3466ea2cd6b6 ("OPP: Don't drop opp->np reference while it is still in use")
> Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
> ---
>  drivers/opp/of.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index fd5ed2858258..a24f76f5fd01 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -926,7 +926,7 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
>  
>  	ret = _of_opp_alloc_required_opps(opp_table, new_opp);
>  	if (ret)
> -		goto free_opp;
> +		goto put_node;
>  
>  	if (!of_property_read_u32(np, "clock-latency-ns", &val))
>  		new_opp->clock_latency_ns = val;
> @@ -976,6 +976,8 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
>  
>  free_required_opps:
>  	_of_opp_free_required_opps(opp_table, new_opp);
> +put_node:
> +	of_node_put(np);
>  free_opp:
>  	_opp_free(new_opp);

Applied. Thanks.

-- 
viresh

