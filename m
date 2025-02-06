Return-Path: <linux-pm+bounces-21466-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79449A2A493
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2025 10:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 496FA3A84C6
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2025 09:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39573230994;
	Thu,  6 Feb 2025 09:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u9GXNw4R"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCEF23027F
	for <linux-pm@vger.kernel.org>; Thu,  6 Feb 2025 09:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738834190; cv=none; b=lnBbqXHVT3U11UlvEMSRD7O0cf9YZeuLU5xZGR3ZxGP+SQ4ait6tQgBU+9wFzukm0HWlMM4Ur8asAJFna4zeSMAwGp/Qutt9Bv21gYOGT5FjYvSCN5gZ6r8md/F362QC5VG/shMGnPTFiQit4Og2+f/DD778XjZ1IgsiobOrLts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738834190; c=relaxed/simple;
	bh=lQwGxkeDyLZl4gzxKTY+sfg/kgWYDadG6FIOwNqQWm8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ORhNWUx9ftAYnqyHV87S0W87czxdlfR5265AsOQqVwGhkkmcWzcdaYTexu1CmSduNvUldOAO/6WcK5wPmDA9OdmbB89U6UADFmWqcnXjTZfP3wI/p03Q6JFP85fQg68ygJVEfSD/ity9Pu+bhaVni2Gj5yitlWCDs+cOMj0UXBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u9GXNw4R; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ef72924e53so1259103a91.3
        for <linux-pm@vger.kernel.org>; Thu, 06 Feb 2025 01:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738834187; x=1739438987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u3kmMrnO07/rY8kDURhyasWYzOo/7PtXahiPnASlEac=;
        b=u9GXNw4RMZ0Dk0GqRASj9PFgIrNS32tRoQhnMwUj184G5nhPZ/O86D+lp/edk07w9n
         kUOHc0ksNfx/+ZX1sCs32U9jUDB02/tYq2s6VJQe1Djnylhq7ebOni4Z7EwGtydnOTRr
         toar/ivIQwXMmmFZ7fgtqN2zCRnjU0QNuDLpdtXp3xocEzmfEsKOo6LhqRO3P1CM0sJK
         KxiU5Apj6sTQ4Ch9Lay9nzINZOLiJ22sgn49lEW5dVr8jAYcmT9+V9RpEjfh+ynkUJZk
         mg5YdnAdn/HE1gjnWxosNNM0H0HwLSUGWnh3IngmJi49jmmSnAE2Sdz/rAnQKoBQO8rQ
         0dlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738834187; x=1739438987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u3kmMrnO07/rY8kDURhyasWYzOo/7PtXahiPnASlEac=;
        b=YCA3VWfxsXBS48/UMOjZWOvy8HupxgA8ELw4UNYQdNEqmkKWOQfCCI4rjxxjhVsjQk
         tHa0rVVBxeKGcBP5cCNKbidqIh3GHqdxfLkdeIXFnybkRb0KxGUsMJGjR8spCxuprKtH
         1mxjzUWJNsh2mFIaJgZMLPDDw+zSbsjY0bKCulHG2VPwRzus8lYhKBIxygNkPGHi1ZjB
         42d3Nkoub1JAnMfjdadNAho0J2OXZn0NF1enBOSvzKB+F9X6bH7QkhlTQ0oNBXaGsmqq
         OZCbEemVGQjf19RctcqsXRpaXYRaCRAFbTh1hlGMix17duGU5oL8MS/5i9g6b8rytmOj
         7wBA==
X-Gm-Message-State: AOJu0YwkvxyaKEpkOJK4QOwmm4Mziu2XpRptXzeNl+JrQbdVZAscAwt3
	IBKtMV3FqU7dqbfTnnWDgc33yfv7KTaKcB9Ftw347ENySYQI0l3GkgEIT1z9EHo=
X-Gm-Gg: ASbGncuR4+RIS7MM+wr9GpBFKduv4y25aCeqP+BUSkzX4nIfSOQ/0tlx2YuH5Y5CEQ/
	5CDJuhguRLPVbrsXyWoSJEv8pyP72WgTOX4o9Mqifdmr3LfwD9cMJCyIc8cLdCTab4hSfNVfDPC
	pCjKKViVnIdBoP6gPBxCV8GBSPYqZilVbdPvIntD3OJzx6MNhoLJFh4ypVxBgC9zL8X8hvIDPob
	P46aw4iel4e2cj0sj1C97fNgaiQFai060H+57YfyTtAxDIqCSvcvE/wcu7QaUS5wx1/Hi/3GES1
	PE6ywG5k8s791heRyA==
X-Google-Smtp-Source: AGHT+IGkNEhqQ7+Hl8c3zRCkviXXDjX9Vvx04qeZh3UAEF2BzHwjV8tkWb9YU/Rv9U3rFPCfG1+Zfw==
X-Received: by 2002:a05:6a00:2287:b0:725:e499:5b86 with SMTP id d2e1a72fcca58-7303521977bmr9464530b3a.20.1738834187287;
        Thu, 06 Feb 2025 01:29:47 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048ae7e54sm855752b3a.76.2025.02.06.01.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 01:29:46 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Danilo Krummrich <dakr@redhat.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Erik Schilling <erik.schilling@linaro.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>,
	Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH V8 14/14] cpufreq: Add Rust based cpufreq-dt driver
Date: Thu,  6 Feb 2025 14:58:35 +0530
Message-Id: <3054a0eb12330914cd6165ad460d9844ee8c19e2.1738832119.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1738832118.git.viresh.kumar@linaro.org>
References: <cover.1738832118.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds a Rust based cpufreq-dt driver, which covers most of
the functionality of the existing C based driver. Only a handful of
things are left, like fetching platform data from cpufreq-dt-platdev.c.

This is tested with the help of QEMU for now and switching of
frequencies work as expected.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/Kconfig        |  12 ++
 drivers/cpufreq/Makefile       |   1 +
 drivers/cpufreq/rcpufreq_dt.rs | 238 +++++++++++++++++++++++++++++++++
 rust/kernel/cpufreq.rs         |  10 +-
 4 files changed, 257 insertions(+), 4 deletions(-)
 create mode 100644 drivers/cpufreq/rcpufreq_dt.rs

diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index d64b07ec48e5..78702a08364f 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -217,6 +217,18 @@ config CPUFREQ_DT
 
 	  If in doubt, say N.
 
+config CPUFREQ_DT_RUST
+	tristate "Rust based Generic DT based cpufreq driver"
+	depends on HAVE_CLK && OF && RUST
+	select CPUFREQ_DT_PLATDEV
+	select PM_OPP
+	help
+	  This adds a Rust based generic DT based cpufreq driver for frequency
+	  management.  It supports both uniprocessor (UP) and symmetric
+	  multiprocessor (SMP) systems.
+
+	  If in doubt, say N.
+
 config CPUFREQ_VIRT
 	tristate "Virtual cpufreq driver"
 	depends on GENERIC_ARCH_TOPOLOGY
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 890fff99f37d..7fa29bdec3c7 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_CPU_FREQ_GOV_COMMON)		+= cpufreq_governor.o
 obj-$(CONFIG_CPU_FREQ_GOV_ATTR_SET)	+= cpufreq_governor_attr_set.o
 
 obj-$(CONFIG_CPUFREQ_DT)		+= cpufreq-dt.o
+obj-$(CONFIG_CPUFREQ_DT_RUST)		+= rcpufreq_dt.o
 obj-$(CONFIG_CPUFREQ_DT_PLATDEV)	+= cpufreq-dt-platdev.o
 obj-$(CONFIG_CPUFREQ_VIRT)		+= virtual-cpufreq.o
 
diff --git a/drivers/cpufreq/rcpufreq_dt.rs b/drivers/cpufreq/rcpufreq_dt.rs
new file mode 100644
index 000000000000..461e88006ed9
--- /dev/null
+++ b/drivers/cpufreq/rcpufreq_dt.rs
@@ -0,0 +1,238 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Rust based implementation of the cpufreq-dt driver.
+
+use core::format_args;
+
+use kernel::{
+    c_str, clk, cpu, cpufreq, cpumask::Cpumask, device::Device, error::code::*, fmt,
+    macros::vtable, module_platform_driver, of, opp, platform, prelude::*, str::CString, sync::Arc,
+};
+
+// Finds exact supply name from the OF node.
+fn find_supply_name_exact(dev: &Device, name: &str) -> Option<CString> {
+    let name_cstr = CString::try_from_fmt(fmt!("{}-supply", name)).ok()?;
+
+    if dev.property_present(&name_cstr) {
+        CString::try_from_fmt(fmt!("{}", name)).ok()
+    } else {
+        None
+    }
+}
+
+// Finds supply name for the CPU from DT.
+fn find_supply_names(dev: &Device, cpu: u32) -> Option<KVec<CString>> {
+    // Try "cpu0" for older DTs.
+    let name = match cpu {
+        0 => find_supply_name_exact(dev, "cpu0"),
+        _ => None,
+    }
+    .or(find_supply_name_exact(dev, "cpu"))?;
+
+    let mut list = KVec::with_capacity(1, GFP_KERNEL).ok()?;
+    list.push(name, GFP_KERNEL).ok()?;
+
+    Some(list)
+}
+
+// Represents the cpufreq dt device.
+struct CPUFreqDTDevice {
+    opp_table: opp::Table,
+    freq_table: opp::FreqTable,
+    #[allow(dead_code)]
+    mask: Cpumask,
+    #[allow(dead_code)]
+    token: Option<opp::ConfigToken>,
+    #[allow(dead_code)]
+    clk: clk::Clk,
+}
+
+struct CPUFreqDTDriver {
+    _pdev: platform::Device,
+}
+
+#[vtable]
+impl opp::ConfigOps for CPUFreqDTDriver {}
+
+#[vtable]
+impl cpufreq::Driver for CPUFreqDTDriver {
+    type Data = ();
+    type PData = Arc<CPUFreqDTDevice>;
+
+    fn init(policy: &mut cpufreq::Policy) -> Result<Self::PData> {
+        let cpu = policy.cpu();
+        // SAFETY: The CPU device is only used from the init() callback during which the CPU can't
+        // get hot-unplugged. Also the cpufreq core in C library, registers with CPU notifiers and
+        // the cpufreq core/driver won't use the CPU device, once the CPU is hot-unplugged.
+        let dev = unsafe { cpu::from_cpu(cpu)? };
+        let mut mask = Cpumask::new()?;
+
+        mask.set(cpu);
+
+        let token = match find_supply_names(dev, cpu) {
+            Some(names) => Some(
+                opp::Config::<Self>::new()
+                    .set_regulator_names(names)?
+                    .set(dev)?,
+            ),
+            _ => None,
+        };
+
+        // Get OPP-sharing information from "operating-points-v2" bindings.
+        let fallback = match opp::Table::of_sharing_cpus(dev, &mut mask) {
+            Ok(()) => false,
+            Err(e) => {
+                if e != ENOENT {
+                    return Err(e);
+                }
+
+                // "operating-points-v2" not supported. If the platform hasn't
+                // set sharing CPUs, fallback to all CPUs share the `Policy`
+                // for backward compatibility.
+                opp::Table::sharing_cpus(dev, &mut mask).is_err()
+            }
+        };
+
+        // Initialize OPP tables for all policy cpus.
+        //
+        // For platforms not using "operating-points-v2" bindings, we do this
+        // before updating policy cpus. Otherwise, we will end up creating
+        // duplicate OPPs for the CPUs.
+        //
+        // OPPs might be populated at runtime, don't fail for error here unless
+        // it is -EPROBE_DEFER.
+        let mut opp_table = match opp::Table::from_of_cpumask(dev, &mut mask) {
+            Ok(table) => table,
+            Err(e) => {
+                if e == EPROBE_DEFER {
+                    return Err(e);
+                }
+
+                // The table is added dynamically ?
+                opp::Table::from_dev(dev)?
+            }
+        };
+
+        // The OPP table must be initialized, statically or dynamically, by this point.
+        opp_table.opp_count()?;
+
+        // Set sharing cpus for fallback scenario.
+        if fallback {
+            mask.set_all();
+            opp_table.set_sharing_cpus(&mut mask)?;
+        }
+
+        let mut transition_latency = opp_table.max_transition_latency() as u32;
+        if transition_latency == 0 {
+            transition_latency = cpufreq::ETERNAL_LATENCY;
+        }
+
+        let freq_table = opp_table.to_cpufreq_table()?;
+        let clk = policy
+            .set_freq_table(freq_table.table())
+            .set_dvfs_possible_from_any_cpu()
+            .set_suspend_freq((opp_table.suspend_freq() / 1000) as u32)
+            .set_transition_latency(transition_latency)
+            .set_clk(dev, None)?;
+
+        mask.copy(policy.cpus());
+
+        Ok(Arc::new(
+            CPUFreqDTDevice {
+                opp_table,
+                freq_table,
+                mask,
+                token,
+                clk,
+            },
+            GFP_KERNEL,
+        )?)
+    }
+
+    fn exit(_policy: &mut cpufreq::Policy, _data: Option<Self::PData>) -> Result<()> {
+        Ok(())
+    }
+
+    fn online(_policy: &mut cpufreq::Policy) -> Result<()> {
+        // We did light-weight tear down earlier, nothing to do here.
+        Ok(())
+    }
+
+    fn offline(_policy: &mut cpufreq::Policy) -> Result<()> {
+        // Preserve policy->data and don't free resources on light-weight
+        // tear down.
+        Ok(())
+    }
+
+    fn suspend(policy: &mut cpufreq::Policy) -> Result<()> {
+        policy.generic_suspend()
+    }
+
+    fn verify(data: &mut cpufreq::PolicyData) -> Result<()> {
+        data.generic_verify()
+    }
+
+    fn target_index(policy: &mut cpufreq::Policy, index: u32) -> Result<()> {
+        let data = match policy.data::<Self::PData>() {
+            Some(data) => data,
+            None => return Err(ENOENT),
+        };
+
+        let freq = data.freq_table.freq(index.try_into().unwrap())? as usize;
+        data.opp_table.set_rate(freq * 1000)
+    }
+
+    fn get(policy: &mut cpufreq::Policy) -> Result<u32> {
+        policy.generic_get()
+    }
+
+    fn set_boost(_policy: &mut cpufreq::Policy, _state: i32) -> Result<()> {
+        Ok(())
+    }
+
+    fn register_em(policy: &mut cpufreq::Policy) {
+        policy.register_em_opp()
+    }
+}
+
+kernel::of_device_table!(
+    OF_TABLE,
+    MODULE_OF_TABLE,
+    <CPUFreqDTDriver as platform::Driver>::IdInfo,
+    [(of::DeviceId::new(c_str!("operating-points-v2")), ())]
+);
+
+impl platform::Driver for CPUFreqDTDriver {
+    type IdInfo = ();
+    const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
+
+    fn probe(
+        pdev: &mut platform::Device,
+        _id_info: Option<&Self::IdInfo>,
+    ) -> Result<Pin<KBox<Self>>> {
+        cpufreq::Registration::<CPUFreqDTDriver>::new_foreign_owned(
+            pdev.as_ref(),
+            c_str!("cpufreq-dt"),
+            (),
+            cpufreq::flags::NEED_INITIAL_FREQ_CHECK | cpufreq::flags::IS_COOLING_DEV,
+            true,
+        )?;
+
+        let drvdata = KBox::new(
+            Self {
+                _pdev: pdev.clone(),
+            },
+            GFP_KERNEL,
+        )?;
+
+        Ok(drvdata.into())
+    }
+}
+
+module_platform_driver! {
+    type: CPUFreqDTDriver,
+    name: "cpufreq-dt",
+    author: "Viresh Kumar <viresh.kumar@linaro.org>",
+    description: "Generic CPUFreq DT driver",
+    license: "GPL v2",
+}
diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
index f92259d339d3..ecf7c6e2cb89 100644
--- a/rust/kernel/cpufreq.rs
+++ b/rust/kernel/cpufreq.rs
@@ -628,15 +628,17 @@ pub fn new(name: &'static CStr, data: T::Data, flags: u16, boost: bool) -> Resul
 
         // SAFETY: The C code returns a valid pointer here, which is again passed to the C code in
         // an array.
-        attr[next] =
-            unsafe { addr_of_mut!(bindings::cpufreq_freq_attr_scaling_available_freqs) as *mut _ };
+        attr[next] = unsafe {
+            addr_of_mut!(bindings::cpufreq_freq_attr_scaling_available_freqs) as *mut _
+        };
         next += 1;
 
         if boost {
             // SAFETY: The C code returns a valid pointer here, which is again passed to the C code
             // in an array.
-            attr[next] =
-                unsafe { addr_of_mut!(bindings::cpufreq_freq_attr_scaling_boost_freqs) as *mut _ };
+            attr[next] = unsafe {
+                addr_of_mut!(bindings::cpufreq_freq_attr_scaling_boost_freqs) as *mut _
+            };
             next += 1;
         }
         attr[next] = ptr::null_mut();
-- 
2.31.1.272.g89b43f80a514


