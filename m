Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0B0D13BE6B
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2020 12:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730003AbgAOLah (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jan 2020 06:30:37 -0500
Received: from mail-sh.amlogic.com ([58.32.228.43]:38651 "EHLO
        mail-sh.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729758AbgAOLag (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jan 2020 06:30:36 -0500
Received: from droid13.amlogic.com (116.236.93.172) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.1591.10; Wed, 15 Jan 2020
 19:31:02 +0800
From:   Jianxin Pan <jianxin.pan@amlogic.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        <linux-amlogic@lists.infradead.org>
CC:     Jianxin Pan <jianxin.pan@amlogic.com>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, Jian Hu <jian.hu@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>
Subject: [PATCH v6 0/4] arm64: meson: add support for A1 Power Domains
Date:   Wed, 15 Jan 2020 19:30:27 +0800
Message-ID: <1579087831-94965-1-git-send-email-jianxin.pan@amlogic.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [116.236.93.172]
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patchset introduces a "Secure Power Doamin Controller". In A1/C1, power
controller registers such as PWRCTRL_FOCRSTN, PWRCTRL_PWR_OFF, PWRCTRL_MEM_PD
and PWRCTRL_ISO_EN, are in the secure domain, and should be accessed from ATF
by smc.

The secure-pwrc will not be probed before the secure watchdog patchset is merged 
at [6], which adds of_platform_default_populate() in meson_sm_probe(). 

Changes since v5 at [4]:                                                         
 - Move sec-pwrc to child node of secure-monitor according to Rob's suggestion
   at [5]

Changes since v4 at [3]:                                                         
 - add SM_A1_ prefix for PWRC_SET/GET
 - rename variable and update comments

Changes since v3 at [2]:                                                         
 - remove phandle to secure-monitor node

Changes since v2 at [1]:
- update domain id
- include dt-bindings in dts

Changes since v1 at [0]:
- use APIs from sm driver
- rename pwrc_secure_get_power as Kevin suggested
- add comments for always on domains
- replace arch_initcall_sync with builtin_platform_driver
- fix coding style

[0]  https://lore.kernel.org/linux-amlogic/1568895064-4116-1-git-send-email-jianxin.pan@amlogic.com
[1]  https://lore.kernel.org/linux-amlogic/1570695678-42623-1-git-send-email-jianxin.pan@amlogic.com
[2]  https://lore.kernel.org/linux-amlogic/1571391167-79679-1-git-send-email-jianxin.pan@amlogic.com
[3]  https://lore.kernel.org/linux-amlogic/1572868028-73076-1-git-send-email-jianxin.pan@amlogic.com
[4]  https://lore.kernel.org/linux-amlogic/1573532930-39505-2-git-send-email-jianxin.pan@amlogic.com
[5]  https://lore.kernel.org/linux-amlogic/07f0ed9d-0b1a-d84f-de8b-1967e56bbd21@amlogic.com/
[6]  https://lore.kernel.org/linux-amlogic/1578973527-4759-3-git-send-email-xingyu.chen@amlogic.com

Jianxin Pan (4):
  firmware: meson_sm: Add secure power domain support
  dt-bindings: power: add Amlogic secure power domains bindings
  soc: amlogic: Add support for Secure power domains controller
  arm64: dts: meson: a1: add secure power domain controller

 .../bindings/power/amlogic,meson-sec-pwrc.yaml     |  40 ++++
 arch/arm64/boot/dts/amlogic/meson-a1.dtsi          |   6 +
 drivers/firmware/meson/meson_sm.c                  |   2 +
 drivers/soc/amlogic/Kconfig                        |  13 ++
 drivers/soc/amlogic/Makefile                       |   1 +
 drivers/soc/amlogic/meson-secure-pwrc.c            | 204 +++++++++++++++++++++
 include/dt-bindings/power/meson-a1-power.h         |  32 ++++
 include/linux/firmware/meson/meson_sm.h            |   2 +
 8 files changed, 300 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml
 create mode 100644 drivers/soc/amlogic/meson-secure-pwrc.c
 create mode 100644 include/dt-bindings/power/meson-a1-power.h

-- 
2.7.4

