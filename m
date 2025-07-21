Return-Path: <linux-pm+bounces-31158-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A098B0BDBC
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 09:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CECB3ADD70
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 07:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB00128467B;
	Mon, 21 Jul 2025 07:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kGGSv0HF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F95A2836B4
	for <linux-pm@vger.kernel.org>; Mon, 21 Jul 2025 07:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753083320; cv=none; b=dMpK6LRlHGi65UcawToqYyC7vPC8Jtzsl/IM5yMqZmPj1xGCurHG90nHLrrq7ldSvOfZ+5FJAPVTrAIhxIzj9jvA23IuO3Ub3nTx/wHvQnVHYs+Txkz9008Q9js91n9kLwHxe5+O/Dpybz9WnJRCjEQinknveeAAyEo7Co/3O8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753083320; c=relaxed/simple;
	bh=75yem3WjluK+t3HLkk9qsg5NT0tv+wkaJxCTWsY2V44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VMZCRA3oyeVhq2rSSN8SWCpgiiJS7Zhu2dalJQmZYCHBkHLDjtYzzekwlqIXtgTvQFOBONmck7krH0T/VG2cPjz+DVSO1JAfP2ueAKPzUDow1xNtGuiI9Z1kyFDid6cHx31ghtMCIKWiLZ+RupSukwIVPTQ8OY4n95mRcr9+xtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kGGSv0HF; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-237311f5a54so30456635ad.2
        for <linux-pm@vger.kernel.org>; Mon, 21 Jul 2025 00:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753083318; x=1753688118; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z5dBnPu5UuatkXMTVj9BGvrncU8K1V9rUHxc0C/1nEk=;
        b=kGGSv0HFtXZDd/hf8OoliuSHGqTcVMDJmtt+p69A1UB+zSfVBODkqmNY2aiPHYoJ14
         jKSpkiU4TkRSUkRSbw0Ul6L+xEDsIRhAU14VTBOpBdsVfZ7bDP/mYjfhawa56kHmO+yt
         VfYUKhjdZ2yZAEx7YrVTb7EJhbrpEa4qkk/D+9qoZPDhY9pwkq+GWNJR7AA4k9U8D+cP
         FlcC0hoB9s2ztApoLKJoZi4qBmhHvI9z5cGSCjJzgfSWVGJrSElYYe8wV54Z7Y/UyQcg
         GrZva1rov1N6CJUCRIDCDHOpo6BODt7/TRHIWuLhSAAQYB8fZ/Trcnban2blXlBgKjbp
         p/+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753083318; x=1753688118;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z5dBnPu5UuatkXMTVj9BGvrncU8K1V9rUHxc0C/1nEk=;
        b=JnledBsYuUjcSno2efQvGK61jmyDz7QIpUNWBeTASLPJC6EeUlMUES4fJfnFduR0p2
         az19EcJwc2L4JWlK0FOjrnjamGYUEQo6INOxgTVfYLlVz12iq/un051rFZL8slV1Nunb
         ygJynuuUkDJmUafCVziKP/4LPHAp1OBJSP8DwLCWVrfhZMvKORRzsYmsqOa3QlF193Ik
         xP2jIffWr4nu2WtrrL7XZRvNbRs9bL2a/vPYPiSjvaHSyMJ1DJz4fttRuMpxc/3cAGLG
         v7fQnUglI8Xc49uu8QEd7V9pKEm1DHcGu0MzZVVGZN2CxcKSpqS7jglOHS74ME9UHGP1
         Ls0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVw8ysL1lXF/vZ7vbSDU621JmKluQsChHsVpxDKvEoE6KutWGaAa7m2nY1IZXllgB10zsyGr1vjWg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz50qKODSj8b5nkTHa4nJPVPupdXXF8iQYFSjMn5vIWlTatvo9d
	qM8MyW472/na2ZW4w6cd75o2xWQt6G9Z1TnnVRCQxp8SSsnkmXn/Vw0Mwlie/86fstM=
X-Gm-Gg: ASbGncs42sQ7gHpamj12xoP1ynCmdVgCDdo3AD118HKYTnZsuOFSpKbf9VQkf8adsKC
	vl6sOqigeb0OVHZxCECB6wns5cq/cJ5dwbLmswVVuPIUXEspBHkpqpnJ51nRAGGA25g6ynjKEQW
	SY6wjX5OeUpo/5ER2EdcSHvLgy9iH14msVIwfv75CZYvEfIXzf7FPYMZnA0dIepdJPcYUq2hcP6
	cwfPLBK/nSxxtywfrg0n5xdAhds5q4EYuoTW8vRFvCOvXxXYSZIAVtGMaRfrah0nqK7EExttfQz
	XDQBPKk9SzCHAlQtvSZy5Rd6W2zqugRo+zL/wRbzJLgaK9GsZN8DwJ7pIbckW75j/CEjh6J1EQe
	kP5gYhd38mQC94a929E5vad+VLXPpF2Pj4Q==
X-Google-Smtp-Source: AGHT+IETNDRZoddMesKOQhKRvcZzakzOmMfiCHJxW7eO5wvM2qbmpmfxE8rY5ugFlkzEUO27/HUOzQ==
X-Received: by 2002:a17:902:d58c:b0:234:a139:120a with SMTP id d9443c01a7336-23e2572ab00mr258734915ad.32.1753083318367;
        Mon, 21 Jul 2025 00:35:18 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6d239dsm52577175ad.155.2025.07.21.00.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 00:35:17 -0700 (PDT)
Date: Mon, 21 Jul 2025 13:05:15 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dave Ertman <david.m.ertman@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, Leon Romanovsky <leon@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	netdev@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 04/10] rust: cpufreq: use `core::ffi::CStr` method
 names
Message-ID: <20250721073515.2srip46utnyap7fb@vireshk-i7>
References: <20250719-core-cstr-fanout-1-v2-0-e1cb53f6d233@gmail.com>
 <20250719-core-cstr-fanout-1-v2-4-e1cb53f6d233@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250719-core-cstr-fanout-1-v2-4-e1cb53f6d233@gmail.com>

On 19-07-25, 18:42, Tamir Duberstein wrote:
> Prepare for `core::ffi::CStr` taking the place of `kernel::str::CStr` by
> avoid methods that only exist on the latter.
> 
> Link: https://github.com/Rust-for-Linux/linux/issues/1075
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Benno Lossin <lossin@kernel.org>
> Acked-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
>  rust/kernel/cpufreq.rs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
> index e8d231971276..71d601f7c261 100644
> --- a/rust/kernel/cpufreq.rs
> +++ b/rust/kernel/cpufreq.rs
> @@ -1018,7 +1018,7 @@ impl<T: Driver> Registration<T> {
>      };
>  
>      const fn copy_name(name: &'static CStr) -> [c_char; CPUFREQ_NAME_LEN] {
> -        let src = name.as_bytes_with_nul();
> +        let src = name.to_bytes_with_nul();
>          let mut dst = [0; CPUFREQ_NAME_LEN];
>  
>          build_assert!(src.len() <= CPUFREQ_NAME_LEN);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

