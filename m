Return-Path: <linux-pm+bounces-30182-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E559AF9B95
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 22:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 088341C262A0
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 20:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A8F24500A;
	Fri,  4 Jul 2025 20:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WcWytZQJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B8823BD1F;
	Fri,  4 Jul 2025 20:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751660169; cv=none; b=OPMo5cgQ8rlFP56T+F9SCMcIqpsM4rXTWjsES7fk9ZybKNbIHMVfOQ/TzHOjmz6Sn/++sj3inhZBdDwQRNMO6WPHVkPCAPbeZ5kmcJz2F/8tySfbHs5Y/gfXm0xjgs0jeWVHD2HQE+BTSKk2Mm4u/N19oU1tHkkde1ps9sbZisk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751660169; c=relaxed/simple;
	bh=pDl2EDPfxPEYVWR9FNKoe/jjP+2a7nwmEQia5/vDvaQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PTP+X26Pix4moDpdY5hkauDtJQvigcz71wYjTyCmel7d+sqEJla4s+tQaG4RXWcazoQ4+QwmKwjkxkaAI0yMscxjo8pM2zCNMHY5J4d604gAxEL1Y09KorjNEsgLuJqExLm2A/DPR36V7MhhSVFzmnDQcfA8BaehRsiACIkJ1J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WcWytZQJ; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4a76ea97cefso13098201cf.2;
        Fri, 04 Jul 2025 13:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751660167; x=1752264967; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IjAX5By1woBTkVbpv4Ax05fTUisbOPE+2UGRU9+yRbU=;
        b=WcWytZQJ6vpFCLHH3jz9Cqtk2fgeopjU6zHk4kx4YlAtAgS/YY3hg/Gsic23CW9IfD
         q4I4t8N73ukzyAbmO+W7j8ECMwoNVy3DdNz1WVIyNzBfxNGvEYM0vhp/CKXsDETDyVzC
         RrwhoqtRAdWHoNDfs/jXKvD0/JCf3PRUS6E7rNw59XGHt2cIV6c1mxH5BYLje2VU4jpB
         8Pr1NmJv9DinMTqLMrye/0z5/I0k09A53hAWb2G2su0YOOlOG7hK0axm6TYYNc17LCDn
         HhFbxcY/FI5t2WHFQqxu3ECNdonVn0nbPhvzKFKnLF9Q+GfFZDqjxtvTRL6HXDCPtcgA
         4xTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751660167; x=1752264967;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IjAX5By1woBTkVbpv4Ax05fTUisbOPE+2UGRU9+yRbU=;
        b=OaPnyVucBBxfVnt/DZXV0ucz4OKrxWdmuX1riXdasozZQtv3yGbqItNJkr3NerN69v
         lSm8xve/FHTqXyXZZnPGsTQIjv/v1xVKONHwjfRQf/ocFOsSbx5XMLnxqXsI7HN60CFD
         VTdmcVBCsP0YwPieIYAvorxEVLPRo7Sc3eDPILG97RdpQ9868fPrzWQ1mFdqe/m8qOHO
         APYACgT9UtbMVqKOBAmBZ/EibU+2NKW4xS40+IPHM6SJzYR2lqmt8LPY2+DStYD1HD2U
         D5CIw83u9SQpe3PlRWt7AlYCiA/W9OUaCnXLntWB8Ote4VmSJriRY54gxGIOjUpIoRg/
         NHWA==
X-Forwarded-Encrypted: i=1; AJvYcCUwW3L4553Y+Ku+g/EuwdX7ZntOUjqzbT0Nh1OaHhss4Gn5WJKt5vMVYFkVTCT6tzoXfzZL9JMnnmyEkKc9wlM=@vger.kernel.org, AJvYcCVxnk3ZmTFlj0Lub0Rc6/JAmd9NdoFQloF9nNfFWT1NwLk17ZLQXi7IdlgokOq/4/EFLoC1QdL6O6oGfwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQVyhMlZ4kt+2X9gG2OQa/SUwazXDkhce2vlfEExQWEJ9+BqYo
	tChmtDCrM9Y3TnFaZFscYLvJyR0x77LsWX5vv0+/2VMA5leldsE7ETMy
X-Gm-Gg: ASbGncvBfnUeqfHQXyqeM2n9q2Ol5SsK63vag7QkmYmk4JzTxg1I7gYjgGTAUMYA3tt
	1hxwnCkUGHA+qRMxUsldoIvA36DLVP65kEJHsE0dSs2lEs2tfU/SY55Z91m54EBpRLEPrS/pfd+
	3YdztZ94x5PTlJdnESU2faxUyeBhRoIyjEVOifu0O/I3ukQv0gjKolrA3G4/q3XJRBxGe4j1j3A
	N+JoTjXfT02zlir3yzb+2F8zVvhPUuwnadXkGvlWT84QfYJbDI22DgGjTrgkvLSnJtUSXIwDsNG
	GIgvjOYM4NttyNafKFJLwXWcOyzadMi9WfiVx4qhIWYHPxbhymBNvChwsIAvOP7vLXcZ1szArhL
	0re2EfKo=
X-Google-Smtp-Source: AGHT+IHoJuyrMg+1Oet7D/5z8M7VsWfC8gsB87eCJncM3DAyTr2cIYU7OHvXVugATk7u3p3qiIn2YQ==
X-Received: by 2002:a05:622a:316:b0:4a4:4063:94d1 with SMTP id d75a77b69052e-4a9985e0c0cmr42987461cf.8.1751660166573;
        Fri, 04 Jul 2025 13:16:06 -0700 (PDT)
Received: from 156.1.168.192.in-addr.arpa ([2600:4041:5c29:e400:94f3:d2bb:5ace:77a1])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a9949e5221sm19772941cf.2.2025.07.04.13.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 13:16:06 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 04 Jul 2025 16:14:54 -0400
Subject: [PATCH 3/6] rust: use `kernel::{fmt,prelude::fmt!}`
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250704-core-cstr-prepare-v1-3-a91524037783@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1751660160; l=3354;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=pDl2EDPfxPEYVWR9FNKoe/jjP+2a7nwmEQia5/vDvaQ=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QCBuyGbM9Ex3z6w+I8XsfYWnnt5RfWTJc8W/D+LryP6sut6ti1h3WTUJlGdh3zPO073i/ELXAnX
 ilrfpP+tUvgE=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Reduce coupling to implementation details of the formatting machinery by
avoiding direct use for `core`'s formatting traits and macros.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/error.rs            | 6 +++---
 rust/kernel/print.rs            | 6 +++---
 rust/kernel/str.rs              | 2 +-
 samples/rust/rust_print_main.rs | 2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index 6277af1c1baa..ffa8efd2d547 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -6,10 +6,10 @@
 
 use crate::{
     alloc::{layout::LayoutError, AllocError},
+    fmt,
     str::CStr,
 };
 
-use core::fmt;
 use core::num::NonZeroI32;
 use core::num::TryFromIntError;
 use core::str::Utf8Error;
@@ -219,8 +219,8 @@ fn from(_: LayoutError) -> Error {
     }
 }
 
-impl From<core::fmt::Error> for Error {
-    fn from(_: core::fmt::Error) -> Error {
+impl From<fmt::Error> for Error {
+    fn from(_: fmt::Error) -> Error {
         code::EINVAL
     }
 }
diff --git a/rust/kernel/print.rs b/rust/kernel/print.rs
index ecdcee43e5a5..2d743d78d220 100644
--- a/rust/kernel/print.rs
+++ b/rust/kernel/print.rs
@@ -8,10 +8,10 @@
 
 use crate::{
     ffi::{c_char, c_void},
+    fmt,
     prelude::*,
     str::RawFormatter,
 };
-use core::fmt;
 
 // Called from `vsprintf` with format specifier `%pA`.
 #[expect(clippy::missing_safety_doc)]
@@ -149,7 +149,7 @@ macro_rules! print_macro (
         // takes borrows on the arguments, but does not extend the scope of temporaries.
         // Therefore, a `match` expression is used to keep them around, since
         // the scrutinee is kept until the end of the `match`.
-        match format_args!($($arg)+) {
+        match $crate::prelude::fmt!($($arg)+) {
             // SAFETY: This hidden macro should only be called by the documented
             // printing macros which ensure the format string is one of the fixed
             // ones. All `__LOG_PREFIX`s are null-terminated as they are generated
@@ -168,7 +168,7 @@ macro_rules! print_macro (
     // The `CONT` case.
     ($format_string:path, true, $($arg:tt)+) => (
         $crate::print::call_printk_cont(
-            format_args!($($arg)+),
+            $crate::prelude::fmt!($($arg)+),
         );
     );
 );
diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index 10399fb7af45..48d9a518db96 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -3,7 +3,7 @@
 //! String representations.
 
 use crate::alloc::{flags::*, AllocError, KVec};
-use core::fmt::{self, Write};
+use crate::fmt::{self, Write};
 use core::ops::{self, Deref, DerefMut, Index};
 
 use crate::prelude::*;
diff --git a/samples/rust/rust_print_main.rs b/samples/rust/rust_print_main.rs
index 8ea95e8c2f36..4095c72afeab 100644
--- a/samples/rust/rust_print_main.rs
+++ b/samples/rust/rust_print_main.rs
@@ -40,7 +40,7 @@ fn arc_print() -> Result {
         // behaviour, contract or protocol on both `i32` and `&str` into a single `Arc` of
         // type `Arc<dyn Display>`.
 
-        use core::fmt::Display;
+        use kernel::fmt::Display;
         fn arc_dyn_print(arc: &Arc<dyn Display>) {
             pr_info!("Arc<dyn Display> says {arc}");
         }

-- 
2.50.0


