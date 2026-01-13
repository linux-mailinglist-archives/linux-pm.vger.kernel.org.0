Return-Path: <linux-pm+bounces-40714-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F60DD18533
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 12:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 62E303041CD8
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 11:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C44346AFA;
	Tue, 13 Jan 2026 11:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="MzDKhcrD"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EBA311C2A;
	Tue, 13 Jan 2026 11:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768302013; cv=none; b=q1aRI+ls042/zg99ieTdfXWhPuHIIRAUmAcLQ4mnIhF1Ix5FXJBtnfgNHSc9KNNxsK0W1qdTIQDz+Ia/DAU//Cm1bONaOWDkbrt9O76fwwNYWqTYPYhQCA/YTNlXqqF7KihoSb7BkJ2uSBcDctDTaYV/LVU/icWoTg0BLpn+EQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768302013; c=relaxed/simple;
	bh=WSc8pifyA45PXjMypwWXQ0wi4toOFAjaSOf8+Y4VN5c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=em6F0yIVP6blsQ5LF2yz8ZJlRfe/KfGJPurCLnqXysRLjxyhrVdtkx8Crfc6EfdxXof+U0PRQvQvO6GpGSi+jJbiEj5TVuo8EtpkMxnJwL4LXz+25R1PhrKslK9+KWGpRT4GMhcVZiE8fwYkjRb5rBuithkBMqmQRO0YSOOgNyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=MzDKhcrD; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1768302005;
	bh=WSc8pifyA45PXjMypwWXQ0wi4toOFAjaSOf8+Y4VN5c=;
	h=From:To:Cc:Subject:Date:From;
	b=MzDKhcrDFN98q6o3nJGgRTX4ntmBZcIwZraHvVgLIrY+BvVqJ4FfvJ8Sa94RDvfQU
	 6jOFCVY2w8WWOZ986pJnXjxDTCgu/E9pcwaMxP+rvu4bqPahPweO4ZL1C9v8JIzzEh
	 IgsXIkyUu8xu7PCyn4Z+0d1vcaynB+g0/fStQ1L1pERjGBBB2om3Zcsp52LJ6mlg+E
	 ffAYZdsFbMCAZZb+kyMDFHpDQbRhts6Vgerr5faRwExJTq55EMRs7AhxVu/Dk0gQRq
	 WK8xFP8+7Gz5XXzeMhSHbq6b+RXpUKHJ6rV6gUZL+Vo8NGisL71hfK0UTGATdPdHCB
	 RWCvtLQX50B/Q==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9088217E10C8;
	Tue, 13 Jan 2026 12:00:04 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: linux-mediatek@lists.infradead.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	sen.chu@mediatek.com,
	sean.wang@mediatek.com,
	macpaul.lin@mediatek.com,
	lee@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH 0/6] Fix dtbs_check warnings for MediaTek Helio X10 platform
Date: Tue, 13 Jan 2026 11:59:54 +0100
Message-ID: <20260113110000.36953-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes various dtbs_check warnings happening on the MediaTek
Helio X10 platform devicetrees.

Depending on correctness, either the bindings or the devicetree was
changed as a dtbs_check warning fix.

AngeloGioacchino Del Regno (6):
  dt-bindings: mfd: mediatek,mt8195-scpsys: Add mediatek,mt6795-scpsys
  dt-bindings: mfd: mediatek: mt6397: Add missing MT6331 regulator
    compat
  dt-bindings: regulator: mediatek,mt6331: Add missing ldo-vio28 vreg
  arm64: dts: mediatek: mt6331: Fix VCAM IO regulator name
  arm64: dts: mediatek: mt6795: Fix issues in SCPSYS node
  arm64: dts: mediatek: mt6795-xperia-m5: Rename PMIC leds node

 Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml    | 1 +
 .../devicetree/bindings/mfd/mediatek,mt8195-scpsys.yaml       | 1 +
 .../bindings/regulator/mediatek,mt6331-regulator.yaml         | 4 ++--
 arch/arm64/boot/dts/mediatek/mt6331.dtsi                      | 2 +-
 arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts        | 2 +-
 arch/arm64/boot/dts/mediatek/mt6795.dtsi                      | 3 +--
 6 files changed, 7 insertions(+), 6 deletions(-)

-- 
2.52.0


