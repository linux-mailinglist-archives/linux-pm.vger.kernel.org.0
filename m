Return-Path: <linux-pm+bounces-8759-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5C38FFF08
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2024 11:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 773BA1C220A8
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2024 09:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307D315F322;
	Fri,  7 Jun 2024 09:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P3XiygEV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99705152511
	for <linux-pm@vger.kernel.org>; Fri,  7 Jun 2024 09:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717751590; cv=none; b=TY1ztJUY/l16esuR8a2C1+SpWAd+wFzcz530Uo91CBXkcEe6GAG6NqXciOhETonr6rfLByEb6EtTodY/0fjkBHWBWE6qy6c9tAzbHymPXZENABK6rPzzgF419AC1kkjxx/zo09upEjzY3zPfyv7s8HMLqyzxTuxK5iaDKzq0/yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717751590; c=relaxed/simple;
	bh=PlYAE9z0g5K3iAsbL9S0/w/lr81FU4c5zUhtR8b3HfE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bIycGjaTf0GhITtI7cKcC8gS6XtSBX75Sn6X4BaeDQu4ujDbcvLb2Yaf2Y29rkozQ72ZBUgq3q1sarqOTNrIEqvWz2cufEshnTPQBpxOcJ8DKhZfdXNU2iwNu67ArcJN4E0LaBRJ5e/09QB1g4OC1Utegjqo9Nwlz2TEq1ToGcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P3XiygEV; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-6cdf9a16229so1397994a12.3
        for <linux-pm@vger.kernel.org>; Fri, 07 Jun 2024 02:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717751587; x=1718356387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gpdjfdsu7F7InZnhYGTwKFUVSu8T2YzyZYnj5q/OC3w=;
        b=P3XiygEVSzpvjJFpzadjMKZWCn0y7tolzdnqeClHXN/tF7mOyozN4k2qT+psTZYBEA
         y51bwWGhhejCinprctUg0MCiTumDoV6Yb632JPCNvfG1tF3mIptUQHn2NoFsJXET5RXD
         a76kfzK7UU9Gdbn1HCfQq1xeqG2pjxhpEqWm8fRHEYZFKMACOzHKWPGLpc7Ka/Dg625Z
         R4j8/wqwH2DYmxekCnaMAEr/vIw2shJAJhGb0kgcKDl7A2BLobIjxUqJz+dh6aXw+MCR
         J5K+dTQbXInmzAXiXHb+7EGCLT7Tw3Nmbi/4KWjWr8G+enB1P6PdbYhXDpifTNjCGqLt
         BfYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717751587; x=1718356387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gpdjfdsu7F7InZnhYGTwKFUVSu8T2YzyZYnj5q/OC3w=;
        b=Kyf9UIh3MKJRkXe0IZsyUmeSOmh2ttYT8z79kJHh18RX1hXhlP6yMvCvcwuNtiLliu
         qHY2ZA1SlaWcP9eQRYFiiYFD3uV15/Or2MPffRYjVIuofaASS0+nIJBZvwspe6G1dTS6
         uIcVZAU/j0fwTY0w8t1X+0ctX7p9V8ZhCAdwGJYf3GXSD/qE70zQaZltIO78D2Y4q9pZ
         8fcjNWtgq77oZ4BWwvTMc4EztJcG6hJbFVFpb73pMjL/q43UXOxuJCDipw1VZ/TBRD8I
         00TPiQzwGFZ2fLKWufUaUrrYuGuGk8Ns9H0HgZCRvsRNB9m4Unz4iqfsNT0xXer6zNTO
         CMig==
X-Gm-Message-State: AOJu0YyVLSr0CbGUH6IlSjpHtBqUkJ8+mrVVyM72eeqf6csacPfrypzx
	hQvFr65WlkTxtki9OXb8HwmLErzZcYve2SIEyyWVrZ8Ee/2bJb3P3nq4IZ4uZOo=
X-Google-Smtp-Source: AGHT+IGTKWVmYcNoQJyhcj1P+6/81dmOtIBoL4JNvjOpvNWJY60yKyW7M76qmcyTJfvXfVUqVxTKmw==
X-Received: by 2002:a17:90a:b008:b0:2bd:d2f9:e71a with SMTP id 98e67ed59e1d1-2c2bcc0bbe9mr1875468a91.29.1717751586630;
        Fri, 07 Jun 2024 02:13:06 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c29c4a574bsm3069258a91.56.2024.06.07.02.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 02:13:06 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>
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
Subject: [RFC PATCH V2 8/8] cpufreq: Add Rust based cpufreq-dt driver
Date: Fri,  7 Jun 2024 14:42:23 +0530
Message-Id: <994d50cbf25a1301e4c0ffbc48eaabd8c90ab827.1717750631.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1717750631.git.viresh.kumar@linaro.org>
References: <cover.1717750631.git.viresh.kumar@linaro.org>
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
 drivers/cpufreq/rcpufreq_dt.rs | 229 +++++++++++++++++++++++++++++++++
 3 files changed, 242 insertions(+)
 create mode 100644 drivers/cpufreq/rcpufreq_dt.rs

diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index 94e55c40970a..eb9359bd3c5c 100644
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
 config CPUFREQ_DT_PLATDEV
 	tristate "Generic DT based cpufreq platdev driver"
 	depends on OF
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 8d141c71b016..4981d908b803 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_CPU_FREQ_GOV_COMMON)		+= cpufreq_governor.o
 obj-$(CONFIG_CPU_FREQ_GOV_ATTR_SET)	+= cpufreq_governor_attr_set.o
 
 obj-$(CONFIG_CPUFREQ_DT)		+= cpufreq-dt.o
+obj-$(CONFIG_CPUFREQ_DT_RUST)		+= rcpufreq_dt.o
 obj-$(CONFIG_CPUFREQ_DT_PLATDEV)	+= cpufreq-dt-platdev.o
 
 # Traces
diff --git a/drivers/cpufreq/rcpufreq_dt.rs b/drivers/cpufreq/rcpufreq_dt.rs
new file mode 100644
index 000000000000..b016771e6180
--- /dev/null
+++ b/drivers/cpufreq/rcpufreq_dt.rs
@@ -0,0 +1,229 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Rust based implementation of the cpufreq-dt driver.
+
+use core::format_args;
+
+use kernel::{
+    b_str, c_str, clk, cpufreq, define_of_id_table,
+    device::{self, Device},
+    error::code::*,
+    fmt,
+    macros::vtable,
+    module_platform_driver, of, opp, platform,
+    prelude::*,
+    str::CString,
+    sync::Arc,
+    types::ARef,
+};
+
+// Finds exact supply name from the OF node.
+fn find_supply_name_exact(np: &ARef<of::DeviceNode>, name: &str) -> Option<CString> {
+    let name_cstr = CString::try_from_fmt(fmt!("{}-supply", name)).ok()?;
+
+    np.find_property(&name_cstr).ok()?;
+    CString::try_from_fmt(fmt!("{}", name)).ok()
+}
+
+// Finds supply name for the CPU from DT.
+fn find_supply_names(dev: ARef<Device>, cpu: u32) -> Option<Vec<CString>> {
+    let np = of::DeviceNode::from_dev(dev).ok()?;
+
+    // Try "cpu0" for older DTs.
+    let name = match cpu {
+        0 => find_supply_name_exact(&np, "cpu0"),
+        _ => None,
+    }
+    .or(find_supply_name_exact(&np, "cpu"))?;
+
+    let mut list = Vec::with_capacity(1, GFP_KERNEL).ok()?;
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
+    token: Option<opp::ConfigToken>,
+    #[allow(dead_code)]
+    clk: clk::Clk,
+}
+
+#[vtable]
+impl opp::ConfigOps for CPUFreqDTDevice {}
+
+#[vtable]
+impl cpufreq::DriverOps for CPUFreqDTDevice {
+    type Data = ();
+    type PData = Arc<Self>;
+
+    fn init(policy: &mut cpufreq::Policy) -> Result<Self::PData> {
+        let cpu = policy.cpu();
+        let dev = Device::from_cpu(cpu)?;
+
+        policy.set_cpus(cpu);
+
+        let token = match find_supply_names(dev.clone(), cpu) {
+            Some(names) => Some(
+                opp::Config::<Self>::new()
+                    .set_regulator_names(names)?
+                    .set(dev.clone())?,
+            ),
+            _ => None,
+        };
+
+        // Get OPP-sharing information from "operating-points-v2" bindings.
+        let fallback = match opp::Table::of_sharing_cpus(dev.clone(), policy.cpus()) {
+            Ok(_) => false,
+            Err(e) => {
+                if e != ENOENT {
+                    return Err(e);
+                }
+
+                // "operating-points-v2" not supported. If the platform hasn't
+                // set sharing CPUs, fallback to all CPUs share the `Policy`
+                // for backward compatibility.
+                opp::Table::sharing_cpus(dev.clone(), policy.cpus()).is_err()
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
+        let mut opp_table = match opp::Table::from_of_cpumask(dev.clone(), policy.cpus()) {
+            Ok(table) => table,
+            Err(e) => {
+                if e == EPROBE_DEFER {
+                    return Err(e);
+                }
+
+                // The table is added dynamically ?
+                opp::Table::from_dev(dev.clone())?
+            }
+        };
+
+        // The OPP table must be initialized, statically or dynamically, by this point.
+        opp_table.opp_count()?;
+
+        // Set sharing cpus for fallback scenario.
+        if fallback {
+            policy.set_all_cpus();
+            opp_table.set_sharing_cpus(policy.cpus())?;
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
+        Ok(Arc::new(
+            CPUFreqDTDevice {
+                opp_table,
+                token,
+                freq_table,
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
+        let freq = data.freq_table.freq(index.try_into().unwrap())? as u64;
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
+type DeviceData = device::Data<cpufreq::Registration<CPUFreqDTDevice>, ()>;
+
+struct CPUFreqDTDriver;
+
+impl platform::Driver for CPUFreqDTDriver {
+    type Data = Arc<DeviceData>;
+
+    define_of_id_table! {(), [
+        (of::DeviceId(b_str!("operating-points-v2")), None),
+    ]}
+
+    fn probe(_dev: &mut platform::Device, _id_info: Option<&Self::IdInfo>) -> Result<Self::Data> {
+        let data = Arc::<DeviceData>::from(kernel::new_device_data!(
+            cpufreq::Registration::new(),
+            (),
+            "CPUFreqDT::Registration"
+        )?);
+        let flags = cpufreq::flags::NEED_INITIAL_FREQ_CHECK | cpufreq::flags::IS_COOLING_DEV;
+        let boost = true;
+
+        data.registrations()
+            .ok_or(ENXIO)?
+            .as_pinned_mut()
+            .register(c_str!("cpufreq-dt"), (), flags, boost)?;
+
+        pr_info!("CPUFreq DT driver registered\n");
+
+        Ok(data)
+    }
+}
+
+module_platform_driver! {
+    type: CPUFreqDTDriver,
+    name: "cpufreq_dt",
+    author: "Viresh Kumar <viresh.kumar@linaro.org>",
+    description: "Generic CPUFreq DT driver",
+    license: "GPL v2",
+}
-- 
2.31.1.272.g89b43f80a514


