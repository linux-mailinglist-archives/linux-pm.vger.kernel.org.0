Return-Path: <linux-pm+bounces-10948-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F39992DB8E
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2024 00:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2AA41C21645
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jul 2024 22:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24D8149E0E;
	Wed, 10 Jul 2024 22:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m9vcFRfh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44F51494B9;
	Wed, 10 Jul 2024 22:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720649174; cv=none; b=sBlVCVYhp2/f1LXQTjaSKrdqSMkugW911gXSegENiQRBN+eakRsFLqZ82XN+wqSPKFYUj9tsSLUgLFDa7n+UHAryUoxAt3Obd3RWC2KJ4UUJRWRidA6mMycG7EWAwDwEFdMbWBcVqybB8nUlmLdedZ6LF7vFBmrUApxSWi2pYIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720649174; c=relaxed/simple;
	bh=fra+uJ9ihrE7pcF+O3kIzc0vD3ziRZ1ZXU6TCViPJdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MVuM7+olTSifQWKOmLeeje9GaikfdPD4M8McOt18JNInKI+SiBxoWB1+WkDPieNn8sbARl1NXbU665dfTlNgX2WMhPfLOwTYWB3ZLJw67UOaulMi/J5oGlkw8pkxFWSPanC2lRe/HQTgPQAoOhW/hdFC2AB0AW4FeXgH64ycaNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m9vcFRfh; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-44931d9eda6so2318401cf.1;
        Wed, 10 Jul 2024 15:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720649172; x=1721253972; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KeYbNDPg/ePPaWh8fx4YPE/6Ak4jjKbY61dtBDyMPGU=;
        b=m9vcFRfhtPuis53TZ2ythX4G8z/Su8cuSWH+s/Tvjjt7x6re9yawazgwv241l6HabK
         qALTpkEvDEso12Mw2YYK5V7H3j64hvjte6TwxjFo9ZUgEqCXucBTpCj8eGZwhKP6sboR
         oYxWbViYPcUw4Mvlo1+IcM+Wdz6XNxRuDdev49i362fYDwJvqD46GzM1xyCOXUeIKEko
         ctKFRNsOGkIJPc28ipmWCn5a9SK6AiFsEEXdHRa3INVDgQINS3Hf9JdnpQMCvZCwa91A
         jSAFfAOUFpNv7zgKd7QlkFFkFNzJheVAmr4Jc8tMxliDb+YJDcJjnBhWUkW0887rNdzA
         pRmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720649172; x=1721253972;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KeYbNDPg/ePPaWh8fx4YPE/6Ak4jjKbY61dtBDyMPGU=;
        b=j4B0OZoAgtPWbeGrVcAakukmS8iKiRG52bFEaVCuCmCSVIJFy3BpYLl3283bXiqNc9
         PPYM8gR08fE+PPdeqMP7SZ22clG06wUPwqCDBgelbG0WhJ/3oSnS8aOBCRQkFs3XAIVk
         DRQotnSeA5I7u53n48dF+mtiZRsQA5+Cj+By2fSLire0jQr7mUo/0boRxG6HqT6kE6VL
         ZjGYwR23/bTSOYEvprOJ9lKyv/abzC3hyHNSrT3AoNOgFLLych0c9x8ofxPIWhsNTfx5
         SioeMU6jJGkQjutlmWB/Mlm3VTkvw+5tjCFoPci6O7jvjP+KzBF4r1MkB/BLGHIs/oRJ
         T4HQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSDkYwK/lBEhZ7U50PmuwCGEWrcKJeXTQxb7/qP4Jg5jT5+RPvRvpzB3nFrSye8fQty3XidfNRtZgDFBhAha/YpLTA34mqb6jJES0u1vuPSPFpFulyTPmVefJ3Blq2T14nOLOrrPXYz7BfZzuV7p1BL4U1ys427bYLzHhgPE7t1lrGVmAcng==
X-Gm-Message-State: AOJu0YwLHMmXNKwZjTJCKscGOyoj48c61bqyvyCfBTABFZSaOWTS0hCY
	oOZY4KZ9dmXp3gs3eGzvcUYWJz7XSzfHS/KSWLRzD+I9upRju4ne
X-Google-Smtp-Source: AGHT+IFEyV0IjNyixcWQvhB46t+HlXBO/vxFNP943OTjoE70npAhD2l2Rvb6mGXOwHGLUkktKvXeeg==
X-Received: by 2002:a05:622a:4f:b0:446:3a8f:1907 with SMTP id d75a77b69052e-44cee8a120bmr16457021cf.7.1720649171631;
        Wed, 10 Jul 2024 15:06:11 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-447f9b3d2d6sm24064931cf.22.2024.07.10.15.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 15:06:11 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 9DE571200078;
	Wed, 10 Jul 2024 17:59:35 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 10 Jul 2024 17:59:35 -0400
X-ME-Sender: <xms:RgSPZh7HljiO_z4yCTrh8xP7wL4Uqe5U7g0a00Sjae3b6vRLYn_yWQ>
    <xme:RgSPZu7XtWrLmK58A8W6hJz2CkI6Ntg6RQqmPld3B_CD_SGXHY352kRQfSjQ9MRW4
    yNTicLZWvznFsVkNg>
X-ME-Received: <xmr:RgSPZoccNTrEuF1CykJueRCUhSgAxVuS7WHzrrqUjgBFkrCZZfrWXxwOm1HRHg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrfeefgddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepheejveevjeettdfguedvjeefheffteelheelvefhveeiheejkeegfefgueel
    feeinecuffhomhgrihhnpegtrghsthdrrghsnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhs
    ohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnh
    hgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:RgSPZqLblSOorUET1hqbQZTfvpDxqkd-8OS8MgM1m6dMwpN4U_N_Mw>
    <xmx:RgSPZlLUvftH4dQTMrQ8VcDAPgLJl4e14g6g-gZLEI2qEPDEBYaJIg>
    <xmx:RgSPZjyvExXEPEKLFVq6HVfTgUlQ9DLR0bm35lqgps_EdBx6-P4vJA>
    <xmx:RgSPZhIWv64P7_ZJNG3LPvbgLKbMp-61D8y4I6x4K0UARt3MBmshgQ>
    <xmx:RwSPZoZeeRLXZqUrBon6owZ0xo8_1Vn556Gcwhjjx7CC1swTLZFBze3f>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jul 2024 17:59:34 -0400 (EDT)
Date: Wed, 10 Jul 2024 14:58:11 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
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
Subject: Re: [RFC PATCH V3 1/8] rust: Add initial bindings for OPP framework
Message-ID: <Zo8D86qiZ7aYdZhY@boqun-archlinux>
References: <cover.1719990273.git.viresh.kumar@linaro.org>
 <fe8e9a96b29122876346fc98a6a9ede7e4f28707.1719990273.git.viresh.kumar@linaro.org>
 <ZoVvn0QCSR8y4HQJ@Boquns-Mac-mini.home>
 <20240709110245.o73xnrj6jsvz2v2w@vireshk-i7>
 <Zo13PB-fZ8B9WEYy@boqun-archlinux>
 <20240710073623.qdxatsqvumkguabp@vireshk-i7>
 <20240710110607.jywoxf3wnkze2ouu@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710110607.jywoxf3wnkze2ouu@vireshk-i7>

On Wed, Jul 10, 2024 at 04:36:07PM +0530, Viresh Kumar wrote:
> On 10-07-24, 13:06, Viresh Kumar wrote:
> > I am not entirely sure what the change must be like that :)
> 
> Anyway, I have looked around and made some changes. Please see how it
> looks now. Thanks Boqun.
> 
> diff --git a/rust/kernel/opp.rs b/rust/kernel/opp.rs
> new file mode 100644
> index 000000000000..2ef262c4640a
> --- /dev/null
> +++ b/rust/kernel/opp.rs
> @@ -0,0 +1,188 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Operating performance points.
> +//!
> +//! This module provides bindings for interacting with the OPP subsystem.
> +//!
> +//! C header: [`include/linux/pm_opp.h`](srctree/include/linux/pm_opp.h)
> +
> +use crate::{
> +    bindings,
> +    device::Device,
> +    error::{code::*, to_result, Result},
> +    types::{ARef, AlwaysRefCounted, Opaque},
> +};
> +
> +use core::ptr;
> +
> +/// Dynamically created Operating performance point (OPP).
> +pub struct Token {
> +    dev: ARef<Device>,
> +    freq: u64,
> +}
> +
> +impl Token {
> +    /// Adds an OPP dynamically.
> +    pub fn new(dev: &ARef<Device>, mut data: Data) -> Result<Self> {
> +        // SAFETY: The requirements are satisfied by the existence of `Device` and its safety
> +        // requirements.
> +        to_result(unsafe { bindings::dev_pm_opp_add_dynamic(dev.as_raw(), &mut data.0) })?;
> +        Ok(Self {
> +            dev: dev.clone(),
> +            freq: data.freq(),
> +        })
> +    }
> +}
> +
> +impl Drop for Token {
> +    fn drop(&mut self) {
> +        // SAFETY: The requirements are satisfied by the existence of `Device` and its safety
> +        // requirements.
> +        unsafe { bindings::dev_pm_opp_remove(self.dev.as_raw(), self.freq) };
> +    }
> +}
> +
> +/// Equivalent to `struct dev_pm_opp_data` in the C Code.
> +#[repr(transparent)]
> +pub struct Data(bindings::dev_pm_opp_data);
> +
> +impl Data {
> +    /// Creates new instance of [`Data`].
> +    pub fn new(freq: u64, u_volt: u64, level: u32, turbo: bool) -> Self {
> +        Self(bindings::dev_pm_opp_data {
> +            turbo,
> +            freq,
> +            u_volt,
> +            level,
> +        })
> +    }
> +
> +    /// Adds an OPP dynamically. The OPP is freed once the [`Token`] gets freed.
> +    pub fn add_opp(self, dev: &ARef<Device>) -> Result<Token> {
> +        Token::new(dev, self)
> +    }
> +
> +    fn freq(&self) -> u64 {
> +        self.0.freq
> +    }
> +}
> +
> +/// Operating performance point (OPP).
> +///
> +/// Wraps the kernel's `struct dev_pm_opp`.
> +///
> +/// The pointer stored in `Self` is non-null and valid for the lifetime of the `OPP` instance.
> +///
> +/// # Refcounting
> +///
> +/// Instances of this type are reference-counted. The reference count is incremented by the
> +/// `dev_pm_opp_get()` function and decremented by `dev_pm_opp_put`. The Rust type `ARef<OPP>`
> +/// represents a pointer that owns a reference count on the OPP.
> +///
> +/// A reference to the `OPP`, `&OPP` isn't refcounted by the Rust code. The C code guarantees that
> +/// the pointer stored in `OPP` is is valid for the lifetime of the reference and hence refcounting

"the pointer stored in `OPP`" is incorrect, I think what you tried to
say here is "the C code guarantees a pointer to `OPP` is valid with at
lease one reference count for the lifetime of the `&OPP`". But this
comment can be avoided at all since it's generally true for most
references. It's OK if you want to write this here as a special note.

> +/// isn't required.
> +
> +#[repr(transparent)]
> +pub struct OPP(Opaque<bindings::dev_pm_opp>);
> +
> +// SAFETY: It is okay to send ownership of `OPP` across thread boundaries and `OPP::dec_ref` can be
> +// called from any thread.

Whether `OPP::dec_ref` can be called from any thread is unrelated to
whether `OPP` is `Send` or not. `Send` means you could own an `OPP`
(instead of an `ARef<OPP>`) that's created by other thread/context, as
long as `Opp::drop` is safe to call from a different thread (other than
the one that creates it), it should be safe to send.

> +unsafe impl Send for OPP {}
> +
> +// SAFETY: It's OK to access `OPP` through shared references from other threads because we're
> +// either accessing properties that don't change or that are properly synchronised by C code.

LGTM.

> +unsafe impl Sync for OPP {}
> +
> +// SAFETY: The type invariants guarantee that [`OPP`] is always refcounted.

Since you use "type invariants" here, you should rename the "# Refcounting"
section before "OPP" as "# Invariants".

> +unsafe impl AlwaysRefCounted for OPP {
> +    fn inc_ref(&self) {
> +        // SAFETY: The existence of a shared reference means that the refcount is nonzero.
> +        unsafe { bindings::dev_pm_opp_get(self.0.get()) };
> +    }
> +
> +    unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
> +        // SAFETY: The safety requirements guarantee that the refcount is nonzero.
> +        unsafe { bindings::dev_pm_opp_put(obj.cast().as_ptr()) }
> +    }
> +}
> +
> +impl OPP {
> +    /// Creates an owned reference to a [`OPP`] from a valid pointer.
> +    ///
> +    /// The refcount is incremented by the C code and will be decremented by `dec_ref()` when the
> +    /// ARef object is dropped.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller must ensure that `ptr` is valid and OPP's refcount is incremented.

One part is missing in this safety requirement, the caller needs to
guarantee "forget"ing one reference count of the object, because that's
owned by the returned value, see the safety requirement of
`ARef::from_raw()` for more informatoin.

Regards,
Boqun

> +    pub unsafe fn from_raw_opp_owned(ptr: *mut bindings::dev_pm_opp) -> Result<ARef<Self>> {
> +        let ptr = ptr::NonNull::new(ptr).ok_or(ENODEV)?;
> +
> +        // SAFETY: The safety requirements guarantee the validity of the pointer.
> +        Ok(unsafe { ARef::from_raw(ptr.cast()) })
> +    }
> +
> +    /// Creates a reference to a [`OPP`] from a valid pointer.
> +    ///
> +    /// The refcount is not updated by the Rust API unless the returned reference is converted to
> +    /// an ARef object.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller must ensure that `ptr` is valid and remains valid for the duration of 'a.
> +    pub unsafe fn from_raw_opp<'a>(ptr: *mut bindings::dev_pm_opp) -> Result<&'a Self> {
> +        // SAFETY: The caller guarantees that the pointer is not dangling and stays valid for the
> +        // duration of 'a. The cast is okay because `OPP` is `repr(transparent)`.
> +        Ok(unsafe { &*ptr.cast() })
> +    }
> +
> +    #[inline]
> +    fn as_raw(&self) -> *mut bindings::dev_pm_opp {
> +        self.0.get()
> +    }
> +
> +    /// Returns the frequency of an OPP.
> +    pub fn freq(&self, index: Option<u32>) -> u64 {
> +        let index = index.unwrap_or(0);
> +
> +        // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe to
> +        // use it.
> +        unsafe { bindings::dev_pm_opp_get_freq_indexed(self.as_raw(), index) }
> +    }
> +
> +    /// Returns the voltage of an OPP.
> +    pub fn voltage(&self) -> u64 {
> +        // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe to
> +        // use it.
> +        unsafe { bindings::dev_pm_opp_get_voltage(self.as_raw()) }
> +    }
> +
> +    /// Returns the level of an OPP.
> +    pub fn level(&self) -> u32 {
> +        // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe to
> +        // use it.
> +        unsafe { bindings::dev_pm_opp_get_level(self.as_raw()) }
> +    }
> +
> +    /// Returns the power of an OPP.
> +    pub fn power(&self) -> u64 {
> +        // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe to
> +        // use it.
> +        unsafe { bindings::dev_pm_opp_get_power(self.as_raw()) }
> +    }
> +
> +    /// Returns the required pstate of an OPP.
> +    pub fn required_pstate(&self, index: u32) -> u32 {
> +        // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe to
> +        // use it.
> +        unsafe { bindings::dev_pm_opp_get_required_pstate(self.as_raw(), index) }
> +    }
> +
> +    /// Returns true if the OPP is turbo.
> +    pub fn is_turbo(&self) -> bool {
> +        // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe to
> +        // use it.
> +        unsafe { bindings::dev_pm_opp_is_turbo(self.as_raw()) }
> +    }
> +}

