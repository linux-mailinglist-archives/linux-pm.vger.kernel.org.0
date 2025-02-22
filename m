Return-Path: <linux-pm+bounces-22740-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C25DA40C22
	for <lists+linux-pm@lfdr.de>; Sun, 23 Feb 2025 00:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CC17170816
	for <lists+linux-pm@lfdr.de>; Sat, 22 Feb 2025 23:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07F4198E76;
	Sat, 22 Feb 2025 23:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PJ0JYvrD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9182CCDB;
	Sat, 22 Feb 2025 23:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740267287; cv=none; b=ZWWIx2jPYvcq2P+7oQ8HzOThG/erNsdzOb7C0gKWabV2coB7d8feDfB5nXv9B4XIBHxlwq3KKosuDya3MzjMDsnq2MUY0sx85d4EEVQjlR4cZGgi3+D1QA5KpnUV1q07nsvzGd4ZuWtzrm0S+h3SXeCH/NF10bEU466sgV5XV50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740267287; c=relaxed/simple;
	bh=tU3r286zfMEzp509S4Nwj3oJKm1dT+refdlYwbG487A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EUwUNNBwqopGMGpW7m1Ck0xXq1SZ6SCi+kApeoh+49uD0UFqcshtcFgLXIhHY3FZDwbtGu3ExnZcMBMQUDzmK1ZDcLYuAfgf+NpsSJbfVMWi0zFAcpzB9E80ZelLoub1mI+gIcnmd5CGsGpCw8C/DIN+qCm8mgw/LvfuyOOrHTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PJ0JYvrD; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6fb3a611afdso27781647b3.0;
        Sat, 22 Feb 2025 15:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740267285; x=1740872085; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/2b+ymF1Y/6cEr1vN13eZ8XRTQyUDfjNMs7g+mlMvUo=;
        b=PJ0JYvrDMtayd5cj2X8RdD2q9bDoJnbxlR5f5gYsgYZv80WdqOIvb8MYx3t0C/G8S8
         6DOMkZz1jcdZ6BGWSi+GvWYS5QnSDLqw9yBusc8XxnC28oXSoupoatwYmMDcfwZuRkvC
         No2XDBHCgroAP3cy3SLqFVkvl6FE4gzVanDSnTct4YxZ3ixz4IapuTf/DONM7o/xDrJe
         oEsX/UDjcZRhoilZkbBtgixOQKKUuFyNPNrFcIyVII1PibrPcx4kfW2l1/W80TN/qAHc
         WEgx3ya8Akg2350xhj8AXvs536ZVvf5kPtg1/ZOYNwYiheisWVmDd/yvhdexcPvC0YJc
         qgaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740267285; x=1740872085;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/2b+ymF1Y/6cEr1vN13eZ8XRTQyUDfjNMs7g+mlMvUo=;
        b=q4IizJKroa0SSbnkTmcfEv2AohMOAzEj4CiX0hPMMv0q5yNT4hLUpNXOPROzNQdcDW
         WL7BjVrD3mOV4O0MOhJtCRyA6v9+pPUUa/A/yOh9muoo72MLYDBcATw2kBNpKhW6Vt/A
         mF2N1JkY9JrCp3eKSIqj7bFyr90PTROrOxKGVJlP5N/fLinEsxOzpOfTAWIYL74ZosVj
         HqZ4QJKGaZ1YZZIfh75mJ06l3SlXcmzK3MYtXdrV0G+vpeD1B1GzwvKmEANMvLL6lDAE
         +AeURuZ4zgEkOmiGQJE/QSCzUjwV8fS8/8O96OQWes4FoSDUyJ18h07t9MYbGOiIY9SV
         Lw7g==
X-Forwarded-Encrypted: i=1; AJvYcCVIQNTmT6lQHeO2nrzmIA3OA/jIDiB/YPKPH7IAdbJAQ/4fse/uevtFk5kNzwmZN2RqgC+4+mn/jII=@vger.kernel.org, AJvYcCVUuJ4L3mWc/YVXOwnygoE3oPEnklwMH1Xh+PqeA+jo/kVg5kobsgR7giSN+wlY+JhBa2CnmSejfDERFt4=@vger.kernel.org, AJvYcCVnzIJnyNvaHqjyQfiYYT/LohQBZAigApzHkim/ZL2xS4CtCKmp8xk1NimeiBgToTX/5hqWOvb+AFJy9ZjitME=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBwvnYTjklJsiHLf9mA1aB/lq4Ohz0r3aE2XjB/ny+TaYhgmxK
	2HbuuKqjDLuh2lF7PVeAiopVn3xyjQttEjWWKSgXDbbSbPTX3IJt
X-Gm-Gg: ASbGncuVLD6G8JWXa5zX8Uz+B3Sj2gVI/MBBlkJ8Z6rI5dMIvaZk09EgXxRXcpqFHdE
	XfI/nteTCqCNJLTg2cr17nxY+hR7mMvcCZv1joCo1z/tMeyTmYywkUYUHVbUIqeauuOlGPNBpxv
	mK+Br1Mp2qcVkKqjLd9RgnAJ/MFZnBEyNpjM71V9Bdv1aCIbSMD0CRkbGoC1H38Nt/4IJf9qglc
	Y5oExWQjhhzxm66kC2EZEySEU4Yhb0feH6Ad+3tAvnwDgG0eqClhqg7ghAZU+QmUlOVwgIoAVPZ
	8ALNTFyQPdNxLRtEJkXrWrM0CRGIR/x9/wFEHfty7+r57bc/nJUKdZ/rFrdisA==
X-Google-Smtp-Source: AGHT+IFX+yydMfA2KvN3qR8wwEAWMY6dCzO7XD1Jpai1WZCyjR83OHW/VfW2eSTH7oe0ieczq9aNOA==
X-Received: by 2002:a05:690c:6c8e:b0:6fb:9389:3cde with SMTP id 00721157ae682-6fbcc1ffb02mr73850507b3.3.1740267284829;
        Sat, 22 Feb 2025 15:34:44 -0800 (PST)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6fce175d7c7sm4656927b3.80.2025.02.22.15.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 15:34:43 -0800 (PST)
Date: Sat, 22 Feb 2025 18:34:42 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
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
Subject: Re: [PATCH 2/2] MAINTAINERS: add rust bindings entry for bitmap API
Message-ID: <Z7pfBoXDoH5x-MEq@thinkpad>
References: <20250221205649.141305-1-yury.norov@gmail.com>
 <20250221205649.141305-3-yury.norov@gmail.com>
 <CANiq72=ctKoDz+Kf7UFBTD-oF17cTHBcrkNN_5cqxQeK609OVA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72=ctKoDz+Kf7UFBTD-oF17cTHBcrkNN_5cqxQeK609OVA@mail.gmail.com>

On Sat, Feb 22, 2025 at 02:50:50PM +0100, Miguel Ojeda wrote:
> On Fri, Feb 21, 2025 at 9:57 PM Yury Norov <yury.norov@gmail.com> wrote:
> >
> > Bitmap developers do their best to keep the API stable. When API or
> > user-visible behavior needs to be changed such that it breaks rust,
> > bitmap and rust developers collaborate as follows:
> 
> If I understand correctly, you are proposing to a "temporarily stable
> API", i.e. to add new APIs while keeping old ones for a bit until the
> Rust side updates to the new one (including perhaps workarounds in the
> helpers when needed). Is that correct?

Yes. Keeping them under CONFIG_RUST for a while, or moving directly to
rust helpers would be an option.

> In other words, while the entry is about the helpers file, the policy
> is about all APIs (since some APIs are called directly), right?

Yes, it's about all functions used by rust. I can underline it in
the commit message. 
 
> (Up to you, Viresh et al., of course, i.e. I am just trying to follow)

What I want to make clear to my contributors is that lack of proficiency
in rust will never become a problem for them. If they have an improvement
that may break something on rust side, there will be someone who will take
care of it - this way or another.

I think rust developers need similar guarantees form rust maintainers:
there will be a rust engineer who will keep the bindings on rust side in
a good shape. Viresh, as per my understanding, has committed on that.

Thanks,
Yury

