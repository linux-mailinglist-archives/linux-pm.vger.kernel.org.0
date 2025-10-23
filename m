Return-Path: <linux-pm+bounces-36726-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F449C019A9
	for <lists+linux-pm@lfdr.de>; Thu, 23 Oct 2025 16:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9CDF1A66A40
	for <lists+linux-pm@lfdr.de>; Thu, 23 Oct 2025 14:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC19322C9A;
	Thu, 23 Oct 2025 13:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FG5HYBPS"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E04128E00;
	Thu, 23 Oct 2025 13:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761227990; cv=none; b=c/Y5SrfRYAGBxQBBIn0W49a5gDMAFu26RHyh7PEKD2M9M2RlWkXjLjIYfT6V2B3JBiuBMqJhWBZbkrgJ4wYGEd8vXgmpeUqxvfTKeJ++K0BHVtLrP2bEgtPrgluFBa5UIR/qLGg013JhvXx/M0da6IyGGpy55QodRjI1moTke1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761227990; c=relaxed/simple;
	bh=nct9jhEWSM2GOVnXV2mRTGtn7KkYC3Xu9p8cxI6j6+U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lrpA94bjdM60Vuhw3sRL8EPBf2kyKEQgioysT1xUqUP2CAfJZ0K37rsBNlE0dgupCQhFOdNphj1kuGdBrlc/+NJLouF0PTuP/tNWKqEtQE0+lqwdtCe1xCkHSVHa0gYaVhLj6WQPUxDo1QK7qKiQ6Yj8pgdbivW15DMtPc5B80Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FG5HYBPS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BEA5C4CEE7;
	Thu, 23 Oct 2025 13:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761227990;
	bh=nct9jhEWSM2GOVnXV2mRTGtn7KkYC3Xu9p8cxI6j6+U=;
	h=From:Date:Subject:To:Cc:From;
	b=FG5HYBPSUikmZsTSFt3fwJ82G8umHab6anVu4NLANs49loyR8NGclAVqqjeCchX5P
	 5nwYn9oBYDFEjo4VfpoxJ3VIChoWM1Znen8waWxyZxaMV9hxCgQL3G8FKcX6VRDCpY
	 Yw9QIAZ11MTZPpMrZgKiwfTB20nLwkqi9oFM8ZEV32lc1RI4hOJJvUMnFIHnm17EJN
	 5IxoIrYLaVcj3urUAxzjbQTn8m/6spzs9Wg6G7D8GqsJwzpS9K8xHyexh3hZnJtAas
	 tRYNPkTz8rkAjvBDEb7szB8wJd8lZ59hqVkouLTJwuGO9OmSs/R1k7IebCWHQNQnfl
	 n7hoSMMOFGjng==
From: Tamir Duberstein <tamird@kernel.org>
Date: Thu, 23 Oct 2025 09:59:39 -0400
Subject: [PATCH v2] rust: opp: simplify callers of `to_c_str_array`
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-opp-simpler-code-v2-1-44230ed00fd8@kernel.org>
X-B4-Tracking: v=1; b=H4sIAMo0+mgC/2WNQQ6CMBBFr0K6dkw7KZS48h6GhcIUJiJtpoZoS
 O9uJe5cvpf89zeVSJiSOlWbElo5cVgK4KFS/XRdRgIeCivUWBttWggxQuJHnEmgDwNB3TYN9g2
 6m7eqzKKQ59eevHSFJ07PIO/9YTVf+4uh/o+tBgxo65231jmD/nwnWWg+BhlVl3P+AB+MhcyxA
 AAA
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1761227987; l=6187;
 i=tamird@kernel.org; h=from:subject:message-id;
 bh=nct9jhEWSM2GOVnXV2mRTGtn7KkYC3Xu9p8cxI6j6+U=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QAZzhKgnRlHJSlChXcD5X76nsZnU9ccgzH5xOLYnJs0pGCxi5SkV+t4EjTlcabtsqGGEMERw/F8
 jJc18QDR+zQU=
X-Developer-Key: i=tamird@kernel.org; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Use `Option` combinators to make this a bit less noisy.

Wrap the `dev_pm_opp_set_config` operation in a closure and use type
ascription to leverage the compiler to check for use after free.

Signed-off-by: Tamir Duberstein <tamird@kernel.org>
---
Note: this diff is much smaller with whitespace suppressed (`-w`).

An alternative approach to compiler checking for UAF that doesn't change
indentation is to add `drop((self, clk_names, regulator_names))` after
`let ret = ...;` but that felt more prone to becoming out of date if
more owned data needed to be added to the function scope.
---
Changes in v2:
- Avoid use after free; add compiler checking. (Thanks Viresh!)
- Link to v1: https://patch.msgid.link/20251020-opp-simpler-code-v1-1-04f7f447712f@kernel.org
---
 rust/kernel/opp.rs | 112 +++++++++++++++++++++++++++--------------------------
 1 file changed, 58 insertions(+), 54 deletions(-)

diff --git a/rust/kernel/opp.rs b/rust/kernel/opp.rs
index 04472a8de3ff..f9641c639fff 100644
--- a/rust/kernel/opp.rs
+++ b/rust/kernel/opp.rs
@@ -443,66 +443,70 @@ pub fn set_supported_hw(mut self, hw: KVec<u32>) -> Result<Self> {
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
+        let clk_names = self.clk_names.as_deref().map(to_c_str_array).transpose()?;
+        let regulator_names = self
+            .regulator_names
+            .as_deref()
+            .map(to_c_str_array)
+            .transpose()?;
+
+        let set_config = || {
+            let clk_names = clk_names.as_ref().map_or(ptr::null(), |c| c.as_ptr());
+            let regulator_names = regulator_names.as_ref().map_or(ptr::null(), |c| c.as_ptr());
+
+            let prop_name = self
+                .prop_name
+                .as_ref()
+                .map_or(ptr::null(), |p| p.as_char_ptr());
+
+            let (supported_hw, supported_hw_count) = self
+                .supported_hw
+                .as_ref()
+                .map_or((ptr::null(), 0), |hw| (hw.as_ptr(), hw.len() as u32));
+
+            let (required_dev, required_dev_index) = self
+                .required_dev
+                .as_ref()
+                .map_or((ptr::null_mut(), 0), |(dev, idx)| (dev.as_raw(), *idx));
+
+            let mut config = bindings::dev_pm_opp_config {
+                clk_names,
+                config_clks: if T::HAS_CONFIG_CLKS {
+                    Some(Self::config_clks)
+                } else {
+                    None
+                },
+                prop_name,
+                regulator_names,
+                config_regulators: if T::HAS_CONFIG_REGULATORS {
+                    Some(Self::config_regulators)
+                } else {
+                    None
+                },
+                supported_hw,
+                supported_hw_count,
 
-        let (_regulator_list, regulator_names) = match &self.regulator_names {
-            Some(x) => {
-                let list = to_c_str_array(x)?;
-                let ptr = list.as_ptr();
-                (Some(list), ptr)
-            }
-            None => (None, ptr::null()),
-        };
+                required_dev,
+                required_dev_index,
+            };
 
-        let prop_name = self
-            .prop_name
-            .as_ref()
-            .map_or(ptr::null(), |p| p.as_char_ptr());
-
-        let (supported_hw, supported_hw_count) = self
-            .supported_hw
-            .as_ref()
-            .map_or((ptr::null(), 0), |hw| (hw.as_ptr(), hw.len() as u32));
-
-        let (required_dev, required_dev_index) = self
-            .required_dev
-            .as_ref()
-            .map_or((ptr::null_mut(), 0), |(dev, idx)| (dev.as_raw(), *idx));
-
-        let mut config = bindings::dev_pm_opp_config {
-            clk_names,
-            config_clks: if T::HAS_CONFIG_CLKS {
-                Some(Self::config_clks)
-            } else {
-                None
-            },
-            prop_name,
-            regulator_names,
-            config_regulators: if T::HAS_CONFIG_REGULATORS {
-                Some(Self::config_regulators)
-            } else {
-                None
-            },
-            supported_hw,
-            supported_hw_count,
+            // SAFETY: The requirements are satisfied by the existence of [`Device`] and its safety
+            // requirements. The OPP core guarantees not to access fields of [`Config`] after this
+            // call and so we don't need to save a copy of them for future use.
+            let ret = unsafe { bindings::dev_pm_opp_set_config(dev.as_raw(), &mut config) };
 
-            required_dev,
-            required_dev_index,
+            to_result(ret).map(|()| ConfigToken(ret))
         };
 
-        // SAFETY: The requirements are satisfied by the existence of [`Device`] and its safety
-        // requirements. The OPP core guarantees not to access fields of [`Config`] after this call
-        // and so we don't need to save a copy of them for future use.
-        let ret = unsafe { bindings::dev_pm_opp_set_config(dev.as_raw(), &mut config) };
+        // Ensure the closure does not accidentally drop owned data; if violated, the compiler
+        // produces E0525 with e.g.:
+        //
+        // ```
+        // closure is `FnOnce` because it moves the variable `clk_names` out of its environment
+        // ```
+        let _: &dyn Fn() -> _ = &set_config;
 
-        to_result(ret).map(|()| ConfigToken(ret))
+        set_config()
     }
 
     /// Config's clk callback.

---
base-commit: 173e02d674946ff3ef8da7f44a9d5b820b9af21c
change-id: 20251018-opp-simpler-code-58662c627bf4

Best regards,
--  
Tamir Duberstein <tamird@kernel.org>


