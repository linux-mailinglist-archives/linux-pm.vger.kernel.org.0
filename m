Return-Path: <linux-pm+bounces-28333-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A8DAD2B15
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 02:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A0B51890E44
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 00:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BBF417A30F;
	Tue, 10 Jun 2025 00:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VF3IiZpN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A431176ADB
	for <linux-pm@vger.kernel.org>; Tue, 10 Jun 2025 00:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749517046; cv=none; b=dL09LQXkY5mCf2nhUsYTaWjremgmeRaMVXirOGVhvcaubTrGAB4b3X4SD7u2m5RF9pxFHseFw4yBBPrp3CRUUk1p6b2I99lkAN2H8x6q+7eeSNBGeC6wKdMyYBdC8JIRHVGWHTwqZHOxgFHY7RNKaxCF8jvc9eo/g8/6/jAMu40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749517046; c=relaxed/simple;
	bh=p/XSuCXGPS17CXVAw4xGn4f5MNxiAyBtMTSqDEOx0Pg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QV+E2gw82HWRqbo6fgItpkHWXMJHXYyCxMflTsNhMHvD5IEvCgRfKNFEHZ65JLX83Y7CqH5PziasU2AFZATMgljcw+vQEa0Kh/5pXvTJdY+ta4EJi39/+h+/MQiwX0GEW7+WIF3YndCeKuS0BTZQDXICaRQhJCVmlltzayAuXRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VF3IiZpN; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-235d6de331fso57700055ad.3
        for <linux-pm@vger.kernel.org>; Mon, 09 Jun 2025 17:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749517044; x=1750121844; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c1rQwYkfS8VPR2HtcdFz5xQMJ3QnFjshutUNq6gvzdg=;
        b=VF3IiZpNvMTJUqVh9zt8gej3e418SoXcYMYjnpSL8WMH0T5gzjlJ1E15IclwSg/Gu8
         usza/+6sciwnszxi1CrMpMJFdGhkoORyZCgu7FqmP4vs+YWJazErjeAZ/tIs9LcvQVKu
         Rh9zYVRAjNHRf+1g5t7Dzw3EGdG5q2Re5ASeUJzLhDx1duJ/z6TtWZUiIaP9Q7zAGt1I
         r1hfyGUb4VNxCVDCZ/DmCJVPaQ6pyAG5GXf470FMPLT8qcMssbq0/1fmmU8QibZFdafs
         oNFKrkw8+Xe88bcysKGalbErpkWv95o4KglkZY9DhN6ZjQBDM4f/0YjPGEojJIMdsIa0
         5UfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749517044; x=1750121844;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c1rQwYkfS8VPR2HtcdFz5xQMJ3QnFjshutUNq6gvzdg=;
        b=KYRIpiEGSXIjIoe00FV3tW2MmMPsNrmZzRolNkmfvlVUYw8NirhED4KRxkeQytakz8
         zjO934F78JmHUTTeL6RKLQpXRZWYkDM/No9pi2vTCkoUvzK2m8dCVNi2sFQ8LOI8WlgK
         sv88v4brEvk8jaMKP4O3gTcNwOTCSXLgOtRSzCJMzZfC8mDS7js9bo8u8lNSBT2LfnfI
         iBmO40gHNG1GPQrZncNNOPxpOqileaSdPw/r/snlD+dwCERv7APyJeQW4GYizTH+zkqs
         NBoIkKU4OWdtZ8lSnVU11tNo4Xe20FlWGHWDEuB4LuY6QmOUgLb45RbeFInyu6ibvZG2
         GURA==
X-Forwarded-Encrypted: i=1; AJvYcCWM7a0ZGlCHP5rUpPGvX8RY7lAMWZoAywENtlZs+NbVzP3+qSutwkfXpwahkMJa1erAGZDvKU76xw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzLPgfM0KjOeEk0NBNlgv5ZhP35q0hdliT1Dw3K/yk4g4infR4u
	fbmu3djvpi3nV5xrlyAZ/44jz5GaJ6vAo2aKUIFFeSjHCQ/2cc2RoqtcKbfkFFXzpKg=
X-Gm-Gg: ASbGnctm0M3AQIgA0KLKSpNafyev8F3UwY1hmJpue2P9uWZFo8owPAQTlocETYIyLSX
	xq5bNNXlwq3XjpM8PAEEzMitDmTrfKH+cbE5gJbd0AliUuizk1s3I/mmYLdbI5sFWU6N24KQ7Xr
	AZBz3QuQUChdKqaHlEQvn4RROLyB1IOAZKw0lgBMGlwR+o0R9E2mTNznOHqesA1hIgzegJcUxEr
	gigzhkNd9Ej4EQpSmgM4y/GOva3L8f/npnDiPSP/ACs5cqqvKsn8CDMhJJ2Ng2nWqh6qIiMYY67
	i/zX2KVAbEyTtK9g0bR8WAavowpUjG93HluWmfztynek2adnGfrYAUEWel65y2w=
X-Google-Smtp-Source: AGHT+IEdl8eeFf7aJp3yaKtzoKAh6ceNn/qekzHSRC0NuzHU4sIrFSD+owbOXJVQKsMXXNVfTFyxWg==
X-Received: by 2002:a17:903:2c9:b0:234:d778:13fa with SMTP id d9443c01a7336-23601d13585mr206171875ad.26.1749517043866;
        Mon, 09 Jun 2025 17:57:23 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236037ae33dsm60076015ad.206.2025.06.09.17.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 17:57:23 -0700 (PDT)
Date: Tue, 10 Jun 2025 06:27:17 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
Cc: rafael@kernel.org, dakr@kernel.org, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	simona@ffwll.ch, mcgrof@kernel.org, russ.weight@linux.dev,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	leitao@debian.org, gregkh@linuxfoundation.org,
	david.m.ertman@intel.com, ira.weiny@intel.com, leon@kernel.org,
	fujita.tomonori@gmail.com, tamird@gmail.com,
	igor.korotin.linux@gmail.com, walmeida@microsoft.com,
	anisse@astier.eu, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] rust: module: remove deprecated author key
Message-ID: <20250610005717.kd32qk7jvrioyds3@vireshk-i7>
References: <20250609122200.179307-1-trintaeoitogc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609122200.179307-1-trintaeoitogc@gmail.com>

On 09-06-25, 09:22, Guilherme Giacomo Simoes wrote:
> Commit 38559da6afb2 ("rust: module: introduce `authors` key") introduced
> a new `authors` key to support multiple module authors, while keeping
> the old `author` key for backward compatibility.
> 
> Now that all in-tree modules have migrated to `authors`, remove:
> 1. The deprecated `author` key support from the module macro
> 2. Legacy `author` entries from remaining modules
> 
> Signed-off-by: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
> ---
>  drivers/cpufreq/rcpufreq_dt.rs        | 2 +-
 
> diff --git a/drivers/cpufreq/rcpufreq_dt.rs b/drivers/cpufreq/rcpufreq_dt.rs
> index 94ed81644fe1..bdf4b844de42 100644
> --- a/drivers/cpufreq/rcpufreq_dt.rs
> +++ b/drivers/cpufreq/rcpufreq_dt.rs
> @@ -220,7 +220,7 @@ fn probe(
>  module_platform_driver! {
>      type: CPUFreqDTDriver,
>      name: "cpufreq-dt",
> -    author: "Viresh Kumar <viresh.kumar@linaro.org>",
> +    authors: ["Viresh Kumar <viresh.kumar@linaro.org>"],
>      description: "Generic CPUFreq DT driver",
>      license: "GPL v2",
>  }

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

