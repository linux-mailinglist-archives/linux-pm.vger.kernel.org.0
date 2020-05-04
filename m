Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F104C1C459C
	for <lists+linux-pm@lfdr.de>; Mon,  4 May 2020 20:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730915AbgEDSQk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 May 2020 14:16:40 -0400
Received: from mga12.intel.com ([192.55.52.136]:27142 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730118AbgEDSQk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 4 May 2020 14:16:40 -0400
IronPort-SDR: oCnErzAT7DVc1SeSTbjfz11UUwloklhguMI3arBbS72HPlrHN8IxUJK2K/V48fJPhtfxT7aFRX
 0v6fRxxNji/g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2020 11:16:31 -0700
IronPort-SDR: NnSxUvHoT5minm6IYX7yq0PVyLdootB7wWKOxh7irLgQVGMhJUNbmc5LQ+yeNolF4wkuOS4X0b
 e4V0NcuXoFwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,352,1583222400"; 
   d="scan'208";a="259427099"
Received: from spandruv-mobl.amr.corp.intel.com ([10.212.145.237])
  by orsmga003.jf.intel.com with ESMTP; 04 May 2020 11:16:30 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [RFC][PATCH 0/5] thermal: Add new mechanism to get thermal notification
Date:   Mon,  4 May 2020 11:16:11 -0700
Message-Id: <20200504181616.175477-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

I presented this idea during LPC 2018.
Refer to the following link:
https://linuxplumbersconf.org/event/2/contributions/182/attachments/38/45/LPC_2018_Thermal-Srinivas-Rui.pdf
There was broad agreement about this.

At that time, there was no use case for non x86 systems. But now there is
interest from Linaro community. But this doesn't meet all the requirement for
Linaro use cases. So I think, Daniel Lezcano <daniel.lezcano@linaro.org> is working
on a follow up series.

Thermal actions can be categorized in three types:
1. Urgent actions in micro to less than milli second range
2. Actions at milli seconds scale
3. Non urgent actions but improves thermal management, which improves long
term reliability of the system and also allow to meet safety standards

The first category of actions usually handled by the hardware and firmware to
meet the time scale. Some examples are sudden spike of CPU temperature which
needs immediate action.

Second category of actions are done at OS kernel level. Like graceful shutdown
of a system, when a critical temperature is reached. Also a good place to take
takes actions where there is a direct correlation from a thermal source to a
cooling action (one to one relationship). The Linux thermal subsystem has in
built governors to bind thermal zones to cooling devices.

The third category acts at a scale of several seconds. This types of actions
primarily focused for non CPU components, which takes time to heat up but
once hot will take long time to cool. Like skin temperature or board
temperature. Also there is no one to one relationship. For example skin can be
hot, not only by CPU processing, but GPU, displays, networking, charger and
ambient temperature etc. There are some thermally constraint laptops with 15+
sensors and complex thermal relationship tables tying thermal hotspots to
groups of devices. Also these relationships and threshold changes are context
aware. This is done primary from user space thermal management programs. These
programs primarily relies on the thermal sysfs for getting temperature samples
and to get other notifications of change.

There are several limitations of the thermal subsystem, which makes the user
space management inefficient and complex.
- Temperature needs to be polled from sysfs
There is no way to set thermal thresholds and get notifications. We are getting
around by using the passive trips as threshold and using user space governor to
send uevents. The uevent is used for other non thermal events also. We have
special strings to notify temperature samples.
- We have platforms with 15+ zones, where we need to traverse each directory read
"temp" string and convert to integer to process every second in some cases
- For hotpluggable devices the zones can appear and disappear on fly. We have
to again listen to uevents to find out that.
- Based on the context, firmware updates temperature trips, again combination of
user space governor and uevents are used as workaround.

To be more flexible here /dev/thermal_notify device is created, where user
space can wait for notifications and read events and data. A standard structure
for notifications is defined. Based on the zone, additional thermal sysfs
attributes are added to specify thresholds. More events and attributes can be
added in future based on need. If the kernel config is not defined, there are
are no additional thermal sysfs attributes.

This patchset contains
- A new config for creation of the /dev interface
- Use of the new interface in the core for zone creation, deletion and
temperature samples
- Use of the framework in int340x drivers. More will be added in the next series

This series is based on 4.7-rc1

Srinivas Pandruvada (5):
  thermal: Add support for /dev/thermal_notify
  thermal: Add notification for zone creation and deletion
  thermal: Add support for setting notification thresholds
  thermal: Add support for setting polling interval
  thermal: int340x: Use new device interface

 drivers/thermal/Kconfig                       |   9 +
 drivers/thermal/Makefile                      |   3 +
 .../intel/int340x_thermal/int3403_thermal.c   |   3 +
 .../int340x_thermal/int340x_thermal_zone.c    |  29 +++
 .../int340x_thermal/int340x_thermal_zone.h    |   7 +
 .../processor_thermal_device.c                |   1 +
 drivers/thermal/thermal_core.c                |  11 +
 drivers/thermal/thermal_dev_if.c              | 195 ++++++++++++++++++
 drivers/thermal/thermal_sysfs.c               | 168 ++++++++++++++-
 include/linux/thermal.h                       |  33 +++
 10 files changed, 457 insertions(+), 2 deletions(-)
 create mode 100644 drivers/thermal/thermal_dev_if.c

-- 
2.25.4

