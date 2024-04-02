Return-Path: <linux-pm+bounces-5784-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9202B894A18
	for <lists+linux-pm@lfdr.de>; Tue,  2 Apr 2024 05:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B99F286EE3
	for <lists+linux-pm@lfdr.de>; Tue,  2 Apr 2024 03:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F5F1756A;
	Tue,  2 Apr 2024 03:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="oc00ZDkh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="l7AjR9Oo"
X-Original-To: linux-pm@vger.kernel.org
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F6117C61;
	Tue,  2 Apr 2024 03:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712028872; cv=none; b=C3C2AZMBJEZi0lR1agO9VDmrKXGAv2wiDYozSlGoDTrS4r/5Z4r6Vl+T9GgoeJCSCaqPBC8mROdH2zbEyphQIZQ+Xih8fa/CAacI/XsynBFJqJmPIO0oWhbbCt4TVZimPLaGwLL60Meo4M/ixK+vJBPVmiUstaEeRv4AcYFIZrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712028872; c=relaxed/simple;
	bh=BwJGuKkJlm/KiBlbl/p36YL1ZnrVVIlNiNrusr4VlVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nye7acJaGn3dXEzvHsfmu5/DFVLKPvmT9OyQd1k5QCAz0a1T7fKd7f5EMDtE5N+/2za0bchq8jxLarhknwsZLsaefiiZ3Vpzf+pApuTWCqCegNqGFys+LLWdKgAHbpaz6xD6WbKU2W2dpLLaFeB9k5fPHK5FoF5q5yz/CCB6aoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=oc00ZDkh; dkim=fail (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=l7AjR9Oo reason="signature verification failed"; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id A999E250DB;
	Mon,  1 Apr 2024 23:34:30 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=BwJGuKkJlm/KiBlbl/p36YL1Z
	nrVVIlNiNrusr4VlVE=; b=oc00ZDkhRcPR4xoMkB9eWib2ZiERGayPIxzMmIZD0
	2P4+vKV9zaQ2gpXv8fundx7L+2ImlytlXn6VjBDwwWeUQoOc/5w+4OKyW9C0FJGZ
	Ve53Dj1KbuhoD256K1iDJb6rDZMGR95VCchB0LZhaVqofGUWHytkKYf2fv4VsL5I
	YU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id A20FE250DA;
	Mon,  1 Apr 2024 23:34:30 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=2016-12.pbsmtp; bh=oYdmhye+IyS1lSjTZzFHFlM1bTrQAJxcccMGglzUASg=; b=l7AjR9Oo7ZIrakzGiqHKzWBWHsrUp1I6baYaqZmopAtWUyQhAtkULD3huiOXSG6rtPXN8zPIqHIBWlVMgF9UioNM63NyL+iVcQKh0NA1AnsTwP4gFDuaab+meGVFOnn3FAdL6aDhfz/9ZM0PuD7cav5/XWFjBQU4+VkIxobjy3Y=
Received: from yoda.fluxnic.net (unknown [24.201.101.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C1757250D4;
	Mon,  1 Apr 2024 23:34:24 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id C3C8BC1CED6;
	Mon,  1 Apr 2024 23:27:45 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org
Cc: Nicolas Pitre <npitre@baylibre.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2 12/15] dt-bindings: thermal: mediatek: Add LVTS thermal controller definition for MT8188
Date: Mon,  1 Apr 2024 23:25:46 -0400
Message-ID: <20240402032729.2736685-13-nico@fluxnic.net>
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
 E6D36846-F0A1-11EE-A7F2-F515D2CDFF5E-78420484!pb-smtp20.pobox.com
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
index 433d298826..bf95309d25 100644
--- a/include/dt-bindings/thermal/mediatek,lvts-thermal.h
+++ b/include/dt-bindings/thermal/mediatek,lvts-thermal.h
@@ -26,6 +26,22 @@
 #define MT8186_ADSP		7
 #define MT8186_MFG		8
=20
+#define MT8188_MCU_LITTLE_CPU0	0
+#define MT8188_MCU_LITTLE_CPU1	1
+#define MT8188_MCU_LITTLE_CPU2	2
+#define MT8188_MCU_LITTLE_CPU3	3
+#define MT8188_MCU_BIG_CPU0	4
+#define MT8188_MCU_BIG_CPU1	5
+
+#define MT8188_AP_APU		0
+#define MT8188_AP_GPU1		1
+#define MT8188_AP_GPU2		2
+#define MT8188_AP_SOC1		3
+#define MT8188_AP_SOC2		4
+#define MT8188_AP_SOC3		5
+#define MT8188_AP_CAM1		6
+#define MT8188_AP_CAM2		7
+
 #define MT8195_MCU_BIG_CPU0     0
 #define MT8195_MCU_BIG_CPU1     1
 #define MT8195_MCU_BIG_CPU2     2
--=20
2.44.0


