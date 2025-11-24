Return-Path: <linux-pm+bounces-38474-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 246A0C815CE
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 16:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7F3F3A2732
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 15:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BAF31352B;
	Mon, 24 Nov 2025 15:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EpKLaPQa"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5E629A322;
	Mon, 24 Nov 2025 15:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763998445; cv=none; b=OeNAxNDn4e5rDbbApZ2JYsDjOV+VwHY+eF2KF6jy18Ebd1yS55X/xIYV30lnhJe5mRDudNP/QYON7USvKe4hteBJ2iVKjSDceLsHjsrEnv7KFy9jwfiT4f7I+/Rv/PU0DFLWwOgxNvbut8BpNmD0b37wy8i42YDMDq/kzSyWTH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763998445; c=relaxed/simple;
	bh=d9PUmR/PITKV7fFNiNd0FCOE6MjF4kQ835w5ojEFs8A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fpKAALj/vBIs+NRgS8XSZUHWHTZ9HYwSe/FFj7r3I29f4QgLYjKK2HZT1uOEFLeGFldlJ8v+4GPFLZ4Ayiik8scKnNN4KrYEMBAjeDhrBISgebbCZAnhrcomv3GOlbBPImXILH458+ve4RB3H6sGvorSco5kYqH1AK0VlAcTzrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EpKLaPQa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8A8BC4CEF1;
	Mon, 24 Nov 2025 15:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763998444;
	bh=d9PUmR/PITKV7fFNiNd0FCOE6MjF4kQ835w5ojEFs8A=;
	h=From:To:Cc:Subject:Date:From;
	b=EpKLaPQaHxLx/9GT+e6ixxv4r9gSq8qWvP1rVZFBt8wBMJ+wNab3gAxpj+GwdPMfg
	 oGu9FCeLvf00obmyENfeFxK1RZzxtQWKoeuJP5x8d0zwn6/9r2r6b+Iwt86wC2ysXK
	 C4k6KelmoacXQuFHWdVoVUlJKm+ocOM+XzTWU5GTpZC4cIYFELqtEcYu8hCoURmluE
	 ThQAyktFzj7JXSF3aXfKPY5eYgbdvs4y/fe1HAp1Qze0yCJbMWyGQAq1qlon/o0zwT
	 eaKOZRhmM7zysMen/SMzEeOTuFoNdPNv9KkZGc0kxj5ayzyIb1htRwFA46EzSKlTU9
	 PI5VjHbdoQhoA==
From: Georgi Djakov <djakov@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	djakov@kernel.org
Subject: [GIT PULL] interconnect changes for 6.19
Date: Mon, 24 Nov 2025 17:33:32 +0200
Message-Id: <20251124153332.2754651-1-djakov@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Greg,

This is the pull request with interconnect changes for the v6.19-rc1 merge
window. As always, the summary is in the signed tag.

All patches have been in linux-next for a while. There are currently
no reported issues. Please pull into char-misc-next when possible.

Thanks,
Georgi


The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:

  Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-6.19-rc1

for you to fetch changes up to 60b52af082b1462e878d10a0298fad40a26a8b35:

  Merge branch 'icc-sm6350' into icc-next (2025-11-19 16:07:00 +0200)

----------------------------------------------------------------
interconnect changes for 6.19

This pull request contains the interconnect changes for the 6.19-rc1
merge window. The core and driver changes are listed below.

Core changes:
- kbps_to_icc() macro optimization

Driver changes:
- Switch all Qualcomm RPMh interconnect drivers to use the dynamic
  node IDs and drop support for non-dynamic ID allocation
- Add new driver and BWMON support for the Kaanapali SoC
- Add QoS support for the SM6350 SoC
- Add QoS support for the SA8775p SoC
- Fix missing link from SNOC_PNOC to the USB 2 on MSM8996 SoC that
  includes also a dts change that has been acked by the maintainer
- Drop the QPIC interconnect and BCM nodes for the SDX75 SoC, as these
  should be handled by the rpmh-clk driver
- Other misc fixes

Signed-off-by: Georgi Djakov <djakov@kernel.org>

----------------------------------------------------------------
Amir Vajid (1):
      dt-bindings: interconnect: qcom-bwmon: Document Kaanapali BWMONs

Dmitry Baryshkov (27):
      interconnect: qcom: msm8996: add missing link to SLAVE_USB_HS
      arm64: dts: qcom: msm8996: add interconnect paths to USB2 controller
      interconnect: qcom: icc-rpmh: convert link_nodes to dynamic array
      interconnect: qcom: sc7280: convert to dynamic IDs
      interconnect: qcom: sc8180x: convert to dynamic IDs
      interconnect: qcom: sc8280xp: convert to dynamic IDs
      interconnect: qcom: sdm845: convert to dynamic IDs
      interconnect: qcom: sm8250: convert to dynamic IDs
      interconnect: qcom: x1e80100: convert to dynamic IDs
      interconnect: qcom: qcs615: convert to dynamic IDs
      interconnect: qcom: qcs8300: convert to dynamic IDs
      interconnect: qcom: qdu1000: convert to dynamic IDs
      interconnect: qcom: sar2130p: convert to dynamic IDs
      interconnect: qcom: sc7180: convert to dynamic IDs
      interconnect: qcom: sdm670: convert to dynamic IDs
      interconnect: qcom: sdx55: convert to dynamic IDs
      interconnect: qcom: sdx65: convert to dynamic IDs
      interconnect: qcom: sdx75: convert to dynamic IDs
      interconnect: qcom: sm6350: convert to dynamic IDs
      interconnect: qcom: sm7150: convert to dynamic IDs
      interconnect: qcom: sm8150: convert to dynamic IDs
      interconnect: qcom: sm8350: convert to dynamic IDs
      interconnect: qcom: sm8450: convert to dynamic IDs
      interconnect: qcom: sm8550: convert to dynamic IDs
      interconnect: qcom: sm8650: convert to dynamic IDs
      interconnect: qcom: sm8750: convert to dynamic IDs
      interconnect: qcom: icc-rpmh: drop support for non-dynamic IDS

Georgi Djakov (6):
      Merge branch 'icc-msm8996' into icc-next
      Merge branch 'icc-sdx75' into icc-next
      Merge branch 'icc-sa8775p' into icc-next
      Merge branch 'icc-kaanapali' into icc-next
      Merge branch 'icc-dynamic-ids' into icc-next
      Merge branch 'icc-sm6350' into icc-next

Kuan-Wei Chiu (2):
      interconnect: Optimize kbps_to_icc() macro
      interconnect: debugfs: Fix incorrect error handling for NULL path

Luca Weiss (4):
      dt-bindings: interconnect: qcom,sm6350-rpmh: Add clocks for QoS
      interconnect: qcom: icc-rpmh: Get parent's regmap for nested NoCs
      interconnect: qcom: sm6350: Remove empty BCM arrays
      interconnect: qcom: sm6350: enable QoS configuration

Odelu Kukatla (2):
      dt-bindings: interconnect: add reg and clocks properties to enable QoS on sa8775p
      interconnect: qcom: sa8775p: enable QoS configuration

Raviteja Laggyshetty (4):
      interconnect: qcom: sdx75: Drop QPIC interconnect and BCM nodes
      dt-bindings: interconnect: qcom: Drop QPIC_CORE IDs
      dt-bindings: interconnect: document the RPMh Network-On-Chip interconnect in Kaanapali SoC
      interconnect: qcom: add Kaanapali interconnect provider driver

 .../devicetree/bindings/interconnect/qcom,kaanapali-rpmh.yaml  |  124 +
 .../devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml   |    1 +
 .../devicetree/bindings/interconnect/qcom,sa8775p-rpmh.yaml    |   50 +-
 .../devicetree/bindings/interconnect/qcom,sm6350-rpmh.yaml     |   65 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi                          |    3 +
 drivers/interconnect/debugfs-client.c                          |    7 +-
 drivers/interconnect/qcom/Kconfig                              |    9 +
 drivers/interconnect/qcom/Makefile                             |    2 +
 drivers/interconnect/qcom/glymur.c                             |  225 +-
 drivers/interconnect/qcom/icc-rpmh.c                           |   39 +-
 drivers/interconnect/qcom/icc-rpmh.h                           |    7 +-
 drivers/interconnect/qcom/kaanapali.c                          | 1855 ++++++++
 drivers/interconnect/qcom/milos.c                              |  142 +-
 drivers/interconnect/qcom/msm8996.c                            |    1 +
 drivers/interconnect/qcom/qcs615.c                             |  511 +-
 drivers/interconnect/qcom/qcs615.h                             |  128 -
 drivers/interconnect/qcom/qcs8300.c                            |  671 ++-
 drivers/interconnect/qcom/qcs8300.h                            |  177 -
 drivers/interconnect/qcom/qdu1000.c                            |  348 +-
 drivers/interconnect/qcom/qdu1000.h                            |   95 -
 drivers/interconnect/qcom/sa8775p.c                            |  639 ++-
 drivers/interconnect/qcom/sar2130p.c                           |  630 +--
 drivers/interconnect/qcom/sc7180.c                             |  678 ++-
 drivers/interconnect/qcom/sc7180.h                             |  149 -
 drivers/interconnect/qcom/sc7280.c                             |  617 ++-
 drivers/interconnect/qcom/sc7280.h                             |  154 -
 drivers/interconnect/qcom/sc8180x.c                            |  648 +--
 drivers/interconnect/qcom/sc8180x.h                            |  179 -
 drivers/interconnect/qcom/sc8280xp.c                           |  825 ++--
 drivers/interconnect/qcom/sc8280xp.h                           |  209 -
 drivers/interconnect/qcom/sdm670.c                             |  522 +-
 drivers/interconnect/qcom/sdm670.h                             |  128 -
 drivers/interconnect/qcom/sdm845.c                             |  766 ++-
 drivers/interconnect/qcom/sdm845.h                             |  140 -
 drivers/interconnect/qcom/sdx55.c                              |  489 +-
 drivers/interconnect/qcom/sdx55.h                              |   70 -
 drivers/interconnect/qcom/sdx65.c                              |  457 +-
 drivers/interconnect/qcom/sdx65.h                              |   65 -
 drivers/interconnect/qcom/sdx75.c                              |  395 +-
 drivers/interconnect/qcom/sdx75.h                              |   97 -
 drivers/interconnect/qcom/sm6350.c                             |  927 ++--
 drivers/interconnect/qcom/sm6350.h                             |  139 -
 drivers/interconnect/qcom/sm7150.c                             |  653 ++-
 drivers/interconnect/qcom/sm7150.h                             |  140 -
 drivers/interconnect/qcom/sm8150.c                             |  706 ++-
 drivers/interconnect/qcom/sm8150.h                             |  152 -
 drivers/interconnect/qcom/sm8250.c                             |  736 ++-
 drivers/interconnect/qcom/sm8250.h                             |  168 -
 drivers/interconnect/qcom/sm8350.c                             |  684 ++-
 drivers/interconnect/qcom/sm8350.h                             |  158 -
 drivers/interconnect/qcom/sm8450.c                             |  601 ++-
 drivers/interconnect/qcom/sm8450.h                             |  169 -
 drivers/interconnect/qcom/sm8550.c                             |  501 +-
 drivers/interconnect/qcom/sm8550.h                             |  138 -
 drivers/interconnect/qcom/sm8650.c                             |  527 +-
 drivers/interconnect/qcom/sm8650.h                             |  144 -
 drivers/interconnect/qcom/sm8750.c                             |  602 +--
 drivers/interconnect/qcom/x1e80100.c                           |  610 ++-
 drivers/interconnect/qcom/x1e80100.h                           |  192 -
 include/dt-bindings/interconnect/qcom,kaanapali-rpmh.h         |  149 +
 include/dt-bindings/interconnect/qcom,sdx75.h                  |    2 -
 include/linux/interconnect.h                                   |    2 +-
 62 files changed, 9632 insertions(+), 10785 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,kaanapali-rpmh.yaml
 create mode 100644 drivers/interconnect/qcom/kaanapali.c
 delete mode 100644 drivers/interconnect/qcom/qcs615.h
 delete mode 100644 drivers/interconnect/qcom/qcs8300.h
 delete mode 100644 drivers/interconnect/qcom/qdu1000.h
 delete mode 100644 drivers/interconnect/qcom/sc7180.h
 delete mode 100644 drivers/interconnect/qcom/sc7280.h
 delete mode 100644 drivers/interconnect/qcom/sc8180x.h
 delete mode 100644 drivers/interconnect/qcom/sc8280xp.h
 delete mode 100644 drivers/interconnect/qcom/sdm670.h
 delete mode 100644 drivers/interconnect/qcom/sdm845.h
 delete mode 100644 drivers/interconnect/qcom/sdx55.h
 delete mode 100644 drivers/interconnect/qcom/sdx65.h
 delete mode 100644 drivers/interconnect/qcom/sdx75.h
 delete mode 100644 drivers/interconnect/qcom/sm6350.h
 delete mode 100644 drivers/interconnect/qcom/sm7150.h
 delete mode 100644 drivers/interconnect/qcom/sm8150.h
 delete mode 100644 drivers/interconnect/qcom/sm8250.h
 delete mode 100644 drivers/interconnect/qcom/sm8350.h
 delete mode 100644 drivers/interconnect/qcom/sm8450.h
 delete mode 100644 drivers/interconnect/qcom/sm8550.h
 delete mode 100644 drivers/interconnect/qcom/sm8650.h
 delete mode 100644 drivers/interconnect/qcom/x1e80100.h
 create mode 100644 include/dt-bindings/interconnect/qcom,kaanapali-rpmh.h

