Return-Path: <linux-pm+bounces-20007-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 866AAA03D73
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 12:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3629B3A4C0F
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 11:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE3D1E571F;
	Tue,  7 Jan 2025 11:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zHWnH5B5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16521E0DB3
	for <linux-pm@vger.kernel.org>; Tue,  7 Jan 2025 11:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736248931; cv=none; b=lu0K3Srh2EhiUMm0mlt8R5CNi9oPil5wXSHVF/uzOS3hWGQ4Tok0kCAz6ukfEpTUHB+AQfMgG6ZzFtiea9V20BBYNtuOSrMpF/C2/qxBDV6gny7ZbkqHtLNNvC01vxH+79SlVOVZWYvf5E6mLa6ZGuFKnXg+wyYNR7kjSIGJrjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736248931; c=relaxed/simple;
	bh=f/c17fphYUPFe/11gbQ5CEmhBRiM+XGDu2zrOdl33C8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aC9mcQhIFLkMfci8nLaU3YVqcsWo0JOZbjPZYUrWnpCMnyLZqK9spqP3d+Wd7lj03gQ62ANVgIQShKQwmjFrxQFJZfqvkqYAruL3DGMcwJwfe+/9p0kOCsjbTDnaqo6jcpsqLFM3UjgLv0mYjhgpSBK6f1LDe768IN7EJvNrVQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zHWnH5B5; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ee709715d9so18035908a91.3
        for <linux-pm@vger.kernel.org>; Tue, 07 Jan 2025 03:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736248928; x=1736853728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zphEAdaY76QxeZbpV/+8gIgoQkGbmjTjuxv3lzazeOw=;
        b=zHWnH5B5La47E81Q73Oo8R2FqKWGTDacJrC7asZW3oH7h7iQ+YWCx48ZqfJSYUaSLP
         kFKS0YjywX80NMstwtTD2CzXUEsarTi2sBmlK+Un1jhkplmcjJzj5+ZWEAX6Rx4uokfb
         nWS/1riBEOH3cloYpDzLh0sOihKEdUUquQPeUCv13NW36+wSLGm+7s34jVdBq2cwjMdI
         k/LhEP9Kja/9BqINd46cvSZkQB3lxvr3HBzFii3dr7ZU3PTWJxUE7skLjJpqj7pevYDT
         s5ypftdglHi4bDztEReR+bn/3t8Bs1YRMzS8+5AvMgIIvW4Bz6rooycq9VXyBKwqIKMV
         bkcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736248928; x=1736853728;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zphEAdaY76QxeZbpV/+8gIgoQkGbmjTjuxv3lzazeOw=;
        b=Pr0U6FgYUuM9iErIWNnQly0tZ7MfDcgzflMcSWEtNOhwwCNm3p5/r6LkdI2fTjkdI4
         ixrwO9SbJ4LinG8pZFLtBDxvMT+5ZxPT+tuVdGgDpsvjZdfo5Cx2JyI8FI+dLrI/yc0p
         HlWXef0EQEdX8OcL0SaTY/wHpbwuc6kd1iljyePQfgtvIFCAqAHDE+ZbHakQluRBQJvV
         sEQiLuMXnt+ih3sJflngyajjPsWurhTs28yyCcSdlcestRquMjwNE6TE8XMfyXFkBgmP
         W1rC+JCo741f08Y72kz74oM0Ey489eMjIwX7GkBuPaY6xTdRdZRmU3KTyUdxb4xJehWF
         fGJA==
X-Gm-Message-State: AOJu0YyGQgZDvROCTGUnRgGHy6hHaU0BVmTyVtfB+vaRRaYhDumkgjkK
	E/Ma+ZpA8BHPL//akRkhzZrE56M5DnITYXSc/HM2LcBqbzUAFsK2fTkr4xYPGKw=
X-Gm-Gg: ASbGncvFT9JL6xGenpAM4tEWuJo2YlaqqZ+UTmP0bSbZK53pCeDknt4D0xAn99ZYtOj
	Fk/cHSrMwxf9K7r0/IH782XkBL+NgofbCuPFx6rXJ0hHNtLcdLNfXL1hKnfYzFZXY7H8qdOAjWV
	ZBm6nUUDgKbfd3BYqi2u9QAvN7h7rRLtDkA+fIyTqq/qsCQb/xr4yQU7klV+c/3HNPnJmDzgQTj
	GMjCfPEGmqR7EDeBc5dL3pckmlCHMWfSCSZWsqI1MjqPhCJp7wowTJHThY=
X-Google-Smtp-Source: AGHT+IEs+PQiZLGQCmJ3EjZZ/+JUdQRYCGg7VfSv4hksY9MNPotGp4kkWDH9/SYO66Ro3VpuwlPOSg==
X-Received: by 2002:a17:90b:2e41:b0:2ee:e518:c1cb with SMTP id 98e67ed59e1d1-2f452dfd030mr94172778a91.7.1736248928166;
        Tue, 07 Jan 2025 03:22:08 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f447798982sm35743731a91.1.2025.01.07.03.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 03:22:07 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Danilo Krummrich <dakr@redhat.com>,
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
	rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Erik Schilling <erik.schilling@linaro.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>,
	Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH V6 00/15] Rust bindings for cpufreq and OPP core + sample driver
Date: Tue,  7 Jan 2025 16:51:33 +0530
Message-Id: <cover.1736248242.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Miguel / Danilo,

I would like to get some of this (if not all) merged now into the rust/dev
branch, since this stuff has been around for some time and many other
dependencies are already merged new (like OF, platform, device/driver). Please
suggest how can we move forward to get that done.

-------------------------8<-------------------------

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

The series includes all the patches to make it work:
- few new APIs to cpufreq/OPP frameworks.
- Avoiding using BIT() macro in cpufreq core (we need to make Rust work with
  it).
- Renaming of the cpufreq-dt platform device (this too needs to be fixed in
  Rust).
- Basic Rust bindings for clk and cpumask layers.

The work is based on `staging/dev` from the Rust tree, which is derived
from v6.13-rc3.

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

Viresh Kumar (15):
  PM / OPP: Expose refcounting helpers for the Rust implementation
  cpufreq: Add cpufreq_table_len()
  cpufreq: Rust implementation doesn't parse BIT() macro
  rust: device: Add few helpers
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
 drivers/cpufreq/rcpufreq_dt.rs       |  232 ++++++
 drivers/opp/core.c                   |   17 +-
 drivers/opp/opp.h                    |    1 -
 include/linux/cpufreq.h              |   27 +-
 include/linux/pm_opp.h               |    6 +
 rust/bindings/bindings_helper.h      |    5 +
 rust/helpers/cpufreq.c               |   16 +
 rust/helpers/cpumask.c               |   35 +
 rust/helpers/helpers.c               |    2 +
 rust/kernel/clk.rs                   |   48 ++
 rust/kernel/cpufreq.rs               | 1079 ++++++++++++++++++++++++++
 rust/kernel/cpumask.rs               |   85 ++
 rust/kernel/device.rs                |   21 +
 rust/kernel/lib.rs                   |    6 +
 rust/kernel/opp.rs                   |  886 +++++++++++++++++++++
 19 files changed, 2468 insertions(+), 15 deletions(-)
 create mode 100644 drivers/cpufreq/rcpufreq_dt.rs
 create mode 100644 rust/helpers/cpufreq.c
 create mode 100644 rust/helpers/cpumask.c
 create mode 100644 rust/kernel/clk.rs
 create mode 100644 rust/kernel/cpufreq.rs
 create mode 100644 rust/kernel/cpumask.rs
 create mode 100644 rust/kernel/opp.rs

-- 
2.31.1.272.g89b43f80a514


