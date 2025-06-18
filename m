Return-Path: <linux-pm+bounces-28999-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B2AADF465
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 19:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 977F83A121A
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 17:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807CE2F49EB;
	Wed, 18 Jun 2025 17:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZKTfdMki"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7232FE383
	for <linux-pm@vger.kernel.org>; Wed, 18 Jun 2025 17:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750268450; cv=none; b=KjdzxKqaz0lkyj+yfPaVOmtuT3NVrzRvZgr6BOsPnM6gPtCfUOaNeyTuKqA3fe/4PiG51EqGPWDohYm+r2oBeMB6QRMTP0MsY3wsSVrlMtdCke1Xxc7E5eAWC29R6avzTvW85/OOajjEznqH52RuSzcsPRK3OTzjuvnArVslhUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750268450; c=relaxed/simple;
	bh=4sFWwkFXi8BvpD8IMU8juMRg7f+DirSsf+Ud/E9pRzw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K05xPhE04UPLHNLjUt+Qkei74hrr1aS5Pt1OYRtUFwr5TfFUMyvcUjktqgCeI9xDIyEEVgWhouKuftfl8M193pP+2iMEFQlT3BjP18qJX3CJWsG3V4SAjIsL5MhckRoC1uPO4t0OhWUkjaPdSW/lwE6ZNxR2MduK4qY4KZcioGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZKTfdMki; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750268444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QyjtI6z4LqPR2c4duviV1oQl9DWLYnzH4cNekvsPaJY=;
	b=ZKTfdMkiRBxVhKaZlowFwwUCoT2CSQnfLD4e79dpP6Wa9/0f6qvuE+GQ1xHN5JrCtCKQ0L
	zqCzqWl9QoIhk0Dbz6m7moPI9z0wdAi2jpiAgT4dz8zIGZ6oOmaz/NDPiCY3xB19d9EuqI
	3hjr3lB9dR0/y09caxJrw2pAU2G5srQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-8h1ogsJlN42F1ujma5zjJQ-1; Wed, 18 Jun 2025 13:40:42 -0400
X-MC-Unique: 8h1ogsJlN42F1ujma5zjJQ-1
X-Mimecast-MFC-AGG-ID: 8h1ogsJlN42F1ujma5zjJQ_1750268442
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ae012f87dd1so109417766b.3
        for <linux-pm@vger.kernel.org>; Wed, 18 Jun 2025 10:40:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750268442; x=1750873242;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QyjtI6z4LqPR2c4duviV1oQl9DWLYnzH4cNekvsPaJY=;
        b=GvxrbJjY3FM483Gt1tkawKvUmuVto2+mScGjSu9EvuCd4Dx2DTytzOytoZ+SFePIFQ
         fxDwWKJUW7IHclS1xUL9k1G2Eose/+MdHpCk6k0x7C9RJGlehxuEOd0PhQvo6gtBCpe3
         ScveHeaEqx3LVY2h930dNv8p5uTTmDD88A0bSLEhyXe5Qrg1YOVVi9vlMt+B9PesT5r0
         EtmefjDJNa5GUtxdwhcZ9sf2guCvRJ/qobfhtXOwqQJWQs5SNHaRj5SVTLfMjgXvh3uq
         zAqU7VbmisRuuP1kRSinYV6lJuLMpPW6WlQ9GtPb18ouyG4VXjoc36jFZ7YmdmAHdVwn
         GNHg==
X-Forwarded-Encrypted: i=1; AJvYcCWrgJQCVlBZWexOdC1OsuoxECM/Yvx4p0mtrbAs0KzdgrJNOEF0uRnS96mgciiMvccrb5ofRZ1V5A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7naPKoBeQsZzBJDc5c/HzZfkbIzYlABgefzKhLwp3V0DDHyo4
	ZoraCYZGPiwGWpvC4lV1wvJJugngxV4ec3fy5bx4BOXvpcQEGtQz9Yu6JpiP1JRSuBBoveMYawI
	mUEu/vT44QKiTdEIOjc4bvKgYBy1uGbhVEwEaiGkhEPKfLBMRjsoyGD5AAyA4
X-Gm-Gg: ASbGncsdF6yePZXc3QvRxy4YwZrOtXblQUSjBfC2NVTDDyVNDYi4q2AXRx3MWJKUQLe
	p6ZY2EgrWpDqXMCydKERGlkp3ka3LOTuFmaV18/GSgCPe0gTaSlzEIBaHos9yGqDXzEQ43q/TwY
	YFwz5ET0yibCOtB2exNcx76wEGQqSVvBTjgXQwJIJs+q5V17zu8FTDJ+xc1JM9S6ncLeqyHT3zq
	pTjnA0b2Z5NOzhE8qoiqB8EiL1BXZ+RY2fnVUMF84uP48GykUV+MdqiuxLjcw2PEO7kbxGAY+IU
	Jr4MWXt+hoJIHam+PMep5/fdkCGnIIaW9yPwaDGnXuFESQQfUs9vll/3x7hPAA==
X-Received: by 2002:a17:907:3f1f:b0:ad2:417b:2ab5 with SMTP id a640c23a62f3a-adfad4f5a5amr1527478566b.60.1750268441561;
        Wed, 18 Jun 2025 10:40:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJxKyWXcdF99utGWSG81lMA2wUOYJgcYHm0gBuwbodj41pCAPM9kqV+i3SsT8FRKkHC4LNpQ==
X-Received: by 2002:a17:907:3f1f:b0:ad2:417b:2ab5 with SMTP id a640c23a62f3a-adfad4f5a5amr1527470666b.60.1750268440967;
        Wed, 18 Jun 2025 10:40:40 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:8998:e0cf:68cc:1b62? ([2a01:e0a:c:37e0:8998:e0cf:68cc:1b62])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec897c397sm1066045766b.167.2025.06.18.10.40.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 10:40:40 -0700 (PDT)
Message-ID: <f6dcf50e-99ee-4e2d-86a8-5ffa2c7aacc7@redhat.com>
Date: Wed, 18 Jun 2025 19:40:36 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 5/6] rust: enable `clippy::cast_lossless` lint
To: Tamir Duberstein <tamird@gmail.com>,
 Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor
 <nathan@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow
 <davidgow@google.com>, Rae Moar <rmoar@google.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>,
 Saravana Kannan <saravanak@google.com>,
 Abdiel Janulgue <abdiel.janulgue@gmail.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Nicolas Schier <nicolas.schier@linux.dev>,
 Frederic Weisbecker <frederic@kernel.org>, Lyude Paul <lyude@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Benno Lossin <lossin@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Breno Leitao
 <leitao@debian.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com, linux-pci@vger.kernel.org,
 linux-block@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, linux-mm@kvack.org,
 linux-pm@vger.kernel.org, nouveau@lists.freedesktop.org
References: <20250615-ptr-as-ptr-v12-0-f43b024581e8@gmail.com>
 <20250615-ptr-as-ptr-v12-5-f43b024581e8@gmail.com>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20250615-ptr-as-ptr-v12-5-f43b024581e8@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 15/06/2025 22:55, Tamir Duberstein wrote:
> Before Rust 1.29.0, Clippy introduced the `cast_lossless` lint [1]:
> 
>> Rust’s `as` keyword will perform many kinds of conversions, including
>> silently lossy conversions. Conversion functions such as `i32::from`
>> will only perform lossless conversions. Using the conversion functions
>> prevents conversions from becoming silently lossy if the input types
>> ever change, and makes it clear for people reading the code that the
>> conversion is lossless.
> 
> While this doesn't eliminate unchecked `as` conversions, it makes such
> conversions easier to scrutinize.  It also has the slight benefit of
> removing a degree of freedom on which to bikeshed. Thus apply the
> changes and enable the lint -- no functional change intended.

Thanks, it looks good to me, for the drm_panic_qr.rs part.

Acked-by: Jocelyn Falempe <jfalempe@redhat.com>

> 
> Link: https://rust-lang.github.io/rust-clippy/master/index.html#cast_lossless [1]
> Suggested-by: Benno Lossin <benno.lossin@proton.me>
> Link: https://lore.kernel.org/all/D8ORTXSUTKGL.1KOJAGBM8F8TN@proton.me/
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
>   Makefile                             | 1 +
>   drivers/gpu/drm/drm_panic_qr.rs      | 4 ++--
>   drivers/gpu/nova-core/regs.rs        | 2 +-
>   drivers/gpu/nova-core/regs/macros.rs | 2 +-
>   rust/bindings/lib.rs                 | 1 +
>   rust/kernel/net/phy.rs               | 4 ++--
>   rust/uapi/lib.rs                     | 1 +
>   7 files changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 0ba22c361de8..29cf39be14de 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -481,6 +481,7 @@ export rust_common_flags := --edition=2021 \
>   			    -Wclippy::all \
>   			    -Wclippy::as_ptr_cast_mut \
>   			    -Wclippy::as_underscore \
> +			    -Wclippy::cast_lossless \
>   			    -Wclippy::ignored_unit_patterns \
>   			    -Wclippy::mut_mut \
>   			    -Wclippy::needless_bitwise_bool \
> diff --git a/drivers/gpu/drm/drm_panic_qr.rs b/drivers/gpu/drm/drm_panic_qr.rs
> index dd55b1cb764d..6b59d19ab631 100644
> --- a/drivers/gpu/drm/drm_panic_qr.rs
> +++ b/drivers/gpu/drm/drm_panic_qr.rs
> @@ -404,7 +404,7 @@ fn pop3(&mut self) -> Option<(u16, usize)> {
>               let mut out = 0;
>               let mut exp = 1;
>               for i in 0..poplen {
> -                out += self.decimals[self.len + i] as u16 * exp;
> +                out += u16::from(self.decimals[self.len + i]) * exp;
>                   exp *= 10;
>               }
>               Some((out, NUM_CHARS_BITS[poplen]))
> @@ -425,7 +425,7 @@ fn next(&mut self) -> Option<Self::Item> {
>           match self.segment {
>               Segment::Binary(data) => {
>                   if self.offset < data.len() {
> -                    let byte = data[self.offset] as u16;
> +                    let byte = u16::from(data[self.offset]);
>                       self.offset += 1;
>                       Some((byte, 8))
>                   } else {
> diff --git a/drivers/gpu/nova-core/regs.rs b/drivers/gpu/nova-core/regs.rs
> index 5a1273230306..c1cb6d4c49ee 100644
> --- a/drivers/gpu/nova-core/regs.rs
> +++ b/drivers/gpu/nova-core/regs.rs
> @@ -32,7 +32,7 @@ pub(crate) fn architecture(self) -> Result<Architecture> {
>       pub(crate) fn chipset(self) -> Result<Chipset> {
>           self.architecture()
>               .map(|arch| {
> -                ((arch as u32) << Self::IMPLEMENTATION.len()) | self.implementation() as u32
> +                ((arch as u32) << Self::IMPLEMENTATION.len()) | u32::from(self.implementation())
>               })
>               .and_then(Chipset::try_from)
>       }
> diff --git a/drivers/gpu/nova-core/regs/macros.rs b/drivers/gpu/nova-core/regs/macros.rs
> index 7ecc70efb3cd..6851af8b5885 100644
> --- a/drivers/gpu/nova-core/regs/macros.rs
> +++ b/drivers/gpu/nova-core/regs/macros.rs
> @@ -264,7 +264,7 @@ pub(crate) fn $field(self) -> $res_type {
>           pub(crate) fn [<set_ $field>](mut self, value: $to_type) -> Self {
>               const MASK: u32 = $name::[<$field:upper _MASK>];
>               const SHIFT: u32 = $name::[<$field:upper _SHIFT>];
> -            let value = ((value as u32) << SHIFT) & MASK;
> +            let value = (u32::from(value) << SHIFT) & MASK;
>               self.0 = (self.0 & !MASK) | value;
>   
>               self
> diff --git a/rust/bindings/lib.rs b/rust/bindings/lib.rs
> index 81b6c7aa4916..7631c9f6708d 100644
> --- a/rust/bindings/lib.rs
> +++ b/rust/bindings/lib.rs
> @@ -25,6 +25,7 @@
>   )]
>   
>   #[allow(dead_code)]
> +#[allow(clippy::cast_lossless)]
>   #[allow(clippy::ptr_as_ptr)]
>   #[allow(clippy::undocumented_unsafe_blocks)]
>   #[cfg_attr(CONFIG_RUSTC_HAS_UNNECESSARY_TRANSMUTES, allow(unnecessary_transmutes))]
> diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
> index 32ea43ece646..65ac4d59ad77 100644
> --- a/rust/kernel/net/phy.rs
> +++ b/rust/kernel/net/phy.rs
> @@ -142,7 +142,7 @@ pub fn is_autoneg_enabled(&self) -> bool {
>           // SAFETY: The struct invariant ensures that we may access
>           // this field without additional synchronization.
>           let bit_field = unsafe { &(*self.0.get())._bitfield_1 };
> -        bit_field.get(13, 1) == bindings::AUTONEG_ENABLE as u64
> +        bit_field.get(13, 1) == u64::from(bindings::AUTONEG_ENABLE)
>       }
>   
>       /// Gets the current auto-negotiation state.
> @@ -427,7 +427,7 @@ impl<T: Driver> Adapter<T> {
>           // where we hold `phy_device->lock`, so the accessors on
>           // `Device` are okay to call.
>           let dev = unsafe { Device::from_raw(phydev) };
> -        T::match_phy_device(dev) as i32
> +        T::match_phy_device(dev).into()
>       }
>   
>       /// # Safety
> diff --git a/rust/uapi/lib.rs b/rust/uapi/lib.rs
> index e79a1f49f055..08e68ebef606 100644
> --- a/rust/uapi/lib.rs
> +++ b/rust/uapi/lib.rs
> @@ -14,6 +14,7 @@
>   #![cfg_attr(test, allow(unsafe_op_in_unsafe_fn))]
>   #![allow(
>       clippy::all,
> +    clippy::cast_lossless,
>       clippy::ptr_as_ptr,
>       clippy::undocumented_unsafe_blocks,
>       dead_code,
> 


