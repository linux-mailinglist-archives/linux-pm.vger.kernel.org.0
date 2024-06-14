Return-Path: <linux-pm+bounces-9142-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D013290839B
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2024 08:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 578471F23786
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2024 06:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E4D148309;
	Fri, 14 Jun 2024 06:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wX2adr7E"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71C71474C4
	for <linux-pm@vger.kernel.org>; Fri, 14 Jun 2024 06:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718346517; cv=none; b=XrZOAxLLg9+ey7qr1grSZW5gBzE1nPErBMlDBssr4op2RrcQ5DHiB9/vdK+6/njF0GUs0Sofrgw+batuiT3OQydtJ8pAiHV2RRrkLbte7BPI7gUfcg7ZXI3MIQtsXqWGseTH0DD6b1rha9mk8CZd0HVPmA+9FeyfwMhwIndnJgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718346517; c=relaxed/simple;
	bh=PS5cem+qRDnvp+e/EOpgrOGaKynV1htId32lFedCazc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RqBc9YRHCaRjUJn2bmVpTN2TX89PAvlGW8nFDeQM2kRBjPrOa5bl4oH3J5YfvMMcyJaNWnCJaVuq4rh/FswY77YVy7brflkh8rT17QYnqNEWk68orJaY+t6yJZ8ED4aeNZa7KRiCRna8wY987Cm+hlGDKiGJgCn6iO+dTJBqlhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wX2adr7E; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-6e41550ae5bso1363812a12.3
        for <linux-pm@vger.kernel.org>; Thu, 13 Jun 2024 23:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718346514; x=1718951314; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=j9YP0QMC7AMbtIpknDppp8RmGp1sowHm9sta2f+DQZg=;
        b=wX2adr7E70nnqKGkxOT9px+UbwF6f6gLPLSVlOa10E7zaFeMKC073dC9y6LjcVZB0S
         7m3N2R/0ITI9SbdXW/g0qHkeytZtlyDtvui67gR0eW2wrAWRNDNRlcUf8nbU7T5lh/BL
         3vTA7PprB5iIlK+3GU+OYEJSilDYo5pX39+UC7xQfZsD1R9+qUyDVNqEI3f1QQkBuAcX
         V4PRthwvSXFQCSL+JJCVCjv/G0wA3mN6h6rd5cxFdWTjUvNIDLS7QdSizy1S6Z9XK5OE
         ygEOgWa4LSQUvkSKN/wDzoaPSBng+Uia9Im/R7Su7tv85K3N1ed2rtjc/GBUWp5ZJ8HF
         LTsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718346514; x=1718951314;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j9YP0QMC7AMbtIpknDppp8RmGp1sowHm9sta2f+DQZg=;
        b=d+EUlwUQPI+yn/6keT+aa+Erk4egxuzP598YoDmlfjCeQ9XOy5wyh9e/BjFJ2NoJJ7
         UDzUonUrjpjxLx8LbT3AKI2/1Akhw+V9jJ9qv9pva0Mi+yTSOXb0VKtw2zPGkEUF/LbR
         Ry8lN2Tl+MO8DqlMfFGCSeipR0PWCSTx/kTkGKkIVHiqklq9tsm6IsvYRf4Q8hSDeFJs
         kuqtGvCztbul5IIRtGHwYPU4QDav5kYyUNncEyqDR/SUmIUw0NHSIhEpxsqNbTxFM3q1
         9wY6xl6kcUWq/y51oaJhcvE0iOAReY4reZnTLgMdgCA82uzi66HskmJMlNPod+0jJ75c
         RhUA==
X-Forwarded-Encrypted: i=1; AJvYcCVnpBXiAcPWOc4+naCwtYLWpNC1MXokk0UsLKkOVehL5ZWOil2e3zqRF7oOhoVYwxoUXCq/12lCuvr69RInTdqm1aUUeBv3f9s=
X-Gm-Message-State: AOJu0YzVXtciNO/05MB0JOtBeWIvPgTlNKBiA/QBNyktZ6IkL3GXp6+R
	w57uqkLWRYm0kZiaBcCQVfkqtxXPquKfmjB9CNHlHlJ1WaE7KhGLaIVADZOsMV0=
X-Google-Smtp-Source: AGHT+IEu0pOnPe4iZ0k7YMgoRcpPg8HzyUQH6rJSlbEe1dKh8Ef4of72JCl6VQTXjVtSAM3r3fr5eg==
X-Received: by 2002:a17:90a:bb04:b0:2c1:aefa:1e7f with SMTP id 98e67ed59e1d1-2c4db13239dmr1942134a91.3.1718346513679;
        Thu, 13 Jun 2024 23:28:33 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c4a75d1d40sm5212891a91.9.2024.06.13.23.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 23:28:33 -0700 (PDT)
Date: Fri, 14 Jun 2024 11:58:30 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>, linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
	rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Erik Schilling <erik.schilling@linaro.org>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH V2 1/8] rust: Add initial bindings for OPP framework
Message-ID: <20240614062830.pfy4v66o7wubekna@vireshk-i7>
References: <cover.1717750631.git.viresh.kumar@linaro.org>
 <e74e3a14e6da3f920cee90d32a023ba4805328a0.1717750631.git.viresh.kumar@linaro.org>
 <CAH5fLgjChZCtTUnHVHJat-sXFyLVE+MgDXrNDiUD0LNsUndpBQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgjChZCtTUnHVHJat-sXFyLVE+MgDXrNDiUD0LNsUndpBQ@mail.gmail.com>

Thanks Alice for reviewing.

On 07-06-24, 12:51, Alice Ryhl wrote:
> > +    /// Removes a dynamically added OPP.
> > +    pub fn remove(dev: ARef<Device>, freq: u64) {
> > +        // SAFETY: The requirements are satisfied by the existence of `Device` and its safety
> > +        // requirements.
> > +        unsafe { bindings::dev_pm_opp_remove(dev.as_raw(), freq) };
> > +    }
> 
> Also, why are these methods defined on OPP when they appear to be
> methods on Device and don't take any OPP argument?

I have changed them slightly to match what they are supposed to look
like and implemented them as method on the data itself.

All other comments are incorporated in the following diff:

diff --git a/rust/kernel/opp.rs b/rust/kernel/opp.rs
new file mode 100644
index 000000000000..b26e39a74635
--- /dev/null
+++ b/rust/kernel/opp.rs
@@ -0,0 +1,182 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Operating performance points.
+//!
+//! This module provides bindings for interacting with the OPP subsystem.
+//!
+//! C header: [`include/linux/pm_opp.h`](srctree/include/linux/pm_opp.h)
+
+use crate::{
+    bindings,
+    device::Device,
+    error::{code::*, to_result, Result},
+    types::{ARef, AlwaysRefCounted, Opaque},
+};
+
+use core::ptr;
+
+/// Dynamically created Operating performance point (OPP).
+pub struct Token {
+    dev: ARef<Device>,
+    freq: u64,
+}
+
+impl Token {
+    /// Adds an OPP dynamically.
+    pub fn new(dev: &ARef<Device>, mut data: Data) -> Result<Self> {
+        // SAFETY: The requirements are satisfied by the existence of `Device` and its safety
+        // requirements.
+        to_result(unsafe { bindings::dev_pm_opp_add_dynamic(dev.as_raw(), &mut data.0) })?;
+        Ok(Self {
+            dev: dev.clone(),
+            freq: data.freq(),
+        })
+    }
+}
+
+impl Drop for Token {
+    fn drop(&mut self) {
+        // SAFETY: The requirements are satisfied by the existence of `Device` and its safety
+        // requirements.
+        unsafe { bindings::dev_pm_opp_remove(self.dev.as_raw(), self.freq) };
+    }
+}
+
+/// Equivalent to `struct dev_pm_opp_data` in the C Code.
+#[repr(transparent)]
+pub struct Data(bindings::dev_pm_opp_data);
+
+impl Data {
+    /// Creates new instance of [`Data`].
+    pub fn new(freq: u64, u_volt: u64, level: u32, turbo: bool) -> Self {
+        Self(bindings::dev_pm_opp_data {
+            turbo,
+            freq,
+            u_volt,
+            level,
+        })
+    }
+
+    /// Adds an OPP dynamically. The OPP is freed once the [`Token`] gets freed.
+    pub fn add_opp(self, dev: &ARef<Device>) -> Result<Token> {
+        Token::new(dev, self)
+    }
+
+    fn freq(&self) -> u64 {
+        self.0.freq
+    }
+}
+
+/// Operating performance point (OPP).
+///
+/// # Invariants
+///
+/// The pointer stored in `Self` is non-null and valid for the lifetime of the ARef instance. In
+/// particular, the ARef instance owns an increment on underlying object’s reference count.
+#[repr(transparent)]
+pub struct OPP(Opaque<bindings::dev_pm_opp>);
+
+// SAFETY: `OPP` only holds a pointer to a C OPP, which is safe to be used from any thread.
+unsafe impl Send for OPP {}
+
+// SAFETY: `OPP` only holds a pointer to a C OPP, references to which are safe to be used from any
+// thread.
+unsafe impl Sync for OPP {}
+
+// SAFETY: The type invariants guarantee that [`OPP`] is always refcounted.
+unsafe impl AlwaysRefCounted for OPP {
+    fn inc_ref(&self) {
+        // SAFETY: The existence of a shared reference means that the refcount is nonzero.
+        unsafe { bindings::dev_pm_opp_get(self.0.get()) };
+    }
+
+    unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
+        // SAFETY: The safety requirements guarantee that the refcount is nonzero.
+        unsafe { bindings::dev_pm_opp_put(obj.cast().as_ptr()) }
+    }
+}
+
+impl OPP {
+    /// Creates a reference to a [`OPP`] from a valid pointer.
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that `ptr` is valid and remains valid for the lifetime of the
+    /// returned [`OPP`] reference.
+    pub unsafe fn from_raw_opp_owned<'a>(ptr: *mut bindings::dev_pm_opp) -> Result<&'a Self> {
+        // SAFETY: The caller guarantees that the pointer is not dangling
+        // and stays valid for the duration of 'a. The cast is okay because
+        // `OPP` is `repr(transparent)`.
+        Ok(unsafe { &*ptr.cast() })
+    }
+
+    /// Creates a reference to a [`OPP`] from a valid pointer.
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that `ptr` is valid and remains valid for the lifetime of the
+    /// returned [`OPP`] reference.
+    pub unsafe fn from_raw_opp<'a>(ptr: *mut bindings::dev_pm_opp) -> Result<&'a Self> {
+        let opp = unsafe { Self::from_raw_opp_owned(ptr) }?;
+
+        // Take an extra reference to the OPP since the caller didn't take it.
+        opp.inc_ref();
+        Ok(opp)
+    }
+
+    #[inline]
+    fn as_raw(&self) -> *mut bindings::dev_pm_opp {
+        self.0.get()
+    }
+
+    /// Returns the frequency of an OPP.
+    pub fn freq(&self, index: Option<u32>) -> u64 {
+        let index = index.unwrap_or(0);
+
+        // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe to
+        // use it.
+        unsafe { bindings::dev_pm_opp_get_freq_indexed(self.as_raw(), index) }
+    }
+
+    /// Returns the voltage of an OPP.
+    pub fn voltage(&self) -> u64 {
+        // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe to
+        // use it.
+        unsafe { bindings::dev_pm_opp_get_voltage(self.as_raw()) }
+    }
+
+    /// Returns the level of an OPP.
+    pub fn level(&self) -> u32 {
+        // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe to
+        // use it.
+        unsafe { bindings::dev_pm_opp_get_level(self.as_raw()) }
+    }
+
+    /// Returns the power of an OPP.
+    pub fn power(&self) -> u64 {
+        // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe to
+        // use it.
+        unsafe { bindings::dev_pm_opp_get_power(self.as_raw()) }
+    }
+
+    /// Returns the required pstate of an OPP.
+    pub fn required_pstate(&self, index: u32) -> u32 {
+        // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe to
+        // use it.
+        unsafe { bindings::dev_pm_opp_get_required_pstate(self.as_raw(), index) }
+    }
+
+    /// Returns true if the OPP is turbo.
+    pub fn is_turbo(&self) -> bool {
+        // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe to
+        // use it.
+        unsafe { bindings::dev_pm_opp_is_turbo(self.as_raw()) }
+    }
+}
+
+impl Drop for OPP {
+    fn drop(&mut self) {
+        // SAFETY: The safety requirements guarantee that the refcount is nonzero.
+        unsafe { bindings::dev_pm_opp_put(self.as_raw()) }
+    }
+}


-- 
viresh

