Return-Path: <linux-pm+bounces-10814-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE85692B0A9
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 08:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DBA81F24C94
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 06:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD7E13213A;
	Tue,  9 Jul 2024 06:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HS/22Mee"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA7513C699
	for <linux-pm@vger.kernel.org>; Tue,  9 Jul 2024 06:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720507912; cv=none; b=X9/mm4N90fvm5yjL8Bn4NyJ8XKz9u07VRp8c5Yw5/vUNTg9MpHHWIY0Ye2cBPs0gVwpbFlTpz67h4JMkg3IEwJALctKHdPujXF7G860YAsH3f/WguekLNyKF9Y8I/c3RumzamP2MhlyUH+UWUp7Vm+Vw018Y9fWbv0OYHp5SEnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720507912; c=relaxed/simple;
	bh=oWh/2Zr5nM6T1Fccua2chAsJEbdyUUI5uk88e0SLzG8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WskqC14ZcHSpb8W9xhA1xv9WoSOMIS2mp6uQvMfoWm8iiJGq0nDFaNwLWww3oNEQ5NSKt1zyogGE+Yyc0gCEsYUg+jCQRvUbhtMvF6FrLheYuYzU5dA0iD3PHU2dlIsHaIo+PYfN5PlNndCJ4f21S3fm4chiTpo0VEyqiNzTONA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HS/22Mee; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3d92aa0ade0so1175964b6e.1
        for <linux-pm@vger.kernel.org>; Mon, 08 Jul 2024 23:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720507909; x=1721112709; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U4O+M/5eTUP8W5asZrLPI0Cmtamy26NBhW4ki3sBDqM=;
        b=HS/22Meeb6sCeJG5bdkXiQAMndrKIpG147uF8+HV1NsJkCrZeSlHwyNRhdmWMP9Ors
         UBMZzB9BjhrQE96mIl3NS8o9vWUCyM/tA+cE79zGvt8ULSUF/mhSOqpEres3Ap8dY7x0
         8KPoSA0276UXAQ32i2JYZWBZKE76gCrH+iwA4bUPHYj2turgmSnXHjUtj8CRbdrAD4uo
         V71R3haLz505zmC+NUgbJEmuBP7/92xtv1DI9HoNuuTui3akp+/EHBfKF1HexazqjnjK
         98yqDDxnLPkLt5VdbCqvXfWEPnQZcleh+Gfbak7Y5qhlOpd6blI81Ht/XUF5z3GCatA0
         MEsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720507909; x=1721112709;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U4O+M/5eTUP8W5asZrLPI0Cmtamy26NBhW4ki3sBDqM=;
        b=tvGd8DCsmmXjoXvHibrxg0yuLNGkNORTOFz6i3ljMBxzimlJikglY5g+33Slz/QWvp
         UuisQLCFCuFSX2vTrAkzEaeDUKTqH79DDLyvfutmvgNNyOfH13cYWvQtAZOjvovx9Bwb
         Hbr6Z45yAcS6aO8nMLTkrRQxGjphBaViPOtq8cnczxTm9lYFYxEMWUYcxJ7MvBD/p68D
         kzxvfsFWNIhbYHv4hbbpbtJba0wO7ofEhJkVqbZK0iF2mDK9CW+jq+2qAjxLGiILZimJ
         gnYJjKIW6S2cfwRdz60bXC41D2zrK3W5WJuCRZMDrgFMXDSgCJ3tBgeiuJ1quaA6Ay1l
         nv+A==
X-Gm-Message-State: AOJu0YztKTj9wf6L7tiONVdTGjIQUvKA05aeOSqv9zXs8Gm2aSFPP8F7
	0RRgX29EULuyKUmcBTFeVg5tZPvrX2Memes/rpMWMpx7Y5ZOlEs314nCoFaaEH0=
X-Google-Smtp-Source: AGHT+IFSxqGTlqMFjv08U0QsgGUSMwt33yqSxxDHhU3wy+Pts1//c4trsRHV5AUSzsjtOz5mS0Lv4A==
X-Received: by 2002:a05:6808:170a:b0:3d2:17c2:8301 with SMTP id 5614622812f47-3d93c039304mr1863626b6e.30.1720507909184;
        Mon, 08 Jul 2024 23:51:49 -0700 (PDT)
Received: from localhost ([122.172.84.129])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-77d62c4c7b0sm838081a12.53.2024.07.08.23.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 23:51:48 -0700 (PDT)
Date: Tue, 9 Jul 2024 12:21:46 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] cpufreq/arm updates for 6.11
Message-ID: <20240709065146.okez4bvizmf5bxtx@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Rafael,

The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/cpufreq-arm-updates-6.11

for you to fetch changes up to d992f881764cc89444aa5a9752ff508a1baeb61e:

  cpufreq: sti: fix build warning (2024-07-09 08:45:43 +0530)

----------------------------------------------------------------
ARM cpufreq updates for 6.11

- cpufreq: Add Loongson-3 CPUFreq driver support (Huacai Chen).
- Make exit() callback return void (Lizhe and Viresh Kumar).
- Minor cleanups and fixes in several drivers (Bryan Brattlof,
  Javier Carrasco, Jagadeesh Kona, Jeff Johnson, Nícolas F. R. A. Prado,
  Primoz Fiser, Raphael Gallais-Pou, and Riwen Lu).

----------------------------------------------------------------
Bryan Brattlof (2):
      cpufreq: ti: update OPP table for AM62Ax SoCs
      cpufreq: ti: update OPP table for AM62Px SoCs

Huacai Chen (1):
      cpufreq: Add Loongson-3 CPUFreq driver support

Jagadeesh Kona (1):
      cpufreq: scmi: Avoid overflow of target_freq in fast switch

Javier Carrasco (4):
      cpufreq: sun50i: fix memory leak in dt_has_supported_hw()
      cpufreq: sun50i: replace of_node_put() with automatic cleanup handler
      cpufreq: qcom-nvmem: fix memory leaks in probe error paths
      cpufreq: qcom-nvmem: eliminate uses of of_node_put()

Jeff Johnson (1):
      cpufreq: dt-platdev: add missing MODULE_DESCRIPTION() macro

Lizhe (1):
      cpufreq: Make cpufreq_driver->exit() return void

Nícolas F. R. A. Prado (1):
      cpufreq: mediatek: Use dev_err_probe in every error path in probe

Primoz Fiser (2):
      cpufreq: ti-cpufreq: Handle deferred probe with dev_err_probe()
      OPP: ti: Fix ti_opp_supply_probe wrong return values

Raphael Gallais-Pou (2):
      cpufreq: sti: add missing MODULE_DEVICE_TABLE entry for stih418
      cpufreq: sti: fix build warning

Riwen Lu (1):
      cpufreq/cppc: Don't compare desired_perf in target()

Ryan Walklin (1):
      cpufreq: sun50i: add Allwinner H700 speed bin

Viresh Kumar (3):
      cpufreq: nforce2: Remove empty exit() callback
      cpufreq: loongson2: Remove empty exit() callback
      cpufreq: pcc: Remove empty exit() callback

Yang Li (1):
      cpufreq: longhaul: Fix kernel-doc param for longhaul_setstate

 MAINTAINERS                            |   1 +
 drivers/cpufreq/Kconfig                |  12 +++++
 drivers/cpufreq/Makefile               |   1 +
 drivers/cpufreq/acpi-cpufreq.c         |   4 +-
 drivers/cpufreq/amd-pstate.c           |   7 +--
 drivers/cpufreq/apple-soc-cpufreq.c    |   4 +-
 drivers/cpufreq/bmips-cpufreq.c        |   4 +-
 drivers/cpufreq/cppc_cpufreq.c         |  12 ++---
 drivers/cpufreq/cpufreq-dt-platdev.c   |   1 +
 drivers/cpufreq/cpufreq-dt.c           |   3 +-
 drivers/cpufreq/cpufreq-nforce2.c      |   6 ---
 drivers/cpufreq/e_powersaver.c         |   3 +-
 drivers/cpufreq/intel_pstate.c         |   8 ++--
 drivers/cpufreq/longhaul.c             |   5 ++-
 drivers/cpufreq/loongson2_cpufreq.c    |   6 ---
 drivers/cpufreq/loongson3_cpufreq.c    | 395 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/cpufreq/mediatek-cpufreq-hw.c  |   4 +-
 drivers/cpufreq/mediatek-cpufreq.c     |  76 +++++++++++++++-----------------
 drivers/cpufreq/omap-cpufreq.c         |   3 +-
 drivers/cpufreq/pasemi-cpufreq.c       |   6 +--
 drivers/cpufreq/pcc-cpufreq.c          |   6 ---
 drivers/cpufreq/powernow-k6.c          |   5 +--
 drivers/cpufreq/powernow-k7.c          |   3 +-
 drivers/cpufreq/powernow-k8.c          |   6 +--
 drivers/cpufreq/powernv-cpufreq.c      |   4 +-
 drivers/cpufreq/ppc_cbe_cpufreq.c      |   3 +-
 drivers/cpufreq/qcom-cpufreq-hw.c      |   4 +-
 drivers/cpufreq/qcom-cpufreq-nvmem.c   |  12 ++---
 drivers/cpufreq/qoriq-cpufreq.c        |   4 +-
 drivers/cpufreq/scmi-cpufreq.c         |   8 ++--
 drivers/cpufreq/scpi-cpufreq.c         |   4 +-
 drivers/cpufreq/sh-cpufreq.c           |   4 +-
 drivers/cpufreq/sparc-us2e-cpufreq.c   |   3 +-
 drivers/cpufreq/sparc-us3-cpufreq.c    |   3 +-
 drivers/cpufreq/speedstep-centrino.c   |  10 ++---
 drivers/cpufreq/sti-cpufreq.c          |   3 +-
 drivers/cpufreq/sun50i-cpufreq-nvmem.c |  30 +++++--------
 drivers/cpufreq/tegra194-cpufreq.c     |   4 +-
 drivers/cpufreq/ti-cpufreq.c           |  96 ++++++++++++++++++++++++++++++++++++++--
 drivers/cpufreq/vexpress-spc-cpufreq.c |   5 +--
 drivers/opp/ti-opp-supply.c            |   6 ++-
 include/linux/cpufreq.h                |   2 +-
 42 files changed, 603 insertions(+), 183 deletions(-)
 create mode 100644 drivers/cpufreq/loongson3_cpufreq.c

-- 
viresh

