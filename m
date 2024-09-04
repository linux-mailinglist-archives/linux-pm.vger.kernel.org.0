Return-Path: <linux-pm+bounces-13622-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 969AF96C7C4
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 21:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F5061F26629
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 19:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9511E1E6DEA;
	Wed,  4 Sep 2024 19:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="tj/4/nJY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CA78286A
	for <linux-pm@vger.kernel.org>; Wed,  4 Sep 2024 19:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725478957; cv=none; b=U6TWxouUDfxFhrQlbNcjLdn9cSQhUYSFopD3jXzfwowGzW2j0YMuBN1yVqrsc5TpbrHeWp+NR3r8bxKRj+JrnUPKOThojfMoisqMcxcQ2/xbzsKOFbzv9H+VgA/pxiC82jUollOE0Oj8gHuAoa823J7TZT5aW6sLsT6rHK8Cyy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725478957; c=relaxed/simple;
	bh=m6WtAER+1F11MfUMWmg5KEdZ9iGcA3C6UAVzQuGSz54=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pk802v08F2uKCWrfVrRlbyd4LW5WHHexKI7WuuIOZYpQGN+pb+JC/fYDtsewhh8cdaa8vnh5WN4KkcxwZepzMdYxyN9w3ZUMAGRZZkJFktu0uKAkT7te59oi+nvEBCxNj/pGmPdHk5tdMJpBr/QjHBgfYyes1bRP/mc5kAxAcKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=tj/4/nJY; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42bbe809b06so45606525e9.1
        for <linux-pm@vger.kernel.org>; Wed, 04 Sep 2024 12:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725478952; x=1726083752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CyLYto3aL8kOgp9Zk91CMri0QQCLg48XeOPUXir002c=;
        b=tj/4/nJYlFVyg/b1gRZIBEBLFUQMKjuNnMHPUVfwX8eQUYs5S3HsZWaLJKvs6L5Ty0
         eG4bwvMX1/s5a79qJ/0p4gcFIfiNkdrw+70LkyCVt9Yx4G8syEKOEqlT49O28rAxbvTG
         8JPGa4h67SCS2mDE47gT13A0riRumapr0MmhVCOTy0FmwYNXPewX6iEsoiuypqS8Ckvp
         DQ7kAK9V+PXU+fu7MiM2Fgn4WvgSEJ5GR5QaY+9KFSWkDczj3i1U7RZqjmLLZRoon/Yq
         jvHcrCRvRjSUBF2HGIwvaDpkyNPA2uVWYURpQHSfH8CoQYxMpzyS5ZSnX/+wPxicy0Lr
         Y17g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725478952; x=1726083752;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CyLYto3aL8kOgp9Zk91CMri0QQCLg48XeOPUXir002c=;
        b=vpQXUEzlAIl3mvDNYOmD3S+BLAhSgsgmTaMr6RwTey54i3GR4GoN75UiYWKKWifXd6
         +TZwlxsHfnsk9a//oN+MTZTy8GHhFN+0+wAIRRky9NU4PNXbP6BGHl91UN6qHQtZE+vM
         JPItyD68CI5wZDboB2XIxXCq/wkHs2MomslJBawZSPF28AnE2J3sWuZefqj4OKFa2Suz
         jY9idAQ3kI7NouD4kkA9UuZ/JAOJmH69FpwgC+TFJR+izP+A3dBo3puoE9xtjh86Yfts
         mEttp13Wodh5XacFnsYpZByenVHl1PizYDQBlE/dUarz7fJkJ+YayFOUdJxsOlNYjpxO
         ZXIg==
X-Forwarded-Encrypted: i=1; AJvYcCW8myb4dcT2jcP/1VtULMPS4EdPJs8pN9VJEyH9TCggeCNHLEKMk2Cfhd/P72xvntTaiJAgKSh0cw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6acFrBDN/quH3Hswiux1Cx5FvQ48aF/EOSmZxYEipEDJBcSyw
	m7I1jYSdzYNuc2jO4j2fiZm5qCXEfDKkFSynabMlijk0JLcOhRV4ozr59ggGAJY=
X-Google-Smtp-Source: AGHT+IHj+X7o9/Siz24ePquVbJTJ8zl9B2u4l/XgtNSjVWj00QZ3pu8obGFuoMfmE4qXqtR0cVwLpg==
X-Received: by 2002:a05:600c:5110:b0:42b:afe3:e9f4 with SMTP id 5b1f17b1804b1-42bb02c10b2mr166953895e9.3.1725478952007;
        Wed, 04 Sep 2024 12:42:32 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a247:83d8:caa7:e645:3612:56b6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374c03595fcsm12473625f8f.98.2024.09.04.12.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 12:42:31 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Nishanth Menon <nm@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	Len Brown <len.brown@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Vibhore Vardhan <vibhore@ti.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Dhruva Gole <d-gole@ti.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v12 0/5] firmware: ti_sci: Introduce system suspend support
Date: Wed,  4 Sep 2024 21:42:24 +0200
Message-ID: <20240904194229.109886-1-msp@baylibre.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Abstract
********

This series introduces necessary ti_sci driver functionality to support
various Suspend-to-RAM modes on TI AM62 family of devices. These Low
Power Modes include Deep Sleep and MCU Only as described in section
"6.2.4 Power Modes" of the AM62P Technical Reference Manual [0].

Summary
*******

This series is a restructuring and rebase of the patch series by
Dave Gerlach [1] and Dhruva Gole [2]. It applies on top of Linux
6.11-rc1.

The kernel triggers entry to Low Power Mode through the mem suspend
transition with the following:

* At the  bootloader stage, one is  expected to package the  TIFS stub
  which then gets  pulled into the Tightly coupled memory  of the Device
  Mgr  (DM) R5  when it  starts up.  If using  U-Boot, then  it requires
  tispl.bin to contain the TIFS stub. Refer to documentation in upstream
  u-boot[3] for further details. The  supported firmware version is from
  TI Processor SDK >= 10.00 ie. tag 10.00.04 from ti-linux-firmware [4].

* Use a TF-A binary that supports PSCI_SYSTEM_SUSPEND call. This causes
  system to use PSCI system suspend as last step of mem sleep.

* We add support for the TISCI_MSG_QUERY_FW_CAPS message, used to retrieve
  the firmware capabilities of the currently running system firmware [6].
  Sysfw version >= 10.00.04 support LPM_DM_MANAGED capability, where
  Device Mgr firmware now manages which low power mode is chosen. Going
  forward, this is the default configuration supported for TI AM62 family
  of devices. The state chosen by the DM can be influenced by sending
  constraints using the new LPM constraint APIs. (Patch 1)

* The firmware requires that the OS sends a TISCI_MSG_PREPARE_SLEEP
  message in order to provide details about suspend. The ti_sci driver
  must send this message to firmware with the above information
  included, which it does during the driver suspend handler when
  PM_MEM_SUSPEND is the determined state being entered. The mode being
  sent depends on whether firmware capabilities have support for
  LPM_DM_MANAGED feature. Legacy firmware or those supporting other
  modes can extend the mode selection logic as needed. (Patch 2)

* We also add the remaining TISCI Low Power Mode messages required for
  inquiring wake reason and managing LPM constraints as part of a new PM
  ops. These messages are part of the TISCI PM Low Power Mode API [5].
  (Patch 3)

* Finally if any CPUs have PM QoS resume latency constraints set, we
  aggregate these and set the TISCI system-wide latency constraint.
  (Patch 4)

Testing
*******

This series can for example be tested with a am62a-lp-sk board.

For am62a-lp-sk all usb nodes have to be disabled at the moment (usbss0,
usb0, usbss1 and usb1). There is currently an issue with USB Link Power
Management and turning off the USB device which is being worked on.

Once booted suspend/resume can be tested with rtcwake:
  $ rtcwake -m mem -s 10 -d /dev/rtc0

Make sure /dev/rtc0 corresponds to rtc-ti-k3:
  $ dmesg | grep rtc-ti-k3
  rtc-ti-k3 2b1f0000.rtc: registered as rtc0

Base commit:
************

v6.11-rc1

Changelog:
**********
v12:
- Add patch to add an export for dev_pm_qos_read_value() to fix module
  build on KEYSTONE
- Remove include of linux/dev_printk.h

v11:
- Add dev_err() in many error cases
- Fix a typo in the commit message of 'firmware: ti_sci: Add support for
  querying the firmware caps'
- Fix URL in commit message
- Unify error handling and printing over the added ti_sci_cmd_*
  functions
- Use dev_* instead of pr_*
- Add a debug message listing the capabilities the firmware returned
- Add a small comment describing why context address is 0x0
- Removed unnecessary debug prints
- Restructure the ifdefs for pm ops as suggested
- Only print the wake reason if there was no error. If there is an
  error, the ti_sci_cmd_lpm_wake_reason already printed an error. As a
  missing reason is not critical, the error is ignored and the system
  continues to resume
- Remove wakeup source macros from sci_protocol.h

v10:
- add "wake reason" handling which is also supported by 10.x
  firmware update, but was mistakenly left out of v9
- fix debug print of which CPU caused max CPU latency
- update TRM pointer[0] to point to AM62P TRM which has better
  description of low-power modes shared across AM62P family
- update u-boot documentaion pointer to point to upstream u-boot
  commit.

v9:
- Include Kevin's patch to add CPU latency constraint management into
  this series. Posted here in v3:
  https://lore.kernel.org/lkml/20240802214220.3472221-1-khilman@baylibre.com/
- reorder patches to avoid any build warnings
- ti_sci_cmd_prepare_sleep was moved into the patch that adds suspend
  and resume calls
- pmops wake_reason is now only set if the capabilities exist
- Use pmops pointer instead of full path

v8:
- Restructuring of code to include all TISCI PM LPM ops
- Removing malloc related to TIFS Stub as it is managed by DM
- Dropping has_lpm check as suggested by Nishanth
- Using LPM_DM_MANAGED capability for mode selection
- Updating the suspend and resume callback handlers

v7:
- Address Andrew's concerns on SYSFW fw_caps API
- Remove all the unused functions and variables including
  set_io_isolation and wake_reason calls
- use dma_free_attrs
- remove IO isolation related code from linux side,

v6:
- link to v6 [5]
- Loading of FS Stub from linux no longer needed, hence drop that patch,
- Drop 1/6 and 5/6 from the previous series [4].
- Add system suspend resume callbacks which were removed in
commit 9225bcdedf16297a346082e7d23b0e8434aa98ed ("firmware: ti_sci: Use
system_state to determine polling")
- Use IO isolation while putting the system in suspend to RAM

v5:
- Add support (patch 3) for detecting the low power modes (LPM) of the
  FW/SoC with a recently introduced core TISCI_MSG_QUERY_FW_CAPS message.
- Use TISCI_MSG_QUERY_FW_CAPS instead of misusing the
  TISCI_MSG_PREPARE_SLEEP to detect the FW/SoC low power caps (patch 4).
- Take into account the supported LPMs in ti_sci_prepare_system_suspend()
  and handle the case when CONFIG_SUSPEND is not enabled (patch 6) that
  was reported by Roger Quadros and LKP.
- Pick up Rob Herring's "Reviewed-by" tag for the binding patch.

v4:
- Fix checkpacth warnings in patches 2 and 3.
- Drop the links with anchors in patch 2.

v3:
- Fix the compile warnings on 32-bit platforms reported by the kernel
  test robot in patches (3,5).
- Pick up Roger's "Tested-by" tags.

v2:
- Addressed comments received for v1 series [1].
- Updated v1 patch 5 to use pm notifier to avoid firmware loading
  issues.
- Dropped the reserved region requirement and allocate DMA memory
  instead. The reserved region binding patch is also removed.
- Introduce two more TISCI LPM messages that are supported in SysFW.
- Fixes in error handling.

References:
***********

[0] https://www.ti.com/lit/pdf/spruiv7
[1] https://lore.kernel.org/lkml/20220421203659.27853-1-d-gerlach@ti.com
[2] https://lore.kernel.org/lkml/20230804115037.754994-1-d-gole@ti.com
[3] https://source.denx.de/u-boot/u-boot/-/commit/962f60abca82bb11501bc0c627abacda15bed076
[4] https://git.ti.com/cgit/processor-firmware/ti-linux-firmware/commit/?h=10.00.06&id=193f7d7570583a41ddc50a221e37c32be6be583e
[5] https://software-dl.ti.com/tisci/esd/latest/2_tisci_msgs/pm/lpm.html
[6] https://downloads.ti.com/tisci/esd/latest/2_tisci_msgs/general/core.html#tisci-msg-query-fw-caps

Dave Gerlach (1):
  firmware: ti_sci: Introduce Power Management Ops

Georgi Vlaev (1):
  firmware: ti_sci: Add support for querying the firmware caps

Kevin Hilman (1):
  firmware: ti_sci: add CPU latency constraint management

Markus Schneider-Pargmann (1):
  PM: QoS: Export dev_pm_qos_read_value

Vibhore Vardhan (1):
  firmware: ti_sci: Add system suspend and resume call

 drivers/base/power/qos.c               |   1 +
 drivers/firmware/ti_sci.c              | 489 ++++++++++++++++++++++++-
 drivers/firmware/ti_sci.h              | 143 +++++++-
 include/linux/soc/ti/ti_sci_protocol.h |  30 ++
 4 files changed, 661 insertions(+), 2 deletions(-)

-- 
2.45.2


