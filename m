Return-Path: <linux-pm+bounces-25514-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6409CA8B08F
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 08:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B67B1890D8F
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 06:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B832309A6;
	Wed, 16 Apr 2025 06:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DroUADkf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6A422FE0C
	for <linux-pm@vger.kernel.org>; Wed, 16 Apr 2025 06:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744785617; cv=none; b=MmCpOgxxMrNlGaySO7TUzrDhsmCaphRgzE70LwC9SaofXgRy8kggME8mHEFQQza53zCdvKoMU8ciBE6BrXVNj7Z3nx0SjFgx14PqOylOwquyHeEx7iOeXAT81rf7TcKAqKMYT639VwvzesRe6xeH1EpfB7EZeNIvzqu5dKfqO90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744785617; c=relaxed/simple;
	bh=RPs39+G/2/WRBdJP3KwTQnQlR3Lp/kvURzUIgtDgvwA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jUydt/zaktmreM2MAxdzLuSuHIsIb1XRRhR7rbzZwlcn70zs6fDF2zdw6xSvSSPwkRd5ilIqF3pOhXAK06sD5bNJ3mJFZayGHybE+opNzl1Hoqh16i+CJtYBw5dp7c2vBrFoBOn0aSv9dvCfbFW+XrnmFcYsqAL6qRlTUVOTE5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DroUADkf; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22c33ac23edso3684845ad.0
        for <linux-pm@vger.kernel.org>; Tue, 15 Apr 2025 23:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744785614; x=1745390414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=06XWI3zWvI8xB81BSzBcpZnXhq7zBjUBfZT4cp51CDs=;
        b=DroUADkfGP9ENmXbc0Ucy2ZkNEfwC5hYWmEuM/MFlN9DGve7mzqEKrl6YjeKJLGDzQ
         M7oEKXY8WkeBgKssiS+4MZJhzL+yMh8+IaNGcreuFFMa+78svFmVlCF3QQOzPUvopZw3
         n0MX089dXsGmhZDM6prwNGq5XHjcAKt0iAbLGMf74cAQSf8M3K3xkFxqO/32ZVJWTgOS
         mzE7FmNUj9uJoTJpXn0871RgLg1s5VqOxT7eQVo4ovVJHj1ra7FRrmm4O0HeVPSa7Y1T
         6dLZiMgTiqDBWt1cHGRHp3JSRVHl8M3IH8EhYDNQUzRFXFNiYKMmSsDf+ol99rlYbK0S
         lM6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744785614; x=1745390414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=06XWI3zWvI8xB81BSzBcpZnXhq7zBjUBfZT4cp51CDs=;
        b=ateR3SxzohhQLl+vtx1ajYz06Vh7ibBhkU5PJ8qQuMWpwlMeht7C8ZLkAu9y1TYyCu
         uKqBC4McWwbu8lKlfAeAyAE8bUe96XHcrWjTuC7/v2r0Y7gfCWzOO/uSCe23sjwy7lCn
         eVunZRmrOkbHT2C82fvupAVye7DlF7ReXtXAISpYG8FVGuHUUozbDXuAoFhVG4PB+x8q
         5NI0M5nEOyqoHR3ugUjs+yGdmVYX7e0pCmkbN8OHZuOSZF889zNfkPEsBGFZPt3peKlZ
         k5xaiYP1Q55N/JOfdlFmRvAJpDNjcjNKRwjagq/V15ifd+uck0Yh/Tpa/XgLAdeclkS2
         u5LQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGVTugdURerp9L9cLDb1kT7AG8U2w/4nqBWQr0eXquHUCpAWyt8WdxmHnzRTHqZkYeS2S6ilTZPg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+uPRLdiqTJw1p/K0zyP9w4idx9j09IuQlpCe/wap3mhJKCjMp
	OPp+tq4OqxJPocuDmDgq7ggRYfletFDIAuZkqBO+gNS3JG1APZYvfrk0zUC3rrQ=
X-Gm-Gg: ASbGncvjv7NjVDsjPDdiOjZ9O4+DPx5qiH4PTQrqxtJmLW/znFqIf7vxAA7c8P8Lh5m
	ZcGIc1vMwMVhhdXYnsdbOnulwF/HFgVbqdjZQdw5Kb7aJMzkKPMjoezu+E1ZHy4hESGjFh9W6gG
	E6XprhMsNH6CPI2PlPRziM4e91DVb5Ul3c/sVJhGpCA2+hXvEuMokjcWfhKuv3jf4bVYk263V/c
	QNJH0rwi6bWu7gJJ8ZBZ+yDunbvc3NpvYnSvaWWuzcLKz+tyRhSLaWx0TxuT1s7hGB4wQ2KEuCe
	1NHKxqW4AAVy7VEYPec1Fs1SgJPt2FPiNYatlhP6pQ==
X-Google-Smtp-Source: AGHT+IF2Rglo7eHxKgDEgBNsJGaQtvp/oXKgIHcXad7KTacx4TnahZHOzUtBIJLTVG1uvlzQ1gByKw==
X-Received: by 2002:a17:903:84f:b0:224:122d:d2de with SMTP id d9443c01a7336-22c358ddb96mr9533055ad.16.1744785614335;
        Tue, 15 Apr 2025 23:40:14 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33ef0e83sm6446415ad.35.2025.04.15.23.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 23:40:13 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Danilo Krummrich <dakr@redhat.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Yury Norov <yury.norov@gmail.com>,
	Burak Emir <bqe@google.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Russell King <linux@armlinux.org.uk>,
	linux-clk@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	Anisse Astier <anisse@astier.eu>,
	linux-kernel@vger.kernel.org
Subject: [PATCH V10 06/15] rust: macros: enable use of hyphens in module names
Date: Wed, 16 Apr 2025 12:09:23 +0530
Message-Id: <b7f534dfbb63aa0e8acfe90f122e23ad052d5e19.1744783509.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1744783509.git.viresh.kumar@linaro.org>
References: <cover.1744783509.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anisse Astier <anisse@astier.eu>

Some modules might need naming that contains hyphens "-" to match the
auto-probing by name in the platform devices that comes from the device
tree.

But rust identifiers cannot contain hyphens, so replace the module name
by an underscore anywhere we'd use it as an identifier.

Signed-off-by: Anisse Astier <anisse@astier.eu>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
[Viresh: Replace "-" with '-', and fix line length checkpatch warnings]
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 rust/macros/module.rs | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/rust/macros/module.rs b/rust/macros/module.rs
index a9418fbc9b44..27cc72d474f0 100644
--- a/rust/macros/module.rs
+++ b/rust/macros/module.rs
@@ -185,7 +185,9 @@ pub(crate) fn module(ts: TokenStream) -> TokenStream {
 
     let info = ModuleInfo::parse(&mut it);
 
-    let mut modinfo = ModInfoBuilder::new(info.name.as_ref());
+    /* Rust does not allow hyphens in identifiers, use underscore instead */
+    let name_identifier = info.name.replace('-', "_");
+    let mut modinfo = ModInfoBuilder::new(name_identifier.as_ref());
     if let Some(author) = info.author {
         modinfo.emit("author", &author);
     }
@@ -310,14 +312,15 @@ mod __module_init {{
                     #[doc(hidden)]
                     #[link_section = \"{initcall_section}\"]
                     #[used]
-                    pub static __{name}_initcall: extern \"C\" fn() -> kernel::ffi::c_int = __{name}_init;
+                    pub static __{name_identifier}_initcall: extern \"C\" fn() ->
+                        kernel::ffi::c_int = __{name_identifier}_init;
 
                     #[cfg(not(MODULE))]
                     #[cfg(CONFIG_HAVE_ARCH_PREL32_RELOCATIONS)]
                     core::arch::global_asm!(
                         r#\".section \"{initcall_section}\", \"a\"
-                        __{name}_initcall:
-                            .long   __{name}_init - .
+                        __{name_identifier}_initcall:
+                            .long   __{name_identifier}_init - .
                             .previous
                         \"#
                     );
@@ -325,7 +328,7 @@ mod __module_init {{
                     #[cfg(not(MODULE))]
                     #[doc(hidden)]
                     #[no_mangle]
-                    pub extern \"C\" fn __{name}_init() -> kernel::ffi::c_int {{
+                    pub extern \"C\" fn __{name_identifier}_init() -> kernel::ffi::c_int {{
                         // SAFETY: This function is inaccessible to the outside due to the double
                         // module wrapping it. It is called exactly once by the C side via its
                         // placement above in the initcall section.
@@ -335,13 +338,13 @@ mod __module_init {{
                     #[cfg(not(MODULE))]
                     #[doc(hidden)]
                     #[no_mangle]
-                    pub extern \"C\" fn __{name}_exit() {{
+                    pub extern \"C\" fn __{name_identifier}_exit() {{
                         // SAFETY:
                         // - This function is inaccessible to the outside due to the double
                         //   module wrapping it. It is called exactly once by the C side via its
                         //   unique name,
-                        // - furthermore it is only called after `__{name}_init` has returned `0`
-                        //   (which delegates to `__init`).
+                        // - furthermore it is only called after `__{name_identifier}_init` has
+                        //   returned `0` (which delegates to `__init`).
                         unsafe {{ __exit() }}
                     }}
 
@@ -381,6 +384,7 @@ unsafe fn __exit() {{
         ",
         type_ = info.type_,
         name = info.name,
+        name_identifier = name_identifier,
         modinfo = modinfo.buffer,
         initcall_section = ".initcall6.init"
     )
-- 
2.31.1.272.g89b43f80a514


