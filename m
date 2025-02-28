Return-Path: <linux-pm+bounces-23191-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF025A4A1E0
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 19:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0319F3B7F97
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 18:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D9927CCEC;
	Fri, 28 Feb 2025 18:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJyQ47+d"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570BA27CCC4;
	Fri, 28 Feb 2025 18:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740768151; cv=none; b=KpQGxZyQwAwr3hI9RUJgsaGat9D/RjNt+D2LJGmkH01Gxmv/Ldta9dsXdTvpRARmWPJLdDqnUQnYhSyECaXtX4eBM+BWGuN3yRehhR3jx9mcM3NHOfa8sitWzoxhUYkahRWkGiDVlAnhUmrU+LIyxneys3itHGAUWgu343jzu/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740768151; c=relaxed/simple;
	bh=5lSITHDlRILZPrE35B3ku7igRsvprNxDX13ui0l4HNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IHx80wlr/ebYyYr3yfeZ3PLT4i7gI2krPVCGvIcTllJu1aEcVFqxtCNQQ7UakoTxdNw6i84SzY+/RQWfQ5xF9/lFS6x0iA/nfv0CbzSps40Rg8ow+eAa17MdjxAVZm/eP4jD8rBfD6qig4bMJLnV6CLyQRv9IC+YTXxcphB9qFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kJyQ47+d; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2232b12cd36so35375745ad.0;
        Fri, 28 Feb 2025 10:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740768149; x=1741372949; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+cMh2PRfuILm2UXO22hatPrnTgkwXb9D7IBTjSStnU8=;
        b=kJyQ47+dIdC2MZL7r1NmZ5dvrD28r5KtsMqWlP3vGcFNCT+LYSjpYcYAhF0NmeGe2O
         2rVUE6PMaTZ1OX8U1fvGPuQSb9dIM0t249yJX5z5pzCuiwzG12dKukuvCwmGqDRVsgst
         VhKiWYBBlMd7gpqSnq929BRBzS80xMdrEzZLUkBVZwilvc+YA6ujoSFd4g05xlXDeY+7
         qSCRwk4naReMI1YvXXDVQbKyz5MB7i890oA/8hc3gwTcP81hlV+Ei12U4F1cQBvYc3/7
         A8Al07s+nQO13oYAUiCwxRSRBiptpdbOK6R9QqsEUeIJXBLSmyK65eb+2DxtbEd3vinp
         p7Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740768149; x=1741372949;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+cMh2PRfuILm2UXO22hatPrnTgkwXb9D7IBTjSStnU8=;
        b=PQxjPpbh5bgLNh6ucysWgGNjAr0Sqx0McFJ92ca1040l6z5q0mcWCHP1hRg3hZsF+T
         f6SM/mRI5x/39GkgSR/le6rNBNAGngOna90TxRXRMVqGBcrUMieadTAncPw0fbcL0W6G
         2/kFKexwdKm8wDoke4lkfUCF+ITkI9xv6AV0NWaPbyyqau7QGV8327MBYXwc0zKEtNkG
         G+y036PiohJk9GfiCphYMZM3bO7q3RNkT8MAnks77QhcFd4+Og/RSyayC3mh6J2O27QH
         KI3kjPxVXChIigqW7zkeQ1ro6nC1czD1Np2+D5BHC6jzaW4INzkDtq4ZGHwGQ4sUq0Rj
         lWiw==
X-Forwarded-Encrypted: i=1; AJvYcCW/T+QwNTN1ALa7qPc07bBK6AjIqF1Gx/oEXCosGAZjT69IPQN3LOGY3vn5EePwpayKOxgfpAfpWYY+5go=@vger.kernel.org, AJvYcCWlzU4hSIBagPwG5OsGU2uWjLoioi/OQYYlq0Mi8bAUTepqsTIJrdduQqvH2BlzJTx7TXTNvh2qxy0=@vger.kernel.org, AJvYcCXTmKWHNgLfD9gShOZLh3IEpCtZHNLFaYro5Tpm26uxwhug/F40Zk6k05CbwzGUfvNCdDyUSEKlVVYYxiT18s8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLLJvIJVHgOgcQroaywQdgCvnNWeADeXkGMH1FT8NaX/oFQV8T
	l2aizglpscnRF4Q1bJIsdYD6MEONaySKnGkzC3Npachz8FOIoOZc
X-Gm-Gg: ASbGncsB626pZVtas+/PBh1n9NDYpmR4xlAsKZEHOoktrfT/xNm5lY5grXY9z/+HrDo
	yGMTxDZ6gTsSgzoOQn7d4cVcCV1K/kHf4SOReOYWy1qdH2m/N0uzMhgeXiazS2mIiU0mPgoAdTb
	h3uFSGdC+aZIkQiQvdaWOhgflLGZwF9GPn73m4Ti5b1xVqXYEnEOF+ZlesNCwP3LLXp8Dfh9tkq
	cGeOET9ZDOuOzX1inLkDmf8MHnCfKx36vLRnd7CcUIg3rOKrsVwGVWKtRVuETvw5ghDiqmoKjYD
	fwXe5nv0jmVScv0xaOcHnGxInMpbKmA58wumEo2D0R8i6N+tRg==
X-Google-Smtp-Source: AGHT+IExhQFhIQ67IxZzaSXKW5q1qrVIn7lWPc2s9Her1UKGTNiUzITjAK5I99TIfkwYv9BXTOSwwg==
X-Received: by 2002:a05:6a20:6a05:b0:1ee:6b39:c386 with SMTP id adf61e73a8af0-1f2f4cbedfdmr7296811637.13.1740768149474;
        Fri, 28 Feb 2025 10:42:29 -0800 (PST)
Received: from localhost (maglev-oncall.nvidia.com. [216.228.125.128])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aee90c7e519sm1828529a12.61.2025.02.28.10.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 10:42:28 -0800 (PST)
Date: Fri, 28 Feb 2025 13:42:26 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Danilo Krummrich <dakr@redhat.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Erik Schilling <erik.schilling@linaro.org>,
	Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Jason Gunthorpe <jgg@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>, linux-pm@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Bitmap bindings for rust
Message-ID: <Z8IDksO2uEzuq2M8@thinkpad>
References: <20250224233938.3158-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224233938.3158-1-yury.norov@gmail.com>

On Mon, Feb 24, 2025 at 06:39:34PM -0500, Yury Norov wrote:
> The bindings and a new maintenance entry together with the API changes
> policy.
> 
> v1: https://lore.kernel.org/all/20250221205649.141305-1-yury.norov@gmail.com/T/
> v2:
>  - export alloc_cpumask_var() @ Viresh;
>  - clarify that the maintenance rules apply to all bitmap interfaces,
>    including those not mentioned explicitly in the helpers @ Miguel.

OK, adding in bitmap-for-next for testing.

Thanks,
Yury
 
> Viresh Kumar (1):
>   rust: Add cpumask helpers
> 
> Yury Norov [NVIDIA] (1):
>   MAINTAINERS: add rust bindings entry for bitmap API
> 
>  MAINTAINERS                     |  5 ++++
>  rust/bindings/bindings_helper.h |  1 +
>  rust/helpers/cpumask.c          | 45 +++++++++++++++++++++++++++++++++
>  rust/helpers/helpers.c          |  1 +
>  4 files changed, 52 insertions(+)
>  create mode 100644 rust/helpers/cpumask.c
> 
> -- 
> 2.43.0

