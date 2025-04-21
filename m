Return-Path: <linux-pm+bounces-25788-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A44A94D13
	for <lists+linux-pm@lfdr.de>; Mon, 21 Apr 2025 09:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D438F3B321A
	for <lists+linux-pm@lfdr.de>; Mon, 21 Apr 2025 07:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22751213230;
	Mon, 21 Apr 2025 07:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L9g3SjPQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CCB25D1FD
	for <linux-pm@vger.kernel.org>; Mon, 21 Apr 2025 07:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745220225; cv=none; b=SN7oQoymKQGhgWVu1RH19TolOdkyjJvHYq0hyuAJQsdPa856yPrfbTXlzv/8nClIp4q0xyc7rIZ9xyl73uAcvDWmwouyBVgdFyq5ueXFOLOhBH27lK2Q5Ste8sR1fMUXJcNuD96Mu/iZtxoNQ/5pIBszhZivW6h/JHn5RDDmPHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745220225; c=relaxed/simple;
	bh=ZIS3z7iPsFidXafxV93b2Yi3FI3yu6TnEKFMXRSjxlU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b/tF/iZ2zRyRm/B2PDO8/Mh5Bx24TdxDkN9DhElLpYUm8o12C6DPA6g8YrSCJi8iSnsELqWSununxhtvuqhD4uom8+mK03aKdtZeJhqlSvI0iyOEp0wCXzbtB5JAwyS1jfV4eg8wvx2MpYZJdE5wHYrpKAXiHN/9rr99OFRs3Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L9g3SjPQ; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7376dd56eccso3784120b3a.0
        for <linux-pm@vger.kernel.org>; Mon, 21 Apr 2025 00:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745220222; x=1745825022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c+dWCxW0qa//qOeop3seiJ+PvmpaQk8MdxFASKGEdIg=;
        b=L9g3SjPQUkY2Ahb7iB6jLTk0tcBGsMIDJuATanEfqotDmN56kcDMkZPxxqejq0kVKu
         zcoZAl5fbZ6wvId0ae2hYH3Pj6UQY4F7d/+LUOMN1LkWXIeg/f3ytytCg/ZymGUiABGA
         DoJlI5erqlYCM8c2B3TYx806h23pa+T91LVmvuH83Ux9y3qQEo0cmHUgYisE5qCuZ8r8
         a3U/MiapCJdBTYsZJQ1MU9n5a3PXb5lxLrp7ZXq2kYbgB1RmwY7inBTJk+M+iHc4tmO3
         Xlk/fBE2tr3KT3mHZ+xNDbDcZqvBxfe5QJ6haEjU4MVGc4yVd6UcUHXgYc/sJC7jkeTy
         9Kqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745220222; x=1745825022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c+dWCxW0qa//qOeop3seiJ+PvmpaQk8MdxFASKGEdIg=;
        b=V1HTKMu7o6ji0Eb4sdxGmCFqlhVnddGUwl0rSfY+ry3Klx60TkPQpKrqt/+boLXj/H
         GUXkUfcl/d4qJmvOisOK+UejxdZ/OtXyxRNPkEQueeXfAC2nqGWa6eLzhPcA4U+C9m1x
         bBn4mPHf3BvWr8h01DT6Nlx1K59aX0UxnoFerDE3UrE+QDSHtMkds2jzAjieDT6ui/vT
         NAQXRTL7pBZygRC/7kJSj2oMYgI/aSkvs2Fp7zJGByV5io6pcErduJdrjSdKcK/yDU0x
         VgsddPhochbDI/qS/koZe/e998iKkxCqTMPotShHv/J9gxdQsDXSi+ULaOwsZGBNK5bP
         UwSg==
X-Gm-Message-State: AOJu0YyJMihmXV5sDeRoWzKfgk/qNcMJy9qK9R/DgwnEGOh0FtIKrb7C
	2F2L0I4WPmk3oWGMjfG1nXbnnUQ3o96ogw6tI8eHnw0niiid+z4iUFOfFejOPjE=
X-Gm-Gg: ASbGnctKEQ9/apvZ8qfmZ09DJ3RcWhR3ho9fkjgzJYznRVqyGWGt1qknDxNyuNcN5SG
	+5zOUdqdllVd/E8V4mcKC8H1vuZTMm789LkHr+9uiYhEaho/ABdS/SQEXQbJ8R3T2kCtGjdQnd/
	CxnqmCT4ZSI6E+YP+/8hRXlj9xrawepMQ4pCkQIlDvodkQzhnV9pDYSNQ9y0A04OZl50XzF6r04
	V2EWr9MTbG+ibZn2t/EQ5u6xl0hlBdpb4vsJIJyCDkn+JsPI/R3ioJDz3Of+bpwIK1ZuV3qRzBZ
	mDYAKz2W83OlBzbIF7+b7I0flWC1fnLV3LcMp+paNQ==
X-Google-Smtp-Source: AGHT+IE3ihNLzBum2t3EhVaSfOP4Ld6WJ65y89kj52Y27XwztxFnklLO3F7HnSJou6+pglNZWyyDOw==
X-Received: by 2002:a05:6a00:3cc2:b0:736:5b85:a911 with SMTP id d2e1a72fcca58-73dc149bf14mr16837159b3a.8.1745220222266;
        Mon, 21 Apr 2025 00:23:42 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbfaeb282sm6081227b3a.176.2025.04.21.00.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 00:23:41 -0700 (PDT)
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
Subject: [PATCH V11 15/15] cpufreq: Add Rust-based cpufreq-dt driver
Date: Mon, 21 Apr 2025 12:52:22 +0530
Message-Id: <f7e96b7da77ac217be5ccb09b9309da28fd96c90.1745218976.git.viresh.kumar@linaro.org>
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
 drivers/cpufreq/rcpufreq_dt.rs | 229 +++++++++++++++++++++++++++++++++
 3 files changed, 242 insertions(+)
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
index 000000000000..4bc74d6e361d
--- /dev/null
+++ b/drivers/cpufreq/rcpufreq_dt.rs
@@ -0,0 +1,229 @@
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
+/// Finds exact supply name from the OF node.
+fn find_supply_name_exact(dev: &Device, name: &str) -> Option<CString> {
+    let prop_name = CString::try_from_fmt(fmt!("{}-supply", name)).ok()?;
+    dev.property_present(&prop_name)
+        .then(|| CString::try_from_fmt(fmt!("{name}")).ok())
+        .flatten()
+}
+
+/// Finds supply name for the CPU from DT.
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
+/// Represents the cpufreq dt device.
+struct CPUFreqDTDevice {
+    opp_table: opp::Table,
+    freq_table: opp::FreqTable,
+    _mask: CpumaskVar,
+    _token: Option<opp::ConfigToken>,
+    _clk: Clk,
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
+                _mask: mask,
+                _token: token,
+                _clk: clk,
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
+    fn target_index(policy: &mut cpufreq::Policy, index: cpufreq::TableIndex) -> Result<()> {
+        let Some(data) = policy.data::<Self::PData>() else {
+            return Err(ENOENT);
+        };
+
+        let freq = data.freq_table.freq(index)?;
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


