Return-Path: <linux-pm+bounces-17326-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A0D9C3FD5
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 14:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F01AF1F21081
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 13:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235C919DF61;
	Mon, 11 Nov 2024 13:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EzDA4JSh"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08C319D891;
	Mon, 11 Nov 2024 13:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731333046; cv=none; b=exhpGBatjqoaZ/DMqQ3PjDN4zH6snpgbDRtoIU9cnubHPRybaa7Km377ccxwjxC4OjFfPIld5ubpPC493mTkysfC8e724nkKiHk6U25X9GORXEX8zBA4Mg2uaLKQPGTwjjhL8wcZF1Ksk3yE7HUP9x8fIPif5170FWyaY1dXD/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731333046; c=relaxed/simple;
	bh=igSTgu76GFYvFftAE7voDBY7egITEGWmPnHa+OO6rVo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=qk45XcHKtRYKtaSEbuHg3ZZm8FtriCGK3An8XH+xuUUqxDj5WAWLIEwg0HflrtGm/vmBM7YG+FmZgY5+PM7ceh2IjIjUHYpli51wFVV6cJH7BteLHDjVBpiBLpBVuwIP193a8oqZMVaQ/m4uyXULIdk5QpR0I3qD7BFf7UqlB0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EzDA4JSh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74020C4CECF;
	Mon, 11 Nov 2024 13:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731333045;
	bh=igSTgu76GFYvFftAE7voDBY7egITEGWmPnHa+OO6rVo=;
	h=From:To:Cc:Subject:Date:From;
	b=EzDA4JSh/YifYwWY1CqgOYZBp2vzv2LuRfLWXxS3RwGj+B7df3/ttMi6DmNkjrBvi
	 CfHNkbpywglc8uzZ1X+s63h8m6IHgbicUg5UMMUHRaFipYOZiNvOApZMMGZCFaWi2R
	 ZcLw9X+ctwf1+vCbdYgWmbxj7knLPk2QUio+ECFgqLLvpX9U3eF4J9C+1LazP9efq5
	 G1fiPHruFy8wlOBC56WQxd3Zkz+jEN/b/Mq7rRYTF76O67VFhBdav6qBOdrjVnDsCZ
	 VFphSYmhiz3ZcMNyzqvkI0dzBm89niJpepNd0C8fCRIz1hK1L0XvpdYGRMTvpEG8Ee
	 YQkEJNj2VK+SA==
From: Georgi Djakov <djakov@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	djakov@kernel.org
Subject: [GIT PULL] interconnect changes for 6.13
Date: Mon, 11 Nov 2024 15:43:04 +0200
Message-Id: <20241111134304.1019885-1-djakov@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello Greg,

This is the pull request with interconnect changes for the v6.13-rc1 merge
window. It contains new drivers and clean-ups. As always, the summary is
in the signed tag.

All patches have been in linux-next for at least a week. There are no
reported issues. Please pull into char-misc-next when possible.

Thanks,
Georgi


The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:

  Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-6.13-rc1

for you to fetch changes up to b1fd28da86aae5d622ea95711cee8ede39f70369:

  Merge branch 'icc-sar2130p' into icc-next (2024-11-05 01:32:05 +0200)

----------------------------------------------------------------
interconnect changes for 6.13

This pull request contains the interconnect changes for the 6.13-rc1 merge
window. It contains new drivers and clean-ups with the following highlights:

Core changes:
- Remove a useless kfree_const() usage
- Switch back to struct platform_driver::remove()
- Use of_property_present() for non-boolean properties

Driver changes:
- New driver for QCS615 platforms
- New driver for SAR2130P platforms
- New driver for QCS8300 platforms
- Probe defer incase of missing QoS clock dependency in rpmh driver
- Rename qos_clks_required flag to qos_requires_clocks in rpmh driver
- Constify pointers to qcom_icc_node in msm8937 driver

Signed-off-by: Georgi Djakov <djakov@kernel.org>

----------------------------------------------------------------
Christophe JAILLET (1):
      interconnect: Remove a useless kfree_const() usage

Dmitry Baryshkov (2):
      dt-bindings: interconnect: qcom: document SAR2130P NoC
      interconnect: qcom: add support for SAR2130P

Georgi Djakov (3):
      Merge branch 'icc-qcs8300' into icc-next
      Merge branch 'icc-qcs615' into icc-next
      Merge branch 'icc-sar2130p' into icc-next

Jingyi Wang (1):
      dt-bindings: interconnect: qcom-bwmon: Document QCS8300 bwmon compatibles

Krzysztof Kozlowski (1):
      interconnect: qcom: msm8937: constify pointer to qcom_icc_node

Raviteja Laggyshetty (6):
      interconnect: qcom: icc-rpmh: probe defer incase of missing QoS clock dependency
      interconnect: qcom: icc-rpmh: rename qos_clks_required flag
      dt-bindings: interconnect: document the RPMh Network-On-Chip interconnect in QCS8300 SoC
      dt-bindings: interconnect: document the RPMh Network-On-Chip interconnect in QCS615 SoC
      interconnect: qcom: add QCS615 interconnect provider driver
      interconnect: qcom: add QCS8300 interconnect provider driver

Rob Herring (Arm) (1):
      interconnect: Use of_property_present() for non-boolean properties

Uwe Kleine-König (1):
      interconnect: Switch back to struct platform_driver::remove()

 .../devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml   |    2 +
 .../devicetree/bindings/interconnect/qcom,qcs615-rpmh.yaml     |   73 +
 .../devicetree/bindings/interconnect/qcom,qcs8300-rpmh.yaml    |   72 +
 .../devicetree/bindings/interconnect/qcom,sar2130p-rpmh.yaml   |  117 +
 drivers/interconnect/core.c                                    |    4 +-
 drivers/interconnect/imx/imx8mm.c                              |    2 +-
 drivers/interconnect/imx/imx8mn.c                              |    2 +-
 drivers/interconnect/imx/imx8mp.c                              |    2 +-
 drivers/interconnect/imx/imx8mq.c                              |    2 +-
 drivers/interconnect/mediatek/mt8183.c                         |    2 +-
 drivers/interconnect/mediatek/mt8195.c                         |    2 +-
 drivers/interconnect/qcom/Kconfig                              |   29 +
 drivers/interconnect/qcom/Makefile                             |    6 +
 drivers/interconnect/qcom/icc-rpmh.c                           |    5 +-
 drivers/interconnect/qcom/icc-rpmh.h                           |    2 +-
 drivers/interconnect/qcom/msm8909.c                            |    2 +-
 drivers/interconnect/qcom/msm8916.c                            |    2 +-
 drivers/interconnect/qcom/msm8937.c                            |   10 +-
 drivers/interconnect/qcom/msm8939.c                            |    2 +-
 drivers/interconnect/qcom/msm8953.c                            |    2 +-
 drivers/interconnect/qcom/msm8974.c                            |    2 +-
 drivers/interconnect/qcom/msm8976.c                            |    2 +-
 drivers/interconnect/qcom/msm8996.c                            |    2 +-
 drivers/interconnect/qcom/osm-l3.c                             |    2 +-
 drivers/interconnect/qcom/qcm2290.c                            |    2 +-
 drivers/interconnect/qcom/qcs404.c                             |    2 +-
 drivers/interconnect/qcom/qcs615.c                             | 1563 ++++++
 drivers/interconnect/qcom/qcs615.h                             |  128 +
 drivers/interconnect/qcom/qcs8300.c                            | 2088 ++++++++
 drivers/interconnect/qcom/qcs8300.h                            |  177 +
 drivers/interconnect/qcom/qdu1000.c                            |    2 +-
 drivers/interconnect/qcom/sa8775p.c                            |    2 +-
 drivers/interconnect/qcom/sar2130p.c                           | 1930 +++++++
 drivers/interconnect/qcom/sc7180.c                             |    2 +-
 drivers/interconnect/qcom/sc7280.c                             |    6 +-
 drivers/interconnect/qcom/sc8180x.c                            |    2 +-
 drivers/interconnect/qcom/sc8280xp.c                           |    2 +-
 drivers/interconnect/qcom/sdm660.c                             |    2 +-
 drivers/interconnect/qcom/sdm670.c                             |    2 +-
 drivers/interconnect/qcom/sdm845.c                             |    2 +-
 drivers/interconnect/qcom/sdx55.c                              |    2 +-
 drivers/interconnect/qcom/sdx65.c                              |    2 +-
 drivers/interconnect/qcom/sdx75.c                              |    2 +-
 drivers/interconnect/qcom/sm6115.c                             |    2 +-
 drivers/interconnect/qcom/sm6350.c                             |    2 +-
 drivers/interconnect/qcom/sm7150.c                             |    2 +-
 drivers/interconnect/qcom/sm8150.c                             |    2 +-
 drivers/interconnect/qcom/sm8250.c                             |    2 +-
 drivers/interconnect/qcom/sm8350.c                             |    2 +-
 drivers/interconnect/qcom/sm8450.c                             |    2 +-
 drivers/interconnect/qcom/sm8550.c                             |    2 +-
 drivers/interconnect/qcom/sm8650.c                             |    2 +-
 drivers/interconnect/qcom/smd-rpm.c                            |    2 +-
 drivers/interconnect/qcom/x1e80100.c                           |    2 +-
 drivers/interconnect/samsung/exynos.c                          |    2 +-
 include/dt-bindings/interconnect/qcom,qcs615-rpmh.h            |  136 +
 include/dt-bindings/interconnect/qcom,qcs8300-rpmh.h           |  189 +
 include/dt-bindings/interconnect/qcom,sar2130p-rpmh.h          |  137 +
 58 files changed, 6701 insertions(+), 51 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,qcs615-rpmh.yaml
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,qcs8300-rpmh.yaml
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sar2130p-rpmh.yaml
 create mode 100644 drivers/interconnect/qcom/qcs615.c
 create mode 100644 drivers/interconnect/qcom/qcs615.h
 create mode 100644 drivers/interconnect/qcom/qcs8300.c
 create mode 100644 drivers/interconnect/qcom/qcs8300.h
 create mode 100644 drivers/interconnect/qcom/sar2130p.c
 create mode 100644 include/dt-bindings/interconnect/qcom,qcs615-rpmh.h
 create mode 100644 include/dt-bindings/interconnect/qcom,qcs8300-rpmh.h
 create mode 100644 include/dt-bindings/interconnect/qcom,sar2130p-rpmh.h

