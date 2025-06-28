Return-Path: <linux-pm+bounces-29790-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D88EAECAAE
	for <lists+linux-pm@lfdr.de>; Sun, 29 Jun 2025 00:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71D8117348B
	for <lists+linux-pm@lfdr.de>; Sat, 28 Jun 2025 22:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68BCC2441B8;
	Sat, 28 Jun 2025 22:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="DA4EkO1k"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC5B227E9B
	for <linux-pm@vger.kernel.org>; Sat, 28 Jun 2025 22:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751150339; cv=none; b=UV/o4T59VDbYL2VorAZVYrgBPykz6zBGOtn1xp2c10HuALq8c/73HD58c4jCjMbYe4fL95AJsA7Au0b96Y6fnp2cuxFH1uqR0u4Zi68UjfXZ8DsAq6zYfbxjoFUVcyQZoTetXMCcyNoQXMxYOlVtTDF+/m4QOd+nMfRD/8qDgc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751150339; c=relaxed/simple;
	bh=DgGr4XC6BtQAmRfjLMb66i8MKOj0SqYngC4BMS74CPs=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lWBLC2FR/kNl/G4m6t4SQ4acs8seSXu+x8T2MfHGdIdd572X7HcASEHVNC03G9RDbllIIExEHmdUAoYH2b2rh5HEafc9pLZechY0agTiYnDX94pRo1HsK5zHxjIkGFt5LM3jMMBkBd34Pr9SZipKFznYwzw99cIBtSzmNTZE9Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=DA4EkO1k; arc=none smtp.client-ip=212.77.101.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 31775 invoked from network); 29 Jun 2025 00:38:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1751150330; bh=PLFZP/c9fNvh8aFmRu8dwrDO4a59iqD2hrb5gF14geE=;
          h=From:To:Subject;
          b=DA4EkO1km60TxTqeraujBDCqDogUVqwBDW2gBzfS1/Ql17TfWYvX3NRrSTg632jPr
           KRonXKDXCv7MhYi0BwjNpjoSs4DumxQV1TglAgLsh5xFARZbFkEiGrOPvxsCjN0cd1
           D3jBp++nicZwmEJdUarKweJAw8vq4MtasIy4WUMA3pqqFdADD3be4nmj7RBW0KEof7
           iQ27EiYbdton953KwsGw2UHMQx0KNueCnN0aNcXxCUJyChlEhSK1B7PiMovmbHVipL
           xKsOb3ULAMmc2szMwdNtvPxZBs2M3VVp1aU+kmDCKJiKQC0HEjND19uE9dh65AfNkB
           hKD3oZItvq5hA==
Received: from 83.24.145.121.ipv4.supernova.orange.pl (HELO laptop-olek.lan) (olek2@wp.pl@[83.24.145.121])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <rafael@kernel.org>; 29 Jun 2025 00:38:50 +0200
From: Aleksander Jan Bajkowski <olek2@wp.pl>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	olek2@wp.pl,
	zhiyong.tao@mediatek.com,
	linux-pm@vger.kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 3/3] dt-bindings: iio: adc: Add support for MT7981
Date: Sun, 29 Jun 2025 00:38:37 +0200
Message-Id: <20250628223837.848244-4-olek2@wp.pl>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250628223837.848244-1-olek2@wp.pl>
References: <20250628223837.848244-1-olek2@wp.pl>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-MailID: e666d4a039fb80211d7087c5597d3d6c
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [IZMh]                               

The temperature sensor in the MT7981 is same as in the MT7986.
Add compatible string for mt7981.

Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
---
 .../devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml      | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml b/Documentation/devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml
index b489c984c1bb..ceb914dde15b 100644
--- a/Documentation/devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml
@@ -26,6 +26,7 @@ properties:
           - mediatek,mt2712-auxadc
           - mediatek,mt6765-auxadc
           - mediatek,mt7622-auxadc
+          - mediatek,mt7981-auxadc
           - mediatek,mt7986-auxadc
           - mediatek,mt8173-auxadc
       - items:
-- 
2.39.5


