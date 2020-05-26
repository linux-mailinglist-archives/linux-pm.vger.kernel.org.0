Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 266271A7B5C
	for <lists+linux-pm@lfdr.de>; Tue, 14 Apr 2020 14:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502287AbgDNMxd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Apr 2020 08:53:33 -0400
Received: from mail.manjaro.org ([176.9.38.148]:51574 "EHLO mail.manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502282AbgDNMxa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 14 Apr 2020 08:53:30 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.manjaro.org (Postfix) with ESMTP id 04B9D374279E;
        Tue, 14 Apr 2020 14:53:26 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at manjaro.org
Received: from mail.manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VQmChaPkhC0C; Tue, 14 Apr 2020 14:53:21 +0200 (CEST)
From:   Tobias Schramm <t.schramm@manjaro.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tobias Schramm <t.schramm@manjaro.org>
Subject: [RESEND v6 0/3] Add support for CellWise cw2015 fuel gauge
Date:   Tue, 14 Apr 2020 14:52:05 +0200
Message-Id: <20200414125208.1091989-1-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patchset adds support for the CellWise cw2015 fuel gauge.

The CellWise cw2015 fuel gauge is a shuntless, single-cell Li-Ion fuel
gauge. It is used in the pine64 Pinebook Pro laptop.

This is just a resend of v6 to the linux-pm maintainers for merging.

I've kept the cellwise,battery-profile property in the device tree. Its
content describes characteristics of the battery built into a device. The
exact format is unknown and not publicly documented. It is likely
comprised of some key parameters of the battery (chemistry, voltages,
design capacity) and parameters for tuning the internal state of charge
approximation function.
Since v2 CellWise has confirmed to me that the only way to obtain the
profile blob is to mail them batteries for testing. Thus we will need to
keep that property.

In general I'm not 100 % sure about my json-schema binding for the gauge.
It is my first time ever writing a json-schema binding and I'm not sure
whether properties like power-supplies or monitored-battery need to be
added to a separate, common schema for power supplies or not.

Best Regards,

Tobias Schramm

Changelog:
 v2:
  * Change subject to "Add support for CellWise cw2015 fuel gauge"
  * Rewrite bindings as json-schema
  * Use default power-supplies handling
  * Use regmap for register access
  * Use standard simple-battery node
  * Replace printk/pr_* by dev_{dbg,info,warn,err}
  * Use cancel_delayed_work_sync in remove
  * General code cleanup
 v3:
  * Incorporate review by Andy
  * Add cellwise vendor prefix
  * Rename cellwise,bat-config-info property to cellwise,battery-profile
  * Remove most state of charge post-processing
  * Use fwnode interface
  * General code cleanup
  * Lots of code style fixes
 v4:
  * Implement additional changes requested by Andy
  * Use fwnode inline wrappers
  * Clean up waiting for gauge
  * Minor code style fixes
 v5:
  * Clean up includes
  * Handle errors during device property parsing
  * Refactor device property parsing
  * Replace i2c->probe by i2c->probe_new 
  * More code style fixes
 v6:
  * Fix bindings according to review by Rob

Tobias Schramm (3):
  dt-bindings: Document cellwise vendor-prefix
  dt-bindings: power: supply: add cw2015_battery bindings
  power: supply: add CellWise cw2015 fuel gauge driver

 .../bindings/power/supply/cw2015_battery.yaml |  82 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   6 +
 drivers/power/supply/Kconfig                  |  11 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/cw2015_battery.c         | 749 ++++++++++++++++++
 6 files changed, 851 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/cw2015_battery.yaml
 create mode 100644 drivers/power/supply/cw2015_battery.c

-- 
2.26.0

