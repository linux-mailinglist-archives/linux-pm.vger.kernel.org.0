Return-Path: <linux-pm+bounces-32451-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B28B28560
	for <lists+linux-pm@lfdr.de>; Fri, 15 Aug 2025 19:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAF70BA1A92
	for <lists+linux-pm@lfdr.de>; Fri, 15 Aug 2025 17:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51125308F3E;
	Fri, 15 Aug 2025 17:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQAKB6xA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4551304BC8;
	Fri, 15 Aug 2025 17:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755279985; cv=none; b=G5Xdx1Lwn+Xwc6TMOkHo8pG/GKdXYCVul1gIVgueqYLumV2Nkt+BEubPw7pc880e1aZkCGGr1b7/AtqlmDgfnj2wgw/ZcVWnN+VlkG/kACxn3suz3dedu3ORznacOz8Q6gPnt9WvI4Vg0jG6iL4DU4DXmClw1iu6e5AqhvcA17E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755279985; c=relaxed/simple;
	bh=jE6Pp6L2OL2TLlUfVq0yWoATYJXytDI3BTf78V/V7rc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MKTLN0rS1K6MZJz7tonMkr0QDkZXEeNxinF9/M1BRDoqkX69PP8MaWGkV37X21k4nkj2TGBtRJQjL3uX8iCUrI1n7Ho9MutV5z2yWoJa//bq3zQE0kvxKqCqhD3jpW0F1zI4AoWR00cuSHUvSkaAkWpwMo2bJxa72Lk+4fozwXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BQAKB6xA; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-76e2e88c6a6so2141151b3a.1;
        Fri, 15 Aug 2025 10:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755279983; x=1755884783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CAoAm1nvzb4QTcsR6PtAhKRH3alwBe4wTDb8mT73MCk=;
        b=BQAKB6xAymXcRk/f49QHS8Iaj+6Xbj+RggQuvnN0+rO5G6Ux2Ns9SS0571mTKKGBP3
         aW2htNNiGl3RxQj3HyDJWVayER2oAG3DEpH7OYGNv4U0mKCQwoPaEV6R7I+YTpEClvSF
         0D76NzT3ygKG7AkH0xyoCx3RY+Uzu87UtmfM66yI+45bwMLACeSOSHgQqDth37GXKHrF
         icwrw8whxEG0qK2Nqjo9rXOBofyfsPKl1clcgKBGIRxNFFcU1GDtYtvUi2w1JOODX4Jw
         dmbLBPShti4gFrY/3q7FFavHMP5swUxmZWuAuXRKZUJYad5lGIu5Vtu1ZhhUdYG7RsAT
         uFLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755279983; x=1755884783;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CAoAm1nvzb4QTcsR6PtAhKRH3alwBe4wTDb8mT73MCk=;
        b=hqmfuLUBpyhmwSjGaFzB2UiqszVFffUWCs9gWvnNGzIldP/83L0CTi0GZhsEEUNLNw
         R8oHCE4JneXjCzSIhb9BrswUHlBszG1OinOmADC4/RT5JIG2PYAcqNm+b/Yjh3Qs63Jx
         IILevTlSawqYB8tPy/rQvWqOiiSRDdy87y0uJuVnjsNdTc7+a25BeDe7gpClRjEgjM7i
         4qMdomTljqdtQRg08zLn33/svfRvpAa0bpXbtOvG+VVakQJeB+8mdmwKLUFhidVxnjuw
         P/qtYP13lAxw3ILbka/MHVvkFccJdWaiygcU7GwxM6fSZz8HP8d9f7s22QKPnQPAW7gd
         inhw==
X-Forwarded-Encrypted: i=1; AJvYcCUzI/GXLpoV3dLBknsjDaR/MY5Na3gsDbTZDb4ZwThfyXlEwmy/zg7+5bnQy25zIHPydZsVmNVP5dDW6/IjoLI=@vger.kernel.org, AJvYcCW+devkkywDZziosDdg3LJfVziUCMBDuCbhlG0+YSUe3GhouShcCl5vVyg49I32PtTPWxCH7LQEhzg=@vger.kernel.org, AJvYcCWiErGxSs3PX208fcX3Cr6r2KXzKPDZns2Dcod424WMr2nH5jk1lcPa0ZGlDz450UiJDfc2LRYeAIPTit4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFozQRr8N+LH1eWuaBfxZ79u+5YozrY0fQwppexROAAXdEX1fa
	MGDTKEfzOsJpBAdCV94q3S8fvZFaptgQhp8JPaVbkSgQxgGXunsOoqDx
X-Gm-Gg: ASbGncvyq0WvA317HiMfhyaQSYS/JkLv+XflkFwWqYig20LxVxgLMzKY25Abcjt+nEi
	F5pzPRB4tDOUcI5gXMSni3xkOPQUffI+DFtOpKtBZq8CzfAdPgMlBmyqQML5qJ7g2KSQOzIjvGf
	I3Icg1CC/wwNy/EMwIWdl3R7PVIHlcICkY5qOz2kV7Z/cysW7Vg3w8tcaWgch6DEZ2JVhmYmcvR
	1LOwuC54NTPB7eukrbZWLS/wJTt0dkStbwKw8Ei23oA0QMYx0aZfxuG7WYNjaZbCsSWJVgzeqVa
	D/QXm3SexsDGlCGQ1Q+1OUXrfr4kkO6v2iRVZzR9b55+M+PjVW4z0Umgf3pjmI4jAwR/kaBOWeG
	Y2EZtRgNhSh035357s6cNU7ULYkNBgfu9/G9VOeNK6CVDFec=
X-Google-Smtp-Source: AGHT+IEtcQOhbDgsGUg0SWRRnLmrwkd1azvSjgKZCBiKlOFflxFhPaxHFVjS5cT9WfwHWZFo7yBM+A==
X-Received: by 2002:a05:6a20:938e:b0:237:b53b:64dd with SMTP id adf61e73a8af0-240d2da3078mr5425247637.11.1755279982878;
        Fri, 15 Aug 2025 10:46:22 -0700 (PDT)
Received: from shankari-IdeaPad.. ([103.24.60.31])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b472d73aa36sm1778796a12.35.2025.08.15.10.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 10:46:22 -0700 (PDT)
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
Subject: [PATCH v2] rust: opp: update ARef and AlwaysRefCounted imports from sync::aref
Date: Fri, 15 Aug 2025 23:15:21 +0530
Message-Id: <20250815174521.1413560-1-shankari.ak0208@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update call sites in `opp.rs` to import ARef and
AlwaysRefCounted from sync::aref instead of types.

This aligns with the ongoing effort to move ARef and
AlwaysRefCounted to sync.

Suggested-by: Benno Lossin <lossin@kernel.org>
Link: https://github.com/Rust-for-Linux/linux/issues/1173
Signed-off-by: Shankari Anand <shankari.ak0208@gmail.com>
---
Changelog:
v1 - v2 -> Fixed mistake in the commit message

Patch description:
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

base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
-- 
2.34.1


