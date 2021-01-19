Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 447672FC2A9
	for <lists+linux-pm@lfdr.de>; Tue, 19 Jan 2021 22:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389101AbhASVp4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Jan 2021 16:45:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391412AbhASRu6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Jan 2021 12:50:58 -0500
Received: from relay06.th.seeweb.it (relay06.th.seeweb.it [IPv6:2001:4b7a:2000:18::167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39018C06138C
        for <linux-pm@vger.kernel.org>; Tue, 19 Jan 2021 09:46:00 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (unknown [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id A90BE3F1FF;
        Tue, 19 Jan 2021 18:45:58 +0100 (CET)
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
To:     viresh.kumar@linaro.org
Cc:     bjorn.andersson@linaro.org, agross@kernel.org, rjw@rjwysocki.net,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        amit.kucheria@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, jeffrey.l.hugo@gmail.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Subject: [PATCH v4 0/7] cpufreq-qcom-hw: Implement full OSM programming
Date:   Tue, 19 Jan 2021 18:45:50 +0100
Message-Id: <20210119174557.227318-1-angelogioacchino.delregno@somainline.org>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

  **
  ** NOTE: To "view the full picture", please look at the following
  ** patch series:
  ** https://patchwork.kernel.org/project/linux-arm-msm/list/?series=413355
  **              This is a subset of that series.
  **

Changes in v4:
- Huge patch series has been split for better reviewability,
  as suggested by Bjorn
- Rebased code on top of 266991721c15 ("cpufreq: qcom-hw: enable boost
  support")

Changes in v3:
- Fixed a test robot build failure for ARCH=arm
- Fixed dt_binding_check YAML doc issues

Changes in v2:
- Rebased dt-binding on top of Manivannan's patches
- Added MSM8998 to cpufreq-dt-platdev blacklist
- Implemented dynamic Memory Accelerator corners support, needed
  by MSM8998
- Implemented ACD programming, needed by MSM8998

Tested on the following smartphones:
- Sony Xperia XA2        (SDM630)
- Sony Xperia XA2 Ultra  (SDM630)
- Sony Xperia 10         (SDM630)
- Sony Xperia XZ Premium (MSM8998)
- F(x)Tec Pro 1          (MSM8998)

From SDM845 onwards, SAW, CPRh and OSM are getting setup by the
bootloader/TZ *before* booting the OS, so then all the OS has to do
is to request a specific performance state to the OSM hardware and
forget about all the rest, which is anyway protected by the hypervisor
(so there's no access anyway);

BUT:

In MSM/APQ 8998, SDM/SDA 630/636/660 (and other variants), there is no
setup of any of these puzzle pieces, and they're also (basically) fully
accessible, which means that the OS must do it in order to get in the
same state as the newer ones and to get the entire scaling hardware to
start rolling.

AngeloGioacchino Del Regno (5):
  cpufreq: blacklist SDM630/636/660 in cpufreq-dt-platdev
  cpufreq: blacklist MSM8998 in cpufreq-dt-platdev
  cpufreq: qcom-hw: Implement CPRh aware OSM programming
  cpufreq: qcom-hw: Allow getting the maximum transition latency for
    OPPs
  dt-bindings: cpufreq: qcom-hw: Add bindings for 8998

Manivannan Sadhasivam (2):
  dt-bindings: arm: cpus: Document 'qcom,freq-domain' property
  dt-bindings: cpufreq: cpufreq-qcom-hw: Convert to YAML bindings

 .../devicetree/bindings/arm/cpus.yaml         |    6 +
 .../bindings/cpufreq/cpufreq-qcom-hw.txt      |  172 ---
 .../bindings/cpufreq/cpufreq-qcom-hw.yaml     |  242 ++++
 drivers/cpufreq/cpufreq-dt-platdev.c          |    4 +
 drivers/cpufreq/qcom-cpufreq-hw.c             | 1247 ++++++++++++++++-
 5 files changed, 1467 insertions(+), 204 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
 create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml

-- 
2.30.0

