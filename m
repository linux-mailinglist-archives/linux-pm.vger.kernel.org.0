Return-Path: <linux-pm+bounces-27390-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB18ABCE3B
	for <lists+linux-pm@lfdr.de>; Tue, 20 May 2025 06:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5C028A1619
	for <lists+linux-pm@lfdr.de>; Tue, 20 May 2025 04:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD233258CE1;
	Tue, 20 May 2025 04:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DTEtPKVx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBA82550B7
	for <linux-pm@vger.kernel.org>; Tue, 20 May 2025 04:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747715640; cv=none; b=Yqdb+Pic7IeQb57+dXJPVOpuyywwS0fJgji8LzBSOBOGCpDv4naM0cXtspqQ6CyOmWK1SbPJmJX1A0OIvrFYs3UzSL4PCNSCEOOezHjfsh9eosRnXIGrzpFD52AWPYZlyx30lvtAUVlkGXCHiKg0/bD3M9rLmGNjon4x7GQ3XfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747715640; c=relaxed/simple;
	bh=TM7YWc2HanxUC5uSa/mx8mHwCfO/Qpz2hocXunXzOnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AceYfpA3k1GG7pnAL7DoAxmLV3Ty3u8tupdpFIs48PuCc9+qSPlPIjgIDCqLmnRCsbtu6zGPpiVLzLu5d0dzjZQhlZiAwU+1h64O3GsEV4zeLBqtauN/SYuP0mnzznn4YHsje1s27SHbQPfTpsHEw6l0fc4uuUSQ2h1YQW+QWM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DTEtPKVx; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3081f72c271so4505690a91.0
        for <linux-pm@vger.kernel.org>; Mon, 19 May 2025 21:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747715638; x=1748320438; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vmXtbFG7YZNNbJEDh1fYDcGa0WLHVZ/52LrX9t09NXg=;
        b=DTEtPKVxPh29thGGyvRwymyu6QWa5HrLLK1TOwWteGJkisDMVF5VfmI9KQDARigvz6
         9eeSDnSsK6REQDVEmaeBX/v2tqPUAKIrEwogrzS4cLIF1kfJaRSyZWRy4GCQbT1uMLIy
         /DzvcOhOzF9KeGmt8fPXmATyQUT5D8htprY8ePsYCksh7rsWjvzaSV/5tzPRL+f8PUki
         NxPoDEPc1rhdESWvJDeFvd/tQZ5vnqhrgR3D01vuP2nkzW9lX3KCqyosAWy//aCqtaIv
         Z2mHGXpbzi8NFMHDX4F+583rdVhQ7C2RjRG3BsOEAVw4CtNTPo/D/+Kqt1zGRsFLZQoB
         bLIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747715638; x=1748320438;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vmXtbFG7YZNNbJEDh1fYDcGa0WLHVZ/52LrX9t09NXg=;
        b=DnLuY5fo4n0dAmkhdtkMC/wPGbuplJmUIwy4ZTFnNDB5eCCONQe4QzBCuwJUOOcNyZ
         TO+dr+7V/HDuphcd8e0RAOu4UdUnYCiMD0lpc9zzRjSjSehHLovVjVoOlcOeJBM7kVOS
         V4DD2t4kryE8fy255Xbi+b2XY+/8tPTuHg2IwmX9tEa+2DRmW/M4pTm7DlA7rMJsqLw5
         psgmUs9JiX93T9PVdx5+unktzTqjPWoC7E5E2MyJwsoOPmzAsb9G+ftPSXqANd3RyfzW
         zEDv9Uw2ORhrwHbF8bo4LWT6VPD8Tc9uWcv5Mpo5jDsFmHkDm3+/8xz0UPe/I3Ki2UWJ
         AG3w==
X-Forwarded-Encrypted: i=1; AJvYcCXeu4L5jKPSIMPSZh+pb4S7mKYgHyPjHSnW/txOb/n35SVASi4I+4olGj5EX7zGG0w3jSC+5x1ITA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxUhHqROb7NvfAkFS+OVsIIscqyXYSoG6xYvddYNuFH0DSBY8S/
	MfZ0T29djQigRuT5YITFL4O2l11BmrPI0m2GJERioIfGZJilggBj1SaQeco2TwKRNNY=
X-Gm-Gg: ASbGncuscjOml4BNHIfEE74VhM0Y7KmkUJ5yfuWajSqO070kn6QtM6yAPhywRyvDBIZ
	newaFXnFIpqqeQ6/vUP6wLs+SpT3n82gAH7DkaQl0rSYg1N7tNvNlEW2rWoruuxqC/JcbD/Q2Wx
	X/JiQCEmR9nJ+3KopJ7HIEAQodx/ZeKww9F6aF5Jtv8ElkPDiCTm0c+DmuGysQqqYsmG644dnf6
	IRwMyTqpf0+R9GP8ti+FZ8JDva82dOYy1OniAG92TIFXggCwkciltrEdb/nFMcbM67NvB6DYWMq
	UHPysJbGPoUymcyfhTfoB1z0RibrCmZNokuL5CwHQs6Kc2dvWAew
X-Google-Smtp-Source: AGHT+IEv6gz69p3L0tnkjs4WbboIMeCV0Y6PseXGe/lkFOQuL+7jOhnn31ID8Drzpd2DcrW3kToDNw==
X-Received: by 2002:a17:90b:1a91:b0:2ee:e113:815d with SMTP id 98e67ed59e1d1-30e830ebc99mr22665162a91.8.1747715638413;
        Mon, 19 May 2025 21:33:58 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30f36491611sm643232a91.26.2025.05.19.21.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 21:33:57 -0700 (PDT)
Date: Tue, 20 May 2025 10:03:55 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
	rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>,
	Yury Norov <yury.norov@gmail.com>, Burak Emir <bqe@google.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Russell King <linux@armlinux.org.uk>, linux-clk@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	Andrew Ballance <andrewjballance@gmail.com>,
	Anisse Astier <anisse@astier.eu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V12 06/15] rust: macros: enable use of hyphens in module
 names
Message-ID: <20250520043355.wjkrslnripaqj6mm@vireshk-i7>
References: <cover.1747634382.git.viresh.kumar@linaro.org>
 <21b4c30db60f22d56cc6386a18564705ad3a6f4a.1747634382.git.viresh.kumar@linaro.org>
 <CANiq72mNHYKXcDm6DiB=69W0w8pZ1KhqeARqqKBK_s01PPRsmQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72mNHYKXcDm6DiB=69W0w8pZ1KhqeARqqKBK_s01PPRsmQ@mail.gmail.com>

On 19-05-25, 16:15, Miguel Ojeda wrote:
> On Mon, May 19, 2025 at 9:08 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > +    /* Rust does not allow hyphens in identifiers, use underscore instead */
> 
> (In case you see this before you apply)
> 
> Nit: `//` for comments, also please end with a period.

Done.

-- 
viresh

