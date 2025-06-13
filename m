Return-Path: <linux-pm+bounces-28625-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00CE8AD8168
	for <lists+linux-pm@lfdr.de>; Fri, 13 Jun 2025 05:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03F9E1899E3E
	for <lists+linux-pm@lfdr.de>; Fri, 13 Jun 2025 03:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350B8254AE7;
	Fri, 13 Jun 2025 03:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CaQGbVll"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1BE2475E8
	for <linux-pm@vger.kernel.org>; Fri, 13 Jun 2025 03:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749784098; cv=none; b=sejzZaUXpgSmFwbV05J13Z7fUR9bjizkwrl3yU97KVv7lLgROwGjkJ75IP7FZ5GIykGWa42mrl0WZNefBPackubE3lZXD/p2R83J07VooGJRuQ560P75jYKqaoH6hTwopFnqDdIoeVK89edy62DK/Qr2qk2BN4big/Plq2K2b9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749784098; c=relaxed/simple;
	bh=F/cPlJRxdRgqrcVVwCfuopWvR2TZ7HOAdOh3IpnzUjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X3bLhHtE/z1OK1F7jmqmZ30HetQXjsg7Q3zCBx6qVyN62Njt4QTRkz0CY6S/7HwWzNXm3hXiW1uqly6NW8UAz8eHNOWZ2Rhoi1pw6jq801SgP5lVfgGVNzKM+ZDhIakifEwBS9OSH+4EAXP24gLHOds4eQileEHEavvW6yc37oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CaQGbVll; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-235a3dd4f0dso11034315ad.0
        for <linux-pm@vger.kernel.org>; Thu, 12 Jun 2025 20:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749784095; x=1750388895; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WIYd06ooslrA2HtyvTs732OcgY4BnneKr/vzwTUEOyE=;
        b=CaQGbVllxnKlBeCX28izrqY4icgwAw03huMMQ1F02/WLRvPxK1dV0VOklAhushOTlM
         OTe8n0rox2Mxry+uHPq2IzEedzJ2XQ7KBkkiq9pB6pBwZ+s6RRrHqhDHL2yfrlQeihkA
         0PCDcXf0HpMCjUx1YLrNIqHQCpmIVxiXM23w8f/AiXMFLuCye3Zx5Ss8BDRiGz7U6p8M
         Bu6bhZS8uA/6f7b2fdInJGaAyBVyzS9jYupId6JtNFgJ1zoks95w8UeFf3XPV1erac8m
         EXPCWubTWDhVEjVxH1GMngJH24zICCTdUFQx8+DdM2lqtkMUNDO/UyIYWrjJa81cB/Em
         6DXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749784095; x=1750388895;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WIYd06ooslrA2HtyvTs732OcgY4BnneKr/vzwTUEOyE=;
        b=CcHZSYy8N85TEj0fpJMj1lOuplYzQyXXySxK98Wyf3ZRqay2itSZ7uUBoxykKuvCkU
         mYzJB7uQOkpMfHNlDqOeioH3Uq57f55V6uc0oW7LLaczeuON1pq7hhLW2GbAufZPPbN0
         GPHdS4/TIOr9hptu2WFCUuc5mLhd0N2xiQs5vM5D9VefIG0MGfSNgnnWObKKnzIvVjDN
         aek1LYRGWioZnjoOlAEucH3BXugaekIQSxcbvGD30fPZ9AFY8VOwU1Qvz6Qi0WZfU9iz
         2orklo6VRViHeTjv+puljfP+FlesspcQJOyjJOfylwlQHN49gzViBjC/lesGC9IShEf9
         4DLw==
X-Forwarded-Encrypted: i=1; AJvYcCWwpPG/18SeDsQ9t6qO7oBvpyjD/fpNYDPJuVAeItvPCp1sVVoYde+42LK61JeiZ9HFQxXhxLgiSg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwgooMfRTPldSdQlRejI6MOQdf/yj8Sbgc99BQLHEH2KHl95t3+
	2KF8XgQ8XkaCsh1OGPDC2pxLkzNPaQROkuqZTd88SBWWTV7bHiWYlvceSaJyyzBonog=
X-Gm-Gg: ASbGncs3CQZ6xv54TaRZUWimYZg9WeKl4tmVcUfhcOGulbVrdfprEKnohvWnVKCVE0W
	13ZbH5nQlGxgUTMDdDemr/s+rxtW4EygQboYbtoNHhBZ7LoHF6UngRN16OidHmB0wcDnUO3fWEf
	FoXTTPH86KdIgVPwHzdwf4HXHGSb0IdakS8mbW+G31tH7WZxYtAtCwgEQWFqoB1DbvlmMjRfDXP
	fukY7FQO+bCgj9NAaj9elby/Tm1tucz+hNvMVO+iJd+KYoGqIAaaGaH1vaCMJCBITmroVlWb6nC
	s/IL8vHpbltt68j7n65TJ+jHbrlp8jITLhE0T4eCf2mN6FT+J3AjAFcp1J9W0Wwdn12+8+NUvQ=
	=
X-Google-Smtp-Source: AGHT+IF8Y0wgnlnJ7uFcWUJUQNglN2V/OKcklcaqSOverj9hfKklxcYvgBJpD9CVwi+TFZv3FW4+8A==
X-Received: by 2002:a17:903:1210:b0:220:ea90:191e with SMTP id d9443c01a7336-2365d8910f0mr21711975ad.4.1749784094946;
        Thu, 12 Jun 2025 20:08:14 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365de782f1sm4555785ad.134.2025.06.12.20.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 20:08:14 -0700 (PDT)
Date: Fri, 13 Jun 2025 08:38:11 +0530
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
Subject: Re: [PATCH v2] rust : Update the bios_limit_callback to use the C
 FFI types #1170
Message-ID: <20250613030811.ytegbtlw6rgwtjgr@vireshk-i7>
References: <20250612104127.10299-1-abhinav.ogl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250612104127.10299-1-abhinav.ogl@gmail.com>

Hi Abhinav,

Thanks for looking into this..

On 12-06-25, 16:11, Abhinav Ananthu wrote:
> diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
> index b0a9c6182aec..e97607ed86c2 100644
> --- a/rust/kernel/cpufreq.rs
> +++ b/rust/kernel/cpufreq.rs
> @@ -1277,7 +1277,7 @@ extern "C" fn update_limits_callback(ptr: *mut bindings::cpufreq_policy) {
>      /// Driver's `bios_limit` callback.
>      ///
>      /// SAFETY: Called from C. Inputs must be valid pointers.
> -    extern "C" fn bios_limit_callback(cpu: i32, limit: *mut u32) -> kernel::ffi::c_int {
> +    extern "C" fn bios_limit_callback(cpu: c_int, limit: *mut c_uint) -> c_int {
>          from_result(|| {
>              let mut policy = PolicyCpu::from_cpu(cpu as u32)?;

There are a couple of more FFI callbacks which use `u32`, `usize`,
etc.. Can you please fix them all, basically all callbacks with `unsafe
extern "C"`.

Also please rebase over linux-next/master, there are few recent
updates available there.

-- 
viresh

