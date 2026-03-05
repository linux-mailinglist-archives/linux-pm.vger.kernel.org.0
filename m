Return-Path: <linux-pm+bounces-43654-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iF9SDK4jqWkL2gAAu9opvQ
	(envelope-from <linux-pm+bounces-43654-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 07:33:18 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F45320BA3D
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 07:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3CDA3055DF8
	for <lists+linux-pm@lfdr.de>; Thu,  5 Mar 2026 06:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3C430595B;
	Thu,  5 Mar 2026 06:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZVgJNbeG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422602EC0A2
	for <linux-pm@vger.kernel.org>; Thu,  5 Mar 2026 06:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772692348; cv=none; b=rGe81Fv32NfYsxD3J5Z9Ga+8fYDppf81BVFcOxR2q/TBmBu476rgNMTYHiY4kf+982GcAL2ylE5Wo/eN5RboX9nNOebfgYrqdZFjfMkMtZAwawqHGf1iqYlFSqU0ajkyV0W045wHeIOqJC/O8CcusBlLMg6ocg/FzmGcVjgpPWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772692348; c=relaxed/simple;
	bh=J/UsuxGZo/lg+DBQQPdSz9HtN1nO4UA2nH12HFmTj+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BQ7lzJb8tkXEOqQZchpCiW6Kp9Kr4pdkuMyyW2SIXUfVqKkP03QXt5fF36egmWajwYFZeNuIGDRDn/CsKDpI9Arz7kUsA0ZW/EgYn2WxuhjjhnyN59YMEgAm6EZxUrZ3nFH4r9mMWcg4yW6sXtCq9Yw3azen9x//yiA4fULawNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZVgJNbeG; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-354a18c48b5so6688623a91.1
        for <linux-pm@vger.kernel.org>; Wed, 04 Mar 2026 22:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772692346; x=1773297146; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y7PqgF0UGp8WIIQ1iGsrwo0l3t3Ec/cMtr5i+sZ/njc=;
        b=ZVgJNbeGhj2JEAHm/T6zixmIs1cc70ix77zYPJ6pw4mfMJohs7KbdoK2xmbgPWofd4
         AyGfNYWRy+lpNYZfO18onbdV6oRR+EOxaQ85K9kMpctvkBZwAQQmILHKqFY+062wWk44
         kAnEKrnoO1xw7xrM8YW0aZO/wIDb9kBUT36M5dTx79uZU8toIfM2ue075DRTxi6n8B8Q
         I4Wdo3HSDbcqeuHVSFpNT2C30kf5ESPO45O2A1aSa5n57usSKxa0D1hImDJYJdDFkVfJ
         hOtx0ALN/I4+DWDqhMOsySLC43hldjTzYkKfo4yqAJVKqsYo1xcYiGqWoSTFg9ef0WnM
         tudA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772692346; x=1773297146;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y7PqgF0UGp8WIIQ1iGsrwo0l3t3Ec/cMtr5i+sZ/njc=;
        b=Vn0Wene2jHhYxtSBWDKcU4aQZ9hztE6ZhD6psglVPYmCLAoRh48/UmKuPxUgd31Kec
         FS6KzfQPE5ytt0xaXQjc6IS0Ey8JbZ6FBgtn6tp102io1IcQpKxlE8WhkQ3cAqTF1wby
         /pc09RS8bWSPTrTUC4YS80z7nF0kSkcAiUvKl7mUWxb3Dm669DBS0Y2L4Vy0jm+q3r19
         YtHtTgvBjpkkT2G6qui161WeD7EcoGEFPeK56HqnhHIcc2+5JuIb9p7kYX1pWc1AJ39n
         02iwyP1ZeRX2wdzB705DOpVmEctcKkAB9iEJJYH7bZOeXRCjDcElhtySqRknvjruBfnb
         uhHw==
X-Forwarded-Encrypted: i=1; AJvYcCWS5ctmcInfk33HOFs3bO9FUnJ2KyBSAAKtTRD5SGSmIdBVU8Y8KFLcSkasT5AoPaBhIzOXHVlh3Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxXGMWOpYG1LkSUx0JRfCzZJZmIMJWx6hztEZLQv+FncXUY3zOU
	IQN3Ppeulkb9zBDRh2hC9VlHuMFPDRtQk1uJZlkoS4K8toUpuZapgDNY6yS0cB+UGH5NH5cg3rV
	o/cj/
X-Gm-Gg: ATEYQzz8OA01RR7hreNfpwF+bq4+MtVaat2RU2Z2VKiSqOAnqTp6MiEgIvWTFMblIl/
	vFzuqmHOvSeK3cUa2kdyduy4u34FEFmU4ASmqz65vpltNR1i4XZwMoqG+pzYuhf6/r050xTuQ1t
	0xzxg9u55IWiOefEPOYZY87s2QdA262UA4ZCIGpVFaBzoaVvnSoxEmtFDTWA4UcqvJHmprcSjrS
	1q3/0dVpvNmfC71OxRu0LJEwhvF6k/cAOplnK+KgcD4hg8wFuoTYh//JHZOmLScJ4yPjnGR4s3B
	SzHvY5aQlwaKjCMwqHCy51CywVfWpUzKzXpwqJoUbj9xCQU4VHOnqzPf63+IgkIJq4Wv6EIohzM
	c6l7pPSdxoz7W1l1sCUYw9TCsrEKb7spYSyhKIykJ0dS+Qqj1Y1keAZnGwPUy8+NWJb/c2Df1lW
	Z81esKUav4OQSWwloPRldQ5iBA
X-Received: by 2002:a17:90b:2c86:b0:356:2872:9c5d with SMTP id 98e67ed59e1d1-359a6a6648fmr4809381a91.24.1772692346299;
        Wed, 04 Mar 2026 22:32:26 -0800 (PST)
Received: from localhost ([122.172.81.200])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359b2d4096asm910734a91.6.2026.03.04.22.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 22:32:25 -0800 (PST)
Date: Thu, 5 Mar 2026 12:02:23 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "zhangpengjie (A)" <zhangpengjie2@huawei.com>, 
	Sumit Gupta <sumitg@nvidia.com>, Jie Zhan <zhanjie9@hisilicon.com>, 
	Pierre Gondois <pierre.gondois@arm.com>, Prashant Malani <pmalani@google.com>, 
	Ionela Voinescu <ionela.voinescu@arm.com>, beata.michalska@arm.com
Cc: rafael@kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhanjie9@hisilicon.com, zhenglifeng1@huawei.com, 
	lihuisong@huawei.com, yubowen8@huawei.com, linhongye@h-partners.com, 
	linuxarm@huawei.com, jonathan.cameron@huawei.com, wangzhi12@huawei.com
Subject: Re: [PATCH v2] cpufreq: cppc: Clamp default minimum limit to
 lowest_nonlinear_perf
Message-ID: <ixm6xascso3hjfwhrocnudr7kv4o4plpmywsd2pwksr77nowup@l3ngfnctk5xh>
References: <20260213100633.15413-1-zhangpengjie2@huawei.com>
 <54f5795f-2c0b-49f2-a319-216c17657c0f@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54f5795f-2c0b-49f2-a319-216c17657c0f@huawei.com>
X-Rspamd-Queue-Id: 4F45320BA3D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43654-lists,linux-pm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viresh.kumar@linaro.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:dkim,huawei.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Added few more people

I think we should updated MAINTAINERS with a list of reviewers or maintainers
for the CPPC driver. Who all want to be part of the reviewers list ?

On 03-03-26, 20:03, zhangpengjie (A) wrote:
> Just a gentle ping on this patch.
> Thanks, Pengjie
> 
> On 2/13/2026 6:06 PM, Pengjie Zhang wrote:
> > The ACPI spec defines 'lowest_nonlinear_perf' as the threshold for
> > linear performance scaling. Performance levels below this threshold
> > are typically inefficient and should not be used by default.
> > 
> > Currently, the QoS minimum request is initialized to 0. This defaults
> > the performance floor to the absolute "Lowest Performance" state
> > instead of "lowest_nonlinear_perf", allowing the CPU to operate in
> > an inefficient range unnecessarily.
> > 
> > Signed-off-by: Pengjie Zhang <zhangpengjie2@huawei.com>
> > ---
> > Changes in v2:
> >    - Renamed the patch subject to better reflect the logic change.
> >    - Updated the commit log to clarify ACPI spec details.
> > Link to v1:https://lore.kernel.org/all/20260116094555.2978887-1-zhangpengjie2@huawei.com/
> > ---
> >   drivers/cpufreq/cppc_cpufreq.c | 18 ++++++++++++++++--
> >   1 file changed, 16 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> > index 7e8042efedd1..4a3031d9fcf4 100644
> > --- a/drivers/cpufreq/cppc_cpufreq.c
> > +++ b/drivers/cpufreq/cppc_cpufreq.c
> > @@ -333,9 +333,23 @@ static unsigned int cppc_cpufreq_fast_switch(struct cpufreq_policy *policy,
> >   	return target_freq;
> >   }
> > -static int cppc_verify_policy(struct cpufreq_policy_data *policy)
> > +static int cppc_verify_policy(struct cpufreq_policy_data *policy_data)
> >   {
> > -	cpufreq_verify_within_cpu_limits(policy);
> > +	if (policy_data->min == FREQ_QOS_MIN_DEFAULT_VALUE) {
> > +		struct cpufreq_policy *policy __free(put_cpufreq_policy) =
> > +					      cpufreq_cpu_get(policy_data->cpu);
> > +		struct cppc_cpudata *cpu_data;
> > +
> > +		if (!policy)
> > +			return -EINVAL;
> > +
> > +		cpu_data = policy->driver_data;
> > +		policy_data->min = cppc_perf_to_khz(&cpu_data->perf_caps,
> > +			cpu_data->perf_caps.lowest_nonlinear_perf);
> > +	}
> > +
> > +	cpufreq_verify_within_cpu_limits(policy_data);
> > +
> >   	return 0;
> >   }

-- 
viresh

