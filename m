Return-Path: <linux-pm+bounces-25242-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C3A7A85B18
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 13:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 008793B6B4B
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 11:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902502BF3C6;
	Fri, 11 Apr 2025 11:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xmb9Upzf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A171D278E77
	for <linux-pm@vger.kernel.org>; Fri, 11 Apr 2025 11:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744369205; cv=none; b=JbRCBe7niWlZB6eM+9t0xVKEWMv8s2gkBNnE8F4WJzroXX94D8aPVyFB5YSrIWAi69hU77VzN8yq3IEzMKlLq9a7xBAlIDsqeOUu3ZlcO6RCTRnMNicksLoVKv9+XUv+a+wge98f/q4h9zGE2ZOH7AjPgIBbhk28sNKDYLjyu30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744369205; c=relaxed/simple;
	bh=pWo35UcpFfXt0lltVDkHvDrvwug3xEzrt77oiEiP7XI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C50pe8qqRof3nCAcDUU2HOIZV8R6nWiW3J7YHZg4bLEQJyR/IhT34M4PLOpFit2g4N7yvK6nyxqj8OO6oZwXBiExOiT6AROGpFprfYq36A/ZL89V6ILAa4+9l43QazeqzOrRAgupkIETTCJxbWwEOYbSh+3zRn8Uv5HTSLUPznI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xmb9Upzf; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22622ddcc35so23513935ad.2
        for <linux-pm@vger.kernel.org>; Fri, 11 Apr 2025 04:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744369203; x=1744974003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4mNVvyernaxT52HQcm+4cNUWaUzVLRpgc/yTn2bSQaE=;
        b=xmb9UpzfcIDoUm86ZJ00J+nBYQkL0d42SvqYHpzbnt3ceJMZK+vlEsuPKVJc4yBUdA
         Wx5SnU1XCHqEKvdq+7ZTLEP2JMZcVUtdBjygJQFlP2HAKz1MEhAZmeJKT+eyO5KWKhmZ
         B+3QT8PgNgCTPy4I1rnQHkO2+Vdy9hxgjhItDmRwBeRqP8oYz9LGSIPEDtxSmwOtIsHi
         FXKncbaHFGkUoelPnAe+4CFzLvLZ2jMLzU94UG739x08TfQFMXUGlpg3jW00txnFra3f
         8K+XVRBP3STBMxq+PuiEWE9ifBPLQpuOc9jZQtfgdpqvBIRQWEiCnbvhFKDYUHLJOfnV
         QPhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744369203; x=1744974003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4mNVvyernaxT52HQcm+4cNUWaUzVLRpgc/yTn2bSQaE=;
        b=o/9B9+mkcFmQ9Xm4u+n4pKHPbKE9KGtRyPdas9HYOta/+nYIS4Kf2Zny/Buoh5SPhk
         l7o7NemesETSf/sTp4QzAL2sFp1hYA0kXYhSb4zkYRZTK++nUU2xA1Fc0sPSRavPeoIQ
         JLSTnQyMtr0xgAg6MNXjWImLE/hpfRCXy3y15M+8Lc8Jh+4r6EdmX363ZAxpGyGCFFfs
         LSQfBi7wF7NFCstuxct/68b2/QYuEUmlUnY0bbAfwp42W/wJrU5jqS2o/WQ88E5WMpdu
         3j+N16BP1Su0fQcRMHaF9/rBNObrACEoSPwlRtOCCb0KgCLyLMQ1dzopazCYlTWSu+u0
         3wQg==
X-Gm-Message-State: AOJu0YxiPi+ZdLyysNPQCal+g1GL1MqAdk31wMqndUCqNdglN1ORWqYe
	B3R19W18+VpIwNJT5s7eQZVE7kuQVsmGIqAvOV7og1F8S401gFxjjWiMsUfeyTc=
X-Gm-Gg: ASbGncsMKxT/lzwAxGQw0DVfx+ce1dHiccJzG0oUUsM1ZfwlQu/YWQZL550fl2Mmoxu
	ZFYxDsLQy/a8+fAh4LdlhYUKhl2qMWzT8z1FVKSboNQ55Hho4LhIEc4ypGwezeXq78I3vo+UKPs
	4DMmHsAV/y9ynrk8cVVxOmmEz3BG6Ev2k4cHkekaLkhhtlG7HMSZwFBytRkVcX/ndFcttayOmVn
	/UGZ1GisBtbJE95/OL106SZ9MjVE0Bh8PVfEv2A4Uz29kh7mTMQ0ilIQXVRhY8GCYUTMvbAD++p
	YBppmjqz86iSYIhbos5XUZwBDaUAD4bu4GZFVyseXA==
X-Google-Smtp-Source: AGHT+IHE8HlOfRWkUJ6bGufM5iixKyxjSNZZ9SqxCniqwDGeJ+fDGcaMFZXytSiHOOkDy5nU5HRnVw==
X-Received: by 2002:a17:903:2a8f:b0:21f:1bd:efd4 with SMTP id d9443c01a7336-22bea4ab8bemr35593525ad.19.1744369202779;
        Fri, 11 Apr 2025 04:00:02 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7cafdaasm46053495ad.165.2025.04.11.04.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 04:00:02 -0700 (PDT)
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
	Erik Schilling <erik.schilling@linaro.org>,
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
Subject: [PATCH V9 17/17] cpufreq: Add Rust-based cpufreq-dt driver
Date: Fri, 11 Apr 2025 16:25:16 +0530
Message-Id: <0bb160bbbc11d7b9249e064cdaec48dfc4380d90.1744366572.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1744366571.git.viresh.kumar@linaro.org>
References: <cover.1744366571.git.viresh.kumar@linaro.org>
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
 drivers/cpufreq/rcpufreq_dt.rs | 236 +++++++++++++++++++++++++++++++++
 3 files changed, 249 insertions(+)
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
index 000000000000..751be33c0218
--- /dev/null
+++ b/drivers/cpufreq/rcpufreq_dt.rs
@@ -0,0 +1,236 @@
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
+    type Data = ();
+    type PData = Arc<CPUFreqDTDevice>;
+
+    fn init(policy: &mut cpufreq::Policy) -> Result<Self::PData> {
+        let cpu = policy.cpu();
+        // SAFETY: The CPU device is only used during init; it won't get hot-unplugged. The cpufreq
+        // core  registers with CPU notifiers and the cpufreq core/driver won't use the CPU device,
+        // once the CPU is hot-unplugged.
+        let dev = unsafe { cpu::from_cpu(cpu)? };
+        let mut mask = CpumaskVar::new(GFP_KERNEL)?;
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
+        cpufreq::Registration::<CPUFreqDTDriver>::new_foreign_owned(
+            pdev.as_ref(),
+            c_str!("cpufreq-dt"),
+            (),
+            cpufreq::flags::NEED_INITIAL_FREQ_CHECK | cpufreq::flags::IS_COOLING_DEV,
+            true,
+        )?;
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


