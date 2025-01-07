Return-Path: <linux-pm+bounces-20021-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A24A03D97
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 12:26:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 566E9165757
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 11:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B711EBFE1;
	Tue,  7 Jan 2025 11:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r78PjdTc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C8E1F1911
	for <linux-pm@vger.kernel.org>; Tue,  7 Jan 2025 11:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736248986; cv=none; b=Ftz+xzpR+/Y8T2q2AFyhc29behEmsa2I268jBkAli/fzPfpU0diO4APOen2nBknNT+MWdRxWBR2qNrXS21r4sgRJC92XtXerlXsfZiucIoh4s81n8NBWoRH3eRZr44O8i8yLqtDC3B/kQBLY6+Gsjo+60W9vNf6edgItOmMoBWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736248986; c=relaxed/simple;
	bh=Zh+zceVRDe4q1VK/iKv7tBO8zGZlwvb7fLfjCUgyxcI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UtRJK4q04smLyAQP6pVKAZatTAIbNgyyU4XMXrjs4MS6UxM9cZg7c8rzPgiTDydtdfGCNCq9YQ1vcYcrzIWrWFFa5hjzAiFctwmjiS5L/NFDDAoWpXfmMRCR0PC25OafRJTuBJ2TwRpECahAgdQtx5szsj12ol+XT3zzwizkKDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r78PjdTc; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21661be2c2dso204596115ad.1
        for <linux-pm@vger.kernel.org>; Tue, 07 Jan 2025 03:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736248981; x=1736853781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oEZZKnPd0bzb6THTbxBmj6P2rsKvzK5VMvCnwY2nlJ0=;
        b=r78PjdTcmoRW1nIJLsrqyic+mOxl93BzA/dABLudZOA2Otc0WKqZY0qRP4v+9xlY0r
         KrFZxfYmaWg/FqEt/bt3aHob83/3bdb6K7yeKvkKWdJRwKecK0jEpFTChKU0g91HHyqq
         z6dtkURmjmGIXmY7QNT+jxMc5jaH9YS6DkhsjxFM/DhHidaKceR/Ojhd+8cBIyeXrkgm
         QbT4boeBFY46qx/ic93USGA7Pw7Q+n1gwPlhsSSVOK7hDeOvcpTIG9WPB/4/BZ1dSXr3
         4dNmPC2CTUv3mhKaZuLqoJCYBIyy/sBtbmiekhg0mlnil0HIgnO/7Fa8+oQBPwzkjkqQ
         DRYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736248981; x=1736853781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oEZZKnPd0bzb6THTbxBmj6P2rsKvzK5VMvCnwY2nlJ0=;
        b=qYnOL2JdpMUV3UGCyLClRKQOyVfUwbW1kKI3aNzS128Jlt8MjVS+pkt2rzRiS5xJkW
         YMXrfi+2HtE7D0QEJ57dWRfvDdD85x8hfjrocNXddXUkv8rnSSQJGA59fUn4GEYRWmnu
         OKjIDFo/krXMBw6y6ZrH5KkXLqjYHLrslBT/2wwLqDLdkEsqymc0SUICecBgq44ieq8V
         jGnXjHjC/tqMpAFlRl1Eo/4gjZo1egtVAWuAyryehTq3zCL1hqM8UetPZNvqgjHKTZWB
         HWs+zHW/4tEqI/azTJOVcYzI3+rrP5LEEmt1NfuvlqiQ6oHVr5dvlgmSC9ysoULeYe6K
         kikA==
X-Gm-Message-State: AOJu0Yz31Qmxa/XMvlsqYfIfl82WydbVpTl49zMMYcsfFJOn0/0uxx0s
	q41UEZL+72ip/4dj7ldGSGlR5eIJwyQbUPddqrp4xk0cuSImkGuIgf98enU7dBs=
X-Gm-Gg: ASbGncv4xA6WHfihwlJmwFjsntRj9iCFE7ZW8/YiP3ebxft6bBlrIBDrEfp2WiTrLlt
	e2cKPPV6bsNcF7+eZwXliMjRYtJR65zdHZegp3VGELjVnYWYZBSVbGaHi5qo2S/RPAO1p05Ig0o
	JEtK1bTxjHuyq/FC5WiYNBdkDTs6RvD9ihZV9797oa0ApYuXiv1CGXeRsFtzV67O0pUz/uwdI6v
	QterGBuXApjua6fUTORdFDQW0/MPWZ/mh6xc9f9Ddlsj8gXluw+pBCTMMQ=
X-Google-Smtp-Source: AGHT+IFkKEhXYseuNv5arMgQ5CUD8uPU++D1W3eQ+KvaVzXDpwhzlvnZqwRbRsF/95raPkieH9woYA==
X-Received: by 2002:a17:903:228d:b0:215:a2f2:cfbf with SMTP id d9443c01a7336-219e6e9ded8mr761215475ad.18.1736248980773;
        Tue, 07 Jan 2025 03:23:00 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9cde66sm308089705ad.145.2025.01.07.03.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 03:23:00 -0800 (PST)
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
Subject: [PATCH V6 14/15] cpufreq: Add Rust based cpufreq-dt driver
Date: Tue,  7 Jan 2025 16:51:47 +0530
Message-Id: <41a674fc8ebca6174bcc3af6cdd9155a18b19d42.1736248242.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1736248242.git.viresh.kumar@linaro.org>
References: <cover.1736248242.git.viresh.kumar@linaro.org>
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
 drivers/cpufreq/rcpufreq_dt.rs | 232 +++++++++++++++++++++++++++++++++
 3 files changed, 245 insertions(+)
 create mode 100644 drivers/cpufreq/rcpufreq_dt.rs

diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index 92a83a9bb2e1..5e60dfb6f93e 100644
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
index d35a28dd9463..db38d1d5562d 100644
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
index 000000000000..62831629bd93
--- /dev/null
+++ b/drivers/cpufreq/rcpufreq_dt.rs
@@ -0,0 +1,232 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Rust based implementation of the cpufreq-dt driver.
+
+use core::format_args;
+
+use kernel::{
+    c_str, clk, cpufreq, cpumask::Cpumask, device::Device,
+    error::code::*, fmt, macros::vtable, module_platform_driver, of, opp, platform, prelude::*,
+    str::CString, sync::Arc,
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
+            Ok(()) => false,
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
+        let mut opp_table = match opp::Table::from_of_cpumask(&dev, &mut mask) {
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
+    [
+    (of::DeviceId::new(c_str!("operating-points-v2")), ())
+    ]
+);
+
+impl platform::Driver for CPUFreqDTDriver {
+    type IdInfo = ();
+    const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
+
+    fn probe(pdev: &mut platform::Device, _id_info: Option<&Self::IdInfo>) -> Result<Pin<KBox<Self>>> {
+        cpufreq::Registration::<CPUFreqDTDriver>::new_foreign_owned(
+            pdev.as_ref(),
+            c_str!("cpufreq-dt"),
+            (),
+            cpufreq::flags::NEED_INITIAL_FREQ_CHECK | cpufreq::flags::IS_COOLING_DEV,
+            true,
+        )?;
+
+        pr_info!("CPUFreq DT driver registered\n");
+
+        let drvdata = KBox::new(Self { _pdev: pdev.clone() }, GFP_KERNEL)?;
+
+        Ok(drvdata.into())
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


