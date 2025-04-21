Return-Path: <linux-pm+bounces-25779-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61883A94CF2
	for <lists+linux-pm@lfdr.de>; Mon, 21 Apr 2025 09:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DC0B165AA0
	for <lists+linux-pm@lfdr.de>; Mon, 21 Apr 2025 07:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF874257AD4;
	Mon, 21 Apr 2025 07:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XAfcsTJb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438C0255E4C
	for <linux-pm@vger.kernel.org>; Mon, 21 Apr 2025 07:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745220188; cv=none; b=Qiq6RagzdQbfQtn7TGQ7rIEdaGPPN5e2PMDT964S+7YVRc3+L4KL3DrJGUobwscebUnS4KxoKoqKu/ZaVzlL6iL9O9ciO6Qqv+bh3b8/5RHrxF8cmvGDooYwRLPZEvh1oRnMkYdFVxJ7Tlbe3mMmj6EQjTXoYqOR8ZQ6X85V5uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745220188; c=relaxed/simple;
	bh=RPs39+G/2/WRBdJP3KwTQnQlR3Lp/kvURzUIgtDgvwA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cYCLMyYomVHpaJFLMxnSHthFm/cBDiwo1ScWFNOV0xgjx/GDe8Vg340S7rCStt1K83ANn4IbSU8oH2LmpGdy50HWfeVjMZnz7g2BIBscsmN6Ubz6vHmN8gvfU0Np1vH3nINKz2i6dkIz3h1cmOiEBUWiZO/DFmczcbkrAVpf7hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XAfcsTJb; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-224191d92e4so36703125ad.3
        for <linux-pm@vger.kernel.org>; Mon, 21 Apr 2025 00:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745220186; x=1745824986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=06XWI3zWvI8xB81BSzBcpZnXhq7zBjUBfZT4cp51CDs=;
        b=XAfcsTJbmJL+OSKmyD0WVm243+wjfepWXYh3R7aeLQlzDMSnP/r/MQEgqe17BMucAX
         s5PULFCXBcEXtR026bMFAxICr1WX2ersvA3SVA1pbSNICCJMnb3vmXzuXhUT+gNbNCHl
         tj4mkrUbu4cLe0hIk1Z99pD5T6XtKY18X6GnCPaarqahEhRkv9HXYeuOsyzpk1nCseO3
         kH/EZB2WipXcNSVzf32IVsAb1hCpDlF8oCi3pika/0lSCkYg7w4n1NmmKS+godqFojyp
         9lDSl2eN/oVDnflMpxXDvM3gOdip+5cKUTjN22ka48tZjD/gOvGZweBL0BwPcXpLqwcg
         HZPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745220186; x=1745824986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=06XWI3zWvI8xB81BSzBcpZnXhq7zBjUBfZT4cp51CDs=;
        b=Zdxn5U9YtQHmL1rcj6QLvwkCo7p8NEff3cCdtzY27h2lzrGKt2Ko1cJcF/K5jfTC9B
         c6DAKr2CAjnywz7VBH2+HFsxesOy7XbjX+sQAwTtov+cFeloO8NlJ3FXacLojS2b1LqY
         Tjcg+e7Qe5BYym4OMqtLrlJejAwekUEBPAl4Fxtd6I0wc2Cnkn0qQEK+lgMhFkmRMO5Q
         pLW1K+oPbnzzWK5jzoe7m02ePBDlnvC8DCHKIIiQx0Hld+W4J6FFowLA63yOwS4+PVJy
         M3ENtFk1FEysHgd6esl3O0tS9Vz7raA6m9tgqDNKh2Zy8LzBukAPX6wcareE3dIPxhwW
         1GDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWF/zs6PH3WT514uiTAwC0ZZNazP4tlgScVb1/aM+VErh1GC6MLs4irKXGMUYc3NeEfQ9vdiafVFw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyeeBdY/qBGmi4nrzqaqe9h82xy64rTYdNe5+j/wipTnlyz2rUw
	Rn9ykkXGmCf1ux+Siwp2Gf37rBJmsL+I6v3rLM5JjQdnXQZmyCtVGDffCdQhhOQ=
X-Gm-Gg: ASbGnct/qd0poG8WOhJw1Dlv/U/TBM+31RlfaVNnab1blISUGHEWbF23oUXs4nBgEsn
	4hES4is3e4PitygYPRNNGX0EmFe8MMjE4iyCo/uROK9yYlZs5K1muYl5hEMjA3lNzgbg23SShuI
	cJp5A5BHChODbuSIATC8yOgITs6ii/MNCdPlcC/L+G1NodoLzHeZw2PDauneaDmLGH/z3gvVIaM
	UYeXCrKOfQjfBd3NcskNcscfNZY0KlSBJ29gCVYau90a1N5P77Q/t61RbFu7urlr6UOKbZqxv7v
	KLvjnE/fG5xFWhlRUK7MT53pEQ0xEsAxhS6AaKuf5A==
X-Google-Smtp-Source: AGHT+IHzFs+Yl0YKuPCOslDLAjE9ywj82yfkuqAwtgX61FbjT05TSlY35lL/GVySQmYtWNQHRuL2Lw==
X-Received: by 2002:a17:902:dac9:b0:224:a74:28c2 with SMTP id d9443c01a7336-22c535aa4femr163703795ad.29.1745220186519;
        Mon, 21 Apr 2025 00:23:06 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50bf31e7sm59281455ad.55.2025.04.21.00.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 00:23:06 -0700 (PDT)
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
Subject: [PATCH V11 06/15] rust: macros: enable use of hyphens in module names
Date: Mon, 21 Apr 2025 12:52:13 +0530
Message-Id: <b7f534dfbb63aa0e8acfe90f122e23ad052d5e19.1745218975.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1745218975.git.viresh.kumar@linaro.org>
References: <cover.1745218975.git.viresh.kumar@linaro.org>
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


