Return-Path: <linux-pm+bounces-32389-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B18B26141
	for <lists+linux-pm@lfdr.de>; Thu, 14 Aug 2025 11:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99C035C2BBE
	for <lists+linux-pm@lfdr.de>; Thu, 14 Aug 2025 09:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F449307480;
	Thu, 14 Aug 2025 09:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hpc3ENZq"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FD1302779;
	Thu, 14 Aug 2025 09:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755163911; cv=none; b=Bf3YNCHbFhyY0+yL5NTvCCQEmp0wmOy0FTEKPMFx8UqiouHPN9oVViOcH4xz1nqxequPVNmj8Qsz1/TG9o8oekMb+IZVZ24p9R64WfKj6uJa2JS0Wudy7O+rlDr1wZWZuFpBsZ5KZ4fL8kdm0mabTmDCWHhEZwGKVuO3BfhJGGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755163911; c=relaxed/simple;
	bh=e9mgz8XbeaX7DTGVgHJOp/zC3oQa22JUfQ5bhgnwxPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b8dJiVAnqkbpMI47zMgS/GEcE8SeaXaX55Yw6kofb5XmUNTYZMOFCFuxjrQAo2PtbHxf9eOdTXSYyDsUdxU1j/rbDEZ1/NnOgkjqR8d5q9yznQiKQHgh/hUxPaxkbBR449sJ5ZPui7URlQRhQv/2iDrbUe3WX2foI4DthsxAuQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hpc3ENZq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE206C4CEEF;
	Thu, 14 Aug 2025 09:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755163910;
	bh=e9mgz8XbeaX7DTGVgHJOp/zC3oQa22JUfQ5bhgnwxPo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hpc3ENZqf4EbC8ZV20nW0mMu+FBQ1KYLpSHcZAao2EFG7uE/JCFGYRuYUvC0U5XIc
	 g00C41cxSR9+hEzl+sDRTJQXSnS4nN4JK4MhJebJCOBOSqEQc2ipwsDOW28k15PY+a
	 JcnXvgXuATAr8CXmYGFjWVFK4dCMwFA9zI+VOTd7b4cHFXMP0mI9V9St1Mk7sXy6l6
	 KodOd66b5OBvXiN3H3HJOKai3aoJMoMYi/MX8JtMnsmmT5nigw1mnPXZquwOH1e3Kc
	 rzvb3oBJqzD5v50ZNRsp9aTxtTCWwNxtQrI0XqREZ536vkfwKPfeC64g/Z0wszrs5M
	 6UmzJHcfCaTWQ==
From: Benno Lossin <lossin@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>
Cc: linux-pm@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 11/11] rust: cpufreq: replace `MaybeUninit::zeroed().assume_init()` with `pin_init::zeroed()`
Date: Thu, 14 Aug 2025 11:30:38 +0200
Message-ID: <20250814093046.2071971-12-lossin@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814093046.2071971-1-lossin@kernel.org>
References: <20250814093046.2071971-1-lossin@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All types in `bindings` implement `Zeroable` if they can, so use
`pin_init::zeroed` instead of relying on `unsafe` code.

If this ends up not compiling in the future, something in bindgen or on
the C side changed and is most likely incorrect.

Signed-off-by: Benno Lossin <lossin@kernel.org>
---
 rust/kernel/cpufreq.rs | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
index afc15e72a7c3..be2dffbdb546 100644
--- a/rust/kernel/cpufreq.rs
+++ b/rust/kernel/cpufreq.rs
@@ -27,7 +27,6 @@
 use core::{
     cell::UnsafeCell,
     marker::PhantomData,
-    mem::MaybeUninit,
     ops::{Deref, DerefMut},
     pin::Pin,
     ptr,
@@ -1013,8 +1012,7 @@ impl<T: Driver> Registration<T> {
         } else {
             None
         },
-        // SAFETY: All zeros is a valid value for `bindings::cpufreq_driver`.
-        ..unsafe { MaybeUninit::zeroed().assume_init() }
+        ..pin_init::zeroed()
     };
 
     const fn copy_name(name: &'static CStr) -> [c_char; CPUFREQ_NAME_LEN] {
-- 
2.50.1


