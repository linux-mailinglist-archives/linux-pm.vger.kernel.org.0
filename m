Return-Path: <linux-pm+bounces-21757-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F24F7A2FEC2
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 01:02:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 147E73A54EC
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 00:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A8722F19;
	Tue, 11 Feb 2025 00:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BsVQYlCk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EAE2CA8;
	Tue, 11 Feb 2025 00:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739232128; cv=none; b=ceNMqBigHLIJLwJUfVrwotdbmQ6/1S+WktuANzhuxrt11AE8PrX33MfVB8hJbBPSRj8CQ3HSc9w30+vX+DwcH4A82xUcvKfrvgCHAGG5u0twIv/qP9OTImZTbu8H1xpPKHOv8yFSlHF3gKboj+Ga1f1U+Cd24m9IANASsJ5YF2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739232128; c=relaxed/simple;
	bh=F0pdyiD81sFkm398csGJqQBeGQ2J9fkDm33FEy97YzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V0Z340wd6b/RMMqTv95iMskjLFB7q9FvxdES8M7m0HwDkB+jUhidqRsjvJN1be2Oi6SyAyrRQ4UfEQGz0N+w0kt8qtQ3mf5pDSGCdkLxvc0CwGWfoZ3SyslnPKpUnkpIMZmlreHxjkeEgSu/FTD5fg0+Chp4eTrUtUnJH8I62DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BsVQYlCk; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2fa40c0bab2so5132878a91.0;
        Mon, 10 Feb 2025 16:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739232126; x=1739836926; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4hGmwdTz43yi8CRgYF+QhfvcC0Uza0p3/oPN6qReQCs=;
        b=BsVQYlCkJyA6VqBHi8vcMwB5BeyzL4SWFKlinEP3nSCAnyk/X+8gmuk3IB80kdE8b2
         UOx+W/PlwVsxlNjAQgxyheJdbEPVLLVrc+bP3EJO40FKnqlEAhXXzkoW/Ie8D4bDZBnd
         hJ7H5uYxBSCo578cLzTmiLE11bGnMlD5M48utXgwcWfLro0rIe93WgU3to4v5UvNMf41
         e7RWSvalcMJsfKgyqFyZP5iDDkF+/Fzf3qDCtDb2DFkFOeGjLZINP/G2p9V8QTe0Ofs5
         hmCSYbmxZ+f7zKKFDsySdP1jLmEbmyhZzlYsoWJPjXFL1j8MsBezgUX8Kh1m/WSqT5BB
         qJ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739232126; x=1739836926;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4hGmwdTz43yi8CRgYF+QhfvcC0Uza0p3/oPN6qReQCs=;
        b=KpvFX/C+vPQYEgyxsVV9AmPt2MkSfyh4j7pmTfu5SlOoN4Q+UYAQWHBQ1JKDgRtHOA
         rWAn4IQrdbUO/AdKhZ6RNgH6N4arQaYXakX9TkJ75x/7yNmjg32u/++/2riqRgJSSG0S
         fp//izfCuD5nU57r3YHEJtAdIMjqqcz87Q8Ji8XK5D/VnhI8g4QvncG8yBeLfYxzTPJl
         lclGLgB/rNmBZ7ikCldSTCtH+9teN6PwBNfYFCIeua5cKMP0qtYXgeDXFIQTUFtbIH6X
         E1Vu/uwse8zjpRVK06aAXWWymkGj0JGn0OvoN4yh9MAW/+5ZAdHlF4MZSVvHolXYS/HI
         vQ9w==
X-Forwarded-Encrypted: i=1; AJvYcCVAIx0yJV21m4p6oArpPrcFBWBN6Vk7OqudwQ/LwIqHsUeOMt5X/kDfJViQXutfF+83XlTaCzWBT6nMCg4a15c=@vger.kernel.org, AJvYcCVPWLHtIR6OoxhTOOLvilB4wC5V3Btu1O3cQx+5LkuHZ7F8YQQ68bCwcmmJrXQJBLKIU1Yl3B2GKu8=@vger.kernel.org, AJvYcCWDok4iv2teQ5bdxk0ea3YUMqvkTj/i44AnKSwyTVfrhLOKVVgXkwKtFc4IU6hMoNa+WQM59JAFQKCRQLE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn9St6QGpbApQXsiDFMdDrS4PLgHuocHYYLZ7M2Z/4c6gRMBhL
	B1m/KYqU//nfP+sKgRuVZzvLnucR6/dWXIV/wooInMU2Yck5PT9L
X-Gm-Gg: ASbGncsNykJxvZydbx4sXseR/qzX693v9h/gqlED5Sftu4GdDsVvTZj8BkvS9VgvKPs
	72Zjt4y2f3T1n9Tp+OsYB5POGmeotR1m1qqTVlfmTwmToaT4Xjc8KBn1I+T347ZV7HNtlli6Z8O
	pDAqFW4SWABToGkllh2w36TLRSCWk8gdbE0W5F0MxKxejqqxKevfRCVbnjF0Nlluwj2vLa6bWcr
	YHw7Qh6h8gPz4v5aQVitDPV2oem7F8InswGnLeUsTUAkACnNAIGFmAAfTIfz/YBwBTt2gBf9tDT
	cETlkJgxChsVMi8=
X-Google-Smtp-Source: AGHT+IGszLO1hm7FntpF5LKYRl4sfNqpDc9kIQOd9hkIqSvwUns/kn1JVqGStnQD5AcVhZKmJFWioA==
X-Received: by 2002:a17:90b:3a87:b0:2fa:ba3:5451 with SMTP id 98e67ed59e1d1-2fa2450d1bamr22847169a91.35.1739232125482;
        Mon, 10 Feb 2025 16:02:05 -0800 (PST)
Received: from localhost ([216.228.125.130])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa09a46121sm9221511a91.19.2025.02.10.16.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 16:02:04 -0800 (PST)
Date: Mon, 10 Feb 2025 19:02:02 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Danilo Krummrich <dakr@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
	rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Erik Schilling <erik.schilling@linaro.org>,
	Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V8 04/14] rust: Add cpumask helpers
Message-ID: <Z6qTelPSqpFk439l@thinkpad>
References: <cover.1738832118.git.viresh.kumar@linaro.org>
 <db0166341ce824c157d0c58c240b3efc6aec6f6e.1738832118.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db0166341ce824c157d0c58c240b3efc6aec6f6e.1738832118.git.viresh.kumar@linaro.org>

On Thu, Feb 06, 2025 at 02:58:25PM +0530, Viresh Kumar wrote:
> In order to prepare for adding Rust abstractions for cpumask, this patch
> adds cpumask helpers.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  MAINTAINERS                     |  1 +
>  rust/bindings/bindings_helper.h |  1 +
>  rust/helpers/cpumask.c          | 40 +++++++++++++++++++++++++++++++++
>  rust/helpers/helpers.c          |  1 +
>  4 files changed, 43 insertions(+)
>  create mode 100644 rust/helpers/cpumask.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ee6709599df5..bfc1bf2ebd77 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4021,6 +4021,7 @@ F:	lib/cpumask_kunit.c
>  F:	lib/find_bit.c
>  F:	lib/find_bit_benchmark.c
>  F:	lib/test_bitmap.c
> +F:	rust/helpers/cpumask.c

Sorry what? I never committed to maintain this thing, and will
definitely not do it for free.

NAK.

>  F:	tools/include/linux/bitfield.h
>  F:	tools/include/linux/bitmap.h
>  F:	tools/include/linux/bits.h
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> index fda1e0d8f376..59b4bc49d039 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -11,6 +11,7 @@
>  #include <linux/blk_types.h>
>  #include <linux/blkdev.h>
>  #include <linux/cpu.h>
> +#include <linux/cpumask.h>
>  #include <linux/cred.h>
>  #include <linux/errname.h>
>  #include <linux/ethtool.h>
> diff --git a/rust/helpers/cpumask.c b/rust/helpers/cpumask.c
> new file mode 100644
> index 000000000000..49267ad33b3c
> --- /dev/null
> +++ b/rust/helpers/cpumask.c
> @@ -0,0 +1,40 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/cpumask.h>
> +
> +void rust_helper_cpumask_set_cpu(unsigned int cpu, struct cpumask *dstp)
> +{
> +	cpumask_set_cpu(cpu, dstp);
> +}
> +
> +void rust_helper_cpumask_clear_cpu(int cpu, struct cpumask *dstp)
> +{
> +	cpumask_clear_cpu(cpu, dstp);
> +}
> +
> +void rust_helper_cpumask_setall(struct cpumask *dstp)
> +{
> +	cpumask_setall(dstp);
> +}
> +
> +unsigned int rust_helper_cpumask_weight(struct cpumask *srcp)
> +{
> +	return cpumask_weight(srcp);
> +}
> +
> +void rust_helper_cpumask_copy(struct cpumask *dstp, const struct cpumask *srcp)
> +{
> +	cpumask_copy(dstp, srcp);
> +}
> +
> +bool rust_helper_zalloc_cpumask_var(cpumask_var_t *mask, gfp_t flags)
> +{
> +	return zalloc_cpumask_var(mask, flags);
> +}
> +
> +#ifndef CONFIG_CPUMASK_OFFSTACK
> +void rust_helper_free_cpumask_var(cpumask_var_t mask)
> +{
> +	free_cpumask_var(mask);
> +}
> +#endif

This is most likely wrong because free_cpumask_var() is declared
unconditionally, and I suspect the rust helper should be as well.

> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> index 0640b7e115be..de2341cfd917 100644
> --- a/rust/helpers/helpers.c
> +++ b/rust/helpers/helpers.c
> @@ -11,6 +11,7 @@
>  #include "bug.c"
>  #include "build_assert.c"
>  #include "build_bug.c"
> +#include "cpumask.c"
>  #include "cred.c"
>  #include "device.c"
>  #include "err.c"
> -- 
> 2.31.1.272.g89b43f80a514

Please for the next iteration keep me CCed for the whole series. I
want to make sure you'll not make me a rust maintainer accidentally.

Thanks,
Yury

