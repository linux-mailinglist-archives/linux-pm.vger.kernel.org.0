Return-Path: <linux-pm+bounces-39891-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDDCCDA384
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 19:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF4B7304D4FB
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 17:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B71347FD1;
	Tue, 23 Dec 2025 17:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="Bq02R1vb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mxout4.routing.net (mxout4.routing.net [134.0.28.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126C81586C2;
	Tue, 23 Dec 2025 17:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766512652; cv=none; b=FZW6+GHrvJe51nuwyUML8EAwBNkVap+Q633I0W4oaFF9HllLzH4u/zeWpAlDGKL5Jbyn+KrofD3bIHXC42uWzjkdUbB7p9wCQikCBr3dQbYxzCz0CjgaTW/jmS1HDRpF6/3cqmCGGQaXdiyUSrmgImjRWOmgOFxc7jPuezTJSAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766512652; c=relaxed/simple;
	bh=ACG7D4SCq7Z8sPAkjNFQ0S/9Q0hbgPbJbIGa4D5BQyU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u3M1TYN7G7s0+cajSdzhO2+trJbU0XKKRXiNsrVaZNQi2Nrk/GRfwpsaHuwWzGXAtSYJBsyUP6jHqsJY48p08D+ocPJDBhqezdaTbZaFabzu6/Vq/2dUpDWWhCXBY+tVlwCP7MJBXq785jHo7WIA7eUlMDBwLzTuivUWfKqPJpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=Bq02R1vb; arc=none smtp.client-ip=134.0.28.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
	by mxout4.routing.net (Postfix) with ESMTP id 752C9100374;
	Tue, 23 Dec 2025 17:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=routing; t=1766512641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nck6W2kcIiP++rumyNfPIr2NPQS0LMMghoE45KMIusU=;
	b=Bq02R1vb4kWrr1miBXc4PF1ul2xhuQPLLZFkF/dpoEXwAnoF3IfbNauyQtg8X/HFiXMi5H
	K+hVXD3ajaDWCUyV5TTAmUWvw6JqTySF3vFoNvM1LWHvlL/6MJaRm86hET22nadesxpXID
	yc2PAhL+a3WgbyorUC5bedBiN4VsIqQ=
Received: from frank-u24.. (fttx-pool-217.61.156.193.bambit.de [217.61.156.193])
	by mxbulk.masterlogin.de (Postfix) with ESMTPSA id 2151D122700;
	Tue, 23 Dec 2025 17:57:21 +0000 (UTC)
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
	Balsam CHIHI <bchihi@baylibre.com>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2 0/2] Add MT7987 Thermal support
Date: Tue, 23 Dec 2025 18:56:25 +0100
Message-ID: <20251223175710.25850-1-linux@fw-web.de>
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

v2:
- dropped non-irq patches
- dropped patch for golden_temp
- moved mt7987 COEFF above mt7988

Frank Wunderlich (2):
  dt-bindings: thermal: mediatek: Add LVTS thermal controller definition
    for MT7987
  thermal/drivers/mediatek/lvts_thermal: Add mt7987 support

 .../thermal/mediatek,lvts-thermal.yaml        |  1 +
 drivers/thermal/mediatek/lvts_thermal.c       | 36 +++++++++++++++++++
 .../thermal/mediatek,lvts-thermal.h           |  3 ++
 3 files changed, 40 insertions(+)

-- 
2.43.0


