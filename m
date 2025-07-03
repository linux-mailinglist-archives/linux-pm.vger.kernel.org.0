Return-Path: <linux-pm+bounces-30072-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC4BAF7CF7
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 17:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57F3E188C96D
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 15:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4DE231A30;
	Thu,  3 Jul 2025 15:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bVJveQnV"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152C5221FC7;
	Thu,  3 Jul 2025 15:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751558158; cv=none; b=rdpuypU46LpRpBJT6lK1eCsgEOtISq2hcCt9IJ5Yhh3d5GRliAH0Zh01GqPxKb/woN+2obA7ADHArOu/PJaelMdLg9XbxN8PzfiGS5YMB6wbjNKD/tVkZyfZGO9opvjRju+I8mZrKazrVOfvdVfmr6bog9STVk31x9PExapxDKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751558158; c=relaxed/simple;
	bh=sXaoVv9tyLyV0Zz/v2ZIPCrRYVLC/rpt0zYBDKlcr/Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l0Qo9KujRem/cKTUFAThkt6fcfLrHNtIgYbum6tIGbkYSVWmh3rh5N5Sxi6C4xSJ/x/HsRZCQS2hF116NcbOZXuxGd5mfFi09yYD38INQQh6zm18ZXeqDAof5CdjZBwFXaaLCZ6efQ/R3uA/x/42hqODtC2jGa8b4/DrNZPGahc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bVJveQnV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97339C4CEE3;
	Thu,  3 Jul 2025 15:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751558157;
	bh=sXaoVv9tyLyV0Zz/v2ZIPCrRYVLC/rpt0zYBDKlcr/Q=;
	h=From:To:Cc:Subject:Date:From;
	b=bVJveQnVx0aOCN8v/QYWCmM4RdPh6Rdu0s5Mh0PE/NL+MMWM68miHF9YVdAj6qXRj
	 H8RUcX11/kh1H6iX8jkUXj5wG8mXtn/1mUit+wxLzxBH6d7IuEPv+yaZ7rmq4mMNUc
	 PkLHv4XIUNKjjQ4q9YJCAe6tj+YaRfDt967FNn0fWteBpfuq3bBHeQhTCrHk0BWCSg
	 OxfGctP+dbDfrdcyVH1Mfj56454cmdWWZVVf27Cd9Ip5ieUKJJmT4v57CrrirqtD70
	 b+AYCYc3aK6KvOl3zete1oO+P6Z+9DU81WIoQo5UcwtlwbmurU8/cJ41WJrng0zah7
	 TJQi/nxGBcMoA==
From: Georgi Djakov <djakov@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	djakov@kernel.org
Subject: [GIT PULL] interconnect fixes for 6.16-rc
Date: Thu,  3 Jul 2025 18:55:14 +0300
Message-Id: <20250703155514.3841629-1-djakov@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Greg,

This pull request contains fixes for the current cycle. The details are
in the signed tag as usual. The patches have been in linux-next for a few
days. Please pull into char-misc-linus when possible.

Thanks,
Georgi


The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-6.16-rc5

for you to fetch changes up to c5b60592886f97b01503c1bb553f88d6a7df42ea:

  interconnect: avoid memory allocation when 'icc_bw_lock' is held (2025-06-27 21:43:40 +0300)

----------------------------------------------------------------
interconnect fixes for v6.16-rc

This contains a few framework core fixes (related to the new dynamic node
id feature), as well as some misc Qualcomm and Samsung driver fixes.

- interconnect: qcom: sc7280: Add missing num_links to xm_pcie3_1 node
- interconnect: exynos: handle node name allocation failure
- interconnect: increase ICC_DYN_ID_START
- interconnect: icc-clk: destroy nodes in case of memory allocation failures
- interconnect: avoid memory allocation when 'icc_bw_lock' is held

Signed-off-by: Georgi Djakov <djakov@kernel.org>

----------------------------------------------------------------
Gabor Juhos (3):
      interconnect: increase ICC_DYN_ID_START
      interconnect: icc-clk: destroy nodes in case of memory allocation failures
      interconnect: avoid memory allocation when 'icc_bw_lock' is held

Johan Hovold (1):
      interconnect: exynos: handle node name allocation failure

Xilin Wu (1):
      interconnect: qcom: sc7280: Add missing num_links to xm_pcie3_1 node

 drivers/interconnect/core.c           | 34 ++++++--
 drivers/interconnect/icc-clk.c        |  2 +
 drivers/interconnect/qcom/icc-rpmh.c  |  7 +-
 drivers/interconnect/qcom/osm-l3.c    |  7 +-
 drivers/interconnect/qcom/sc7280.c    |  1 +
 drivers/interconnect/samsung/exynos.c |  5 ++
 include/linux/interconnect-provider.h |  7 ++
 7 files changed, 56 insertions(+), 7 deletions(-)

