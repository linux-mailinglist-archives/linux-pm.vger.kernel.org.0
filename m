Return-Path: <linux-pm+bounces-25533-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 287E3A8B649
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 12:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 742D41885825
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 10:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740FE235BFF;
	Wed, 16 Apr 2025 09:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ohdYXI03"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B084B23315F
	for <linux-pm@vger.kernel.org>; Wed, 16 Apr 2025 09:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744797588; cv=none; b=TA4egnh+kp5YOMRoMPSwswq2tFYoxHKvA44sE9KF9E38KhkoVQduea2+nwLu/vche07ioGxdjM9gpcK0THhhCtIZyXa7Is+FaFpdnKr1NiaK127Nrq8/lwAaAJoZ0ooNWg+Eo2lwr8ATae+5NCnCQG1MhuQOlXma/fu0EERp1+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744797588; c=relaxed/simple;
	bh=/KqlifPlITcri+NQjH9NT/zBN4DYYrCOXYlB0R4bEE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MlaiEUYFazPg9GLFoXPqNNdSKgQ7+FGE8YG3blMusCWsoHDKaHlqYEy50N8kbGL9unP05dAShy/rfft5NQC9BLNpYGhGRX/owE7DoGXw+sebQ8RA/RS6kSC/I+bPV0+YOByUtRoH4FlcGra8iGviLX3DyZvZSrDQJdvcgHIkPdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ohdYXI03; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-225477548e1so63636975ad.0
        for <linux-pm@vger.kernel.org>; Wed, 16 Apr 2025 02:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744797586; x=1745402386; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JEYp1SEbpoVNrf3LCVsspSC8TThhLaOuKiPfCmCBrCE=;
        b=ohdYXI03XDnmwCDoBfeuwXBEDDAL95kC40N+9cJUZwQcjuM33qX74PA70LK+tMDQay
         BN9q3GprWzmrAN/zlj4PDEKYXKs/Slkb8B4Jw1rn4cq+uW2tS1qQi4tnkpke7qc1T9P9
         yjOQ9P5YwYJvDn420WWWxiEWWcpo+CsalPwxt5rBmaauOX5qYH6d3kp6iOPbRrP3FbsK
         x8YJtjlpjdJvtScB76T9tx8BZ/4hpG2Uav7VzwWriyv1L3kNVKzZ+BOnEr0SdykJsL6r
         4JUPRRFlFP+mdJyMmIM51uWSNH6o9Y+XKCQOkvF91zypXsm0Q4u4gsLdzgzg5xScez/2
         AFUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744797586; x=1745402386;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JEYp1SEbpoVNrf3LCVsspSC8TThhLaOuKiPfCmCBrCE=;
        b=LtZURfuD7SWDJzixwksdnJgM+MLQgfQ2b28yFD/Kvy+upOXTQj/VhYwHeJDC8WiOQ3
         oBuk2o9RCMXDXiTT87iHGh3U8XaVVTCircdo6MllZaO3vHbRi1JsvZQJUxnhR+ievabR
         3LqROojqOAzIqJNHri+9Wgf+FaoDrpsnp06vyR8B2d63fHuQoOv939cCUUvo+FJVbES8
         +Vqb+g62orSRWb4d/1twn48VvOdFpzO7MV/Xf+fivYCKJCeJAeyaIETWMQhQe0kl3ZN5
         MNWeXrz77stSio/+X1ugMdUBZLBOtwNzpaf9xgJQUCn7EhYkxi7cVEEIzTyDpO2k7cke
         PRww==
X-Forwarded-Encrypted: i=1; AJvYcCW374UvMUY0RCtPqlIHWRA1ataI9fiT8lrHVdZHHEFoE8U6AVeElbNz1t/QeQXhKOBkQmel7kdyPQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg7mGTjjZZZFfAun9h0ZpcoAS6H7JqRSyPNajS3MUHIhshk4AS
	Aw92LgaP81eUI3RdiMr0gORS9W2qwXc46oDsDui+EHImUqprOEI6CXwm5MhRr+I=
X-Gm-Gg: ASbGncsfMynSilZcijV7t0eF7pSkulG4ll79+NvSx7Xiz54WYFj+2O4ParyvBbm6MAE
	lX/ALLw1fcpi1wI+nQgEF3H9ueIoA97nhWvaVJ20yO4jS+dXYjvpCHCBciI5TTqVUP4aZZrTfm6
	bfcBvHc05/APjo5aLLSZBvxXNVVe41cH3+XPvG24C151KZrz+8sCainidIEDtP1wf5Dnlv2o2FE
	/WIcJfTrcynMxjxinIitQ2s7K0LskOyblSloP/qoCgn00f22AgavBObURNPfevY75OzhbiROQLj
	IwstAqusN6EqUAkEGeNklEUCbayIK1yBB3ELLACs5Q==
X-Google-Smtp-Source: AGHT+IFlrDH8XoDOr95CMioGMAxmNZhKw0qCNMj4btmrvguVmdoyuIky5agyncMrdkwVuUZ7fBvXGQ==
X-Received: by 2002:a17:902:e806:b0:220:e63c:5b13 with SMTP id d9443c01a7336-22c35982038mr16198835ad.46.1744797585891;
        Wed, 16 Apr 2025 02:59:45 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33ef0fbasm9958505ad.19.2025.04.16.02.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 02:59:45 -0700 (PDT)
Date: Wed, 16 Apr 2025 15:29:43 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Danilo Krummrich <dakr@redhat.com>,
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>,
	Yury Norov <yury.norov@gmail.com>, Burak Emir <bqe@google.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Russell King <linux@armlinux.org.uk>, linux-clk@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V10 14/15] rust: opp: Extend OPP abstractions with
 cpufreq support
Message-ID: <20250416095943.f3jxy55bamekscst@vireshk-i7>
References: <cover.1744783509.git.viresh.kumar@linaro.org>
 <a940d1b1a02d99fdc80ba8d0526c35a776854cb3.1744783509.git.viresh.kumar@linaro.org>
 <Z_9v24SghlIhT62r@pollux>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_9v24SghlIhT62r@pollux>

On 16-04-25, 10:52, Danilo Krummrich wrote:
> This config is needed quite often, it probably makes sense to move this code in
> its own Rust module, i.e.:
> 
> 	#[cfg(CONFIG_CPU_FREQ)]
> 	pub mod freq;

Like this ?

diff --git a/rust/kernel/opp.rs b/rust/kernel/opp.rs
index 734be8b6d0ef..f4cabe859c43 100644
--- a/rust/kernel/opp.rs
+++ b/rust/kernel/opp.rs
@@ -20,10 +20,67 @@
 };

 #[cfg(CONFIG_CPU_FREQ)]
-use crate::cpufreq;
+// Frequency table implementation.
+mod freq {
+    use crate::cpufreq;
+    use core::ops::Deref;
+    use super::*;
+
+    /// OPP frequency table.
+    ///
+    /// A [`cpufreq::Table`] created from [`Table`].
+    pub struct FreqTable {
+        dev: ARef<Device>,
+        ptr: *mut bindings::cpufreq_frequency_table,
+    }
+
+    impl FreqTable {
+        /// Creates a new instance of [`FreqTable`] from [`Table`].
+        pub(crate) fn new(table: &Table) -> Result<Self> {
+            let mut ptr: *mut bindings::cpufreq_frequency_table = ptr::null_mut();
+
+            // SAFETY: The requirements are satisfied by the existence of [`Device`] and its safety
+            // requirements.
+            to_result(unsafe {
+                bindings::dev_pm_opp_init_cpufreq_table(table.dev.as_raw(), &mut ptr)
+            })?;
+
+            Ok(Self {
+                dev: table.dev.clone(),
+                ptr,
+            })
+        }
+
+        // Returns a reference to the underlying [`cpufreq::Table`].
+        #[inline]
+        fn table(&self) -> &cpufreq::Table {
+            // SAFETY: The `ptr` is guaranteed by the C code to be valid.
+            unsafe { cpufreq::Table::from_raw(self.ptr) }
+        }
+    }
+
+    impl Deref for FreqTable {
+        type Target = cpufreq::Table;
+
+        #[inline]
+        fn deref(&self) -> &Self::Target {
+            self.table()
+        }
+    }
+
+    impl Drop for FreqTable {
+        fn drop(&mut self) {
+            // SAFETY: The pointer was created via `dev_pm_opp_init_cpufreq_table`, and is only
+            // freed here.
+            unsafe {
+                bindings::dev_pm_opp_free_cpufreq_table(self.dev.as_raw(), &mut self.as_raw())
+            };
+        }
+    }
+}

 #[cfg(CONFIG_CPU_FREQ)]
-use core::ops::Deref;
+pub use freq::FreqTable;

 use core::{marker::PhantomData, ptr};

@@ -502,60 +559,6 @@ extern "C" fn config_regulators(
     }
 }

-/// OPP frequency table.
-///
-/// A [`cpufreq::Table`] created from [`Table`].
-#[cfg(CONFIG_CPU_FREQ)]
-pub struct FreqTable {
-    dev: ARef<Device>,
-    ptr: *mut bindings::cpufreq_frequency_table,
-}
-
-#[cfg(CONFIG_CPU_FREQ)]
-impl FreqTable {
-    /// Creates a new instance of [`FreqTable`] from [`Table`].
-    fn new(table: &Table) -> Result<Self> {
-        let mut ptr: *mut bindings::cpufreq_frequency_table = ptr::null_mut();
-
-        // SAFETY: The requirements are satisfied by the existence of [`Device`] and its safety
-        // requirements.
-        to_result(unsafe {
-            bindings::dev_pm_opp_init_cpufreq_table(table.dev.as_raw(), &mut ptr)
-        })?;
-
-        Ok(Self {
-            dev: table.dev.clone(),
-            ptr,
-        })
-    }
-
-    // Returns a reference to the underlying [`cpufreq::Table`].
-    #[inline]
-    fn table(&self) -> &cpufreq::Table {
-        // SAFETY: The `ptr` is guaranteed by the C code to be valid.
-        unsafe { cpufreq::Table::from_raw(self.ptr) }
-    }
-}
-
-#[cfg(CONFIG_CPU_FREQ)]
-impl Deref for FreqTable {
-    type Target = cpufreq::Table;
-
-    #[inline]
-    fn deref(&self) -> &Self::Target {
-        self.table()
-    }
-}
-
-#[cfg(CONFIG_CPU_FREQ)]
-impl Drop for FreqTable {
-    fn drop(&mut self) {
-        // SAFETY: The pointer was created via `dev_pm_opp_init_cpufreq_table`, and is only freed
-        // here.
-        unsafe { bindings::dev_pm_opp_free_cpufreq_table(self.dev.as_raw(), &mut self.as_raw()) };
-    }
-}
-
 /// A reference-counted OPP table.
 ///
 /// Rust abstraction for the C `struct opp_table`.

-- 
viresh

