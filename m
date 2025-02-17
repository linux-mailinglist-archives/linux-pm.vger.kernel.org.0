Return-Path: <linux-pm+bounces-22247-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46207A38D81
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 21:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C24E3B3B23
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 20:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DAC23E23D;
	Mon, 17 Feb 2025 20:40:46 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E99823C8D1
	for <linux-pm@vger.kernel.org>; Mon, 17 Feb 2025 20:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739824846; cv=none; b=GGkRUDERm232mUYNdxDlRdptCf/6DYBUcsmR74lvK8QtR/uFLYLRp2buwEqi8ULOHoZIUMQFjLO78A0R4j2x0GVDQxDnmzfE5KFaBSYFkWe/RNKJhqWwPqpKUJRxGfsCfIZ41z3svOw96yHmmBLN54Apht6ttgXWHg9C+d4QdOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739824846; c=relaxed/simple;
	bh=EF+OIGuQjAmSVRDImJKX1B6EES2YYainDrFd5e7QM38=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mk5SmH96yyLf3hHcdJNxIdTCm3OlCq3seqRVg/Dldl+k2fGvQ3uNjC6rvAmfB/fKxQlcznebU+8aKCHsyNOCoBfhYP/t8RPjAX2nMwc8OlK5QmUBbNjZddIh3TPLKClnqkBeW07i/W9tFTTF2+jYTcz8+Z56gA8bZKkbyZrzAFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tk7uZ-0007oK-CW; Mon, 17 Feb 2025 21:40:15 +0100
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tk7uX-001TFx-32;
	Mon, 17 Feb 2025 21:40:13 +0100
Received: from localhost ([::1] helo=dude05.red.stw.pengutronix.de)
	by dude05.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tk7uX-000W9t-2R;
	Mon, 17 Feb 2025 21:40:13 +0100
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
Date: Mon, 17 Feb 2025 21:39:44 +0100
Subject: [PATCH v3 04/12] reboot: describe do_kernel_restart's cmd argument
 in kernel-doc
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-hw_protection-reboot-v3-4-e1c09b090c0c@pengutronix.de>
References: <20250217-hw_protection-reboot-v3-0-e1c09b090c0c@pengutronix.de>
In-Reply-To: <20250217-hw_protection-reboot-v3-0-e1c09b090c0c@pengutronix.de>
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

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---
 kernel/reboot.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/reboot.c b/kernel/reboot.c
index f348f1ba9e22675ac1183149ba19f39be12edacd..6185cfe5d4ee910daf057884a7ff8dcf1e80df28 100644
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


