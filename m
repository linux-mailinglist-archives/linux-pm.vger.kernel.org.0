Return-Path: <linux-pm+bounces-10965-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6509592E07B
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2024 09:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B16F282A2A
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2024 07:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E6B152189;
	Thu, 11 Jul 2024 06:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wZS2OaRd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041081514F3
	for <linux-pm@vger.kernel.org>; Thu, 11 Jul 2024 06:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720681122; cv=none; b=sMP9hC1/enpYbi5MtvRv8I34rZ/nOUKC2woRxSWgQyvYCnpv16gWSWD205QNMhhrcsBDMRm2bTqHbCptKsuSnN5b19gRNSAZbdA3eCRltmeDJHB/mR3YLeVLL4lbgRInwb4aeogf8u3sRKqKvhnvzID5HOVuLwVupAzO3m7qDcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720681122; c=relaxed/simple;
	bh=1Xy9KHDychYMFo45DJYM4XIeOyy+ftVDsh/XzMyp4bs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ltVztHEqtOI1UjMFHiJMkhpPhHQzsD0kw/hfoO1BPC0TakWMXYEcXdq/MhWYFNkJoyAF2AnwuVroSFU2lJP+/xQD58NlNolyKJFMG0ZXsnsz+CV+/PWnp9q+qa4+qegHeHW2XmaKIh96lCuqttfLHwpeCvqp22DaUJTyhhdKf/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wZS2OaRd; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fb8781ef1bso4180135ad.3
        for <linux-pm@vger.kernel.org>; Wed, 10 Jul 2024 23:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720681120; x=1721285920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9e8HCkv4MqLK7B9EDdw2qJNgX3GUhxvt7rYdMaHiBII=;
        b=wZS2OaRdNnn0D/GJn1JWSLTLMj+kgolN2aLu3gZ1oMTuQBTsxTvAveCuAvT8O1QNal
         1JioGRVKlydjw8jQgWqGa2y430W3eaRIu6uJS3307faJ2a5CuCvK2HLDmkhfR38cPH1l
         C+1DFbPPhv6QC5T8V6jYy7aKMz0ozmuXFHl4Em93wAXSq7ZMYXIeyfcRC/en3ubREbKh
         kNCsRjX1ConLL0YpTCvQ8OoeoosD+0Gb5vGl8Ryb8wbl+ie5SBMBOP0svaYkDt8LDtsa
         GDhSShIFzDS9dhwh7PUA+wunEUwzMu0qxe/QnjDLGI00dinF3z61U+m+6T39xjdaN/6+
         zcVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720681120; x=1721285920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9e8HCkv4MqLK7B9EDdw2qJNgX3GUhxvt7rYdMaHiBII=;
        b=Ohy8y0Xr06jzTPwKQA6MZbN0czSP8OlIG+2Cfx1MSjPre+hBFxNKv4MpqIrc0xahlG
         tM4Db2LfwR8D1iwlhV3KVpKE25md563uIKkfYpDa+OL5xjIEtJy8Jd8ljt1S3jNZuSTm
         wEoqREVWt53qxi4YnVo9Y87DerIdAHkC0Br3jRXfhLdtITOUX3r9553rvzgZlsDlbGlC
         3+LeFozrpG2DUBhGSGWx4GTsBiAEn1vcRsg/QWtHCsGkM365kjOyTv4L8oargU5hHCKk
         hLFNBhfIXvQOw0A+4ZAHq9xccXPRr79SNiAsBJXuA40E9IUZS1/8zWn8n8ht8N4IUXJN
         Zy0g==
X-Gm-Message-State: AOJu0YxviPL0tvpcpH6Z6JCile5QYcmmMNJ5XjijJegUqWlPPbkSzdOg
	yfQy+HI5378eolxbU1buDB2fBj8AuQJwyJbpbOgpnG5RznWYf1UK6AgN7QntEVU=
X-Google-Smtp-Source: AGHT+IG6KiJN8RvMFc2x7IkaNiACkQ6MjAB6O5+E4DFT+Hi8we5+RzfQHFoGsT7JgQSL8HqEIHgfSQ==
X-Received: by 2002:a17:902:c952:b0:1fb:1b16:eb80 with SMTP id d9443c01a7336-1fbb6d0e113mr66096045ad.26.1720681120236;
        Wed, 10 Jul 2024 23:58:40 -0700 (PDT)
Received: from localhost ([122.172.84.129])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ac80f1sm43753745ad.235.2024.07.10.23.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 23:58:39 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Danilo Krummrich <dakr@redhat.com>,
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
Subject: [PATCH V4 8/8] cpufreq: Add Rust based cpufreq-dt driver
Date: Thu, 11 Jul 2024 12:27:50 +0530
Message-Id: <b1601c1dbdf68a4b812fcfaf73f3b5dea67f2025.1720680252.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1720680252.git.viresh.kumar@linaro.org>
References: <cover.1720680252.git.viresh.kumar@linaro.org>
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
 drivers/cpufreq/rcpufreq_dt.rs | 222 +++++++++++++++++++++++++++++++++
 3 files changed, 235 insertions(+)
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
index 000000000000..3e86ad134e13
--- /dev/null
+++ b/drivers/cpufreq/rcpufreq_dt.rs
@@ -0,0 +1,222 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Rust based implementation of the cpufreq-dt driver.
+
+use core::format_args;
+
+use kernel::{
+    b_str, c_str, clk, cpufreq, cpumask::Cpumask, define_of_id_table, device::Device,
+    devres::Devres, error::code::*, fmt, macros::vtable, module_platform_driver, of, opp, platform,
+    prelude::*, str::CString, sync::Arc,
+};
+
+// Finds exact supply name from the OF node.
+fn find_supply_name_exact(np: &of::DeviceNode, name: &str) -> Option<CString> {
+    let name_cstr = CString::try_from_fmt(fmt!("{}-supply", name)).ok()?;
+
+    np.find_property(&name_cstr).ok()?;
+    CString::try_from_fmt(fmt!("{}", name)).ok()
+}
+
+// Finds supply name for the CPU from DT.
+fn find_supply_names(dev: &Device, cpu: u32) -> Option<Vec<CString>> {
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
+    mask: Cpumask,
+    #[allow(dead_code)]
+    token: Option<opp::ConfigToken>,
+    #[allow(dead_code)]
+    clk: clk::Clk,
+}
+
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
+        let dev = Device::from_cpu(cpu)?;
+        let mut mask = Cpumask::new()?;
+
+        mask.set(cpu);
+
+        let token = match find_supply_names(&dev, cpu) {
+            Some(names) => Some(
+                opp::Config::<Self>::new()
+                    .set_regulator_names(names)?
+                    .set(&dev)?,
+            ),
+            _ => None,
+        };
+
+        // Get OPP-sharing information from "operating-points-v2" bindings.
+        let fallback = match opp::Table::of_sharing_cpus(&dev, &mut mask) {
+            Ok(_) => false,
+            Err(e) => {
+                if e != ENOENT {
+                    return Err(e);
+                }
+
+                // "operating-points-v2" not supported. If the platform hasn't
+                // set sharing CPUs, fallback to all CPUs share the `Policy`
+                // for backward compatibility.
+                opp::Table::sharing_cpus(&dev, &mut mask).is_err()
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
+        let mut opp_table = match opp::Table::from_of_cpumask(&dev, &mask) {
+            Ok(table) => table,
+            Err(e) => {
+                if e == EPROBE_DEFER {
+                    return Err(e);
+                }
+
+                // The table is added dynamically ?
+                opp::Table::from_dev(&dev)?
+            }
+        };
+
+        // The OPP table must be initialized, statically or dynamically, by this point.
+        opp_table.opp_count()?;
+
+        // Set sharing cpus for fallback scenario.
+        if fallback {
+            mask.set_all();
+            opp_table.set_sharing_cpus(&mask)?;
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
+            .set_clk(&dev, None)?;
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
+impl platform::Driver for CPUFreqDTDriver {
+    type Data = ();
+
+    define_of_id_table! {(), [
+        (of::DeviceId(b_str!("operating-points-v2")), None),
+    ]}
+
+    fn probe(dev: &mut platform::Device, _id_info: Option<&Self::IdInfo>) -> Result<Self::Data> {
+        let drv = cpufreq::Registration::<CPUFreqDTDriver>::register(
+            c_str!("cpufreq-dt"),
+            (),
+            cpufreq::flags::NEED_INITIAL_FREQ_CHECK | cpufreq::flags::IS_COOLING_DEV,
+            true,
+        )?;
+
+        Devres::new_foreign_owned(dev.as_ref(), drv, GFP_KERNEL)?;
+
+        pr_info!("CPUFreq DT driver registered\n");
+
+        Ok(())
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


