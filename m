Return-Path: <linux-pm+bounces-23701-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F028A583EC
	for <lists+linux-pm@lfdr.de>; Sun,  9 Mar 2025 13:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 786993AE75E
	for <lists+linux-pm@lfdr.de>; Sun,  9 Mar 2025 12:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354771C7B62;
	Sun,  9 Mar 2025 12:13:44 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9472B9A4;
	Sun,  9 Mar 2025 12:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741522424; cv=none; b=hXv0rCgO31Jy/warrl+4rGpDM+EBWClPFaDUQGA6fdnfAvrmIkAA5U3IfqsQVmAJ+lMvQQrs5CPsLu72Eqs2svPZJZ5qLH0H/uR7A79zio/G6+lSoICHdOqYgJWLlvaNU5nZJYeODSmj2g61OcJbSQCApq4EwZFDnnNwj0DDGeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741522424; c=relaxed/simple;
	bh=4DvY72QASYhj2s94IScZ3Src59yyJG6l+LyXmGolDKc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nj7IdHdbmW4MDbrbyxabTn4PumO2dy2iGPF5AxNBe+DzMKty2yYGTZV7A8v4LJ8KxIZKnuaAvM8KzxwIzAy4fHfpMf/Te8ZUBLSoz99NZWA676GwDw5CQ1pjp1VePog1Z+hDxTKVvfPRH5SfUotRUA7xXw8QsOmdFjMK4RKD0bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: 77slmj2eSVSKH9WzPWISrw==
X-CSE-MsgGUID: /J4vV1yiRyuPkCfltFFj2A==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 09 Mar 2025 21:13:33 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.92.42])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 78B63422041D;
	Sun,  9 Mar 2025 21:13:27 +0900 (JST)
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: geert+renesas@glider.be,
	niklas.soderlund+renesas@ragnatech.se,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	rafael@kernel.org,
	daniel.lezcano@linaro.org
Cc: magnus.damm@gmail.com,
	claudiu.beznea.uj@bp.renesas.com,
	devicetree@vger.kernel.org,
	john.madieu@gmail.com,
	rui.zhang@intel.com,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	biju.das.jz@bp.renesas.com,
	linux-pm@vger.kernel.org,
	John Madieu <john.madieu.xa@bp.renesas.com>
Subject: [RFC PATCH 0/3] thermal: Add CPU hotplug cooling driver
Date: Sun,  9 Mar 2025 13:13:20 +0100
Message-ID: <20250309121324.29633-1-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch series introduces a new thermal cooling driver that implements CPU
hotplug-based thermal management. The driver dynamically takes CPUs offline
during thermal excursions to reduce power consumption and prevent overheating,
while maintaining system stability by keeping at least one CPU online. 

1- Problem Statement

Modern SoCs require robust thermal management to prevent overheating under heavy
workloads. Existing cooling mechanisms like frequency scaling may not always
provide sufficient thermal relief, especially in multi-core systems where
per-core thermal contributions can be significant. 

2- Solution Overview 

The driver:

 - Integrates with the Linux thermal framework as a cooling device  
 - Registers per-CPU cooling devices that respond to thermal trip points  
 - Uses CPU hotplug operations to reduce thermal load  
 - Maintains system stability by preserving the boot CPU from being put offline,
 regardless the CPUs that are specified in cooling device list. 
 - Implements proper state tracking and cleanup

Key Features:   

 - Dynamic CPU online/offline management based on thermal thresholds  
 - Device tree-based configuration via thermal zones and trip points  
 - Hysteresis support through thermal governor interactions  
 - Safe handling of CPU state transitions during module load/unload  
 - Compatibility with existing thermal management frameworks

Testing    

 - Verified on Renesas RZ/G3E platforms with multi-core CPU configurations  
 - Validated thermal response using artificial load generation (emul_temp)  
 - Confirmed proper interaction with other cooling devices
 - Verified support for 'plug' type trace events
 - Tested with step_wise governor

As the 'hot' type is already used for user space notification, I've choosen
'plug' for this new type. suggestions on this are welcome. Here is an example
of 'thermal-zone' that integrate 'plug' type:

```
thermal-zones {
	cpu-thermal {
		polling-delay = <1000>;
		polling-delay-passive = <250>;
		thermal-sensors = <&tsu>;

		cooling-maps {
			map0 {
				trip = <&target>;
				cooling-device = <&cpu0 0 3>, <&cpu3 0 3>;
				contribution = <1024>;
			};

			map1 {
				trip = <&trip_emergency>;
				cooling-device = <&cpu1 0 1>, <&cpu2 0 1>;
				contribution = <1024>;
			};

		};

		trips {
			target: trip-point {
				temperature = <95000>;
				hysteresis = <1000>;
				type = "passive";
			};

			trip_emergency: emergency {
				temperature = <110000>;
				hysteresis = <1000>;
				type = "plug";
			};

			sensor_crit: sensor-crit {
				temperature = <120000>;
				hysteresis = <1000>;
				type = "critical";
			};
		};
	};
};
```

Dependencies    

 - Requires standard thermal framework components (CONFIG_THERMAL)  
 - Depends on CPU hotplug support (CONFIG_HOTPLUG_CPU)  
 - Assumes device tree contains appropriate thermal zone definitions

This series also depends upon [1], more precisely on patch 6/7, 
arm64: dts: renesas: r9a09g047: Add TSU node.


3) Notes for Reviewers    

 - Focus areas: Thermal framework integration, CPU state management, and error handling  
 - Feedback on device tree binding requirements is particularly welcome  
 - Suggestions for interaction improvements with other governors are appreciated

I look forward to your feedback and guidance on this contribution.

[1] https://patchwork.kernel.org/project/linux-clk/cover/20250227122453.30480-1-john.madieu.xa@bp.renesas.com/

Regards,
John


John Madieu (3):
  thermal/cpuplog_cooling: Add CPU hotplug cooling driver
  tmon: Add support for THERMAL_TRIP_PLUG type
  arm64: dts: renesas: r9a09g047: Add thermal hotplug trip point

 arch/arm64/boot/dts/renesas/r9a09g047.dtsi |  13 +
 drivers/thermal/Kconfig                    |  12 +
 drivers/thermal/Makefile                   |   1 +
 drivers/thermal/cpuplug_cooling.c          | 363 +++++++++++++++++++++
 drivers/thermal/thermal_of.c               |   1 +
 drivers/thermal/thermal_trace.h            |   2 +
 drivers/thermal/thermal_trip.c             |   1 +
 include/uapi/linux/thermal.h               |   1 +
 tools/thermal/tmon/tmon.h                  |   1 +
 tools/thermal/tmon/tui.c                   |   3 +-
 10 files changed, 397 insertions(+), 1 deletion(-)
 create mode 100644 drivers/thermal/cpuplug_cooling.c

-- 
2.25.1


