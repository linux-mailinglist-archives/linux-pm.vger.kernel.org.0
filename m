Return-Path: <linux-pm+bounces-40720-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D65D1854B
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 12:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7B7330E77C7
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 11:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3818838BF71;
	Tue, 13 Jan 2026 11:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="O+sTOvcX"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699E82BE7D6;
	Tue, 13 Jan 2026 11:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768302018; cv=none; b=peooEVlsYPw149boJb6LT5BMbquF5X3JLHP/W4bO3ys+r1cXGcRUgUbwGNXx9kE60Jubl+MI6j178/5ikgVRgAHILDLYPfuRLUwLikj5ep9gA2nfZWaZpY2tzmVY0jK4GqKeiM9oYRhWkYJcCOmHxmzel9T9v6jg9tr8ANDid00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768302018; c=relaxed/simple;
	bh=zucZeLDjTuMkSGcuXiR7OU6C7Qz5H4JCwJizqZNqjEA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rgfdEXFrrLWOpvcsi2J+zllgGWrA4oS9tPX6amUiVEQhm/zOPptaHe1ytmgTAeQQLO7LYKBOIckB5E6zG8EfhBxboUCz14/ofzsU6qU2S+Idy7lWUiIlxqbUxyA8JtLA/u1cB6Py4Cy4CCHINjJsfNyT4quHxA8yYQW6iy9vv9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=O+sTOvcX; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1768302014;
	bh=zucZeLDjTuMkSGcuXiR7OU6C7Qz5H4JCwJizqZNqjEA=;
	h=From:To:Cc:Subject:Date:From;
	b=O+sTOvcXNxPfmpbEaUCfSIkpcIboG/hK/pHBnTLDnMjrCRYwhOzXk9JFBLAKTS/2n
	 od4OD8fnSwgWsSGuY8McAzh8OAVFMAdwSV/rx87RfWa+z776Jcf2ma+6+QvAKbvXrq
	 8vqhSL42zsr7LyzrjvT2WzkNOIhH1YUzplvZyLZMC8f29r7KALtwSkryrIkg310d7C
	 wEe/wc8sBlCwPkgh4KDjcoGBETY96EivwrVUuO1C3d9G672pU1FRbi9s5Z7pw4h/B0
	 lSc7BNLFEiqeUQ0GcYIT1JoT1Ui7CcLhuItFJVlLJyt3fLHRB93vH8xJi2wkZoPVoN
	 P5tbTz7gTHN5Q==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0786317E1523;
	Tue, 13 Jan 2026 12:00:13 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: linux-mediatek@lists.infradead.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	ulf.hansson@linaro.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	kernel@collabora.com
Subject: [PATCH 0/5] Fix dtbs_check warnings for MediaTek MT7622 platform
Date: Tue, 13 Jan 2026 12:00:07 +0100
Message-ID: <20260113110012.36984-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes various dtbs_check warnings happening on the MediaTek
MT7622 Home Router platforms devicetrees.

Depending on correctness, either the bindings or the devicetree was
changed as a dtbs_check warning fix.

AngeloGioacchino Del Regno (5):
  dt-bindings: clock: mediatek,mt7622-pciesys: Remove syscon compatible
  dt-bindings: power: mt7622-power: Add MT7622_POWER_DOMAIN_AUDIO
  pmdomain: mediatek: scpsys: Add MT7622 Audio power domain to legacy
    driver
  arm64: dts: mediatek: mt7622: Add missing clock to audio-controller
  arm64: dts: mediatek: mt7622: Add missing power domain to afe

 .../bindings/clock/mediatek,mt7622-pciesys.yaml        | 10 ++++------
 arch/arm64/boot/dts/mediatek/mt7622.dtsi               |  7 +++++--
 drivers/pmdomain/mediatek/mtk-scpsys.c                 | 10 ++++++++++
 include/dt-bindings/power/mt7622-power.h               |  1 +
 4 files changed, 20 insertions(+), 8 deletions(-)

-- 
2.52.0


