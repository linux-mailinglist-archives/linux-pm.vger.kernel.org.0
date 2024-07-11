Return-Path: <linux-pm+bounces-10983-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFF692E4F6
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2024 12:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 134C42802AA
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2024 10:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA3A157A74;
	Thu, 11 Jul 2024 10:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZMQ2cv4a"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF7A15748F
	for <linux-pm@vger.kernel.org>; Thu, 11 Jul 2024 10:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720694600; cv=none; b=tfAYXGThnEklWYY0OrThyR9OblRJDvMP1iRHNQsVTVzKFocKxtanewcXACw3hGEwc1ZO7Q4r8slC+FSIXsPtvBY8qK9peasw7iZ1X+DyLiGhI8ykvAz/be0KmgwakHZsWGELTzagiffJCbLTggZVeG5PKaaxPNB91CH+ma9Oun8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720694600; c=relaxed/simple;
	bh=vLgN8ydt9R0lSQJEzNPu1qwo9POilw3g8eYIWXLN0pE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oMwFQHrqxVRHnlKGfdOpEME4rgm9Vc1cuL71akUtlQpreMxoo1g1gKhhwTDVTKlMfXy7VzHH2h0aTMteMiCjWad7lYjA7/boTBqE3t0NNW2dLiQ1wVeknMy1lHSCuFVw7QMgpoflpc/WSyDR3wLAp4wbhxe+zae1Pb1eEUGwEQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZMQ2cv4a; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720694598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nFnMHEgP+MZLRxSq3Ch/Tx/f7UElIyD3peARHLX6JK0=;
	b=ZMQ2cv4azeaNc4QUFsAM8QlTH/sWj8EOLlJTbxZ3r/hfMVpm+wpz4DafOqO+0hrfRC4cfL
	JkOp3D4Ra4CyZWmAtdW5XQr+us19SvxajYOmVPkwkzNN9C4eNIdiptnw4n5J60d/z4hHZk
	86iMgbkc1zADzSjad+KTh+rTzXwy2Pk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-148Wi4n3MwGjEvxFHbabaA-1; Thu, 11 Jul 2024 06:43:16 -0400
X-MC-Unique: 148Wi4n3MwGjEvxFHbabaA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-367987cff30so385760f8f.1
        for <linux-pm@vger.kernel.org>; Thu, 11 Jul 2024 03:43:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720694596; x=1721299396;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nFnMHEgP+MZLRxSq3Ch/Tx/f7UElIyD3peARHLX6JK0=;
        b=DUPuVIkG0j15WywCL6qOlSKwPVzBsAih3BDP9VccPxVtpmxigTPEsVyg3yYSxEm1gq
         vP6YFkALddK1AVpXSR2QmzR23nruK7c9nLvR5iqWPvthAoD3c2nFp0bmf0a6Jo9FvP0v
         efvijx9bRF2O0870vzm19qirzC+ui3dUiYg+aWlrslgSZlF5zNS4pLFnckL/49tNcwE1
         IE/ndMysnRFIuC4VKJZoNcrCzqnpdPEzeQLN48Vtx1Dj2NKDuYaEpfZVj4RT5Ji/OfXM
         CYdiDNEIn2wp6Mw2xFxy+7auJJEBGw7fIbnRDG1En3ThFdjhSJlnCqPrN0uYk3ENwDRP
         vjzA==
X-Forwarded-Encrypted: i=1; AJvYcCXEw/WE8C2ruy/MecPNK3Po+ML1BNk73bsQRFYkSqxuRt+CdPSHlxZpeqJkKsURJV9cL31tiFsj/ZeI3r0w6EJe3VsZgFexazM=
X-Gm-Message-State: AOJu0Yyv4QZwJX+mRxiKLOKrNGLXbOwmz9rrVLqXPtH620yKakMe0SLE
	KtZCYt7jGp9wDRbIZDXaaoTa7ifMoYBm6hScQgZ7LVMKR3lysB1eG5OQ1uCqj/pRLg6GtJgn9iE
	4L4Cd+gbAS6ogLwxI5CcprXJR/IGXCZoi6uRUndQe2F/mB4tXE1LKY6Ua
X-Received: by 2002:a5d:564a:0:b0:367:8811:5e3c with SMTP id ffacd0b85a97d-367cea6b768mr5014634f8f.20.1720694595828;
        Thu, 11 Jul 2024 03:43:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgRshjr+9ksnHSGSXuJd0NT8hvn9tanR8CI3BrSShzgi64VEFSJ0dPW8iU0bEZHBQ8xO0GpQ==
X-Received: by 2002:a5d:564a:0:b0:367:8811:5e3c with SMTP id ffacd0b85a97d-367cea6b768mr5014611f8f.20.1720694595446;
        Thu, 11 Jul 2024 03:43:15 -0700 (PDT)
Received: from pollux ([2a02:810d:4b3f:ee94:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde84798sm7375792f8f.38.2024.07.11.03.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 03:43:15 -0700 (PDT)
Date: Thu, 11 Jul 2024 12:43:12 +0200
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
Subject: Re: [PATCH V4 8/8] cpufreq: Add Rust based cpufreq-dt driver
Message-ID: <Zo-3QIPbhBsv8EjB@pollux>
References: <cover.1720680252.git.viresh.kumar@linaro.org>
 <b1601c1dbdf68a4b812fcfaf73f3b5dea67f2025.1720680252.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1601c1dbdf68a4b812fcfaf73f3b5dea67f2025.1720680252.git.viresh.kumar@linaro.org>

On Thu, Jul 11, 2024 at 12:27:50PM +0530, Viresh Kumar wrote:
> This commit adds a Rust based cpufreq-dt driver, which covers most of
> the functionality of the existing C based driver. Only a handful of
> things are left, like fetching platform data from cpufreq-dt-platdev.c.
> 
> This is tested with the help of QEMU for now and switching of
> frequencies work as expected.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/Kconfig        |  12 ++
>  drivers/cpufreq/Makefile       |   1 +
>  drivers/cpufreq/rcpufreq_dt.rs | 222 +++++++++++++++++++++++++++++++++
>  3 files changed, 235 insertions(+)
>  create mode 100644 drivers/cpufreq/rcpufreq_dt.rs
> 
> diff --git a/drivers/cpufreq/rcpufreq_dt.rs b/drivers/cpufreq/rcpufreq_dt.rs
> new file mode 100644
> index 000000000000..3e86ad134e13
> --- /dev/null
> +++ b/drivers/cpufreq/rcpufreq_dt.rs
> +
> +impl platform::Driver for CPUFreqDTDriver {
> +    type Data = ();
> +
> +    define_of_id_table! {(), [
> +        (of::DeviceId(b_str!("operating-points-v2")), None),
> +    ]}
> +
> +    fn probe(dev: &mut platform::Device, _id_info: Option<&Self::IdInfo>) -> Result<Self::Data> {
> +        let drv = cpufreq::Registration::<CPUFreqDTDriver>::register(

Please just call this function `cpufreq::Registration::new`.

The existance of a `cpufreq::Registration` means that it's registered. Once it
is dropped, it's unregistered. It's the whole point of a `Registration` type
to bind the period of a driver being registered to the lifetime of a
`Registration` instance.

Having `Registration::register` implies a bit, that we could ever have an
unregistered `Registration`, which can never happen.

Besides that, it'd be nice to follow the same naming scheme everywhere.

> +            c_str!("cpufreq-dt"),
> +            (),
> +            cpufreq::flags::NEED_INITIAL_FREQ_CHECK | cpufreq::flags::IS_COOLING_DEV,
> +            true,
> +        )?;
> +
> +        Devres::new_foreign_owned(dev.as_ref(), drv, GFP_KERNEL)?;

This should be called by `cpufreq::Registration` directly, otherwise it's every
driver's responsibility to take care of the registration lifetime.

> +
> +        pr_info!("CPUFreq DT driver registered\n");
> +
> +        Ok(())
> +    }
> +}
> +
> +module_platform_driver! {
> +    type: CPUFreqDTDriver,
> +    name: "cpufreq_dt",
> +    author: "Viresh Kumar <viresh.kumar@linaro.org>",
> +    description: "Generic CPUFreq DT driver",
> +    license: "GPL v2",
> +}
> -- 
> 2.31.1.272.g89b43f80a514
> 


