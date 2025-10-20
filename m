Return-Path: <linux-pm+bounces-36462-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E29BF16FC
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 15:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 789CE1886787
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 13:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7891A313537;
	Mon, 20 Oct 2025 13:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J+G04tYc"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2472F6196;
	Mon, 20 Oct 2025 13:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760965650; cv=none; b=MIk/s1xLmgzNr0YIAnK8x5urhesm91cX2EmNG/AP3FVXFw6McQiTlhPPfjqzGvdEGb0p6k+uPn2LHZSt8qgZ1vU/16MnryjBImEvkswx3PUoidjaEkKb3cXKkIfqY5qvBjhluW9eOlILALiNWTxMiUVuJP04Hu5scej30Mz3XA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760965650; c=relaxed/simple;
	bh=84ijlBcIXDyj2XxLW1M/v22FZDomhnAZOpBhwWY+gj8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=MeoRqyyaXJPkExVPcQQeA4jh5LJTpcqam8tdTCOrR41QXL+KfI+qVzRFVKHX9T3ij9FC60dyhEMpPMOBz3Cz52bg9EHSwbKt3i0Tx22goF3sV3VEPvSvE4zP64sm1fFlhuhFTiXoXnEv/+86cnqT85qfdY3ymb3dj+rzk5uaz/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J+G04tYc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 125E1C4CEF9;
	Mon, 20 Oct 2025 13:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760965649;
	bh=84ijlBcIXDyj2XxLW1M/v22FZDomhnAZOpBhwWY+gj8=;
	h=From:Date:Subject:To:Cc:From;
	b=J+G04tYckYKTK5Fv7opz/ARIwtEcpd1Me7sAxQb80crCGS/FF/ITXqC3DPVs/XH9j
	 VaAWQZV8BEjj3yusnRMMb1GQBDUJ7oADlIX09X4ihVNIc7loysdtraUaIeFg47JlED
	 XqvTqs9/cHF8dq5Fc+COhUL3f6wUCHm6+m0GbMP0gXeaYVJGEDCiqLhoI4Aui6jsIh
	 Xe3C1NzeO7/7Pk6sUq8VJqxVlgdy7LNh3R5aEhQs1W0S3HztVbN0dhlfMnGusb86E/
	 i+UctN8VRIOyvrIcCHmcJ97jz0nFgqt+bP+8m07lsnYVvMTIz4vl0l0etr9l9APkyC
	 DnHeQwf9qWSfg==
From: Tamir Duberstein <tamird@kernel.org>
Date: Mon, 20 Oct 2025 09:07:22 -0400
Subject: [PATCH] rust: opp: simplify callers of `to_c_str_array`
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251020-opp-simpler-code-v1-1-04f7f447712f@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAk09mgC/x3MQQqAIBBA0avIrBtQKYuuEi1KpxqoFIUIxLsnL
 d/i/wyJIlOCUWSI9HBif1eoRoA9lnsnZFcNWupOSTWgDwETX+GkiNY7wm4wRluj+3VroWYh0sb
 vv5zmUj5a6oWMYgAAAA==
X-Change-ID: 20251018-opp-simpler-code-58662c627bf4
To: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>
Cc: linux-pm@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Tamir Duberstein <tamird@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1760965647; l=1850;
 i=tamird@kernel.org; h=from:subject:message-id;
 bh=84ijlBcIXDyj2XxLW1M/v22FZDomhnAZOpBhwWY+gj8=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QHFqjXyc3WyeybzGTMB6Px+KBZWl1fyMKfCJf97ch3/b5poABmNTmH423TIyOELROATh2hm8hsT
 tGJnVm37i5ww=
X-Developer-Key: i=tamird@kernel.org; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Use `Option` combinators to make this a bit less noisy.

Signed-off-by: Tamir Duberstein <tamird@kernel.org>
---
 rust/kernel/opp.rs | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/rust/kernel/opp.rs b/rust/kernel/opp.rs
index 9d6c58178a6f..b84786f45522 100644
--- a/rust/kernel/opp.rs
+++ b/rust/kernel/opp.rs
@@ -443,23 +443,14 @@ pub fn set_supported_hw(mut self, hw: KVec<u32>) -> Result<Self> {
     ///
     /// The returned [`ConfigToken`] will remove the configuration when dropped.
     pub fn set(self, dev: &Device) -> Result<ConfigToken> {
-        let (_clk_list, clk_names) = match &self.clk_names {
-            Some(x) => {
-                let list = to_c_str_array(x)?;
-                let ptr = list.as_ptr();
-                (Some(list), ptr)
-            }
-            None => (None, ptr::null()),
-        };
-
-        let (_regulator_list, regulator_names) = match &self.regulator_names {
-            Some(x) => {
-                let list = to_c_str_array(x)?;
-                let ptr = list.as_ptr();
-                (Some(list), ptr)
-            }
-            None => (None, ptr::null()),
-        };
+        let clk_names = self.clk_names.as_deref().map(to_c_str_array).transpose()?;
+        let clk_names = clk_names.map_or(ptr::null(), |c| c.as_ptr());
+        let regulator_names = self
+            .regulator_names
+            .as_deref()
+            .map(to_c_str_array)
+            .transpose()?;
+        let regulator_names = regulator_names.map_or(ptr::null(), |c| c.as_ptr());
 
         let prop_name = self
             .prop_name

---
base-commit: a1ec674cd709fec213acbb567e699c5f6f58cb60
change-id: 20251018-opp-simpler-code-58662c627bf4

Best regards,
--  
Tamir Duberstein <tamird@kernel.org>


