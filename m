Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E457B17E4BA
	for <lists+linux-pm@lfdr.de>; Mon,  9 Mar 2020 17:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgCIQZF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Mar 2020 12:25:05 -0400
Received: from mail.manjaro.org ([176.9.38.148]:44346 "EHLO mail.manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727146AbgCIQZF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 9 Mar 2020 12:25:05 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.manjaro.org (Postfix) with ESMTP id 30EC03702399;
        Mon,  9 Mar 2020 17:04:21 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at manjaro.org
Received: from mail.manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id n1f4Bhx4d8nd; Mon,  9 Mar 2020 17:04:18 +0100 (CET)
From:   Tobias Schramm <t.schramm@manjaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tobias Schramm <t.schramm@manjaro.org>
Subject: [PATCH v2 0/2] Add support for CellWise cw2015 fuel gauge
Date:   Mon,  9 Mar 2020 17:03:44 +0100
Message-Id: <20200309160346.2203680-1-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patchset adds support for the CellWise cw2015 fuel gauge.

The CellWise cw2015 fuel gauge is a shuntless, single-cell Li-Ion fuel
gauge. It is used in the pine64 Pinebook Pro laptop.

This is v2 of a patchset I sent in late 2019. Took me some time to get
around to prepare a v2 but here it is.

I've kept the cellwise,bat-config-info property in the device tree. Its
content describes characteristics of the battery built into a device. The
exact format is unknown and not publicly documented. It is likely composed
of some key parameters of the battery (chemistry, voltages,
design capacity) and parameters for tuning the internal state of charge
approximation function.

In general I'm not 100 % sure about my json-schema binding for the gauge.
It is my first time ever writing a json-schema binding and I'm not sure
whether properties like power-supplies or monitored-battery need to be
added to a separate, common schema for power supplies or not.


Best regards,

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

Tobias Schramm (2):
  dt-bindings: power: supply: cw2015_battery: add device tree binding
    documentation
  power: supply: add CellWise cw2015 fuel gauge driver

 .../bindings/power/supply/cw2015_battery.yaml |  84 ++
 MAINTAINERS                                   |   6 +
 drivers/power/supply/Kconfig                  |   6 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/cw2015_battery.c         | 891 ++++++++++++++++++
 5 files changed, 988 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/cw2015_battery.yaml
 create mode 100644 drivers/power/supply/cw2015_battery.c

-- 
2.24.1

