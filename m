Return-Path: <linux-pm+bounces-40933-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B23D6D24DFF
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jan 2026 15:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 95AF43006706
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jan 2026 14:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5656739527F;
	Thu, 15 Jan 2026 14:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QjrIdv1C"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333C217736;
	Thu, 15 Jan 2026 14:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768486082; cv=none; b=Q1TW4dFgHtXDN7MelpcS2lfezQULYs7ByFKzgrw31WC+0h9qjJHpfPlporc+MGBGWZ65NbGkiy1ogyTM8EFpAxdvx4CJdH4sSWVQrpa+9oNdjG2xz1Qx1cx37Izq0Hkhs3WJk1pxZe/aTEqNBFNx+ciHe2GhwZVzA0JFnBLxQTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768486082; c=relaxed/simple;
	bh=e9eUlhqK8N+yAWMYljQjUpUyYJbVk6xYKHo4S9fl0H4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iT48IN1Ha2EWj43hIDVMVWv6NKC9PgBiEf3DUJO0/bk3wIAn+ZImS0vUx+IsvopoVICL8IQoXy/2/bFqyUJPCxseamHEnyb+0Ej8zNNfY81Wj4s5ijGXf5Hem1wszBL5ob+O1QBITWUiySvxnWAc4De5cq75Aymv9+vdUIwBnHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QjrIdv1C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A760EC19423;
	Thu, 15 Jan 2026 14:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768486081;
	bh=e9eUlhqK8N+yAWMYljQjUpUyYJbVk6xYKHo4S9fl0H4=;
	h=From:To:Cc:Subject:Date:From;
	b=QjrIdv1CLJ7UWe9eRNhAoYV9c9ul9pHToTK1U/9wfr9LG4rYdVj2PxWiIMG1xX4+f
	 tEp4sPPjPTHLonZ0v1scxsm6l3QDMu6aXvgCBuMLrLm0IhIy+V60ijg7WvurKA4X2S
	 0Wmbrtr//pbyZjw94mNDKgtgpxCeamz4RHEpEW5WTFTaHtaSSoJpg/VDJxnzzDISi0
	 BYU2pcW8RSVXZPk7B8zeQo1EX569sfe4TI0E8BZDTdAotD5+4eRFSiYTreauiZ4/Ld
	 iew+lyFfrxauCbWjx/WShAH18WAE9UMbJQZojdPz+nYAAd7LjC+XJ9F9eWXjV2oKuc
	 wvVxVuXoPU4wA==
From: Georgi Djakov <djakov@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	djakov@kernel.org
Subject: [GIT PULL] interconnect fixes for 6.19-rc
Date: Thu, 15 Jan 2026 16:07:28 +0200
Message-Id: <20260115140728.494253-1-djakov@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Greg,

This pull request contains a couple of small fixes for v6.19. They are
listed in the signed tag. All have been in linux-next for a few days.
Please pull them into char-misc-linus when you get a chance.

Thanks,
Georgi

The following changes since commit 8f0b4cce4481fb22653697cced8d0d04027cb1e8:

  Linux 6.19-rc1 (2025-12-14 16:05:07 +1200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-6.19-rc6

for you to fetch changes up to 8cc27f5c6dd17dd090f3a696683f04336c162ff5:

  interconnect: debugfs: initialize src_node and dst_node to empty strings (2026-01-12 01:58:36 +0200)

----------------------------------------------------------------
interconnect fixes for v6.19-rc

This contains a few small fixes for the current cycle.

- dt-bindings: interconnect: qcom,sa8775p-rpmh: Fix incorrectly added reg and clocks
- MAINTAINERS: Add interconnect-clk.h to interconnect API entry
- interconnect: debugfs: initialize src_node and dst_node to empty strings

Signed-off-by: Georgi Djakov <djakov@kernel.org>

----------------------------------------------------------------
Georgi Djakov (1):
      interconnect: debugfs: initialize src_node and dst_node to empty strings

Krzysztof Kozlowski (1):
      dt-bindings: interconnect: qcom,sa8775p-rpmh: Fix incorrectly added reg and clocks

Kuan-Wei Chiu (1):
      MAINTAINERS: Add interconnect-clk.h to interconnect API entry

 .../devicetree/bindings/interconnect/qcom,sa8775p-rpmh.yaml      | 31 ++++++++
 MAINTAINERS                                                      |  1 +
 drivers/interconnect/debugfs-client.c                            |  5 ++
 3 files changed, 37 insertions(+)

