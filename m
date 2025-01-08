Return-Path: <linux-pm+bounces-20082-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 334ACA0590B
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2025 12:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12B8D7A1AA0
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2025 11:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082111F6667;
	Wed,  8 Jan 2025 11:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ncNkksfl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B321F37CF
	for <linux-pm@vger.kernel.org>; Wed,  8 Jan 2025 11:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736334167; cv=none; b=JVgYlELnVUspVTfx9U1wYqbbQlJnfEnBd7Y/ij7je/pRngHGMJrYJhbjLOcwwigvQ/xsvSLQ3ONyPi+sPSmOEboUC38nBZRUE3KiIsW2wuV4URbwMlbQu6iUXUROAhF+jdmAyVD0yaeu3fOghimXEPHEA7xRvYxtoNBdvRjGIaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736334167; c=relaxed/simple;
	bh=74KoKn+Z5+V6H+MTFwT85PxqGLMfVaI0+UzWkhUGPZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KkKHpxzmw+FGZR/y06D1OUayIcOciVyeHJQr/zow3baOcCHohn7+YBCelRFOaJq3dWq/OVqz/JxLhnBD2fjf4ohXaV0f58BdMkQts+ny7yofNI5+3VxNRYl5ufuEhITMSTgx4s0mzk6FBEg2Og0wRGiro93bbM5ViZM1bHb3SmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ncNkksfl; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21a1e6fd923so33750395ad.1
        for <linux-pm@vger.kernel.org>; Wed, 08 Jan 2025 03:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736334165; x=1736938965; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qsNpxh2S1v1oQWSnjr07pnH4qVgM0YfzklwN4kDwZs8=;
        b=ncNkksflnHuhPGA66DOgyGqriHnh6uxRMx/YEPbzYnxM9GcGqUn6lwvJgaeMnfzimh
         K8e5ZILsdzPVlvHkx8SN/A0Hd7s+fz6uDhgJQtOqUqjTSSDu6E5saiTFydtTxsYeSb9X
         MP3TT9sAlwh73UMKYKwU2ZK2e4rt2Ubq22xpB4a8DJoA9vgeREELUORB4pOF/uRdugEr
         U+uC5yijNBJMpJQGvcYNsOa2a3r4ShVHwtQ91R9+862SxEymLooHXg9nQQmPd4nPC5UI
         g0QVJ7sns8sV0DSN9w2U7GvqhtkNSF6p5t94JMwwJ3Xe+0xYEKGB8P7EjZPSNSvk4NVg
         Ozgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736334165; x=1736938965;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qsNpxh2S1v1oQWSnjr07pnH4qVgM0YfzklwN4kDwZs8=;
        b=P848R799Mg3QK2A9wHmtqe3yZo2c6wANU73LuEKWiF2xGTwu2R2rb5lI2z70wPO1x2
         ej4vJHOB9+uYbhev+RAmVrb4wIwAOjfrSAKaWNROLSAsJ4ybv24noJz9OHbKxpTzOzYC
         eUoqqP5gV3zs3rZtf7/euNPOtKbetK16frP5NrrKizXAPhrJwSxTGfhDOjBVNr42iX1s
         p3FemVgJy9gb/yp4vn+7JSA2UssYIKJgH2b68qHxntGmddG39XBstNoksHn3Pr6J4iRo
         E9cdGm8GLoz6VVdyTLDfQnAJKeC4jGcD9MRL/aYVqnYeNRttKSGSs00RK86+HYKXB4Bg
         E9HQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZBUJ8u0PsJuRzu/lcysxVLjJUCv7iZIxvCQnxgkkMnCdNP13a0WPom5ouoFE5sL/PD3UxhCIcLg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwiykXLNOsZNPp6F0HCGMokA+4EIrtLYLWl8UFyeEsJNe8FfJTP
	vfnx7v7v9MVg/evroW+y3p0EEIkhwJIpUSqlqF5ojq5dNEdgXkoYbyWo01Rk/Fs=
X-Gm-Gg: ASbGncvN2ehpBo8NXQGp3StTrWfig/7qO+vDvOS3W0/OfOqg12rmiYqlq6zUG5CMgzL
	6L9rj28nrLbKeW8qD42hE6lE4w128pMpzbHWAKEZMiL6lZcgXUPHo48CYXZJiKlx8j/ZzMDKGBa
	jYTvtiQbh+HMfcSMDEbNGFJsBZbth5It/4N/NPWbPct3DowIYVPx7euq58uO8vHToqblUdaD794
	7G3i1j1tE7OFmYwq4At0XChXBpUlHjR1WmfUP6rOHmex1zetuM3frfvI2c=
X-Google-Smtp-Source: AGHT+IG65Js8o+bc6dubfgzSIUteJxPznZSIqNa1IAnIhDbD0DF0Znpf6rcdXYjyWCVJ7y6ICniNEQ==
X-Received: by 2002:a17:902:da87:b0:215:9642:4d7a with SMTP id d9443c01a7336-21a83da6a40mr43182625ad.0.1736334165584;
        Wed, 08 Jan 2025 03:02:45 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842abd5920bsm31973371a12.6.2025.01.08.03.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 03:02:44 -0800 (PST)
Date: Wed, 8 Jan 2025 16:32:42 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Danilo Krummrich <dakr@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
	rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Erik Schilling <erik.schilling@linaro.org>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V6 04/15] rust: device: Add few helpers
Message-ID: <20250108110242.dwhdlwnyjloz6dwb@vireshk-i7>
References: <cover.1736248242.git.viresh.kumar@linaro.org>
 <429b7539f787ad360cd28fd1db6dc3d6c1fe289d.1736248242.git.viresh.kumar@linaro.org>
 <2025010734-march-cultivate-bd96@gregkh>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025010734-march-cultivate-bd96@gregkh>

On 07-01-25, 12:56, Greg Kroah-Hartman wrote:
> On Tue, Jan 07, 2025 at 04:51:37PM +0530, Viresh Kumar wrote:
> > +    /// Creates a new ref-counted instance of device of a CPU.
> > +    pub fn from_cpu(cpu: u32) -> Result<ARef<Self>> {
> 
> Why is this a reference counted device, yet the C structure is NOT
> properly reference counted at all?

Ahh, I completely missed that it is not reference counted at all.

> Are you _sure_ this is going to work properly?
> 
> And really, we should fix up the C side to properly reference count all
> of this.  Just read the comment in cpu_device_release() for a hint at
> what needs to be done here.
> 
> > +        // SAFETY: It is safe to call `get_cpu_device()` for any CPU number.
> 
> For any number at all, no need to say "CPU" here, right?
> 
> > +        let ptr = unsafe { bindings::get_cpu_device(cpu) };
> > +        if ptr.is_null() {
> > +            return Err(ENODEV);
> > +        }
> > +
> > +        // SAFETY: By the safety requirements, ptr is valid.
> > +        Ok(unsafe { Device::get_device(ptr) })
> 
> So why is this device reference counted?  I get it that it should be,
> but how does that play with the "real" device here?

How about this:

Subject: [PATCH] rust: device: Add from_cpu()

This implements Device::from_cpu(), which returns a reference to
`Device` for a CPU. The C struct is created at initialization time for
CPUs and is never freed and so `ARef` isn't returned from this function.

The new helper will be used by Rust based cpufreq drivers.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 rust/kernel/device.rs | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index 66ba0782551a..007f9ffab08b 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -6,6 +6,8 @@
 
 use crate::{
     bindings,
+    error::Result,
+    prelude::ENODEV,
     str::CString,
     types::{ARef, Opaque},
 };
@@ -60,6 +62,20 @@ pub unsafe fn get_device(ptr: *mut bindings::device) -> ARef<Self> {
         unsafe { Self::as_ref(ptr) }.into()
     }
 
+    /// Creates a new instance of CPU's device.
+    pub fn from_cpu(cpu: u32) -> Result<&'static Self> {
+        // SAFETY: The pointer returned by `get_cpu_device()`, if not `NULL`, is a valid pointer to
+        // a `struct device` and is never freed by the C code.
+        let ptr = unsafe { bindings::get_cpu_device(cpu) };
+        if ptr.is_null() {
+            return Err(ENODEV);
+        }
+
+        // SAFETY: The pointer returned by `get_cpu_device()`, if not `NULL`, is a valid pointer to
+        // a `struct device` and is never freed by the C code.
+        Ok(unsafe { Self::as_ref(ptr) })
+    }
+
     /// Obtain the raw `struct device *`.
     pub(crate) fn as_raw(&self) -> *mut bindings::device {
         self.0.get()

-------------------------8<-------------------------

> > +    /// Checks if property is present or not.
> > +    pub fn property_present(&self, name: &CString) -> bool {
> > +        // SAFETY: `name` is null-terminated. `self.as_raw` is valid because `self` is valid.
> > +        unsafe { bindings::device_property_present(self.as_raw(), name.as_ptr() as *const _) }
> 
> is "self.as_raw()" a constant pointer too?

Subject: [PATCH] rust: device: Add property_present()

This implements Device::property_present(), which calls C APIs
device_property_present() helper.

The new helper will be used by Rust based cpufreq drivers.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 rust/bindings/bindings_helper.h | 1 +
 rust/kernel/device.rs           | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 43f5c381aab0..70e4b7b0f638 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -31,6 +31,7 @@
 #include <linux/pid_namespace.h>
 #include <linux/platform_device.h>
 #include <linux/poll.h>
+#include <linux/property.h>
 #include <linux/refcount.h>
 #include <linux/sched.h>
 #include <linux/security.h>
diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index d5e6a19ff6b7..66ba0782551a 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -6,6 +6,7 @@
 
 use crate::{
     bindings,
+    str::CString,
     types::{ARef, Opaque},
 };
 use core::{fmt, ptr};
@@ -180,6 +181,12 @@ unsafe fn printk(&self, klevel: &[u8], msg: fmt::Arguments<'_>) {
             )
         };
     }
+
+    /// Checks if property is present or not.
+    pub fn property_present(&self, name: &CString) -> bool {
+        // SAFETY: By the invariant of `CString`, `name` is null-terminated.
+        unsafe { bindings::device_property_present(self.as_raw() as *const _, name.as_ptr() as *const _) }
+    }
 }
 
 // SAFETY: Instances of `Device` are always reference-counted.

-- 
viresh

