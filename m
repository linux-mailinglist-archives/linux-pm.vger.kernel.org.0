Return-Path: <linux-pm+bounces-19880-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1607F9FF776
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jan 2025 10:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 210991881BBE
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jan 2025 09:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C571917EB;
	Thu,  2 Jan 2025 09:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tZWBiia4"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56427188938;
	Thu,  2 Jan 2025 09:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735810471; cv=none; b=LMoVlARYAb0abRRArYvaJBGbwbJBd2Gdp6Gohmu+gkUlTZlEhnWd5bwl8r4EZWHrICLaXl80uffJdr93Kk/bLg95+mRJiPci5yPAucGk1sU23fVw9Hj79KtFK+Ex+R0f9BQjqRWvs7/XgfcXpx1AoXOBBSDkFq8RMWUzbfD3Aro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735810471; c=relaxed/simple;
	bh=oTeU9mTGKrBcXiHvg+Jl3slVbuBrAfkxWQcJ4qdEqJ4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kggPXr6j0bMnG/IlI7D/1uLz1JAWTfIVqirh1V0dRl4Wcp5Ln7myYyf1efrOuSWbbFYY46ROolcHt6AkaBC8oKRTm5cI7f8Oi21quXOyhx55rA3GrbWw7ghKBI9rF+BU/tB4z4RHuzRVk/aq7DIVPCpi85oxeUu1mTN3V2RK3dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tZWBiia4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8164C4CED0;
	Thu,  2 Jan 2025 09:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735810470;
	bh=oTeU9mTGKrBcXiHvg+Jl3slVbuBrAfkxWQcJ4qdEqJ4=;
	h=From:To:Cc:Subject:Date:From;
	b=tZWBiia4cLy6okdpTT3BGYjab/WoaCKnMB5Vz6Y86mrSXUgm5nS1XFPMYlwQhX8U9
	 cI89Baw8pxyN2XiXAh+/BlN70R3QevZzlCiMIPhcy450iHgX9S8DBPL3QuX2KCOsY+
	 rv3SpWnDsylvEIHAYEOSaQi+XgrHZsOG9E5wcn0dp0Vqaw5pce7TzogICHH4EzY2WF
	 VF3yaU0+1AgDM3YR/6ElDMkZScA9Ay2vVq5e/rxI0Hyo1uEAuDCulPJz/lj+EwV3v/
	 MOMQbD/nW2mZNpPBomPBxkfoM8Qq4wD9hc79fGMSHw9gMVW45ZWtucDqoEY5ergbDK
	 YiweCFQdv+erg==
From: Georgi Djakov <djakov@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	djakov@kernel.org
Subject: [GIT PULL] interconnect fixes for 6.13-rc
Date: Thu,  2 Jan 2025 11:34:04 +0200
Message-Id: <20250102093404.947684-1-djakov@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Greg,

This pull request contains two fixes for the current cycle. The details
are in the signed tag as usual. The patches have been in linux-next for
a few days right before the holidays. Please pull into char-misc-linus
when possible.

Thanks,
Georgi


The following changes since commit 40384c840ea1944d7c5a392e8975ed088ecf0b37:

  Linux 6.13-rc1 (2024-12-01 14:28:56 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-6.13-rc6

for you to fetch changes up to 44c5aa73ccd1e8a738fd011354ee8fb9fcda201a:

  interconnect: icc-clk: check return values of devm_kasprintf() (2024-12-17 14:03:34 +0200)

----------------------------------------------------------------
interconnect fixes for v6.13-rc

This contains two fixes. One fixing a boot error on db410c board when UBSAN
is enabled with clang-19 builds. The other one adds a missing return value
check after devm_kasprintf.

- interconnect: qcom: icc-rpm: Set the count member before accessing the flex array
- interconnect: icc-clk: check return values of devm_kasprintf()

Signed-off-by: Georgi Djakov <djakov@kernel.org>

----------------------------------------------------------------
Bartosz Golaszewski (1):
      interconnect: icc-clk: check return values of devm_kasprintf()

Georgi Djakov (1):
      interconnect: qcom: icc-rpm: Set the count member before accessing the flex array

 drivers/interconnect/icc-clk.c      | 10 ++++++++
 drivers/interconnect/qcom/icc-rpm.c |  2 +-
 2 files changed, 11 insertions(+), 1 deletion(-)

