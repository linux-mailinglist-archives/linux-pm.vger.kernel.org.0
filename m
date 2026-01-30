Return-Path: <linux-pm+bounces-41780-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UOHRBnaofGnuOAIAu9opvQ
	(envelope-from <linux-pm+bounces-41780-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 13:47:50 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2AFDBAA17
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 13:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F1EDD300B5BC
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 12:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE1737E2F1;
	Fri, 30 Jan 2026 12:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jw0jS9YU"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AEA37D113;
	Fri, 30 Jan 2026 12:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769777263; cv=none; b=fu3ORRL+X1Iizyr9YPZmlJuMLrPMRgPK14HPHor+5rKXmAtFXbCTwIW8uYNtb1E4mW/e8kM69tqXBAoQJNyk2SWnWf2gJwZs8w8MPTR/x948M5kFKTMe9w82hWVTKAnDPMSHjerEfYFa5Y2DDFAJI8SqOHXuHwPESaWzw5oMJ88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769777263; c=relaxed/simple;
	bh=SqhcHnm+LGbJ4dJya0W9zSwInwEq2CintOifuZQPts0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b3oIrPJG1GV0kC5AvvGTa6XtldhgLhvaFbBO5HGJH838SBEyZFlT1EdXB8+di9Y73/1BEmmvZSvfVVDf1DHYM4Vef56oDHtEa7AjO0hsHLLbgYtlgEYOPmHA1jbvi0weMZ1Vdvj6hyHqBI2LxLvAjzPOOsVpMnC9pfLn8TWjuq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jw0jS9YU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCE1AC4CEF7;
	Fri, 30 Jan 2026 12:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769777263;
	bh=SqhcHnm+LGbJ4dJya0W9zSwInwEq2CintOifuZQPts0=;
	h=From:To:Cc:Subject:Date:From;
	b=Jw0jS9YUgME9aJae6J7uAKvvQ0xO2IEQ6rDKkPyMFBcPpPfKej0PmL6k+EEOQEF2C
	 UjLeKWI+wR3H5/70K71L1h/TXzrHCExKw3PVROGCHpWiY5agAG2LXfghTgo5OODlff
	 YoLeVih4jl8pK/vX88W/O6jBH7ivRLx7CY1WMihHfonXT8Iquu9TVyTlKGWT5ofNaY
	 ORojCuGotloNNiqnhJKIMvCazSA7piJPIh+OFmMu/043ZbeTlij0dmgz0UTRXh5/t/
	 ehG0H+Lt66wHEgHdpJRMjW/wdAjc3Ylc89NEZ3/ZE4c1ZfJ+8DzYN8mxwtI03YMVuc
	 fHk2dhlwthDRA==
From: Georgi Djakov <djakov@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	djakov@kernel.org
Subject: [GIT PULL] interconnect changes for 6.20
Date: Fri, 30 Jan 2026 14:46:30 +0200
Message-Id: <20260130124630.1279635-1-djakov@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41780-lists,linux-pm=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djakov@kernel.org,linux-pm@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B2AFDBAA17
X-Rspamd-Action: no action

Hello Greg,

This is the pull request with interconnect changes for the v6.20-rc1 merge
window. As always, the summary is in the signed tag.

All patches have been in linux-next for over a week. There are currently
no reported issues. Please pull into char-misc-next when possible.

Thanks,
Georgi


The following changes since commit 8f0b4cce4481fb22653697cced8d0d04027cb1e8:

  Linux 6.19-rc1 (2025-12-14 16:05:07 +1200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-6.20-rc1

for you to fetch changes up to 0e841d1d561376828ea9ecdf7d591f491046924c:

  interconnect: qcom: msm8974: drop duplicated RPM_BUS_{MASTER,SLAVE}_REQ defines (2026-01-22 22:36:31 +0200)

----------------------------------------------------------------
interconnect changes for 6.20

This pull request contains the interconnect changes for the 6.20-rc1
merge window. The core and driver changes are listed below.

Core changes:
- Add KUnit tests for core functionality

Driver changes:
- New driver for MediaTek MT8196 EMI
- MediaTek driver fixes
- Support for Glymur BWMONs
- QCS8300 driver topology fix
- Misc cleanups

Signed-off-by: Georgi Djakov <djakov@kernel.org>

----------------------------------------------------------------
AngeloGioacchino Del Regno (2):
      dt-bindings: interconnect: mt8183-emi: Add support for MT8196 EMI
      interconnect: mediatek: Add support for MediaTek MT8196 EMI ICC

Gabor Juhos (2):
      interconnect: qcom: smd-rpm: drop duplicated QCOM_RPM_SMD_KEY_RATE define
      interconnect: qcom: msm8974: drop duplicated RPM_BUS_{MASTER,SLAVE}_REQ defines

Georgi Djakov (1):
      Merge branch 'icc-mtk' into icc-next

Konrad Dybcio (1):
      dt-bindings: interconnect: qcom,qcs615-rpmh: Drop IPA interconnects

Kuan-Wei Chiu (1):
      interconnect: Add kunit tests for core functionality

Nicolas Frattaroli (2):
      interconnect: mediatek: Don't hijack parent device
      interconnect: mediatek: Aggregate bandwidth with saturating add

Pragnesh Papaniya (1):
      dt-bindings: interconnect: qcom-bwmon: Document Glymur BWMONs

Raviteja Laggyshetty (1):
      interconnect: qcom: qcs8300: fix the num_links for nsp icc node

 .../devicetree/bindings/interconnect/mediatek,mt8183-emi.yaml   |   1 +
 .../devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml    |   1 +
 .../devicetree/bindings/interconnect/qcom,qcs615-rpmh.yaml      |   2 -
 drivers/interconnect/Kconfig                                    |  14 +
 drivers/interconnect/Makefile                                   |   2 +
 drivers/interconnect/icc-kunit.c                                | 324 ++++++
 drivers/interconnect/mediatek/Kconfig                           |   7 +
 drivers/interconnect/mediatek/Makefile                          |   1 +
 drivers/interconnect/mediatek/icc-emi.c                         |   9 +-
 drivers/interconnect/mediatek/mt8196.c                          | 383 ++++++++
 drivers/interconnect/qcom/msm8974.c                             |   3 -
 drivers/interconnect/qcom/qcs8300.c                             |   2 +-
 drivers/interconnect/qcom/smd-rpm.c                             |   1 -
 include/dt-bindings/interconnect/mediatek,mt8196.h              |  48 +
 14 files changed, 788 insertions(+), 10 deletions(-)
 create mode 100644 drivers/interconnect/icc-kunit.c
 create mode 100644 drivers/interconnect/mediatek/mt8196.c
 create mode 100644 include/dt-bindings/interconnect/mediatek,mt8196.h

