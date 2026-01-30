Return-Path: <linux-pm+bounces-41747-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPF4IGtPfGmOLwIAu9opvQ
	(envelope-from <linux-pm+bounces-41747-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 07:27:55 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0176BB79DF
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 07:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F36E300D155
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 06:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2ED2ED16D;
	Fri, 30 Jan 2026 06:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dfNkyT++"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0E31B4138
	for <linux-pm@vger.kernel.org>; Fri, 30 Jan 2026 06:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769754473; cv=none; b=QESCC8y+YBazRu5pu7PlCdcTXXWKWLt03YPrBTYloacZtPJ7NRNnnsKeVfS5yVAVPokLi3Z5gsCvrDgYTECxwf5CKe07PC2PP4P36KEZ/EgvQVXMkoZ8HOuRl2Ogn7WoTWEP6o5Fi30wq/dGbMMpj8gAqkhvCEdUpf3EZrCXlwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769754473; c=relaxed/simple;
	bh=S5ytEVKJJuP65177qQrqTryrs1V6OObtns4hH94v9YY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tcyNAYnanfLUrT/qrmRljw8Om9a8v+hvgW2TzvGM/o7llmVVQ8GFni3qm/5svsxsfYv8JY4eZ44KjFJRqIam2VTh/5/wUk4O3pqnaHUwWENTlvzGGiHsX3MlP/kTPPMyhEbc9OB/AxVfa4owlZ9km+a6Q73nffB6cCHbcf2gL60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dfNkyT++; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c0c24d0f4ceso671563a12.1
        for <linux-pm@vger.kernel.org>; Thu, 29 Jan 2026 22:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769754471; x=1770359271; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OcCddLBTX1u2AT65eTJArqUf8OubYhQCURjlAC2zifw=;
        b=dfNkyT++fXMpusnsY6a3YMBBBQg0sk3eFGpzP0k+KKlNyH/qwBlX9wV9ed7+jtZyhI
         PeXtnecqa7Qw2c9u/fvPxk2pcoF8cwVuR8gFclwxlB1YT6linM9oeBX4jBFcvqHuu4Gg
         +aLJYvGXwKFk8mOni2z5cqMxg6oKTLt8IgVuFh71jZ66/R93/g8qXy2zpgk6b91+VG+Z
         r54HBCPSOaUEF7MwaD8zi72Trgrj3r8XL41sZiowpRr9qmlCKw/u2FXvgVq/G1GDrJuY
         b5x/ff/7YyvatHnKyjAcyse09ztuZ9kQ3wIfIyjgV3lptk5II6anXSyYdzNqBgcdC9ZL
         iU+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769754471; x=1770359271;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OcCddLBTX1u2AT65eTJArqUf8OubYhQCURjlAC2zifw=;
        b=m6cuc/fHFpEUVZxfjeVWKgDJqxGg3Eral5XyHVJ/5Xh+R52Hk3c3oXwwImMIkBflfC
         VB+TTRimQF+8MkmXPuadZ0eWdmTecUo723nYG4M/EQkXaQrZkyetKczRZt1ZElxl5QNf
         o+PftHk1qNg0LS/idxRJimpI9nkJC6oSmkEzWo2i9Anu0fekT7+rivCmrfuS7AUwoJD/
         oQm0LsVf9u25pIREjnhtjPaj11hEQAd37JwidkXw93E9JRXVnZMb3XB1NPq+HHyu9XO4
         PLolrkoqQod0No2nY4kINU1x27+hfggsv62tsvp0bqGxQUwJkjdwFdRYbMgyIbwilyCp
         XLNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnEBqq6uRtDNocKqm9Fc3ITFmOzeJKED2pK4zVCLh4+LSv0+roBCfTKYv8uu52rAmbYT+umI4dWQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyuxRGZJsMwilPcODMboQc6V5FMumxTVmlR5DB5XQVjAwDHSSX7
	2usNtAWxvXCnKpBeWBj5Bb4xOVEEpTmih0rKgv8ye6v2jNCIUV+Z6cYcBn3krqh7WAA=
X-Gm-Gg: AZuq6aKmlLBL5N7/ti4GfnDClvfaukXiRPUIOxN2upLGFK4DggL3uhd8q/LkTpszNRm
	PulcSvt7vPNdGk8Tyzs5v28yRdKjAVCIvDDY3B127YHsdGZ0hqH9p4oEmfKrDBfmd8vjrCYF+Ic
	2bd/F6AD6zCz5DNKMCaVkiZher1yf3U8m6khm/1LGgd66Yypl45J9kgfPF5Mbcm7dIFhnLYPPAk
	NvbPGnuMGd8BPfTPIxH2Dqpo2NQUIGpBhCJezyTZQU4hEEubyvVIHveeagqrQaNiqSuBqmCmFum
	zaYuWjUOQhFxhqsaPv1PqgNHm8p5cN9Zlp8cqXN9slCLOe5BTwiusVRe6CsdmF1wSvPrX6Tmh64
	j+ENYIFqZyU4pNpjrY+/GuNjGzywjIM6YEP90Il62HhcUFsCU73traObrglb2cV37XJh+ImZ7Z7
	NNN9mSI2Fdg/k=
X-Received: by 2002:a17:903:1b67:b0:2a8:dc02:8939 with SMTP id d9443c01a7336-2a8dc028b56mr14913635ad.0.1769754470910;
        Thu, 29 Jan 2026 22:27:50 -0800 (PST)
Received: from localhost ([122.172.80.63])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b4c3ddfsm67357275ad.66.2026.01.29.22.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 22:27:50 -0800 (PST)
Date: Fri, 30 Jan 2026 11:57:47 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Pengjie Zhang <zhangpengjie2@huawei.com>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhanjie9@hisilicon.com, zhenglifeng1@huawei.com, 
	lihuisong@huawei.com, yubowen8@huawei.com, linhongye@h-partners.com, 
	linuxarm@huawei.com, jonathan.cameron@huawei.com, wangzhi12@huawei.com
Subject: Re: [PATCH] cpufreq: Add debug print for current frequency in
 __cpufreq_driver_target()
Message-ID: <ezppyby2fs2k2njwcty4dpaf4637g24kzmemjm5sedeerl6ihw@brxxfglbitxc>
References: <20260129121813.3874516-1-zhangpengjie2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129121813.3874516-1-zhangpengjie2@huawei.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41747-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linaro.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viresh.kumar@linaro.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linaro.org:email,linaro.org:dkim]
X-Rspamd-Queue-Id: 0176BB79DF
X-Rspamd-Action: no action

On 29-01-26, 20:18, Pengjie Zhang wrote:
> Include policy->cur in the debug message to explicitly show the frequency
> transition (from current to target).
> 
> Signed-off-by: Pengjie Zhang <zhangpengjie2@huawei.com>
> ---
>  drivers/cpufreq/cpufreq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 4472bb1ec83c..b3d2d2e0c864 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2361,8 +2361,8 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
>  	target_freq = __resolve_freq(policy, target_freq, policy->min,
>  				     policy->max, relation);
>  
> -	pr_debug("target for CPU %u: %u kHz, relation %u, requested %u kHz\n",
> -		 policy->cpu, target_freq, relation, old_target_freq);
> +	pr_debug("CPU %u: cur %u kHz -> target %u kHz (req %u kHz, rel %u)\n",
> +		policy->cpu, policy->cur, target_freq, old_target_freq, relation);
>  
>  	/*
>  	 * This might look like a redundant call as we are checking it again

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

