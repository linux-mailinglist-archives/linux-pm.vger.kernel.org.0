Return-Path: <linux-pm+bounces-31303-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4EDB0E54B
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jul 2025 23:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 575C07AC66D
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jul 2025 21:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C9528725B;
	Tue, 22 Jul 2025 21:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Of5RHCCt"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4994287246;
	Tue, 22 Jul 2025 21:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753218887; cv=none; b=U+ASJvqFrFYxglUz+R8dgohSs13x/TYaCIdFeuGojg5UFLORVXVZ8LSFOIbtFJ8VPqfOXi1MIZrHeL0eetgvGa3veJKssCsimWDfaynKVqid0tJSkpFMOGahPUk0Rjtt/OsL6C3aPJhjXs2wP6hYZAiqsBY3PQVM6bLEYx3CZBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753218887; c=relaxed/simple;
	bh=GI1bYvDXeqOlV4VLN2LaDohG2UtSgNmXCrZJCZ09eqM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dhGOAIiPTmShVexmbN1qSovgjyhF4MT+H33tXCOTFB6zFy47hgTPWz/dLAl8pQOvEwSvmyv7meh9Lyaptstj5xEbye+EEbA1ual8JiT5YMHPdNa400Sfw/shoOw7qrR4yAmiY7Fc+XOvWicZc31wgeVNKEpUSOvnrd7T82iwl/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Of5RHCCt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE36AC4CEF4;
	Tue, 22 Jul 2025 21:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753218886;
	bh=GI1bYvDXeqOlV4VLN2LaDohG2UtSgNmXCrZJCZ09eqM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Of5RHCCtOKPgu9gf821JSL2SMNAFk3OJrblu42M31ADI7yxpCSCjMryssKSKlRGcS
	 S3hwk7kiz+hhdslnYFUNl2QjjhfTAJEH0gMVw/iaeuDIuwYpqpvnoI9UK00TH6Oqvi
	 wT+Ky47/MhQRmUUbKPaEUENq+c82iFRRmmU4IpX6TjB5eD7YG+P7TaBDGzzGm+0ntG
	 h9Iea08xIk/MAdnHeifNes+0JlsS7BTMnBRH3qter01fke4Q4qdavvXpbk1YwqlQr/
	 +nsJHqC5esG9T+7URmAU6FpBoaw48UsajjXR577Bu8ISaF4vH2fxhK6rVBobD2Sarg
	 I6bhn5u6yZjRA==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Tue, 22 Jul 2025 23:14:26 +0200
Subject: [PATCH DNM 2/2] interconnect: Add a test Rust consumer driver
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250722-topic-icc_rs-v1-2-9da731c14603@oss.qualcomm.com>
References: <20250722-topic-icc_rs-v1-0-9da731c14603@oss.qualcomm.com>
In-Reply-To: <20250722-topic-icc_rs-v1-0-9da731c14603@oss.qualcomm.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, Georgi Djakov <djakov@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-pm@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753218871; l=2424;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=AUfUrkjxDa8Dp36nZmOv9PIHJioHXljAHqy6xwE929M=;
 b=FzP//7lYibJ7lSp1oj+OI69rCFqs4CSoH4BtDIYdAsdoL4goEz99IOXx3cVvv2CMF0MLB5A8U
 HOtgV5SyQ03D2CvOrqFHyx5aqxmxsJ1gJCubhzPZVAeHQyQ/EO//8Uu
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Do not merge, this is for illustration / CI purposes only.

Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 drivers/interconnect/Makefile |  1 +
 drivers/interconnect/test.rs  | 47 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/drivers/interconnect/Makefile b/drivers/interconnect/Makefile
index b0a9a6753b9dc30083781163ccc01dafcfcd0485..913b92080cc0b79846b74c239e14959b45b5450c 100644
--- a/drivers/interconnect/Makefile
+++ b/drivers/interconnect/Makefile
@@ -2,6 +2,7 @@
 
 CFLAGS_core.o				:= -I$(src)
 icc-core-objs				:= core.o bulk.o debugfs-client.o
+icc-core-$(CONFIG_RUST)			+= test.o
 
 obj-$(CONFIG_INTERCONNECT)		+= icc-core.o
 obj-$(CONFIG_INTERCONNECT_IMX)		+= imx/
diff --git a/drivers/interconnect/test.rs b/drivers/interconnect/test.rs
new file mode 100644
index 0000000000000000000000000000000000000000..f4ba2000d0f1fd2d91aedf8aace0b0b54bfd48f2
--- /dev/null
+++ b/drivers/interconnect/test.rs
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+
+//! Test interconnect consumer driver
+use kernel::{
+    c_str, device::Core, icc::*, module_platform_driver, of, of::DeviceId, platform, prelude::*,
+};
+
+#[pin_data]
+struct IccTestConsumerDriver {
+    #[pin]
+    path: IccPath,
+}
+
+kernel::of_device_table!(
+    OF_TABLE,
+    MODULE_OF_TABLE,
+    <IccTestConsumerDriver as platform::Driver>::IdInfo,
+    [(DeviceId::new(c_str!("linux,icc-consumer-test")), ())]
+);
+
+impl platform::Driver for IccTestConsumerDriver {
+    type IdInfo = ();
+    const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
+
+    fn probe(
+        pdev: &platform::Device<Core>,
+        _id_info: Option<&Self::IdInfo>,
+    ) -> Result<Pin<KBox<Self>>> {
+        let path = IccPath::of_get(pdev.as_ref(), None)?;
+
+        path.set_bw(
+            IccBwUnit::from_megabits_per_sec(400),
+            IccBwUnit::from_megabits_per_sec(800),
+        )?;
+
+        Ok(KBox::pin_init(Self { path }, GFP_KERNEL)?.into())
+    }
+}
+
+module_platform_driver! {
+    type: IccTestConsumerDriver,
+    name: "icc-test-consumer",
+    authors: ["Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>"],
+    description: "Test interconnect consumer driver",
+    license: "GPL",
+}

-- 
2.50.1


