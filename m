Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 124AC139967
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2020 19:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbgAMS47 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jan 2020 13:56:59 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:56589 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbgAMS46 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jan 2020 13:56:58 -0500
Received: from localhost.localdomain ([37.4.249.154]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M5fdC-1il0Lq3iMk-007BNQ; Mon, 13 Jan 2020 19:56:41 +0100
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH V5 0/4] ARM: Enable thermal support for Raspberry Pi 4
Date:   Mon, 13 Jan 2020 19:56:14 +0100
Message-Id: <1578941778-23321-1-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
X-Provags-ID: V03:K1:hv0hsyqJpIwtbxYMr5BT7QCXdH39k5R/zvSb7rg54zqAk2xVZdt
 vqACBCM0IqNpkOOTIylb5dwGyyf5vtgFWk5hM8ifMETYCoaHMiXocVmc/u6L0jVJ3a70GG0
 WqH44JD2oGbMpWrPyeo56FQNAvk9R6ldrtNEgAbXNIhYvYVrW5zf3zsKF+8u/0zL5B8SUTN
 fimf7LOArh48+BUHwVVMw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ipaKVj28PZs=:Wp79E36xfZoin7V0NtPfVO
 2IiRI/BtF4+V5ucyiYw4DA9CWBhL7ysioYVaxZUdIOclJoKL1jURyLG00hk6e4v5knohS2Gve
 oeq+me+cNaIrissmLGCSBfMuFhDGDMUs198CGvXJ1F2lKvNmQe9TQqEScUCIT9Pz3/IO5KD+A
 R7eYfZjuqhyhAk1sZzOShCIND/lGEupAns2GWqJ9e8mmIJCSHow2bUx1CnNYtHAIK2kGgu+OY
 8oJcfeaDaoNrPnJtS3AgNwmj9kGCVN94SUevoX4blg6AuWPytWHcJ4oeKlQI2j6sjBp+CVybF
 hBb4D4mtqXlDh7/SEHwc9bItJLGE2CwsvKcjZWOo5ddoX4GDtipxu0CZ5VSjXP5hPGpwWlIeE
 /InOwbuakmSjFqJpyW4HcC71Lz5y//yeuAhub7PToo9WMIeuKeJzknPI2jBEZLtXqlo1UPGkl
 rQTYBfnaM6E+LV8veCl/OVmW9aiNavKU2gcMWJ9uNghWJiKsrnywMZ5LWb/5BgBs9x73wM/mG
 Gy+5SS4cb7JR2Sg7ojGnF4AjdUAw/nOJAfiJeQFl6/k1iMNrgSWJko+mWiNBYZd0f4wi/wKNo
 LzAoWMGEKRSFeaeVq1ZJQuhzqnyU2MWHDv3Ny51E3JZ8O14GGUFe9xPQCnNym2jOh8mYgT1wm
 xaejTbj6+3zi65viJJ3vcb5ajhdBaYjJpn4flhNU+v7LjMKEYhvzaaE89WKF6QUuV6DK2H8D3
 rWob67I3BOzJX/NyEghuqcqoVeAefLoQ1+9z94AI1XiDHWcOfTj23vLLHQ7crTJaWXkkQbSKT
 wkSPKRHbKHMhXJXICcosys6C/GjTM7cOGtgwzWO0RzPxgzV95pJ1todNZpenkpGt9MerMb07F
 7NvciYDn0MRnn36LWT+A8xDfABGEIsXO9Pj2yWHkA=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This series enables thermal support for the Raspberry Pi 4. Neither the
bcm2835_thermal nor the brcmstb_thermal are suitable for the BCM2711.
So add a new thermal driver to read out the SoC temperature from the
AVS RO block of the BCM2711.

Changes in V5:
- git the rid of device member in private structure
- improve readability of bcm2711_get_temp
- avoid trace message in get_temp callback

Changes in V4:
- change my email address to avoid spurious characters

Changes in V3:
- add Rob's, Florian's and Nicolas' reviewed-by/tested-by
- adjust binding license
- make error pointer handling consistent

Changes in V2:
- rebase on thermal/linux-next
- convert binding to YAML
- make AVS RO block a subnode of AVS monitor and access it via syscon
- drop unnecessary TSENS clock and get the rid of remove callback
- add Florian's reviewed-by to last/unchanged patch

Stefan Wahren (4):
  dt-bindings: Add Broadcom AVS RO thermal
  thermal: Add BCM2711 thermal driver
  ARM: dts: bcm2711: Enable thermal
  ARM: configs: Build BCM2711 thermal as module

 .../bindings/thermal/brcm,avs-ro-thermal.yaml      |  45 ++++++++
 arch/arm/boot/dts/bcm2711.dtsi                     |  12 ++
 arch/arm/configs/multi_v7_defconfig                |   1 +
 arch/arm64/configs/defconfig                       |   1 +
 drivers/thermal/broadcom/Kconfig                   |   7 ++
 drivers/thermal/broadcom/Makefile                  |   1 +
 drivers/thermal/broadcom/bcm2711_thermal.c         | 123 +++++++++++++++++++++
 7 files changed, 190 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/brcm,avs-ro-thermal.yaml
 create mode 100644 drivers/thermal/broadcom/bcm2711_thermal.c

-- 
2.7.4

