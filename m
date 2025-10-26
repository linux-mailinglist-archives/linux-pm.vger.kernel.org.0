Return-Path: <linux-pm+bounces-36839-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87CEFC0A709
	for <lists+linux-pm@lfdr.de>; Sun, 26 Oct 2025 13:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 478E43AC8CD
	for <lists+linux-pm@lfdr.de>; Sun, 26 Oct 2025 12:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA0024466C;
	Sun, 26 Oct 2025 12:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="Id9AfSYA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mxout4.routing.net (mxout4.routing.net [134.0.28.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE8B215075;
	Sun, 26 Oct 2025 12:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761481763; cv=none; b=sxYp5RvLwnrJQUeQ7hpYU6zekKS6Z63AQ9HLBPJUNdymk7ddLdoD8UYaRWqbgQE2Nf7rjiQCrSUoN8HgnNitulUnMqsnEyw6SJz8pnVa7vezP9/ewx3ng2knPrO5DjmIUrf8Abmyjdx7PiTPmgxudgSjImAXSCN3qZKgpVKqQmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761481763; c=relaxed/simple;
	bh=1CueByyOn2jYWsMAY9FseSTU9JmKPZICHFQbNAZRxW4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pqyn+xZfxmV8+kzfEqZ8FtVATbEpUY/ViZOmwFRnmF7EByVk9ml+oAWvYZsk9w72QYkurpkk9oniUWkb9N4lFjCIwBE/njigCUdx2FtmAMgKiQbbN3xIG207sfRSVafHGQR5T4cVDsBM7QHGxyw4rRFvuoXL45mPm3aocwXJBRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=Id9AfSYA; arc=none smtp.client-ip=134.0.28.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
	by mxout4.routing.net (Postfix) with ESMTP id AF8551009AF;
	Sun, 26 Oct 2025 12:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=routing; t=1761481324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=J+oIT4ZSlvcfRBxWrhMbinuOO7yYO/gbdfjRoPL1coY=;
	b=Id9AfSYAhE7BUezRgygKn+cTdeMOS9iccD0ng4R2WApmSTYJzCCbI8sBEueLCgAiyhfc/u
	dYrXxb+B+75Ubd5pw4LPbgDBLXKAasM6sWSf8sJ48OLHS1xU5gBUxbuuhuY+S8rOE3To8t
	GqlEZnhmeVB57YcfTr0Vj+DtPs1pZOA=
Received: from frank-u24.. (fttx-pool-217.61.154.70.bambit.de [217.61.154.70])
	by mxbulk.masterlogin.de (Postfix) with ESMTPSA id 60B4D1226BC;
	Sun, 26 Oct 2025 12:22:04 +0000 (UTC)
From: Frank Wunderlich <linux@fw-web.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Frank Wunderlich <frank-w@public-files.de>,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	Mason Chang <mason-cw.chang@mediatek.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Balsam CHIHI <bchihi@baylibre.com>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v1 0/5] Add MT7987 Thermal support
Date: Sun, 26 Oct 2025 13:21:29 +0100
Message-ID: <20251026122143.71100-1-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Wunderlich <frank-w@public-files.de>

This series adds Thermal support for MT7987.

Frank Wunderlich (5):
  dt-bindings: thermal: mediatek: make interrupt only required for
    current SoCs
  dt-bindings: thermal: mediatek: Add LVTS thermal controller definition
    for MT7987
  thermal/drivers/mediatek/lvts_thermal: Add no-irq-mode for mt7987
  thermal/drivers/mediatek/lvts_thermal: Add SoC based golden Temp
  thermal/drivers/mediatek/lvts_thermal: Add mt7987 support

 .../thermal/mediatek,lvts-thermal.yaml        |  18 +++-
 drivers/thermal/mediatek/lvts_thermal.c       | 102 ++++++++++++++++--
 .../thermal/mediatek,lvts-thermal.h           |   3 +
 3 files changed, 111 insertions(+), 12 deletions(-)

-- 
2.43.0


