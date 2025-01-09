Return-Path: <linux-pm+bounces-20129-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 070CEA06C82
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jan 2025 04:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8FBB3A52AE
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jan 2025 03:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB1F156220;
	Thu,  9 Jan 2025 03:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NkhmzSDu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F1013C9C4
	for <linux-pm@vger.kernel.org>; Thu,  9 Jan 2025 03:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736394637; cv=none; b=LYpxnjXCN9JycRjTD6SJcjaLgP6+eNDhIiCNTTSSMYWileSR0KMGQ5meneXt6qh7/C2tuJaZ8vn7Fbmeakh30fRIJsq5LCwQbTkw8HFlD4Z7VrmXj1qhWFYOzosExtNmDzinhvDZI0kPakSHsehpKryZaSNVMdUColKfE8gpb+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736394637; c=relaxed/simple;
	bh=ez5+UAxbA53MuMo50mcpaq5hIivDZMNRwQWvFinRh9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fb6g5+1H5ul0ozrB0A/dV+kESS4fP3USz/x/U8nRS2/EsxRjg9cZwXV0AzNgY9ES4WKh9UeOcPmbtICBK6ZPVv7oW2UXWueXfp36jiSLUorWpcaEnz4jAcandbYOKzlEhVN/1kcdw+R34YwDvxlWqK4vPwQ1gZqgyZ8M3CjcWxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NkhmzSDu; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21649a7bcdcso6310605ad.1
        for <linux-pm@vger.kernel.org>; Wed, 08 Jan 2025 19:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736394634; x=1736999434; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lpgdpXTdEHzIeEtbhcBqaQ8chJjfy4KYtlOr7JwHaew=;
        b=NkhmzSDuUv4brB0EaW9Upg1QaaN1iNFIGpFIyFzzwjFsRoY09OALe9ahuqeWB3hBwL
         g8TKiaZyzo15Vp8T1GWL9F7YgOe7O3v6bDh6VDU4UBPFYpM6h3D/c18xkhcWlmQ4HkvM
         w3MGlQnq0clYAk/Q6aiNeOC++8mk5pSWRP9ygBMZREGdWb4gJhyhLtHFboZDEM5fV6ss
         krbTLqazWzRbVgA3aVTVUNaZ+6xia59dX73ArjoH90vBDvfHHrUZ5+11OaYPUcu2c2Gb
         +Bwh3DespKIQwMLkcpV3CE/i1A9I9MEUroRYXtwO4TqCgWO5lR6ifev8dETK6HQNEBAA
         BTTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736394634; x=1736999434;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lpgdpXTdEHzIeEtbhcBqaQ8chJjfy4KYtlOr7JwHaew=;
        b=iKQ5R48lnOh//pFwFcaumNUXGxRxIOVEez0zfqkkYFXq5oqpyPKjX9EtWw6TH1DJOJ
         8IcopZrMROCyCMM+3DdY/WalCqVHJJH7kKRWwYc850diplvN8xVQoUWntI2QZQlFGIEO
         K2v902nSZda0osG4YqRQMPi/YZ7c+36Mw47AGd3ZcQ8mpEazzYNwP2QcXnRxkMH7MMH8
         wjOcHRNQViDZCOdyMQ09eyl5B9QhkSNPu+M2hmoEYA+l0wErc5chDQA23HIexkqbRTkp
         Y8kyPEOybNG29BYm/HCSAkGCEr64dpsRFd/7w8XzNphcH//LL0HkdMC9YDibcb7Ls6oz
         0VeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUW/uq6tsKUptAXH20XPFflBQxQpRveQ8wEqtKR/YhJbHbaZFlpSYPzGWQcGpIcmDX3T3naVefR8g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwXyqyFn7jtva/0/Vqyc3u1f2LMAh/H0Vc0rgS9g1L++u247Iqn
	XSzzL2YIxsZQpo6OrclXUppWIf3nMhgzb6vcrw0ViNfhqqsQccFpbpmyxXL33QE=
X-Gm-Gg: ASbGncv8O/C7fsE/DsnAUY0buVY+k9yaOvQVFOk0KLTWQeTiWGS3S5rv4+T6qcSCN2E
	qXCAKFshUjKXWEErvpi2SjGBcoFW1vgvbH0d0VejvTJtRpCuY1VyYHJUG7ud9lmihVNXZp4FcpY
	y4zV76fkz8Mn2tLowZKTa9+VxvGFZr4gNxOtiQp02HX9XfR/ggZCdnkhaV4r1Y1QvXEOG9YWE+g
	i/3nHIPzJ4hZtV8aY6CLbYsW8saxTB6zX1iKeA3WZu84dHSFOD35aCdoQ8=
X-Google-Smtp-Source: AGHT+IFsHNdvQ1YeOjX/2zKq7r/5QBL2omM/xruCsyRaGOKjnVTYaIW2nrcHidJ2mDZ5vPOZXPqpUw==
X-Received: by 2002:a05:6a00:1255:b0:71e:6c3f:2fb6 with SMTP id d2e1a72fcca58-72d21f4b05emr8649752b3a.8.1736394632952;
        Wed, 08 Jan 2025 19:50:32 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a317a07d050sm265068a12.15.2025.01.08.19.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 19:50:32 -0800 (PST)
Date: Thu, 9 Jan 2025 09:20:29 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@redhat.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Benno Lossin <benno.lossin@proton.me>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Miguel Ojeda <ojeda@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>, Trevor Gross <tmgross@umich.edu>,
	Viresh Kumar <vireshk@kernel.org>, linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Erik Schilling <erik.schilling@linaro.org>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V6 00/15] Rust bindings for cpufreq and OPP core + sample
 driver
Message-ID: <20250109035029.3kr6ynlsfzslrong@vireshk-i7>
References: <cover.1736248242.git.viresh.kumar@linaro.org>
 <Z30UZwgN2nGtiTsK@pollux>
 <20250108052008.izm5ffzgrc45ms4x@vireshk-i7>
 <CANiq72krWF5a8cDJfwj4FxW7aJ2N5FD6zinFALsNAni3tmkcHg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72krWF5a8cDJfwj4FxW7aJ2N5FD6zinFALsNAni3tmkcHg@mail.gmail.com>

On 08-01-25, 16:03, Miguel Ojeda wrote:
> On Wed, Jan 8, 2025 at 6:20 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 07-01-25, 12:47, Danilo Krummrich wrote:
> > > On Tue, Jan 07, 2025 at 04:51:33PM +0530, Viresh Kumar wrote:
> > > > I would like to get some of this (if not all) merged now into the rust/dev
> > >
> > > You mean rust-dev or staging/dev?
> >
> > Right.
> 
> I think something was missing there :) i.e. which one?

/facepalm

https://github.com/Rust-for-Linux/linux staging/dev

> In any case, for upstreaming eventually, then this should ideally go
> through the relevant maintainers. So I guess that means yourself in a
> few cases here.

Ahh, I thought they are all getting merged via the Rust tree. Sure I can take
them in once I manage to get Acks from you guys.

Thanks.

-- 
viresh

