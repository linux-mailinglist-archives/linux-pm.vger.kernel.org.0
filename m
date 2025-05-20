Return-Path: <linux-pm+bounces-27393-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB670ABCF19
	for <lists+linux-pm@lfdr.de>; Tue, 20 May 2025 08:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 397598A35A4
	for <lists+linux-pm@lfdr.de>; Tue, 20 May 2025 06:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F060325C80A;
	Tue, 20 May 2025 06:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i+60eLsu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3070E25CC48
	for <linux-pm@vger.kernel.org>; Tue, 20 May 2025 06:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747721989; cv=none; b=LSD7zMq4r2JwLBbXCO7szc6867j9zqryimeZCfS/zSpDSqndBqPjEirMPCgSTQrcCqfxRu9YWPhDvMsx1uRvBHyqnKJgeZLUvE5LirsOMVn5HjoC7R99o4egGOnbCBPUw02Gr0F7tJ5CQp+3lYsZw74Z8gk5gLNtIqi9qhwy7wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747721989; c=relaxed/simple;
	bh=OU4ByQOtWJ+gydec1QudsIgdSpAgtbfCrGrIflz+nS8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TUBAM6Qwsqgo/Zf1OVyRguLzY4ZvSNT78dE1u1Ct9xZcGiWXU7Sdac0HndE9qrhybFl3NwD5q3pG+jYocWx6D5sIjPJYbY6kPAZP63MGGbtAADaHDqcDg2MaxEJpZuqh9JoFp1V9d7syzcCy/LJE5trYTzkixINhVPBnpo65c9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i+60eLsu; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b26df8f44e6so5057191a12.2
        for <linux-pm@vger.kernel.org>; Mon, 19 May 2025 23:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747721987; x=1748326787; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3QrXriFq0Ub8Xkck+rczHyL+UrIKWIcIp4tiFFkhPQs=;
        b=i+60eLsuO0ylqhzpxi+ZOIKwJ8fyv5ziruPyFc2o5VRpOSsKHK7K25lFad/aizRAly
         XMP2vGfQIovyOVRuu7ggnrAZaZQNsELNX5MYd5e/H5jSmgxth/trdWxqUKER04w9IJej
         DXvIXBx8So+/JplflzfN/KmVg/Hn/jYsgF1KqhSTSxEvI4x5IhYrQJVetPVQcuak9p84
         VmE7Tj9U+Kzyam44jsDRyglmnXlWSLwU4nI8RAabdLpNyMzdzwPR7/O0mC97gPTE2Fxe
         ddsiqTauLwxB5iomUVaC9oV2LbSeCqpxIGT0VZN+xNP2pYMaSz9wsXgb5WUli+B355Hf
         pDnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747721987; x=1748326787;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3QrXriFq0Ub8Xkck+rczHyL+UrIKWIcIp4tiFFkhPQs=;
        b=sj3OY+AGg9eR9zkiaprirQQe5VBb2EGE4pqof4T3MRv+fhB7npmSbsNo5M4lCw41HA
         jviyUqFtmJ9q6naADjylyu+n7WwOgd4WVp7Od6vAgSNnAnu0qeKycBkp4pPPV08LUSDM
         NeDBcJhIquXTFiuq/j9k7vVZEImx1AglqsLzrpJB/O8yZ4jdaloVIH9T8DpG1hBCy7+q
         MNVak9QAIxAYdIX9msJjCOqp4kCxAEhDsduMTRHoGQm02pwgMbG5b/Z2kBSEV7YaY/bH
         mWbAkEZWqEVlR88AOGzq86BbahgvVXv3PcKz7GoI4b6G9Osdnf9sFERzCWAUcWJK32lB
         /ADg==
X-Gm-Message-State: AOJu0YzW5p24z8iZyG3Q0ZGani3OcAEdZFkdGeO2syVWQUKfrLJXKaim
	IYJ7MuI3aTbz2dtj+F5+SFF4J0j7mm8yrrw95vrWttfCYvvmG3Po8tKvF43T8M0ivazoi+dStuY
	Lir+p
X-Gm-Gg: ASbGnctohQXQV5QSoZC+i1PWSRK7ZLcYmBOIJwPI2eoKwaIdea9fyfZT556Q0QafR9M
	/JO0+qxYAkyzh4b6o2z33flwHkguqQXD0f1lBLxsgXVVLJ7cXyazoRfWhkZ1RxIqLAGBo/0kMGs
	L5HRZS7GXNrZYqFakhmCjxhWIKyZYE08C0GpFuMeNvmDItLzxkdV1BSSRX7BX55vOAO8skN3g8l
	ub02Rk2cGjYfItJysCm9zo0nZnmVb/dEP2izX2CFXzsXtPqpp0/7FqZeGz7DoocHPgscIjkIzTw
	q6MB3v14KHpqJW4evrqYlZWgJ05f7Pjs4I3kPnVvD5ga/2yAjiW1
X-Google-Smtp-Source: AGHT+IGel+JHrtNl1VZJn7tExvpoE+fr1Yt4fLgYovTO9C4ueG3OMFXqk0yUacYe6nEzeAwxxm7EIw==
X-Received: by 2002:a05:6a20:10a9:b0:216:60bc:2ca9 with SMTP id adf61e73a8af0-21660cb6eefmr17944742637.40.1747721987317;
        Mon, 19 May 2025 23:19:47 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eaf6e6a5sm7238085a12.17.2025.05.19.23.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 23:19:46 -0700 (PDT)
Date: Tue, 20 May 2025 11:49:44 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, rust-for-linux@vger.kernel.org
Subject: [GIT PULL] cpufreq/arm updates for 6.16
Message-ID: <20250520061944.pl3mqw2clo2roe3s@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Rafael,

This contains few patches from Danilo Krummrich as well, which will
get merged via driver-core separately. Please push this to Linus once
that is merged during rc1. Thanks.

The following changes since commit a374f28700abd20e8a7d026f89aa26f759445918:

  cpufreq: fix compile-test defaults (2025-04-17 13:36:29 +0530)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/cpufreq-arm-updates-6.16

for you to fetch changes up to 6c9bb86922728c7a4cceb99f131e00dd87514f20:

  cpufreq: scmi: Skip SCMI devices that aren't used by the CPUs (2025-05-20 11:24:18 +0530)

----------------------------------------------------------------
CPUFreq updates for 6.16

- Rust abstractions for CPUFreq framework (Viresh Kumar).

- Rust abstractions for OPP framework (Viresh Kumar).

- Basic Rust abstractions for Clk and Cpumask frameworks (Viresh Kumar).

- Minor cleanup to the SCMI cpufreq driver (Mike Tipton).

----------------------------------------------------------------
Anisse Astier (1):
      rust: macros: enable use of hyphens in module names

Danilo Krummrich (8):
      rust: device: implement impl_device_context_deref!
      rust: device: implement impl_device_context_into_aref!
      rust: device: implement device context for Device
      rust: platform: preserve device context in AsRef
      rust: pci: preserve device context in AsRef
      rust: device: implement Bound device context
      rust: pci: move iomap_region() to impl Device<Bound>
      rust: devres: require a bound device

Mike Tipton (1):
      cpufreq: scmi: Skip SCMI devices that aren't used by the CPUs

Viresh Kumar (16):
      Merge commit 'eaff6b62d343' of pm/linux-next into commit 'f720efda2db5' of driver-core/driver-core-next
      rust: cpumask: Add few more helpers
      rust: cpumask: Add initial abstractions
      MAINTAINERS: Add entry for Rust cpumask API
      rust: clk: Add helpers for Rust code
      rust: clk: Add initial abstractions
      rust: cpu: Add from_cpu()
      rust: opp: Add initial abstractions for OPP framework
      rust: opp: Add abstractions for the OPP table
      rust: opp: Add abstractions for the configuration options
      rust: cpufreq: Add initial abstractions for cpufreq framework
      rust: cpufreq: Extend abstractions for policy and driver ops
      rust: cpufreq: Extend abstractions for driver registration
      rust: opp: Extend OPP abstractions with cpufreq support
      cpufreq: Add Rust-based cpufreq-dt driver
      Merge branch 'rust/cpufreq-dt' into cpufreq/arm/linux-next

 MAINTAINERS                     |   11 ++
 drivers/cpufreq/Kconfig         |   12 ++
 drivers/cpufreq/Makefile        |    1 +
 drivers/cpufreq/amd-pstate.c    |    7 +-
 drivers/cpufreq/cpufreq.c       |  345 +++++++++++++++++----------------------
 drivers/cpufreq/intel_pstate.c  |   47 +++---
 drivers/cpufreq/rcpufreq_dt.rs  |  226 ++++++++++++++++++++++++++
 drivers/cpufreq/scmi-cpufreq.c  |   36 ++++-
 include/linux/cpufreq.h         |   10 +-
 rust/bindings/bindings_helper.h |    4 +
 rust/helpers/clk.c              |   66 ++++++++
 rust/helpers/cpufreq.c          |   10 ++
 rust/helpers/cpumask.c          |   25 +++
 rust/helpers/helpers.c          |    2 +
 rust/kernel/clk.rs              |  334 ++++++++++++++++++++++++++++++++++++++
 rust/kernel/cpu.rs              |   30 ++++
 rust/kernel/cpufreq.rs          | 1321 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/cpumask.rs          |  330 +++++++++++++++++++++++++++++++++++++
 rust/kernel/device.rs           |   90 ++++++++++-
 rust/kernel/devres.rs           |   17 +-
 rust/kernel/lib.rs              |    7 +
 rust/kernel/opp.rs              | 1145 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/pci.rs              |   33 ++--
 rust/kernel/platform.rs         |   32 +---
 rust/macros/module.rs           |   20 ++-
 25 files changed, 3861 insertions(+), 300 deletions(-)
 create mode 100644 drivers/cpufreq/rcpufreq_dt.rs
 create mode 100644 rust/helpers/clk.c
 create mode 100644 rust/helpers/cpufreq.c
 create mode 100644 rust/kernel/clk.rs
 create mode 100644 rust/kernel/cpu.rs
 create mode 100644 rust/kernel/cpufreq.rs
 create mode 100644 rust/kernel/cpumask.rs
 create mode 100644 rust/kernel/opp.rs

-- 
viresh

