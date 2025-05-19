Return-Path: <linux-pm+bounces-27349-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72361ABC05C
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 16:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91BDE189F9F3
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 14:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E823283C8D;
	Mon, 19 May 2025 14:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jrt7RWpH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246631A83F8;
	Mon, 19 May 2025 14:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747664143; cv=none; b=jhwZ+6CFq4k97yrBwGfnaNZFu9BSjoUBPkGh3TQBYdQmJLwkuxyviNZKYDmqbdXqknwo7jGgkxbiQRbBpmkJi1R6famfRvjHAYuoBdAMxTqEj1FkRBbCLPKiU5nWiSbXzaxQlOQDiQw+/w3op8sH8XrjKGGTA0oCU6+5AMwR2PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747664143; c=relaxed/simple;
	bh=LBz7CbTok9hiT/Rd4gD+6R6Afb6EOxFXMSfsbOL4IRU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dqoPXo0mQF9qzQK6W3Z3w0WvDt7KQOnDz4jEU5tYjRvTgDS+2raKen54XDqJoKcA9UEi2XlPd9ao2k57+gIk/5ZixJqIQyIGj7uNEfzuilJ2CWlTS+JWHX7Vbjvz0fHIlBzRiKqIocxWB/RFteMFemkRVy99EJsssYZhh2GU5IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jrt7RWpH; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22e17b7173bso2295715ad.3;
        Mon, 19 May 2025 07:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747664141; x=1748268941; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JFWLr6OI5wVVnuVWXpsQry3bxwa2eh/RNHdZAeSrn9E=;
        b=jrt7RWpHtthPTXQ3CzVTiGI7DyDQ8ze3MSA6+8u3Bek/dP84X6ii8IItJyuS+qMD5x
         dxRAOCj3mVUQQDWujd6bVUJrnJUSgLSwDrq5iAjBsa71Bs9FgmjfDpsWHlfeVSYGwYdj
         1aKIWemP1rrMFhn3x7PbDtwVCnnIwgWfP2wjFGPAv8iR9dwxKsGcSH7fvmTAPicovD6q
         YQ18xI6EBql0YjuRrn97hnPgkxmkTD9yZ11+g52iDszP9Cjfnbd2d+p9q9IZH2d4FhVP
         bP5UkzrsGVSKQ5vSB5JQvt4oKeEU5FgwONzFepaMXxzA1YtV8S/oVstRy8VekXpSLYze
         ePww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747664141; x=1748268941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JFWLr6OI5wVVnuVWXpsQry3bxwa2eh/RNHdZAeSrn9E=;
        b=nkouM/Q1hC4IeXbfBsJxjpMyIzWVY9bba/TNQj4GtCQlN2Zfsy2CCpUce9OjAwE3qn
         IdylnGAQv7NRi4roPtql9y0wifGk48gf5kjPhWtLJLvsCIe6ZrjeVctTfTd1o/DTB5EZ
         8tTE55hFYsgME4ZrxdtOq89eUXg82ouQvAH4hLEWNGPaMhqb1yqdcZ/WhUf0VPvHz8wc
         X1vHXEROc2y5s1CQYZHwGhdttFRz63L98yPp9Hkp4fok6nHk8f1jikO8fqpP7P/sYcIM
         8XjscpFMnwTsbsEMMGM4Kw2tfDcRQza+Be6tMAPG0OdynYpZqP0WxRX7NZRcOh1WDTEA
         y2AA==
X-Forwarded-Encrypted: i=1; AJvYcCU+6N06doPk/OZEkWNKdVQ4avfa3EHtxzggPDnXqME3NU5xpCEPk49hvj9eFWV0PjU0P1wHw6G6OOOurZDyOlQ=@vger.kernel.org, AJvYcCVCH67AZgW7MtqWYrky2ywOcAk1m4ZtnGwDgRyfCHiGbiUc1gNDcEhkDc3MJWBpDHET24bVBBGTyok=@vger.kernel.org, AJvYcCVYZOhLO6iCEDZq8/4HBlgYOzvCO9X3mXopeoW55zaC0xWeWoWz9NcOYejrBXOxwGHF8s2Sj9uI++0=@vger.kernel.org, AJvYcCWlvu7c2XM+oUtyXJ5DA81F/hW6u3ZlWfJvw+p7v+dHjqzMuhF7JE37J8B05ha4kg8GPk2vS4aLECZCFY8w@vger.kernel.org
X-Gm-Message-State: AOJu0YylrHS5HieXMc+N3nlm74Cf5D0ganffYnNlZgRHFriguSEcF/Xg
	R/KmkVPQ7hWkf/nxbRho/DVCpKBG5Saw1mT6GhI7rPNHF8vTsISHB/mNd2+x1DPXimYBvA51Tke
	EgDNKOEyWf8KRcDfsiZVVeuLSH8NNYZM=
X-Gm-Gg: ASbGncs1rBO3nlywNkZQMXXLakBMO6e1OvGf7Jq3qdJXQnIIcHQnK9kqjqyjgzNV9Xk
	jZKk61+PRD1rjzQebEZtsTTyRxQxcU8pVxEN+6nUITnmVe2RIzs32Tfc4bWqNuJOVqeooHRFDFy
	LQL2h1jlWU8XIXYgl4k2N0S8B00KeFvRbs
X-Google-Smtp-Source: AGHT+IEYa3sccvA8xQ5p1zCSL1p/yZXI4bGMmkiDApxIBC1xjOK5CDTHXaWyMmXLa8VfSf8paFTObwZ3GjovVzMUVuw=
X-Received: by 2002:a17:902:f543:b0:212:48f0:5b6f with SMTP id
 d9443c01a7336-231d45262a6mr65988125ad.9.1747664141111; Mon, 19 May 2025
 07:15:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1747634382.git.viresh.kumar@linaro.org> <21b4c30db60f22d56cc6386a18564705ad3a6f4a.1747634382.git.viresh.kumar@linaro.org>
In-Reply-To: <21b4c30db60f22d56cc6386a18564705ad3a6f4a.1747634382.git.viresh.kumar@linaro.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 19 May 2025 16:15:28 +0200
X-Gm-Features: AX0GCFtC-8NcfIsvsg4cU78ogkZiXh9AmQGXjdzvJiPpuVhnrDGer3E08jYPZ1U
Message-ID: <CANiq72mNHYKXcDm6DiB=69W0w8pZ1KhqeARqqKBK_s01PPRsmQ@mail.gmail.com>
Subject: Re: [PATCH V12 06/15] rust: macros: enable use of hyphens in module names
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@redhat.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-pm@vger.kernel.org, 
	Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@kernel.org>, 
	Nishanth Menon <nm@ti.com>, rust-for-linux@vger.kernel.org, 
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>, 
	Yury Norov <yury.norov@gmail.com>, Burak Emir <bqe@google.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Russell King <linux@armlinux.org.uk>, 
	linux-clk@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>, 
	Andrew Ballance <andrewjballance@gmail.com>, Anisse Astier <anisse@astier.eu>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 19, 2025 at 9:08=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> +    /* Rust does not allow hyphens in identifiers, use underscore instea=
d */

(In case you see this before you apply)

Nit: `//` for comments, also please end with a period.

Cheers,
Miguel

