Return-Path: <linux-pm+bounces-10957-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4EDC92E06B
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2024 08:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6CCEB22269
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2024 06:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F66E12FB02;
	Thu, 11 Jul 2024 06:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IM/wf5EM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E777612F386
	for <linux-pm@vger.kernel.org>; Thu, 11 Jul 2024 06:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720681090; cv=none; b=tt8eK25KfYRSDTdfdRR3vGkYogecqZ8zu0D/S81UiuTj0uG7Hth4UhsrcRNn37Jr9u9XPjt6dJ+zOWBwTO5DoyBh9LyMmKHd/r9XHkUnhIm2wKti7Hs7eX9DKw0nW7onRp5x9Bau/31RSG9GO2ma29x4kKeKaKe40pXIy/F4R74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720681090; c=relaxed/simple;
	bh=VbV8n5fZKF1PMujDojYs/OiGZSy1hDuq9GQMWoMh+Jc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R38pqmtrhdiDL8qIsJJAFEBg6KTAF+hevTjCoEiUaBBJbk6izorS7JNZAgPbacxblMx8/Dm7VVptAcVsXrvN2OOmbvfxs6fSQxhVXg8wwC1yVd80MIQQAgkR4OkfdfhXHsKcaxMRux/z6k5jaYwIbJej3dVjzNvfqrU7h5BWaSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IM/wf5EM; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-38abd30a1c9so2088315ab.3
        for <linux-pm@vger.kernel.org>; Wed, 10 Jul 2024 23:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720681088; x=1721285888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3toptsoMNGxVTtM8r/mDQ2GtXlGc7pzgPc/YT1pqslQ=;
        b=IM/wf5EMmAoO9oHbApzt6focoFfXdTQjxe0s3ftmSe7eFqJEBQvikG5qkPA422n+ia
         SbpR94Adeohn32qdh9WzAwyOb2ejwbKQI/LE/mk77bMxgPcUcVIYwNvAnzwRKcdfQ146
         u6cELK8XUmv+rm99G7+VGSZqXYN43o21M61R7q6GhCazqpyfDfR8Scr8pkRlLrr/d+JD
         fG/X+cLDL1YddHWbsJdv80TYf+Kr3LGN8yRpdtfPSKHaHo4fjVTaFBak1x9Qgo7Yfa23
         oTMUiJqMnOW1tbt0XFXWSV+Qq8EqORLpiu/cBxlX9/EJEmXcnK1tHMCHiOXrd1G5U01E
         CVwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720681088; x=1721285888;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3toptsoMNGxVTtM8r/mDQ2GtXlGc7pzgPc/YT1pqslQ=;
        b=mxD9qU1DN6EUggTQL19AI7647WumLxI70E/w4rEwLdTAvTDfmztOkTiVRcutyTt32l
         19pbIEGHHmC5ex5aoIpB5y93jC9smKFhrKjgUQtoolrHyaIbcxdvsmpCeKMNLF7NtVV8
         jOgLPtSYP7O4RzddMO60Fqsh/Szt4To215PI4eZB1JPhOgySS0FMoyzqHiwlypwFm/cn
         lQh53uisz1D9JR27KafSa44CxvpBOrA0jPZAzE1153klkw1fpEObesbdnD9fMULVIQL6
         PQivhOzXU20auQQeX2oVcQpGmdfCFTk4ZgBe/1vBXcZimZP0V9xcSumVKTpzluN0Ko6n
         oQqA==
X-Gm-Message-State: AOJu0YwqO8Jsn6oZjGzp17O/I9RgzLzJhg348zS9kxQXPdOp762Y2eiR
	w1a0jO1hCE49qs5u5z9jmokrFWHQXc8IVyERi9M88sygGCIvUI5m4wUSAKQoqc8=
X-Google-Smtp-Source: AGHT+IFS9ttr8vgB5L0xprzERmk0Pue4prYYOP61KK6nfcxE5tq8k4JxtA3/ILvDMV75gLXHgwZFEw==
X-Received: by 2002:a05:6e02:1d16:b0:382:e06a:6a88 with SMTP id e9e14a558f8ab-38a57ad8d4amr97756245ab.10.1720681087811;
        Wed, 10 Jul 2024 23:58:07 -0700 (PDT)
Received: from localhost ([122.172.84.129])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b4389abb6sm5103343b3a.18.2024.07.10.23.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 23:58:06 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Danilo Krummrich <dakr@redhat.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Benno Lossin <benno.lossin@proton.me>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	Miguel Ojeda <ojeda@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Wedson Almeida Filho <wedsonaf@gmail.com>
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
Subject: [PATCH V4 0/8] Rust bindings for cpufreq and OPP core + sample driver
Date: Thu, 11 Jul 2024 12:27:42 +0530
Message-Id: <cover.1720680252.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This adds initial rust bindings for two subsystems, cpufreq and operating
performance points (OPP). The bindings are provided for most of the interface
these subsystems expose.

This series also provides a sample cpufreq driver rcpufreq-dt, which is a
duplicate of the merged cpufreq-dt driver (A generic platform agnostic device
tree based cpufreq driver) used on most of the ARM platforms.

This is tested with the help of QEMU for now and frequency transitions, various
configurations, driver binding/unbinding work as expected. No performance
measurement is done with this.

These patches (along with few other dependencies) are pushed here for anyone to
give them a try:

git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/linux.git rust/cpufreq-dt


This depends on basic bindings for few other modules: device/driver, platform
driver, OF, clk, and cpumask. I am not looking to upstream support for them yet.

Based on staging/rust-device from the Rust tree (which is based over v6.10-rc1).

V3->V4:
- Fix bugs with freeing of OPP structure. Dropped the Drop routine and fixed
  reference counting.
- Registration object of the cpufreq core is modified a bit to remove the
  registered field, and few other cleanups.
- Use Devres for instead of platform data.
- Improve SAFETY comments.

V2->V3:
- Rebased on latest rust-device changes, which removed `Data` and so few changes
  were required to make it work.
- use srctree links (Alice Ryhl).
- Various changes the OPP creation APIs, new APIs: from_raw_opp() and
  from_raw_opp_owned() (Alice Ryhl).
- Inline as_raw() helpers (Alice Ryhl).
- Add new interface (`OPP::Token`) for dynamically created OPPs.
- Add Reviewed-by tag from Manos.
- Modified/simplified cpufreq registration structure / method a bit.

V1->V2:
- Create and use separate bindings for OF, clk, cpumask, etc (not included in
  this patchset but pushed to the above branch). This helped removing direct
  calls from the driver.
- Fix wrong usage of Pinning + Vec.
- Use Token for OPP Config.
- Use Opaque, transparent and Aref for few structures.
- Broken down into smaller patches to make it easy for reviewers.
- Based over staging/rust-device.

Thanks.

Viresh Kumar (8):
  rust: Add initial bindings for OPP framework
  rust: Extend OPP bindings for the OPP table
  rust: Extend OPP bindings for the configuration options
  rust: Add initial bindings for cpufreq framework
  rust: Extend cpufreq bindings for policy and driver ops
  rust: Extend cpufreq bindings for driver registration
  rust: Extend OPP bindings with CPU frequency table
  cpufreq: Add Rust based cpufreq-dt driver

 drivers/cpufreq/Kconfig         |   12 +
 drivers/cpufreq/Makefile        |    1 +
 drivers/cpufreq/rcpufreq_dt.rs  |  222 +++++++
 rust/bindings/bindings_helper.h |    2 +
 rust/helpers.c                  |   15 +
 rust/kernel/cpufreq.rs          | 1023 +++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |    4 +
 rust/kernel/opp.rs              |  925 ++++++++++++++++++++++++++++
 8 files changed, 2204 insertions(+)
 create mode 100644 drivers/cpufreq/rcpufreq_dt.rs
 create mode 100644 rust/kernel/cpufreq.rs
 create mode 100644 rust/kernel/opp.rs

-- 
2.31.1.272.g89b43f80a514


