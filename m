Return-Path: <linux-pm+bounces-30180-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70DD5AF9B92
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 22:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BA646E08B8
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 20:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C872236A70;
	Fri,  4 Jul 2025 20:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="blXEuRQt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345B572634;
	Fri,  4 Jul 2025 20:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751660167; cv=none; b=iF59tW4WeR+dt9hRSzwtGdE7ApUyjuc1Kl2sOOutHP370SRNo4EicYKkj1ozjIFeHwu+QBTEp8phQpS9sv2FiHwP78pOGRNBmIIGye9qNkJNem9bTS8294fFY18++kmUh5MUFYeQ/M1VEBUO8yV0l5OQSb8GJhbLJz1ke+//990=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751660167; c=relaxed/simple;
	bh=0eE29d4BDbrbeYPny4FZm2lEWg1f3s4QbLWbmMdfS2Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XySAKcfWQzmaV88dsPTUVHIWE8aY+gPSP5rxMgVyRt+F6Of4IV56W8QuMV8VlZrlQo3Y999rwPfhezT0wwDEVm1h+iwJl66WtDdGUdi/F31ixu98iMhOEg9aE+39I4oESkUnsiPNClx6nMVNQJUF3+NkfVvkf/HJ7HqFFVi+gag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=blXEuRQt; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4a8244e897fso17298951cf.1;
        Fri, 04 Jul 2025 13:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751660164; x=1752264964; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ytj/U1rka5vUlSmFzHnNuz0MRFUCm7uq4gnATea5MG4=;
        b=blXEuRQt/mqmEy2pdBvvcr4G5cWOyu9NXOK2l4VutbcfyWUp9b20W6HTIe0Np+PZWF
         EXGxgUHTg4tp9W3JSlr/WF7/+XKFWMs+5Xn6/qKXxR+d25FRHGMcydwjJjOfCKGmuqjP
         GvuH3zFAc2ISZY/aog+U/MVMeD3iIG3Is6hpGbIWZgFkvLvtWooqOTYoWANRVL4LzmX9
         nS48+tjvLsRwAgZi72dfIAuIHrOTavHwGr+63LVhWgkDUYAk593oCaGL8xjntgG5npsO
         06r2CqWMHl6UFRStItYQGGPbrUcLxt6qRudbW1s4hKeLY+xUfOtbeeZUi5oZUBiOGgCn
         2bMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751660164; x=1752264964;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ytj/U1rka5vUlSmFzHnNuz0MRFUCm7uq4gnATea5MG4=;
        b=wFiB5hGOL1FJP0YRaj0Y7Zln0jodDbGH6iuiu0+Ftw4n7hEQm05ITDWDPIPW9q64qq
         CeuVpVhWIi1ZPZ/jHbVm8BQ0PgnPS2PNR7n/1JQoZLVZpZjG1RcW+FLrJMe2bTWsYCwj
         G0DwzESnTWF6ipzXvYONDCGpSy6fTho1n63Y4cuIVSK36SN0WuccFvuVqVj4Uy7pq6s8
         ZTzBmjRvHfB+VHh29qVl4nu6E1czcJB7Bx5AMBXYcCh0VZJPkdyNdxfY2UlfJq+BWuTT
         YKY4sZr/sLoSre2FIB2q6K6yZE5EquPqmhMZtPpXxmdLzKSCidfaWqerLNy7YcuGTJir
         vExw==
X-Forwarded-Encrypted: i=1; AJvYcCUT/zNofLwQVjR91ft80buj2dEAWPQ3p/ZELDGyUR9xt8Iv+eIsOMunu4yi1bUDTaZQJWZODa/O9LdyFygMfi0=@vger.kernel.org, AJvYcCV1yadPodH+K5hGmNFe6L8gObpnRFrnpJisB/pOpyjoxTheBfgqPAnZNgdJR5tnJwthpGBM9R97dUE+GYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqEd5BMeBMkG0zH09GsvTeGeX5J+U9JsGtJD7kUwMmbIQNSiIV
	fLsyb5CSu5rO7pUGQCNrx9CPsH568Bb5Vqcin8W0L/tq/xWfnGjXoYm1
X-Gm-Gg: ASbGncslkcjeTXk2u4Io8SBYQvKz4rzh7nDcRxHOAcJPzh1KdVKFfjYxcbELl8LCKV9
	4XoTz8fIIXcfdqSfZbkfqTeknKscnenEQK0fyBykvRNl2lAPsWJ3hUMo8Lxeucnf05DzwbzxZnu
	QCv+wOINOgX9TrAFMRjvtt7yglxdifcYg9b4x2yszXL1Ji03S2KuHyCkS6/WhqIvGfpmQN/9ppW
	qBl+KnGnT33Z7XqwexfdIo2RntUPVGQfpRf7yIb6ebEvnb9zlIpWGnt7Az6OThKcJmR/dQHj4rH
	yzflt44Vqvvj5TCYCfJ5tFHVjC7mtMy/oViSlkynaNM1PVac97AjztSCeQANGGIWWbBb2zhvo7i
	gPCsxel4=
X-Google-Smtp-Source: AGHT+IFEHuArpM8TIRSfH3/PNk3fgwhnpLrdJuiimaZA+jC0FuRTqewTYv7paL4gvO9Vh/4dQDMg8w==
X-Received: by 2002:ac8:7e86:0:b0:4a6:c5ee:6ced with SMTP id d75a77b69052e-4a9a6d5f372mr751781cf.4.1751660163869;
        Fri, 04 Jul 2025 13:16:03 -0700 (PDT)
Received: from 156.1.168.192.in-addr.arpa ([2600:4041:5c29:e400:94f3:d2bb:5ace:77a1])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a9949e5221sm19772941cf.2.2025.07.04.13.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 13:16:03 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 04 Jul 2025 16:14:52 -0400
Subject: [PATCH 1/6] rust: kernel: remove `fmt!`, fix
 clippy::uninlined-format-args
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250704-core-cstr-prepare-v1-1-a91524037783@gmail.com>
References: <20250704-core-cstr-prepare-v1-0-a91524037783@gmail.com>
In-Reply-To: <20250704-core-cstr-prepare-v1-0-a91524037783@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Danilo Krummrich <dakr@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 rust-for-linux@vger.kernel.org, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1751660160; l=8814;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=0eE29d4BDbrbeYPny4FZm2lEWg1f3s4QbLWbmMdfS2Q=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QBTfUwC+8+4Q7FidFkzWZ9u87I5aWLRGbg8aJnPxxBijaaEp1K9afxbrP+TMPnlXRRmGa9ue8Lk
 J89tQ+BdPTgY=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Rather than export a macro that delegates to `core::format_args`, simply
re-export `core::format_args` as `fmt` from the prelude. This exposes
clippy warnings which were previously obscured by this macro, such as:

    warning: variables can be used directly in the `format!` string
      --> ../drivers/cpufreq/rcpufreq_dt.rs:21:43
       |
    21 |     let prop_name = CString::try_from_fmt(fmt!("{}-supply", name)).ok()?;
       |                                           ^^^^^^^^^^^^^^^^^^^^^^^
       |
       = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#uninlined_format_args
       = note: `-W clippy::uninlined-format-args` implied by `-W clippy::all`
       = help: to override `-W clippy::all` add `#[allow(clippy::uninlined_format_args)]`
    help: change this to
       |
    21 -     let prop_name = CString::try_from_fmt(fmt!("{}-supply", name)).ok()?;
    21 +     let prop_name = CString::try_from_fmt(fmt!("{name}-supply")).ok()?;
       |

Thus fix them in the same commit. This could possibly be fixed in two
stages, but the diff is small enough (outside of kernel/str.rs) that I
hope it can taken in a single commit.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 drivers/cpufreq/rcpufreq_dt.rs    |  3 +--
 drivers/gpu/nova-core/firmware.rs |  5 +++--
 rust/kernel/opp.rs                |  2 +-
 rust/kernel/prelude.rs            |  2 +-
 rust/kernel/str.rs                | 34 ++++++++++++++--------------------
 5 files changed, 20 insertions(+), 26 deletions(-)

diff --git a/drivers/cpufreq/rcpufreq_dt.rs b/drivers/cpufreq/rcpufreq_dt.rs
index 30a170570c0e..4608d2286fa1 100644
--- a/drivers/cpufreq/rcpufreq_dt.rs
+++ b/drivers/cpufreq/rcpufreq_dt.rs
@@ -9,7 +9,6 @@
     cpumask::CpumaskVar,
     device::{Core, Device},
     error::code::*,
-    fmt,
     macros::vtable,
     module_platform_driver, of, opp, platform,
     prelude::*,
@@ -19,7 +18,7 @@
 
 /// Finds exact supply name from the OF node.
 fn find_supply_name_exact(dev: &Device, name: &str) -> Option<CString> {
-    let prop_name = CString::try_from_fmt(fmt!("{}-supply", name)).ok()?;
+    let prop_name = CString::try_from_fmt(fmt!("{name}-supply")).ok()?;
     dev.property_present(&prop_name)
         .then(|| CString::try_from_fmt(fmt!("{name}")).ok())
         .flatten()
diff --git a/drivers/gpu/nova-core/firmware.rs b/drivers/gpu/nova-core/firmware.rs
index 4b8a38358a4f..e503a4fddae0 100644
--- a/drivers/gpu/nova-core/firmware.rs
+++ b/drivers/gpu/nova-core/firmware.rs
@@ -24,11 +24,12 @@ pub(crate) struct Firmware {
 
 impl Firmware {
     pub(crate) fn new(dev: &device::Device, chipset: Chipset, ver: &str) -> Result<Firmware> {
-        let mut chip_name = CString::try_from_fmt(fmt!("{}", chipset))?;
+        let mut chip_name = CString::try_from_fmt(fmt!("{chipset}"))?;
         chip_name.make_ascii_lowercase();
+        let chip_name = &*chip_name;
 
         let request = |name_| {
-            CString::try_from_fmt(fmt!("nvidia/{}/gsp/{}-{}.bin", &*chip_name, name_, ver))
+            CString::try_from_fmt(fmt!("nvidia/{chip_name}/gsp/{name_}-{ver}.bin"))
                 .and_then(|path| firmware::Firmware::request(&path, dev))
         };
 
diff --git a/rust/kernel/opp.rs b/rust/kernel/opp.rs
index 0e94cb2703ec..5a161ad12bf7 100644
--- a/rust/kernel/opp.rs
+++ b/rust/kernel/opp.rs
@@ -345,7 +345,7 @@ fn drop(&mut self) {
 /// impl ConfigOps for Driver {}
 ///
 /// fn configure(dev: &ARef<Device>) -> Result<ConfigToken> {
-///     let name = CString::try_from_fmt(fmt!("{}", "slow"))?;
+///     let name = CString::try_from_fmt(fmt!("slow"))?;
 ///
 ///     // The OPP configuration is cleared once the [`ConfigToken`] goes out of scope.
 ///     Config::<Driver>::new()
diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
index 2f30a398dddd..3ca934885797 100644
--- a/rust/kernel/prelude.rs
+++ b/rust/kernel/prelude.rs
@@ -31,9 +31,9 @@
 // `super::std_vendor` is hidden, which makes the macro inline for some reason.
 #[doc(no_inline)]
 pub use super::dbg;
-pub use super::fmt;
 pub use super::{dev_alert, dev_crit, dev_dbg, dev_emerg, dev_err, dev_info, dev_notice, dev_warn};
 pub use super::{pr_alert, pr_crit, pr_debug, pr_emerg, pr_err, pr_info, pr_notice, pr_warn};
+pub use core::format_args as fmt;
 
 pub use super::{try_init, try_pin_init};
 
diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index cbc8b459ed41..10399fb7af45 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -54,13 +54,13 @@ impl fmt::Display for BStr {
     /// Formats printable ASCII characters, escaping the rest.
     ///
     /// ```
-    /// # use kernel::{fmt, b_str, str::{BStr, CString}};
+    /// # use kernel::{prelude::fmt, b_str, str::{BStr, CString}};
     /// let ascii = b_str!("Hello, BStr!");
-    /// let s = CString::try_from_fmt(fmt!("{}", ascii))?;
+    /// let s = CString::try_from_fmt(fmt!("{ascii}"))?;
     /// assert_eq!(s.as_bytes(), "Hello, BStr!".as_bytes());
     ///
     /// let non_ascii = b_str!("🦀");
-    /// let s = CString::try_from_fmt(fmt!("{}", non_ascii))?;
+    /// let s = CString::try_from_fmt(fmt!("{non_ascii}"))?;
     /// assert_eq!(s.as_bytes(), "\\xf0\\x9f\\xa6\\x80".as_bytes());
     /// # Ok::<(), kernel::error::Error>(())
     /// ```
@@ -85,14 +85,14 @@ impl fmt::Debug for BStr {
     /// escaping the rest.
     ///
     /// ```
-    /// # use kernel::{fmt, b_str, str::{BStr, CString}};
+    /// # use kernel::{prelude::fmt, b_str, str::{BStr, CString}};
     /// // Embedded double quotes are escaped.
     /// let ascii = b_str!("Hello, \"BStr\"!");
-    /// let s = CString::try_from_fmt(fmt!("{:?}", ascii))?;
+    /// let s = CString::try_from_fmt(fmt!("{ascii:?}"))?;
     /// assert_eq!(s.as_bytes(), "\"Hello, \\\"BStr\\\"!\"".as_bytes());
     ///
     /// let non_ascii = b_str!("😺");
-    /// let s = CString::try_from_fmt(fmt!("{:?}", non_ascii))?;
+    /// let s = CString::try_from_fmt(fmt!("{non_ascii:?}"))?;
     /// assert_eq!(s.as_bytes(), "\"\\xf0\\x9f\\x98\\xba\"".as_bytes());
     /// # Ok::<(), kernel::error::Error>(())
     /// ```
@@ -429,15 +429,15 @@ impl fmt::Display for CStr {
     ///
     /// ```
     /// # use kernel::c_str;
-    /// # use kernel::fmt;
+    /// # use kernel::prelude::fmt;
     /// # use kernel::str::CStr;
     /// # use kernel::str::CString;
     /// let penguin = c_str!("🐧");
-    /// let s = CString::try_from_fmt(fmt!("{}", penguin))?;
+    /// let s = CString::try_from_fmt(fmt!("{penguin}"))?;
     /// assert_eq!(s.as_bytes_with_nul(), "\\xf0\\x9f\\x90\\xa7\0".as_bytes());
     ///
     /// let ascii = c_str!("so \"cool\"");
-    /// let s = CString::try_from_fmt(fmt!("{}", ascii))?;
+    /// let s = CString::try_from_fmt(fmt!("{ascii}"))?;
     /// assert_eq!(s.as_bytes_with_nul(), "so \"cool\"\0".as_bytes());
     /// # Ok::<(), kernel::error::Error>(())
     /// ```
@@ -459,16 +459,16 @@ impl fmt::Debug for CStr {
     ///
     /// ```
     /// # use kernel::c_str;
-    /// # use kernel::fmt;
+    /// # use kernel::prelude::fmt;
     /// # use kernel::str::CStr;
     /// # use kernel::str::CString;
     /// let penguin = c_str!("🐧");
-    /// let s = CString::try_from_fmt(fmt!("{:?}", penguin))?;
+    /// let s = CString::try_from_fmt(fmt!("{penguin:?}"))?;
     /// assert_eq!(s.as_bytes_with_nul(), "\"\\xf0\\x9f\\x90\\xa7\"\0".as_bytes());
     ///
     /// // Embedded double quotes are escaped.
     /// let ascii = c_str!("so \"cool\"");
-    /// let s = CString::try_from_fmt(fmt!("{:?}", ascii))?;
+    /// let s = CString::try_from_fmt(fmt!("{ascii:?}"))?;
     /// assert_eq!(s.as_bytes_with_nul(), "\"so \\\"cool\\\"\"\0".as_bytes());
     /// # Ok::<(), kernel::error::Error>(())
     /// ```
@@ -578,7 +578,7 @@ mod tests {
 
     macro_rules! format {
         ($($f:tt)*) => ({
-            CString::try_from_fmt(::kernel::fmt!($($f)*))?.to_str()?
+            CString::try_from_fmt(fmt!($($f)*))?.to_str()?
         })
     }
 
@@ -840,7 +840,7 @@ fn write_str(&mut self, s: &str) -> fmt::Result {
 /// # Examples
 ///
 /// ```
-/// use kernel::{str::CString, fmt};
+/// use kernel::{str::CString, prelude::fmt};
 ///
 /// let s = CString::try_from_fmt(fmt!("{}{}{}", "abc", 10, 20))?;
 /// assert_eq!(s.as_bytes_with_nul(), "abc1020\0".as_bytes());
@@ -930,9 +930,3 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
         fmt::Debug::fmt(&**self, f)
     }
 }
-
-/// A convenience alias for [`core::format_args`].
-#[macro_export]
-macro_rules! fmt {
-    ($($f:tt)*) => ( ::core::format_args!($($f)*) )
-}

-- 
2.50.0


