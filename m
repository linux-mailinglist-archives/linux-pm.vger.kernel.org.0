Return-Path: <linux-pm+bounces-10935-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CED92D4F5
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jul 2024 17:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7D59280FD1
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jul 2024 15:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1637194A62;
	Wed, 10 Jul 2024 15:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OnygIS73"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232EA1946CF
	for <linux-pm@vger.kernel.org>; Wed, 10 Jul 2024 15:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720625333; cv=none; b=PZ0SbqThuTGMYyQhq9MasTeI9NVXRNtjTxutu0UQDsR2mrdcnI94DEnEM/HG84tcHQ9KRV9DHpJ27FxXndw3ZitybWu5yamRWZAuN/2uMl2TAqvsufKiCFMk8Vw7XpzYXvbI8ybRx+SoC2x537d6ODyGt0KsYBlL+rRoTNfSuLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720625333; c=relaxed/simple;
	bh=umm5NQLzqFULNPwOL9iavZyEgQiYul3xYGSdC/V3Yi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GC4rmlpc8Y/yvvUX76KmHNPciCvEDP19qiMCbWtUaet6AyC0L4pW4Ry270hbFMBP7b1CLPnydImJDN7czDAjeHWqjxDWqxGeKPE6z9qtsi76TzxdXOlrx7hEclY/yobYKl/42iWOxVjUlY8w9Zwj1m13MU+DMvsL7JOGdG32ylc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OnygIS73; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720625330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JiswT65XwU9I/0a+3mkQf8xLZNUkrdHDC4aVFNJHkF8=;
	b=OnygIS73lenVD70rLixDzT8vDlApSlZkn0Sq2L3oW2Kiaj9buYwviYlrIJBNNsashfD2ry
	hv1yZXf6YF8YVA8tRQao2zeZFCDvyy/8Botw60AfGVacCLs4NqPP02gA11Gi+8QF2gORy1
	n4nZbRKEu5wG9AkzUWyUN/llKR4I9QQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-bopvxozMNCCu1CCZk5P0Gw-1; Wed, 10 Jul 2024 11:28:47 -0400
X-MC-Unique: bopvxozMNCCu1CCZk5P0Gw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-367af2cd5f3so2741423f8f.0
        for <linux-pm@vger.kernel.org>; Wed, 10 Jul 2024 08:28:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720625325; x=1721230125;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JiswT65XwU9I/0a+3mkQf8xLZNUkrdHDC4aVFNJHkF8=;
        b=OgfHzGfM8TMaW2PxjWyNSMd/LDrKB10SFCTvFphb+JPpxn9XGJWWhFYe9Fa4+brp9A
         zde7HljapglJ8g7Y3cJ5Do3qSZry31vijUYVyeEv6KItb3UeiSCbpVCviEyVtkrDmmgL
         HMhrrFNV4SP/zM6VnD7xWZijLQMfDzhLDJynCPfHI05fi+YU7/U6OY+0Dup4vjDPJcbF
         fo3FYlf/4kpqNqZHar5qO/6vQW/BDzu2hmgmC59vPdK+fFSUHknBA07oopEVkOKseUUa
         SgGlw5R5UlA/GM2YpyQtjum965wcWb6YzUczHsqglgwTxSOrajhNFj/cnEtRccPyWViM
         v35Q==
X-Forwarded-Encrypted: i=1; AJvYcCUNdd7FQ9pnp2k5aGmd2jmOEUPdRzwnMr6cwlkTXkLwEd22E4kV4fLT5bWxhBq9gRxX9+0PuhKQ6vnKwbm6hI/AQ+AE+lCc8F0=
X-Gm-Message-State: AOJu0YzFtniXdcr4xzC4Uan6hHV+/oKPgedUt5cVsdbYCkzSlVs4s5bC
	boknHe8ydyp6pT3QBwVJvT5nA/p2V5sEtXfqQSNWi+qn9a3VvqRoRzjG1nwAsVnXffWhwngMy4Z
	35z0pXUpPCG7ELCHGhAOn5dCrux+BPiCxwblIcmqoZapEdLkq4EtfHqcd
X-Received: by 2002:adf:e80b:0:b0:363:341:1cf2 with SMTP id ffacd0b85a97d-367cea7355emr3811015f8f.22.1720625325138;
        Wed, 10 Jul 2024 08:28:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaOpwUVhMBcEaYLWlYi0AGlNxmlsgMJ9+TlNHkqzOC0lgyPh6t979vO258uH0PKKJUo2HQ8g==
X-Received: by 2002:adf:e80b:0:b0:363:341:1cf2 with SMTP id ffacd0b85a97d-367cea7355emr3811000f8f.22.1720625324747;
        Wed, 10 Jul 2024 08:28:44 -0700 (PDT)
Received: from pollux ([2a02:810d:4b3f:ee94:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde7e07fsm5583240f8f.17.2024.07.10.08.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 08:28:44 -0700 (PDT)
Date: Wed, 10 Jul 2024 17:28:41 +0200
From: Danilo Krummrich <dakr@redhat.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
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
Subject: Re: [RFC PATCH V3 8/8] cpufreq: Add Rust based cpufreq-dt driver
Message-ID: <Zo6oqfFX-TNIeaIC@pollux>
References: <cover.1719990273.git.viresh.kumar@linaro.org>
 <b7df0c75cc07a451243b554fb2272c91cbe42dfe.1719990273.git.viresh.kumar@linaro.org>
 <f0016987-4288-4adf-954d-665b35ae1bf1@redhat.com>
 <20240710085652.zu7ntnv4gmy7zr2i@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710085652.zu7ntnv4gmy7zr2i@vireshk-i7>

On Wed, Jul 10, 2024 at 02:26:52PM +0530, Viresh Kumar wrote:
> On 05-07-24, 13:32, Danilo Krummrich wrote:
> > On 7/3/24 09:14, Viresh Kumar wrote:
> > > +    fn probe(_dev: &mut platform::Device, _id_info: Option<&Self::IdInfo>) -> Result<Self::Data> {
> > > +        let drv = Arc::new(
> > > +            cpufreq::Registration::<CPUFreqDTDriver>::register(
> > > +                c_str!("cpufreq-dt"),
> > > +                (),
> > > +                cpufreq::flags::NEED_INITIAL_FREQ_CHECK | cpufreq::flags::IS_COOLING_DEV,
> > > +                true,
> > > +            )?,
> > > +            GFP_KERNEL,
> > > +        )?;
> > 
> > Putting the `cpufreq::Registration` into `Arc<DeviceData>` is unsafe from a
> > lifetime point of view. Nothing prevents this `Arc` to out-live the
> > `platform::Driver`.
> 
> Hmm, the platform driver layer (in Rust) should guarantee that the
> data will be freed from the driver removal path. Isn't it ?

No, the platform driver layer will only guarantee that it decreses the reference
count of the `Arc` by one, that doesn't guarantee a free. If something else
still holds a reference to the `Arc` it will keep the `Registration` alive,
unless it's wrapped by `Devres`.

> 
> > Instead, you should wrap `cpufreq::Registration` into `Devres`. See
> > `drm::drv::Registration` for an example [1].
> > 
> > [1] https://gitlab.freedesktop.org/drm/nova/-/blob/nova-next/rust/kernel/drm/drv.rs?ref_type=heads#L173
> 
> I can convert to that too, will do it anyway.
> 
> -- 
> viresh
> 


