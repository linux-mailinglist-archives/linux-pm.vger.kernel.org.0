Return-Path: <linux-pm+bounces-31356-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D337AB1004C
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jul 2025 07:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB3523BA420
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jul 2025 05:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B319C2046A9;
	Thu, 24 Jul 2025 05:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mt3o0xCh"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893F3202C48;
	Thu, 24 Jul 2025 05:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753336649; cv=none; b=T7g2o3Riyu7F5XnTzTznk4UBSdA+KzlwdbGbdU9O8FO9CIeBxcH4SlUi1Tket9KVNejiKtvlKeD4sNj1x+iFNTMTsHS0bhJbkFBTDG/uhn3U7MEEX3IdL3j9q8oBmgUuQ67cI8hIk5hqrk70VCoHGN1YffF7ni0KkfHN9LcuTVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753336649; c=relaxed/simple;
	bh=v2JztTXe4OVrFPr2+ifi9OR302LJje8h/XwMLk8OZLU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SpeCIZG8NcmyumJgT97Ohjgbz7KmJrl+XrbHzyqmOYizUZj8MsXohSqrtD7pl/UgDWi3aedpV1P5Zr1EJilQqezq8BGP+7hXLhsqQB/cQBt3iKTfkyza2RQQRNAAPBwFxv2M/2GkTQ3CR7hcXcSpKt9F6ytefBNi1un6UioIXBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mt3o0xCh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06A39C4CEED;
	Thu, 24 Jul 2025 05:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753336649;
	bh=v2JztTXe4OVrFPr2+ifi9OR302LJje8h/XwMLk8OZLU=;
	h=From:To:Cc:Subject:Date:From;
	b=Mt3o0xChy57QcbFab4aB/TR3VYsqnpqas9giYbCLxaFhHTuu/XI2B2Wb3CRVLt/PX
	 JFGtGtNmTMqvjpnrTi0lxfGj3TcgUlfdoIYPATcBHXj0XlbXWn/08pWzGtILDOayxV
	 Y0UYVGjWOBXeizCfMLc2HQ8j48b0vo91VwxhRJint4VMSqVsnXL4P5vEqagA3uC4K9
	 gErQJgTbZxT6MVP3NTDJkwDCWbIXEu3+7p4JQ6Giz8pdPpQgIC2os4kqFOaEIBEXGt
	 oaFB5V4KQmAcl5wyUJkUTCnQEcFbOypQclgnbXh5cSUjuEuHcX6gOG5AyLvjqePCK0
	 rJ8sBljUxAqBw==
From: Georgi Djakov <djakov@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	djakov@kernel.org
Subject: [GIT PULL] interconnect changes for 6.17
Date: Thu, 24 Jul 2025 08:57:16 +0300
Message-Id: <20250724055716.1636178-1-djakov@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Greg,

This is the pull request with interconnect changes for the v6.17-rc1 merge
window. This time it contains only driver changes. As always, the summary
is in the signed tag.

All patches have been in linux-next during the last few days. There are
currently no reported issues. Please pull into char-misc-next when possible.

Thanks,
Georgi


The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-6.17-rc1

for you to fetch changes up to ca652cf0c2612add5d3c9283bbc742dabc704a77:

  Merge branch 'icc-milos' into icc-next (2025-07-22 14:41:12 +0300)

----------------------------------------------------------------
interconnect changes for 6.17

This pull request contains the interconnect changes for the 6.17-rc1
merge window. It contains only driver changes.

Driver changes:
- SC8180X and SC8280XP driver fixes
- Add new driver for the Qualcomm Milos SoC
- Add Support for EPSS L3 hardware in QCS8300 SoC
- DT bindings fixes and other cleanups

Signed-off-by: Georgi Djakov <djakov@kernel.org>

----------------------------------------------------------------
Dmitry Baryshkov (2):
      interconnect: qcom: sc8280xp: specify num_links for qnm_a1noc_cfg
      interconnect: qcom: sc8180x: specify num_nodes

Georgi Djakov (1):
      Merge branch 'icc-milos' into icc-next

Konrad Dybcio (2):
      interconnect: qcom: qcs615: Drop IP0 interconnects
      dt-bindings: interconnect: qcom,msm8998-bwmon: Allow 'nonposted-mmio'

Luca Weiss (3):
      dt-bindings: interconnect: qcom: Remove double colon from description
      dt-bindings: interconnect: document the RPMh Network-On-Chip Interconnect in Qualcomm Milos SoC
      interconnect: qcom: Add Milos interconnect provider driver

Raviteja Laggyshetty (1):
      dt-bindings: interconnect: Add EPSS L3 compatible for QCS8300 SoC

 .../devicetree/bindings/interconnect/qcom,milos-rpmh.yaml      |  136 +
 .../devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml   |    2 +
 .../devicetree/bindings/interconnect/qcom,osm-l3.yaml          |    5 +
 .../devicetree/bindings/interconnect/qcom,sa8775p-rpmh.yaml    |    2 +-
 .../devicetree/bindings/interconnect/qcom,sar2130p-rpmh.yaml   |    2 +-
 .../devicetree/bindings/interconnect/qcom,sc7280-rpmh.yaml     |    2 +-
 .../devicetree/bindings/interconnect/qcom,sc8280xp-rpmh.yaml   |    2 +-
 .../devicetree/bindings/interconnect/qcom,sm7150-rpmh.yaml     |    2 +-
 .../devicetree/bindings/interconnect/qcom,sm8450-rpmh.yaml     |    2 +-
 .../devicetree/bindings/interconnect/qcom,sm8550-rpmh.yaml     |    2 +-
 .../devicetree/bindings/interconnect/qcom,sm8650-rpmh.yaml     |    2 +-
 .../devicetree/bindings/interconnect/qcom,sm8750-rpmh.yaml     |    2 +-
 .../devicetree/bindings/interconnect/qcom,x1e80100-rpmh.yaml   |    2 +-
 drivers/interconnect/qcom/Kconfig                              |    9 +
 drivers/interconnect/qcom/Makefile                             |    2 +
 drivers/interconnect/qcom/milos.c                              | 1931 ++++++++
 drivers/interconnect/qcom/qcs615.c                             |   42 -
 drivers/interconnect/qcom/sc8180x.c                            |    6 +
 drivers/interconnect/qcom/sc8280xp.c                           |    1 +
 include/dt-bindings/interconnect/qcom,milos-rpmh.h             |  141 +
 20 files changed, 2243 insertions(+), 52 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,milos-rpmh.yaml
 create mode 100644 drivers/interconnect/qcom/milos.c
 create mode 100644 include/dt-bindings/interconnect/qcom,milos-rpmh.h

