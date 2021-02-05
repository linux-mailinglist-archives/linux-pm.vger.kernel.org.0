Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2504431087A
	for <lists+linux-pm@lfdr.de>; Fri,  5 Feb 2021 10:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbhBEJzk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Feb 2021 04:55:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:49142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229716AbhBEJxc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 5 Feb 2021 04:53:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 058B464FB5;
        Fri,  5 Feb 2021 09:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612518771;
        bh=/q6BVsPPmAhr9cWK+oriRq5M7Ln0EA8bMP6q3ukfmTc=;
        h=From:To:Cc:Subject:Date:From;
        b=fYrDOLE+0J1WLyamo+ka8BrlBdiI46cDMz2iYI7LbKd8YmdpCwQ0NI5Wuq8Ja2Qjh
         WUne0hKJHAfcLdmu90HStCYUqGzih63JP5UIGHGqIC4wWICSMv4vM91NLVSMTO8ixg
         hfr2EjTYcnUP+YCd+FVOEZZAXzG8PcMiMXNxTAkQ3uVEF/QTyqS9QrtuvfdKgFRcSp
         mG63Z1TRG+wBfEvbbNWRre/cYBxyuh1Kfce2J6G0oY6RSQBPxo5agf/+hIbqLgxRiI
         kHTStWipWmWtAZJNUiWah2rJgknJPgtmhtL4WqaDqMFIs5h+oY9ywjQW7B77sdumWk
         f/KHpffK7aFuA==
From:   Georgi Djakov <djakov@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        georgi.djakov@linaro.org, Georgi Djakov <djakov@kernel.org>
Subject: [GIT PULL] interconnect changes for 5.12
Date:   Fri,  5 Feb 2021 11:52:46 +0200
Message-Id: <20210205095246.24577-1-djakov@kernel.org>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello Greg,

This is the pull request with the interconnect changes for the 5.12-rc1
merge window. These include two new drivers some driver consolidation.

Patches have been in linux-next without any reported issues. Please pull
into char-misc-next.

Thanks,
Georgi

The following changes since commit 7c53f6b671f4aba70ff15e1b05148b10d58c2837:

  Linux 5.11-rc3 (2021-01-10 14:34:50 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-5.12-rc1

for you to fetch changes up to 6715ea06ced45c8910c878877722ccf502301499:

  Merge branch 'icc-sdx55' into icc-next (2021-02-01 14:26:57 +0200)

----------------------------------------------------------------
interconnect changes for 5.12

Here are the interconnect changes for the 5.12-rc1 merge window
consisting of driver updates.

Driver changes:
- Refactoring and consolidation of drivers.
- New driver for MSM8939 platforms.
- New driver for SDX55 platforms.

Signed-off-by: Georgi Djakov <djakov@kernel.org>

----------------------------------------------------------------
Georgi Djakov (2):
      Merge branch 'icc-msm8939' into icc-next
      Merge branch 'icc-sdx55' into icc-next

Jun Nie (5):
      interconnect: qcom: Consolidate interconnect RPM support
      interconnect: qcom: qcs404: use shared code
      dt-bindings: interconnect: single yaml file for RPM interconnect drivers
      dt-bindings: interconnect: Add Qualcomm MSM8939 DT bindings
      interconnect: qcom: Add MSM8939 interconnect provider driver

Manivannan Sadhasivam (2):
      dt-bindings: interconnect: Add Qualcomm SDX55 DT bindings
      interconnect: qcom: Add SDX55 interconnect provider driver

 Documentation/devicetree/bindings/interconnect/qcom,qcs404.yaml |  77 --
 .../bindings/interconnect/{qcom,msm8916.yaml => qcom,rpm.yaml}  |  22 +-
 Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml   |   4 +
 drivers/interconnect/qcom/Kconfig                               |  18 +
 drivers/interconnect/qcom/Makefile                              |   6 +-
 drivers/interconnect/qcom/icc-rpm.c                             | 191 ++++
 drivers/interconnect/qcom/icc-rpm.h                             |  73 ++
 drivers/interconnect/qcom/msm8916.c                             | 241 +----
 drivers/interconnect/qcom/msm8939.c                             | 355 +++++++
 drivers/interconnect/qcom/qcs404.c                              | 242 +----
 drivers/interconnect/qcom/sdx55.c                               | 356 ++++++++
 drivers/interconnect/qcom/sdx55.h                               |  70 ++
 include/dt-bindings/interconnect/qcom,msm8939.h                 | 105 +++
 include/dt-bindings/interconnect/qcom,sdx55.h                   |  76 ++
 14 files changed, 1286 insertions(+), 550 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/interconnect/qcom,qcs404.yaml
 rename Documentation/devicetree/bindings/interconnect/{qcom,msm8916.yaml => qcom,rpm.yaml} (77%)
 create mode 100644 drivers/interconnect/qcom/icc-rpm.c
 create mode 100644 drivers/interconnect/qcom/icc-rpm.h
 create mode 100644 drivers/interconnect/qcom/msm8939.c
 create mode 100644 drivers/interconnect/qcom/sdx55.c
 create mode 100644 drivers/interconnect/qcom/sdx55.h
 create mode 100644 include/dt-bindings/interconnect/qcom,msm8939.h
 create mode 100644 include/dt-bindings/interconnect/qcom,sdx55.h
