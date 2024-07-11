Return-Path: <linux-pm+bounces-11002-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7DF792EC69
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2024 18:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DE131F24D9E
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2024 16:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89FF116C87F;
	Thu, 11 Jul 2024 16:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ifp+SIpK"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC8916C6B8
	for <linux-pm@vger.kernel.org>; Thu, 11 Jul 2024 16:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720714342; cv=none; b=OZwAeOuiUAH7s8+TSUBX9bn66HLWk/qg6uvMUK0yZqVpLwlCy8Nn/CMWn8ROv51se2VrWSQiOmxm4/ulPndlxcTSblZ6BmJtArWP2jGDTyQD+nFjrzvrJ7X0zSkKQjpv5dZRjkMa2prNs+4bbiH0i/5wpBkQkPikFr5YHfhjawA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720714342; c=relaxed/simple;
	bh=xSv/pAElyqabmJkJ/UvEKYZHt7PFzhtbXS0sLNGobLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gf1YuRObLda+/jvrA2HT4CLAecFLlQ/WUFoYFf90mdXx3j2r3zM3U8t0lEfDQUE3bWEkfN2VU1lI3MiBPosBfdRO7FaUX+bCGH844jnz6mmw0K3kifZk4Bz76yGT6t4qqqApdUE85m7G92P9knnCyx1IpQRN1IeH95Rx/lcpHXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ifp+SIpK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720714340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jGp0x2KyrISOhdhVBMxGIYQs/iAq5rAVU04UXibc0EE=;
	b=Ifp+SIpK0GYigO4WzeS76t81fS5pqjTNNj4yC0vchnieh7V7Bio+vNfkI2fj/KcSHWskKi
	BLO8HByMCAHRqq0ai6KT/n/kCSXZW9Pzyo0nQoS2Kz42DU09lYbu/uyF//9rN8gL3k7+BE
	KqIv3d1RUB12j1egqi9vMN0attgkQos=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-72Is6QBHNVGnfVs83Hrs5Q-1; Thu, 11 Jul 2024 12:12:12 -0400
X-MC-Unique: 72Is6QBHNVGnfVs83Hrs5Q-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-367991a0a64so513697f8f.1
        for <linux-pm@vger.kernel.org>; Thu, 11 Jul 2024 09:12:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720714332; x=1721319132;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jGp0x2KyrISOhdhVBMxGIYQs/iAq5rAVU04UXibc0EE=;
        b=Dn3ei88lsLzfsVXEpCjMX+aYVpZlBl9k6Pnsqd1xsn3PJvQYntxqhXyYnDBr9bnIP3
         Ka2l+CjCJrAymRpva/ZcPmzZ9/yAniFbW81PaIKFb716sZPwFfNth19b28GFhqQz9imU
         rhwYwKhAiFI6kMYimj75TSAiaX/j5U3pbfpEMqMVJ3LNpChnpTLBnIysjLkKVSv9vIxC
         vG2v2Jj6jKy4yZB1UXYERevMsusBnwnMeRIpsfZ2uxHYmhPgohfFnadb/RXHPSp/VXcN
         kESnmh3BZNKY6uO0b27klUHtsjTkctpgzSZWIfIyZVM1Zu5y1V/azp5qij2wIDsdLgB0
         CegQ==
X-Forwarded-Encrypted: i=1; AJvYcCVivAm4OLDhNyMHepUMzBP6UNvHNGTR38i4/bjEtr9VLqt6LT6m2Omno0J9DUHZjrA0CSejeqiaEwYX44hpuQpJkHyiOErKMhU=
X-Gm-Message-State: AOJu0Yyy+tqw1oDroofuSkFK+62KzHLCpJOCw4VRt3fNX++D1I2iwpDv
	D9KOUEHYCuWRjitKMapHwevS6Q2WQfCWDPhYMk3gSlxYNt1XYKX7ugQBrv//RNbUHHiE3FRxAtZ
	Yjf92eJ2M9k1YGozuzLKvL1OgMAO5kE1+kea2Elo74jq+/wNkmucaSckz
X-Received: by 2002:adf:cd8b:0:b0:367:99fd:d7b8 with SMTP id ffacd0b85a97d-367cea965a1mr5399169f8f.35.1720714331748;
        Thu, 11 Jul 2024 09:12:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEk9MfL1t+xrZwkJ0qJ3kx9NSKMMHVhwHWXaLexst1iGqnCx78rqRXhjzLmuuqO7RJ/+QTB1g==
X-Received: by 2002:adf:cd8b:0:b0:367:99fd:d7b8 with SMTP id ffacd0b85a97d-367cea965a1mr5399140f8f.35.1720714331381;
        Thu, 11 Jul 2024 09:12:11 -0700 (PDT)
Received: from pollux ([2a02:810d:4b3f:ee94:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde84907sm8138566f8f.43.2024.07.11.09.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 09:12:10 -0700 (PDT)
Date: Thu, 11 Jul 2024 18:12:08 +0200
From: Danilo Krummrich <dakr@redhat.com>
To: Greg KH <greg@kroah.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>, linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
	rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Erik Schilling <erik.schilling@linaro.org>,
	Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 8/8] cpufreq: Add Rust based cpufreq-dt driver
Message-ID: <ZpAEWAzETnrVI-cs@pollux>
References: <cover.1720680252.git.viresh.kumar@linaro.org>
 <b1601c1dbdf68a4b812fcfaf73f3b5dea67f2025.1720680252.git.viresh.kumar@linaro.org>
 <Zo-3QIPbhBsv8EjB@pollux>
 <20240711130802.vk7af6zd4um3b2cm@vireshk-i7>
 <Zo_cW57i_GMlmYV-@pollux>
 <2024071122-escargot-treadmill-6e9a@gregkh>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024071122-escargot-treadmill-6e9a@gregkh>

On Thu, Jul 11, 2024 at 04:37:50PM +0200, Greg KH wrote:
> On Thu, Jul 11, 2024 at 03:21:31PM +0200, Danilo Krummrich wrote:
> > (2) You require drivers to always implement a "dummy" struct platform_device,
> > there is platform_device_register_simple() for that purpose.
> 
> No, NEVER do that.  platform devices are only for real platform devices,
> do not abuse that interface any more than it already is.

I thought we're talking about cases like [1] or [2], but please correct me if
those are considered abusing the platform bus as well.

(Those drivers read the CPU OF nodes, instead of OF nodes that represent a
separate device.)

[1] https://elixir.bootlin.com/linux/latest/source/drivers/cpuidle/cpuidle-riscv-sbi.c#L586
[2] https://elixir.bootlin.com/linux/latest/source/drivers/cpuidle/cpuidle-psci.c#L441

> 
> > I think (2) is the preferred option.
> 
> No, not at all, sorry.
> 
> Use a real device, you have one somewhere that relates to this hardware,
> otherwise you aren't controlling anything and then you can use a virtual
> device.

Of course we should stick to a real device if there is one, I didn't meant to
say anything else.

But since it came up now, some virtual drivers still require a parent device.

For instance, in DRM we have vGEM [3] and vKMS [4], that use
platform_device_register_simple() for this purpose.

What should they use instead? I'm happy to fix things up if required.

[3] https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/vgem/vgem_drv.c
[4] https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/vkms/vkms_drv.c

> 
> Again, do NOT abuse the platform subsystem.  It's one reason I am loath
> to even want to allow rust bindings to it.

How is that related to Rust?

> 
> greg k-h
> 


