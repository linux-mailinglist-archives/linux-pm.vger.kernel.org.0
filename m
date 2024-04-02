Return-Path: <linux-pm+bounces-5769-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE138949E8
	for <lists+linux-pm@lfdr.de>; Tue,  2 Apr 2024 05:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B42FB28711B
	for <lists+linux-pm@lfdr.de>; Tue,  2 Apr 2024 03:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D5C14F65;
	Tue,  2 Apr 2024 03:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BGylCQtc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="xfxowGnN"
X-Original-To: linux-pm@vger.kernel.org
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8210E2C9E;
	Tue,  2 Apr 2024 03:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712028470; cv=none; b=XKlb0UhJ+qWMEzNzboP6ipar5oMeoabH8CknhP8ytiT+JNKujh4YxvVnCtXzymuh4EJTHQb7jssRqgUSFShyN4jjxTsFoAk6a6lFjgtG/Zk1M5pvRJZUTh38xg3RYVZD06V0g9U8MuyLiaYRUZOb3wa9NWqROk6vNJAk88pZg1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712028470; c=relaxed/simple;
	bh=ODM27AWbi/WoPUM8CtduNdu60hE5B64Y6ULqzglTfp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YGCj4mRUbUB9hQbosLI1bXBcQdcmCThj8w3UoKZk4jMcluJlWK84hY2UeWhOa0zPYoDGwU8RpLcHsiO84RbdveSmt0qhM2/IRQXSYau0e1mzjxcxQnmHyvh6l55bYUUsqRllpS2bAjlD1w445+3qVjfkL5bBAKMwsr85X6qPBHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=BGylCQtc; dkim=fail (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=xfxowGnN reason="signature verification failed"; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 572EA1DBD78;
	Mon,  1 Apr 2024 23:27:47 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=ODM27AWbi/WoPUM8CtduNdu60
	hE5B64Y6ULqzglTfp4=; b=BGylCQtcUPq5HrGQyLEhxDCa9a2tDru1g4KyCfJyE
	04KBLK49z/KKwnJG6LuxZPc6hFUBcVCJgDOriv+chJ6Y/tT+hluq9SNzDHi3DIWl
	xoHrRt3t7rtnwNDOOn5/YLO0DNixq1GwW5NuCRlG91PzxlgEVfQT8tDD8zfIVuQe
	2Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4D5761DBD77;
	Mon,  1 Apr 2024 23:27:47 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=2016-12.pbsmtp; bh=ROuDOPudaTnBIpzyth6id2zKJSaeiMGerblNaABRxDo=; b=xfxowGnNIiKzDpZYe0N6McbP2TG7hfRwnLsnI4eugSjK6vV2nY2TY38/mCTHPNLFq2Xv7slmgdE1wHivUGxpXqb4NgxNVS0piqZe6XF2RKxRoqbCejn9nyjGwX2OmeWcJQ97WZ54bbL6nXXPgrVlHNWWA4O7T6cbA8AkRhjrC4Q=
Received: from yoda.fluxnic.net (unknown [24.201.101.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BE77B1DBD76;
	Mon,  1 Apr 2024 23:27:46 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id E7B95C1CECF;
	Mon,  1 Apr 2024 23:27:44 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org
Cc: Nicolas Pitre <npitre@baylibre.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2 06/15] dt-bindings: thermal: mediatek: Add LVTS thermal controller definition for MT8186
Date: Mon,  1 Apr 2024 23:25:40 -0400
Message-ID: <20240402032729.2736685-7-nico@fluxnic.net>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240402032729.2736685-1-nico@fluxnic.net>
References: <20240402032729.2736685-1-nico@fluxnic.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 F9980906-F0A0-11EE-8E76-25B3960A682E-78420484!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

From: Nicolas Pitre <npitre@baylibre.com>

Add LVTS thermal controller definition for MT8186.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
---
 .../bindings/thermal/mediatek,lvts-thermal.yaml        |  2 ++
 include/dt-bindings/thermal/mediatek,lvts-thermal.h    | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/mediatek,lvts-ther=
mal.yaml b/Documentation/devicetree/bindings/thermal/mediatek,lvts-therma=
l.yaml
index e6665af52e..4173bae530 100644
--- a/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yam=
l
+++ b/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yam=
l
@@ -19,6 +19,7 @@ properties:
   compatible:
     enum:
       - mediatek,mt7988-lvts-ap
+      - mediatek,mt8186-lvts
       - mediatek,mt8192-lvts-ap
       - mediatek,mt8192-lvts-mcu
       - mediatek,mt8195-lvts-ap
@@ -75,6 +76,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - mediatek,mt8186-lvts
               - mediatek,mt8195-lvts-ap
               - mediatek,mt8195-lvts-mcu
     then:
diff --git a/include/dt-bindings/thermal/mediatek,lvts-thermal.h b/includ=
e/dt-bindings/thermal/mediatek,lvts-thermal.h
index 997e2f5512..433d298826 100644
--- a/include/dt-bindings/thermal/mediatek,lvts-thermal.h
+++ b/include/dt-bindings/thermal/mediatek,lvts-thermal.h
@@ -16,6 +16,16 @@
 #define MT7988_ETHWARP_0	6
 #define MT7988_ETHWARP_1	7
=20
+#define MT8186_LITTLE_CPU0	0
+#define MT8186_LITTLE_CPU1	1
+#define MT8186_LITTLE_CPU2	2
+#define MT8186_CAM		3
+#define MT8186_BIG_CPU0	4
+#define MT8186_BIG_CPU1	5
+#define MT8186_NNA		6
+#define MT8186_ADSP		7
+#define MT8186_MFG		8
+
 #define MT8195_MCU_BIG_CPU0     0
 #define MT8195_MCU_BIG_CPU1     1
 #define MT8195_MCU_BIG_CPU2     2
--=20
2.44.0


