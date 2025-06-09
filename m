Return-Path: <linux-pm+bounces-28306-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC4BAD1D17
	for <lists+linux-pm@lfdr.de>; Mon,  9 Jun 2025 14:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C6213A236A
	for <lists+linux-pm@lfdr.de>; Mon,  9 Jun 2025 12:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6AC1E98FB;
	Mon,  9 Jun 2025 12:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SAz8l2W/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A8C12E7E;
	Mon,  9 Jun 2025 12:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749471748; cv=none; b=njdeXtuVaxRbycSqa/xMLawnpqjyZJqYwgj8htPDH+5K2VtF76qN+FCJX63jFmIjh9hDfM0FgNtZ91uWLSY0RZLSXFgLnQsvll/jdBwIfJZrrWdZAwHrveRixRHEQ8FvEGS2U9jwdYezo33PAvDAp33KjaB103zJHZZXCoLy+ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749471748; c=relaxed/simple;
	bh=FhUb+ZXql8dArcka8IrDv/E1OATdkq2BGb4ry+i1JHI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NCK2Z2uknNQqkTNykPhhiKeTq0NXJDG4K5Dog0fLTqyqGDMAxH9BU9D7yNnG1BHNOIvDXyg7KQaIxPlJZ86U/XMSnmTYtC2EJ8/1Hc/OWboiTw8554GiQhPnQPT5DMjAv3fLd/rbaR4UXeBHVNN5RFCv3/Z2ofnyGw9zi1bZM18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SAz8l2W/; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-742c73f82dfso3290758b3a.2;
        Mon, 09 Jun 2025 05:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749471747; x=1750076547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YBch+ffur1O0Rgja7qluq4MVSQH3W827o3L8nkl80n0=;
        b=SAz8l2W/P47BMU9FJxDsE51sBska+Ba/5HFbVW3fqGXTur4aoCl20ZpSoxNakGkIXb
         +V8vb2A/phyHCFqQLt8Deqjun5s7VNEyVLlbrF8IHVpN9ZHqW7KVVcpElZgYBM+CDFqB
         1dinPfqoJlqE2RGmOiHxUPFuc+JLeH37KaLPwaJt2MwMvQhMoHpAW0cnyAM4ZqiopL/o
         VFtsVQc+cS5d8o2+SqzwqxuAJJmROs9YpOjPU+rQ+VO0mBY9WF4bCnzM8uCASVniH4Qz
         lFcuGB2z5ti6+b7AwKeK/mcOmnFj6D0vNXky9aiydKJUYOtiVFTcvuNJi1pRvVRMKpMv
         NUDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749471747; x=1750076547;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YBch+ffur1O0Rgja7qluq4MVSQH3W827o3L8nkl80n0=;
        b=CPzimJW8/oT3J76d+WQTsPJj0/PMUVfUjzmiq4FgEmOlyHhjASuwyIy6xQPjIRk/ub
         ifVPeooAizcumzckhrDIq8IhvFlcxzniuZyY6jgdcOf2UEGGcW9ZHWzsJQQASwWGhqOn
         h96pcItcXxBoSzCt4ek/MhXw3mt0/du/kgBwbeY+SNA3YdN92DbEyCxigfZx7RDT56YM
         sLZqVyroAl9iHy2TpjObFxbvngOElEUzlIhTVwskzKNGSWwGqs9H21NUbGCrD9I/N6Kz
         hh+yQ7FBQBAB/SZ0PeTPvQpbKX8bmCiTFqLGFB9itOi/CbJbEY9/Dmk1xXXAuwLPFOAZ
         2pPg==
X-Forwarded-Encrypted: i=1; AJvYcCX2qEYFtXaF12HmpqmZswq10Galj21tL7Dqwp2LYX98u9CBMnI58wVvBN0/endXk7ArAGk5kJieHCyoaPw=@vger.kernel.org, AJvYcCX7Tk2jn5RnJPC+NhGijemn+D3AszblPBzdybUgoNRD3Veo81N0chHTCLxvCAg+GUP7ClwnJAv9FdVrIyejsIc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuufwIrNJl1xZbXv5TD+tN7PS7gucYQ32F0+cwin9HaMe4rppd
	S37aZJ3feOX+X/0NVZLycMLQkXtQtJz3rfgs3DZa8k1jzipnxq18nrIo
X-Gm-Gg: ASbGncsKWPLaT7gM+3jDhXKXQox29OCd212csZKYJYcrSbwd9uITrrSHJiei5VLIZxi
	arBI++m0bk5HjehuBnTu7m57kSzXaZDbgg9C6dGh+M0HIn1JU8xKvRZGNCXtdAe4H+8+B8KCjAF
	KrpO/6CAfWFvPPZ2Qh2IHaMOI46WSV1a4KoQb91tuugOvb8GQHU+mF9Co1GBHjs7I4ne0jJI71K
	6rP52YgOUY2kk0UefqkiFmTeSntYIFZXvirWn4phkWVTMxH/61YKu5INju9kIoEojiPwzE0tk88
	YiPDJ3JxYqeho6miA83ZmDVw+qdhbf9a1jBfWwVpZmnknocT+lYJSoa2Ffwvznyl4kKjaSj8
X-Google-Smtp-Source: AGHT+IFN/6jpjwnUWAnmieziowXquVGyIPIEOCFl8zdXOz/2r+NiQoJ5BLmsN49W1/EDBbcGUv3y0g==
X-Received: by 2002:a05:6a21:6e41:b0:21f:62e7:cd08 with SMTP id adf61e73a8af0-21f62e7ce8dmr5864666637.8.1749471746484;
        Mon, 09 Jun 2025 05:22:26 -0700 (PDT)
Received: from pop-os.. ([201.49.69.163])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2f5f7827c0sm5170285a12.62.2025.06.09.05.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 05:22:26 -0700 (PDT)
From: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
To: rafael@kernel.org,
	viresh.kumar@linaro.org,
	dakr@kernel.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	mcgrof@kernel.org,
	russ.weight@linux.dev,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	leitao@debian.org,
	gregkh@linuxfoundation.org,
	david.m.ertman@intel.com,
	ira.weiny@intel.com,
	leon@kernel.org,
	fujita.tomonori@gmail.com,
	tamird@gmail.com,
	igor.korotin.linux@gmail.com,
	walmeida@microsoft.com,
	anisse@astier.eu
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nouveau@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	rust-for-linux@vger.kernel.org,
	trintaeoitogc@gmail.com
Subject: [PATCH] rust: module: remove deprecated author key
Date: Mon,  9 Jun 2025 09:22:00 -0300
Message-Id: <20250609122200.179307-1-trintaeoitogc@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 38559da6afb2 ("rust: module: introduce `authors` key") introduced
a new `authors` key to support multiple module authors, while keeping
the old `author` key for backward compatibility.

Now that all in-tree modules have migrated to `authors`, remove:
1. The deprecated `author` key support from the module macro
2. Legacy `author` entries from remaining modules

Signed-off-by: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
---
 drivers/cpufreq/rcpufreq_dt.rs        | 2 +-
 drivers/gpu/drm/nova/nova.rs          | 2 +-
 drivers/gpu/nova-core/nova_core.rs    | 2 +-
 rust/kernel/firmware.rs               | 2 +-
 rust/macros/module.rs                 | 6 ------
 samples/rust/rust_configfs.rs         | 2 +-
 samples/rust/rust_driver_auxiliary.rs | 2 +-
 7 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/cpufreq/rcpufreq_dt.rs b/drivers/cpufreq/rcpufreq_dt.rs
index 94ed81644fe1..bdf4b844de42 100644
--- a/drivers/cpufreq/rcpufreq_dt.rs
+++ b/drivers/cpufreq/rcpufreq_dt.rs
@@ -220,7 +220,7 @@ fn probe(
 module_platform_driver! {
     type: CPUFreqDTDriver,
     name: "cpufreq-dt",
-    author: "Viresh Kumar <viresh.kumar@linaro.org>",
+    authors: ["Viresh Kumar <viresh.kumar@linaro.org>"],
     description: "Generic CPUFreq DT driver",
     license: "GPL v2",
 }
diff --git a/drivers/gpu/drm/nova/nova.rs b/drivers/gpu/drm/nova/nova.rs
index 902876aa14d1..64fd670e99e1 100644
--- a/drivers/gpu/drm/nova/nova.rs
+++ b/drivers/gpu/drm/nova/nova.rs
@@ -12,7 +12,7 @@
 kernel::module_auxiliary_driver! {
     type: NovaDriver,
     name: "Nova",
-    author: "Danilo Krummrich",
+    authors: ["Danilo Krummrich"],
     description: "Nova GPU driver",
     license: "GPL v2",
 }
diff --git a/drivers/gpu/nova-core/nova_core.rs b/drivers/gpu/nova-core/nova_core.rs
index 618632f0abcc..f405d7a99c28 100644
--- a/drivers/gpu/nova-core/nova_core.rs
+++ b/drivers/gpu/nova-core/nova_core.rs
@@ -13,7 +13,7 @@
 kernel::module_pci_driver! {
     type: driver::NovaCore,
     name: "NovaCore",
-    author: "Danilo Krummrich",
+    authors: ["Danilo Krummrich"],
     description: "Nova Core GPU driver",
     license: "GPL v2",
     firmware: [],
diff --git a/rust/kernel/firmware.rs b/rust/kernel/firmware.rs
index 2494c96e105f..ed2fc20cba9b 100644
--- a/rust/kernel/firmware.rs
+++ b/rust/kernel/firmware.rs
@@ -181,7 +181,7 @@ unsafe impl Sync for Firmware {}
 /// module! {
 ///    type: MyModule,
 ///    name: "module_firmware_test",
-///    author: "Rust for Linux",
+///    authors: ["Rust for Linux"],
 ///    description: "module_firmware! test module",
 ///    license: "GPL",
 /// }
diff --git a/rust/macros/module.rs b/rust/macros/module.rs
index 2ddd2eeb2852..5dd276a2e5cb 100644
--- a/rust/macros/module.rs
+++ b/rust/macros/module.rs
@@ -94,7 +94,6 @@ struct ModuleInfo {
     type_: String,
     license: String,
     name: String,
-    author: Option<String>,
     authors: Option<Vec<String>>,
     description: Option<String>,
     alias: Option<Vec<String>>,
@@ -108,7 +107,6 @@ fn parse(it: &mut token_stream::IntoIter) -> Self {
         const EXPECTED_KEYS: &[&str] = &[
             "type",
             "name",
-            "author",
             "authors",
             "description",
             "license",
@@ -134,7 +132,6 @@ fn parse(it: &mut token_stream::IntoIter) -> Self {
             match key.as_str() {
                 "type" => info.type_ = expect_ident(it),
                 "name" => info.name = expect_string_ascii(it),
-                "author" => info.author = Some(expect_string(it)),
                 "authors" => info.authors = Some(expect_string_array(it)),
                 "description" => info.description = Some(expect_string(it)),
                 "license" => info.license = expect_string_ascii(it),
@@ -179,9 +176,6 @@ pub(crate) fn module(ts: TokenStream) -> TokenStream {
     // Rust does not allow hyphens in identifiers, use underscore instead.
     let ident = info.name.replace('-', "_");
     let mut modinfo = ModInfoBuilder::new(ident.as_ref());
-    if let Some(author) = info.author {
-        modinfo.emit("author", &author);
-    }
     if let Some(authors) = info.authors {
         for author in authors {
             modinfo.emit("author", &author);
diff --git a/samples/rust/rust_configfs.rs b/samples/rust/rust_configfs.rs
index 60ddbe62cda3..af04bfa35cb2 100644
--- a/samples/rust/rust_configfs.rs
+++ b/samples/rust/rust_configfs.rs
@@ -14,7 +14,7 @@
 module! {
     type: RustConfigfs,
     name: "rust_configfs",
-    author: "Rust for Linux Contributors",
+    authors: ["Rust for Linux Contributors"],
     description: "Rust configfs sample",
     license: "GPL",
 }
diff --git a/samples/rust/rust_driver_auxiliary.rs b/samples/rust/rust_driver_auxiliary.rs
index 3e15e6d002bb..abf3d55ed249 100644
--- a/samples/rust/rust_driver_auxiliary.rs
+++ b/samples/rust/rust_driver_auxiliary.rs
@@ -114,7 +114,7 @@ fn init(module: &'static kernel::ThisModule) -> impl PinInit<Self, Error> {
 module! {
     type: SampleModule,
     name: "rust_driver_auxiliary",
-    author: "Danilo Krummrich",
+    authors: ["Danilo Krummrich"],
     description: "Rust auxiliary driver",
     license: "GPL v2",
 }
-- 
2.34.1


