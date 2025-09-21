Return-Path: <linux-pm+bounces-35114-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D24F9B8D705
	for <lists+linux-pm@lfdr.de>; Sun, 21 Sep 2025 09:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91CD63AC81E
	for <lists+linux-pm@lfdr.de>; Sun, 21 Sep 2025 07:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3EC02BFC73;
	Sun, 21 Sep 2025 07:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PFeOWwEG"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1FB46B5;
	Sun, 21 Sep 2025 07:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758441383; cv=none; b=q7q+sN6NxrBbOPyF1WAniDrJZU1C3HrlgE/Sj9ZjQdlYFLEQKyT0lAtTv67JEfmtbLWzID1x8dPXvXN3SHH2rauKM/qs/U+wQg/QPErwmQgZ2JHfwYTlG4DmzcGP/L0DBdmgT19A8zpCkZ9iXeoKG3vHJcaUzu8WEJ7FOUgaCYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758441383; c=relaxed/simple;
	bh=pkXmWMXT97+JSbetdgGN1OksrY17F7X1ivvEOG+Y2Zg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mf7gmD4mcRmi694G1lxKCFrxf2vUUrT3oU4Zbwotgud08uoL+sDRAF+YCxlUpEhyv0x19abyEylh2CURYohmKqxbHkPtIs/5nU3Abna2PwElzwxWmmfa37v2mPavT0ubtdO6WaJc60YUB+JltaMjYWhmazqqVkJzm+EOllM4gA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PFeOWwEG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 309FDC4CEE7;
	Sun, 21 Sep 2025 07:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758441383;
	bh=pkXmWMXT97+JSbetdgGN1OksrY17F7X1ivvEOG+Y2Zg=;
	h=From:To:Cc:Subject:Date:From;
	b=PFeOWwEGGDYMd3n5CWiy7ndYtMKRGSZ3Wi4NfuIlCX5K/tDfuxPz9r+nsPsydld1n
	 9re96EZn7nBU+u3PAqRXEy+V/RtD4hGMvn6CKHmMlzw5LOT1yf/WZ0vCQod/Q4Q6k7
	 Wa1Z6nuvZpFVVA+JSjt+6vPbHzutiXunNOjpcEN/KR4hKQZCzVgtuBLTyzywS+rLBD
	 XNMtoq6gCvRCm8HAtBcX/+lBWOUWVqdX9bttp2Fi4VVy3KdsTq1e33ZWu2wd8r+poD
	 U0Qy8xqSMm1bRJqSx5oaPwT2hpoT0qel5Qe/S9D39iMTRzqWvwvMMiIHFyOqIxgMWX
	 hLwvUvG3CGFUw==
From: Georgi Djakov <djakov@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	djakov@kernel.org
Subject: [GIT PULL] interconnect changes for 6.18
Date: Sun, 21 Sep 2025 10:56:03 +0300
Message-Id: <20250921075603.14452-1-djakov@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Greg,

This is the pull request with interconnect changes for the v6.18-rc1 merge
window. As always, the summary is in the signed tag.

All patches have been in linux-next for a full week. There are currently
no reported issues. Please pull into char-misc-next when possible.

Thanks,
Georgi


The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-6.18-rc1

for you to fetch changes up to bcdf7a064c3c73cd97870a3ef5e4dd6214b28b79:

  Merge branch 'icc-glymur' into icc-next (2025-09-12 13:54:17 +0300)

----------------------------------------------------------------
interconnect changes for 6.18

This pull request contains the interconnect changes for the 6.18-rc1
merge window. It contains new driver and a minor core cleanup.

Core change:
- Use device_match_of_node() instead of open coding it

Driver changes:
- Add new driver for the Qualcomm Glymur SoC
- Enable OSM L3 support for the QCS615 SoC

Signed-off-by: Georgi Djakov <djakov@kernel.org>

----------------------------------------------------------------
Georgi Djakov (1):
      Merge branch 'icc-glymur' into icc-next

Raviteja Laggyshetty (4):
      dt-bindings: interconnect: document the RPMh Network-On-Chip interconnect in Glymur SoC
      interconnect: qcom: icc-rpmh: increase MAX_PORTS to support four QoS ports
      interconnect: qcom: add glymur interconnect provider driver
      dt-bindings: interconnect: Add OSM L3 compatible for QCS615 SoC

Zhang Enpei (1):
      interconnect: core: Use device_match_of_node()

 .../devicetree/bindings/interconnect/qcom,glymur-rpmh.yaml     |  172 +
 .../devicetree/bindings/interconnect/qcom,osm-l3.yaml          |    5 +
 drivers/interconnect/core.c                                    |    2 +-
 drivers/interconnect/qcom/Kconfig                              |    9 +
 drivers/interconnect/qcom/Makefile                             |    2 +
 drivers/interconnect/qcom/glymur.c                             | 2543 ++++++++
 drivers/interconnect/qcom/icc-rpmh.h                           |    2 +-
 include/dt-bindings/interconnect/qcom,glymur-rpmh.h            |  205 +
 8 files changed, 2938 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,glymur-rpmh.yaml
 create mode 100644 drivers/interconnect/qcom/glymur.c
 create mode 100644 include/dt-bindings/interconnect/qcom,glymur-rpmh.h

