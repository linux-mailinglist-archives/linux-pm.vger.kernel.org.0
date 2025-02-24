Return-Path: <linux-pm+bounces-22840-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E28A6A42CDD
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 20:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F9CA177AA3
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 19:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B28420468D;
	Mon, 24 Feb 2025 19:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EUfODXBF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22292156F44;
	Mon, 24 Feb 2025 19:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740426029; cv=none; b=MukWlMgXtJT2gT9gR9XDsaQYJsqF/8iMUOvM6f5v7yPHou0qByR+ofW1DkZfzDGTGMDBt+ydeF4vYBLeGAEX4XAj5HjJzfhTEVr/dyg1FKjnf+brrfoO2Ey17rSBoJjYSccm3+1dGBw+vGoTSrjr+LYirLMAdIjw1xFpm963B/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740426029; c=relaxed/simple;
	bh=0G337c2mwOQTgqfGBU7Y7usM5K2vtZxBQJHiZHq0MYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QRjPSnGmvnM1pyb7d4QvcFRqXJsNRSwGv/NTXNpWo3FGkNPmnfY4xUpNrQ4UGzV9lgiAVO15d7hPpz3GNJPFvaVWoHSNYKKLHpDRaUKmCzyWIuaJ6b/WS6u/xP05eLYXMCVMceUW3xFp1PI6flswvyaEbXmrKkDNYh3uMWWpgaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EUfODXBF; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-221050f3f00so109178465ad.2;
        Mon, 24 Feb 2025 11:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740426027; x=1741030827; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=blpZojWlw3eBFg2o1Iv9HU3+rowxftfATIEUjR6VDX0=;
        b=EUfODXBFcCTqiPXJ9vyPYjw1Eccwf40UDFuCcP2QsCSCNh+UpL9cy44fQhJl3Omg8z
         AR4/eUDNyfXgJ2XKnS8cpIRXvFIgIRvpo7cDJOkjt7KMMrd4EwLJQNZXKsaR0ssXwym3
         BoIYXIvOrWMKBJOu2tgvgnVs8/RSYf9gVkpXOjQ9AgZqK8oSVDtw+b17tdGXK+FIofRN
         +ZXz+2ecXm18WBORHoIcJ7KTvLb0LqyIWgVXyz9z+WVJCsbHovWKXiwqHS1pnHXXxY7D
         kl94zQ59GBj22I+RsFiexg6waR3+dwAA0ahIelr97/PWKLCoIpR4/PT/vT4gRX46brP4
         2p3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740426027; x=1741030827;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=blpZojWlw3eBFg2o1Iv9HU3+rowxftfATIEUjR6VDX0=;
        b=gwH5+KZ8sXWhfMIK4FlOziH1hx/sTKf3kLhcmlFXcQg8yLtT1NUG7ESNVHbA9INKme
         vmyEacLQAM5nS1Fq4inrLzMCRdhxTxcIkWUFmW1kpnU7OsaagQYG/8DfvVJnYsRI22bu
         ZLmnLSBmnXrp/8L3oLdF2YE5Qoy2vGOLFnNgD4qaQ3oTlELeikqYZOYAANttLef3KgOE
         Jthr6TAuvZh2f0KutkK4GdfTG7EhK1hhtZkGYJzc7v6Ir4zbJsDkA60TVu1Ce1yD0Eif
         4LiUAEwuBgsg+yAYOOKR6LpxfpZ1ynwFdHLju0rekP7YGOwaO7+yUdlD+t2EdGb9SpQo
         jOxw==
X-Forwarded-Encrypted: i=1; AJvYcCXFtW96HNXJnGYmZezDlnBFK0eFvbB3kn8xKC/sraYeGzS8NDUmhs462aDQbAtUw919rnmYWEDQkhc=@vger.kernel.org, AJvYcCXbPI1doODGK+fwpCJHh6xFJgV1F9c4mk8Y0BZBOllEG9zgMGNx/dSp9OmR02NfW0OnBhYUNQfKI6CBdGxoSVg=@vger.kernel.org, AJvYcCXqR/HUOs1EsB55CJNNgvAHXtIRhCVOoSpm5aP7luXRBYmcvX0jyUu1URJJREJ9H3+Fe4gKkvm5bbCleN4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfqZ9rLtCFT2UzAAOLIQ8kPUzYluTajLDlRty3KUBZVHJGQ5tn
	S2AYuCmZ4k67UZqSZ+1/WjvXX6S+n64PVGelBsfhivNQvUKibnzk
X-Gm-Gg: ASbGncvQSqzPwwZyZPa/NaNpMAwhSh7I/QBJgkbXRN2K0zdxzxoMpM8DUmWSql8vy+a
	uQXED1DHaYHaLGtYRGjw3UMgUXXaWNQ/7yJ91cMqJuHZoCtWJbw9PFlsryuRufH5GvWmCazz3uu
	2IINEAr93brNUYihN9HeeEwJWq+xbAefV9I+7SPBrPk5taqvLuaIl59VizCp8G4y4j175qj9m07
	tjz39Rt+wPDa81H/RmWsDFnFPY03expTwtQzPbo3i+edMqE/wM3wI39W+suvmxbPapY1d4mJUEW
	RChsCnXUdbVFrbr1iHhfnON47fkvXvtQmUXyIwSA3L83Xngjew==
X-Google-Smtp-Source: AGHT+IGYZfzCdstp40Y+7X9Sh1qT/lL1k7FXU2gb12PeZuuLcUxcbij/RYwdDrr6tsXIMsmPIcoXhg==
X-Received: by 2002:a05:6a20:258e:b0:1ee:d317:48e6 with SMTP id adf61e73a8af0-1f0fbff6cf8mr510414637.7.1740426027235;
        Mon, 24 Feb 2025 11:40:27 -0800 (PST)
Received: from localhost (maglev-oncall.nvidia.com. [216.228.125.128])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aeda8574dbasm13824a12.42.2025.02.24.11.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 11:40:26 -0800 (PST)
Date: Mon, 24 Feb 2025 14:40:24 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Danilo Krummrich <dakr@redhat.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
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
Subject: Re: [PATCH 1/2] rust: Add cpumask helpers
Message-ID: <Z7zLKNcvvga08jcw@thinkpad>
References: <20250221205649.141305-1-yury.norov@gmail.com>
 <20250221205649.141305-2-yury.norov@gmail.com>
 <20250224085613.ksburgsarl35tvnh@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224085613.ksburgsarl35tvnh@vireshk-i7>

On Mon, Feb 24, 2025 at 02:26:13PM +0530, Viresh Kumar wrote:
> Hi Yury,
> 
> On 21-02-25, 15:56, Yury Norov wrote:
> > Question: zalloc_cpumask_war() is a convenient wrapper around
> > alloc_cpumask_var_node(). Maybe rust can use the latter directly as it's
> > a true outlined function? There's more flexibility, if you need it, but
> > also a higher risk that the API will change: ~40 users vs 180 for zalloc
> > thing. Up to you guys. I can send v2 if needed.
> 
> I looked at the APIs again and here is what I feel:
> 
> - I am not sure if the Rust code will have any users of the *_node()
>   APIs in the near future. i.e. There is no need for the Rust code to
>   implement Cpumask::new_node() version for now.
> 
> - I have missed implementing the uninitialized version earlier,
>   alloc_cpumask_var(), which I think should be implemented right away.
>   Bindings for alloc_cpumask_var() are required to be added for this
>   though.
> 
> - One advantage of using zalloc_cpumask_var() instead of
>   alloc_cpumask_var() is that we don't need to open code it in the
>   Rust code, specifically for the !CONFIG_CPUMASK_OFFSTACK case where
>   we need to call cpumask_clear() separately.
>
> - The Rust side can have following abstractions for now:
> 
>   pub fn new() -> Result<Self>;
>   pub fn new_zeroed() -> Result<Self>;
> 
> -- 
> viresh

OK, if you need both I'll export both. I'll send it in v2 together
with clarifications from discussion with Miguel.
 

