Return-Path: <linux-pm+bounces-8778-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A0A90018F
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2024 13:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D4471C220A8
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2024 11:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1AA1186E2E;
	Fri,  7 Jun 2024 11:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sx8ROLsc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE77A13D2B2
	for <linux-pm@vger.kernel.org>; Fri,  7 Jun 2024 11:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717758261; cv=none; b=q6qvtpAOxhnLDNm/KdR8tpUPLLssDh58Xm2qJV+xHzhzzPKOFPe/uKqDRLRDoOwAh6T2/rKXPe+FCV1SqU0QNLoI87ZndDklJWjKDgMzBChWcnGGow+D0oAypzitz07t5D9E+awuvRFCARCe9078SqKzqsoJTD25wgtHfRnbaok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717758261; c=relaxed/simple;
	bh=AN/mXFLmmOOxh4ohQqh0I5EZsgTEbPwsV7LU8Ha71SI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=s7IwsCJ2ddaZfB/06T6KiF7+a9PDf1i8JsDhwCMo/20+Z2U+94tonD2wmGSqbDQiVe2K8Yvl8x7OVVu73culdDwTTE5AR1w4tdveM3QkJ+M3a6QMkRgpN4PjCk3+M6O40tCHlNWOBDZ5kAp6/dYTazl34HOP3fZ8Bgj5Dawevf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sx8ROLsc; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42163fa630aso9559345e9.3
        for <linux-pm@vger.kernel.org>; Fri, 07 Jun 2024 04:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717758258; x=1718363058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dlz1M1Q96MoJTbBHiqN6xZFkx4A4jAugPwmqHEAfQlM=;
        b=sx8ROLscim+16/5RnC+EJHtkqutKqN66BekfmIea1CLQhllcXogYZaoxQi8OF/AFFb
         LdpWUCQFpqsnLrV5UlB2nE3NOkXOxvhgnlViZjHiyQxI6wEbEy/RZGJvt3Fc2JixA7gP
         cIy67SSNzLIGMq8jmWLPb1uuYlgiDIOoIXuWzYBT0fVeHMrzeUVNzOS/57nTalCcXOxC
         ti8HfZnqu7yar+kDZ154joNwXa8SWV9heVAVfXVM4rGrBdii1yK2E7+jzIMuDH/G8IeL
         vcrqYUIcv8nrBx8cWUZRRcgVeT1zSM2opxHYaE2AdckFqqpzQe9JxLgYZ4GqD4/BOCXh
         chKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717758258; x=1718363058;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :references:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dlz1M1Q96MoJTbBHiqN6xZFkx4A4jAugPwmqHEAfQlM=;
        b=TYA5hDxSOglCbttVBeFrpOgaD9g3UAVei+qcN3nK2/toSpd9JoxNJiEL+fYooD8PFz
         5sH19X7pr7DA7Kg53BOYGCatIw8H+d94U4wwVcKI1oA8U23OfWk5bfQ499/M1TS6FedZ
         uYg+jb7E3emtf7u0epfFl4ccAAkOk4bR6jBLLRwJOTkzVHegz57SW2AkUv44d71HpHmy
         sF5z48tJ6anaBkPjZEH8g92WAe2lnAuiYymgl1a6BUMF0a0dU9GnWXfrivaVRAt99/xN
         V3JHdvZ4g5HttRAIWKw4p0PBQNJqzUbKXI2ANHzFes/QaDp29404FjGs546dJ+7xUMEl
         l82Q==
X-Forwarded-Encrypted: i=1; AJvYcCXDcBIgDadD/cJNvX8U1WXHR5ExqoABL7PnKHX4aUo2Hl1FYPlsmpoxRmk0LRJ33jKNrGoDOJ74L3gEzgCN0dImJ4iz37HK2Ko=
X-Gm-Message-State: AOJu0YwQH5jEhHPdHIXDFbG0yvp8uom6XiZdmPWh3P/rUb824PgOkeU7
	1D51X+Xyn/ZeEgXt3qvAigkvsVU8N9CVXE/mz4kP1s0PX6MecvZiWuFzn0MJ7Qs=
X-Google-Smtp-Source: AGHT+IHod7WifBUl7WN31uqgwKkQIdjobL7dtcDM7zsUKlmpwG3Nkk+YAZ0yifsUngtlMlKS08HWgA==
X-Received: by 2002:a05:600c:4f8e:b0:41b:f022:8e69 with SMTP id 5b1f17b1804b1-42164a03160mr19707055e9.19.1717758258064;
        Fri, 07 Jun 2024 04:04:18 -0700 (PDT)
Received: from meli-email.org (adsl-105.37.6.1.tellas.gr. [37.6.1.105])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215809fcbesm84707525e9.0.2024.06.07.04.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 04:04:17 -0700 (PDT)
Date: Fri, 07 Jun 2024 13:38:17 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, Bj=?UTF-8?B?w7Y=?= rn Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>, rust-for-linux@vger.kernel.org, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, Erik Schilling <erik.schilling@linaro.org>, Alex Benn=?UTF-8?B?w6k=?= e <alex.bennee@linaro.org>, Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH V2 2/8] rust: Extend OPP bindings for the OPP table
User-Agent: meli 0.8.5
References: <cover.1717750631.git.viresh.kumar@linaro.org> <dc156230814a899e5e3ffb6f3a0e5471d92506de.1717750631.git.viresh.kumar@linaro.org>
In-Reply-To: <dc156230814a899e5e3ffb6f3a0e5471d92506de.1717750631.git.viresh.kumar@linaro.org>
Message-ID: <epir3.2kxc5jzd28c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed

On Fri, 07 Jun 2024 12:12, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>This extends OPP bindings with the bindings for the `struct opp_table`.
>
>Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>---
> rust/kernel/opp.rs | 374 ++++++++++++++++++++++++++++++++++++++++++++-
> 1 file changed, 372 insertions(+), 2 deletions(-)
>
>diff --git a/rust/kernel/opp.rs b/rust/kernel/opp.rs
>index 9e5cf0412ed5..06f36845047f 100644
>--- a/rust/kernel/opp.rs
>+++ b/rust/kernel/opp.rs
>@@ -7,9 +7,9 @@
> //! C header: [`include/linux/pm_opp.h`](../../../../../../include/linux/pm_opp.h)
> 
> use crate::{
>-    bindings,
>+    bindings, cpumask,
>     device::Device,
>-    error::{code::*, to_result, Result},
>+    error::{code::*, from_err_ptr, to_result, Error, Result},
>     types::{ARef, AlwaysRefCounted, Opaque},
> };
> 
>@@ -31,6 +31,376 @@ pub fn new(freq: u64, u_volt: u64, level: u32, turbo: bool) -> Self {
>     }
> }
> 
>+/// OPP search types.
>+#[derive(Copy, Clone, Debug, Eq, PartialEq)]
>+pub enum SearchType {
>+    /// Search for exact value.
>+    Exact,
>+    /// Search for highest value less than equal to value.
>+    Floor,
>+    /// Search for lowest value greater than equal to value.
>+    Ceil,
>+}

Seeing this enum made me think about memory layouts which are not stable 
in Rust and can change between compilations unless they have a specific 
`repr`.

Not related to this series directly, has there been discussion about 
guaranteeing struct layouts in kernel APIs? It'd require a lot of things 
to happen to cause a problem (multiple users of an API in the kernel in 
separate compilation units maybe even compiled with different rustc 
versions).

>+
>+/// Operating performance point (OPP) table.
>+///
>+/// # Invariants
>+///
>+/// The pointer stored in `Self` is non-null and valid for the lifetime of the ARef instance. In
>+/// particular, the ARef instance owns an increment on underlying object’s reference count.
>+pub struct Table {
>+    ptr: *mut bindings::opp_table,
>+    dev: ARef<Device>,
>+    em: bool,
>+    of: bool,
>+    cpumask: Option<cpumask::Cpumask>,
>+}
>+
>+// SAFETY: The fields of `Table` are safe to be used from any thread.
>+unsafe impl Send for Table {}
>+
>+// SAFETY: The fields of `Table` are safe to be referenced from any thread.
>+unsafe impl Sync for Table {}
>+
>+impl Table {
>+    /// Creates a new OPP table instance from raw pointer.
>+    ///
>+    /// # Safety
>+    ///
>+    /// Callers must ensure that `ptr` is valid and non-null.
>+    unsafe fn from_ptr(ptr: *mut bindings::opp_table, dev: ARef<Device>) -> Self {
>+        // SAFETY: By the safety requirements, ptr is valid and its refcount will be incremented.
>+        unsafe { bindings::dev_pm_opp_get_opp_table_ref(ptr) };
>+
>+        Self {
>+            ptr,
>+            dev,
>+            em: false,
>+            of: false,
>+            cpumask: None,
>+        }
>+    }
>+
>+    /// Find OPP table from device.
>+    pub fn from_dev(dev: ARef<Device>) -> Result<Self> {
>+        // SAFETY: The requirements are satisfied by the existence of `Device` and its safety
>+        // requirements. Refcount of the OPP table is incremented as well.
>+        let ptr = from_err_ptr(unsafe { bindings::dev_pm_opp_get_opp_table(dev.as_raw()) })?;
>+
>+        Ok(Self {
>+            ptr,
>+            dev: dev.clone(),

Clone is not probably not needed here, right? the argument value will be 
dropped after this.

>+            em: false,
>+            of: false,
>+            cpumask: None,
>+        })
>+    }
>+
>+    /// Add device tree based OPP table for the device.
>+    #[cfg(CONFIG_OF)]
>+    pub fn from_of(dev: ARef<Device>, index: i32) -> Result<Self> {
>+        // SAFETY: The requirements are satisfied by the existence of `Device` and its safety
>+        // requirements. Refcount of the OPP table is incremented as well.
>+        to_result(unsafe { bindings::dev_pm_opp_of_add_table_indexed(dev.as_raw(), index) })?;
>+
>+        // Fetch the newly created table.
>+        let mut table = Self::from_dev(dev)?;
>+        table.of = true;
>+
>+        Ok(table)
>+    }
>+
>+    // Remove device tree based OPP table for the device.
>+    #[cfg(CONFIG_OF)]
>+    fn remove_of(&self) {
>+        // SAFETY: The requirements are satisfied by the existence of `Device` and its safety
>+        // requirements. We took the reference from `from_of` earlier, it is safe to drop the same
>+        // now.
>+        unsafe { bindings::dev_pm_opp_of_remove_table(self.dev.as_raw()) };
>+    }
>+
>+    /// Add device tree based OPP table for CPU devices.
>+    #[cfg(CONFIG_OF)]
>+    pub fn from_of_cpumask(dev: ARef<Device>, cpumask: &mut cpumask::Cpumask) -> Result<Self> {
>+        // SAFETY: The cpumask is valid and the returned ptr will be owned by the [`Table`] instance.
>+        to_result(unsafe { bindings::dev_pm_opp_of_cpumask_add_table(cpumask.as_ptr()) })?;
>+
>+        // Fetch the newly created table.
>+        let mut table = Self::from_dev(dev)?;
>+        // SAFETY: The `cpumask` is guaranteed by the C code to be valid.
>+        table.cpumask = Some(unsafe { cpumask::Cpumask::new(cpumask.as_mut_ptr()) });
>+
>+        Ok(table)
>+    }
>+
>+    // Remove device tree based OPP table for CPU devices.
>+    #[cfg(CONFIG_OF)]
>+    fn remove_of_cpumask(&self, cpumask: &cpumask::Cpumask) {
>+        // SAFETY: The cpumask is valid and we took the reference from `from_of_cpumask` earlier,
>+        // it is safe to drop the same now.
>+        unsafe { bindings::dev_pm_opp_of_cpumask_remove_table(cpumask.as_ptr()) };
>+    }
>+
>+    /// Returns the number of OPPs in the table.
>+    pub fn opp_count(&self) -> Result<u32> {
>+        // SAFETY: The requirements are satisfied by the existence of `Device` and its safety
>+        // requirements.
>+        let ret = unsafe { bindings::dev_pm_opp_get_opp_count(self.dev.as_raw()) };
>+        if ret < 0 {
>+            Err(Error::from_errno(ret))
>+        } else {
>+            Ok(ret as u32)
>+        }
>+    }
>+
>+    /// Returns max clock latency of the OPPs in the table.
>+    pub fn max_clock_latency(&self) -> u64 {
>+        // SAFETY: The requirements are satisfied by the existence of `Device` and its safety
>+        // requirements.
>+        unsafe { bindings::dev_pm_opp_get_max_clock_latency(self.dev.as_raw()) }
>+    }
>+
>+    /// Returns max volt latency of the OPPs in the table.
>+    pub fn max_volt_latency(&self) -> u64 {
>+        // SAFETY: The requirements are satisfied by the existence of `Device` and its safety
>+        // requirements.
>+        unsafe { bindings::dev_pm_opp_get_max_volt_latency(self.dev.as_raw()) }
>+    }
>+
>+    /// Returns max transition latency of the OPPs in the table.
>+    pub fn max_transition_latency(&self) -> u64 {
>+        // SAFETY: The requirements are satisfied by the existence of `Device` and its safety
>+        // requirements.
>+        unsafe { bindings::dev_pm_opp_get_max_transition_latency(self.dev.as_raw()) }
>+    }
>+
>+    /// Returns the suspend OPP.
>+    pub fn suspend_freq(&self) -> u64 {
>+        // SAFETY: The requirements are satisfied by the existence of `Device` and its safety
>+        // requirements.
>+        unsafe { bindings::dev_pm_opp_get_suspend_opp_freq(self.dev.as_raw()) }
>+    }
>+
>+    /// Synchronizes regulators used by the OPP table.
>+    pub fn sync_regulators(&self) -> Result<()> {
>+        // SAFETY: The requirements are satisfied by the existence of `Device` and its safety
>+        // requirements.
>+        to_result(unsafe { bindings::dev_pm_opp_sync_regulators(self.dev.as_raw()) })
>+    }
>+
>+    /// Gets sharing CPUs.
>+    pub fn sharing_cpus(dev: ARef<Device>, cpumask: &mut cpumask::Cpumask) -> Result<()> {
>+        // SAFETY: The requirements are satisfied by the existence of `Device` and its safety
>+        // requirements.
>+        to_result(unsafe {
>+            bindings::dev_pm_opp_get_sharing_cpus(dev.as_raw(), cpumask.as_mut_ptr())
>+        })
>+    }
>+
>+    /// Sets sharing CPUs.
>+    pub fn set_sharing_cpus(&self, cpumask: &cpumask::Cpumask) -> Result<()> {
>+        // SAFETY: The requirements are satisfied by the existence of `Device` and its safety
>+        // requirements.
>+        to_result(unsafe {
>+            bindings::dev_pm_opp_set_sharing_cpus(self.dev.as_raw(), cpumask.as_ptr())
>+        })
>+    }
>+
>+    /// Gets sharing CPUs from Device tree.
>+    #[cfg(CONFIG_OF)]
>+    pub fn of_sharing_cpus(dev: ARef<Device>, cpumask: &mut cpumask::Cpumask) -> Result<()> {
>+        // SAFETY: The requirements are satisfied by the existence of `Device` and its safety
>+        // requirements.
>+        to_result(unsafe {
>+            bindings::dev_pm_opp_of_get_sharing_cpus(dev.as_raw(), cpumask.as_mut_ptr())
>+        })
>+    }
>+
>+    /// Updates the voltage value for an OPP.
>+    pub fn adjust_voltage(
>+        &self,
>+        freq: u64,
>+        u_volt: u64,
>+        u_volt_min: u64,
>+        u_volt_max: u64,
>+    ) -> Result<()> {
>+        // SAFETY: The requirements are satisfied by the existence of `Device` and its safety
>+        // requirements.
>+        to_result(unsafe {
>+            bindings::dev_pm_opp_adjust_voltage(
>+                self.dev.as_raw(),
>+                freq,
>+                u_volt,
>+                u_volt_min,
>+                u_volt_max,
>+            )
>+        })
>+    }
>+
>+    /// Sets a matching OPP based on frequency.
>+    pub fn set_rate(&self, freq: u64) -> Result<()> {
>+        // SAFETY: The requirements are satisfied by the existence of `Device` and its safety
>+        // requirements.
>+        to_result(unsafe { bindings::dev_pm_opp_set_rate(self.dev.as_raw(), freq) })
>+    }
>+
>+    /// Sets exact OPP.
>+    pub fn set_opp(&self, opp: ARef<OPP>) -> Result<()> {
>+        // SAFETY: The requirements are satisfied by the existence of `Device` and its safety
>+        // requirements.
>+        to_result(unsafe { bindings::dev_pm_opp_set_opp(self.dev.as_raw(), opp.as_mut_ptr()) })
>+    }
>+
>+    /// Finds OPP based on frequency.
>+    pub fn opp_from_freq(
>+        &self,
>+        mut freq: u64,
>+        available: Option<bool>,
>+        index: Option<u32>,
>+        stype: SearchType,
>+    ) -> Result<ARef<OPP>> {
>+        let rdev = self.dev.as_raw();
>+        let index = index.unwrap_or(0);
>+
>+        let ptr = from_err_ptr(match stype {
>+            SearchType::Exact => {
>+                if let Some(available) = available {
>+                    // SAFETY: The requirements are satisfied by the existence of `Device` and
>+                    // its safety requirements. The returned ptr will be owned by the new [`OPP`]
>+                    // instance.
>+                    unsafe {
>+                        bindings::dev_pm_opp_find_freq_exact_indexed(rdev, freq, index, available)
>+                    }
>+                } else {
>+                    return Err(EINVAL);
>+                }
>+            }
>+
>+            // SAFETY: The requirements are satisfied by the existence of `Device` and its
>+            // safety requirements. The returned ptr will be owned by the new [`OPP`] instance.
>+            SearchType::Ceil => unsafe {
>+                bindings::dev_pm_opp_find_freq_ceil_indexed(rdev, &mut freq as *mut u64, index)
>+            },
>+
>+            // SAFETY: The requirements are satisfied by the existence of `Device` and its
>+            // safety requirements. The returned ptr will be owned by the new [`OPP`] instance.
>+            SearchType::Floor => unsafe {
>+                bindings::dev_pm_opp_find_freq_floor_indexed(rdev, &mut freq as *mut u64, index)
>+            },
>+        })?;
>+
>+        // SAFETY: The `ptr` is guaranteed by the C code to be valid.
>+        unsafe { OPP::from_ptr_owned(ptr) }
>+    }
>+
>+    /// Finds OPP based on level.
>+    pub fn opp_from_level(&self, mut level: u32, stype: SearchType) -> Result<ARef<OPP>> {
>+        let rdev = self.dev.as_raw();
>+
>+        let ptr = from_err_ptr(match stype {
>+            // SAFETY: The requirements are satisfied by the existence of `Device` and its
>+            // safety requirements. The returned ptr will be owned by the new [`OPP`] instance.
>+            SearchType::Exact => unsafe { bindings::dev_pm_opp_find_level_exact(rdev, level) },
>+

Minor style comment, the empty lines between match patterns are unusual

>+            // SAFETY: The requirements are satisfied by the existence of `Device` and its
>+            // safety requirements. The returned ptr will be owned by the new [`OPP`] instance.
>+            SearchType::Ceil => unsafe {
>+                bindings::dev_pm_opp_find_level_ceil(rdev, &mut level as *mut u32)
>+            },
>+
>+            // SAFETY: The requirements are satisfied by the existence of `Device` and its
>+            // safety requirements. The returned ptr will be owned by the new [`OPP`] instance.
>+            SearchType::Floor => unsafe {
>+                bindings::dev_pm_opp_find_level_floor(rdev, &mut level as *mut u32)
>+            },
>+        })?;
>+
>+        // SAFETY: The `ptr` is guaranteed by the C code to be valid.
>+        unsafe { OPP::from_ptr_owned(ptr) }
>+    }
>+
>+    /// Finds OPP based on bandwidth.
>+    pub fn opp_from_bw(&self, mut bw: u32, index: i32, stype: SearchType) -> Result<ARef<OPP>> {
>+        let rdev = self.dev.as_raw();
>+
>+        let ptr = from_err_ptr(match stype {
>+            // The OPP core doesn't support this yet.
>+            SearchType::Exact => return Err(EINVAL),
>+
>+            // SAFETY: The requirements are satisfied by the existence of `Device` and its
>+            // safety requirements. The returned ptr will be owned by the new [`OPP`] instance.
>+            SearchType::Ceil => unsafe {
>+                bindings::dev_pm_opp_find_bw_ceil(rdev, &mut bw as *mut u32, index)
>+            },
>+
>+            // SAFETY: The requirements are satisfied by the existence of `Device` and its
>+            // safety requirements. The returned ptr will be owned by the new [`OPP`] instance.
>+            SearchType::Floor => unsafe {
>+                bindings::dev_pm_opp_find_bw_floor(rdev, &mut bw as *mut u32, index)
>+            },
>+        })?;
>+
>+        // SAFETY: The `ptr` is guaranteed by the C code to be valid.
>+        unsafe { OPP::from_ptr_owned(ptr) }
>+    }
>+
>+    /// Enable the OPP.
>+    pub fn enable_opp(&self, freq: u64) -> Result<()> {
>+        // SAFETY: The requirements are satisfied by the existence of `Device` and its safety
>+        // requirements.
>+        to_result(unsafe { bindings::dev_pm_opp_enable(self.dev.as_raw(), freq) })
>+    }
>+
>+    /// Disable the OPP.
>+    pub fn disable_opp(&self, freq: u64) -> Result<()> {
>+        // SAFETY: The requirements are satisfied by the existence of `Device` and its safety
>+        // requirements.
>+        to_result(unsafe { bindings::dev_pm_opp_disable(self.dev.as_raw(), freq) })
>+    }
>+
>+    /// Registers with Energy model.
>+    #[cfg(CONFIG_OF)]
>+    pub fn of_register_em(&mut self, cpumask: &mut cpumask::Cpumask) -> Result<()> {
>+        // SAFETY: The requirements are satisfied by the existence of `Device` and its safety
>+        // requirements.
>+        to_result(unsafe {
>+            bindings::dev_pm_opp_of_register_em(self.dev.as_raw(), cpumask.as_mut_ptr())
>+        })?;
>+
>+        self.em = true;
>+        Ok(())
>+    }
>+
>+    // Unregisters with Energy model.
>+    #[cfg(CONFIG_OF)]
>+    fn of_unregister_em(&self) {
>+        // SAFETY: The requirements are satisfied by the existence of `Device` and its safety
>+        // requirements. We registered with the EM framework earlier, it is safe to unregister now.
>+        unsafe { bindings::em_dev_unregister_perf_domain(self.dev.as_raw()) };
>+    }
>+}
>+
>+impl Drop for Table {
>+    fn drop(&mut self) {
>+        // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe
>+        // to relinquish it now.
>+        unsafe { bindings::dev_pm_opp_put_opp_table(self.ptr) };
>+
>+        #[cfg(CONFIG_OF)]
>+        {
>+            if self.em {
>+                self.of_unregister_em();
>+            }
>+
>+            if self.of {
>+                self.remove_of();
>+            } else if let Some(cpumask) = &self.cpumask {
>+                self.remove_of_cpumask(cpumask);
>+            }
>+        }
>+    }
>+}
>+
> /// Operating performance point (OPP).
> ///
> /// # Invariants
>-- 
>2.31.1.272.g89b43f80a514
>

