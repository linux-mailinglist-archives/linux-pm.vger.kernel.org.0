Return-Path: <linux-pm+bounces-13799-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8412A96F8AD
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 17:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B08951C22022
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 15:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3F51D2F65;
	Fri,  6 Sep 2024 15:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DO+3czJj"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CDC374F1;
	Fri,  6 Sep 2024 15:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725637965; cv=none; b=dYhog7buxCfzFXW2YE9xG1br5QS3k7Kopkn5P+eTajYPZidhfm71LQvOMRvCjy32jYhZq6rgy6HM0yHC/dwqAxz03NUVKdMuLCr/++GwlCrEOA+AQfeug8IlgTc1Eijrrq6u6Bq5yi2oD9kl4VqUJFXckhw/Ge3E1mZjFoL9r5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725637965; c=relaxed/simple;
	bh=8AR/kEPf0FAuH4RNYD8pbMauexDRH29Di8tE7w4W2VY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hrcrIu+Jx99+0MqtXO75//uotNvqKH09fhsiWUq5OlJSeD6QJrOe38WrLW4KIuiGyMIdrLpE4e+yhKGKhQFGfLCs7XXRZq7SFKD3cCJerVQuo7oZ4tLO9IrAWEYHafrvUUThTw0e5M5X+IH+t8c2PcQzpPpcVR07udWAHFV+dic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DO+3czJj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7377FC4CEC4;
	Fri,  6 Sep 2024 15:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725637964;
	bh=8AR/kEPf0FAuH4RNYD8pbMauexDRH29Di8tE7w4W2VY=;
	h=From:To:Cc:Subject:Date:From;
	b=DO+3czJjfS30WPnAz5jpXkF6F2ADs1Imkec3ck9TjgqPJLTLqJ8PXc2JHRoA5FAkF
	 Cd4TSBjHfZv8AUJeCxNbFSh6FOPPzXJjI9DSO8DiCH+zin4oTr/X8C9ZWa+J8abdyW
	 vFpyvRdg0rLZdxouj/LMv+xpBKTPvWArLvnpOuw4ximJsAbfJQEQ1VewZLkeibUyiz
	 Z3HqB/pJ8YEvJoLD3nuEju0AhktAnYS5wVh3dcG6e2v2BKC9mfA6n41cNoNKVzvmfI
	 FFZPvnYhpIUpPOtlGd97aGWmQPBtiGybrOhzXCd/Ds10j1Wd6keDooNMtMR9u2DUOZ
	 kMHnd3eNr9O2Q==
From: Georgi Djakov <djakov@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	djakov@kernel.org
Subject: [GIT PULL] interconnect changes for 6.12
Date: Fri,  6 Sep 2024 18:52:27 +0300
Message-Id: <20240906155227.310250-1-djakov@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Greg,

This is the pull request with interconnect changes for the v6.12-rc1 merge
window. It contains some new drivers, fixes and clean-ups. As always, the
summary is in the signed tag.

All patches have been in linux-next for almost two weeks. There are no
reported issues. Please pull into char-misc-next when you get a chance.

Thanks,
Georgi

The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-6.12-rc1

for you to fetch changes up to a5733950fe35d56a935257995d8093a3b4867f61:

  Merge branch 'icc-sm8350' into icc-next (2024-08-26 01:36:44 +0300)

----------------------------------------------------------------
interconnect changes for 6.12

This pull request contains the interconnect changes for the 6.12-rc1 merge
window. It contains new drivers and fixes with the following highlights:

Driver changes:
- New driver for MSM8976 platforms
- New driver for MSM8937 platforms
- Enable sync_state for SM8250 platforms
- Enable QoS support for QCS404
- Add ab_coeff bandwidth adjustments for MSM8953
- Drop the unsupported yet DISP nodes on SM8350 platforms
- Fix missed num_nodes initialization in icc-clk driver
- Misc DT and documentation fixes

Signed-off-by: Georgi Djakov <djakov@kernel.org>

----------------------------------------------------------------
Adam Skladowski (9):
      dt-bindings: interconnect: qcom: Add Qualcomm MSM8976 NoC
      interconnect: qcom: Add MSM8976 interconnect provider driver
      dt-bindings: interconnect: qcom: Add Qualcomm MSM8937 NoC
      interconnect: qcom: Add MSM8937 interconnect provider driver
      interconnect: qcom: qcs404: Mark AP-owned nodes as such
      interconnect: qcom: qcs404: Add regmaps and more bus descriptions
      dt-bindings: interconnect: qcom: msm8939: Fix example
      interconnect: qcom: msm8953: Add ab_coeff
      dt-bindings: interconnect: qcom: msm8953: Fix 'See also' in description

Dmitry Baryshkov (3):
      interconnect: qcom: sm8350: drop DISP nodes
      dt-bindings: interconnect: qcom,sm8350: drop DISP nodes
      interconnect: qcom: sm8250: Enable sync_state

Georgi Djakov (3):
      dt-bindings: interconnect: qcom: Do not require reg for sc8180x virt NoCs
      Merge branch 'icc-misc' into icc-next
      Merge branch 'icc-sm8350' into icc-next

Kees Cook (1):
      interconnect: icc-clk: Add missed num_nodes initialization

Rayyan Ansari (1):
      dt-bindings: interconnect: qcom,rpmh: correct sm8150 camnoc

Tengfei Fan (1):
      dt-bindings: interconnect: qcom-bwmon: Document SA8775p bwmon compatibles

 .../devicetree/bindings/interconnect/qcom,msm8939.yaml         |   25 +-
 .../devicetree/bindings/interconnect/qcom,msm8953.yaml         |    3 +-
 .../devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml   |    2 +
 Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml  |    5 +-
 drivers/interconnect/icc-clk.c                                 |    3 +-
 drivers/interconnect/qcom/Kconfig                              |   18 +
 drivers/interconnect/qcom/Makefile                             |    4 +
 drivers/interconnect/qcom/msm8937.c                            | 1350 +++++++
 drivers/interconnect/qcom/msm8953.c                            |    2 +
 drivers/interconnect/qcom/msm8976.c                            | 1440 ++++++++
 drivers/interconnect/qcom/qcs404.c                             |  127 +-
 drivers/interconnect/qcom/sm8350.c                             |  155 +-
 drivers/interconnect/qcom/sm8350.h                             |   10 -
 include/dt-bindings/interconnect/qcom,msm8937.h                |   93 +
 include/dt-bindings/interconnect/qcom,msm8976.h                |   97 +
 include/dt-bindings/interconnect/qcom,sm8350.h                 |   10 -
 16 files changed, 3151 insertions(+), 193 deletions(-)
 create mode 100644 drivers/interconnect/qcom/msm8937.c
 create mode 100644 drivers/interconnect/qcom/msm8976.c
 create mode 100644 include/dt-bindings/interconnect/qcom,msm8937.h
 create mode 100644 include/dt-bindings/interconnect/qcom,msm8976.h

