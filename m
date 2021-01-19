Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6052FC13B
	for <lists+linux-pm@lfdr.de>; Tue, 19 Jan 2021 21:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403848AbhASSvA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Jan 2021 13:51:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392147AbhASSA3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Jan 2021 13:00:29 -0500
Received: from relay08.th.seeweb.it (relay08.th.seeweb.it [IPv6:2001:4b7a:2000:18::169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E66C061381
        for <linux-pm@vger.kernel.org>; Tue, 19 Jan 2021 09:45:31 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (unknown [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 57B5E3F17F;
        Tue, 19 Jan 2021 18:45:30 +0100 (CET)
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
To:     nks@flawful.org
Cc:     bjorn.andersson@linaro.org, agross@kernel.org, robh+dt@kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, konrad.dybcio@somainline.org,
        marijn.suijten@somainline.org, martin.botka@somainline.org,
        jeffrey.l.hugo@gmail.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Subject: [PATCH v4 0/3] CPR commonization in preparation for CPR3 driver
Date:   Tue, 19 Jan 2021 18:45:26 +0100
Message-Id: <20210119174529.227074-1-angelogioacchino.delregno@somainline.org>
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

In preparation for adding a driver for CPR3, CPR4 and CPR4-Hardened,
commonize some functions in the CPR driver, as they will be used by
both drivers, drastically reducing code duplication.

Changes in v4:
- Huge patch series has been split for better reviewability,
  as suggested by Bjorn

Changes in v3:
- Fixed YAML doc issues

Changes in v2:
- Minor Cleanups

Tested on the following smartphones:
- Sony Xperia XA2        (SDM630)
- Sony Xperia XA2 Ultra  (SDM630)
- Sony Xperia 10         (SDM630)
- Sony Xperia XZ Premium (MSM8998)
- F(x)Tec Pro 1          (MSM8998)

AngeloGioacchino Del Regno (3):
  soc: qcom: cpr: Move common functions to new file
  dt-bindings: avs: cpr: Convert binding to YAML schema
  arm64: qcom: qcs404: Change CPR nvmem-names

 .../bindings/power/avs/qcom,cpr.txt           | 131 +-----
 .../bindings/soc/qcom/qcom,cpr.yaml           | 167 +++++++
 MAINTAINERS                                   |   2 +-
 arch/arm64/boot/dts/qcom/qcs404.dtsi          |  26 +-
 drivers/soc/qcom/Makefile                     |   2 +-
 drivers/soc/qcom/cpr-common.c                 | 382 +++++++++++++++
 drivers/soc/qcom/cpr-common.h                 | 113 +++++
 drivers/soc/qcom/cpr.c                        | 441 ++----------------
 8 files changed, 705 insertions(+), 559 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,cpr.yaml
 create mode 100644 drivers/soc/qcom/cpr-common.c
 create mode 100644 drivers/soc/qcom/cpr-common.h

-- 
2.30.0

