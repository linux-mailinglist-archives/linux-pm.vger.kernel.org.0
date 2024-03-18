Return-Path: <linux-pm+bounces-5076-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E31B887F205
	for <lists+linux-pm@lfdr.de>; Mon, 18 Mar 2024 22:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 101E31C210C1
	for <lists+linux-pm@lfdr.de>; Mon, 18 Mar 2024 21:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A5F5917B;
	Mon, 18 Mar 2024 21:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ozpoh6Ys";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="a/RBSYa8"
X-Original-To: linux-pm@vger.kernel.org
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF9458AA0;
	Mon, 18 Mar 2024 21:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710797096; cv=none; b=OxcPB1UlLA4EqkosIrKlkF98fJ4n5NuT5z3EBsnDGM1XIYEYRb1ibfjby2dUPa+r5H+dFGUGPgkvOVIeELrjVZjSETsekCLRT1N6YqozVruMHXjzYEB0z5RUH2992/xhcbC2FQkmhDwD92kXjk6/H8RUwV1oEXgL55Gj3LmfJQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710797096; c=relaxed/simple;
	bh=riBa2i2K5aVkfxrVFil1GzpH3/MJZgEvPoRpDmR6jew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TV+fJggQIrcfouo/QvUhZt0sl5z/Y10/JxsSLm9g7PBgtEC4LgtLKdiqXlF3C6Ine07eQxbGU9Y+VQ8gMQAXzfIl2wsKd2Ap+ZV3mRKzaSC8+EvTcUQtZYjb4ddZbhKF+XjHa9+kdfx/OsUAPcfPMj5GuW789tL4RxIY3TABEC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ozpoh6Ys; dkim=fail (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=a/RBSYa8 reason="signature verification failed"; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 309001EA51F;
	Mon, 18 Mar 2024 17:24:54 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=riBa2i2K5aVkfxrVFil1GzpH3
	/MJZgEvPoRpDmR6jew=; b=ozpoh6YsU2Wg/+Cwuee0tvNZL277kGIXf8c/Ga2eO
	klSin18eoybgfrvfdtCvnCkBIJDVd940LRxOMBCTssciltydNNl+X0qosjIWWlGf
	Ab9U33zRhDNIZ36D+xY0uwxpVetlHSwS+TbVbKrO7dgNBeLi9ji88K4PTnHu9q/t
	Gk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 288FC1EA51E;
	Mon, 18 Mar 2024 17:24:54 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=2016-12.pbsmtp; bh=WcTGoIDUaHZ+qNSs8SEiFxxzSk5tmdUFvUu3wByDWpE=; b=a/RBSYa8C5G4UPU4RJuKTdDGyl0hRgqu+O/LlKF8PzbIr82UloRbMPe+2zdqeNzeZ0Tm47NFaXZsWFHGzQxrrm9pL4kmMjyggYFQ7i2avfpZXhW/QX7euaEeBXPPDngPKD5kL9ABwuEYcOvi+AoFGkIR5xOLXx1Az+dnP9ESDrM=
Received: from yoda.fluxnic.net (unknown [24.201.101.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 942491EA51D;
	Mon, 18 Mar 2024 17:24:53 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id CD791BE2BAD;
	Mon, 18 Mar 2024 17:24:50 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org
Cc: Nicolas Pitre <npitre@baylibre.com>
Subject: [PATCH v2 11/13] dt-bindings: thermal: mediatek: Add LVTS thermal controller definition for MT8188
Date: Mon, 18 Mar 2024 17:22:13 -0400
Message-ID: <20240318212428.3843952-12-nico@fluxnic.net>
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
 F5FC9052-E56D-11EE-BA10-25B3960A682E-78420484!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

From: Nicolas Pitre <npitre@baylibre.com>

Add LVTS thermal controller definition for MT8188.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
---
 .../bindings/thermal/mediatek,lvts-thermal.yaml  |  4 ++++
 .../dt-bindings/thermal/mediatek,lvts-thermal.h  | 16 ++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/mediatek,lvts-ther=
mal.yaml b/Documentation/devicetree/bindings/thermal/mediatek,lvts-therma=
l.yaml
index 4173bae530..331cf4e662 100644
--- a/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yam=
l
+++ b/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yam=
l
@@ -20,6 +20,8 @@ properties:
     enum:
       - mediatek,mt7988-lvts-ap
       - mediatek,mt8186-lvts
+      - mediatek,mt8188-lvts-ap
+      - mediatek,mt8188-lvts-mcu
       - mediatek,mt8192-lvts-ap
       - mediatek,mt8192-lvts-mcu
       - mediatek,mt8195-lvts-ap
@@ -61,6 +63,8 @@ allOf:
         compatible:
           contains:
             enum:
+              - mediatek,mt8188-lvts-ap
+              - mediatek,mt8188-lvts-mcu
               - mediatek,mt8192-lvts-ap
               - mediatek,mt8192-lvts-mcu
     then:
diff --git a/include/dt-bindings/thermal/mediatek,lvts-thermal.h b/includ=
e/dt-bindings/thermal/mediatek,lvts-thermal.h
index 3197ca6087..04fa9d7821 100644
--- a/include/dt-bindings/thermal/mediatek,lvts-thermal.h
+++ b/include/dt-bindings/thermal/mediatek,lvts-thermal.h
@@ -26,6 +26,22 @@
 #define MT8186_TS3_1		7
 #define MT8186_TS3_2		8
=20
+#define MT8188_MCU_TS1_0	0
+#define MT8188_MCU_TS1_1	1
+#define MT8188_MCU_TS1_2	2
+#define MT8188_MCU_TS1_3	3
+#define MT8188_MCU_TS2_0	4
+#define MT8188_MCU_TS2_1	5
+
+#define MT8188_AP_TS3_1		0
+#define MT8188_AP_TS4_0		1
+#define MT8188_AP_TS4_1		2
+#define MT8188_AP_TS4_2		3
+#define MT8188_AP_TS5_0		4
+#define MT8188_AP_TS5_1		5
+#define MT8188_AP_TS6_0		6
+#define MT8188_AP_TS6_1		7
+
 #define MT8195_MCU_BIG_CPU0     0
 #define MT8195_MCU_BIG_CPU1     1
 #define MT8195_MCU_BIG_CPU2     2
--=20
2.44.0


