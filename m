Return-Path: <linux-pm+bounces-5081-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2D287F210
	for <lists+linux-pm@lfdr.de>; Mon, 18 Mar 2024 22:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6E251F227F8
	for <lists+linux-pm@lfdr.de>; Mon, 18 Mar 2024 21:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511495A4C4;
	Mon, 18 Mar 2024 21:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bLz6XzrB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="nUreU5t+"
X-Original-To: linux-pm@vger.kernel.org
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90165A0F4;
	Mon, 18 Mar 2024 21:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710797100; cv=none; b=t6erQE8z6ANHZl+vsVmu8QF1Vplcqe9CBgqzTheKqUhrdQgInlHpYHf5VtavImPHyQcGkIYZZmNaI4AShlGUh4gcHavKOGKXMrsiaBa0f9/Ri3hHXK1PQVY2Y9AbjIn5OUe8JWm0ZuOLRSxUF6lj+0VzQq8gZBIOX30YU3buKcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710797100; c=relaxed/simple;
	bh=BzYO/BRS3nuGVE4aH0ME/K3s0oCcWv61BiLYxgyBbSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dab6GJ2LG/S9YofGzpAJGROv3XgJu/DOnPgkXBH7HEj6xVrOSc6vIeVvvksV4TauVY2+XOvEYmwlAJ9330qpNStekJD7cfKHvTgMcOOaeayCqvims93C+P25krIr0PF1sxCAmXYs6FHLWIY2BhaKYVB4AEvQDy8HH87PCnqRzlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=bLz6XzrB; dkim=fail (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=nUreU5t+ reason="signature verification failed"; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 4A6D6234E3;
	Mon, 18 Mar 2024 17:24:58 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=BzYO/BRS3nuGVE4aH0ME/K3s0
	oCcWv61BiLYxgyBbSI=; b=bLz6XzrBvWOKnfh1CTfz4wL5cmurkTOKfDfcoGT7g
	pGu4qzwWlxOn6U+cu5rSwQt5WEZlYaAR0Nri9DNZbfdvxPG08y8Niit0WpbukkDg
	NTDGBdgO8gATYkBPK9fi5qqUUpmrQbHTtw26nVVJVa6mN0M2hW2mIMBmVq5NCZiV
	t0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 42604234E2;
	Mon, 18 Mar 2024 17:24:58 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=2016-12.pbsmtp; bh=yy9ZBV3bBYtehfvMt0pa7NKX6qI0enPfmDme0BevxTE=; b=nUreU5t+9CBRltMImmOCS9WyaAvl3hLNlBB60U334bN1T6UX/7Gjzrw61TH43wv8sfg32bs1F+lfy22WiUrxfSCtLmdolBzTalUN/iJTTxriOFWkAuMyIRFPc6vbwyhDiJ7XJSx/ZMmUbapB+Fa/PU6be6PPGnC3CojLLa+f1Xk=
Received: from yoda.fluxnic.net (unknown [24.201.101.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5B5DB234DB;
	Mon, 18 Mar 2024 17:24:53 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 3D0E0BE2BA5;
	Mon, 18 Mar 2024 17:24:50 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org
Cc: Nicolas Pitre <npitre@baylibre.com>
Subject: [PATCH v2 05/13] dt-bindings: thermal: mediatek: Add LVTS thermal controller definition for MT8186
Date: Mon, 18 Mar 2024 17:22:07 -0400
Message-ID: <20240318212428.3843952-6-nico@fluxnic.net>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240318212428.3843952-1-nico@fluxnic.net>
References: <20240318212428.3843952-1-nico@fluxnic.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 F5D91C6C-E56D-11EE-9EF6-F515D2CDFF5E-78420484!pb-smtp20.pobox.com
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
index 997e2f5512..3197ca6087 100644
--- a/include/dt-bindings/thermal/mediatek,lvts-thermal.h
+++ b/include/dt-bindings/thermal/mediatek,lvts-thermal.h
@@ -16,6 +16,16 @@
 #define MT7988_ETHWARP_0	6
 #define MT7988_ETHWARP_1	7
=20
+#define MT8186_TS1_0		0
+#define MT8186_TS1_1		1
+#define MT8186_TS1_2		2
+#define MT8186_TS1_3		3
+#define MT8186_TS2_0		4
+#define MT8186_TS2_1		5
+#define MT8186_TS3_0		6
+#define MT8186_TS3_1		7
+#define MT8186_TS3_2		8
+
 #define MT8195_MCU_BIG_CPU0     0
 #define MT8195_MCU_BIG_CPU1     1
 #define MT8195_MCU_BIG_CPU2     2
--=20
2.44.0


