Return-Path: <linux-pm+bounces-34396-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42457B51EE7
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 19:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F18655E832F
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 17:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AFC5321448;
	Wed, 10 Sep 2025 17:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="Y4gkSs61"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2ED279792;
	Wed, 10 Sep 2025 17:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757525354; cv=pass; b=AJDfymteaxdK8KecixwmGmmmQgQ81P1rxbyDSoGIijT9arHRAoTpjngptT8QF90Kg3kCXsKpViiNoFQsGbDQ5rWY75ob/q44dRXCHd16+GPfFTR5Nr+f1tDn+Zb0TbZKG4qVMNw/qpr7JunrAa/gABo/ZgM84330oDdndYwtdgo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757525354; c=relaxed/simple;
	bh=+sY7esOV4ftXk/7FoFtS2AcrS5EdQ0OEfrcxwpsWu0A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wr1Qa8NFmNAcVSM1ydyniV8PC3tu4IsmkLMS+DLkoif8xqmrbKgUywWjW6D1+77AqZz6QBtCAQGqw8Lqc8VNkIOC9sMxinQTg1BfYp677OF4ElnaxBsOC4gn0M2Vb+M/eeA0HMjAe5QdC3TLklH1klXAVyVg6H35JNkSCSDbDDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=Y4gkSs61; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1757525336; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=kjdNOp7l9h6y48lFjyoM0abO9ZJITEneqCk3f77o1YpPZYylfPEym1dEl9EGt3XigSUyAo8jml0Tb1idr5vVtQZ65VQwfa6XDURSCkN4ShwdyTYMLrQaAR3BwWWKkUglNG0QSzMWJaxymQxZPkEeBN7IdW9GEb/K+kydH1qRklc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757525336; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=5RBAS6Ybhl3OEyHFveyxQEmvr4mrg6ZvjRKJIqMrvgg=; 
	b=OeWwqAa8+8dT4EJ2DQHltISEKU8Jllz2CtX4hiwrdbsj9H4ry6aJdCLUnZ99GyfWR1aQf8wD0XtoHOQUYrs49qSwvFaQiXFZjhHlscy2DR56wRTGEIod0drJzX04k+FCNgzoZZCq9VpkPe3KEr54Tb96HC8yIL3/HmtUPB0Ey4o=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757525336;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=5RBAS6Ybhl3OEyHFveyxQEmvr4mrg6ZvjRKJIqMrvgg=;
	b=Y4gkSs61nnoWK3lu318TiRZ3CSjRi0kOJ0d6dPRKq9gDjQtMWw9cmxa+is7zXdSP
	l7ConYaMEFfWD2aw3AOLpWVQdRuXwBdJXLmee8snKvrQsdu892oHy9ujq/nRxqd5ih9
	2fypgzI8WFwYxsrxjT4pHoV+zS+MAdZygYVoeQmI=
Received: by mx.zohomail.com with SMTPS id 1757525335231838.1458446552067;
	Wed, 10 Sep 2025 10:28:55 -0700 (PDT)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Wed, 10 Sep 2025 14:28:27 -0300
Subject: [PATCH v2 1/2] rust: clk: implement Send and Sync
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-clk-type-state-v2-1-1b97c11bb631@collabora.com>
References: <20250910-clk-type-state-v2-0-1b97c11bb631@collabora.com>
In-Reply-To: <20250910-clk-type-state-v2-0-1b97c11bb631@collabora.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-clk@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Daniel Almeida <daniel.almeida@collabora.com>
X-Mailer: b4 0.14.2
X-ZohoMailClient: External

From: Alice Ryhl <aliceryhl@google.com>

These traits are required for drivers to embed the Clk type in their own
data structures because driver data structures are usually required to
be Send. See e.g. [1] for the kind of workaround that drivers currently
need due to lacking this annotation.

Link: https://lore.kernel.org/rust-for-linux/20250812-tyr-v2-1-9e0f3dc9da95@collabora.com/ [1]
Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Danilo Krummrich <dakr@kernel.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 rust/kernel/clk.rs | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/rust/kernel/clk.rs b/rust/kernel/clk.rs
index 1e6c8c42fb3a321951e275101848b35e1ae5c2a8..0a290202da69669d670ddad2b6762a1d5f1d912e 100644
--- a/rust/kernel/clk.rs
+++ b/rust/kernel/clk.rs
@@ -129,6 +129,13 @@ mod common_clk {
     #[repr(transparent)]
     pub struct Clk(*mut bindings::clk);
 
+    // SAFETY: It is safe to call `clk_put` on another thread than where `clk_get` was called.
+    unsafe impl Send for Clk {}
+
+    // SAFETY: It is safe to call any combination of the `&self` methods in parallel, as the
+    // methods are synchronized internally.
+    unsafe impl Sync for Clk {}
+
     impl Clk {
         /// Gets [`Clk`] corresponding to a [`Device`] and a connection id.
         ///

-- 
2.51.0


