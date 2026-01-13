Return-Path: <linux-pm+bounces-40721-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB100D1857E
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 12:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8DD9A30E5A54
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 11:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E0138E101;
	Tue, 13 Jan 2026 11:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kXBcjMT+"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AB238B9B8;
	Tue, 13 Jan 2026 11:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768302019; cv=none; b=DMuHlAlvU4nRYfEi4QWEgg2t+NmQWi9awCEZjom7i81uaSNBNaUk4/I9HOpxzgDV6CugNS46rl5ERJaKbK7VqJ8Cmj2VxAxzIwGUT5s0OrEZGVb7hFUiYHhF+IVOnfwk9eUjf/EqNnk1Wul8G6zDBJyjPtKkitrc4Dt0lL9l/2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768302019; c=relaxed/simple;
	bh=Axhq3LGTNbxz4u+KRkYjN6yjn7G1wJmLGxtKUA3MjMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kDifQBnBNl62pf3r2cu7lOa0JMa4TRjW7dAiC9OypMoEEjIFNhsXoQQO3cRs28MXdKQnOK+oHZf/Bh9kVVbBkZ+H+CYTIIsS63wgEdZCeNmdUuk8R+q23wGDArF1dDR8oP4ljMPgJtc2d8bAyC3qQ+bdJuvQ3Bvbpm8iJo91430=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=kXBcjMT+; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1768302008;
	bh=Axhq3LGTNbxz4u+KRkYjN6yjn7G1wJmLGxtKUA3MjMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kXBcjMT+Qy+GOdNm65k2fMfkmAy7vsKYxmzjLYrfYwHurGZdIXaOWk9y4G31lNXiD
	 OgrPiaJ60CaNmJDXvJd29vxcnihWw/cTH/Re0zTGwnXW4f41d5pSAno5rtXO+OI1jm
	 iwQEQ0HiBjyNhMIT56q1WC0igCkR0aDWkxRLJsByTzgiqDt/VicjK6bviHQsEHtXlP
	 obOgbaBIuZRr1ESlNPaojyT/xa1mjBAO/X40zNLQTGLPYDEVgN++XPpFwuq3emP7f+
	 qWgu88O3ZS3bA37/pQCXOnUpEh79K+TIjacQ3MkPPl3daUvOxd4TabLqsENFFXgC0u
	 kpvj28Zwpmp8Q==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id EC5F917E150E;
	Tue, 13 Jan 2026 12:00:07 +0100 (CET)
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
Subject: [PATCH 4/6] arm64: dts: mediatek: mt6331: Fix VCAM IO regulator name
Date: Tue, 13 Jan 2026 11:59:58 +0100
Message-ID: <20260113110000.36953-5-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260113110000.36953-1-angelogioacchino.delregno@collabora.com>
References: <20260113110000.36953-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ldo-vcamio regulator is named "vcam_io", however, the binding
only allows "vcamio" as name: change it to the latter to resolve
a dtbs_check warning.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt6331.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt6331.dtsi b/arch/arm64/boot/dts/mediatek/mt6331.dtsi
index 243afbffa21f..7e7b96e8ca6f 100644
--- a/arch/arm64/boot/dts/mediatek/mt6331.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt6331.dtsi
@@ -217,7 +217,7 @@ mt6331_vusb10_reg: ldo-vusb10 {
 			};
 
 			mt6331_vcamio_reg: ldo-vcamio {
-				regulator-name = "vcam_io";
+				regulator-name = "vcamio";
 				regulator-min-microvolt = <1200000>;
 				regulator-max-microvolt = <1800000>;
 				regulator-ramp-delay = <0>;
-- 
2.52.0


