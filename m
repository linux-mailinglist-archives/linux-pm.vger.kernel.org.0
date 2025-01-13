Return-Path: <linux-pm+bounces-20304-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E79D6A0B559
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 12:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1F1B16582D
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 11:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4198422F160;
	Mon, 13 Jan 2025 11:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fvkxb5n7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9634322F15A
	for <linux-pm@vger.kernel.org>; Mon, 13 Jan 2025 11:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736767416; cv=none; b=MfNxYXTyZ1Zd0zE3kfDY8yK5Asq/6UJab7A9xGKctleBc3wgVf+l5NiyzuGwUMg3PmNGPTDKiGCTjolQhABmDP8nah77EzEhB8HQbMBLTiqnekoX1m4FrKIJeH329ax9DapT3DuTQ7Gsqi3xRiCD5mQeLvSWvLALeboMxyeKMLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736767416; c=relaxed/simple;
	bh=/kE5kPbNWY6PC79ZSfDAuKNMLuhIH4+h8fz5NhoXvxc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EvL5iR3g/dvmT/61oclcAylhybp/aL2ZdOsMQMhKyyHQDwjLyM57dE1lUI9f7Xx6/7VQ6g1VKcHgdPotkrU2Mif4B9TBCdRbmnUvlJO9e3L8P5tRa6t7SiSnGEsYcs0O5N5HxkI1V2EvHDBILdbjyVculGox8ggFWFr/Mx8Va1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Fvkxb5n7; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21a7ed0155cso68961335ad.3
        for <linux-pm@vger.kernel.org>; Mon, 13 Jan 2025 03:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736767414; x=1737372214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1AG9HcOcVokzr0nsf4h2oFRkN4qLeAqJSfWTUWUhso0=;
        b=Fvkxb5n7D+WYxFnhYn6NzWO1Ee9M2YHGWbcSxYnw6IoZDpuaf/Js9WIfcTmNshjShh
         JaDKjIst6HasJPhMFueLgYSjJHVoOvzsRNlQCJt6X4oZ4iwHBku8xsGNvtBODyyqRIio
         hmSks888+fHv4byD94YccuNX01k1AuzCcpxFw//z7U+fd9l1F6SsgpKwtm6T8wDrGlxT
         wDGzcr6O5TEZCvrKnSCU7R56sdmduCm0LPKs+7ZnCYHyR+gS3ntvIqUb5DbaPVkmW2ll
         dOs/ljvUYAUYkWm82PZ2ftRUs94oAL8d8lEytPI/Y64hkWuA/7cic10Tmaek2sPkusCa
         r88g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736767414; x=1737372214;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1AG9HcOcVokzr0nsf4h2oFRkN4qLeAqJSfWTUWUhso0=;
        b=Kv1gKZHJBN9Ov80pGAdkJS5c5jDWGql9zZo7Jeyu4t6ko/DMDIxGWd/R77eNuGyZ7S
         ZLC379Gpe3tTqRGagj9gvdS2nJchRYJAoEYf8pHWUnrwDrb+Ak6Mj7BLz7BOdLwViyxA
         clHAoXeBhzfzKVZy3598T8yw3EncHcXJs9lRSyIPxEYu7BzvWdCETSZQN77HNhNnFABe
         48HxMowVfp+t2fwcaOmVTdhE91oz+irK+oSEnA5rowhUnAzGvLVSXfnqgGUosEvqMS9p
         NbO9PTmWKUKLLLHvalOmw6hnK3SkeaDX3nTGbHAxt9l1+4obIpJC3ithGPfwXpRljpyy
         nNig==
X-Gm-Message-State: AOJu0YzgJ2yg3pXuGk9fLhhf7Y9eV1t6JwxfZvyirw6ZLKXs/99q0YX5
	qILsTi/T2Ffy9PuxLVxPOZgNTOmd3NAsmfNUQfczq1LB8dUa43HIsqIKOz8W6IA=
X-Gm-Gg: ASbGncubUKnxP7uVDo2+sqSuSTYu6A/Ie07OAX/wKczkcXwvsau4B2wWhDCiETKi432
	migR6xBAO+NyFbrh4whUnkFr4HkSC3qzXFh5cQLDjgfZuaAzU5SM6mpdQtnWVwG1UQscqbhHWY5
	HyECbZOMbUpXUgy4pfR+JCfLKt2mNM0M5ZOI2lopkj/XCPQV0DmKCdjC1K+eHjliNwj1zglY8j7
	IxaOe4jmQ0hIlEHVjqcH3q3D5LkRrdjWJX0oo3cnZG3LfNYCpPD9H3l9H8=
X-Google-Smtp-Source: AGHT+IFS1Ade/lCNohwz6lSNtMyhnEumsGf01NDYDdmrzy557Wsdy9qW7K+/MJGgXUNuuTCOSpFqlw==
X-Received: by 2002:a05:6a20:840a:b0:1e3:e77d:1431 with SMTP id adf61e73a8af0-1e88d10ccbbmr33340957637.23.1736767413260;
        Mon, 13 Jan 2025 03:23:33 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a31844ba087sm5682685a12.22.2025.01.13.03.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 03:23:32 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Benno Lossin <benno.lossin@proton.me>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Viresh Kumar <vireshk@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	rust-for-linux@vger.kernel.org
Subject: [PATCH V7 00/16] Rust bindings for cpufreq and OPP core + sample driver
Date: Mon, 13 Jan 2025 16:52:55 +0530
Message-Id: <cover.1736766672.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This patch series introduces initial Rust bindings for two subsystems: cpufreq
and Operating Performance Points (OPP). The bindings cover most of the
interfaces exposed by these subsystems.

Included in this series is a sample `cpufreq` driver, `rcpufreq-dt`, which is a
duplicate of the existing `cpufreq-dt` driver. The `cpufreq-dt` driver is a
generic, platform-agnostic, device-tree-based driver used on many ARM platforms.

Currently, the implementation has been tested using QEMU, verifying that
frequency transitions, various configurations, and driver binding/unbinding
functions as expected. However, performance measurements have not been
conducted.

For those interested in trying these patches, along with a few dependencies,
they can be found at:

git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/linux.git rust/cpufreq-dt

This version is rebased on linux-next's master branch (needed changes from
rust-next and driver-core-next branches).

FIXME: I haven't found a solution yet for the last patch 16/16, if someone can
please help ?

V6->V7:
- from_cpu() is moved to cpu.rs and doesn't return ARef anymore, but just a
  reference.
- Dropped cpufreq_table_len() and related validation in cpufreq core.
- Solved the issue with BIT() macro differently, using an enum now.
- Few patches are broken into smaller / independent patches.
- Improved Commit logs and SAFETY comments at few places.
- Removed print message from cpufreq driver.
- Rebased over linux-next/master.
- Few other minor changes.

V5->V6:
- Rebase over latest rust/dev branch, which changed few interfaces that the
  patches were using.
- Included all other patches, which weren't included until now to focus only on
  core APIs.
- Other minor cleanups, additions.

V4->V5:
- Rename Registration::register() as new().
- Provide a new API: Registration::new_foreign_owned() and use it for
  rcpufreq_dt driver.
- Update MAINTAINERS file.

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

Viresh Kumar (16):
  cpufreq: Use enum for cpufreq flags that use BIT()
  PM / OPP: Add reference counting helpers for Rust implementation
  rust: cpu: Add from_cpu()
  rust: device: Add property_present()
  rust: Add cpumask helpers
  rust: Add bindings for cpumask
  rust: Add bare minimal bindings for clk framework
  rust: Add initial bindings for OPP framework
  rust: Extend OPP bindings for the OPP table
  rust: Extend OPP bindings for the configuration options
  rust: Add initial bindings for cpufreq framework
  rust: Extend cpufreq bindings for policy and driver ops
  rust: Extend cpufreq bindings for driver registration
  rust: Extend OPP bindings with CPU frequency table
  cpufreq: Add Rust based cpufreq-dt driver
  DO-NOT_MERGE: cpufreq: Rename cpufreq-dt platdev

 MAINTAINERS                          |    2 +
 drivers/cpufreq/Kconfig              |   12 +
 drivers/cpufreq/Makefile             |    1 +
 drivers/cpufreq/cpufreq-dt-platdev.c |    2 +-
 drivers/cpufreq/rcpufreq_dt.rs       |  230 ++++++
 drivers/opp/core.c                   |   17 +-
 drivers/opp/opp.h                    |    1 -
 include/linux/cpufreq.h              |   96 +--
 include/linux/pm_opp.h               |    6 +
 rust/bindings/bindings_helper.h      |    6 +
 rust/helpers/cpufreq.c               |   10 +
 rust/helpers/cpumask.c               |   35 +
 rust/helpers/helpers.c               |    2 +
 rust/kernel/clk.rs                   |   48 ++
 rust/kernel/cpu.rs                   |   26 +
 rust/kernel/cpufreq.rs               | 1056 ++++++++++++++++++++++++++
 rust/kernel/cpumask.rs               |   85 +++
 rust/kernel/device.rs                |    7 +
 rust/kernel/lib.rs                   |    7 +
 rust/kernel/opp.rs                   |  890 ++++++++++++++++++++++
 20 files changed, 2487 insertions(+), 52 deletions(-)
 create mode 100644 drivers/cpufreq/rcpufreq_dt.rs
 create mode 100644 rust/helpers/cpufreq.c
 create mode 100644 rust/helpers/cpumask.c
 create mode 100644 rust/kernel/clk.rs
 create mode 100644 rust/kernel/cpu.rs
 create mode 100644 rust/kernel/cpufreq.rs
 create mode 100644 rust/kernel/cpumask.rs
 create mode 100644 rust/kernel/opp.rs

-- 
2.31.1.272.g89b43f80a514


