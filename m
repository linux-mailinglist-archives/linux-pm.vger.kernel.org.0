Return-Path: <linux-pm+bounces-15245-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D46C1992432
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2024 08:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 037161C208F7
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2024 06:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680B714D718;
	Mon,  7 Oct 2024 06:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Cnc/GH9M"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E7D140E5F
	for <linux-pm@vger.kernel.org>; Mon,  7 Oct 2024 06:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728281390; cv=none; b=k3R7Kf8AvsFUHgDW0A2SUQSygJjzMg4XAElVgheGVJPappAWTy0nPm2WPnPUW3BJcB4DS7akcG4gHd7z2CugbrD4bgAx0O5BhP5SzflBt+7Lv1tJyFMba+iWc02ahxZytxYiunCOxoLK3l/eEBhxQARuqfbcZBE7UlMdbJlImo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728281390; c=relaxed/simple;
	bh=0UqydeCVPxPWC+B4ZmUIAklO8jK6JJU2zjJmjkP4Zzw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=m0PphdGiT3eUIVCM9vkSSKXpKVm767MR1RVfs5lA7iKbFVWAGJaiGsjoWtrcvCbRlwagwwvpSLYFL6fVsMnYVng18MF+x8g0QpM3do/61JrI31MJxOFDXKJIU3bxMQugmsgxVMJmFoYlElD56Qs/M+tqnxhKgrueiNVygEXCYFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Cnc/GH9M; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a8d446adf6eso686940966b.2
        for <linux-pm@vger.kernel.org>; Sun, 06 Oct 2024 23:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728281384; x=1728886184; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xq2tnlGyeLKsihIeoAIAbqWeiTvtm/+6nHQVzzGeTP4=;
        b=Cnc/GH9MTRNl0xXYQ9QWZRy8LxkUWa9/CcLNxYs9ixkcK4K20JaSrxSOTFpDaPn0TZ
         u2BIt3jg2fyLYSsF9wzCgxfyJbPYsPfS3NwKVXLo3dovKBV07htyiKCqqB/06gqK1jJS
         dQN1VWMqgXJ+BsVNJjlQnD98udx5s3dp3zNJe2FpE4n/vlD4fUV+fSvzmBEbXkVd/DOR
         cOT4w73PgfKhn10ShAmaGUi10A1vdXFLUT6cfltD090drAyym7REeIdu4KRNH6eBssY1
         Z/mlvkxE9tY3UWw+hV4Zk4uOSBMRyD2jyaUIcj/h7jFzrkHZzxGXPj45XXvbM9Ek9ALp
         7JZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728281384; x=1728886184;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xq2tnlGyeLKsihIeoAIAbqWeiTvtm/+6nHQVzzGeTP4=;
        b=N5IbpJ2oq9ZLrLMzdlNRQOmgdPvQM6LzpOtOr9PTUHyLSJGH/cZofggLXTptKflF43
         bIfHYiEhCj0BPcTi6+q2YjZuKQnKYWGWtERwU78mZsHP+wq0w6gwPN90asJhCNkUDGP1
         2FPsnJDCCKlmvJbAohxaRqYu6wkN27vdcFphpvyFFNOGNM7rEi4c0KVy77Bktq5pJ4jm
         NvNV9y1Tyc1kfJE+e1Ie1QuUzHTmXX8YMiCYeUxYO2aHKkboV2J9M+KUjI4ijWTYFPDt
         IyEuFfIaN3cY5upHwWqrCLiBVaqmnm/i31c+7lpatos1CyFyRvL0rT81rhmTjc3F9c9x
         Krmg==
X-Gm-Message-State: AOJu0Yw/vE6AJEVOBvpEla5VZPkXpWop95UbOyRJCFXLHFIvlsTdk3KY
	i9bwSfEIKITQ0N7SvWdF32XdIyHQqyJC3X21Zm6a5a/MoiD7VoSfniZIqsqgiV4=
X-Google-Smtp-Source: AGHT+IFSl0swjmv8y0/Uiao7Yo12lopZSAMtDU3gyEnhyFa3YF6LulThU1lQcDmRZN2u9Btg3NoYfw==
X-Received: by 2002:a17:906:d553:b0:a8d:1545:f48a with SMTP id a640c23a62f3a-a991c0531eamr994692366b.61.1728281384347;
        Sun, 06 Oct 2024 23:09:44 -0700 (PDT)
Received: from localhost ([2001:4090:a244:83ae:2517:2666:43c9:d0d3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a994c5a219bsm173698166b.152.2024.10.06.23.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 23:09:43 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v13 0/5] firmware: ti_sci: Introduce system suspend support
Date: Mon, 07 Oct 2024 08:08:53 +0200
Message-Id: <20241007-tisci-syssuspendresume-v13-0-ed54cd659a49@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPV6A2cC/z2MQQ6CMBAAv0L2bMm2AlJP/sN4KLDIJhbILhgJ4
 e82HjzOJDM7KAmTwjXbQejNytOYwJ5PGbRDGJ9kuEsCHLrCIlZmYW3Z6Ka66kxjJ6RrJENVWeL
 FYSixhxTPQj1/fuf7I3EvUzTLIBT+O/RYWF8453OLvq4rY03U+daE7cWNUN5OEY7jC5aillekA
 AAA
X-Change-ID: 20241006-tisci-syssuspendresume-e6550720a50f
To: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
 Len Brown <len.brown@intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nishanth Menon <nm@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Kamlesh Gurudasani <kamlesh@ti.com>, 
 Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>, 
 Vishal Mahaveer <vishalm@ti.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>, 
 Akashdeep Kaur <a-kaur@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9606; i=msp@baylibre.com;
 h=from:subject:message-id; bh=0UqydeCVPxPWC+B4ZmUIAklO8jK6JJU2zjJmjkP4Zzw=;
 b=owGbwMvMwCGm0rPl0RXRdfaMp9WSGNKZq9ma9ha7B99MCmCsnv++kDN3g+KVCcWdM4Ssc21u1
 df/X7m2o5SFQYyDQVZMkeXuh4Xv6uSuL4hY98gRZg4rE8gQBi5OAZiI2gmGn4zalm+TjXNPPJHe
 na7Jwsoe51TsI8Gi97rgxN/6ALPdixgZ7nOd+3zNLzXl+Na8Px9aJLILZS9UqJxi4zY4cPbXr/8
 G3AA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

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
6.12-rc1.

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

v6.12-rc1

Changelog:
**********
v13:
- Rebased to v6.12-rc1
- The patch to add the EXPORT for the dev_pm_qos_read_value() function
  was sent separately once and reintegrated into this series after some
  feedback. Commit message was rephrased.
  https://lore.kernel.org/lkml/20241002194446.269775-1-msp@baylibre.com/
- Removed an unreachable return 0 in ti_sci_prepare_system_suspend to
  make the compiler complain in case it gets reachable in the future.

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

---
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
 drivers/firmware/ti_sci.c              | 487 ++++++++++++++++++++++++++++++++-
 drivers/firmware/ti_sci.h              | 143 +++++++++-
 include/linux/soc/ti/ti_sci_protocol.h |  30 ++
 4 files changed, 659 insertions(+), 2 deletions(-)
---
base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
change-id: 20241006-tisci-syssuspendresume-e6550720a50f

Best regards,
-- 
Markus Schneider-Pargmann <msp@baylibre.com>


