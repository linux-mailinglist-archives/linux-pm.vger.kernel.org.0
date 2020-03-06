Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D400317BD83
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2020 14:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgCFND7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Mar 2020 08:03:59 -0500
Received: from mail.baikalelectronics.com ([87.245.175.226]:36126 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbgCFND7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Mar 2020 08:03:59 -0500
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 6ABDD8030703;
        Fri,  6 Mar 2020 13:03:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id EJm72VqUZvCq; Fri,  6 Mar 2020 16:03:51 +0300 (MSK)
From:   <Sergey.Semin@baikalelectronics.ru>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Maxim Kaurkin <Maxim.Kaurkin@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Ekaterina Skachko <Ekaterina.Skachko@baikalelectronics.ru>,
        Vadim Vlasov <V.Vlasov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/4] syscon: Alter syscon and reboot-mode drivers
Date:   Fri, 6 Mar 2020 16:03:37 +0300
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Message-Id: <20200306130356.6ABDD8030703@mail.baikalelectronics.ru>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Serge Semin <fancer.lancer@gmail.com>

A lot of custom functionality can be tuned by means of a syscon-registers
placed in Baikal-T1 CCU memory space (though in documentation they are
called system devices registers). While in most of the case the syscon
registers usage will be distributed between corresponding subsystem drivers
(thanks to pretty much coherent design of the registers fields), there are
some peculiarities we should reflect in the generic syscon code.

First of all seeing there is an map endiannes config acceptable by the syscon
it would be justified to add the corresponding properties declared in the
mfd/syscon.yaml bindings file. Don't really know why this hasn't been done
before.

Then as it's going to be general in the framework of the Baikal-T1 SoC support
integration into the kernel, we suggest to replace the legacy text-based
syscon-reboot-mode dts-bindings file with yaml-based one.

Finally seeing the syscon-reboot-mode devices are mostly used in conjuction
with just syscon-reboot device (in particular Baikal-T1 CCU WDT RCR register is
preserved during any type of reboots) and for several other reasons (see the
commit message for details), we suggest to add the 'regmap' property support
to the syscon-reboot-mode driver. This would eliminate the requirement of
placing the syscon-reboot-mode dts-node in the syscon sub-nodes area.

This patchset is rebased and tested on the mainline Linux kernel 5.6-rc4:
commit 98d54f81e36b ("Linux 5.6-rc4").

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Signed-off-by: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Maxim Kaurkin <Maxim.Kaurkin@baikalelectronics.ru>
Cc: Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>
Cc: Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
Cc: Ekaterina Skachko <Ekaterina.Skachko@baikalelectronics.ru>
Cc: Vadim Vlasov <V.Vlasov@baikalelectronics.ru>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Paul Burton <paulburton@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Serge Semin (4):
  dt-bindings: syscon: Add syscon endian properties support
  dt-bindings: power: reset: Replace SYSCON reboot-mode legacy bindings
    with YAML-based one
  dt-bindings: power: reset: Add regmap support to the SYSCON
    reboot-mode bindings
  power: reset: syscon-reboot-mode: Add regmap dts-property support

 .../devicetree/bindings/mfd/syscon.yaml       | 14 +++++
 .../power/reset/syscon-reboot-mode.txt        | 35 -----------
 .../power/reset/syscon-reboot-mode.yaml       | 58 +++++++++++++++++++
 drivers/power/reset/syscon-reboot-mode.c      | 11 +++-
 4 files changed, 80 insertions(+), 38 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.txt
 create mode 100644 Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.yaml

-- 
2.25.1

