Return-Path: <linux-pm+bounces-37714-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 50772C4617F
	for <lists+linux-pm@lfdr.de>; Mon, 10 Nov 2025 12:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9FE84346FF2
	for <lists+linux-pm@lfdr.de>; Mon, 10 Nov 2025 11:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CAF52EC08F;
	Mon, 10 Nov 2025 11:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MoITomXm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F95F305E2B
	for <linux-pm@vger.kernel.org>; Mon, 10 Nov 2025 11:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762772458; cv=none; b=dpZjukR0C+m4RLi4YjEf34s18/ZUwOuq5OepBbGJAEws3KDSGGx2M2Bithb399ttG/d9QVDzCzaO6R4KEYYAN8kSxKNTyQ7IAXsZg7FPtT+i7fCgdeNcqrzR9RNfqsfe2NaWiwfMrwLRa8WaxbqYu0/YGciHuqbb4w9mJPdJWxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762772458; c=relaxed/simple;
	bh=j/sDhA1BE/crBk5MB3jz5Gyqsa0mwcEpYJuOnY+51Ws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dZBcHE4xawL2Ct+JBnjZRPy29MzUFZ+fJOxva2wtWRUXF/obBga8ybnnD0d/3vEDUMO2rJA9U7OUmg4ZaKgvu1MSjJilYhBYS38S9+L2QjMwMZH+eIRKRSmXetoWwbYoz8fFLfI8eS2UfqcwMzF+5nTf7cJXhIQDO9OPJgrhPEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MoITomXm; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7b22ffa2a88so1048806b3a.1
        for <linux-pm@vger.kernel.org>; Mon, 10 Nov 2025 03:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762772455; x=1763377255; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YrIRy6Lhq+4eE5yPFjSN9IOBDP8Cyczj9KXwJvvJFlc=;
        b=MoITomXmIdl0l9mMoc4ILl2St6hK1A4HMUb0F493E4DjqRtYRaaHWITxuqAxyq4ZMt
         Eux6VA/tuOY/Phh+AcSizGAkdWdmdFpuWDuTX4jh4eLo+zxAkadFZO+DnDH9dLRMMPvw
         KM5rJ8gPZho8vx/xWz9zYmHpGbiQ0u+pNqXNNOG+Ohb69SzBHy7dy9Deb0Mh1kyi6bDr
         BLIjiHLZZrloc2S58aturYja41JAsiGJcgCQg1UGb0GcsXEDi64d/pQE6WK7V4y/SvN6
         HDod5am68vwzf1U+U9hlWeSGUECILkPgFoMuE3rFPrySIu3Ue/zZb9jRtE69mO6FLLwU
         5Hag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762772455; x=1763377255;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YrIRy6Lhq+4eE5yPFjSN9IOBDP8Cyczj9KXwJvvJFlc=;
        b=oFbkgSDbwFK/DQgNnzdEMD4aXxEBgCVcxqpisIIriAccaSU1WXYN0UrUrkjBo5ZbKL
         vm2QVMse5vLZkRf4/N8aEMeUep9Nhs45+iOuRsbgxs8K730CkKUL/oEOdY2cR1wHI06P
         odz67TbQK572i63fhp26F1WrRvcKe1wURhU+2rzabDe67+yXcem4SEB4ykURd0X5P/sk
         YYrQRgcshN6fPpcmJlKV5RugASA8EAWRW9I9vwr0n2pA2MaiuMneBFKvfBKBWne0XWSf
         1PwJ1XlrfBXhQgPQByH6Il3jd0fp7RKsOzL2vmw81Q9hVZRuZ5f49RgofCB7ccwhawMu
         5lRg==
X-Forwarded-Encrypted: i=1; AJvYcCVCNhhDCnieQGgv4gifx9QeBx/8Kkus4vTtRFwG0x0KI5nUbtYKiz11nuG8Oa++iE7TIJWOR/wUZg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwJKxufTOFZwuTZPB3O5yTCa4jlQ3nhK0StVE+h+einzmYfXGWQ
	BIxteWQz/2yBT+nHWCBH/02CA8t7EXgUWeqMnrojJia4KQwujwLz8qxWYMNdjpcqVBw=
X-Gm-Gg: ASbGncuzJn8whwsu02P31sOBliWlRXfFLNsdw85KfQRR8w3vjYlIbYmdIR39ZlVDus1
	epCRv461sUzuhAfnpppdrEFRQ2am53hbJr64ZlxC4deabQQfYwPe8zrLZDKkct2nO4tqsiIVcHu
	ZO2CG0pjHpWg6esgURtyHXRxFqYucA+pzfN9GRrqtAf4BlKEHqkvOr/pRdIIWKHWDF/sFEYsjaq
	xN4zFs+ZZmUsFn5+nTIDlOqNpEZrkXdxOtoDiOY7CnTMakLkI1+8+Fvd25GFCB00te6ACKXgnWx
	BQqo5B/FskUAB+THMQufDtYAP16egqMR7UQbjPU2sKRrxGnVVS1PCe28zZwD6vga/eE4C0F6oWG
	cEdZcht2/pZ4/HrnuwjiXcAS/6Ol7Pq9zblqH9NVrP47wmudfPLFCSTSUWOdLzlQpgzBjnb/lJW
	yYiiUtnuh5Ryo=
X-Google-Smtp-Source: AGHT+IGOFDbu7mquDmNhSqV97BdY6cG6MLgvb5Xp7QodBHXn8La7j+gNEL/xmdVl7cozIyrmwIAy9g==
X-Received: by 2002:a05:6a21:3291:b0:350:1872:7023 with SMTP id adf61e73a8af0-353a4163b2bmr9937463637.55.1762772455121;
        Mon, 10 Nov 2025 03:00:55 -0800 (PST)
Received: from localhost ([122.172.86.94])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c963586fsm11304602b3a.10.2025.11.10.03.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 03:00:54 -0800 (PST)
Date: Mon, 10 Nov 2025 16:30:52 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Sumit Gupta <sumitg@nvidia.com>, pierre.gondois@arm.com, 
	zhanjie9@hisilicon.com, ionela.voinescu@arm.com, beata.michalska@arm.com
Cc: rafael@kernel.org, lenb@kernel.org, robert.moore@intel.com, 
	corbet@lwn.net, zhenglifeng1@huawei.com, rdunlap@infradead.org, 
	ray.huang@amd.com, gautham.shenoy@amd.com, mario.limonciello@amd.com, 
	perry.yuan@amd.com, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-doc@vger.kernel.org, acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com, 
	ksitaraman@nvidia.com, sanjayc@nvidia.com, nhartman@nvidia.com, bbasu@nvidia.com
Subject: Re: [PATCH v4 0/8] Enhanced autonomous selection and improvements
Message-ID: <hjrcoq7dapqcodk3iiyvjeuq3cwvyccqr4wnlcoi6eduqg5ahf@tszrjvfnkjux>
References: <20251105113844.4086250-1-sumitg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105113844.4086250-1-sumitg@nvidia.com>

On 05-11-25, 17:08, Sumit Gupta wrote:
> This patch series enhances the ACPI CPPC CPUFREQ driver with
> comprehensive support for autonomous performance selection, expanded
> runtime control interfaces and improvements.
> 
> It adds support for below:
> - Expose sysfs to read/write the Minimum/Maximum Performance Registers
>   using frequency (kHz), with internal conversion to performance values.
>   Also, update the policy min/max accordingly.
>     /sys/.../cpufreq/policy*/min_perf and max_perf
> 
> - Expose sysfs to read/write the Performance Limited Register.
>     /sys/.../cpufreq/policy*/perf_limited
> 
> - When toggling autonomous selection, synchronize the policy limits
>   by updating the policy min/max.
> 
> - System-wide autonomous mode configuration via 'auto_sel_mode' boot
>   parameter. Mode can be switched dynamically on individual CPUs.
> 
> - Generic sysfs helper functions to reduce code duplication.
> 
> The patches are grouped as below:
> - Patch 1, 2 & 3: Improvements. Can be applied independently.
> - Patch 4: Sysfs to update min/max_perf. Can be applied independently.
> - Patch 5: Sysfs to update perf_limited. Can be applied independently.
> - Patch 6: add sysfs documentation. Depends on 'Patch 4 and 5'.
> - Patch 7: sync policy min/max with auto_select. Depends on 'Patch 4'.
> - Patch 8: Boot Parameter Support. Depends on 'Patch 4 and 7'.

Beata/Ionela/Jie, any feedback on the CPPC changes ?

-- 
viresh

