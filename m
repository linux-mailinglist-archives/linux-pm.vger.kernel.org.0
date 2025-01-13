Return-Path: <linux-pm+bounces-20342-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD50A0BD3D
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 17:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBD5D169C27
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 16:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D402297E1;
	Mon, 13 Jan 2025 16:25:58 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCACF1537A8
	for <linux-pm@vger.kernel.org>; Mon, 13 Jan 2025 16:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736785558; cv=none; b=n8RTg57rIPyROyqMe7pjSpM7DaOo+KwpKq59Xw84OXVv0VUE2ptJ5ua5ccVO/bdT90kFz3cPZlcP+d0PpGAO7lzZiggnAkApr14L13wSiM/c86vtKsoptco8LmkXcCpdcq/Yi7ifqt8CmPFdW8ihY2U/cuA7TFqzMYHY09KbzIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736785558; c=relaxed/simple;
	bh=kJ2yKBl7nEqQNMvLzNDc3qKjivLR/JBqBYSo25/UQFQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kVYLiIA4YehQfeG+IxjsnG7RCg42I2ToszFathLCI/VE2t+qumHzCz8tHVfyNPtain1vONOIkao7PoEwweYj3jSj6UivOCKCXHio5OoBB1QYnnQglnJQzn1ArQQKKfAq3JfOehqOg1RvxjnHvZ1CBIfPCw0M//aUswHg9ZPRajY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tXNFs-0000JH-8B; Mon, 13 Jan 2025 17:25:32 +0100
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tXNFp-000HzI-2l;
	Mon, 13 Jan 2025 17:25:30 +0100
Received: from localhost ([::1] helo=dude05.red.stw.pengutronix.de)
	by dude05.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tXNFq-007FQL-2x;
	Mon, 13 Jan 2025 17:25:30 +0100
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
Date: Mon, 13 Jan 2025 17:25:29 +0100
Subject: [PATCH v2 04/12] reboot: describe do_kernel_restart's cmd argument
 in kernel-doc
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250113-hw_protection-reboot-v2-4-161d3fc734f0@pengutronix.de>
References: <20250113-hw_protection-reboot-v2-0-161d3fc734f0@pengutronix.de>
In-Reply-To: <20250113-hw_protection-reboot-v2-0-161d3fc734f0@pengutronix.de>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Fabio Estevam <festevam@denx.de>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
 Jonathan Corbet <corbet@lwn.net>, Serge Hallyn <serge@hallyn.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Matti Vaittinen <mazziesaccount@gmail.com>, 
 Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
 Guenter Roeck <groeck@chromium.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-security-module@vger.kernel.org, 
 chrome-platform@lists.linux.dev, devicetree@vger.kernel.org, 
 kernel@pengutronix.de, Ahmad Fatoum <a.fatoum@pengutronix.de>
X-Mailer: b4 0.14.2
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org

A W=1 build rightfully complains about the function's kernel-doc
being incomplete.

Describe its single parameter to fix this.

Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---
 kernel/reboot.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/reboot.c b/kernel/reboot.c
index 222b63dfd31020d0e2bc1b1402dbfa82adc71990..21a85cf95413979322d3183af1a378f5ddd8e780 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -229,6 +229,9 @@ EXPORT_SYMBOL(unregister_restart_handler);
 /**
  *	do_kernel_restart - Execute kernel restart handler call chain
  *
+ *	@cmd: pointer to buffer containing command to execute for restart
+ *		or %NULL
+ *
  *	Calls functions registered with register_restart_handler.
  *
  *	Expected to be called from machine_restart as last step of the restart

-- 
2.39.5


