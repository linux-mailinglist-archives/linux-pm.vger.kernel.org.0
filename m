Return-Path: <linux-pm+bounces-21812-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E03F2A308FB
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 11:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 841867A3DD9
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 10:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50B11F4E5D;
	Tue, 11 Feb 2025 10:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jtt77E+k"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B241F4701
	for <linux-pm@vger.kernel.org>; Tue, 11 Feb 2025 10:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739270673; cv=none; b=RP6cddvdhPRU3LxT+5/Za0bHbAONHMjCb8/6VbllXG2ZtT7m14KNafyRwatX2xmTV7RHrcoaLu+evPwWbzwCdQgwOxidd56SZQBO/pinNluls1dz1daik3QUrsbkQCtIZRa8gwNLNJXyO9aejV5uOeSIaitdJ1YAucVgtCsgFfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739270673; c=relaxed/simple;
	bh=lyQGPOiFZfI8iuJQWeJ/ZTEHobti30YMVFPeLxYKCIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q2J9F3RYxhxvYmx0ewD8GTksFk7k9zGVjPG6HtFdpqi6FOYwwQvuHUnTtvCsPWESErm/PsxSe0l8ko2zDmHd9yjCmFG0M8b7hPx0tSegRSyZSyB6jhxtmKkEYa2i5BemGf3ccMUxiWGFcpP1WJhaXVICfoEqnrOhh7bTJsFB3vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Jtt77E+k; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21f2339dcfdso84315205ad.1
        for <linux-pm@vger.kernel.org>; Tue, 11 Feb 2025 02:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739270671; x=1739875471; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KGyAcIVzwdxp3SxUx+rEML92I4jzvu6KhWaUMgM+hIg=;
        b=Jtt77E+kukLcHVB+chYhAjiR76Ep2Mz6XaUZtkCLsDfWw43zWq5NR/uK9B3VZu6Oa9
         qdQzo0DnA/pt3E1t3S3L0wWo3npbdMcBZGnF0ObtPLbggyYc++liFDwIsAaEag9TUrNh
         55GyOSyP+8PHwhyesYzngOMKXspeB45iaj20ZcxtPczfS+Oam97+2hsG3qyTgtKPW5CR
         AL3lSQdFtkKXr5m0NKZ62mr4yMz5vwlIJgAtMUKNCeCBXXUqQSqTJyenDWXv7LzLD531
         O69J5bt8NbKIKIsVPFKFdCIvjx+nsNattotk9Qp+fYLiZ+/q4ZRswfzjD8Q6MT5oO7oP
         S3qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739270671; x=1739875471;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KGyAcIVzwdxp3SxUx+rEML92I4jzvu6KhWaUMgM+hIg=;
        b=JHWhz614bqaGCj3MJiFMVd+iRv3mI0+HZSB0/gn8ykB6WYieGC8uFWh5QKGAmfZhlz
         rgKRFQ7/D6L2TjBc0lLJ2/0CZ8VpGhPedEWmx52cmMbA3FP4uTGPEEE3CDP8TP99qIK/
         ZmeyhkmYSTU2+P0xfQYwqbrHetwOawNBkVPCP7O+DTKWA1fNgRBPMDtoP8GTeTaX3Rcb
         8V7f4D+NrzgHmJV5FlVVKwiForUh0z+CTcv3+0opXavuvukIaCYRbQJUAGJQV8lpumrN
         fUBV/SGlL+JBOJ1OhppDaeN/CLRTMPfb6IHUkQVGlW4OwXEDcee1wB5gIkevJh/0WMx+
         OJjg==
X-Forwarded-Encrypted: i=1; AJvYcCVAJq0KNtktH/ygNC7y1s3Jf1O4GsQNrHi9b0enLCnvXmu4JqeIzw/KA8/yVGelQ/Y0WQvCet7Y8Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwTsV8m4b4x9Wd6XYdj8rFaZnSHjzuhpXGjzg2dLmf+PCaTub6X
	hWgqEf5/Hgt0AhcRnMR9LzSc1mExzA6s2grUrUQ3G9OrgJSFqOKh40DsJWJa4eE=
X-Gm-Gg: ASbGncsa6KTlXnPtgbMmXZXkXEsBoLjqnHeVh4y1w7Ro7QlxuwDxuXRWrcjrpFpiCjz
	wbxUUlpL35TdRdw1AcpHnAIXSSnP/gL6e3fIi8stZOBZ9IG1PwIkKkLVCmrI0/beD7LmR0PrDzf
	u+eytaYQv6/y6MDT583gGP1x9DHI11Fnmlhe+DDRR1OdFJPpOPrjgsA0793cry9r5SKiOMCaeLm
	ILMUxxA+yVv8x5w74HF0pXdBpBp2k7DAbAxYTf0rWevOfmCWhMwEptZ4iVOcokpgQQcP/7MczYV
	pYhw0P4IFmTQiHHJsA==
X-Google-Smtp-Source: AGHT+IFkGzG5Hx5dxP8FNIuWUPeK9ACiFX9V+SrVY6ss/7yixFEmLNDBn5grfGl0BrfxDpYTkhCtJQ==
X-Received: by 2002:a17:902:f641:b0:215:9eac:1857 with SMTP id d9443c01a7336-21fb6bf622fmr47511905ad.5.1739270671078;
        Tue, 11 Feb 2025 02:44:31 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa618e5e18sm5506354a91.41.2025.02.11.02.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 02:44:30 -0800 (PST)
Date: Tue, 11 Feb 2025 16:14:28 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Sumit Gupta <sumitg@nvidia.com>, Lifeng Zheng <zhenglifeng1@huawei.com>
Cc: rafael@kernel.org, lenb@kernel.org, robert.moore@intel.com,
	corbet@lwn.net, linux-pm@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org,
	acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org, treding@nvidia.com,
	jonathanh@nvidia.com, sashal@nvidia.com, vsethi@nvidia.com,
	ksitaraman@nvidia.com, sanjayc@nvidia.com, bbasu@nvidia.com
Subject: Re: [Patch 0/5] Support Autonomous Selection mode in cppc_cpufreq
Message-ID: <20250211104428.dibsnxmkiluzixvz@vireshk-i7>
References: <20250211103737.447704-1-sumitg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211103737.447704-1-sumitg@nvidia.com>

On 11-02-25, 16:07, Sumit Gupta wrote:
> This patchset supports the Autonomous Performance Level Selection mode
> in the cppc_cpufreq driver. The feature is part of the existing CPPC
> specification and already present in Intel and AMD specific pstate
> cpufreq drivers. The patchset adds the support in generic acpi cppc
> cpufreq driver.

Is there an overlap with:

https://lore.kernel.org/all/20250206131428.3261578-1-zhenglifeng1@huawei.com/

?

> It adds a new 'cppc_cpufreq_epp' instance of the 'cppc_cpufreq' driver
> for supporting the Autonomous Performance Level Selection and Energy
> Performance Preference (EPP).
> Autonomous selection will get enabled during boot if 'cppc_auto_sel'
> boot argument is passed or the 'Autonomous Selection Enable' register
> is already set before kernel boot. When enabled, the hardware is
> allowed to autonomously select the CPU frequency within the min and
> max perf boundaries using the Engergy Performance Preference hints.
> The EPP values range from '0x0'(performance preference) to '0xFF'
> (energy efficiency preference).
> 
> It also exposes the acpi_cppc sysfs nodes to update the epp, auto_sel
> and {min|max_perf} registers for changing the hints to hardware for
> Autonomous selection.
> 
> In a followup patch, plan to add support to dynamically switch the
> cpufreq driver instance from 'cppc_cpufreq_epp' to 'cppc_cpufreq' and
> vice-versa without reboot.
> 
> The patches are divided into below groups:
> - Patch [1-2]: Improvements. Can be applied independently.
> - Patch [3-4]: sysfs store nodes for Auto mode. Depend on Patch [1-2].
> - Patch [5]: Support for 'cppc_cpufreq_epp'. Uses a macro from [3].
> 
> Sumit Gupta (5):
>   ACPI: CPPC: add read perf ctrls api and rename few existing
>   ACPI: CPPC: expand macro to create store acpi_cppc sysfs node
>   ACPI: CPPC: support updating epp, auto_sel and {min|max_perf} from
>     sysfs
>   Documentation: ACPI: add autonomous mode ctrls info in cppc_sysfs.txt
>   cpufreq: CPPC: Add cppc_cpufreq_epp instance for Autonomous mode
> 
>  Documentation/admin-guide/acpi/cppc_sysfs.rst |  28 ++
>  .../admin-guide/kernel-parameters.txt         |  11 +
>  drivers/acpi/cppc_acpi.c                      | 311 ++++++++++++++++--
>  drivers/cpufreq/cppc_cpufreq.c                | 260 ++++++++++++++-
>  include/acpi/cppc_acpi.h                      |  19 +-
>  5 files changed, 572 insertions(+), 57 deletions(-)

-- 
viresh

