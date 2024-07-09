Return-Path: <linux-pm+bounces-10858-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0417892B75C
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 13:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 821C81F21A45
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 11:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B93B158DD2;
	Tue,  9 Jul 2024 11:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kkozKfJV"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347AE158DCD;
	Tue,  9 Jul 2024 11:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720524132; cv=none; b=L95IkQaBUwTBlJuB8NkRJng5eaBS9USboZn58HLzpWJ7sCw5+7o8iN38pnj3WcVKwIZb/qtnzw+Ii7rxhJjVb6IT5FRCCleUN+Zb0ydiUCZ+Pe29tw+5hQ2Yzo1IB6PZfFSIHLwyw9QFrQAT6OlEabpMpOQtBRt9EG7jBMz+jMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720524132; c=relaxed/simple;
	bh=0bIQwvttVlhEBLtbAG0LnxAJT60Athlg39gMLKlKBKc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mtcsDs7JK2L7mJKF5fvXNZmSsT74v2QGW1K79SACV/n3IMT9iUuB7yUtXCYFi+9CYSonVkjHfYJg5xv/yD0xL6SPeXTtPTluWn5wRpxMq47PyzeuS8ucZvOchGftJlzZSjnr3t1Lkibu69GOMZ1yMC6OUC/KiWcVugesDlTrws8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kkozKfJV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9B83C3277B;
	Tue,  9 Jul 2024 11:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720524132;
	bh=0bIQwvttVlhEBLtbAG0LnxAJT60Athlg39gMLKlKBKc=;
	h=From:To:Cc:Subject:Date:From;
	b=kkozKfJVAE1H97lBT62JnvFUrcHE1xcKecw/I3BmYVHdJIQcY7Nu4VCo20EfBmMR1
	 4CrYDJofcHws6wS1jplT3QwyZ6QvpOJ9l4t4ZvpJKKDY8eDTArw94calAhV2943r+W
	 1x7OowB3UUc+mq+i7ZaZpSB3EQ7RDdhO+fLRtkYF62+AzLyF78lSfzZIg+OIO149tf
	 prp/aguWyAXb2mJE309ZR1gxVk2CLmhPdSPwCrVpj1lZMyq+XqgpMW8zrrJgjPzebL
	 vONB9i3Hdrj/BzgSCnB+L4GEND+p4VxBvgj3vyFRFL2AvhATvc6z6gHPf85/JR1W27
	 XOMBech8LZV2A==
From: Georgi Djakov <djakov@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	djakov@kernel.org
Subject: [GIT PULL] interconnect changes for 6.11
Date: Tue,  9 Jul 2024 14:21:34 +0300
Message-Id: <20240709112134.782462-1-djakov@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Greg,

This is the pull request with interconnect changes for the v6.11-rc1 merge
window. It contains some new drivers and bugfixes. As always, the summary
is in the signed tag.

The patches have been in linux-next for a while. There are no reported issues
currently. Please pull into char-misc-next when possible.

Thanks,
Georgi

The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-6.11-rc1

for you to fetch changes up to 226e58b20975000960cb40b7488f55f173007489:

  Merge branch 'icc-rpmh-qos' into icc-next (2024-07-04 22:45:20 +0300)

----------------------------------------------------------------
interconnect changes for 6.11

This pull request contains the interconnect changes for the 6.11-rc1 merge
window. It contains just driver changes with the following highlights:

Driver changes:
- New driver for MediaTek MT8183/8195 platforms
- New driver for MSM8953 platforms
- New QoS support for RPMh-based platforms with SC7280 being the
  first one to benefit from it.
- Fix incorrect master-id value in qcm2290 driver
- Add missing MODULE_DESCRIPTION in a few drivers

Signed-off-by: Georgi Djakov <djakov@kernel.org>

----------------------------------------------------------------
AngeloGioacchino Del Regno (2):
      dt-bindings: interconnect: Add MediaTek EMI Interconnect bindings
      interconnect: mediatek: Add MediaTek MT8183/8195 EMI Interconnect driver

Georgi Djakov (4):
      Merge branch 'icc-mtk' into icc-next
      Merge branch 'icc-fixes' into icc-next
      Merge branch 'icc-msm8953' into icc-next
      Merge branch 'icc-rpmh-qos' into icc-next

Jeff Johnson (2):
      interconnect: imx: add missing MODULE_DESCRIPTION() macros
      interconnect: qcom: add missing MODULE_DESCRIPTION() macros

Jiapeng Chong (1):
      interconnect: mediatek: remove unneeded semicolon

Konrad Dybcio (1):
      interconnect: qcom: qcm2290: Fix mas_snoc_bimc RPM master ID

Odelu Kukatla (4):
      dt-bindings: interconnect: add clock property to enable QOS on SC7280
      interconnect: qcom: icc-rpmh: Add QoS configuration support
      interconnect: qcom: sc7280: enable QoS configuration
      interconnect: qcom: Fix DT backwards compatibility for QoS

Vladimir Lypak (2):
      dt-bindings: interconnect: qcom: Add Qualcomm MSM8953 NoC
      interconnect: qcom: Add MSM8953 driver

 .../devicetree/bindings/interconnect/mediatek,mt8183-emi.yaml  |   51 +
 .../devicetree/bindings/interconnect/qcom,msm8953.yaml         |  101 +
 .../devicetree/bindings/interconnect/qcom,sc7280-rpmh.yaml     |   53 +
 drivers/interconnect/Kconfig                                   |    1 +
 drivers/interconnect/Makefile                                  |    1 +
 drivers/interconnect/imx/imx.c                                 |    1 +
 drivers/interconnect/imx/imx8mm.c                              |    1 +
 drivers/interconnect/imx/imx8mn.c                              |    1 +
 drivers/interconnect/imx/imx8mp.c                              |    1 +
 drivers/interconnect/imx/imx8mq.c                              |    1 +
 drivers/interconnect/mediatek/Kconfig                          |   29 +
 drivers/interconnect/mediatek/Makefile                         |    5 +
 drivers/interconnect/mediatek/icc-emi.c                        |  153 +
 drivers/interconnect/mediatek/icc-emi.h                        |   40 +
 drivers/interconnect/mediatek/mt8183.c                         |  143 +
 drivers/interconnect/mediatek/mt8195.c                         |  339 ++
 drivers/interconnect/qcom/Kconfig                              |    9 +
 drivers/interconnect/qcom/Makefile                             |    2 +
 drivers/interconnect/qcom/icc-common.c                         |    1 +
 drivers/interconnect/qcom/icc-rpmh.c                           |   94 +
 drivers/interconnect/qcom/icc-rpmh.h                           |   36 +
 drivers/interconnect/qcom/msm8953.c                            | 1321 ++++++++
 drivers/interconnect/qcom/qcm2290.c                            |    2 +-
 drivers/interconnect/qcom/sc7280.c                             |  276 ++
 include/dt-bindings/interconnect/mediatek,mt8183.h             |   23 +
 include/dt-bindings/interconnect/mediatek,mt8195.h             |   44 +
 include/dt-bindings/interconnect/qcom,msm8953.h                |   93 +
 27 files changed, 2821 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/interconnect/mediatek,mt8183-emi.yaml
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,msm8953.yaml
 create mode 100644 drivers/interconnect/mediatek/Kconfig
 create mode 100644 drivers/interconnect/mediatek/Makefile
 create mode 100644 drivers/interconnect/mediatek/icc-emi.c
 create mode 100644 drivers/interconnect/mediatek/icc-emi.h
 create mode 100644 drivers/interconnect/mediatek/mt8183.c
 create mode 100644 drivers/interconnect/mediatek/mt8195.c
 create mode 100644 drivers/interconnect/qcom/msm8953.c
 create mode 100644 include/dt-bindings/interconnect/mediatek,mt8183.h
 create mode 100644 include/dt-bindings/interconnect/mediatek,mt8195.h
 create mode 100644 include/dt-bindings/interconnect/qcom,msm8953.h

