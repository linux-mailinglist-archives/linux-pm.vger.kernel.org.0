Return-Path: <linux-pm+bounces-36408-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D9ABED737
	for <lists+linux-pm@lfdr.de>; Sat, 18 Oct 2025 20:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90C0B3AEC3A
	for <lists+linux-pm@lfdr.de>; Sat, 18 Oct 2025 18:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B231126CE2E;
	Sat, 18 Oct 2025 18:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rAH46SFk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5476259CAF
	for <linux-pm@vger.kernel.org>; Sat, 18 Oct 2025 18:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760810598; cv=none; b=XECfuLjkFLikoz5wkvrACo5XWdX0GHvopBjJYKSXrOK8qgxZb0DQMsTzc7+ZDHoMq9JuwM07eD4WibPVmjW9GKMEejljxeQPOQfyMB8K7dQRpysMfasr+/uEUglCS2m6A0D/LvdSCDV7YcVczOxu40BC6Djr0HXfjL0fUt5pdyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760810598; c=relaxed/simple;
	bh=hMEnshIBBCwKDA9va+C+vgTZ7D8UBppyjlBh7zEwkCg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HCl+lSi1YA6K5D8+B5GbGWsmls3soCQARklpRBo1hw76+yFO2cXlW276RMyCald+8yrV+5W0OgDtR5b0MQ//qMkngCPOdOil+DKTNVISodfuzuD3tdP9lsaEkDV+/zWYegZbrLpZohBf81jiVo+YWBIdswGCORwM3NvIv/DxehI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rAH46SFk; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-47111dc7bdbso24182495e9.0
        for <linux-pm@vger.kernel.org>; Sat, 18 Oct 2025 11:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760810595; x=1761415395; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=P+Xp99Syf6solx7Qtcc9CHjBfbP4dER1f+PiKli4U2c=;
        b=rAH46SFknU6g/O+c9FsM0Mynh5Na/VXbCoy0kaqhgmol+EcG+2U5WNgvTbpujC1pdn
         c135DTKP7q9wPejRxg9bkmkFs3aRlL54p4hOFLGmjUg07Hq4TU4wRgfPFJYRvekZPgrT
         T4my87GpFOArojEb1Pa9Dnbvj0Hrz+JnTEjDvYo7ojwSuhcTvPEt+fp3ypiUcdokhQMV
         gn+1evR8OlBXVQG2oA8xg7lr8JnjpzWDiIga1rLJQW6FDO658c3lQafRxG6M/wsb916J
         RK/SQWcLcaOa6+qHfY0ncZ36onzFoSDspShOjIcHyvqBwsGMhB+bIFdS03TXtou+2jZ9
         S+Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760810595; x=1761415395;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P+Xp99Syf6solx7Qtcc9CHjBfbP4dER1f+PiKli4U2c=;
        b=H6sRBvLkJizZgu2/Pvjqk1+TYGv/ooQ2HSaQJI7If+rN63BfH1sneY7wnTLE4eQ81K
         1zJVQJBS/BXzml9TC+coIwaHjv8NDDGlr8XdrwXdHLz5vm40auDokt4hP+xiPHm24Zy5
         dqBlyv4Vkqw18kSCHYiUtusmh/vUDQt/owJhRDJVnn/clpEO2pK5AppUCKIVE2pG3+nL
         6Y3xMZSa1kKAjrwrJImenSvNkL6ctjHQzlWYtzN5MafrLNqzQ8BJDyAWJ3f/GUdj0NIT
         /+E796yUpdJC0T0aQggzEWEmHUPEa6HAsoB2afSfMcG1H9I/i/QBv5XzqUDwjTX6qQjB
         +ufQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmQ63+TbBMoMlUNbQvJYpF9ZqDXuZiRVZXU64arhicRTPkDgomcQbtUrayeBqmbgLMX02F8MsCbQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YylA9C37YBFODMq7IDtXdli+DrTHBcrQBtkhzXpFJRcEXWeOY2a
	XZrWKaAruEb9CoZ7NHhcLoj4YtKkTiNJKBdOkWjkdhFAq6Dn0uWrx6CdphqIb2BaZYyOzc+H0Pl
	Ni3lWkdGedQDEMMN/Vg==
X-Google-Smtp-Source: AGHT+IFD1cfJ8UvE+arlsN4Q/pztwM830HHKQSYiiR0oQA7gs4M/kyYn5nx3HAt5EUs2SUtbpxbRKJSK1nrxs4c=
X-Received: from wmbz7.prod.google.com ([2002:a05:600c:c087:b0:46f:aa50:d700])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:474a:b0:46f:b42e:e39c with SMTP id 5b1f17b1804b1-4711794902dmr54802325e9.41.1760810594858;
 Sat, 18 Oct 2025 11:03:14 -0700 (PDT)
Date: Sat, 18 Oct 2025 18:03:12 +0000
In-Reply-To: <20251018-cstr-core-v18-0-ef3d02760804@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251018-cstr-core-v18-0-ef3d02760804@gmail.com>
X-Mailer: git-send-email 2.51.0.915.g61a8936c21-goog
Message-ID: <20251018180313.3615630-1-aliceryhl@google.com>
Subject: [PATCH v18 13/16] rust: regulator: use `CStr::as_char_ptr`
From: Alice Ryhl <aliceryhl@google.com>
To: tamird@gmail.com
Cc: Liam.Howlett@oracle.com, a.hindborg@kernel.org, airlied@gmail.com, 
	alex.gaynor@gmail.com, aliceryhl@google.com, arve@android.com, 
	axboe@kernel.dk, bhelgaas@google.com, bjorn3_gh@protonmail.com, 
	boqun.feng@gmail.com, brauner@kernel.org, broonie@kernel.org, 
	cmllamas@google.com, dakr@kernel.org, dri-devel@lists.freedesktop.org, 
	gary@garyguo.net, gregkh@linuxfoundation.org, jack@suse.cz, 
	joelagnelf@nvidia.com, justinstitt@google.com, kwilczynski@kernel.org, 
	leitao@debian.org, lgirdwood@gmail.com, linux-block@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-pm@vger.kernel.org, llvm@lists.linux.dev, longman@redhat.com, 
	lorenzo.stoakes@oracle.com, lossin@kernel.org, maco@android.com, 
	mcgrof@kernel.org, mingo@redhat.com, mmaurer@google.com, morbo@google.com, 
	mturquette@baylibre.com, nathan@kernel.org, nick.desaulniers+lkml@gmail.com, 
	nm@ti.com, ojeda@kernel.org, peterz@infradead.org, rafael@kernel.org, 
	russ.weight@linux.dev, rust-for-linux@vger.kernel.org, sboyd@kernel.org, 
	simona@ffwll.ch, surenb@google.com, tkjos@android.com, tmgross@umich.edu, 
	urezki@gmail.com, vbabka@suse.cz, vireshk@kernel.org, viro@zeniv.linux.org.uk, 
	will@kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Tamir Duberstein <tamird@gmail.com>

Replace the use of `as_ptr` which works through `<CStr as
Deref<Target=&[u8]>::deref()` in preparation for replacing
`kernel::str::CStr` with `core::ffi::CStr` as the latter does not
implement `Deref<Target=&[u8]>`.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/regulator.rs | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/regulator.rs b/rust/kernel/regulator.rs
index b55a201e5029..65a4eb096cae 100644
--- a/rust/kernel/regulator.rs
+++ b/rust/kernel/regulator.rs
@@ -84,7 +84,7 @@ pub struct Error<State: RegulatorState> {
 pub fn devm_enable(dev: &Device<Bound>, name: &CStr) -> Result {
     // SAFETY: `dev` is a valid and bound device, while `name` is a valid C
     // string.
-    to_result(unsafe { bindings::devm_regulator_get_enable(dev.as_raw(), name.as_ptr()) })
+    to_result(unsafe { bindings::devm_regulator_get_enable(dev.as_raw(), name.as_char_ptr()) })
 }
 
 /// Same as [`devm_enable`], but calls `devm_regulator_get_enable_optional`
@@ -102,7 +102,9 @@ pub fn devm_enable(dev: &Device<Bound>, name: &CStr) -> Result {
 pub fn devm_enable_optional(dev: &Device<Bound>, name: &CStr) -> Result {
     // SAFETY: `dev` is a valid and bound device, while `name` is a valid C
     // string.
-    to_result(unsafe { bindings::devm_regulator_get_enable_optional(dev.as_raw(), name.as_ptr()) })
+    to_result(unsafe {
+        bindings::devm_regulator_get_enable_optional(dev.as_raw(), name.as_char_ptr())
+    })
 }
 
 /// A `struct regulator` abstraction.
@@ -268,7 +270,8 @@ pub fn get_voltage(&self) -> Result<Voltage> {
     fn get_internal(dev: &Device, name: &CStr) -> Result<Regulator<T>> {
         // SAFETY: It is safe to call `regulator_get()`, on a device pointer
         // received from the C code.
-        let inner = from_err_ptr(unsafe { bindings::regulator_get(dev.as_raw(), name.as_ptr()) })?;
+        let inner =
+            from_err_ptr(unsafe { bindings::regulator_get(dev.as_raw(), name.as_char_ptr()) })?;
 
         // SAFETY: We can safely trust `inner` to be a pointer to a valid
         // regulator if `ERR_PTR` was not returned.
-- 
2.51.0.915.g61a8936c21-goog


