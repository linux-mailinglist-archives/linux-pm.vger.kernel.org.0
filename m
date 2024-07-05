Return-Path: <linux-pm+bounces-10693-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4B9928801
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2024 13:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30D531C23354
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2024 11:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE7D1494D7;
	Fri,  5 Jul 2024 11:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gUgvIRR8"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A831494A8
	for <linux-pm@vger.kernel.org>; Fri,  5 Jul 2024 11:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720179148; cv=none; b=D/YqW45M7yVMjul3HcU6lF1WoL5IhEBy23WF2Z7LM+5SVOL1DWg9/69+FSn3sI+wgik6gYfP23fO2v5Bpcb5hE0e1m/4cZ0JFknQRpBZuStok4aPHmS7kn6/cTfSw/yRxSF9Rzl5UkwT61+6ENjiklxAlrwxKSm3eoZJIukA6do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720179148; c=relaxed/simple;
	bh=LuO94MjSEqAzZZ+OdQaO8GGVDhFrlkG2Ta2cSnC8spg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u5bQSgqcwE2TSrrxSgamrai7kkry71A2O6W3eFGkdZ2MyIQN/O8Mb9zEQrtwm5o0RmgrDLgYTA+7YOs87MsgwWsREaxO0jtrzoXhyt8SUoMS90hA5nQYswzbtWfHCsZJG/PUy+StOTnj+SK0baMKSqbRQ0Vy99w6jZBgtoQijVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gUgvIRR8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720179145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jE6S85bFX7ia/r0z6WYFjOqpTUOd5eKCH2fyhxzh5mo=;
	b=gUgvIRR8gVdtlctS4LSsyqkZ7dTrtf/F6bG6NvrRiJObq2+UWb3Ffbb2N318ru1vn6HmqP
	kGPC95bN5FL7viWCZiPXXUkFmlazp1xt0rnBiRqT7N2Ec7zwMLGjuqnvaJpgTedGPYLaaM
	sJ2V3bK8i5QmsKF9osHWAZ34PuUeTzg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-AGHpcc9XPDqiVNO7-KFDAQ-1; Fri, 05 Jul 2024 07:32:24 -0400
X-MC-Unique: AGHpcc9XPDqiVNO7-KFDAQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42566e8a995so12130395e9.0
        for <linux-pm@vger.kernel.org>; Fri, 05 Jul 2024 04:32:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720179143; x=1720783943;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jE6S85bFX7ia/r0z6WYFjOqpTUOd5eKCH2fyhxzh5mo=;
        b=XCEB8GX4RcrzfXfCx+3/PXiYEGy6/sgiS4+gVzqM1PU9EgeCp833NvattHglxd1tnx
         RqxsHVwspM/ESSkUg05V1mS89EYZ+AIYBKxQ8+L+fCsZ3WyZkQJS0txAUGvabiYveYZR
         Rduhmjg+Ynlxez5U69RF0MaS8sTYbyRinJYzfLzK+Cz6f5BePXU8XODft1ClKgm+Om8a
         1pOubckHxYQO49KkEfJhZMQ9wEEF4FMfhuboe487OXzhbySM2D0EHVFSZUPE63TV3jnU
         oNlANlMRLAPpEmrfbya+Pc8SFCpiswAZakDrvOZYfpvaa1+tfOBi6cwzCpxn90r1zDGM
         DzoQ==
X-Gm-Message-State: AOJu0YyXBAKv3/U2JE5+IexhT7zliIaCxpF/ZT2uF+Mi/szCu2ep2nnm
	6htUzG0Wvo9v0BmRjp36F/VVJYOXhbbBN/mFboFk/WtndIko0vX31ecrjq+AosWPMMvnEeKqeIe
	fgHL5bYaN7Zl+ZLoCJhSQ7VjA2iX5ZMxgJVRFxCt/BxmkH7lrV8Y45YUx
X-Received: by 2002:a05:600c:4b87:b0:426:59fc:cdec with SMTP id 5b1f17b1804b1-42659fccf3bmr4970835e9.21.1720179143038;
        Fri, 05 Jul 2024 04:32:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwwu8Zih5RO6YSe8hQ4RBs6xd5L3lcOJBKw/I/nyz5x44QjIrLSHbrH1hqM8ht621bYpY3Cw==
X-Received: by 2002:a05:600c:4b87:b0:426:59fc:cdec with SMTP id 5b1f17b1804b1-42659fccf3bmr4970545e9.21.1720179142584;
        Fri, 05 Jul 2024 04:32:22 -0700 (PDT)
Received: from ?IPV6:2a02:810d:4b3f:ee94:abf:b8ff:feee:998b? ([2a02:810d:4b3f:ee94:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a1dda61sm58241895e9.19.2024.07.05.04.32.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jul 2024 04:32:22 -0700 (PDT)
Message-ID: <f0016987-4288-4adf-954d-665b35ae1bf1@redhat.com>
Date: Fri, 5 Jul 2024 13:32:19 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH V3 8/8] cpufreq: Add Rust based cpufreq-dt driver
To: Viresh Kumar <viresh.kumar@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng
 <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>,
 Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
 rust-for-linux@vger.kernel.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Erik Schilling <erik.schilling@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>,
 linux-kernel@vger.kernel.org
References: <cover.1719990273.git.viresh.kumar@linaro.org>
 <b7df0c75cc07a451243b554fb2272c91cbe42dfe.1719990273.git.viresh.kumar@linaro.org>
Content-Language: en-US
From: Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <b7df0c75cc07a451243b554fb2272c91cbe42dfe.1719990273.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Viresh,

On 7/3/24 09:14, Viresh Kumar wrote:
> This commit adds a Rust based cpufreq-dt driver, which covers most of
> the functionality of the existing C based driver. Only a handful of
> things are left, like fetching platform data from cpufreq-dt-platdev.c.
> 
> This is tested with the help of QEMU for now and switching of
> frequencies work as expected.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>   drivers/cpufreq/Kconfig        |  12 ++
>   drivers/cpufreq/Makefile       |   1 +
>   drivers/cpufreq/rcpufreq_dt.rs | 225 +++++++++++++++++++++++++++++++++
>   3 files changed, 238 insertions(+)
>   create mode 100644 drivers/cpufreq/rcpufreq_dt.rs
> 
> diff --git a/drivers/cpufreq/rcpufreq_dt.rs b/drivers/cpufreq/rcpufreq_dt.rs
> new file mode 100644
> index 000000000000..652458e7a3b9
> --- /dev/null
> +++ b/drivers/cpufreq/rcpufreq_dt.rs

<snip>

> +
> +type DeviceData = Box<cpufreq::Registration<CPUFreqDTDriver>>;
> +
> +impl platform::Driver for CPUFreqDTDriver {
> +    type Data = Arc<DeviceData>;
> +
> +    define_of_id_table! {(), [
> +        (of::DeviceId(b_str!("operating-points-v2")), None),
> +    ]}
> +
> +    fn probe(_dev: &mut platform::Device, _id_info: Option<&Self::IdInfo>) -> Result<Self::Data> {
> +        let drv = Arc::new(
> +            cpufreq::Registration::<CPUFreqDTDriver>::register(
> +                c_str!("cpufreq-dt"),
> +                (),
> +                cpufreq::flags::NEED_INITIAL_FREQ_CHECK | cpufreq::flags::IS_COOLING_DEV,
> +                true,
> +            )?,
> +            GFP_KERNEL,
> +        )?;

Putting the `cpufreq::Registration` into `Arc<DeviceData>` is unsafe from a
lifetime point of view. Nothing prevents this `Arc` to out-live the
`platform::Driver`.

Instead, you should wrap `cpufreq::Registration` into `Devres`. See
`drm::drv::Registration` for an example [1].

[1] https://gitlab.freedesktop.org/drm/nova/-/blob/nova-next/rust/kernel/drm/drv.rs?ref_type=heads#L173

> +
> +        pr_info!("CPUFreq DT driver registered\n");
> +
> +        Ok(drv)
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


