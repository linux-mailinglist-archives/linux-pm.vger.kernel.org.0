Return-Path: <linux-pm+bounces-32282-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C00D4B24A0B
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 15:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D79FE3A51BD
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 12:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3FA2D8DA9;
	Wed, 13 Aug 2025 12:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j7U5EG5i"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE64E272802;
	Wed, 13 Aug 2025 12:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755089974; cv=none; b=qpNiI9Pta1Z/Zakf6ggtH+5AI4E/UwcbzJDsaZon22HTIragU05b98T3+IcpUuWLZrNTvjNZ1RZpzvCILFSPmIzDqqu3gPG7lwUxwtugsKodEvgMC7SG/TrmfAbRhHOycfRpBVkyY/ubP6oTlx84Hk69QMXVbT4gsIAK6YlyCOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755089974; c=relaxed/simple;
	bh=dTFc3E1aiCdvJZfZClo+9DpCtgXt5pJR4Sj5C5YOZao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VC1vE1cJwg7O0M1ihE6VCLofZNeMnbUonDBIlqFY0ypNpkxmaLxZlBHTs+8mHFOyvaQx3TmyFrXeVdYgTLskTtkG3VfyZkmvWsJ7H2ENFJF1zHtUCoGono3lisPYxfj7TmPm1UX1vmUrtPLAvRRV1J4fqFKoUjgyCfNnwC817ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j7U5EG5i; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-76b8d289f73so6189535b3a.1;
        Wed, 13 Aug 2025 05:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755089972; x=1755694772; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UQPvd+zVqzXDcaRE1Milhvn1ALxIOqrbSOg9v32q6ts=;
        b=j7U5EG5if3bS+Hpnhm91ukDzE3uC1p+77ijHtyMZVE8nzQqeJkzZlpaYdkghwVWWyV
         mdBO9lw6VjakRwGGw2HuwuYNasY9CqqWAPpgF/tkdsxD/KZU6LrZ664+4Gtt0zUDYVmd
         jDrL8iAFXskSGWlmJdXDHFqJK0p7fnuVoP+3gvIHVk6emVsP5tzJvodYw8kVqvkwlROv
         bGvOhA9vdbpH4SzIQOj2snvIi3hDmv7m4axImxHIlF0icl1Pz530LMjsCuZu9oe/X1R4
         Pkv7drkD38K0ijbaumBfd/7ffRlbpJdPa5X7OOVH3GXBDbsLXEoPPTlv3HH4XL4uqSY1
         ThwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755089972; x=1755694772;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UQPvd+zVqzXDcaRE1Milhvn1ALxIOqrbSOg9v32q6ts=;
        b=qCTiTt/3koNY1fxCjYeD36EQPVBU/sI9vQYlz5CPPXFU29vUISaKYgQQOjv6Ll4N68
         RBidAydgel24V0EgIQJIzyBP9V9s9HQOXdwVJlSynUEmUsNaOHy8EEUONWmMlBrYgy/F
         BNfeR8i5uO61Up2klWrMifmEalAVunbx+vWB0141O0BQWd/5yTjq/od5YXiYd6EIpWEZ
         j1b/9kjqFMvbrJAxmihcw2wXWX63F5XzANDuctNrnyaYG2mHfHOoPM3XZW+uxyN37OPK
         3jGeSnHx0AoaNPJE9OsEI395cCtsiOawJ0U6v828p6EvJHMOOfuRrT80DBw50Bddz7kZ
         pQWw==
X-Forwarded-Encrypted: i=1; AJvYcCUsS+uWWFdXIndgafp9x28wXr74pnazGPDAv22070kWONRyvAt8X2jV23E8MKWsUt8LSugYij35jJuuVSc=@vger.kernel.org, AJvYcCXgpeRR+l0o2TcOGhEBmNE16x5y77oVlafw0TqanDQXCa8prBnJaQg50Bga5HyyJUpgVSwzmzGEAKs=@vger.kernel.org, AJvYcCXnvaguchyZHlNd5rQzmvQ20C0V1G8LKblt7T3YqaK7fgpe3xNdNoUGDSNJLO36BbmBh9jUk9X+l9cqZvHrgwU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywitqf7THuftADi3oJfC2ZzbolSuACoqkEkRc0ekU1z1csXqg1s
	cP92Pt5ZwAD0DGS6pt32r7Vn25i1Ph6kZARmPW/rCOiZIqzA9wgDLo6n
X-Gm-Gg: ASbGncslESGP/kMTN9Um5h7w0hR5oDedP/ZmXs9Fv5gL5lOJjGajglWOs3ieE6kwBlz
	GywgJJjk58tdSIJJJQdMnFiKvC2nCFKBk4VptwVgYE7oRm5PEVheQrg9b5izwCbq4kyUk7XdO+f
	ayQNKU7miSHA9Jfh8jxslXLq571jebitIJtOcuVJYbi9UxxRP8ew4RKiCznesjNnFHvIxeXnBCQ
	Sl6zslN2qg4RCp/63gsALYxJvuavetw1hLmSs8MQvcfYJyfF/LZGMQN+R3tow+x9Rgo15dmqyjN
	HYVsMNeClVnKOy0LrI9HDAaKFCeyej758Vek1xvSh1eYgg8FWc4BcdZIQOv1o4U8MsGDYL3XNra
	TsK6FYiGsrKYy7Az15M/qtWprh6itBYA1
X-Google-Smtp-Source: AGHT+IG8R4qt6TnQdln39ZZIqnhdZLG0VHnFzmJud0A0EvI8YMeFg2UdOWBhjzl16urJ2PjbWhG34A==
X-Received: by 2002:a17:903:1a70:b0:242:9bc5:31a1 with SMTP id d9443c01a7336-2430d2c841fmr48188895ad.57.1755089972062;
        Wed, 13 Aug 2025 05:59:32 -0700 (PDT)
Received: from localhost ([216.228.127.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e899adc3sm326538625ad.118.2025.08.13.05.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 05:59:31 -0700 (PDT)
Date: Wed, 13 Aug 2025 08:59:29 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, linux-pm@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: cpumask: rename CpumaskVar::as[_mut]_ref to
 from_raw[_mut]
Message-ID: <aJyMMc-nd2wOBZ4g@yury>
References: <20250813-cpumask-asref-v1-1-1242aa8e0cfc@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813-cpumask-asref-v1-1-1242aa8e0cfc@google.com>

On Wed, Aug 13, 2025 at 07:54:31AM +0000, Alice Ryhl wrote:
> The prefix as_* shouldn't be used for constructors. For further
> motivation, see commit 2f5606afa4c2 ("device: rust: rename
> Device::as_ref() to Device::from_raw()").
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Would be nice to describe this rule in Documentation, but anyways:


Reviewed-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
> ---
>  rust/kernel/cpufreq.rs | 2 +-
>  rust/kernel/cpumask.rs | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
> index afc15e72a7c37ac781f25a8a6edd804fa4c9658a..eea57ba95f241dc06218e2d65a0986a1f9c1415c 100644
> --- a/rust/kernel/cpufreq.rs
> +++ b/rust/kernel/cpufreq.rs
> @@ -543,7 +543,7 @@ pub fn register_em_opp(&mut self) {
>      pub fn cpus(&mut self) -> &mut cpumask::Cpumask {
>          // SAFETY: The pointer to `cpus` is valid for writing and remains valid for the lifetime of
>          // the returned reference.
> -        unsafe { cpumask::CpumaskVar::as_mut_ref(&mut self.as_mut_ref().cpus) }
> +        unsafe { cpumask::CpumaskVar::from_raw_mut(&mut self.as_mut_ref().cpus) }
>      }
>  
>      /// Sets clock for the [`Policy`].
> diff --git a/rust/kernel/cpumask.rs b/rust/kernel/cpumask.rs
> index 3fcbff4386705490b73360e3108fa447e63b7b34..e311ab9038dfdac01cdbfe5a7303caf5922813fd 100644
> --- a/rust/kernel/cpumask.rs
> +++ b/rust/kernel/cpumask.rs
> @@ -270,7 +270,7 @@ pub unsafe fn new(_flags: Flags) -> Result<Self, AllocError> {
>      ///
>      /// The caller must ensure that `ptr` is valid for writing and remains valid for the lifetime
>      /// of the returned reference.
> -    pub unsafe fn as_mut_ref<'a>(ptr: *mut bindings::cpumask_var_t) -> &'a mut Self {
> +    pub unsafe fn from_raw_mut<'a>(ptr: *mut bindings::cpumask_var_t) -> &'a mut Self {
>          // SAFETY: Guaranteed by the safety requirements of the function.
>          //
>          // INVARIANT: The caller ensures that `ptr` is valid for writing and remains valid for the
> @@ -284,7 +284,7 @@ pub unsafe fn as_mut_ref<'a>(ptr: *mut bindings::cpumask_var_t) -> &'a mut Self
>      ///
>      /// The caller must ensure that `ptr` is valid for reading and remains valid for the lifetime
>      /// of the returned reference.
> -    pub unsafe fn as_ref<'a>(ptr: *const bindings::cpumask_var_t) -> &'a Self {
> +    pub unsafe fn from_raw<'a>(ptr: *const bindings::cpumask_var_t) -> &'a Self {
>          // SAFETY: Guaranteed by the safety requirements of the function.
>          //
>          // INVARIANT: The caller ensures that `ptr` is valid for reading and remains valid for the
> 
> ---
> base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
> change-id: 20250813-cpumask-asref-1054bd96742d
> 
> Best regards,
> -- 
> Alice Ryhl <aliceryhl@google.com>

