Return-Path: <linux-pm+bounces-43173-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJTLK/X5nWnLSwQAu9opvQ
	(envelope-from <linux-pm+bounces-43173-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 20:20:21 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6690718BEE4
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 20:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5589B31354B2
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 19:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8FF3ACA6D;
	Tue, 24 Feb 2026 19:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="GFe3dahh"
X-Original-To: linux-pm@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733D93ACA48;
	Tue, 24 Feb 2026 19:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771960597; cv=none; b=G8OGJ2DA2D7TaMJ2L/k+hXvbeUOl8UkOXbghL7eQiffTAMftSjBzBRhTWX+3DHFfuqw8Tr236DC4iG/3rtvchiMsXfVCA+YJURIGQ2TE5TZEd4HBQAOIeCjKC/Np7anYs+MoD84atNvRpevTh0QX1g8CRko4fWIEKuzdXBTC3r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771960597; c=relaxed/simple;
	bh=APTWEQMa/tcBRn138klkUEJ93Ou5EMkSF0eYeDGIdbc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rAFR3eAmnL9c8cSb1sTeqmligUyP6Xt0D9um46QHDdFLNe939oFrTi5AkQxqpvtAotN89GlLWLgYainfsQYokodAf5DDlJMZrVbAzV0GLQ3lxrhjo6SpPnlb6D5fewilP1l6YNPlaqVz6NXf53M/a34vG831NAIObSIbwbWDH7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=GFe3dahh; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 3858226F9E;
	Tue, 24 Feb 2026 20:16:35 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 46G5CR2P3m-I; Tue, 24 Feb 2026 20:16:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1771960594; bh=APTWEQMa/tcBRn138klkUEJ93Ou5EMkSF0eYeDGIdbc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=GFe3dahhA8JMQuk62JyJaWWl9stIgmSsnVH2VDwdpN8lx2k4nKoHrcKKDdcyArCu4
	 fOPSdmN3Fd5XensjPbBdZOVZ9gy8aNpwFZK+DOHyyCaeYpbudcUDs+4gVc8e+OfxGQ
	 Aj1wdEI9WrxwcF4LSTodDI8jB0M8wfJbVyUuIr7N55fPrNspRWQWy20PiFzT2nzeSE
	 G7FyH5fXFhkYaJciS9IHwlVZD+y0iilccPft1Z7+Bu5cjVg5QOvm02gntOQ2Qee1+X
	 PuHIu0frOBml3lc1udvqHZeaE1iu47tT5Vurnuz4mfE09QdWpWEEVt83IvsnvcnXXs
	 FB3B2a3gv6+Kg==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Wed, 25 Feb 2026 00:45:13 +0530
Subject: [PATCH v3 11/13] Documentation: leds: document pattern behavior of
 Samsung S2M series PMIC RGB LEDs
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260225-s2mu005-pmic-v3-11-b4afee947603@disroot.org>
References: <20260225-s2mu005-pmic-v3-0-b4afee947603@disroot.org>
In-Reply-To: <20260225-s2mu005-pmic-v3-0-b4afee947603@disroot.org>
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Sebastian Reichel <sre@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Nam Tran <trannamatk@gmail.com>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, linux-rtc@vger.kernel.org, 
 linux-doc@vger.kernel.org, Kaustabh Chakraborty <kauschluss@disroot.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[disroot.org,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[disroot.org:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43173-lists,linux-pm=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,samsung.com,linaro.org,bootlin.com,lwn.net,linuxfoundation.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kauschluss@disroot.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[disroot.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,disroot.org:mid,disroot.org:dkim,disroot.org:email]
X-Rspamd-Queue-Id: 6690718BEE4
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
index bebf440042787..23fa9ff7aaf4b 100644
--- a/Documentation/leds/index.rst
+++ b/Documentation/leds/index.rst
@@ -28,6 +28,7 @@ LEDs
    leds-lp5812
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


