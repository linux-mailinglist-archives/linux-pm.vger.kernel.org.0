Return-Path: <linux-pm+bounces-26547-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B1FAA6B2A
	for <lists+linux-pm@lfdr.de>; Fri,  2 May 2025 09:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A0AE1BA5A20
	for <lists+linux-pm@lfdr.de>; Fri,  2 May 2025 07:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2ED2676E6;
	Fri,  2 May 2025 07:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mtc55u2V"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB63EC4
	for <linux-pm@vger.kernel.org>; Fri,  2 May 2025 07:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746169274; cv=none; b=OZZPjxljvr+IG3isduaotoojGhFuOvsWHuJHY/0YfX62+H0eonLc+NTUAI9EV9izI/E05NIVLAMfghLUecJ3rCNggC6NyDn3C5aWunVZlBQnGRR/Le9I3fMiO2w/So/Nly7zleUwjaS7XPeb8AJfbi+jntq3TjtTxig0zHNKzVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746169274; c=relaxed/simple;
	bh=PNbWGAMKm9s3NrC346LUCC25A0/fVZrSTFIV1+54+pI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J0+jC+ywgy4mVTYW0vBxSgLmdfG3mGw6eR8UplEYHRPrWQPf+eahgYidj14ZktnHPWujCHYW2ZnFFADE2phNltBDH5HgIWsWPWkHMhpUMQTkBSjNp5C6LlBzioEqBkbyL6auLvMLtwLoSq0Nu5hbgP52Fv/509ATqMXfn46iIzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mtc55u2V; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-73bb647eb23so1677601b3a.0
        for <linux-pm@vger.kernel.org>; Fri, 02 May 2025 00:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746169272; x=1746774072; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sIYKB9F3o478Jme8raTXTfUkifL4J9sNzNUm7274ITk=;
        b=mtc55u2VznFCXMNRTV4Zu01W8hFrh2CE2zmsfKK2qj5WoZbR7GchyDKsEeodQCMyXb
         hkU9f591btkRXO0oooukUntSuaxpPXFngZ5iu4KgD7247e0v8JRymyEfn6gMio7FqDL+
         S9ose1UQNILS2DRqQkhoOD0cHOF+pIkQ6n6TOnGd0FGIAh9A/IpFPI1goYs6JW+S5sGJ
         mbYzO4mmFMcD3kQCf7oTnZKfxu5s1wtUC7xZbxxEswRqI9i2mn+ayFGmXvDRSnQqt0BJ
         l9C0XdatadJKLOkrG077ueXz27Cduq0PpEBCYv2Llw/jM/HqK6FeIHhal9BbXx2SLD+3
         kvfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746169272; x=1746774072;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sIYKB9F3o478Jme8raTXTfUkifL4J9sNzNUm7274ITk=;
        b=kBBS1Cw954J08VDJGI7Msobjr4WuQb7FMryk0q1mbuO5NKD35UNX1kGYyNcembu10d
         O7uwUGX8FyhYzAMaTrMJEkUjIMqLTJYaB//4X/rRLx9hBjDdoPhnphHu98xXiUppj9NE
         f5VSv66+55aBKEVEEAxhXWTB1hJFD9405F1wrk9VuZHlSdx1o0qpZBNCR9D30eHquSV3
         D6rcrbZDBixqRWCnJl+V9AhrzAj8NwHdSB9/BNQJKpZs1PaKjKUercqIfC2qgUCktrxF
         fK0LmHvxtbPfO+7lDwN9atDCIV6qBbyMTarHIq4c+g92N6Zn5in2l9ovmZ87Vv70xPBw
         fUVg==
X-Gm-Message-State: AOJu0Yw5VTddipnTMY+V6LqDgqnr9Myi3ybryFKASAU0HqTaUTTsIEot
	AaJ3IxLDyKUDnfoTkbZwC9+7TsC3d5J8yEQM+etTxnwofxYpdz0wr4zV8YpAnwo=
X-Gm-Gg: ASbGncunEYH32wAcai/Zz4LEJXCnSloVqQzTbxksoXn5RCIIZBDR636mZwmaFFmJdaQ
	mnzCu+PbAip5xjUIWEtTlJAJyDwqaouNYwZ4RAHZ0RNWZMRh75SxpdK2Jx7tpLYtYAnLhKzNbaH
	/DV/83RCtUy29W7oxRarLkD34sZfTDQKUKe5LOp/wY8OdrvyH5BFB6Dgouh6YiWLeojZy842VNX
	KRrxPXPBcdTbYC1Qao3NhXCRPPL91abjY1gxazlvsC1a956wZH5OJLIz0QvUhWdxfPzVfZg2Et+
	gp/7vuZeV6USWEDkW91DOIZlURD6UD0Pk60UI2Ppkg==
X-Google-Smtp-Source: AGHT+IFSx+VRtOySROI7ANgNGVBaqHJbD9bAJPiju2pU+HGgAlpdoEmLB1WKijWr1JimZfsA5Unkjw==
X-Received: by 2002:a05:6a20:3d90:b0:20a:53e7:4a44 with SMTP id adf61e73a8af0-20cdec4b676mr2533309637.19.1746169271726;
        Fri, 02 May 2025 00:01:11 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b1fb3c6a59bsm49529a12.67.2025.05.02.00.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 00:01:11 -0700 (PDT)
Date: Fri, 2 May 2025 12:31:09 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Danilo Krummrich <dakr@redhat.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Benno Lossin <benno.lossin@proton.me>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Danilo Krummrich <dakr@kernel.org>, Gary Guo <gary@garyguo.net>,
	Michael Turquette <mturquette@baylibre.com>,
	Miguel Ojeda <ojeda@kernel.org>, Nishanth Menon <nm@ti.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Trevor Gross <tmgross@umich.edu>, Viresh Kumar <vireshk@kernel.org>,
	Yury Norov <yury.norov@gmail.com>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>,
	rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>,
	Burak Emir <bqe@google.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Russell King <linux@armlinux.org.uk>, linux-clk@vger.kernel.org,
	Anisse Astier <anisse@astier.eu>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V11 00/15] Rust abstractions for clk, cpumask, cpufreq,
 OPP
Message-ID: <20250502070109.inpes2ou3rxx2fxp@vireshk-i7>
References: <cover.1745218975.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1745218975.git.viresh.kumar@linaro.org>

On 21-04-25, 12:52, Viresh Kumar wrote:
> This series introduces initial Rust abstractions for a few subsystems: clk,
> cpumask, cpufreq and Operating Performance Points (OPP).
> 
> The abstractions cover most of the interfaces exposed by cpufreq and OPP
> subsystems. It also includes minimal abstractions for the clk and cpumask
> frameworks, which are required by the cpufreq / OPP abstractions.
> 
> Additionally, a sample `rcpufreq-dt` driver is included. This is a
> duplicate of the existing `cpufreq-dt` driver, which is a
> platform-agnostic, device-tree based cpufreq driver commonly used on ARM
> platforms.

Applied to the cpufreq tree few days back and is now included in
linux-next:

https://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git/log/?h=cpufreq/arm/linux-next

Will send it for v6.16-rc1 (unless there are any objections).

-- 
viresh

