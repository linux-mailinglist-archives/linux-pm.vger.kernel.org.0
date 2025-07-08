Return-Path: <linux-pm+bounces-30411-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2418AAFDA6E
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 00:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA7F51AA0B72
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 22:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CCC72459F9;
	Tue,  8 Jul 2025 22:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="pJH5xRvb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94ACB22DF9E
	for <linux-pm@vger.kernel.org>; Tue,  8 Jul 2025 22:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752012258; cv=none; b=MZPgmgoG0EEmAV+nnVL/eWbTko31jg0lhDzTdQE/SSK9JLoJ8ou7n2dLgezXp414BmFuvytqAjEBgO6StgK1Z2fhTuFKV3/s0+t57YEnymyhMc2l50qogHKaJ3fUdabezXs240ztN4EBDYccmiKaqfgE49QRlLXdddNBb0xRzqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752012258; c=relaxed/simple;
	bh=U/sQJl4VCFSfLh2tQHSg0A041HPUvYXEaEMHPB5CGD8=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WO1blntXRcqTK5xrWemHd11vr9W5saf7hAs5DYcSvFfusT6Ah8I1lrTGBErtbsXSydN0JYaGUfI3BqY897F518282t2zoFLt7NUKxhrkfvCrColrWXNT8B4KcwkAlfLzbgfKbuW8PolhMBOab9oW9yvMDCnr/bwrLLbkrx8X6fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=pJH5xRvb; arc=none smtp.client-ip=212.77.101.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 8392 invoked from network); 9 Jul 2025 00:04:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1752012249; bh=EGN6DJCTkVUIAy2RF65sa0W+Q97U2Qgd30M42gFEzGQ=;
          h=From:To:Subject;
          b=pJH5xRvb2jZHL44s2wXktgXk+Klty8X/N7+60VeilV7PqgQmpOpFoBDIRskisQYy/
           kpGbeqdfjUUeDb0vm/SFn1TUqKBKe78Yc6hj8N72gvXIC52Pv7P+hEX9zU3WBBvU1H
           bpnuXapHq5ybtCzRmcYY9dVtnvicflsvILIwpfX+cJzCv4Q/NycEgMDVrupWvIMSqa
           AfU1xdHmaWMVoYNR0vO46nz/C+tVFvH7OilCwJXfsWFUgNvJhlElouq85JE2fk4+vi
           H5rPuL/fmJVW2+rkM0pTL0gEzCq4DKQa4efNi1uL43Bg0dUcWPi2NnOyF7UIq1ycB8
           Am5DYDgg77DBA==
Received: from 83.24.138.239.ipv4.supernova.orange.pl (HELO laptop-olek.lan) (olek2@wp.pl@[83.24.138.239])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <rafael@kernel.org>; 9 Jul 2025 00:04:09 +0200
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
	s.hauer@pengutronix.de,
	olek2@wp.pl,
	zhiyong.tao@mediatek.com,
	linux-pm@vger.kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v3 1/3] dt-bindings: iio: adc: Add support for MT7981
Date: Wed,  9 Jul 2025 00:04:03 +0200
Message-Id: <20250708220405.1072393-2-olek2@wp.pl>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250708220405.1072393-1-olek2@wp.pl>
References: <20250708220405.1072393-1-olek2@wp.pl>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-MailID: 5152ad29fb8f55b57847c266456bbc96
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [8SPB]                               

The temperature sensor in the MT7981 is same as in the MT7986.
Add compatible string for mt7981.

Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
---
 .../devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml   | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml b/Documentation/devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml
index b489c984c1bb..14363389f30a 100644
--- a/Documentation/devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml
@@ -32,6 +32,10 @@ properties:
           - enum:
               - mediatek,mt7623-auxadc
           - const: mediatek,mt2701-auxadc
+      - items:
+          - enum:
+              - mediatek,mt7981-auxadc
+          - const: mediatek,mt7986-auxadc
       - items:
           - enum:
               - mediatek,mt6893-auxadc
-- 
2.39.5


