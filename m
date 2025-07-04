Return-Path: <linux-pm+bounces-30184-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C086AF9B9A
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 22:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0DBB5A8594
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 20:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221452522A7;
	Fri,  4 Jul 2025 20:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="crpE/EXe"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AE3248869;
	Fri,  4 Jul 2025 20:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751660172; cv=none; b=Bipo5bGVlp+mHy3Ko4Zq4prKWtVEfwruWQ2gEPCab8L3Zd1aEIbBWcSsFvwUyOjGQonSo2fprgcCubcqm2GR3l+H7vG5P1oKVFkzFykJOeDNUk6ZFWO5k1qMjk9xxISTcbquEGdWWh1+WDc++4XXjMazTMllUg7uP4f6nl02uvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751660172; c=relaxed/simple;
	bh=ijekkld9R1wbyb2cvN5FAg3adFOAIGh+Sl7Wg4UqSo0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lsz/iMQQ5U4+Ils2FSDHD1NyEeiQp4Gd2Z6sMIwlQdfdGM+ghkGIBS/WLqK5T9LTpYFs68gRrX4zCMrparHGDOYUD47u0JlIUgqstZ8yYOWxmcKVhEz6gm9pv1UjLxljAGUw2/Op+jXBL2LxnyLNES7VBkA1nQbzps+qBChxPVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=crpE/EXe; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7d3f192a64eso132349185a.2;
        Fri, 04 Jul 2025 13:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751660169; x=1752264969; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RRnCMuqdD131ZlyvTYi0z/+zkxHVEj8TfOGSz4lWZYk=;
        b=crpE/EXeigqrL9AXm0LvpeWZ3f4YeYwMUH0UGYbNjx7EEcvbbB8UZRdcVN8u1PiyUW
         qA4+tXOyvk5x/AgzD3q0XpGw7x23BsSAvqSVXKExETqFKYuwVRLbHbkuJ1NSgBEKmy61
         YjWhsOzKmqh0aIekPcxN0xpBL4w7VMAlJRvCKPC8AHXy/PNYFuJYlQvJ6MHyVcf1POyY
         vj7YulU6uMgztIFCsZKjw9K3UybqRkZcPjqP+ADw1qPPi6yr/L0HBjHU+P7JH80f0CI7
         JxzeT6dm6RWS+9YWlZkDgBjlpaT2RiFeEbtpBlJJQq8tTryO8Aglkpk4ZwE294arg6bl
         JKdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751660169; x=1752264969;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RRnCMuqdD131ZlyvTYi0z/+zkxHVEj8TfOGSz4lWZYk=;
        b=cn2iGZy54veR2iIDH6XtnuUYk3iMG+ynaRIznV0+dbsTU3AgCmZTTB87pbLrLBGj1V
         yTVJITbqcAcLMsE/+P8fVKNXjcQOOXnMitJu0Jf+7nl46OatxbNMHxDNJZ5gQL8wQ4aL
         rO8ak7BFIudBuva2k81HQjOVXt47VDi0ppJsHg7CnUcP0kPjOmngwAHrCPL9Jq5jxjc7
         Hxbfl7Khbd6dDSH6wUsEoh5BgKiSOirWshxCj0SzF77EQ1/jZlVoWa5wF+uRzI2ZKhGN
         c6mOWftGapRrfgVf5olcWb8EKPkDqhQP/OuWQMF6sfAaqvZ/uEr0llpRZuZbVDNJUdR+
         UQEw==
X-Forwarded-Encrypted: i=1; AJvYcCXH2XTXh3tL0o8WdIizAwa7ogfWuNMgD2KMU1x2c7O3ZRXCnT6zwOynRzcxazo/w/bnYRODCWYsFqH5j9cEB+I=@vger.kernel.org, AJvYcCXpNahRGIIraZ1G5v/ItPDZZMowuAYVsrX542UISagO+bBCIHZIwysMxqUHU9WiD2OYa1cEfxFjSAoUs/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwayKl1gudcAyj9dlkndykIb3+zXfZADQjii+dPrDXQjA7vff82
	eDrDRH3xfRVQdTUPm/UnsQm+vVR/JZIDE9eAy4JcTeK3fsSiVBVB+/NY
X-Gm-Gg: ASbGncsXZJmvoXRtGT1VuoeiHGint9IjPVAhCUByY9ot869jNs2ugZ7FpfwPcBtDZoa
	mzuwaMNMUH6CVu1U+VuZcytvBIQan5S/qKm2w5nKu0rUdT+Pc12FeqZEhkmCZzzsZBoAORustgY
	PpDByI655rn7221akMXmva9ZhirNVbV4l1rpFyppkkF2EkCP9vchiekD5AElUwWpIPNU5MPEjyc
	RwXbLlpFUFXkM62JPzYT+STuHtcPrEyzDkDiD2idrSzjnXwO0ne+eH4Ei8jkODURcPbox5NgxRz
	r1/VY8mRQJNkvmvwjIofQ1rAiNIi47J4blwmtG6MN6xvbE8a2UQd87TqtC6eleYiC1wExIpRZQb
	ppg3PdvI=
X-Google-Smtp-Source: AGHT+IEPhl7M3pPKVKJRRGXgxtNYr3mSuepsFyT/fNiRn/kJBm9O1QrZ8LLvefwHdmgY4q+idaONGw==
X-Received: by 2002:a05:620a:4456:b0:7d4:2925:91b8 with SMTP id af79cd13be357-7d5ef7c4961mr28485585a.16.1751660169087;
        Fri, 04 Jul 2025 13:16:09 -0700 (PDT)
Received: from 156.1.168.192.in-addr.arpa ([2600:4041:5c29:e400:94f3:d2bb:5ace:77a1])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a9949e5221sm19772941cf.2.2025.07.04.13.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 13:16:08 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 04 Jul 2025 16:14:56 -0400
Subject: [PATCH 5/6] rust: add `CStr` methods matching `core::ffi::CStr`
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250704-core-cstr-prepare-v1-5-a91524037783@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1751660161; l=3187;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=ijekkld9R1wbyb2cvN5FAg3adFOAIGh+Sl7Wg4UqSo0=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QPIwxczA1HLqncTECE1BZLwn/UXLVbajrq24i9LGs2u/GwbE2mHvzVz95Yp9yW1WgfD35PH8Hrr
 KgvLRh39BRgE=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Prepare for replacing `CStr` with `core::ffi::CStr` by soft-deprecating
methods which don't exist on `core::ffi::CStr`.

We could keep `as_bytes{,_with_nul}` through an extension trait but
seeing as we have to introduce `as_char_ptr_in_const_context` as a free
function, we may as well introduce `to_bytes{,_with_nul}` here to allow
downstream code to migrate in one cycle rather than two.

Link: https://github.com/Rust-for-Linux/linux/issues/1075
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/str.rs | 37 ++++++++++++++++++++++++++++++++++---
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index f326f0c40ab0..cbb357fc0111 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -175,6 +175,15 @@ macro_rules! b_str {
     }};
 }
 
+/// Returns a C pointer to the string.
+// It is a free function rather than a method on an extension trait because:
+//
+// - error[E0379]: functions in trait impls cannot be declared const
+#[inline]
+pub const fn as_char_ptr_in_const_context(c_str: &CStr) -> *const c_char {
+    c_str.0.as_ptr()
+}
+
 /// Possible errors when using conversion functions in [`CStr`].
 #[derive(Debug, Clone, Copy)]
 pub enum CStrConvertError {
@@ -294,23 +303,45 @@ pub unsafe fn from_bytes_with_nul_unchecked_mut(bytes: &mut [u8]) -> &mut CStr {
     }
 
     /// Returns a C pointer to the string.
+    ///
+    /// Using this function in a const context is deprecated in favor of
+    /// [`as_char_ptr_in_const_context`] in preparation for replacing `CStr` with `core::ffi::CStr`
+    /// which does not have this method.
     #[inline]
     pub const fn as_char_ptr(&self) -> *const c_char {
-        self.0.as_ptr()
+        as_char_ptr_in_const_context(self)
     }
 
     /// Convert the string to a byte slice without the trailing `NUL` byte.
     #[inline]
-    pub fn as_bytes(&self) -> &[u8] {
+    pub fn to_bytes(&self) -> &[u8] {
         &self.0[..self.len()]
     }
 
+    /// Convert the string to a byte slice without the trailing `NUL` byte.
+    ///
+    /// This function is deprecated in favor of [`Self::to_bytes`] in preparation for replacing
+    /// `CStr` with `core::ffi::CStr` which does not have this method.
+    #[inline]
+    pub fn as_bytes(&self) -> &[u8] {
+        self.to_bytes()
+    }
+
     /// Convert the string to a byte slice containing the trailing `NUL` byte.
     #[inline]
-    pub const fn as_bytes_with_nul(&self) -> &[u8] {
+    pub const fn to_bytes_with_nul(&self) -> &[u8] {
         &self.0
     }
 
+    /// Convert the string to a byte slice containing the trailing `NUL` byte.
+    ///
+    /// This function is deprecated in favor of [`Self::to_bytes_with_nul`] in preparation for
+    /// replacing `CStr` with `core::ffi::CStr` which does not have this method.
+    #[inline]
+    pub const fn as_bytes_with_nul(&self) -> &[u8] {
+        self.to_bytes_with_nul()
+    }
+
     /// Yields a [`&str`] slice if the [`CStr`] contains valid UTF-8.
     ///
     /// If the contents of the [`CStr`] are valid UTF-8 data, this

-- 
2.50.0


