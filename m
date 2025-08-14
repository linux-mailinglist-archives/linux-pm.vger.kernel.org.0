Return-Path: <linux-pm+bounces-32384-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A35B25EC1
	for <lists+linux-pm@lfdr.de>; Thu, 14 Aug 2025 10:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E4C41C852F0
	for <lists+linux-pm@lfdr.de>; Thu, 14 Aug 2025 08:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774A22E92B0;
	Thu, 14 Aug 2025 08:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v1YV6rWN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5B02E7BBE
	for <linux-pm@vger.kernel.org>; Thu, 14 Aug 2025 08:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755159886; cv=none; b=MR0bITNfLfRGoSBxXDHxRP/2kJWKtaM7YFi35YXLhTtDdUzLQC+Ec4OaIcvSikz3Lhu8U2gNTE7FYTNXjbSOap6DFtX8dr39+88T9XAEJDrFN8zKqmwJzwas3FB6P1itWXHejfhLsBcXlWMtGS9IbFGndbpMKiXjm2ZJy7os91s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755159886; c=relaxed/simple;
	bh=01JJlSModoqysW+sRDKwyF6wO+ZTlR4O5R5WhdmWmU8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oyVYLvMzqpUYj9TDDxqLKBNiS9aG2zGZhn0PYw0fnQfR2kpDoMVQwqNfhtAB7g0qJBHpV3dZ7HBT7q4ThxCiddrEzbqz5AQTR4Scy+ZWlsqRn+bMk0PFLriKPF+CTuZlkcaemwufXN+I90DOj+ItgA66NV6WuILny/4hv7rqGJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v1YV6rWN; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45a1b04f817so2620565e9.1
        for <linux-pm@vger.kernel.org>; Thu, 14 Aug 2025 01:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755159882; x=1755764682; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XjZ/eR6SQYjR+SXWKMp+2N2e/5Kxjm09W05WAM7WjMU=;
        b=v1YV6rWNmU6fsaHjl4Aai9kCoub56MSu6ji+yAqRobOgvUtCVokLnu/7FVpgK43Ax5
         VVTst6wVaTIjTD/1Dw9t+CzUf3AyOwIg5515ucymvGnfx28L/uIOGSQRS5cwKUA4csna
         Jy2EP47cb/GBaEAA86liWMLeXlajFf2WBYhZSbbBj2Yk6GGyTyUxWoTjHI6gJC6DsLNb
         Qg1nd5QPetY17WeE4yUUEXKSXo3V5khlF2xGZmc1qjnUrc0ctrREG8Zi9/jhAbbuCgjt
         KSKKA7Knd9IQqfKV9AuX0icnKtdAKSnlQisnyVxIov4/yiM4Jxk3f/z9qp0CzY9kq15+
         IqXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755159882; x=1755764682;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XjZ/eR6SQYjR+SXWKMp+2N2e/5Kxjm09W05WAM7WjMU=;
        b=GXnAF9wTRMjmOt103cizw1b34ReST761vRv9sbBvMyaneS2FyTXF4xvv0Fo5u+FN6a
         hzAkbQ4Siry0b28kUCRpdOmZ3FczSnMl1dqecjBeee24Ztsx7jVYsLoy84uJNwOzQPhd
         P5fYECSzDh/qrrutiPf72IHeAZhaI6PkE/6+48P0AUs8JZPV5fwrW+tmuE/n0COqwkjk
         30MyUE0hvsHrW22j05cJ5YYepDBr4yVLrAzz9dYz/tOtm4Vnf71PScC4WFcOKmRjE8ng
         lgLVKk3uD2HgRullgBMqGj2z4HfGEtJKo1rpG5WPBRyjm2rKTBnfmlJvMo6icum9+arg
         3q7g==
X-Forwarded-Encrypted: i=1; AJvYcCXRe0SYk7M39luLSjQh8eK3z3nHZdo4y7w7WHFcvu5al8J+Pb6IsVl7q2W9Uk4hTZDHAqUYHDNiNg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzcoH//1/OoEa7ti5t97rIR6Pk3j07u5RtxlTNFMb5vnRk36ux3
	IxPzZlHlBQXNvAv7sJDqihxhRiDi0agr2ZgiBm1S5rGlP2ZFs2/Gl/k+4MS7RJsy/Ns6Y8rdhTT
	UgOJblYndiYZEsCYIfQ==
X-Google-Smtp-Source: AGHT+IEGivgrzos4CoGDHY7uH0CTjOvIWOyqPK2uMv3U+POUyDq1mhFpmt0OotkxsQj2w6KHcsTz1JVeOL0tM4c=
X-Received: from wmbjg12.prod.google.com ([2002:a05:600c:a00c:b0:458:a7ae:4acf])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:190a:b0:459:d6a6:792 with SMTP id 5b1f17b1804b1-45a1b67a1ddmr13345765e9.29.1755159881981;
 Thu, 14 Aug 2025 01:24:41 -0700 (PDT)
Date: Thu, 14 Aug 2025 08:24:41 +0000
In-Reply-To: <34d384af-6123-4602-bde0-85ca3d14fe09@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250813-core-cstr-cstrings-v2-0-00be80fc541b@gmail.com> <34d384af-6123-4602-bde0-85ca3d14fe09@sirena.org.uk>
Message-ID: <aJ2dST9C8QLUcftA@google.com>
Subject: Re: [PATCH v2 00/19] rust: replace `kernel::c_str!` with C-Strings
From: Alice Ryhl <aliceryhl@google.com>
To: Mark Brown <broonie@debian.org>
Cc: Tamir Duberstein <tamird@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Breno Leitao <leitao@debian.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
	Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	"Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=" <kwilczynski@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Alexandre Courbot <acourbot@nvidia.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Liam Girdwood <lgirdwood@gmail.com>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, nouveau@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, Aug 13, 2025 at 09:11:51PM +0100, Mark Brown wrote:
> On Wed, Aug 13, 2025 at 11:59:10AM -0400, Tamir Duberstein wrote:
> > This series depends on step 3[0] which depends on steps 2a[1] and 2b[2]
> > which both depend on step 1[3].
> > 
> > This series also has a minor merge conflict with a small change[4] that
> > was taken through driver-core-testing. This series is marked as
> > depending on that change; as such it contains the post-conflict patch.
> > 
> > Subsystem maintainers: I would appreciate your `Acked-by`s so that this
> > can be taken through Miguel's tree (where the previous series must go).
> 
> Something seems to have gone wrong with your posting, both my mail
> server and the mail archives stop at patch 15.  If it were just rate
> limiting or greylisting I'd have expected things to have sorted
> themselves out by now for one or the other.

Tamir mentioned to me that he ran into a daily limit on the number of
emails he could send.

Alice

