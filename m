Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CFA93603EC
	for <lists+linux-pm@lfdr.de>; Thu, 15 Apr 2021 10:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbhDOIKN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 15 Apr 2021 04:10:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:55420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231143AbhDOIKM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 15 Apr 2021 04:10:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F3D7D61158;
        Thu, 15 Apr 2021 08:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618474190;
        bh=437iNytFiVAZCufObGd8LNYwkwhJtKlWYmMmdO67tOk=;
        h=From:To:Cc:Subject:Date:From;
        b=BFmDMOPseKxr4oPbSPTx/qkc21GocG5z0CNwjMHzvLpMqklOGLR+ZQESWW+FLXIM7
         ghLssycFh4dLoiXIo0ybqEc+U3imsvmsJaOrga5kGECXm83OjaJc0C2zsYNFocXIaR
         oFdZieDGpJDk/PND1NbzAMe8hkgh9tpRDCEWm3dUbzTmFnbAtLF4iadzeY73kP2+rm
         chAu5vjuYJoQ15rKpV61nuCKKFqZTpSzzN+jXzU8B8ssauMEcOFBM/DbSuFwJZTahU
         PYYCwjCEkX2d1bM7oW8zZ0OV+3YFseSUPp0gE7gkTABDNicaDvHLBGG5CbPLtW3llX
         1YRLeq/YBprVA==
From:   Georgi Djakov <djakov@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        georgi.djakov@linaro.org, Georgi Djakov <djakov@kernel.org>
Subject: [GIT PULL] interconnect changes for 5.13
Date:   Thu, 15 Apr 2021 11:09:48 +0300
Message-Id: <20210415080948.17167-1-djakov@kernel.org>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello Greg,

This is the pull request with the interconnect changes for the 5.13-rc1
merge window. These include two new drivers.

Patches have been in linux-next without any reported issues. Please pull
into char-misc-next.

Thanks,
Georgi

The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-5.13-rc1

for you to fetch changes up to c1de07884f2bafa11ad3780cf08b234c88c2cc9d:

  Merge branch 'icc-sm8350' into icc-next (2021-04-02 13:12:37 +0300)

----------------------------------------------------------------
interconnect changes for 5.13

These are the interconnect changes for the 5.13-rc1 merge window
with the highlights being drivers for two new platforms.

Driver changes:
- New driver for SM8350 platforms.
- New driver for SDM660 platforms.

Signed-off-by: Georgi Djakov <djakov@kernel.org>

----------------------------------------------------------------
AngeloGioacchino Del Regno (2):
      dt-bindings: interconnect: Add bindings for Qualcomm SDM660 NoC
      interconnect: qcom: Add SDM660 interconnect provider driver

Benjamin Li (1):
      interconnect: qcom: icc-rpm: record slave RPM id in error log

Georgi Djakov (5):
      interconnect: qcom: sdm660: Fix kerneldoc warning
      interconnect: qcom: sm8350: Use the correct ids
      interconnect: qcom: sm8350: Add missing link between nodes
      Merge branch 'icc-sdm660' into icc-next
      Merge branch 'icc-sm8350' into icc-next

Vinod Koul (3):
      dt-bindings: interconnect: Add Qualcomm SM8350 DT bindings
      interconnect: qcom: Add SM8350 interconnect provider driver
      MAINTAINERS: icc: add interconnect tree

 Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml   |  10 +
 Documentation/devicetree/bindings/interconnect/qcom,sdm660.yaml | 147 ++
 MAINTAINERS                                                     |   1 +
 drivers/interconnect/qcom/Kconfig                               |  18 +
 drivers/interconnect/qcom/Makefile                              |   4 +
 drivers/interconnect/qcom/icc-rpm.c                             |   4 +-
 drivers/interconnect/qcom/sdm660.c                              | 923 ++++++++
 drivers/interconnect/qcom/sm8350.c                              | 633 +++++
 drivers/interconnect/qcom/sm8350.h                              | 168 ++
 include/dt-bindings/interconnect/qcom,sdm660.h                  | 116 +
 include/dt-bindings/interconnect/qcom,sm8350.h                  | 172 ++
 11 files changed, 2194 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sdm660.yaml
 create mode 100644 drivers/interconnect/qcom/sdm660.c
 create mode 100644 drivers/interconnect/qcom/sm8350.c
 create mode 100644 drivers/interconnect/qcom/sm8350.h
 create mode 100644 include/dt-bindings/interconnect/qcom,sdm660.h
 create mode 100644 include/dt-bindings/interconnect/qcom,sm8350.h
