Return-Path: <linux-pm+bounces-29050-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0901ADFE35
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jun 2025 08:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 880EE1883D64
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jun 2025 06:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F6024889B;
	Thu, 19 Jun 2025 06:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a+iB4PHa"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABF121B8F5
	for <linux-pm@vger.kernel.org>; Thu, 19 Jun 2025 06:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750316237; cv=none; b=cKws7ndURX5ubyztNXeApVfYjWa0Yu0V66NV7hkMTuwfv8fXxBWrWYeP6OcJ8iNXlEsN98rZJvjYwE7HvXj9PlSbZP/UDyan9UTxLJuUxvDCcX5i2hoVeJ7/PCM7U0dN6HUsJ6j4XPHLBmN28bptrWxEgKX0u9i/V6bncgnOD/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750316237; c=relaxed/simple;
	bh=ZpxBiFvNTV24CakR+gqDkbfEBqa7hfmTQr9mkfpyNqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cbV5yJCS8k5Wd1LjIizAIk6XS4RGz49eFnSpUO5ZO18OD7xEgow44ne2zPsKVIPppz+0nXkHYbYFylSoCgPpMceK3lRL/07l0GZGmizqdaT0oKq9MvLkt7ivQ8+I32Oq6T0S/RxiwBwYMtAY8gdmHDAL2aRiEi4y2iY1t/JU1SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a+iB4PHa; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-748da522e79so240778b3a.1
        for <linux-pm@vger.kernel.org>; Wed, 18 Jun 2025 23:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750316235; x=1750921035; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3wXDhrb5gMp7gMf4JCS4TNzFLsoHKLLOownJ0Qkmwik=;
        b=a+iB4PHanVN5l90XLRyePv56zs7x0oatjruNiR0U97qR/EKHqQYihxWfQ5D9kX38AT
         jX/dkTGQGp+0hOZLu/rl2FPD6DUTr3ztK7uSU07PPNeZAwi5FKVrGkJyS41q3bxQut/y
         LFiB6CI5B3EM1YZIC2KiNuIRQZPCDy4jDBxHZBDPR/4NtuxQ7u6KKMVtzknTiuxAR1ts
         8JupLugUd0VRRtt8m0g3CWS99Abc5VWD8o+9Gympq6XKbsn2/F/4ywi9r7OCawo8LBDh
         ZZdTF2gX7nnJw2WzmtaDVdFcdqHqwqyZALgQXHb5EZj69Bm/2LF02BLNL8bobUXJ2KpZ
         NI0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750316235; x=1750921035;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3wXDhrb5gMp7gMf4JCS4TNzFLsoHKLLOownJ0Qkmwik=;
        b=opBOlMFp+D9AafK73Y17XNuv1NKpGveYZ3/JOt6xScj3XzcmHDIJabP9ryTnCLbFV2
         93PCjoIVAUIdZ73AVGuKrWZG7mbc1S6OOvW/BEdRjgrs4DTQMIc0KiCpfdyqN8ZxTtWa
         LUJKV2DSrCSzDtAXMSTFTMAhO3Qv/8wfkuqCev5jDKE+BwtB9QUds8XFO8JZMu4GnokO
         aTAuoTVXWFQfu3wUXJIIlUZSNebVm0KbF3m8yCFKzjoJrbhR9WV0LHItZxD5rwy9VQ35
         LLFRlEQUJBry1yrdugkdC7IaHomJ219XtJ3N1p2n/0DSbiDBjQsDZ99C0hGs3eWwoPia
         ZV8g==
X-Forwarded-Encrypted: i=1; AJvYcCVfwqBdI/ExHnh6fQukMPxZ6T9B2EZZ900z3Z4psTbeO2uInmd3nCzaIw3T3slLjudTkRMV09WpgQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyhLaghK5DH9BrSOmQQS6nvr2ofQG869iWyDj2vaqMu0uZG9N2Y
	059q17ojy1aYlORiSdIFpGUDTrTeoQdA6mV/82Jydb2EfAf5C0DFotbA85RzRAg1tXg=
X-Gm-Gg: ASbGncteywdhHoTCq9EKxKLDdPmNoBHK7OApCMrSljZA/4LJHw/rXtmamEQTJehn9ZD
	Jt9+irPG6kJSTsnysIzLtr4GmMqh7dansvH4yjdGyVZx9TbNf8CwAsFmEmzKs1qhTgS28PO/UpQ
	u9ugR6kPFg8magkkK/QBH8cAnGW5zNW3ibTPwGUw8wcIvnFA/ct/xY3X38XcFUbDz8hbtOYv67T
	u5zDZ6dnng+zek+86V0r6QYACp6/8WN/1lz7fEAx0IK/L22GyABziL2nukLwVoyv1N0zOADGLum
	2y3wjEtTnGc16FI55BmvlxyiH7ywONnRHo4H0qLb3CFO9BCbGGVEvymxbwtlHGk=
X-Google-Smtp-Source: AGHT+IGlUdbrNrLWErrn0rW+WYn9rsrB56pXxkDz0+uZxdgPmgRSJkVrVTE8T9ZZyrn/M1TvSJEAvw==
X-Received: by 2002:a05:6a00:3c89:b0:736:450c:fa54 with SMTP id d2e1a72fcca58-7489cf8b19amr26442033b3a.6.1750316235484;
        Wed, 18 Jun 2025 23:57:15 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2fe163a199sm10414785a12.5.2025.06.18.23.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 23:57:14 -0700 (PDT)
Date: Thu, 19 Jun 2025 12:27:13 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Abhinav Ananthu <abhinav.ogl@gmail.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, linux-pm@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] rust: cpufreq: Ensure C ABI compatibility in all
 unsafe
Message-ID: <20250619065713.hm5ye2uhikaei2xo@vireshk-i7>
References: <20250613101815.18092-1-abhinav.ogl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613101815.18092-1-abhinav.ogl@gmail.com>

On 13-06-25, 15:48, Abhinav Ananthu wrote:
> Update all `unsafe extern "C"` callback functions in the cpufreq module to
> use `kernel::ffi` types (`c_int`, `c_uint`, etc.) instead of Rust-native
> types like `i32`, `u32`, or `usize`.
> 
> This change ensures that all Rust callbacks have signatures that are
> ABI-compatible with their corresponding C counterparts, which is critical
> for FFI correctness and safety.
> 
> Suggested-by: Miguel Ojeda <ojeda@kernel.org>
> Link: https://github.com/Rust-for-Linux/linux/issues/1170
> Signed-off-by: Abhinav Ananthu <abhinav.ogl@gmail.com>
> ---
>  rust/kernel/cpufreq.rs | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
> index 11b03e9d7e89..481a6d2dc362 100644
> --- a/rust/kernel/cpufreq.rs
> +++ b/rust/kernel/cpufreq.rs
> @@ -1207,8 +1207,8 @@ impl<T: Driver> Registration<T> {
>      /// - The pointer arguments must be valid pointers.
>      unsafe extern "C" fn target_callback(
>          ptr: *mut bindings::cpufreq_policy,
> -        target_freq: u32,
> -        relation: u32,
> +        target_freq: c_uint,
> +        relation: c_uint,

I think the one in prelude points to core::ffi::* instead, while we
want to use kernel::ffi::* ?

Miguel ?

Also why does prelude use ::ffi::* instead of kernel::ffi::* ? I was always a
bit confused about it.

-- 
viresh

