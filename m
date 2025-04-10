Return-Path: <linux-pm+bounces-25117-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D6BA84685
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 16:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4279A188C139
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 14:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D97828C5AF;
	Thu, 10 Apr 2025 14:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="VigZi9Q3"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264E5202F71;
	Thu, 10 Apr 2025 14:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744295996; cv=none; b=PEoS4B7Kxr1g2qPbESlT5Xs8tbqwaofDZXHMeR0J78YP6IQ1iuRObQpiXA0ba1/natERrCRRBgzym3CcMjPafhEUwI0AcyjogzCADoEU92KPEm0xk5ALEak9kKvzMoXt6xXcM/g2GeJbLFhyjWePIiorBVj5vwi8HWKAsNboHUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744295996; c=relaxed/simple;
	bh=fQLVhdECukn8rSnKioZ4Hkj2E9G8FUbxvYOvve74Sbs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r0iyIsN2gXU9MIM/H2vBeKBj8ZkCUWlxabFZjeBRSaxGB/wb3BklDBYa9iVgQkCgHgPo9gQ6qKhE0duKDo3YxVPrhlDumUEgNKcsEC+qqp3fRznaG4nD7h3Oudnj8HmrSijnljAWFMwgM/oCmF9RvgtX+kH9inYSPoX131z9cYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=VigZi9Q3; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1744295991;
	bh=fQLVhdECukn8rSnKioZ4Hkj2E9G8FUbxvYOvve74Sbs=;
	h=From:To:Cc:Subject:Date:From;
	b=VigZi9Q3jBLWJn/fh7ChGoQpxIboSo65/aQK+G92HSh1pXJOHrqIubrpp7ZHmmbPP
	 7YtePeEWQEEKjF5mCuxMxJ7gYFqFJZERKXFCbZ3gZJnG27++i5b2529uaOEFLO7lLL
	 22fleaCt56LcgyVFNgYRS5ZhN8CSs/6G0AWi6EjSfkU40VldYIqdY1sp9iH/sqk7GE
	 m7bWh94XZUXnwS/FVTWZ9T0FmDEyltm2/Fs0dEaZiU9aLUIpCt7twD7hNrESYnAzpI
	 t6AhmZFJrvZ/zPG83MM7m8uT4S+9qPUxxPKf70IqNNtAv8rD2VQzLHrdvJkSbQYxpx
	 PG6EKR/5yMVMw==
Received: from IcarusMOD.eternityproject.eu (fi-19-199-243.service.infuturo.it [151.19.199.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 64F0317E0C8D;
	Thu, 10 Apr 2025 16:39:48 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: robh@kernel.org
Cc: krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ulf.hansson@linaro.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	fshao@chromium.org,
	y.oudjana@protonmail.com,
	wenst@chromium.org,
	lihongbo22@huawei.com,
	mandyjh.liu@mediatek.com,
	mbrugger@suse.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH v1 0/3] MediaTek Dimensity 1200 - Add Power Domains support
Date: Thu, 10 Apr 2025 16:39:41 +0200
Message-ID: <20250410143944.475773-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for adding basic support for the OnePlus Nord 2 5G
DN2103 smartphone, this series adds support for the power domains
(MTCMOS) of the MediaTek Dimensity 1200 (MT6893) SoC.

AngeloGioacchino Del Regno (3):
  dt-bindings: power: mediatek: Support Dimensity 1200 MT6893 MTCMOS
  pmdomain: mediatek: Bump maximum bus protect data array elements
  pmdomain: mediatek: Add support for Dimensity 1200 MT6893

 .../power/mediatek,power-controller.yaml      |   2 +
 drivers/pmdomain/mediatek/mt6893-pm-domains.h | 585 ++++++++++++++++++
 drivers/pmdomain/mediatek/mtk-pm-domains.c    |   5 +
 drivers/pmdomain/mediatek/mtk-pm-domains.h    |   2 +-
 .../dt-bindings/power/mediatek,mt6893-power.h |  35 ++
 5 files changed, 628 insertions(+), 1 deletion(-)
 create mode 100644 drivers/pmdomain/mediatek/mt6893-pm-domains.h
 create mode 100644 include/dt-bindings/power/mediatek,mt6893-power.h

-- 
2.49.0


