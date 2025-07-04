Return-Path: <linux-pm+bounces-30185-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED43AAF9B9D
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 22:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74BB41C2753A
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 20:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6C7254844;
	Fri,  4 Jul 2025 20:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RXMPVN3x"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788EC250C18;
	Fri,  4 Jul 2025 20:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751660173; cv=none; b=FB6aWvh6jf/HXb9dbu05zCGwyXm4q/y2LC4Y9M+dK9Gzwagm8QI+ezn+SnsjWKKdFi5UdtoeG9x3ISAZ6QXC5jPKBVO6piLkH//KGtHC/j0G0ySdPMlZYy7TNiY4iBe8lCFg1t5UJ55fQUnBRt8/gmVSbDOFEes00d1QLWs5H7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751660173; c=relaxed/simple;
	bh=Gr5Y82FzFOHSFgE4bAXR4LJsBEIiMIFEwMxnG28mI/k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=li0hTmDI3KIDe5+LB/sHwShHOwyudr/fk+JPDHk7kwwZRwne12xDoGtgZHwgLLxZ8AjibCja5Y/1hiY9LDvXZb+pB9AVnBb2q0/jaPYrN5pJGj19yZVHvCeEe8E2ZScjo55EjgeXdA3Ep4+2agNLokPbFIXSzER8nS4EZmUJHhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RXMPVN3x; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4a9741b513eso26494171cf.1;
        Fri, 04 Jul 2025 13:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751660170; x=1752264970; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rFX61eKYEcol9kAG3M8tjgApkaTg0NmTOXaZhr2OWW4=;
        b=RXMPVN3xaoPBDMTmD64gjDH0KCHAUONIaBXUsEvMch0qQMuG/RHb4IkpFJuEwQiVFx
         8On1ffWGxFXAtpfuRXhyu5Tx9Yml05vYGW0W0YFYx6kCkxgOFVAwD2CqJdAN+X7wGrHN
         LgVgehPWw6Ol6l0xyLNwReLWaUs0uawlEw8v4G5baaa5n6KYAtYzEeUokQl6mQwOnpab
         xHSWOnNMW1AseKJ3/QC+KhBFgXsXf3b47WFw9DXCAvwRKCzEVOTv1geMsovoGnVfmdL+
         BImJMEYn5fBWh7ThMX99Fek3AkVbHwM5bOBirrW+IhlxUf+kZjOgV6PlCTPo0AJ4pjCl
         i2CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751660170; x=1752264970;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rFX61eKYEcol9kAG3M8tjgApkaTg0NmTOXaZhr2OWW4=;
        b=slxTWIddRkH7SB253vupn6I32AIaMLFYw1WMm67FUAzgKQZq+fsLvyTQWc0jNiOb2Q
         35Ae8mEh9LZ/51TKEwMz5YY7R9BTzZGJwhmGfmevxL8cub3No55J7QMfPJz0ULIn5DAN
         NBgaYnGy1Yt/Ujqr2LGRDvfJJGZPd0CLzok/2gJ+k/wbQf/fp86S8MvApgT8H7qiFfq1
         7fhL2XmmvN+CirhnMvB6kioQsb0FtkfBLG8rvkF6rvLlR2o4eg1yxz8Q5O9gSTf0bZFH
         eWOYaGlF4TDLzXY620RCnwyCHR3LHDIhulO4WbDaAi5bOhRsAM3tGeODaOTjaFGzmv36
         Qxvw==
X-Forwarded-Encrypted: i=1; AJvYcCXOcYAuz5kpuFVArUVabfZFT1iuCadv5Um1P60MIbCvSyPx0OcMlu4TvoLy7cjZmuCBR8mkxwq0i+TiSyEloJ8=@vger.kernel.org, AJvYcCXfSN8nbgcOiJHUgZDc46FOoMyL98+YiV7o3kAdoQkhlg1a43g+cMdDYVXQZCUwzvlGTDCFGkXFFARB7fM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1S1S5zD9KuEihdsTTHBX+ZX5PVbl1YyofCZMgjJDwOij9sIW/
	IilhIUeEaMwYa57+87BylPm37PnwBMEsRZAyK3R4ym9Hv+Ylqjwqc+YUVsSzQwydLNhVWg==
X-Gm-Gg: ASbGncu2BbHEgquAnOBEHWbq3T8uSEaChuc0GaT3s9SgpwKZSLevSVv/qCUtyrHSmRa
	BWmKYpKDc/gs2vpQyzZHjTW/aDV9371DqS/P3FP5xiCkwZsbPmqfq/FWMdQ37hYOQL6OGpK2wfD
	J1H41WKxqqjbOZ8XZhoKd5n50KKNrtQiyD/QOmIlB4lwEsdu5TpQOzS4bTDGOFphdKadKHSub/s
	+X29vaR3PEiwMBq6KjBD/u8PdPxj7SIoqiKf23hp9vKgql804qnC1Z1BRTGrTxqAvns124SORTN
	/NLr4m1WZUb4MZYr8CMWq64zE00cxPeOJrDmooPWmknOGRZaIXXYYbsCnQ6Zcc3av3DgngmT4wy
	BrfEbndw=
X-Google-Smtp-Source: AGHT+IHCClMp3qYZhSGQu4QEJmyo61DmZpj8XQCRl0CIpaNBHANR9wOTxi6Qz7IzHn6a7YD26jNiWw==
X-Received: by 2002:ac8:7f8f:0:b0:494:59b0:7347 with SMTP id d75a77b69052e-4a9a69f76cfmr2280131cf.37.1751660170283;
        Fri, 04 Jul 2025 13:16:10 -0700 (PDT)
Received: from 156.1.168.192.in-addr.arpa ([2600:4041:5c29:e400:94f3:d2bb:5ace:77a1])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a9949e5221sm19772941cf.2.2025.07.04.13.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 13:16:09 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 04 Jul 2025 16:14:57 -0400
Subject: [PATCH 6/6] rust: use `core::ffi::CStr` method names
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250704-core-cstr-prepare-v1-6-a91524037783@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1751660161; l=4785;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=Gr5Y82FzFOHSFgE4bAXR4LJsBEIiMIFEwMxnG28mI/k=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QLas4zvU0lCc78yU+Yb9DLjcVMQs5g7e5Va+eCFZgvaWEOcJlCw4GoHKAaftU93fC6280TgpoTe
 TE2iS8TMjrAY=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Prepare for `core::ffi::CStr` taking the place of `kernel::str::CStr` by
avoiding methods that only exist on the latter.

Also avoid `Deref<Target=BStr> for CStr` as that impl doesn't exist on
`core::ffi::CStr`.

Link: https://github.com/Rust-for-Linux/linux/issues/1075
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/error.rs |  2 +-
 rust/kernel/str.rs   | 20 ++++++++++----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index ffa8efd2d547..e29a5d76300e 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -188,7 +188,7 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
             Some(name) => f
                 .debug_tuple(
                     // SAFETY: These strings are ASCII-only.
-                    unsafe { core::str::from_utf8_unchecked(name) },
+                    unsafe { core::str::from_utf8_unchecked(name.to_bytes()) },
                 )
                 .finish(),
         }
diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index cbb357fc0111..6c892550c0ba 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -57,11 +57,11 @@ impl fmt::Display for BStr {
     /// # use kernel::{prelude::fmt, b_str, str::{BStr, CString}};
     /// let ascii = b_str!("Hello, BStr!");
     /// let s = CString::try_from_fmt(fmt!("{ascii}"))?;
-    /// assert_eq!(s.as_bytes(), "Hello, BStr!".as_bytes());
+    /// assert_eq!(s.to_bytes(), "Hello, BStr!".as_bytes());
     ///
     /// let non_ascii = b_str!("🦀");
     /// let s = CString::try_from_fmt(fmt!("{non_ascii}"))?;
-    /// assert_eq!(s.as_bytes(), "\\xf0\\x9f\\xa6\\x80".as_bytes());
+    /// assert_eq!(s.to_bytes(), "\\xf0\\x9f\\xa6\\x80".as_bytes());
     /// # Ok::<(), kernel::error::Error>(())
     /// ```
     fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
@@ -89,11 +89,11 @@ impl fmt::Debug for BStr {
     /// // Embedded double quotes are escaped.
     /// let ascii = b_str!("Hello, \"BStr\"!");
     /// let s = CString::try_from_fmt(fmt!("{ascii:?}"))?;
-    /// assert_eq!(s.as_bytes(), "\"Hello, \\\"BStr\\\"!\"".as_bytes());
+    /// assert_eq!(s.to_bytes(), "\"Hello, \\\"BStr\\\"!\"".as_bytes());
     ///
     /// let non_ascii = b_str!("😺");
     /// let s = CString::try_from_fmt(fmt!("{non_ascii:?}"))?;
-    /// assert_eq!(s.as_bytes(), "\"\\xf0\\x9f\\x98\\xba\"".as_bytes());
+    /// assert_eq!(s.to_bytes(), "\"\\xf0\\x9f\\x98\\xba\"".as_bytes());
     /// # Ok::<(), kernel::error::Error>(())
     /// ```
     fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
@@ -465,15 +465,15 @@ impl fmt::Display for CStr {
     /// # use kernel::str::CString;
     /// let penguin = c_str!("🐧");
     /// let s = CString::try_from_fmt(fmt!("{penguin}"))?;
-    /// assert_eq!(s.as_bytes_with_nul(), "\\xf0\\x9f\\x90\\xa7\0".as_bytes());
+    /// assert_eq!(s.to_bytes_with_nul(), "\\xf0\\x9f\\x90\\xa7\0".as_bytes());
     ///
     /// let ascii = c_str!("so \"cool\"");
     /// let s = CString::try_from_fmt(fmt!("{ascii}"))?;
-    /// assert_eq!(s.as_bytes_with_nul(), "so \"cool\"\0".as_bytes());
+    /// assert_eq!(s.to_bytes_with_nul(), "so \"cool\"\0".as_bytes());
     /// # Ok::<(), kernel::error::Error>(())
     /// ```
     fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
-        for &c in self.as_bytes() {
+        for &c in self.to_bytes() {
             if (0x20..0x7f).contains(&c) {
                 // Printable character.
                 f.write_char(c as char)?;
@@ -874,11 +874,11 @@ fn write_str(&mut self, s: &str) -> fmt::Result {
 /// use kernel::{str::CString, prelude::fmt};
 ///
 /// let s = CString::try_from_fmt(fmt!("{}{}{}", "abc", 10, 20))?;
-/// assert_eq!(s.as_bytes_with_nul(), "abc1020\0".as_bytes());
+/// assert_eq!(s.to_bytes_with_nul(), "abc1020\0".as_bytes());
 ///
 /// let tmp = "testing";
 /// let s = CString::try_from_fmt(fmt!("{tmp}{}", 123))?;
-/// assert_eq!(s.as_bytes_with_nul(), "testing123\0".as_bytes());
+/// assert_eq!(s.to_bytes_with_nul(), "testing123\0".as_bytes());
 ///
 /// // This fails because it has an embedded `NUL` byte.
 /// let s = CString::try_from_fmt(fmt!("a\0b{}", 123));
@@ -948,7 +948,7 @@ impl<'a> TryFrom<&'a CStr> for CString {
     fn try_from(cstr: &'a CStr) -> Result<CString, AllocError> {
         let mut buf = KVec::new();
 
-        buf.extend_from_slice(cstr.as_bytes_with_nul(), GFP_KERNEL)?;
+        buf.extend_from_slice(cstr.to_bytes_with_nul(), GFP_KERNEL)?;
 
         // INVARIANT: The `CStr` and `CString` types have the same invariants for
         // the string data, and we copied it over without changes.

-- 
2.50.0


