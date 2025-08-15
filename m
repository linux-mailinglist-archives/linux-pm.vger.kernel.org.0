Return-Path: <linux-pm+bounces-32449-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1E5B2852E
	for <lists+linux-pm@lfdr.de>; Fri, 15 Aug 2025 19:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAE8E1D013B7
	for <lists+linux-pm@lfdr.de>; Fri, 15 Aug 2025 17:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422DD30DEBE;
	Fri, 15 Aug 2025 17:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EUuJ2ft7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F8A30E82E;
	Fri, 15 Aug 2025 17:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755279075; cv=none; b=HgUJsV30HefWCjRVMXQOppiA3PZbUE7khJ6WTtzh0a80K2PLuUd6NgGiVgZa9CHxVmJ5+kVskDxolEYEZzooVrUK2UAdhDqwVvGLmBZGatHz2avrS0VxcgUsMwMKRrDKRmYy+rW7VCnkxx1uyLxt/qKFjDgvSiPWGB1ESvlLFq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755279075; c=relaxed/simple;
	bh=LR2Zxn7a9oUTn9eteSNg5XeMlDNa/pFLknLUG5QufpY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cCA+m5M1T0jHexzdGNEiD+/IoVxBuJ8JUZfTBD2/lwH+zpBmpBVCkPxkLMXoLqJxe2N9PrOrv+beToSOBWJ/FGibJNtFvdIgSoKOf81/pJAb2zLLCxN7hRJwJGcYyYd664anq7RLBAWhXvxpIhn6033NLfbr0VpprtzqsAcnwKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EUuJ2ft7; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-32326e202e0so1894205a91.2;
        Fri, 15 Aug 2025 10:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755279070; x=1755883870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NhDiVZ4ep8hgvM5p/RFuoqBeP9+ExH15bZwBIny9NLY=;
        b=EUuJ2ft70d0oFmvQm018FsITKU5SEgpwYOp8pK28/D5yUJmXs3iTBKO0xJ4awwnLPR
         o8y5vAdk0ut5oM4GiS1li33JdBDVGi0BKDk/yDAW89/xpGuIq44uE5pPRtQGqLvzL867
         DND1EQFw9abPJUQieHbicwCezooURvhMG2jteoiAyVUuD/sL4wBQExq+/NkOHdlS7vBU
         IcKsmnaHdUKj9Gs3gkYwnlyByGnLAgFJJHo3DQ51Zhovj8uINIzFFSGqu2fdu6EGcXcr
         gcitDTxV3/0G8UgpHqH0SvPFsFAfJhz7sYJw/343t4mPgYjKgXlW6wGa6APC3ZKLv9kU
         GlAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755279070; x=1755883870;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NhDiVZ4ep8hgvM5p/RFuoqBeP9+ExH15bZwBIny9NLY=;
        b=Z9H1TJMnzJ2XB2bqSBONO8moWDaMFkR9NHyU7gyo4CDCQ/1WkO/gNkwoSm9hhP2i8f
         emWi80OwUcO8NK+hGLK5Kpg70cVsIclqDvJTRKQ4sRtvWp6CJuvoMj4vPH7nzPpWxBn3
         w+oiNO+WDKVC8hXh5ca10ayhn4NMQ52gi2/wnc9s+yRGh9EunByGBCLomnga9zhLWIku
         aoZsnmzwMkeC1IFbKjW335QVHEdO+e6x/0p+pPfcFjZ6wLPDbJAVp7unhbADLxN7DluI
         EgY35KLHmbwcrazPAFyhdtko4yIUG6Rgyki8Rgi/D2AnVcasFMoAx7nJGkZbljc/AJdT
         zhVA==
X-Forwarded-Encrypted: i=1; AJvYcCU94DpV6zXxP38+/BTxw+B5vtjq9TZWeRl5A4O8/y2rn5Del3BYC/e3o2c1dNBrPf4lqLkNMQkR6GDzb9YIJnU=@vger.kernel.org, AJvYcCWwIKAARbdsahmkZ6VEj3RA1QxITZUpvFb7slADMUdL8gy1GGtTBLJF/h1nWGglvem/TcgpZMF9608=@vger.kernel.org, AJvYcCXjRc9oRcPB6U1j0TMc4pGt649Lo5gSleVmg86YhymvW3Uhsb7sjmNxzLlY5Uo3P8ydwk77vvqXpMnW2QA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6hi5yUGVE9tMiCwdlI+pJVnKefkZQ2JPpP8G3Mv1ylhqnwlEz
	ZhHnu5Yv1rFKN/Ra/HvRry5OMFWkiHUwCEeoWgHym5hZm0+ZyCxFSACk
X-Gm-Gg: ASbGnctKp7fbe5uCpFg7HR56o1i9N/j8g3L6lO/Nzv+mWM6xbkYnpntXKkBI/ZoYtfc
	dDGuhuMRCqcRyEsBI/XtEgMIZc9/yHbfjqWQNxeGtr0N4jN/HdFZbyXiAYFyJaMV+W98Pw0ZmUh
	B64ZXukaq+lhKoOHt5J47GQGYDF/jT9NAjTJtkPR1dqTF+Qr6MvrRJm0lfxYeammAvJ7noQ0D4k
	SNDRrTaGY2yVg6kqOfTcf4gcklhYeR5EQNg0EKF35kqV5T1DA9uLrF2xLXFiLYn76QltyQ4TDdO
	4PFz83W2ds35024venizeUIv5H5cqTsYEA8ynY5B8HqSyuWG2IvR7scx/Toa56qgd+tvlf0c13Q
	pB7u1DCWlUReG+/fXO1M6+7bbAs439YlI0MbXoUhWPDFpXGo=
X-Google-Smtp-Source: AGHT+IHNm1OQ+qrlBpc1xgThKzcpZfw2jYTOuewZe/ivMpE6N/dMPjd/jZj6dBCerEek9K1qd87/jQ==
X-Received: by 2002:a17:90b:134b:b0:321:15f7:3328 with SMTP id 98e67ed59e1d1-32341ec55a9mr5325974a91.18.1755279070448;
        Fri, 15 Aug 2025 10:31:10 -0700 (PDT)
Received: from shankari-IdeaPad.. ([103.24.60.31])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32344f137cbsm661475a91.3.2025.08.15.10.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 10:31:09 -0700 (PDT)
From: Shankari Anand <shankari.ak0208@gmail.com>
To: Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	linux-pm@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shankari Anand <shankari.ak0208@gmail.com>
Subject: [PATCH] rust: opp: update ARef and AlwaysRefCounted imports from sync::aref
Date: Fri, 15 Aug 2025 23:00:58 +0530
Message-Id: <20250815173058.1398737-1-shankari.ak0208@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update call sites in drm to import ARef and
AlwaysRefCounted from sync::aref instead of types.

This aligns with the ongoing effort to move ARef and
AlwaysRefCounted to sync.

Suggested-by: Benno Lossin <lossin@kernel.org>
Link: https://github.com/Rust-for-Linux/linux/issues/1173
Signed-off-by: Shankari Anand <shankari.ak0208@gmail.com>
---
It part of a subsystem-wise split series, as suggested in:
https://lore.kernel.org/rust-for-linux/CANiq72=NSRMV_6UxXVgkebmWmbgN4i=sfRszr-G+x3W5A4DYOg@mail.gmail.com/T/#u
This split series is intended to ease review and subsystem-level maintenance.

The original moving patch is here: (commit 07dad44aa9a93)
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=07dad44aa9a93b16af19e8609a10b241c352b440

Gradually the re-export from types.rs will be eliminated in the
future cycle.
---
 rust/kernel/opp.rs | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/rust/kernel/opp.rs b/rust/kernel/opp.rs
index 08126035d2c6..29be7d14025e 100644
--- a/rust/kernel/opp.rs
+++ b/rust/kernel/opp.rs
@@ -16,7 +16,8 @@
     ffi::c_ulong,
     prelude::*,
     str::CString,
-    types::{ARef, AlwaysRefCounted, Opaque},
+    sync::aref::{ARef, AlwaysRefCounted},
+    types::Opaque,
 };
 
 #[cfg(CONFIG_CPU_FREQ)]
@@ -162,7 +163,7 @@ fn from(power: MicroWatt) -> Self {
 /// use kernel::device::Device;
 /// use kernel::error::Result;
 /// use kernel::opp::{Data, MicroVolt, Token};
-/// use kernel::types::ARef;
+/// use kernel::sync::aref::ARef;
 ///
 /// fn create_opp(dev: &ARef<Device>, freq: Hertz, volt: MicroVolt, level: u32) -> Result<Token> {
 ///     let data = Data::new(freq, volt, level, false);
@@ -211,7 +212,7 @@ fn drop(&mut self) {
 /// use kernel::device::Device;
 /// use kernel::error::Result;
 /// use kernel::opp::{Data, MicroVolt, Token};
-/// use kernel::types::ARef;
+/// use kernel::sync::aref::ARef;
 ///
 /// fn create_opp(dev: &ARef<Device>, freq: Hertz, volt: MicroVolt, level: u32) -> Result<Token> {
 ///     let data = Data::new(freq, volt, level, false);
@@ -262,7 +263,7 @@ fn freq(&self) -> Hertz {
 /// use kernel::clk::Hertz;
 /// use kernel::error::Result;
 /// use kernel::opp::{OPP, SearchType, Table};
-/// use kernel::types::ARef;
+/// use kernel::sync::aref::ARef;
 ///
 /// fn find_opp(table: &Table, freq: Hertz) -> Result<ARef<OPP>> {
 ///     let opp = table.opp_from_freq(freq, Some(true), None, SearchType::Exact)?;
@@ -335,7 +336,7 @@ fn drop(&mut self) {
 /// use kernel::error::Result;
 /// use kernel::opp::{Config, ConfigOps, ConfigToken};
 /// use kernel::str::CString;
-/// use kernel::types::ARef;
+/// use kernel::sync::aref::ARef;
 /// use kernel::macros::vtable;
 ///
 /// #[derive(Default)]
@@ -581,7 +582,7 @@ extern "C" fn config_regulators(
 /// use kernel::device::Device;
 /// use kernel::error::Result;
 /// use kernel::opp::Table;
-/// use kernel::types::ARef;
+/// use kernel::sync::aref::ARef;
 ///
 /// fn get_table(dev: &ARef<Device>, mask: &mut Cpumask, freq: Hertz) -> Result<Table> {
 ///     let mut opp_table = Table::from_of_cpumask(dev, mask)?;

base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585-- 
2.34.1


