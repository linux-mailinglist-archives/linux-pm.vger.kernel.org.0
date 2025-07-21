Return-Path: <linux-pm+bounces-31163-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1C4B0BE11
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 09:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E059172A35
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 07:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E78222590;
	Mon, 21 Jul 2025 07:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SiC6aSex"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7878427F4CE
	for <linux-pm@vger.kernel.org>; Mon, 21 Jul 2025 07:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753084183; cv=none; b=a0Sis+aBVIoLhXtzkIrKOXyZRwfLMAQJKinwNovAtY+ctE4O1id2myP6T7/J1pPwZx/L3t8llbCS+KQFIjzio1awDdNGJw95682e6x/zv7+m6CEXO3GcBdR1iit9ht+b/3lia74zQrdmbi1CC/JTVPoQ/udoHhoWlMUCg8WT8Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753084183; c=relaxed/simple;
	bh=RGjuwIsJZT2ezZNDlb68Ha0m8uzvWA5Izr0aG0MKK/k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PMwgAg85ZaLZwB++pMbsp0PqloKZUDC1x7HdlKczF0K1gbJSGW2NvtnHROZHHEMDorv7pxVVs2s3aOqAB6snLNxF6wn+QOmkEpBs5f0AQDTY3ggQA1MJdYzeEq3D8ZhWZEi6yaqHYsAj1PPIF4rLlKSfGok3afqvmuAcmi2JhQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SiC6aSex; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-af51596da56so2837766a12.0
        for <linux-pm@vger.kernel.org>; Mon, 21 Jul 2025 00:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753084181; x=1753688981; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A9pM/V0lDJn6YZCsgg5bvZiuOws1noBEMI/SkWJYMVM=;
        b=SiC6aSextRKI4aiQ2nHaOz+NAK4wpb4jKU3e7L9kntszmCebx3JAtAldYo+hCSTk6j
         +VDr1ri1BzJcC1QyMvfgpFaJeNjeRFqtPQeD1052dSmKcF3ByyGbav+DOl3BIHTW4KoL
         UU1T2buJJ8TU1Lh4E5+Lm5nkgQZtINtiillsadtTQWtqcyhZIISDXnyKSkbsHcwPZMXA
         nhIIsIVHVm4wPVFJVfX28R1G2c7XJWekKxQ1p/u2xeWEhfobKrPyqhy/mkvLCYmyWcAs
         QjK9AD2kwN8/pNUXCbCgVVjjkkGIJHQ9HSFuIW5snbymhwgEcrQsKLKFcBvzPlSmOlqf
         D3Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753084181; x=1753688981;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A9pM/V0lDJn6YZCsgg5bvZiuOws1noBEMI/SkWJYMVM=;
        b=FICbP1lodPg3967psXmQCZ9E9J25oUXtG5hTfbwGSfqoewsltYGDYoY590OM9TeS04
         X24yJxX74dMkGn0YewxIfzQSy4tcXF2wPj05um2MF5b8VcaFZU9snRuSh/KrM310dvvl
         yoMuCl3mI/hmEu1lM+xHFrFyERoZHjTru3EHOX/ziqG2GAy57Hgn5hnms9oduzCdrl03
         hp+pZ9axpt6cEOvOdw9CYz4Sg8WzA/VO5mFiiebywzUhAx/yAbgtWAv1S9vIdXFaEnQf
         5FCBvnDgjgMnQ6n+89JjRvMMrYctK2Pq0/v+ZtnXgpFd9R2XLUPjdXvN7nACZqbyQiPC
         OczA==
X-Gm-Message-State: AOJu0YwDoEqTbsewkDjm8Iqearec2ic2FD1x+aIRS2og6gDU+W1SoAgO
	SDdJAt5ZNzRbh6htkw+ls2oyopQCbIGbIrAzrTOuaePw/NsHQQ1jgrbDAJQfumhOyM4zTd35Nii
	3NWuo
X-Gm-Gg: ASbGncvDgD7GjtQO/vsFO8mK7AMrUjSfOvDb/Gntp1IbcoBqEzAvRbrMhkSOu6xZpTI
	miejVTcBTUNs4AeyNjJrT4O1TlnCAokH6vsnyx1LDakNn4dIiNwXbGSTWT2dlrUWaGYQ+xKdJeD
	sl+j0vDgMx+PLu1TYPmeV0Isgl3v/hkB68kKYfoNdms+waAyhtwtc70sB3STbXMJ6NlRuVnMxHD
	gNSMkXxtCDxkYmgSnPVaDMPW8r5DQZL//Y5U42hJUOPgicgLDrCt91GCzxD/q/ly3oNtR0Ppxzz
	HZENMd9cb2gVQ83uyvKcRlUHwxbUP3zDJkeuUqeJnxPiNtzcUm8YE5RA2Ruf6lejR3h7d94h4q+
	J0tj15ix67x7obnq5d8tdsrM=
X-Google-Smtp-Source: AGHT+IEuvxajvpTcuVQH+cKITw6otsp+GKp2QPHTnCMyGwvF5KG9s3WmviD8GxNGWytoveey+JdBwQ==
X-Received: by 2002:a17:90b:1cc5:b0:312:e731:5a6b with SMTP id 98e67ed59e1d1-31c9f4dfc33mr22896947a91.32.1753084180588;
        Mon, 21 Jul 2025 00:49:40 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c9f287be2sm9459783a91.23.2025.07.21.00.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 00:49:40 -0700 (PDT)
Date: Mon, 21 Jul 2025 13:19:38 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] cpufreq/arm updates for 6.17
Message-ID: <20250721074938.dzkmyi2yxvdsctbq@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Rafael,

The following changes since commit e04c78d86a9699d136910cfc0bdcf01087e3267e:

  Linux 6.16-rc2 (2025-06-15 13:49:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/cpufreq-arm-updates-6.17

for you to fetch changes up to a7ce9ca1aaf93d55e32e915700d0ef9f69a781c9:

  drivers: cpufreq: add Tegra114 support (2025-07-15 08:37:35 +0530)

----------------------------------------------------------------
CPUFreq updates for 6.17

- tegra124: Allow building as a module (Aaron Kling).

- Minor cleanups for Rust cpufreq and cpumask APIs and fix MAINTAINERS
entry for cpu.rs (Abhinav Ananthu, Ritvik Gupta, and Lukas Bulwahn).

- Minor cleanups for miscellaneous cpufreq drivers (Arnd Bergmann, Dan
  Carpenter, Krzysztof Kozlowski, Sven Peter, and Svyatoslav Ryhel).

----------------------------------------------------------------
Aaron Kling (3):
      cpufreq: Export disable_cpufreq()
      cpufreq: dt: Add register helper
      cpufreq: tegra124: Allow building as a module

Abhinav Ananthu (2):
      rust: cpufreq: Ensure C ABI compatibility in all unsafe
      rust: cpufreq: use c_ types from kernel prelude

Arnd Bergmann (1):
      cpufreq: armada-8k: make both cpu masks static

Dan Carpenter (1):
      cpufreq: armada-8k: Fix off by one in armada_8k_cpufreq_free_table()

Krzysztof Kozlowski (1):
      cpufreq: brcmstb-avs: Fully open-code compatible for grepping

Lukas Bulwahn (1):
      MAINTAINERS: adjust file entry in CPU HOTPLUG

Ritvik Gupta (1):
      rust: cpumask: Replace `MaybeUninit` and `mem::zeroed` with `Opaque` APIs

Sven Peter (1):
      cpufreq: apple: drop default ARCH_APPLE in Kconfig

Svyatoslav Ryhel (1):
      drivers: cpufreq: add Tegra114 support

 MAINTAINERS                           |  2 +-
 drivers/cpufreq/Kconfig.arm           |  3 +--
 drivers/cpufreq/armada-8k-cpufreq.c   |  5 ++---
 drivers/cpufreq/brcmstb-avs-cpufreq.c |  2 +-
 drivers/cpufreq/cpufreq-dt-platdev.c  |  1 +
 drivers/cpufreq/cpufreq-dt.c          | 11 +++++++++++
 drivers/cpufreq/cpufreq-dt.h          |  2 ++
 drivers/cpufreq/cpufreq.c             |  2 ++
 drivers/cpufreq/tegra124-cpufreq.c    | 49 +++++++++++++++++++++++++++++++++++++------------
 rust/kernel/cpufreq.rs                | 60 ++++++++++++++++++++++++++----------------------------------
 rust/kernel/cpumask.rs                | 13 ++-----------
 11 files changed, 86 insertions(+), 64 deletions(-)

-- 
viresh

