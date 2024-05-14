Return-Path: <linux-pm+bounces-7809-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5798C4F5C
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 12:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 800201F22A6E
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 10:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E4585936;
	Tue, 14 May 2024 10:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LTkxhNLF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8OqQYXex"
X-Original-To: linux-pm@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9295884D23
	for <linux-pm@vger.kernel.org>; Tue, 14 May 2024 10:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715681940; cv=none; b=Q5Af4V7/VJy40nsP5nhchciDgwmQLm9eKOV55OfmVFa57QQZfsXxni4TNVnkCxHjTzTHhCU0LL+7n1nIOQoeQBSWJG0iuSPfW1lTtCZ8PXxZ0bZHgQ5bans8179IdoadqgZLdlgDD5Vk/phMlBuxFqY0qh9i9+LWRRiFTrYe+BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715681940; c=relaxed/simple;
	bh=VCGGCU7irekzpydHsx6szRTsORDVm75s8TvxIWLA15Y=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=BUNkNjiqcWbPKsYbcPH9sMCLpfsTfZ8CSGoB58t07de2WqIjMr7KSioElBiRg0aRb3tDFhbPOmDJztuRq6TH0XIlmqDwGsY0W8r6SdbG+OHR30CGJvbhhcx9EnR7JqvhdtVgzIrzAi7qomYWHkdf/mPm+4LW4paPyXCBOiounoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LTkxhNLF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8OqQYXex; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 14 May 2024 10:18:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715681934;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KKr51r2IWOw6KwVzizQFnZuTA463jOiPIlJr0ghJcPo=;
	b=LTkxhNLF//RJYiY/UcLxhM2o6DX90AeEuHPrkFRepU/kzVWiZAXGYu4TTutcHnCmJ0VbBO
	dpBFIqDu+nM3bor3FV6KDIEBteL/t2Dlz+Ci2grvlmpz+b+lRfEGo+Bpd4XBM6is1Xh8Zj
	9txzjJsEMD3Frl95VEPrtTViUpfSKuWG3iXRj4RysEBka4L2D0hrDItlxjn6CTsJb43nmd
	cb7/IDV06JnwCeOmSofRWRpGhDGMLBXpSAIEiz8czbRCrUwTmnx1n82MmFdtzaey+plz63
	BvGIyLJ6bzYxqD8SMqXACWzNA11ajjVfVZRW32UTiG677gVeY624ShjTCY8jqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715681934;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KKr51r2IWOw6KwVzizQFnZuTA463jOiPIlJr0ghJcPo=;
	b=8OqQYXex/JoMz/8jkYob8y50oIaZHh9QcJkOv9cuuYUcJwOl65nNnyMSlaC4b6apF03Fno
	47Lsy6QMasIGV9Cw==
From: "thermal-bot for Nicolas Pitre" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/fixes] dt-bindings: thermal: mediatek: Add LVTS
 thermal controller definition for MT8186
Cc: Nicolas Pitre <npitre@baylibre.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com,
 amitk@kernel.org
In-Reply-To: <20240402032729.2736685-7-nico@fluxnic.net>
References: <20240402032729.2736685-7-nico@fluxnic.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171568193386.10875.8223857736198071291.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the thermal/fixes branch of thermal:

Commit-ID:     a2ca202350f97bced8dac4cbfbb3cbf855973e57
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//a2ca202350f97bced8dac4cbfbb3cbf855973e57
Author:        Nicolas Pitre <npitre@baylibre.com>
AuthorDate:    Mon, 01 Apr 2024 23:25:40 -04:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 23 Apr 2024 12:40:30 +02:00

dt-bindings: thermal: mediatek: Add LVTS thermal controller definition for MT8186

Add LVTS thermal controller definition for MT8186.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20240402032729.2736685-7-nico@fluxnic.net
---
 Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml |  2 ++
 include/dt-bindings/thermal/mediatek,lvts-thermal.h                  | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml b/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
index e6665af..4173bae 100644
--- a/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
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
diff --git a/include/dt-bindings/thermal/mediatek,lvts-thermal.h b/include/dt-bindings/thermal/mediatek,lvts-thermal.h
index 997e2f5..433d298 100644
--- a/include/dt-bindings/thermal/mediatek,lvts-thermal.h
+++ b/include/dt-bindings/thermal/mediatek,lvts-thermal.h
@@ -16,6 +16,16 @@
 #define MT7988_ETHWARP_0	6
 #define MT7988_ETHWARP_1	7
 
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

