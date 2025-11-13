Return-Path: <linux-pm+bounces-37982-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF322C59A33
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 20:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72B543A66EB
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 19:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8948F31B80A;
	Thu, 13 Nov 2025 19:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="gojeYeR3"
X-Original-To: linux-pm@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DAA31A041;
	Thu, 13 Nov 2025 19:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763060874; cv=none; b=Ma/zzlELxpd1qo9iKF/S07HN6GsaHQUnGBhPgb0WVyUH8gbSD8GUCqQw0opVRX10I1wsvWqd+KKB9G9E8zhaxk/sv2ip8wVZsqoKY9bXQtKvAj/SUstGTAawiALt2l6gx2k0ZzXUramOi9INkwBHaHNkNjLLKBsn94C7GYiORHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763060874; c=relaxed/simple;
	bh=zxRedWwjE9b/E44vMq9L4VTLOedMXWqZjIhevLHmhjY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CiklEtpKGC2Qv5Q81yU3NeR4G6IrdTuXVIIiB/s6BQCpiO25yH633smupJiACfIRCnumaDpBPd2NB008tjfCXdFFsl1yWakuo8pSjM0L0dKrJ+ZflwwXixT77Qe6jyCcHBFmRcDwGnMsrVu9xRcrAFTnPOQDGwKVASycNYW+UBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=gojeYeR3; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 39B382666C;
	Thu, 13 Nov 2025 20:07:51 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SybkkiTBVzdK; Thu, 13 Nov 2025 20:07:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1763060870; bh=zxRedWwjE9b/E44vMq9L4VTLOedMXWqZjIhevLHmhjY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=gojeYeR32NZDirTx6OYm6pLvjGXw5A0ZpJvGSQsU3wXQl+U67/6noUQASz0z5Ez1J
	 PsKPcjwjAQJbzmRZ5+QYdTKOI0qLgEWBWdEJ21NYMs2UOPMHl4vzjTc3Acl/5RkVxf
	 T70igAtqn/WXCAx6UxW8BF9cALXFsPZIJUmOqjxKNpm1FWIBHQ8OEFCIR7EFfANday
	 tq0pXFPRA96tM3VMhb6+lr1MO8ZqbH9CuBMKasGNSryo2Jp3MUe2MFrqjFAXgrz8/f
	 KIWk2e1Z6pu3BVcl6WW6fYdEb0wTf2JRDgk/bUFtIuSSnvm9kALA25+Kq1IXnpNHiJ
	 OU8hbIvTJxfRg==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Fri, 14 Nov 2025 00:35:12 +0530
Subject: [PATCH 11/13] Documentation: leds: document pattern behavior of
 Samsung S2M series PMIC RGB LEDs
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251114-s2mu005-pmic-v1-11-9e3184d3a0c9@disroot.org>
References: <20251114-s2mu005-pmic-v1-0-9e3184d3a0c9@disroot.org>
In-Reply-To: <20251114-s2mu005-pmic-v1-0-9e3184d3a0c9@disroot.org>
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Sebastian Reichel <sre@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, linux-rtc@vger.kernel.org, 
 linux-doc@vger.kernel.org, Kaustabh Chakraborty <kauschluss@disroot.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763060713; l=3290;
 i=kauschluss@disroot.org; s=20250202; h=from:subject:message-id;
 bh=zxRedWwjE9b/E44vMq9L4VTLOedMXWqZjIhevLHmhjY=;
 b=vofBNSa6jIuiouTtAJL+K+XlnmfcS4Q2YxqiOlofVrzFgxhT30nk8atXEx1tsRQLjjSBNMpue
 hGN2BlTNNUiDfDjrMfzvBact965CnrBKFPPmSNUmR/2YGHHxGsQLPek
X-Developer-Key: i=kauschluss@disroot.org; a=ed25519;
 pk=h2xeR+V2I1+GrfDPAhZa3M+NWA0Cnbdkkq1bH3ct1hE=

Add documentation to describe how hardware patterns (as defined by the
documentation of led-class-multicolor) are parsed and implemented by the
Samsung S2M series PMIC RGB LED driver.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 Documentation/leds/index.rst        |  1 +
 Documentation/leds/leds-s2m-rgb.rst | 60 +++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/Documentation/leds/index.rst b/Documentation/leds/index.rst
index 76fae171039c..05d8e8517a80 100644
--- a/Documentation/leds/index.rst
+++ b/Documentation/leds/index.rst
@@ -27,6 +27,7 @@ LEDs
    leds-lp55xx
    leds-mlxcpld
    leds-mt6370-rgb
+   leds-s2m-rgb
    leds-sc27xx
    leds-st1202
    leds-qcom-lpg
diff --git a/Documentation/leds/leds-s2m-rgb.rst b/Documentation/leds/leds-s2m-rgb.rst
new file mode 100644
index 000000000000..cf91f0238093
--- /dev/null
+++ b/Documentation/leds/leds-s2m-rgb.rst
@@ -0,0 +1,60 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+======================================
+Samsung S2M Series PMIC RGB LED Driver
+======================================
+
+Description
+-----------
+
+The RGB LED on the S2M series PMIC hardware features a three-channel LED that is
+grouped together as a single device. Furthermore, the it supports 8-bit
+brightness control for each channel. This LED is typically used as a status
+indicator in mobile devices. It also supports various parameters for hardware
+patterns.
+
+The hardware pattern can be programmed using the "pattern" trigger, using the
+hw_pattern attribute.
+
+/sys/class/leds/<led>/repeat
+----------------------------
+
+The hardware supports only indefinitely repeating patterns. The repeat
+attribute must be set to -1 for hardware patterns to function.
+
+/sys/class/leds/<led>/hw_pattern
+--------------------------------
+
+Specify a hardware pattern for the RGB LEDs.
+
+The pattern is a series of brightness levels and durations in milliseconds.
+There should be only one non-zero brightness level. Unlike the results
+described in leds-trigger-pattern, the transitions between on and off states
+are smoothed out by the hardware.
+
+Simple pattern::
+
+    "255 3000 0 1000"
+
+    255 -+ ''''''-.                     .-'''''''-.
+         |         '.                 .'           '.
+         |           \               /               \
+         |            '.           .'                 '.
+         |              '-.......-'                     '-
+      0 -+-------+-------+-------+-------+-------+-------+--> time (s)
+         0       1       2       3       4       5       6
+
+As described in leds-trigger-pattern, it is also possible to use zero-length
+entries to disable the ramping mechanism.
+
+On-Off pattern::
+
+    "255 1000 255 0 0 1000 0 0"
+
+    255 -+ ------+       +-------+       +-------+
+         |       |       |       |       |       |
+         |       |       |       |       |       |
+         |       |       |       |       |       |
+         |       +-------+       +-------+       +-------
+      0 -+-------+-------+-------+-------+-------+-------+--> time (s)
+         0       1       2       3       4       5       6

-- 
2.51.2


