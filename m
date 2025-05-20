Return-Path: <linux-pm+bounces-27391-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19100ABCED9
	for <lists+linux-pm@lfdr.de>; Tue, 20 May 2025 07:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20D161B65A32
	for <lists+linux-pm@lfdr.de>; Tue, 20 May 2025 05:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F2725B69C;
	Tue, 20 May 2025 05:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KGRoEPig"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3DB25B683
	for <linux-pm@vger.kernel.org>; Tue, 20 May 2025 05:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747720753; cv=none; b=gcytcENzyP6uaLdsVIS686Mt4BW2wqYahqXXMCjMuXXmD8MTH3PEOvtqTj0prFy6kRZzQz9DVyhpaniERRnj7vJJynZxDSNRUQeMfo+MR6RWRh+GyZ8Az4lfXvxPpbpm1f9MIWViD9N+kCbIXbQE4e822TXKUGMwrbujJ0KSOdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747720753; c=relaxed/simple;
	bh=WgQt/NdOhSIU1xi7Jn4ra48ZfyEjelVObububfQoscE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P7+S/iFRkURAmbRwOIc/6QVyLFN7h1U/zyGVZNZTf+ulWFPZIs0gE/JDbUxzbArG3+A/dAmw5UbNbGfXwNTMy3XQl2iSnufb5I21fsBDf0N+/wpsg7LQnW3HYHaAan1Ta1pg4+vfeXjAdSqpyPFZfC9OUGfD9TgiXYi77kmuUxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KGRoEPig; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b26c5fd40a9so5015287a12.1
        for <linux-pm@vger.kernel.org>; Mon, 19 May 2025 22:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747720750; x=1748325550; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xGDN7RsU0AmhoEMuH3z6yWpAuea8qIhTa8D9PCAxouU=;
        b=KGRoEPigmidA2kw64BPNRTsfXWdVyJNK2iNBL02Nqh8vL/B5IjzTcuU4/1NYrKST6Z
         AMl8jd9pya0UrAA8oLidxup7cXaELy3zLNVBGcGvKiJ7+mFEphN0p3uSXryK/4AszYpi
         IDW2L8pvvKtHoM+/2T2CgBgI/TiOtveFMrPV0SoVJe007qC5pUB+EBkl5/asV6PWvEUU
         aVaoct9WsTktu7poqGJZ9aIw3jOiay6Hxz5Q4CC3zoXhbQM2AxEq3zdXtdny8zAVbekv
         Qdum8zsETqKveoMHSTMR0D25K/dJIys51Z2tRxbNLtiDl8PrvCU2ay6T2VV4ADnIsDVw
         CNbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747720750; x=1748325550;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xGDN7RsU0AmhoEMuH3z6yWpAuea8qIhTa8D9PCAxouU=;
        b=tj1aGiylZ5LhEM8A/sgWXEqKsUOm2P+3uP6cF/K3K+cNiCMcL4rLts2SDFxQ+s9pQo
         MnXa7CdPYWhxqbz/ESkX2uTTgUmGVonEIoGojDDs/uTa/IKguYGCthENfcTvlXOE7FR7
         3H8RmY2WqYMu3IsZf7qZQLMdXyqQzs0lZl3vaFhd+YUTDI5WuQ/XBsSsZBQvSrJi3pkW
         bFE0TcE04xA+kSX5kbXYYKcCKRZ2gKlCOQyvrJLB9nvTua9rIbmtKGNwQ73BdsOTy2Ee
         AcvSb/EIkZGQiYyKvE+9/flJ6CSh8nqPbPBBXhCSgXx0Pf07Sb8wX3aZOc/hPzX23z/z
         zhpg==
X-Forwarded-Encrypted: i=1; AJvYcCWFna1YgRmiRRDx+ezpxrvyLyomzcbXdEJpEOcp4sX1dEE5nm/jeHXvu6EyDtgJDJEvSNH3AFsGZA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwSi++AiqFMwXczDTl4qJTHScj9M9O4JcWsJNRGmOVBzqMAUWHR
	cspcbEEDrytfMsQXWJ8jk9D7JX9mvXInHc8gy7lvLa05JHJGj1QzjpkFpt7UryetYPI=
X-Gm-Gg: ASbGncuIwYfHBJN6SCDmcAgtYHmAeWxHkpCu2MIBjjoAJzCQ/+LCKjXfv0lSbw+sKkN
	UwSn98eYtuoMcHLxNEq+O769uzTeWW769jhkVPSrRipf7S0Ozbw7O01x56x+iEKzKOlG/h6Uk03
	yQlQ0ZZ3CIe26QYM/nLoFIczYXEt1rp6LK+f+fykD/oru7MdshD2gwCKer4MbVow/U5hLycAWml
	Il4quBO6GEjwW47U82RY8KX+2jgUgsJ+207NPX88EPNteXLmHDhRW+rEM43zfD0Pd5t2+JtG6vq
	Fgb+RKUMmlRbsOYieNrjj72faaTeqbwcDXzLwKg+zGAx4XL248KY+rlG+M5EQrA=
X-Google-Smtp-Source: AGHT+IFiV7Fe9GVj0sSXj3s9kdHd15yQlXWOmLw4nLqvS3v/wHyIG1QFKAgoblC6foD/Y6gSUtdV2A==
X-Received: by 2002:a17:902:ce90:b0:232:5d3:aa73 with SMTP id d9443c01a7336-23205d3ae44mr167529595ad.13.1747720749649;
        Mon, 19 May 2025 22:59:09 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231f304a55fsm58639815ad.93.2025.05.19.22.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 22:59:09 -0700 (PDT)
Date: Tue, 20 May 2025 11:29:06 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Danilo Krummrich <dakr@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	linux-pm@vger.kernel.org,
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
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V12 13/15] rust: cpufreq: Extend abstractions for driver
 registration
Message-ID: <20250520055906.fxdbow2646gpyax2@vireshk-i7>
References: <cover.1747634382.git.viresh.kumar@linaro.org>
 <68906d67109c3b323b54469fb1ee44e10c1c5b1e.1747634382.git.viresh.kumar@linaro.org>
 <aCsQylyW7R5rC15m@pollux>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCsQylyW7R5rC15m@pollux>

On 19-05-25, 13:06, Danilo Krummrich wrote:
> Sorry, I didn't catch the above in my previous review -- fine for me if you do
> those improvements in a subsequent patch.

That's fine. Thanks a lot for reviewing the series.

-- 
viresh

diff --git a/drivers/cpufreq/rcpufreq_dt.rs b/drivers/cpufreq/rcpufreq_dt.rs
index d0e60b7db81f..94ed81644fe1 100644
--- a/drivers/cpufreq/rcpufreq_dt.rs
+++ b/drivers/cpufreq/rcpufreq_dt.rs
@@ -152,30 +152,30 @@ fn init(policy: &mut cpufreq::Policy) -> Result<Self::PData> {
         )?)
     }
 
-    fn exit(_policy: &mut cpufreq::Policy, _data: Option<Self::PData>) -> Result<()> {
+    fn exit(_policy: &mut cpufreq::Policy, _data: Option<Self::PData>) -> Result {
         Ok(())
     }
 
-    fn online(_policy: &mut cpufreq::Policy) -> Result<()> {
+    fn online(_policy: &mut cpufreq::Policy) -> Result {
         // We did light-weight tear down earlier, nothing to do here.
         Ok(())
     }
 
-    fn offline(_policy: &mut cpufreq::Policy) -> Result<()> {
+    fn offline(_policy: &mut cpufreq::Policy) -> Result {
         // Preserve policy->data and don't free resources on light-weight
         // tear down.
         Ok(())
     }
 
-    fn suspend(policy: &mut cpufreq::Policy) -> Result<()> {
+    fn suspend(policy: &mut cpufreq::Policy) -> Result {
         policy.generic_suspend()
     }
 
-    fn verify(data: &mut cpufreq::PolicyData) -> Result<()> {
+    fn verify(data: &mut cpufreq::PolicyData) -> Result {
         data.generic_verify()
     }
 
-    fn target_index(policy: &mut cpufreq::Policy, index: cpufreq::TableIndex) -> Result<()> {
+    fn target_index(policy: &mut cpufreq::Policy, index: cpufreq::TableIndex) -> Result {
         let Some(data) = policy.data::<Self::PData>() else {
             return Err(ENOENT);
         };
@@ -188,7 +188,7 @@ fn get(policy: &mut cpufreq::Policy) -> Result<u32> {
         policy.generic_get()
     }
 
-    fn set_boost(_policy: &mut cpufreq::Policy, _state: i32) -> Result<()> {
+    fn set_boost(_policy: &mut cpufreq::Policy, _state: i32) -> Result {
         Ok(())
     }
 
@@ -213,10 +213,7 @@ fn probe(
         _id_info: Option<&Self::IdInfo>,
     ) -> Result<Pin<KBox<Self>>> {
         cpufreq::Registration::<CPUFreqDTDriver>::new_foreign_owned(pdev.as_ref())?;
-
-        let drvdata = KBox::new(Self {}, GFP_KERNEL)?;
-
-        Ok(drvdata.into())
+        Ok(KBox::new(Self {}, GFP_KERNEL)?.into())
     }
 }
 
diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
index 826710c4f4b0..09b856bb297b 100644
--- a/rust/kernel/cpufreq.rs
+++ b/rust/kernel/cpufreq.rs
@@ -154,7 +154,7 @@ pub fn as_raw(&self) -> *mut bindings::cpufreq_policy_data {
 
     /// Wrapper for `cpufreq_generic_frequency_table_verify`.
     #[inline]
-    pub fn generic_verify(&self) -> Result<()> {
+    pub fn generic_verify(&self) -> Result {
         // SAFETY: By the type invariant, the pointer stored in `self` is valid.
         to_result(unsafe { bindings::cpufreq_generic_frequency_table_verify(self.as_raw()) })
     }
@@ -208,15 +208,16 @@ fn from(index: TableIndex) -> Self {
 /// ```
 /// use kernel::cpufreq::{Policy, TableIndex};
 ///
-/// fn show_freq(policy: &Policy) {
-///     let table = policy.freq_table().unwrap();
+/// fn show_freq(policy: &Policy) -> Result {
+///     let table = policy.freq_table()?;
 ///
 ///     // SAFETY: Index is a valid entry in the table.
 ///     let index = unsafe { TableIndex::new(0) };
 ///
-///     pr_info!("The frequency at index 0 is: {:?}\n", table.freq(index).unwrap());
+///     pr_info!("The frequency at index 0 is: {:?}\n", table.freq(index)?);
 ///     pr_info!("The flags at index 0 is: {}\n", table.flags(index));
 ///     pr_info!("The data at index 0 is: {}\n", table.data(index));
+///     Ok(())
 /// }
 /// ```
 #[repr(transparent)]
@@ -361,7 +362,7 @@ pub fn new() -> Self {
     }
 
     /// Adds a new entry to the table.
-    pub fn add(&mut self, freq: Hertz, flags: u32, driver_data: u32) -> Result<()> {
+    pub fn add(&mut self, freq: Hertz, flags: u32, driver_data: u32) -> Result {
         // Adds the new entry at the end of the vector.
         Ok(self.entries.push(
             bindings::cpufreq_frequency_table {
@@ -515,7 +516,7 @@ pub fn set_suspend_freq(&mut self, freq: Hertz) -> &mut Self {
 
     /// Provides a wrapper to the generic suspend routine.
     #[inline]
-    pub fn generic_suspend(&mut self) -> Result<()> {
+    pub fn generic_suspend(&mut self) -> Result {
         // SAFETY: By the type invariant, the pointer stored in `self` is valid.
         to_result(unsafe { bindings::cpufreq_generic_suspend(self.as_mut_ref()) })
     }
@@ -643,7 +644,7 @@ pub fn data<T: ForeignOwnable>(&mut self) -> Option<<T>::Borrowed<'_>> {
     /// # Errors
     ///
     /// Returns `EBUSY` if private data is already set.
-    fn set_data<T: ForeignOwnable>(&mut self, data: T) -> Result<()> {
+    fn set_data<T: ForeignOwnable>(&mut self, data: T) -> Result {
         if self.as_ref().driver_data.is_null() {
             // Transfer the ownership of the data to the foreign interface.
             self.as_mut_ref().driver_data = <T as ForeignOwnable>::into_foreign(data) as _;
@@ -736,27 +737,27 @@ pub trait Driver {
     fn init(policy: &mut Policy) -> Result<Self::PData>;
 
     /// Driver's `exit` callback.
-    fn exit(_policy: &mut Policy, _data: Option<Self::PData>) -> Result<()> {
+    fn exit(_policy: &mut Policy, _data: Option<Self::PData>) -> Result {
         build_error!(VTABLE_DEFAULT_ERROR)
     }
 
     /// Driver's `online` callback.
-    fn online(_policy: &mut Policy) -> Result<()> {
+    fn online(_policy: &mut Policy) -> Result {
         build_error!(VTABLE_DEFAULT_ERROR)
     }
 
     /// Driver's `offline` callback.
-    fn offline(_policy: &mut Policy) -> Result<()> {
+    fn offline(_policy: &mut Policy) -> Result {
         build_error!(VTABLE_DEFAULT_ERROR)
     }
 
     /// Driver's `suspend` callback.
-    fn suspend(_policy: &mut Policy) -> Result<()> {
+    fn suspend(_policy: &mut Policy) -> Result {
         build_error!(VTABLE_DEFAULT_ERROR)
     }
 
     /// Driver's `resume` callback.
-    fn resume(_policy: &mut Policy) -> Result<()> {
+    fn resume(_policy: &mut Policy) -> Result {
         build_error!(VTABLE_DEFAULT_ERROR)
     }
 
@@ -766,20 +767,20 @@ fn ready(_policy: &mut Policy) {
     }
 
     /// Driver's `verify` callback.
-    fn verify(data: &mut PolicyData) -> Result<()>;
+    fn verify(data: &mut PolicyData) -> Result;
 
     /// Driver's `setpolicy` callback.
-    fn setpolicy(_policy: &mut Policy) -> Result<()> {
+    fn setpolicy(_policy: &mut Policy) -> Result {
         build_error!(VTABLE_DEFAULT_ERROR)
     }
 
     /// Driver's `target` callback.
-    fn target(_policy: &mut Policy, _target_freq: u32, _relation: Relation) -> Result<()> {
+    fn target(_policy: &mut Policy, _target_freq: u32, _relation: Relation) -> Result {
         build_error!(VTABLE_DEFAULT_ERROR)
     }
 
     /// Driver's `target_index` callback.
-    fn target_index(_policy: &mut Policy, _index: TableIndex) -> Result<()> {
+    fn target_index(_policy: &mut Policy, _index: TableIndex) -> Result {
         build_error!(VTABLE_DEFAULT_ERROR)
     }
 
@@ -799,7 +800,7 @@ fn get_intermediate(_policy: &mut Policy, _index: TableIndex) -> u32 {
     }
 
     /// Driver's `target_intermediate` callback.
-    fn target_intermediate(_policy: &mut Policy, _index: TableIndex) -> Result<()> {
+    fn target_intermediate(_policy: &mut Policy, _index: TableIndex) -> Result {
         build_error!(VTABLE_DEFAULT_ERROR)
     }
 
@@ -814,12 +815,12 @@ fn update_limits(_policy: &mut Policy) {
     }
 
     /// Driver's `bios_limit` callback.
-    fn bios_limit(_policy: &mut Policy, _limit: &mut u32) -> Result<()> {
+    fn bios_limit(_policy: &mut Policy, _limit: &mut u32) -> Result {
         build_error!(VTABLE_DEFAULT_ERROR)
     }
 
     /// Driver's `set_boost` callback.
-    fn set_boost(_policy: &mut Policy, _state: i32) -> Result<()> {
+    fn set_boost(_policy: &mut Policy, _state: i32) -> Result {
         build_error!(VTABLE_DEFAULT_ERROR)
     }
 
@@ -837,43 +838,44 @@ fn register_em(_policy: &mut Policy) {
 ///
 /// ```
 /// use kernel::{
-///     cpu, cpufreq,
+///     cpufreq,
 ///     c_str,
-///     device::{Bound, Device},
+///     device::{Core, Device},
 ///     macros::vtable,
+///     of, platform,
 ///     sync::Arc,
 /// };
-/// struct FooDevice;
+/// struct SampleDevice;
 ///
 /// #[derive(Default)]
-/// struct FooDriver;
+/// struct SampleDriver;
 ///
 /// #[vtable]
-/// impl cpufreq::Driver for FooDriver {
-///     const NAME: &'static CStr = c_str!("cpufreq-foo");
+/// impl cpufreq::Driver for SampleDriver {
+///     const NAME: &'static CStr = c_str!("cpufreq-sample");
 ///     const FLAGS: u16 = cpufreq::flags::NEED_INITIAL_FREQ_CHECK | cpufreq::flags::IS_COOLING_DEV;
 ///     const BOOST_ENABLED: bool = true;
 ///
-///     type PData = Arc<FooDevice>;
+///     type PData = Arc<SampleDevice>;
 ///
 ///     fn init(policy: &mut cpufreq::Policy) -> Result<Self::PData> {
 ///         // Initialize here
-///         Ok(Arc::new(FooDevice, GFP_KERNEL)?)
+///         Ok(Arc::new(SampleDevice, GFP_KERNEL)?)
 ///     }
 ///
-///     fn exit(_policy: &mut cpufreq::Policy, _data: Option<Self::PData>) -> Result<()> {
+///     fn exit(_policy: &mut cpufreq::Policy, _data: Option<Self::PData>) -> Result {
 ///         Ok(())
 ///     }
 ///
-///     fn suspend(policy: &mut cpufreq::Policy) -> Result<()> {
+///     fn suspend(policy: &mut cpufreq::Policy) -> Result {
 ///         policy.generic_suspend()
 ///     }
 ///
-///     fn verify(data: &mut cpufreq::PolicyData) -> Result<()> {
+///     fn verify(data: &mut cpufreq::PolicyData) -> Result {
 ///         data.generic_verify()
 ///     }
 ///
-///     fn target_index(policy: &mut cpufreq::Policy, index: cpufreq::TableIndex) -> Result<()> {
+///     fn target_index(policy: &mut cpufreq::Policy, index: cpufreq::TableIndex) -> Result {
 ///         // Update CPU frequency
 ///         Ok(())
 ///     }
@@ -883,8 +885,17 @@ fn register_em(_policy: &mut Policy) {
 ///     }
 /// }
 ///
-/// fn foo_probe(dev: &Device<Bound>) {
-///     cpufreq::Registration::<FooDriver>::new_foreign_owned(dev).unwrap();
+/// impl platform::Driver for SampleDriver {
+///     type IdInfo = ();
+///     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = None;
+///
+///     fn probe(
+///         pdev: &platform::Device<Core>,
+///         _id_info: Option<&Self::IdInfo>,
+///     ) -> Result<Pin<KBox<Self>>> {
+///         cpufreq::Registration::<SampleDriver>::new_foreign_owned(pdev.as_ref())?;
+///         Ok(KBox::new(Self {}, GFP_KERNEL)?.into())
+///     }
 /// }
 /// ```
 #[repr(transparent)]
@@ -1035,7 +1046,7 @@ pub fn new() -> Result<Self> {
     ///
     /// Instead the [`Registration`] is owned by [`Devres`] and will be revoked / dropped, once the
     /// device is detached.
-    pub fn new_foreign_owned(dev: &Device<Bound>) -> Result<()> {
+    pub fn new_foreign_owned(dev: &Device<Bound>) -> Result {
         Devres::new_foreign_owned(dev, Self::new()?, GFP_KERNEL)
     }
 }
diff --git a/rust/kernel/opp.rs b/rust/kernel/opp.rs
index 1e5fd9887b3a..212555dacd45 100644
--- a/rust/kernel/opp.rs
+++ b/rust/kernel/opp.rs
@@ -292,7 +292,7 @@ pub enum SearchType {
 pub trait ConfigOps {
     /// This is typically used to scale clocks when transitioning between OPPs.
     #[inline]
-    fn config_clks(_dev: &Device, _table: &Table, _opp: &OPP, _scaling_down: bool) -> Result<()> {
+    fn config_clks(_dev: &Device, _table: &Table, _opp: &OPP, _scaling_down: bool) -> Result {
         build_error!(VTABLE_DEFAULT_ERROR)
     }
 
@@ -304,7 +304,7 @@ fn config_regulators(
         _opp_new: &OPP,
         _data: *mut *mut bindings::regulator,
         _count: u32,
-    ) -> Result<()> {
+    ) -> Result {
         build_error!(VTABLE_DEFAULT_ERROR)
     }
 }
@@ -753,7 +753,7 @@ pub fn suspend_freq(&self) -> Hertz {
 
     /// Synchronizes regulators used by the [`Table`].
     #[inline]
-    pub fn sync_regulators(&self) -> Result<()> {
+    pub fn sync_regulators(&self) -> Result {
         // SAFETY: The requirements are satisfied by the existence of [`Device`] and its safety
         // requirements.
         to_result(unsafe { bindings::dev_pm_opp_sync_regulators(self.dev.as_raw()) })
@@ -761,14 +761,14 @@ pub fn sync_regulators(&self) -> Result<()> {
 
     /// Gets sharing CPUs.
     #[inline]
-    pub fn sharing_cpus(dev: &Device, cpumask: &mut Cpumask) -> Result<()> {
+    pub fn sharing_cpus(dev: &Device, cpumask: &mut Cpumask) -> Result {
         // SAFETY: The requirements are satisfied by the existence of [`Device`] and its safety
         // requirements.
         to_result(unsafe { bindings::dev_pm_opp_get_sharing_cpus(dev.as_raw(), cpumask.as_raw()) })
     }
 
     /// Sets sharing CPUs.
-    pub fn set_sharing_cpus(&mut self, cpumask: &mut Cpumask) -> Result<()> {
+    pub fn set_sharing_cpus(&mut self, cpumask: &mut Cpumask) -> Result {
         // SAFETY: The requirements are satisfied by the existence of [`Device`] and its safety
         // requirements.
         to_result(unsafe {
@@ -786,7 +786,7 @@ pub fn set_sharing_cpus(&mut self, cpumask: &mut Cpumask) -> Result<()> {
     /// Gets sharing CPUs from device tree.
     #[cfg(CONFIG_OF)]
     #[inline]
-    pub fn of_sharing_cpus(dev: &Device, cpumask: &mut Cpumask) -> Result<()> {
+    pub fn of_sharing_cpus(dev: &Device, cpumask: &mut Cpumask) -> Result {
         // SAFETY: The requirements are satisfied by the existence of [`Device`] and its safety
         // requirements.
         to_result(unsafe {
@@ -802,7 +802,7 @@ pub fn adjust_voltage(
         volt: MicroVolt,
         volt_min: MicroVolt,
         volt_max: MicroVolt,
-    ) -> Result<()> {
+    ) -> Result {
         // SAFETY: The requirements are satisfied by the existence of [`Device`] and its safety
         // requirements.
         to_result(unsafe {
@@ -825,7 +825,7 @@ pub fn cpufreq_table(&mut self) -> Result<FreqTable> {
 
     /// Configures device with [`OPP`] matching the frequency value.
     #[inline]
-    pub fn set_rate(&self, freq: Hertz) -> Result<()> {
+    pub fn set_rate(&self, freq: Hertz) -> Result {
         // SAFETY: The requirements are satisfied by the existence of [`Device`] and its safety
         // requirements.
         to_result(unsafe { bindings::dev_pm_opp_set_rate(self.dev.as_raw(), freq.into()) })
@@ -833,7 +833,7 @@ pub fn set_rate(&self, freq: Hertz) -> Result<()> {
 
     /// Configures device with [`OPP`].
     #[inline]
-    pub fn set_opp(&self, opp: &OPP) -> Result<()> {
+    pub fn set_opp(&self, opp: &OPP) -> Result {
         // SAFETY: The requirements are satisfied by the existence of [`Device`] and its safety
         // requirements.
         to_result(unsafe { bindings::dev_pm_opp_set_opp(self.dev.as_raw(), opp.as_raw()) })
@@ -937,7 +937,7 @@ pub fn opp_from_bw(&self, mut bw: u32, index: i32, stype: SearchType) -> Result<
 
     /// Enables the [`OPP`].
     #[inline]
-    pub fn enable_opp(&self, freq: Hertz) -> Result<()> {
+    pub fn enable_opp(&self, freq: Hertz) -> Result {
         // SAFETY: The requirements are satisfied by the existence of [`Device`] and its safety
         // requirements.
         to_result(unsafe { bindings::dev_pm_opp_enable(self.dev.as_raw(), freq.into()) })
@@ -945,7 +945,7 @@ pub fn enable_opp(&self, freq: Hertz) -> Result<()> {
 
     /// Disables the [`OPP`].
     #[inline]
-    pub fn disable_opp(&self, freq: Hertz) -> Result<()> {
+    pub fn disable_opp(&self, freq: Hertz) -> Result {
         // SAFETY: The requirements are satisfied by the existence of [`Device`] and its safety
         // requirements.
         to_result(unsafe { bindings::dev_pm_opp_disable(self.dev.as_raw(), freq.into()) })
@@ -953,7 +953,7 @@ pub fn disable_opp(&self, freq: Hertz) -> Result<()> {
 
     /// Registers with the Energy model.
     #[cfg(CONFIG_OF)]
-    pub fn of_register_em(&mut self, cpumask: &mut Cpumask) -> Result<()> {
+    pub fn of_register_em(&mut self, cpumask: &mut Cpumask) -> Result {
         // SAFETY: The requirements are satisfied by the existence of [`Device`] and its safety
         // requirements.
         to_result(unsafe {
diff --git a/rust/macros/module.rs b/rust/macros/module.rs
index 27cc72d474f0..6ff34096d7ee 100644
--- a/rust/macros/module.rs
+++ b/rust/macros/module.rs
@@ -185,9 +185,9 @@ pub(crate) fn module(ts: TokenStream) -> TokenStream {
 
     let info = ModuleInfo::parse(&mut it);
 
-    /* Rust does not allow hyphens in identifiers, use underscore instead */
-    let name_identifier = info.name.replace('-', "_");
-    let mut modinfo = ModInfoBuilder::new(name_identifier.as_ref());
+    // Rust does not allow hyphens in identifiers, use underscore instead.
+    let ident = info.name.replace('-', "_");
+    let mut modinfo = ModInfoBuilder::new(ident.as_ref());
     if let Some(author) = info.author {
         modinfo.emit("author", &author);
     }
@@ -312,15 +312,15 @@ mod __module_init {{
                     #[doc(hidden)]
                     #[link_section = \"{initcall_section}\"]
                     #[used]
-                    pub static __{name_identifier}_initcall: extern \"C\" fn() ->
-                        kernel::ffi::c_int = __{name_identifier}_init;
+                    pub static __{ident}_initcall: extern \"C\" fn() ->
+                        kernel::ffi::c_int = __{ident}_init;
 
                     #[cfg(not(MODULE))]
                     #[cfg(CONFIG_HAVE_ARCH_PREL32_RELOCATIONS)]
                     core::arch::global_asm!(
                         r#\".section \"{initcall_section}\", \"a\"
-                        __{name_identifier}_initcall:
-                            .long   __{name_identifier}_init - .
+                        __{ident}_initcall:
+                            .long   __{ident}_init - .
                             .previous
                         \"#
                     );
@@ -328,7 +328,7 @@ mod __module_init {{
                     #[cfg(not(MODULE))]
                     #[doc(hidden)]
                     #[no_mangle]
-                    pub extern \"C\" fn __{name_identifier}_init() -> kernel::ffi::c_int {{
+                    pub extern \"C\" fn __{ident}_init() -> kernel::ffi::c_int {{
                         // SAFETY: This function is inaccessible to the outside due to the double
                         // module wrapping it. It is called exactly once by the C side via its
                         // placement above in the initcall section.
@@ -338,12 +338,12 @@ mod __module_init {{
                     #[cfg(not(MODULE))]
                     #[doc(hidden)]
                     #[no_mangle]
-                    pub extern \"C\" fn __{name_identifier}_exit() {{
+                    pub extern \"C\" fn __{ident}_exit() {{
                         // SAFETY:
                         // - This function is inaccessible to the outside due to the double
                         //   module wrapping it. It is called exactly once by the C side via its
                         //   unique name,
-                        // - furthermore it is only called after `__{name_identifier}_init` has
+                        // - furthermore it is only called after `__{ident}_init` has
                         //   returned `0` (which delegates to `__init`).
                         unsafe {{ __exit() }}
                     }}
@@ -384,7 +384,7 @@ unsafe fn __exit() {{
         ",
         type_ = info.type_,
         name = info.name,
-        name_identifier = name_identifier,
+        ident = ident,
         modinfo = modinfo.buffer,
         initcall_section = ".initcall6.init"
     )

