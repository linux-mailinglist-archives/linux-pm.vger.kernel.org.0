Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA1A1C9F2D
	for <lists+linux-pm@lfdr.de>; Fri,  8 May 2020 01:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgEGXi4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 May 2020 19:38:56 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:39356 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgEGXi4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 May 2020 19:38:56 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 86648803087C;
        Thu,  7 May 2020 23:38:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HxFt07LMQQVN; Fri,  8 May 2020 02:38:50 +0300 (MSK)
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Sebastian Reichel <sre@kernel.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Maxim Kaurkin <Maxim.Kaurkin@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Ekaterina Skachko <Ekaterina.Skachko@baikalelectronics.ru>,
        Vadim Vlasov <V.Vlasov@baikalelectronics.ru>,
        Alexey Kolotnikov <Alexey.Kolotnikov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Allison Randal <allison@lohutok.net>,
        Richard Fontana <rfontana@redhat.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>, <linux-mips@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/3] syscon: Alter syscon and reboot drivers
Date:   Fri, 8 May 2020 02:38:43 +0300
Message-ID: <20200507233846.11548-1-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200306130356.6ABDD8030703@mail.baikalelectronics.ru>
References: <20200306130356.6ABDD8030703@mail.baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This is a small patchset about tuning the syscon infrastructure a bit.
As it's going to be general in the framework of the Baikal-T1 SoC support
integration into the kernel, we suggest to replace the legacy text-based
syscon-reboot-mode dts-bindings file with yaml-based one. Then seeing a
syscon reboot block is normally expected to be a part of a system
controller and based on the discussion
https://lore.kernel.org/linux-pm/20200306130402.1F4F0803079F@mail.baikalelectronics.ru/
we decided to alter the syscon reboot driver so one would also try to fetch
the syscon registers map from a parental DT node. regmap property is left
supported although it's marked as deprecated from now.

This patchset is rebased and tested on the mainline Linux kernel 5.7-rc4:
0e698dfa2822 ("Linux 5.7-rc4")
tag: v5.7-rc4

Changelog v2:
- Add Sebastian' Acked-by tag to patch 1.
- Use a shorter summary describing the bindings modification patches.
- Our corporate email server doesn't change Message-Id anymore, so the patchset
  is resubmitted being in the cover-letter-threaded format.
- Discard patch with syscon "-endian" property support. As Rob said It shall be
  in the common dt-schema.
- Replace patches of adding a regmap property support to the syscon-reboot-mode
  with patches making syscon-reboot a sub-node of a system controller node.
- Mark regmap property as deprecated from now.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Maxim Kaurkin <Maxim.Kaurkin@baikalelectronics.ru>
Cc: Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>
Cc: Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
Cc: Ekaterina Skachko <Ekaterina.Skachko@baikalelectronics.ru>
Cc: Vadim Vlasov <V.Vlasov@baikalelectronics.ru>
Cc: Alexey Kolotnikov <Alexey.Kolotnikov@baikalelectronics.ru>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Paul Burton <paulburton@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Allison Randal <allison@lohutok.net>
Cc: Richard Fontana <rfontana@redhat.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: linux-mips@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Serge Semin (3):
  dt-bindings: power: reset: Convert syscon-reboot-mode to DT schema
  dt-bindings: power: reset: Unrequire regmap property in syscon-reboot
    node
  power: reset: syscon-reboot: Add parental syscon support

 .../power/reset/syscon-reboot-mode.txt        | 35 ------------
 .../power/reset/syscon-reboot-mode.yaml       | 55 +++++++++++++++++++
 .../bindings/power/reset/syscon-reboot.yaml   | 15 +++--
 drivers/power/reset/syscon-reboot.c           |  7 ++-
 4 files changed, 70 insertions(+), 42 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.txt
 create mode 100644 Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.yaml

-- 
2.25.1

