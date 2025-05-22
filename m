Return-Path: <linux-pm+bounces-27517-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B92A8AC10AD
	for <lists+linux-pm@lfdr.de>; Thu, 22 May 2025 18:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7968A27C7C
	for <lists+linux-pm@lfdr.de>; Thu, 22 May 2025 16:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB12E29995D;
	Thu, 22 May 2025 16:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CICX/f7/"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF37580B;
	Thu, 22 May 2025 16:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747929828; cv=none; b=nATPWemjQd+rAGdZL86P7sIdhbv4Zg4BJhrH1e13DRb3l7JWoGYq6dw74/fc8G2D3N2X0LeE7gjZXZvb0WwrHgy8wwn6ISOehL01H8O+2jQS+hSAWoj4XaIXZXL1aaoz2UY79ESjZ8saolY461vMnPRaJQQYhgsrjoL4waAYO0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747929828; c=relaxed/simple;
	bh=HUH0RE34oNU0RQxQXjHa25P4cj8iY+R/hhIkpLqzuK0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RMHx7iDvkZKwbC+Btw2uDU1QcXbxmFkqWft0uFxUo3mwiWs+/7+2wFhmVy2rBia4iPuu087ZALVp6MIMs0qx+tt2Ope/D0no9HlV7bPl26k3WEvqAJA9yJyduteLbF3trrg5Syyq50fQYXA7/hFZR4RWDlvRDnjexACp3ZYKfOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CICX/f7/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ACF9C4CEEA;
	Thu, 22 May 2025 16:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747929828;
	bh=HUH0RE34oNU0RQxQXjHa25P4cj8iY+R/hhIkpLqzuK0=;
	h=From:To:Cc:Subject:Date:From;
	b=CICX/f7/sYLCTkMY2c3FCwbW8kA2sy33klFoF897s7tYU7DNjeX/Iyi6ixz50mYFd
	 ggRRsFUJIcAc93crjhGtrRZruJ9fRNm8bUlrGHJiS6JJltY5tUghExhdQyjCeomB8Q
	 8by+rZfPn1QMUPPjQVuPR9MRxE71yLrUjOPTtO7RUdN6mySd4gaag7I85Hn1gZcTCi
	 dXfbcu/OYbcNi2XFBVF0zb/rxZHaLhI+fkYpAVTpTWoSlVJeEWobqu179THB5/FtbO
	 bHY2RtXuXF54L5K3l1a67e/n1fiTml9Cx0sAGjeyjo4FE+PPSMcIZPFh3/swBDcG+0
	 iMw0PlNwMW+0w==
From: Georgi Djakov <djakov@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	djakov@kernel.org
Subject: [GIT PULL] interconnect changes for 6.16
Date: Thu, 22 May 2025 19:03:31 +0300
Message-Id: <20250522160331.2666873-1-djakov@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Greg,

This is the pull request with interconnect changes for the v6.16-rc1 merge
window. It contains core and driver changes. As always, the summary is in
the signed tag.

All patches have been in linux-next for a while. There are currently no
reported issues. Please pull into char-misc-next when possible.

Thanks,
Georgi


The following changes since commit 0af2f6be1b4281385b618cb86ad946eded089ac8:

  Linux 6.15-rc1 (2025-04-06 13:11:33 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-6.16-rc1

for you to fetch changes up to 5fed7fe33c2cd7104fc87b7bc699a7be892befa2:

  Merge branch 'icc-sa8775p' into icc-next (2025-05-19 17:09:50 +0300)

----------------------------------------------------------------
interconnect changes for 6.16

This pull request contains the interconnect changes for the 6.16-rc1
merge window. The core and driver changes are listed below.

Core changes:
- Add support for dynamic id allocation, that allows creating
  multiple instances of the same provider

Driver changes:
- Add driver for the EPSS L3 instances on SA8775P SoC
- Add QoS support for SM8650 SoC
- Add some missing nodes for SM8650
- Misc dt-binding style and indentation fixes

Signed-off-by: Georgi Djakov <djakov@kernel.org>

----------------------------------------------------------------
Georgi Djakov (1):
      Merge branch 'icc-sa8775p' into icc-next

Krzysztof Kozlowski (1):
      dt-bindings: interconnect: Correct indentation and style in DTS example

Neil Armstrong (4):
      interconnect: qcom: sm8650: enable QoS configuration
      dt-bindings: interconnect: sm8650: document the MASTER_APSS_NOC
      interconnect: qcom: sm8650: add the MASTER_APSS_NOC
      interconnect: qcom: sm8650: remove regmap config for mc_virt & clk_virt

Raviteja Laggyshetty (5):
      dt-bindings: interconnect: Add EPSS L3 compatible for SA8775P
      interconnect: core: Add dynamic id allocation support
      interconnect: qcom: Add multidev EPSS L3 support
      interconnect: qcom: icc-rpmh: Add dynamic icc node id support
      interconnect: qcom: sa8775p: Add dynamic icc node id support

 .../devicetree/bindings/interconnect/qcom,msm8939.yaml          |   8 +-
 .../devicetree/bindings/interconnect/qcom,msm8953.yaml          |  20 +-
 .../devicetree/bindings/interconnect/qcom,msm8974.yaml          |  20 +-
 Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml |   1 +
 Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml    |  12 +-
 Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml   |  28 +-
 .../devicetree/bindings/interconnect/qcom,sdx75-rpmh.yaml       |  16 +-
 drivers/interconnect/core.c                                     |  82 +-
 drivers/interconnect/qcom/icc-rpmh.c                            |  17 +-
 drivers/interconnect/qcom/icc-rpmh.h                            |   5 +
 drivers/interconnect/qcom/osm-l3.c                              |  38 +-
 drivers/interconnect/qcom/sa8775p.c                             | 952 +++-----
 drivers/interconnect/qcom/sm8650.c                              | 344 +++
 drivers/interconnect/qcom/sm8650.h                              |   1 +
 include/dt-bindings/interconnect/qcom,sm8650-rpmh.h             |   1 +
 include/linux/interconnect-provider.h                           |  12 +
 include/linux/interconnect.h                                    |   3 +
 17 files changed, 873 insertions(+), 687 deletions(-)

