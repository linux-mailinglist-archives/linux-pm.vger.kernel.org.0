Return-Path: <linux-pm+bounces-35783-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFCCEBC1375
	for <lists+linux-pm@lfdr.de>; Tue, 07 Oct 2025 13:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1566189129B
	for <lists+linux-pm@lfdr.de>; Tue,  7 Oct 2025 11:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF21243376;
	Tue,  7 Oct 2025 11:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S21xZcvf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553CB1E5201
	for <linux-pm@vger.kernel.org>; Tue,  7 Oct 2025 11:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759836621; cv=none; b=Ki/BoPOW0eyFpfxn3+mAHKkgQmFufsz8SUjWL/n9eGIjAq+QHwxHnrs7MDxTPQGoYBeYv9eQvG40reCowcw8a9HznYmYBPRhokIpzQiKXS+8m5Tk530GCX/SBMMNky6I+qgAwjIVDASY8Y3mZljortMVMqNrVBX6Y7Liw45KAGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759836621; c=relaxed/simple;
	bh=EsLib4jKtsQhcE5lGFvp6K+ONcTD+59xsfIRVcTeGzM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=WVz4faBaozNTHBJqcD15FEimzcT3PQKD2JtNpizaO06UBD7k94l0VwhfwcMREe7wPax/0ePf5cWWA9b6AyHcpp9BrsVqt9Z42zmPWb1vG3AnV/xg+rMkxfkTXDrSa3XpZh91L+c7My7+WT7HrzFYjdU8OaASFeIvV+op+yZe6yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S21xZcvf; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-43f64a5014aso3145193b6e.1
        for <linux-pm@vger.kernel.org>; Tue, 07 Oct 2025 04:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759836618; x=1760441418; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gjcwVwugsbZr5dwcPHgqy1+P2gVP3IIdmSv12HxlkUs=;
        b=S21xZcvft3lafu37qWyw2QmunnpxH4uEtIm+MSiTQtaVdKOWVcTkKnuZcdSgErrUh1
         B0NUgN9S7ioZhGjH6HE0AsqtqO4nLoLcZGU7+wrMn0c0mqn6N1YAEDiK3bVYS8Vjubew
         Y2hlpcQ+0gxkBlvGDhgJSQBCenVE7KYmYsZh+D6PNlE91/7EWL/+zpkZ+0DHVv05+SzJ
         6SNFFudaLTNpeO/j38+dkq7X+aj47Ig1LawPO9xH4uVfSYoowGT8igmxZmdBLcjBS1dV
         Wk/Umg6lcrqBjmy8QhEEktJnuawtanyOG0utb2XiUNQNhGJGcZ6L/yArSZP90YOsn8RY
         YecA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759836618; x=1760441418;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gjcwVwugsbZr5dwcPHgqy1+P2gVP3IIdmSv12HxlkUs=;
        b=lqr9k/gV488nOPTLfRY2RVsZxYK4ugBrINv+OCWvIQAJOFlacNYfGSeMfq0kufk3vK
         d0wQMjA3QY5d5Y1VbehikF8jolG3jUA60THIu7+QjUTc2xf+9LN72OabrcZJ8R7+eTtM
         5oYgUVPtPUmFEMCjgFyD74Vlzey/2+pCd/zIunLY0tv9W2JXaF1fLBeswamV0JNkSJ6t
         vqlhkQbPXKccIVJ5BzPNM5zHrYt6zWSv0ot1YiR/kZvNjr+CPUFAB2Xq4flhjP90YAID
         HdFEY3zrxU6QuE+HuR0xTGxR9uxr0rwDd66DJJwSuJmquspfpPGanIi5Af2SB8YSbqxl
         swNQ==
X-Gm-Message-State: AOJu0Yzp/JQ0t6ZPcuMLFwpt96bp3/BmkGZmHVEy9MpQrofsjECnkuM7
	hkc3vN3eoBvKg8g8aSyp2pHnWLY1qnOfhw6O99JIlul/3jVkvvKDUd+o55tazl5bLoaDbsuQKJl
	n+1/cMihVrNQupNkC0OWU2ytWj1iq1Ag=
X-Gm-Gg: ASbGncvi/vbFhmF8BUfLAyNTZI8TiN+VtNdQ+5wsl7UAESpL7MKKFJHzArstbyvmxcO
	fqa2uQP2TTyrBWxTTaaG6uPDszx9ZDjHJxCzbTNxJo2PoG1jWrN3lAVG5q5eSg0mEWUeyzuB3gb
	8daK7dwJpJYMJChcdwm2+YM9xpmHCeul+UXPqzxyPQNcW5qBbigaGRVVjAZcEJT9YBcjsT9ein/
	FmyJxfLSBSHXFN0/t0X5NOXGcFx
X-Google-Smtp-Source: AGHT+IFp5L4DFeud5EQuTne829gmDtDXw+y5eMnOv46v4L88QxCcbfZ8j3cuFqfCxtLwVYXsJ7RLy3udC7MYGJPErQE=
X-Received: by 2002:a05:6808:18a1:b0:439:b9b3:af44 with SMTP id
 5614622812f47-43fc179fbb6mr8638021b6e.19.1759836617959; Tue, 07 Oct 2025
 04:30:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Rafa=C5=82_Wysocki?= <rjwysocki@gmail.com>
Date: Tue, 7 Oct 2025 13:30:06 +0200
X-Gm-Features: AS18NWA7NSJgJMBP_QWz-F0G79n56ApPJJhOJtEnRapI7ODshjLeIEP1EiHU95s
Message-ID: <CAJZ5v0i7H832neTnZtHwHBD0gwQSJ_8Tyxc49K2NoO5n4=1eKQ@mail.gmail.com>
Subject: [GIT PULL] More power management updates for v6.18-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.18-rc1-2

with top-most commit 53d4d315d4f7f17882ef11db49b06ca6b0be8ff7

 Merge branch 'pm-cpufreq'

on top of commit 991053178e08fb4d1f80398367db05c2cc4f20b4

 Merge tag 'pm-6.18-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive more power management updates for 6.18-rc1.

These are cpufreq fixes and cleanups on top of the material merged
previously, a power management core code fix and updates of the
runtime PM framework including unit tests, documentation updates and
introduction of auto-cleanup macros for runtime PM "resume and get"
and "get without resuming" operations.

Specifics:

 - Make cpufreq drivers setting the default CPU transition latency to
   CPUFREQ_ETERNAL specify a proper default transition latency value
   instead which addresses a regression introduced during the 6.6 cycle
   that broke CPUFREQ_ETERNAL handling (Rafael Wysocki)

 - Make the cpufreq CPPC driver use a proper transition delay value
   when CPUFREQ_ETERNAL is returned by cppc_get_transition_latency() to
   indicate an error condition (Rafael Wysocki)

 - Make cppc_get_transition_latency() return a negative error code to
   indicate error conditions instead of using CPUFREQ_ETERNAL for this
   purpose and drop CPUFREQ_ETERNAL that has no other users (Rafael
   Wysocki, Gopi Krishna Menon)

 - Fix device leak in the mediatek cpufreq driver (Johan Hovold)

 - Set target frequency on all CPUs sharing a policy during frequency
   updates in the tegra186 cpufreq driver and make it initialize all
   cores to max frequencies (Aaron Kling)

 - Rust cpufreq helper cleanup (Thorsten Blum)

 - Make pm_runtime_put*() family of functions return 1 when the
   given device is already suspended which is consistent with the
   documentation (Brian Norris)

 - Add basic kunit tests for runtime PM API contracts and update return
   values in kerneldoc comments for the runtime PM API (Brian Norris,
   Dan Carpenter)

 - Add auto-cleanup macros for runtime PM "resume and get" and "get
   without resume" operations, use one of them in the PCI core and
   drop the existing "free" macro introduced for similar purpose, but
   somewhat cumbersome to use (Rafael Wysocki)

 - Make the core power management code avoid waiting on device links
   marked as SYNC_STATE_ONLY which is consistent with the handling of
   those device links elsewhere (Pin-yen Lin)

Thanks!


---------------

Aaron Kling (2):
      cpufreq: tegra186: Set target frequency for all cpus in policy
      cpufreq: tegra186: Initialize all cores to max frequencies

Brian Norris (3):
      PM: runtime: Add basic kunit tests for API contracts
      PM: runtime: Make put{,_sync}() return 1 when already suspended
      PM: runtime: Update kerneldoc return codes

Dan Carpenter (1):
      PM: runtime: Fix error checking for kunit_device_register()

Gopi Krishna Menon (2):
      docs/zh_TW: Fix malformed table
      docs/zh_CN: Fix malformed table

Johan Hovold (1):
      cpufreq: mediatek: fix device leak on probe failure

Pin-yen Lin (1):
      PM: sleep: Do not wait on SYNC_STATE_ONLY device links

Rafael J. Wysocki (8):
      PM: runtime: Add auto-cleanup macros for "resume and get" operations
      PCI/sysfs: Use runtime PM guard macro for auto-cleanup
      PM: runtime: Drop DEFINE_FREE() for pm_runtime_put()
      cpufreq: Make drivers using CPUFREQ_ETERNAL specify transition latency
      cpufreq: CPPC: Avoid using CPUFREQ_ETERNAL as transition delay
      ACPI: CPPC: Do not use CPUFREQ_ETERNAL as an error value
      cpufreq: Drop unused symbol CPUFREQ_ETERNAL
      PM: runtime: Introduce one more usage counter guard

Thorsten Blum (1):
      rust: cpufreq: streamline find_supply_names

---------------

 Documentation/admin-guide/pm/cpufreq.rst           |   4 -
 Documentation/cpu-freq/cpu-drivers.rst             |   3 +-
 .../translations/zh_CN/cpu-freq/cpu-drivers.rst    |   3 +-
 .../translations/zh_TW/cpu-freq/cpu-drivers.rst    |   3 +-
 drivers/acpi/cppc_acpi.c                           |  16 +-
 drivers/base/Kconfig                               |   6 +
 drivers/base/base.h                                |   1 +
 drivers/base/core.c                                |   2 +-
 drivers/base/power/Makefile                        |   1 +
 drivers/base/power/main.c                          |   6 +-
 drivers/base/power/runtime-test.c                  | 253 +++++++++++++++++++++
 drivers/base/power/runtime.c                       |   5 +
 drivers/cpufreq/amd-pstate.c                       |   8 +-
 drivers/cpufreq/cppc_cpufreq.c                     |  14 +-
 drivers/cpufreq/cpufreq-dt.c                       |   2 +-
 drivers/cpufreq/imx6q-cpufreq.c                    |   2 +-
 drivers/cpufreq/mediatek-cpufreq-hw.c              |   2 +-
 drivers/cpufreq/mediatek-cpufreq.c                 |  14 +-
 drivers/cpufreq/rcpufreq_dt.rs                     |  12 +-
 drivers/cpufreq/scmi-cpufreq.c                     |   2 +-
 drivers/cpufreq/scpi-cpufreq.c                     |   2 +-
 drivers/cpufreq/spear-cpufreq.c                    |   2 +-
 drivers/cpufreq/tegra186-cpufreq.c                 |  35 ++-
 drivers/pci/pci-sysfs.c                            |   5 +-
 include/acpi/cppc_acpi.h                           |   6 +-
 include/linux/cpufreq.h                            |   6 +-
 include/linux/pm_runtime.h                         | 105 ++++++---
 rust/kernel/cpufreq.rs                             |   7 +-
 28 files changed, 426 insertions(+), 101 deletions(-)

