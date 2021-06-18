Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEBA33AD1FD
	for <lists+linux-pm@lfdr.de>; Fri, 18 Jun 2021 20:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236254AbhFRSVL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Jun 2021 14:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235050AbhFRSVK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Jun 2021 14:21:10 -0400
X-Greylist: delayed 582 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 18 Jun 2021 11:19:00 PDT
Received: from relay04.th.seeweb.it (relay04.th.seeweb.it [IPv6:2001:4b7a:2000:18::165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86579C06175F
        for <linux-pm@vger.kernel.org>; Fri, 18 Jun 2021 11:19:00 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (unknown [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 282321F5F9;
        Fri, 18 Jun 2021 20:09:14 +0200 (CEST)
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
To:     bjorn.andersson@linaro.org
Cc:     agross@kernel.org, daniel.lezcano@linaro.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, jeffrey.l.hugo@gmail.com,
        jamipkettunen@somainline.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Subject: [RESEND PATCH v4 0/3] Implement SPM/SAW for MSM8998 and SDM6xx
Date:   Fri, 18 Jun 2021 20:09:04 +0200
Message-Id: <20210618180907.258149-1-angelogioacchino.delregno@somainline.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

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

AngeloGioacchino Del Regno (3):
  cpuidle: qcom_spm: Detach state machine from main SPM handling
  soc: qcom: spm: Implement support for SAWv4.1, SDM630/660 L2 AVS
  soc: qcom: spm: Add compatible for MSM8998 SAWv4.1 L2

 drivers/cpuidle/Kconfig.arm        |   1 +
 drivers/cpuidle/cpuidle-qcom-spm.c | 294 ++++++-----------------------
 drivers/soc/qcom/Kconfig           |   9 +
 drivers/soc/qcom/Makefile          |   1 +
 drivers/soc/qcom/spm.c             | 240 +++++++++++++++++++++++
 include/soc/qcom/spm.h             |  45 +++++
 6 files changed, 354 insertions(+), 236 deletions(-)
 create mode 100644 drivers/soc/qcom/spm.c
 create mode 100644 include/soc/qcom/spm.h

-- 
2.30.0

