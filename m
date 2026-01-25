Return-Path: <linux-pm+bounces-41434-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2AfcKl5rdmldQgEAu9opvQ
	(envelope-from <linux-pm+bounces-41434-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sun, 25 Jan 2026 20:13:34 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 022FD82053
	for <lists+linux-pm@lfdr.de>; Sun, 25 Jan 2026 20:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30D3B305B475
	for <lists+linux-pm@lfdr.de>; Sun, 25 Jan 2026 19:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4172F3601;
	Sun, 25 Jan 2026 19:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="O4EZu5wz"
X-Original-To: linux-pm@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69ED92F1FF4;
	Sun, 25 Jan 2026 19:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769368130; cv=none; b=SyRQXX5mrI41zlDsq//GVneXyMcqgvEu0rZWG6UDK7p2j4P/CfHn1NCn23QkX7fofk+eACDrKqhq/UHNIgjriDgn3lA+/r4KoG2Jv4+IGIVjKHq2vUswzaNTpizVCF36l2i8CWpm+/qPVFYqnhvpvJ6LrRbS4NrXW+tPmj19BCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769368130; c=relaxed/simple;
	bh=9yWBI+gYov2ELwPEW/EaRpgooS+fd0CmNyD5hHzzb0w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aSzht5sur0+jAVmgT/QH/b+mqSJ+nXao+e2SV7OJLVrQfXfDCsydgnGiUnFYZwImm70jy11NcYm5qE/IAaFZLZd1roIy7ayZmoWSXZtm0B3tfsqwtq27aGvA5PC4PiZutuXuanrPkAhbdRqPMVOtoTEfJLSpWqPIsoq5Xx2u3wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=O4EZu5wz; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 1302B2808A;
	Sun, 25 Jan 2026 20:08:48 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XrrZa3dgvy94; Sun, 25 Jan 2026 20:08:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1769368127; bh=9yWBI+gYov2ELwPEW/EaRpgooS+fd0CmNyD5hHzzb0w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=O4EZu5wz2wFjdZB/Z49AB3movTpgseYvABkQ4Te9oOAKs+ea61sqWtBFtGmInMstx
	 H/gMKfi3gtqiZyGEmYtvXGmW0LWcgoV1xKu6HcKM2/ciPF2nzTw6h10SFmkTTWkbiG
	 +9E96QA43KbzPBRx6vT/g5UxtH5XON0KHTGlfJXXQsO/1DAaHZAC8fnaSkgfszJsw6
	 xt0tUqDZSPfaj116zNl8pay7BzT+x2Tn+K5GiuFL0NGkJKIlhQU4dFNcNtq3fZ3Unv
	 rhBdq/8Q2+OcuaoXajHs1KqKBFFqU2UuRuQkhjbaPgXXAmr1I46Lu4YDpBohZgKjw7
	 O8Fp2UknCJbdw==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Mon, 26 Jan 2026 00:37:17 +0530
Subject: [PATCH v2 10/12] Documentation: leds: document pattern behavior of
 Samsung S2M series PMIC RGB LEDs
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260126-s2mu005-pmic-v2-10-78f1a75f547a@disroot.org>
References: <20260126-s2mu005-pmic-v2-0-78f1a75f547a@disroot.org>
In-Reply-To: <20260126-s2mu005-pmic-v2-0-78f1a75f547a@disroot.org>
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Sebastian Reichel <sre@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, linux-rtc@vger.kernel.org, 
 linux-doc@vger.kernel.org, Kaustabh Chakraborty <kauschluss@disroot.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[disroot.org,reject];
	R_DKIM_ALLOW(-0.20)[disroot.org:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41434-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[disroot.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kauschluss@disroot.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 022FD82053
X-Rspamd-Action: no action

Add documentation to describe how hardware patterns (as defined by the
documentation of led-class-multicolor) are parsed and implemented by the
Samsung S2M series PMIC RGB LED driver.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 Documentation/leds/index.rst        |  1 +
 Documentation/leds/leds-s2m-rgb.rst | 60 +++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/Documentation/leds/index.rst b/Documentation/leds/index.rst
index 76fae171039c6..05d8e8517a807 100644
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
index 0000000000000..4f89a8c89ea86
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
+The RGB LED on the S2M series PMIC hardware features a three-channel LED that
+is grouped together as a single device. Furthermore, it supports 8-bit
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
2.52.0


