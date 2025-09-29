Return-Path: <linux-pm+bounces-35544-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 895CEBA8845
	for <lists+linux-pm@lfdr.de>; Mon, 29 Sep 2025 11:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFDCD7A31FD
	for <lists+linux-pm@lfdr.de>; Mon, 29 Sep 2025 09:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5885280A51;
	Mon, 29 Sep 2025 09:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pQuT+Sin"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E5127FD71
	for <linux-pm@vger.kernel.org>; Mon, 29 Sep 2025 09:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759136729; cv=none; b=sRGitvWXLz0CCtRNl+RVHwdf4qoh4aw2uYI+JRZQrOS7ZcBUdly4afCPKMs6Y0Daz8vfGcnjDu0s+H9SpZ56Tq5S76C/NmSJcUAuHUi1/n8+PhG8MMkU/BCqIgPJMU0wzzcT4CdBRivdggDe4tIM4iI/PTn0wQSe74AeiqXnEww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759136729; c=relaxed/simple;
	bh=VfNfnv8T6wFQdjBp99fQCp6r0cFMOOnZqrGR1VOZ4Pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m4kh+7U784FbY5Kl2+O7E3t3W8GZaxri6VQQ/PSgLFCZeh8Jd0R5i/BfNC8JY9HAYXW8oH8dCAEVH0AxNsd0WW6q5DH2VVX05v66v4S06TTcNCgQZKbTyyyJQvPfRCJvx0P30hD8y2rWDpB7CDZvBtARVmTi3atkN05iroEnaDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pQuT+Sin; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-781997d195aso1119981b3a.3
        for <linux-pm@vger.kernel.org>; Mon, 29 Sep 2025 02:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759136727; x=1759741527; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=isWBuGrVavExFHtjWRBMLQZSe+K9COO/1eBnPARTDvc=;
        b=pQuT+SinCmUVQILNLEhC0rLBJxvptZZ68yza29Q7YF/0sFoAWYr6SQWjwa6vnFUKhS
         Y99axNibcizHwdnGcAtGHb4gpc8z4NsCWzzQ9QZeblAbNzMT8IKOi9KNoGbF/pHH2jA0
         qTQ3PF8lyGytdBmpPppmZY4C7c7BVFSmaQTM/cJZh0vZtMfxHGNUo7N+QlO/YfOk5klp
         DkluIIa8avJj/Dk/0AokeWuizv35icsHlI6902MmnpiY/RvlZHZqpEgjTAhVpVeTN1sD
         mBg5Y2ryeaQgIIdzxo+DoBzDKZ9JBrT4i8Ie7rQrQbxbBavde3UstNvsjcv8WG5boLtw
         DLGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759136727; x=1759741527;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=isWBuGrVavExFHtjWRBMLQZSe+K9COO/1eBnPARTDvc=;
        b=eCeWeLAgB2k9PVrfBPwm7GHKbmpWuM7w8zPz7EYPgTmLuWakhLRJuFDeih7L8A2tNo
         8qzx190/IDxN0eVGSjGJLb4i6SqopOYgzvyDvv+6W9q05PmoY5KWeykjJLjW2CjUonZh
         uOwVtU00hSPILHnVzpfo3OWU2YYB8qLLgSxqCbi5WtrHXe/cnEa2vF/hTVeBc8qapqfP
         ygMN53r7eUCSccMxvfr4AcEtXC35NbWxD/WWZeBNIOKwoVjEo/ms0dHFs3XUb+BJaTGi
         0DCGdPVSVkaHEUHFeWxbh0mC5XJr3r00ZmEJLkRotFlHi6oSlbBKBzXQ4FC78fwNua9m
         qYGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWm6IiAKpEa4QbpSTHOw5XOZaC19cO3fA1iOKm6ADhYd/MyWSu2+tNO1tYUgST4mxV5NfIVezvVKA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxoU0kWQBQBhgkUelw6wZjQTHCbYuYMP48bIoXSPzdpWxUihJvf
	1YV43XzyIbM6Mh5WYSoRB/dT5G6l87I1wVrIyxVoueXwGHkTSDmexwXmAF1UYbW6DN4=
X-Gm-Gg: ASbGncu18MOjthTFWZIcuCS600gzUJjmLEeR1uoImuqCJFpVK5Aehz/sxUP2x5qZFMk
	lMN9SFcUVPNb1nwVkAeD1zE4I9yR9Xw6IYd2/tSKCE4rGRnYjNp/nlB/yfmITSBDF/Qb8ifTloK
	nMLJu4Z3whuwkpv+6+KgwjxmeKGka/x5vEaVtiVGNaRtoqTonCr8cKko6PTDYmbedTz9YON/xbD
	NF2JUsH5vTMJT87P5guEFVKoDSeYCO+iZB65TlZy/yDgWujsIBWsEQ/fCSG9hegqWtOdjYKhcnk
	DJV12XuwB80p13seEAxNc8y+FsO+7+K0IWXl9CVwVEZ189djRMpsNzN/Rn9S23E/KzLGMuvt/mQ
	yXiyNBavL6UYodcXVTlPfckV+0cm3Rc7VhCs=
X-Google-Smtp-Source: AGHT+IHI53HjGws/0MGMYg9oIUI1/ZiOD1m0ms5Rmqmk3vyfhObi4885Z5MzNYAXHb1e431NwurN+Q==
X-Received: by 2002:a05:6a20:394a:b0:24a:1b2d:6414 with SMTP id adf61e73a8af0-2e7c1bc5598mr20471212637.18.1759136727306;
        Mon, 29 Sep 2025 02:05:27 -0700 (PDT)
Received: from localhost ([122.172.87.183])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102c06981sm10451766b3a.72.2025.09.29.02.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 02:05:26 -0700 (PDT)
Date: Mon, 29 Sep 2025 14:35:24 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] rust: cpufreq: streamline find_supply_names
Message-ID: <20250929090524.ztcp6o6qndml54lm@vireshk-i7>
References: <20250915135954.2329723-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915135954.2329723-2-thorsten.blum@linux.dev>

On 15-09-25, 15:59, Thorsten Blum wrote:
> Remove local variables from find_supply_names() and use .and_then() with
> the more concise kernel::kvec![] macro, instead of KVec::with_capacity()
> followed by .push() and Some().
> 
> No functional changes intended.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/cpufreq/rcpufreq_dt.rs | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/cpufreq/rcpufreq_dt.rs b/drivers/cpufreq/rcpufreq_dt.rs
> index 7e1fbf9a091f..224d063c7cec 100644
> --- a/drivers/cpufreq/rcpufreq_dt.rs
> +++ b/drivers/cpufreq/rcpufreq_dt.rs
> @@ -28,15 +28,11 @@ fn find_supply_name_exact(dev: &Device, name: &str) -> Option<CString> {
>  /// Finds supply name for the CPU from DT.
>  fn find_supply_names(dev: &Device, cpu: cpu::CpuId) -> Option<KVec<CString>> {
>      // Try "cpu0" for older DTs, fallback to "cpu".
> -    let name = (cpu.as_u32() == 0)
> +    (cpu.as_u32() == 0)
>          .then(|| find_supply_name_exact(dev, "cpu0"))
>          .flatten()
> -        .or_else(|| find_supply_name_exact(dev, "cpu"))?;
> -
> -    let mut list = KVec::with_capacity(1, GFP_KERNEL).ok()?;
> -    list.push(name, GFP_KERNEL).ok()?;
> -
> -    Some(list)
> +        .or_else(|| find_supply_name_exact(dev, "cpu"))
> +        .and_then(|name| kernel::kvec![name].ok())
>  }
>  
>  /// Represents the cpufreq dt device.

Applied. Thanks.

-- 
viresh

