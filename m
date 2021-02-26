Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBAC3267AA
	for <lists+linux-pm@lfdr.de>; Fri, 26 Feb 2021 21:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbhBZUFR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Feb 2021 15:05:17 -0500
Received: from m-r1.th.seeweb.it ([5.144.164.170]:59141 "EHLO
        m-r1.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbhBZUFM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Feb 2021 15:05:12 -0500
Received: from localhost.localdomain (abab236.neoplus.adsl.tpnet.pl [83.6.165.236])
        by m-r1.th.seeweb.it (Postfix) with ESMTPA id E30FF1F995;
        Fri, 26 Feb 2021 21:04:25 +0100 (CET)
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
To:     phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 00/41] SDM630/636/660/Nile&Ganges DT feature enablement
Date:   Fri, 26 Feb 2021 21:03:30 +0100
Message-Id: <20210226200414.167762-1-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi!

In this *mammoth* series we finally wire up things that
have been ready for far too long.. We weren't able to
send most of them earlier though, as CLK and ICC review
took quite some time..

Speaking of ICC.. the defines are substituted by numbers,
so as to allow merging independent of icc-next (Georgi Djakov stated
the driver would be pulled in for 5.13).

AngeloGioacchino Del Regno (14):
  arm64: dts: qcom: sdm630: Rewrite memory map
  arm64: dts: qcom: sdm630: Add qfprom subnodes
  arm64: dts: qcom: sdm630: Fix TLMM node and pinctrl configuration
  arm64: dts: qcom: sdm630: Add SDHCI2 node
  arm64: dts: qcom: sdm630: Add interconnect and opp table to sdhc_1
  arm64: dts: qcom: sdm630: Add GPU Clock Controller node
  arm64: dts: qcom: sdm630: Add clocks and power domains to SMMU nodes
  arm64: dts: qcom: sdm630: Add qcom,adreno-smmu compatible
  arm64: dts: qcom: sdm630: Add Adreno 508 GPU configuration
  arm64: dts: qcom: pm660: Support SPMI regulators on PMIC sid 1
  arm64: dts: qcom: pm660l: Support SPMI regulators on PMIC sid 3
  arm64: dts: qcom: sdm630: Configure the camera subsystem
  arm64: dts: qcom: sdm630-xperia-nile: Add all RPM and fixed regulators
  arm64: dts: qcom: sdm630-nile: Configure WCN3990 Bluetooth

Konrad Dybcio (27):
  arm64: dts: qcom: sdm630: Add RPMPD nodes
  arm64: dts: qcom: sdm630: Add MMCC node
  arm64: dts: qcom: sdm630: Add interconnect provider nodes
  arm64: dts: qcom: sdm630: Add MDSS nodes
  arm64: dts: qcom: sdm630: Fix intc reg indentation
  arm64: dts: qcom: sdm630: Add USB configuration
  arm64: dts: qcom: sdm630: Add TSENS node
  arm64: dts: qcom: sdm630: Add modem/ADSP SMP2P nodes
  arm64: dts: qcom: sdm630: Add thermal-zones configuration
  arm64: dts: qcom: sdm630: Add ADSP remoteproc configuration
  arm64: dts: qcom: sdm630: Raise tcsr_mutex_regs size
  arm64: dts: qcom: pm660l: Add WLED support
  arm64: dts: qcom: pm660(l): Add VADC and temp alarm nodes
  arm64: dts: qcom: sdm660: Make the DTS an overlay on top of 630
  arm64: dts: qcom: Add device tree for SDM636
  arm64: dts: qcom: sdm630: Add IMEM node
  arm64: dts: qcom: sdm660: Add required nodes for DSI1
  arm64: dts: qcom: sdm630-nile: Use &labels
  arm64: dts: qcom: sdm630-nile: Add USB
  arm64: dts: qcom: sdm630-nile: Add Volume up key
  arm64: dts: qcom: sdm630-xperia: Retire sdm630-sony-xperia-ganges.dtsi
  arm64: dts: qcom: sdm630-nile: Add Synaptics touchscreen.
  arm64: dts: qcom: sdm630-nile: Specify ADSP firmware name
  arm64: dts: qcom: sdm630-nile: Enable uSD card slot
  arm64: dts: qcom: sdm630-nile: Remove gpio-keys autorepeat
  arm64: dts: qcom: sdm630: Add I2C functions to I2C pins
  arm64: dts: qcom: sdm630: Add DMA to I2C hosts

 .../bindings/thermal/qcom-tsens.yaml          |    1 +
 arch/arm64/boot/dts/qcom/pm660.dtsi           |  133 ++
 arch/arm64/boot/dts/qcom/pm660l.dtsi          |   54 +
 .../qcom/sdm630-sony-xperia-ganges-kirin.dts  |   14 +-
 .../dts/qcom/sdm630-sony-xperia-ganges.dtsi   |   40 -
 .../sdm630-sony-xperia-nile-discovery.dts     |    1 +
 .../qcom/sdm630-sony-xperia-nile-pioneer.dts  |    1 +
 .../qcom/sdm630-sony-xperia-nile-voyager.dts  |    1 +
 .../dts/qcom/sdm630-sony-xperia-nile.dtsi     |  538 +++++-
 arch/arm64/boot/dts/qcom/sdm630.dtsi          | 1446 +++++++++++++++--
 .../sdm636-sony-xperia-ganges-mermaid.dts     |   14 +-
 arch/arm64/boot/dts/qcom/sdm636.dtsi          |   23 +
 .../boot/dts/qcom/sdm660-xiaomi-lavender.dts  |    2 -
 arch/arm64/boot/dts/qcom/sdm660.dtsi          |  519 +++---
 14 files changed, 2292 insertions(+), 495 deletions(-)
 delete mode 100644 arch/arm64/boot/dts/qcom/sdm630-sony-xperia-ganges.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sdm636.dtsi

-- 
2.30.1

