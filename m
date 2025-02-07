Return-Path: <linux-pm+bounces-21529-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6610A2C0C5
	for <lists+linux-pm@lfdr.de>; Fri,  7 Feb 2025 11:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8B1A7A3F9B
	for <lists+linux-pm@lfdr.de>; Fri,  7 Feb 2025 10:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693C41DE3D6;
	Fri,  7 Feb 2025 10:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vnfPJdu7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD16F53A7
	for <linux-pm@vger.kernel.org>; Fri,  7 Feb 2025 10:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738924996; cv=none; b=PclDkWWMTOLmwA9hBi9g7K6il4TnG7doLY6eTZKkq88OjNg//shQ+qxyuQqr5y9alya55mzeH8jvB+EISZJmo92tXQ4/t/adW1MFjmECOWNqR5DSMiR+WMwWZmB6kORRPfAGTUqzT4w+/cE6Hn1T/R1EDUiBUdeqbldtcCgyTck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738924996; c=relaxed/simple;
	bh=hAoNykFyJ7QZhJYFf4N5rnUpO0uqECz17MfHTMXMUC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ouehcxxZLoUxYP6ydB3NOJZdNrD16vdFare778nwwJcM1hx8fJgwdN681zKwLc8xcjKEApdw7xz3jhF9zFLZ0/iASU57gX75TTnaZWBrEZYtTCZDi83sUt5V5OBwNOcQODTr16vpZ5Ba+mbdJ4yddGFeXTrB9QjxxHbd3PcY2aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vnfPJdu7; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21f49837d36so15383675ad.3
        for <linux-pm@vger.kernel.org>; Fri, 07 Feb 2025 02:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738924994; x=1739529794; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g1GRWaZfYYbqC6/CdwihJesZg/YXxEXg0hSLoDojT10=;
        b=vnfPJdu7MsXDHg4E+P5wN6VqJIJQ4bNizNlTrqjj0EKHkJw2o7AANMm1iUJVtBDxql
         vchVkX8cyyp91Dg3LMll4Tr0kMj8cNcRI7kJGXruWl9177GkitVDtiEBfYhzpyetOYvp
         6U2jVjNQdCOUkUUlx2Is3QxwYoF8f7B/EwMal9xFP71geSFF7gTzsPOniYv5t5Z7VfOq
         8WJ8bNNdX6brp5a3c6jFqIjVFDhu2UkBH9uTwR0TcIDjJwoF73Tp86NCcwANA93eDNiv
         ho2tIc6IKVhl2dBRAYgStZw0+BTUmRBp2OrO5y/3eg04byd0L+ilsA6Jpz/rzEyosOHZ
         Ycag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738924994; x=1739529794;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g1GRWaZfYYbqC6/CdwihJesZg/YXxEXg0hSLoDojT10=;
        b=l9HWH+vMgFsgr/BFZPBNl7rpcGfjh8QB5IBqDSRwwgelmUhlDzpTIYgtmPAN7ra1mG
         P8VpmcQBP6Df9C4zTG5nRyzgq5MM4wCAn0YTJw5uivpvjq4Jl22pyyGnrfdmMzmnoNUO
         BfIjNqoZFUeMCSrUnt4pIUYTxitV35xSGAIacCVFrSU6/HVT114tDPMS/cmUtNu2/1SS
         31oHwlt4bqrv/lrP4VsA94MSh6r3wTqLcoe+sw6b16Y8M3rhA0fbDG+aNyMKBEmW3dyE
         qNxUlXi1rP3XryccmMzMff2EJQfDatYlQhElbJmAeg9IEG/Y8k6zZZSkV0d3U7901LY9
         Yp+A==
X-Forwarded-Encrypted: i=1; AJvYcCW/G1bsaUhWFh7BZoqfc5L0hLGdcwh84/twHiPnP3yu6pT37ToNg8ymB9OqlUNisPxp4M50rTZhhw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJhu0nQK7BY4g2GDRevDNJanX6cesTZK64RUfli0ou2IoOnCBt
	iVPVjTOhrFp6nvae7h31l1V44BTB4CLM6+jE42cZ3pJSRC2ilu/yl1PzSYLRIAc=
X-Gm-Gg: ASbGncsP0KJEIvgvqQBoUrA36djXEwIy94F/QfQ2kdLcjfLK9pB20GzzGbv7kt5KSG8
	WvU/YFF6pcMtsarJu0YE8LTHeKwJmX79UPiyiZQAq0ildYp6Yfv3IJmGpJUzMlB9wl3MZC5/W2k
	i7NK3ekW08TNabGmtgUQd9vtVA+Sp7Vd9StQnLTjQvzpgPB25fgRNTIMCNpIDsiw75k/4tu3V5e
	7iZ6MzwiVgpbglhyXkDEcL46CLQTFPgPdz+9Xb8y2Poj+R0CznWhkfbhQxOdEjlDbJJW4yhb/wq
	nQxCVXpNICa+87G2Yg==
X-Google-Smtp-Source: AGHT+IG+GWLav9UJfqyQ68A1jcf3lhjRtJkvLA7MYkbHl336IPSn8Kmidgk/a94noG0INXD1mHf3Mw==
X-Received: by 2002:a17:902:ea0d:b0:21d:dae6:d956 with SMTP id d9443c01a7336-21f4e6e1eb8mr44938405ad.24.1738924994072;
        Fri, 07 Feb 2025 02:43:14 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3653c997sm27289215ad.78.2025.02.07.02.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 02:43:13 -0800 (PST)
Date: Fri, 7 Feb 2025 16:13:11 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Stephen Boyd <sboyd@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Danilo Krummrich <dakr@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Michael Turquette <mturquette@baylibre.com>,
	linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Nishanth Menon <nm@ti.com>, rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Erik Schilling <erik.schilling@linaro.org>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH V8 06/14] rust: Add bare minimal bindings for clk
 framework
Message-ID: <20250207104311.g2lexa75o26z6aox@vireshk-i7>
References: <cover.1738832118.git.viresh.kumar@linaro.org>
 <c68081e18d939aefc7f6dac798df6b72e81bba4b.1738832118.git.viresh.kumar@linaro.org>
 <Z6ShsuLykigNscz8@pollux>
 <Z6SiiRubSXGInbgj@pollux>
 <0cd42d2d683ea057e6034978b02c7f84.sboyd@kernel.org>
 <Z6VBo51g54xAmelQ@cassiopeiae>
 <20250207092448.n5mzbt6lg6zqud4a@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207092448.n5mzbt6lg6zqud4a@vireshk-i7>

On 07-02-25, 14:54, Viresh Kumar wrote:
> On 07-02-25, 00:11, Danilo Krummrich wrote:
> > Guess this should be Opaque<bindings::clk>.
> 
> So it should be this now ?

Also, I should be using ARef and AlwaysRefCounted along with that ? I
am not sure if I can use those with the clk API. Yes, it is refcounted
but there is no direct way of incrementing the refcount unlike other
frameworks. clk_get() accepts a dev pointer and a char pointer,
whereas clk_put() accepts the clk pointer itself.

-- 
viresh

