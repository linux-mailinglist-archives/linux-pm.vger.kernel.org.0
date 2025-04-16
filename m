Return-Path: <linux-pm+bounces-25523-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F377A8B0AD
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 08:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D0F25A060C
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 06:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04AF2459E6;
	Wed, 16 Apr 2025 06:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fDjFcA9C"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BE924338F
	for <linux-pm@vger.kernel.org>; Wed, 16 Apr 2025 06:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744785652; cv=none; b=iRAhxLjUBs5wAim1lCdOm/+ke0KPM4OS7NV7TyVy9s8N1X87ILpXO/HtngIIDuAQgDHxEZNCEgerz0AskFVlh2DWsbek7T64AVnmy/wF8NJO9VYe9Hjd9hHm6DJdnED2ACr1ajv1K0ks7iIXDv/N5Hee5QHWNJcR/u+q/C/Fy5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744785652; c=relaxed/simple;
	bh=YCUW7M3FpgyiiQGjw35St6tdqJBkxe3Qu+wxpKDUfUw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FOssZAHU6FUpIQLCGB3fZTtLMKC5oGkyUnmX2i1GEOw4IJfEDxgHsAbtoc9zQ1NU2RbwUj5D6O5Jwo8ixyOmyBVvQp0oekqwtI/bCgJI0wsqJUe1uHhI19GeZpQUWYJFY2JKvQE7MYNTD5y9CR2CdImHClsElPprm16k5rUnnr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fDjFcA9C; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-223f4c06e9fso3694135ad.1
        for <linux-pm@vger.kernel.org>; Tue, 15 Apr 2025 23:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744785650; x=1745390450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N/mvtnXNN1pJbPS5ASieAHCptDhOrKeUchHsYheFMok=;
        b=fDjFcA9CZoYgTGPZhwnpsEmiQ5GSqU2n+9xaxnJOwqbxzl6fenRcSlbGMAhcfY0vOc
         B8AV4jl7z1f08auin1FDl2qNLmBQqZ59udosBXnXlb/xJ9NdYCdycKKPexrtvHaFaz3+
         0DkAwIp5xatzThJENXrKa4XKsYxRYXKwLPI2jLXZNNsN2REq98xe8QsNA7XZXqikzURG
         m1Ts6cy3tVyTApQyjsvCRprWMbINGopICeWV3NMs6AKfgEsAcWgDMyl8c6lCj2X+BV/o
         u4pzaMuR5fRKByh2X9K1n63S0yQCpGGJTqXA+49kv6BEI1Rxm6aq7QQ0eoyVUNnvbq8e
         bXFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744785650; x=1745390450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N/mvtnXNN1pJbPS5ASieAHCptDhOrKeUchHsYheFMok=;
        b=MHdmLh4dajthTGgPWmVIxfzsO/zmkIwgRoy7uiKnpZ1L+D8AYlVJlZB2R3UEAfTQh7
         EWjKCEHyY4IkCq0vu1tOOlkZeKelHwAGusCuV8J36nVdmL+6WD6x8fCxJqZ2g5XZuEGv
         8eZieaJsj7X1mC14puuprZAHWKwiy4FiuACTccw/KOIT78hf5uRUqFne/kdGYvEh5VSZ
         UXjPQ88xTLICNEWH6GktoY5biH80aQ0B9R6zYFYoaSdUDPqQD1lRpfpIZT3CACojChQ1
         LdjSKu7TYyq9xvZxgXlXJr2NBK2VQ6go9ncOKoqlL5ZLyUozfcXCIZNK1eAcMR2aBu5w
         itOw==
X-Gm-Message-State: AOJu0YxcZbRH+0DxEqCO34yRz8CQfqhkTTrEhTtmtC9qWPS7ZNg1JNda
	czwChMuxYtHUKWC4T60D4glHjFc2xm7KODCMHdVfPoSl8C0VZnVDICV7G5jmwPc=
X-Gm-Gg: ASbGncvVjiEKPjrOpjjWKrCECAIYTlgmsuiXIkQvLIGay1El4RWxRuMFwqjYAZdabFx
	HBS4p5/UZux1U4hI4AhdLS/RlFWMGFSj6ZlQhAhukRCKoZeVOeFaGEHwgIIuOR25n+X79zG9tFF
	lpImDYcb5UnWLTjDiPA/HZDXDG5/werm+Zs4xaezMCz6JoGViy42kBq1otHYHI95kDzdFKdB50E
	i/XOhMvDhLaEhXK/fOUhNhwOKFdlNursczgfjE+UTknUIOZ5NCmPJbw3tbPR+dVBu3l9bDB55PS
	eZ2pIdz8dM2SIAjNj2uuTUd5hrSMDIMcjmm3QRgD1g==
X-Google-Smtp-Source: AGHT+IHsyZn4vaNkqCMpGot94/NaRC26FvkgWryRgtlbTWHkBqMeg8qk1kmY2mX8fUHHHMTa/r6A2g==
X-Received: by 2002:a17:902:f683:b0:223:fb95:b019 with SMTP id d9443c01a7336-22c35f16999mr9717555ad.24.1744785650447;
        Tue, 15 Apr 2025 23:40:50 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33f1cd56sm6491425ad.83.2025.04.15.23.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 23:40:49 -0700 (PDT)
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
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>
Cc: linux-pm@vger.kernel.org,
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
	linux-kernel@vger.kernel.org
Subject: [PATCH V10 15/15] cpufreq: Add Rust-based cpufreq-dt driver
Date: Wed, 16 Apr 2025 12:09:32 +0530
Message-Id: <312f14531b97a7530446cc44e38d6dbe10fef083.1744783509.git.viresh.kumar@linaro.org>
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

Introduce a Rust-based implementation of the cpufreq-dt driver, covering
most of the functionality provided by the existing C version. Some
features, such as retrieving platform data from `cpufreq-dt-platdev.c`,
are still pending.

The driver has been tested with QEMU, and frequency scaling works as
expected.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/Kconfig        |  12 ++
 drivers/cpufreq/Makefile       |   1 +
 drivers/cpufreq/rcpufreq_dt.rs | 233 +++++++++++++++++++++++++++++++++
 3 files changed, 246 insertions(+)
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
index 22ab45209f9b..d38526b8e063 100644
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
index 000000000000..81ede13909b7
--- /dev/null
+++ b/drivers/cpufreq/rcpufreq_dt.rs
@@ -0,0 +1,233 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Rust based implementation of the cpufreq-dt driver.
+
+use kernel::{
+    c_str,
+    clk::Clk,
+    cpu, cpufreq,
+    cpumask::CpumaskVar,
+    device::{Core, Device},
+    error::code::*,
+    fmt,
+    macros::vtable,
+    module_platform_driver, of, opp, platform,
+    prelude::*,
+    str::CString,
+    sync::Arc,
+};
+
+// Finds exact supply name from the OF node.
+fn find_supply_name_exact(dev: &Device, name: &str) -> Option<CString> {
+    let prop_name = CString::try_from_fmt(fmt!("{}-supply", name)).ok()?;
+    dev.property_present(&prop_name)
+        .then(|| CString::try_from_fmt(fmt!("{name}")).ok())
+        .flatten()
+}
+
+// Finds supply name for the CPU from DT.
+fn find_supply_names(dev: &Device, cpu: u32) -> Option<KVec<CString>> {
+    // Try "cpu0" for older DTs, fallback to "cpu".
+    let name = (cpu == 0)
+        .then(|| find_supply_name_exact(dev, "cpu0"))
+        .flatten()
+        .or_else(|| find_supply_name_exact(dev, "cpu"))?;
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
+    mask: CpumaskVar,
+    #[allow(dead_code)]
+    token: Option<opp::ConfigToken>,
+    #[allow(dead_code)]
+    clk: Clk,
+}
+
+#[derive(Default)]
+struct CPUFreqDTDriver;
+
+#[vtable]
+impl opp::ConfigOps for CPUFreqDTDriver {}
+
+#[vtable]
+impl cpufreq::Driver for CPUFreqDTDriver {
+    const NAME: &CStr = c_str!("cpufreq-dt");
+    const FLAGS: u16 = cpufreq::flags::NEED_INITIAL_FREQ_CHECK | cpufreq::flags::IS_COOLING_DEV;
+    const BOOST_ENABLED: bool = true;
+
+    type PData = Arc<CPUFreqDTDevice>;
+
+    fn init(policy: &mut cpufreq::Policy) -> Result<Self::PData> {
+        let cpu = policy.cpu();
+        // SAFETY: The CPU device is only used during init; it won't get hot-unplugged. The cpufreq
+        // core  registers with CPU notifiers and the cpufreq core/driver won't use the CPU device,
+        // once the CPU is hot-unplugged.
+        let dev = unsafe { cpu::from_cpu(cpu)? };
+        let mut mask = CpumaskVar::new_zero(GFP_KERNEL)?;
+
+        mask.set(cpu);
+
+        let token = find_supply_names(dev, cpu)
+            .map(|names| {
+                opp::Config::<Self>::new()
+                    .set_regulator_names(names)?
+                    .set(dev)
+            })
+            .transpose()?;
+
+        // Get OPP-sharing information from "operating-points-v2" bindings.
+        let fallback = match opp::Table::of_sharing_cpus(dev, &mut mask) {
+            Ok(()) => false,
+            Err(e) if e == ENOENT => {
+                // "operating-points-v2" not supported. If the platform hasn't
+                // set sharing CPUs, fallback to all CPUs share the `Policy`
+                // for backward compatibility.
+                opp::Table::sharing_cpus(dev, &mut mask).is_err()
+            }
+            Err(e) => return Err(e),
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
+            mask.setall();
+            opp_table.set_sharing_cpus(&mut mask)?;
+        }
+
+        let mut transition_latency = opp_table.max_transition_latency_ns() as u32;
+        if transition_latency == 0 {
+            transition_latency = cpufreq::ETERNAL_LATENCY_NS;
+        }
+
+        policy
+            .set_dvfs_possible_from_any_cpu(true)
+            .set_suspend_freq(opp_table.suspend_freq())
+            .set_transition_latency_ns(transition_latency);
+
+        let freq_table = opp_table.cpufreq_table()?;
+        // SAFETY: The `freq_table` is not dropped while it is getting used by the C code.
+        unsafe { policy.set_freq_table(&freq_table) };
+
+        // SAFETY: The returned `clk` is not dropped while it is getting used by the C code.
+        let clk = unsafe { policy.set_clk(dev, None)? };
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
+        let Some(data) = policy.data::<Self::PData>() else {
+            return Err(ENOENT);
+        };
+
+        // SAFETY: `index` is guaranteed to be valid by the C API.
+        let freq = unsafe { data.freq_table.freq(index.try_into()?)? };
+        data.opp_table.set_rate(freq)
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
+        pdev: &platform::Device<Core>,
+        _id_info: Option<&Self::IdInfo>,
+    ) -> Result<Pin<KBox<Self>>> {
+        cpufreq::Registration::<CPUFreqDTDriver>::new_foreign_owned(pdev.as_ref())?;
+
+        let drvdata = KBox::new(Self {}, GFP_KERNEL)?;
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
-- 
2.31.1.272.g89b43f80a514


