Return-Path: <linux-pm+bounces-20677-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4E0A16834
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2025 09:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53FCF164793
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2025 08:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2082E192D70;
	Mon, 20 Jan 2025 08:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wWlQllzM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9152A192B9D
	for <linux-pm@vger.kernel.org>; Mon, 20 Jan 2025 08:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737361649; cv=none; b=EdZ/Xec7ihVgw1hqPv64esioyqLbYLaFcQO3mq6uRNWx1/8ZL9i6M9QIq+EGI2xjGzDtE5PELQhgQXCS+tiSr/j7Fnoc43bo/HLBaOo2Z4iVObiB9Cqv3Nvye0vbVX3UFvuAKwhCMU+DgUkSWWrn7HgXAe9EZrqUv8uOcpnp3qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737361649; c=relaxed/simple;
	bh=k/he5g/Q1W1hnR2AfJUN60Y/8ZYkF98SPQTAJw8PaD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oVHgJb5oNg5dLgPWow3JBNiNd31knjYV24W260NUy/Sq3MBqSb1DDaaCvOap+8s3C6/q79Wwb7mBWL+i41INeCIXt3KIGgyO2H5AIo57saIBqaKL+OqV5cjMG2dYuchWBgy5ldE3Np3Nz3ahA6U2zzs0ycfG5PFVYcHNorHVEfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wWlQllzM; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2efded08c79so5721513a91.0
        for <linux-pm@vger.kernel.org>; Mon, 20 Jan 2025 00:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737361647; x=1737966447; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=txq8rBXOHWYPjqwGosZpWRv2yZ4sfOBXhUvzeOGs/60=;
        b=wWlQllzMSdUOvseNpzrkmE40zA0qfZleuAWFzdootjrqA9apzdMDS3IauNK2F6uiwL
         /WUDzYhkfik6qNsHwZ4i3kNzB973a5X1ii6ZRRPOhlYDx6Ux7aEujseZxQyIYvjRg022
         35zjGb8Gh9l5U7XmYeSh/57Nv21WUH25A9hwafOxjM8CCi4AUXW+/3KjvISZhV9NlY5Z
         VqrHCnRJBwgRdcHYrYyUdL9K0K8uic0xeSzGGFuNe1gB1nohGsoglW2Ftt9XBSxKcvyr
         cjtT1D1/mBbaQGZZDxY1yHdzk2//NGJ7exbAsCAwvIGvtzxneg62PS3LsiACv1W8YfrL
         9xEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737361647; x=1737966447;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=txq8rBXOHWYPjqwGosZpWRv2yZ4sfOBXhUvzeOGs/60=;
        b=fXqmPjW+bh42YT7u9a8XChBCSG1yuH7FGOEUMrb2W84KIWyJ5n2WgsTxPlGQDpBymI
         XtdKldaihbWG8QF2UP9YSdXDt0oi2cKBzP8ZjWAaDxMP7FwxP4EigaQVoIGt9U0cVTSC
         aRRxfjqO+x0L6VLb654L/KzEAERbMSonW0GJu5HAt5Fjm1GjPvo8sUtPNqYJNFmGzSrq
         beCaCs20HrRp2MDmLYt+DlxvrHsSApW5WutuX9iwkYOZHT/2dYJlhDuqKtPIJSCtvzGc
         vBBqeBk0susairIBFqOZzX/ghs8y2gPmADc5BeJpX0c6G7Cgwg/bG1drql7++F21Qwhw
         lO1w==
X-Forwarded-Encrypted: i=1; AJvYcCU/aDKaCTLW3MEhZ6Kx6wjdDVrw/OLS8lUW714B1gkoUHTq4hMjq873/eD4kGjO24yCboInI/TUNQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjt56RfIIgpjxTkFJiA6jmTasJkfK4eonavcpM1lnWgb+yNijZ
	GFEm3VOoPKWCVU3k0ggftJ4gyUw8PxqsPE7LL7gZsdtkOTCD9rZo6V82X9mVHQ0=
X-Gm-Gg: ASbGncuufwXpUdf2A9lKy27LfpTo0dyz8oSEiAqXIV273DGmbyOnB9kcdBtLHIG8m9T
	gqOU2SjgeGZgp0umIUyLT6AGeuQpfJ0GBLyhLdb+E8+3GQ8yAjNb0+//WliS4qeIKZh5hqTJA2W
	6prMtWxsjd+35zGYE2AJ70Qb7c4XjHFbErmSug3w/tFMYFVgHqwtqrkc2sqCZH+vEVFBBKfzat7
	GFDQIlehZcSqh2Erx3O+sbwi+SKrN7jzSZDysBoMx6EDTOIpO1o3SxfCcNCi6E91MQb3KDU
X-Google-Smtp-Source: AGHT+IFVdwonDpHN+adlbLlBEuh//ImaYoIrRKQopNjsfhqMsUTTfq8vo6zTThyW4+jJcm5VfD779A==
X-Received: by 2002:a17:90b:37ce:b0:2ee:8358:385 with SMTP id 98e67ed59e1d1-2f782c6292emr18197215a91.4.1737361646677;
        Mon, 20 Jan 2025 00:27:26 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f77619e6a5sm7753797a91.26.2025.01.20.00.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 00:27:26 -0800 (PST)
Date: Mon, 20 Jan 2025 13:57:23 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Lifeng Zheng <zhenglifeng1@huawei.com>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxarm@huawei.com,
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com,
	lihuisong@huawei.com, fanghao11@huawei.com
Subject: Re: [PATCH v2 1/4] cpufreq: Fix re-boost issue after hotplugging a
 cpu
Message-ID: <20250120082723.am7rxujmdvzz4eky@vireshk-i7>
References: <20250117101457.1530653-1-zhenglifeng1@huawei.com>
 <20250117101457.1530653-2-zhenglifeng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117101457.1530653-2-zhenglifeng1@huawei.com>

Hi,

I am bit confused by the sequence of events here and need some
clarification. Lets assume that CPU can go from 1 GHz to 1.5 GHz
without boost enabled and with boost it can go to 2 GHz.

On 17-01-25, 18:14, Lifeng Zheng wrote:
> It turns out that cpuX will stay on the base frequency after performing
> these operations:
> 
> 1. boost all cpus: echo 1 > /sys/devices/system/cpu/cpufreq/boost

Boost enabled here, max_freq_req = 2 GHz.

> 2. offline the cpu: echo 0 > /sys/devices/system/cpu/cpuX/online
> 
> 3. deboost all cpus: echo 0 > /sys/devices/system/cpu/cpufreq/boost
> 
> 4. online the cpu: echo 1 > /sys/devices/system/cpu/cpuX/online

Boost is disabled currently here, but max_freq_req = 2 GHz, which is
incorrect and the current change you are proposing fixes it I think.
But it is not what you are claiming to fix.

> 5. boost all cpus again: echo 1 > /sys/devices/system/cpu/cpufreq/boost

Boost enabled again here, and max_freq_req = 2 GHz is the correct
value.

So the CPU doesn't stay at base frequency here, but 2 GHz only.

> This is because max_freq_req of the policy is not updated during the online
> process, and the value of max_freq_req before the last offline is retained.

which was 2 GHz in your example.

> When the CPU is boosted again, freq_qos_update_request() will do nothing
> because the old value is the same as the new one. This causes the CPU stay
> on the base frequency. Update max_freq_req  in cpufreq_online() will solve
> this problem.

-- 
viresh

