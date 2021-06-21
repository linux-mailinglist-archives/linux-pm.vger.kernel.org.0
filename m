Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8D1F3AF498
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jun 2021 20:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233278AbhFUSP2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Jun 2021 14:15:28 -0400
Received: from relay06.th.seeweb.it ([5.144.164.167]:59615 "EHLO
        relay06.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233948AbhFUSMu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Jun 2021 14:12:50 -0400
Received: from IcarusMOD.eternityproject.eu (unknown [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id B3E303EB9E;
        Mon, 21 Jun 2021 20:10:17 +0200 (CEST)
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
To:     bjorn.andersson@linaro.org
Cc:     agross@kernel.org, daniel.lezcano@linaro.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, jeffrey.l.hugo@gmail.com,
        jami.kettunen@somainline.org,
        ~postmarketos/upstreaming@lists.sr.ht, devicetree@vger.kernel.org,
        robh+dt@kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Subject: [PATCH v6 0/5] Implement SPM/SAW for MSM8998 and SDM6xx
Date:   Mon, 21 Jun 2021 20:10:11 +0200
Message-Id: <20210621181016.365009-1-angelogioacchino.delregno@somainline.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Changes in v6:
- Moved cpuidle_driver to be private to cpuidle-qcom-spm (unused in spm.c),
  now we are assigning the cpuidle_driver structure fields inside of the
  spm_cpuidle_register function; this also fixes the cpumask assignment
  issue from v5
- Fixed another contamination from 2/3 in 1/3 (argh!! :])
- Added dt-bindings documentation for the SPM driver

Changes in v5:
- Fixed contamination from patch 2/3 in patch 1/3
- Fixed missing bits in cpuidle-qcom-spm (thanks Stephan)

Changes in v4:
- Huge patch series has been split for better reviewability,
  as suggested by Bjorn

Changes in v3:
- Rebased (no changes - was in previous series' v3)

Changes in v2:
- Fixed MSM8998 SAW parameters on SPM driver

Tested on the following smartphones:
- Sony Xperia XA2        (SDM630)
- Sony Xperia XA2 Ultra  (SDM630)
- Sony Xperia 10         (SDM630)
- Sony Xperia XZ Premium (MSM8998)
- F(x)Tec Pro 1          (MSM8998)

This is a component that we can find on very old
chips, like MSM8974; there, it has been used to actually do the
power scaling basically "on its own" - sending the cores in a specific
sleep mode to save power.
On the newer ones, including MSM8998, SDM630, 660 and others, it is still
present! Though, this time, it's being used for the cluster caches and it
has a different firmware (and maybe it's also slightly different HW),
implementing the SAWv4.1 set and getting controlled *not by the OS* but
by other controllers in the SoC (like the OSM).

Contrary from MSM8974 and the like, this new version of the SPM just
requires us to set the initial parameters for AVS and *nothing else*, as
its states will be totally managed internally.


AngeloGioacchino Del Regno (5):
  cpuidle: qcom_spm: Detach state machine from main SPM handling
  dt-bindings: soc: qcom: Add devicetree binding for QCOM SPM
  soc: qcom: spm: Implement support for SAWv4.1, SDM630/660 L2 AVS
  soc: qcom: spm: Add compatible for MSM8998 SAWv4.1 L2
  dt-bindings: soc: qcom: spm: Document SDM660 and MSM8998 compatibles

 .../bindings/soc/qcom/qcom,spm.yaml           |  77 +++++
 drivers/cpuidle/Kconfig.arm                   |   1 +
 drivers/cpuidle/cpuidle-qcom-spm.c            | 324 ++++--------------
 drivers/soc/qcom/Kconfig                      |   9 +
 drivers/soc/qcom/Makefile                     |   1 +
 drivers/soc/qcom/spm.c                        | 240 +++++++++++++
 include/soc/qcom/spm.h                        |  43 +++
 7 files changed, 446 insertions(+), 249 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,spm.yaml
 create mode 100644 drivers/soc/qcom/spm.c
 create mode 100644 include/soc/qcom/spm.h

-- 
2.32.0

