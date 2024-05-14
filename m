Return-Path: <linux-pm+bounces-7807-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B16288C4F5A
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 12:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E38761C21148
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 10:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAED485636;
	Tue, 14 May 2024 10:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Wj3vuv8E";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CN1hBXbz"
X-Original-To: linux-pm@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405F584A37
	for <linux-pm@vger.kernel.org>; Tue, 14 May 2024 10:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715681939; cv=none; b=fM62hxKrXY0nKq8fjnBlB3kWgWL6pz2wSq1qerrePf9jVPUcNds6wwmxCaZ7Vguvdq4sJ7MA9MHXE2Jeh/EsEANewddwUnJQJ7mKdN5h7IkOpZOuvJLTKHNELCR2Ze8OLzSPwK3CZL9J6EUex79L8WKqCfKK4wpUgeexa/FYBi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715681939; c=relaxed/simple;
	bh=Ex6e6kaqm2ec9YPkJjXdeTF0JxZCXr8b60qIe8t3w6Y=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=a3+FYgDY0lzwD7K5r84OHN3bL62dW4iMsvTZOgSEo6jlSrSnVWOoTkIBFsMgN9a7+7gmKpV1dvqNCMmAoeM/f0WJ5lEV33l2n6cjCF8d/eekg8XtnMglcBWoESCMT5cbQ3IdavwbpalAOxNwle1MZ3FBLaTzHXUnNeZwcWZ8Zbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Wj3vuv8E; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CN1hBXbz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 14 May 2024 10:18:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715681933;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UIrpPNqJgnyuNSuxxJMqh3wMDTHZXy6IeLAkaowNSAs=;
	b=Wj3vuv8EnXwneryxI07j3nAao2UlqOc+jw/DHJHjqcXf0D2IkmYe6l6CigLKE4a3YzqI+X
	xvAKJOW6Xmosu1xkW+93yew+Fb4qdtPUjo/ZBHjK5knSv1+8US+OUpeKU8y2kxtpFIg1zc
	+66eBJlX6ezje2zF1igTgTfsQjyk78J6JbgLkCLctRBXyZOiD3fvfNsDUx4dbtI9bF8gSP
	sqSjxyW8lAJAV2nAa1cAIongMK58fC/7VOd86w/NZBO+ERuY2Tyv1iCwcX0NIY9M4ZFdFQ
	Hy7Ml0iS1o+CvwWDRhQbCEkjipuaX/EopeqUHxHb5neJEkUnqMQ14uZhyV+SlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715681933;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UIrpPNqJgnyuNSuxxJMqh3wMDTHZXy6IeLAkaowNSAs=;
	b=CN1hBXbz4qc3JZjq7fzWi183HnQEX9K8Pl/Nqng2OESyw0fLGV2F9Y8AEJ9ClppzO/5xou
	XezCraFxl1mZpNDw==
From: "thermal-bot for Nicolas Pitre" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/fixes] dt-bindings: thermal: mediatek: Add LVTS
 thermal controller definition for MT8188
Cc: Nicolas Pitre <npitre@baylibre.com>, Rob Herring <robh@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com,
 amitk@kernel.org
In-Reply-To: <20240402032729.2736685-13-nico@fluxnic.net>
References: <20240402032729.2736685-13-nico@fluxnic.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171568193339.10875.7068814394440921756.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the thermal/fixes branch of thermal:

Commit-ID:     78c88534e5e1f8c5334c380b626c6ee91b62161b
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//78c88534e5e1f8c5334c380b626c6ee91b62161b
Author:        Nicolas Pitre <npitre@baylibre.com>
AuthorDate:    Mon, 01 Apr 2024 23:25:46 -04:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 23 Apr 2024 12:40:30 +02:00

dt-bindings: thermal: mediatek: Add LVTS thermal controller definition for MT8188

Add LVTS thermal controller definition for MT8188.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20240402032729.2736685-13-nico@fluxnic.net
---
 Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml |  4 ++++
 include/dt-bindings/thermal/mediatek,lvts-thermal.h                  | 16 ++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml b/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
index 4173bae..331cf4e 100644
--- a/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
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
diff --git a/include/dt-bindings/thermal/mediatek,lvts-thermal.h b/include/dt-bindings/thermal/mediatek,lvts-thermal.h
index 433d298..bf95309 100644
--- a/include/dt-bindings/thermal/mediatek,lvts-thermal.h
+++ b/include/dt-bindings/thermal/mediatek,lvts-thermal.h
@@ -26,6 +26,22 @@
 #define MT8186_ADSP		7
 #define MT8186_MFG		8
 
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

