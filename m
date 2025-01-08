Return-Path: <linux-pm+bounces-20103-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C965A05F8E
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2025 16:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AA483A6E19
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2025 15:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5F31FCF78;
	Wed,  8 Jan 2025 15:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PEEWWTyd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E7E249EB;
	Wed,  8 Jan 2025 15:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736348618; cv=none; b=KRcs6+ls8ZBSHIvwNJWYnnD9Vv3Qcy7kPQHhlC71/vnRAdi8q9ZnriF5PcsK3nEQhMzbh1oy88gOw5kORPZzC5/bUtI1mOXne8EZUxquMeaCz+HL18eXAUimY7rTAnK6gQePB1dT7rscMp5e7rI43+aKBe4ucTQmbWVzjJJ5yjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736348618; c=relaxed/simple;
	bh=V+V10C6TNTlfHp+XgMUYSysNZdYug01Lm4mCNiFyP3Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JnwlAgTUelIaGA1LMH3klq6QdiceexT06OCmmupCEkWE5Rv4oSxEa5aQVRpfHBV99twDJbCom5dWnin2I/Mt5zcZXO5J+jxEU+C7H3a0Y/QKiC/9pp9Z9Izy1GcXEArMXLj0g7UsuEIbAJlfybKJxM85DwHAmcxVP6bCKwmWSUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PEEWWTyd; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ef6ee55225so3426466a91.0;
        Wed, 08 Jan 2025 07:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736348616; x=1736953416; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V+V10C6TNTlfHp+XgMUYSysNZdYug01Lm4mCNiFyP3Q=;
        b=PEEWWTyd0zYg/jMHC7/7jyBIzr5qM/IXeuV7oe7xGsLZY/q/1d3Pa2UkOyloSR7alM
         Bc5xyFviCWdpZDu6Bz7FtVhtV9qxa6iztr9spuN57iqpTUpAn5TynsXvcFlb54o1veFt
         iZrIM3vY80iIfEancwZvH43d66Ooc0BXm9tnyjL2VzP/arc8VcUtipreyi6oEn95k7Ff
         eOEMOI3o3199ZpIP+haDllA3L46+fa3pytd/dR86E+oqPw/p55jCtzGr7rMkgeR5fntp
         BSoaSNRa4aUZxKnuNMh2yTjwAQnl6Nxc2pImselhEqjf4+YMMYH9uq/Puz3g/FpbQ/wY
         ALYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736348616; x=1736953416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V+V10C6TNTlfHp+XgMUYSysNZdYug01Lm4mCNiFyP3Q=;
        b=JtzC1LYoPbAuKVGVVueqO4y+Xagzak0x98SPojZyB3tdOdxNlOO4wiOq5rQ9tBcVA5
         asp4Pf7OkLXkW4SDxqstDr2mHXUVPc/Rpeu9LNA4KbzUGady7auI+adKCvJpCg6ARBrZ
         FLczUIBI/0GPebg5yKx96R0hZ6VCOAHJ+GiR3F4neYbHvayM3MHSYhX9deDE+nGDx7LU
         tkrJUeFadhQ7GUMOGx95LjspvEKZf4sLZ5xuYf+ZfajEfGOVsqItjMbQc2K+XxC0YojN
         sBgjLvJj0+1K1nvPBDwLUWdZ/R1kXgbIf1z4WUSlwqKdMdNcQc045vw82ESAlkYNnYlw
         MPjQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0NJ3B9fWPTLCMFetF7tr6IId33MDs1oQy2QCJlmYarx3EVGtqPHdfAdHCTO7XmxphupADlD/mmZk=@vger.kernel.org, AJvYcCXdUCh6XDJuoa7q2wlCo39gKpD3I3SLL84YD8pckXo6HGK1mBAQTZpJNVOjyOh4PnQxGwS74NWptO66p4i7K7o=@vger.kernel.org, AJvYcCXlz8zSKVnL9BMJDg3kvji6GMI1m+PpPWkRkuzhQ12h1mKebtJXl/u3rpUO7FTI/hpKqTvZesQjV9GAzgM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCOA1R0N+L2dzODoBO/F7A/18xHAMtJLtLpDCDdtZ0TKUebDHx
	P5Xi8uc1MdpJFvWGq+z58pFBbz0Pxu6nXWi2TVcWOMwVO9cz5ArOCxpwPOc5PUwQHDfzssIA2uL
	tAA/RZZnGIDLJZ0hhyK8EoLemh0I=
X-Gm-Gg: ASbGncss+95gcz7sB6Nf9jtcAA8+A5kuB+3r9ayQEUTnj3yjHi/IXZWM1uy52wCNCr3
	fCkhZuce189t0/zaH/CPBO99WrCejgNVC4g7KAw==
X-Google-Smtp-Source: AGHT+IF96KiqDIn74dipZbvGLqyC21IfBudz8WRCNLcC2xx4dR74qcyelHPMw74UlfbdPltC3F+BbkZjsxocXQHow1o=
X-Received: by 2002:a17:90b:2e03:b0:2ee:e518:c1d4 with SMTP id
 98e67ed59e1d1-2f548f1a2cemr1757751a91.1.1736348616426; Wed, 08 Jan 2025
 07:03:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1736248242.git.viresh.kumar@linaro.org> <Z30UZwgN2nGtiTsK@pollux>
 <20250108052008.izm5ffzgrc45ms4x@vireshk-i7>
In-Reply-To: <20250108052008.izm5ffzgrc45ms4x@vireshk-i7>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 8 Jan 2025 16:03:24 +0100
X-Gm-Features: AbW1kvbuaTv6mSzjHK48ZJNcny_Wwi-p5dYp54LwkFVvT-3a9rtWKTNPS1GmB7Y
Message-ID: <CANiq72krWF5a8cDJfwj4FxW7aJ2N5FD6zinFALsNAni3tmkcHg@mail.gmail.com>
Subject: Re: [PATCH V6 00/15] Rust bindings for cpufreq and OPP core + sample driver
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Danilo Krummrich <dakr@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@redhat.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Alice Ryhl <aliceryhl@google.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Benno Lossin <benno.lossin@proton.me>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Viresh Kumar <vireshk@kernel.org>, linux-pm@vger.kernel.org, 
	Vincent Guittot <vincent.guittot@linaro.org>, rust-for-linux@vger.kernel.org, 
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, Erik Schilling <erik.schilling@linaro.org>, 
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 8, 2025 at 6:20=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.or=
g> wrote:
>
> On 07-01-25, 12:47, Danilo Krummrich wrote:
> > On Tue, Jan 07, 2025 at 04:51:33PM +0530, Viresh Kumar wrote:
> > > I would like to get some of this (if not all) merged now into the rus=
t/dev
> >
> > You mean rust-dev or staging/dev?
>
> Right.

I think something was missing there :) i.e. which one?

In any case, for upstreaming eventually, then this should ideally go
through the relevant maintainers. So I guess that means yourself in a
few cases here.

Cheers,
Miguel

