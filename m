Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D02F8138248
	for <lists+linux-pm@lfdr.de>; Sat, 11 Jan 2020 17:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730343AbgAKQQQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 11 Jan 2020 11:16:16 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:35909 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730322AbgAKQQQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 11 Jan 2020 11:16:16 -0500
Received: from localhost.localdomain ([37.4.249.154]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N8nrc-1jmtkG2NRW-015tRv; Sat, 11 Jan 2020 17:15:50 +0100
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
Subject: [PATCH V4 0/4] ARM: Enable thermal support for Raspberry Pi 4
Date:   Sat, 11 Jan 2020 17:15:38 +0100
Message-Id: <1578759342-4550-1-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
X-Provags-ID: V03:K1:rYmDnJ/p/2M5yiHMY7ZWxfCjQjh91TWH0PLDwBcOocszvwo4FvW
 /5Zp8iJJ6i8SKmxc7FAQLWOrCNndtm4ltII4dKOa/Lc2hcwNCug7Z5ysI3NzigQwPz9nSkK
 IhIWsHT2k8OuICKKpSD2aFWvZHOL8XGQ2GWfRnrB1ThvqcLcz+1MKNv4EWgaFmvrrs7w9HV
 k1M+ynnUFDunJNdGrCgpg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:7SUTA/eFNfI=:Z28JbYq+DuU6GRmgZR0LOQ
 ZO70M+X4H27vFIM45Cj6FFdVPQEEMrPHPCb9nByN8I9fWgMRINE37LEMrV31RfCRazjt2zevo
 4DuXisXWONXO3/alzWuzrC5q2/+bhZ1fPPLFWYFyGhfH4APGy6w+Kb+qh7prTDEuBOMp6aACN
 cRTVo7ysP5wmuGD01ggtubUYMi/CCPsOqKygjl0FFOw2Yze2/m2g7n5mAR5qhly/935ysbU56
 Fz7TEFMxnau+MgWFETs+ga+L3+qGLox+8q2XE445mCZMuo023SIwcecz6Qx+i0BCdF2IApvjN
 ZqGxlF1Tau7OjAshAdmCVeps2hAVBLHZ6/jCnAmj2TbttM6UZ0sIbvICOrKWQMpYkxGgbPj/s
 rPPz1EmaSsvFtCOCEmaaV3Up27AGb1HWaEGRMkOUNqbukwmFnUPlEI70nlW1eNRuzw3hJ7D09
 VnLm9d6D5JMd8RXXyguFf0ZEkuLlWTp0ZDG5e/u+/V8SSxC2PMioA1ZNG3YXTpmdziF5loD9v
 OmLzudHLDR5RbDmImBRBfPlotE0Fv0eneXeje1Ky+i8qsQoXDKd7l9X5d1p6H7JBOFfM1A9Zj
 QHs4IyuwTSXmTwv/IADR8JVS4sqftU792FvEr61GWDU+l7boA4U6Fa1DU7+16TGn4mjWYReLX
 3S3zgzaF3y6RP+sYkJcXJ+ACcr0udFC8SIOegxMRc2iSOS6tSMdNRmCQsJvsrAneW/BWc6tW7
 NxIiQ3Vtd/2Kj4AzwHU3X2Y0xHOQdm1esznXEFjI+VbgGrXQUtf44+BFNcpMh3XUeAU6X8BgA
 MGDVlDFhlFqymcq7IhlWFTbMrIrWzlQfjJWt06XX9ZCqJh1ynEjcbHnjef7CDhIns7NdQxx9w
 kFTxt4HunVn04QHpo4Hhgg9DDiRJ7OPJvoVPsQigE=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This series enables thermal support for the Raspberry Pi 4. Neither the
bcm2835_thermal nor the brcmstb_thermal are suitable for the BCM2711.
So add a new thermal driver to read out the SoC temperature from the
AVS RO block of the BCM2711.

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

 .../bindings/thermal/brcm,avs-ro-thermal.yaml      |  45 +++++++
 arch/arm/boot/dts/bcm2711.dtsi                     |  12 ++
 arch/arm/configs/multi_v7_defconfig                |   1 +
 arch/arm64/configs/defconfig                       |   1 +
 drivers/thermal/broadcom/Kconfig                   |   7 ++
 drivers/thermal/broadcom/Makefile                  |   1 +
 drivers/thermal/broadcom/bcm2711_thermal.c         | 129 +++++++++++++++++++++
 7 files changed, 196 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/brcm,avs-ro-thermal.yaml
 create mode 100644 drivers/thermal/broadcom/bcm2711_thermal.c

-- 
2.7.4

