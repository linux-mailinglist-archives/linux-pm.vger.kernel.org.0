Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D38B43747F
	for <lists+linux-pm@lfdr.de>; Fri, 22 Oct 2021 11:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbhJVJPz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Oct 2021 05:15:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:46168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232592AbhJVJPp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 22 Oct 2021 05:15:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B942361163;
        Fri, 22 Oct 2021 09:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634894007;
        bh=h+caQfQKl1jk33Diajt4E5+YDiGfQyaniMkR29wCgQo=;
        h=From:To:Cc:Subject:Date:From;
        b=UKlix+4tC+UBHaYlfvn+bhCOwxRxGMUEWcrysquClfiWevKAXkyazobacikEXSFIb
         1vHQlmUtl2hhZjhsPdFqlIdQaKfmY26/HCD1bZr3+QVUq5/E0QmTk1m9FyDgBKtbkE
         QQsPnMCV8ltr3zXkHwQCCIEsnwLjU7NtmdlIAHk3qZeOUtiqgTPUONgUQoHlSxd+5y
         fQTmORvdcItA8QcQE/errEbs2tmSCQerhdYBcihqvlwBaG1yoIsC4lHomX2DQf7YPK
         J0Ncm4qZbK6BVTZgW8R/ZpzxI02C6nK2YudOr+YXHdZsrZE5SVXmQ0wUkGLS7TJwLw
         oCSgazN7JAZ4w==
From:   Georgi Djakov <djakov@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        djakov@kernel.org
Subject: [GIT PULL] interconnect changes for 5.16
Date:   Fri, 22 Oct 2021 12:13:26 +0300
Message-Id: <20211022091326.28826-1-djakov@kernel.org>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello Greg,

This is the pull request with interconnect changes for the 5.16-rc1
merge window. It contains just driver updates. The details are in the
signed tag.

All patches have been in linux-next for more than two weeks. No issues
have been reported so far. Please pull into char-misc-next.

Thanks,
Georgi

The following changes since commit 9e1ff307c779ce1f0f810c7ecce3d95bbae40896:

  Linux 5.15-rc4 (2021-10-03 14:08:47 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-5.16-rc1

for you to fetch changes up to dfe14674bf7b267c44eb91d66bad076af3827a47:

  Merge branch 'icc-rpm' into icc-next (2021-10-04 16:14:13 +0300)

----------------------------------------------------------------
interconnect changes for 5.16

Here are the changes for the 5.16-rc1 merge window consisting of just
driver updates. The highlight is the refactoring of some existing drivers
into common code and expanding some macros that will make adding QoS
support much easier.

Driver changes:
- icc-rpm: move bus clocks handling into qnoc_probe
- sdm660: expand DEFINE_QNODE macros
- sdm660: drop default/unused values
- sdm660: merge common code into icc-rpm
- icc-rpm: add support for QoS reg offset
- msm8916: expand DEFINE_QNODE macros
- msm8916: add support for AP-owned nodes
- msm8939: expand DEFINE_QNODE macros
- msm8939: add support for AP-owned nodes
- qcs404: expand DEFINE_QNODE macros
- qcom: drop DEFINE_QNODE macro
- samsung: describe drivers in KConfig

Signed-off-by: Georgi Djakov <djakov@kernel.org>

----------------------------------------------------------------
Dmitry Baryshkov (11):
      interconnect: icc-rpm: move bus clocks handling into qnoc_probe
      interconnect: sdm660: expand DEFINE_QNODE macros
      interconnect: sdm660: drop default/unused values
      interconnect: sdm660: merge common code into icc-rpm
      interconnect: icc-rpm: add support for QoS reg offset
      interconnect: msm8916: expand DEFINE_QNODE macros
      interconnect: msm8916: add support for AP-owned nodes
      interconnect: msm8939: expand DEFINE_QNODE macros
      interconnect: msm8939: add support for AP-owned nodes
      interconnect: qcs404: expand DEFINE_QNODE macros
      interconnect: qcom: drop DEFINE_QNODE macro

Georgi Djakov (1):
      Merge branch 'icc-rpm' into icc-next

Krzysztof Kozlowski (1):
      interconnect: samsung: describe drivers in KConfig

 drivers/interconnect/qcom/icc-rpm.c  |  263 +-
 drivers/interconnect/qcom/icc-rpm.h  |   56 +-
 drivers/interconnect/qcom/msm8916.c  | 1214 ++++-
 drivers/interconnect/qcom/msm8939.c  | 1283 ++++-
 drivers/interconnect/qcom/qcs404.c   |  967 +++-
 drivers/interconnect/qcom/sdm660.c   | 1940 +++++---
 drivers/interconnect/samsung/Kconfig |    6 +-
 7 files changed, 4819 insertions(+), 910 deletions(-)
The following changes since commit 9e1ff307c779ce1f0f810c7ecce3d95bbae40896:

  Linux 5.15-rc4 (2021-10-03 14:08:47 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-5.16-rc1

for you to fetch changes up to dfe14674bf7b267c44eb91d66bad076af3827a47:

  Merge branch 'icc-rpm' into icc-next (2021-10-04 16:14:13 +0300)

----------------------------------------------------------------
interconnect changes for 5.16

Here are the changes for the 5.16-rc1 merge window consisting of just
driver updates. The highlight is the refactoring of some existing drivers
into common code and expanding some macros that will make adding QoS
support much easier.

Driver changes:
- icc-rpm: move bus clocks handling into qnoc_probe
- sdm660: expand DEFINE_QNODE macros
- sdm660: drop default/unused values
- sdm660: merge common code into icc-rpm
- icc-rpm: add support for QoS reg offset
- msm8916: expand DEFINE_QNODE macros
- msm8916: add support for AP-owned nodes
- msm8939: expand DEFINE_QNODE macros
- msm8939: add support for AP-owned nodes
- qcs404: expand DEFINE_QNODE macros
- qcom: drop DEFINE_QNODE macro
- samsung: describe drivers in KConfig

Signed-off-by: Georgi Djakov <djakov@kernel.org>

----------------------------------------------------------------
Dmitry Baryshkov (11):
      interconnect: icc-rpm: move bus clocks handling into qnoc_probe
      interconnect: sdm660: expand DEFINE_QNODE macros
      interconnect: sdm660: drop default/unused values
      interconnect: sdm660: merge common code into icc-rpm
      interconnect: icc-rpm: add support for QoS reg offset
      interconnect: msm8916: expand DEFINE_QNODE macros
      interconnect: msm8916: add support for AP-owned nodes
      interconnect: msm8939: expand DEFINE_QNODE macros
      interconnect: msm8939: add support for AP-owned nodes
      interconnect: qcs404: expand DEFINE_QNODE macros
      interconnect: qcom: drop DEFINE_QNODE macro

Georgi Djakov (1):
      Merge branch 'icc-rpm' into icc-next

Krzysztof Kozlowski (1):
      interconnect: samsung: describe drivers in KConfig

 drivers/interconnect/qcom/icc-rpm.c  |  263 +-
 drivers/interconnect/qcom/icc-rpm.h  |   56 +-
 drivers/interconnect/qcom/msm8916.c  | 1214 ++++-
 drivers/interconnect/qcom/msm8939.c  | 1283 ++++-
 drivers/interconnect/qcom/qcs404.c   |  967 +++-
 drivers/interconnect/qcom/sdm660.c   | 1940 +++++---
 drivers/interconnect/samsung/Kconfig |    6 +-
 7 files changed, 4819 insertions(+), 910 deletions(-)
The following changes since commit 9e1ff307c779ce1f0f810c7ecce3d95bbae40896:

  Linux 5.15-rc4 (2021-10-03 14:08:47 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-5.16-rc1

for you to fetch changes up to dfe14674bf7b267c44eb91d66bad076af3827a47:

  Merge branch 'icc-rpm' into icc-next (2021-10-04 16:14:13 +0300)

----------------------------------------------------------------
interconnect changes for 5.16

Here are the changes for the 5.16-rc1 merge window consisting of just
driver updates. The highlight is the refactoring of some existing drivers
into common code and expanding some macros that will make adding QoS
support much easier.

Driver changes:
- icc-rpm: move bus clocks handling into qnoc_probe
- sdm660: expand DEFINE_QNODE macros
- sdm660: drop default/unused values
- sdm660: merge common code into icc-rpm
- icc-rpm: add support for QoS reg offset
- msm8916: expand DEFINE_QNODE macros
- msm8916: add support for AP-owned nodes
- msm8939: expand DEFINE_QNODE macros
- msm8939: add support for AP-owned nodes
- qcs404: expand DEFINE_QNODE macros
- qcom: drop DEFINE_QNODE macro
- samsung: describe drivers in KConfig

Signed-off-by: Georgi Djakov <djakov@kernel.org>

----------------------------------------------------------------
Dmitry Baryshkov (11):
      interconnect: icc-rpm: move bus clocks handling into qnoc_probe
      interconnect: sdm660: expand DEFINE_QNODE macros
      interconnect: sdm660: drop default/unused values
      interconnect: sdm660: merge common code into icc-rpm
      interconnect: icc-rpm: add support for QoS reg offset
      interconnect: msm8916: expand DEFINE_QNODE macros
      interconnect: msm8916: add support for AP-owned nodes
      interconnect: msm8939: expand DEFINE_QNODE macros
      interconnect: msm8939: add support for AP-owned nodes
      interconnect: qcs404: expand DEFINE_QNODE macros
      interconnect: qcom: drop DEFINE_QNODE macro

Georgi Djakov (1):
      Merge branch 'icc-rpm' into icc-next

Krzysztof Kozlowski (1):
      interconnect: samsung: describe drivers in KConfig

 drivers/interconnect/qcom/icc-rpm.c  |  263 +-
 drivers/interconnect/qcom/icc-rpm.h  |   56 +-
 drivers/interconnect/qcom/msm8916.c  | 1214 ++++-
 drivers/interconnect/qcom/msm8939.c  | 1283 ++++-
 drivers/interconnect/qcom/qcs404.c   |  967 +++-
 drivers/interconnect/qcom/sdm660.c   | 1940 +++++---
 drivers/interconnect/samsung/Kconfig |    6 +-
 7 files changed, 4819 insertions(+), 910 deletions(-)
