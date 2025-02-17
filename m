Return-Path: <linux-pm+bounces-22252-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24964A38D9A
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 21:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F06B13B5641
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 20:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF31C24112C;
	Mon, 17 Feb 2025 20:41:00 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DAE241107
	for <linux-pm@vger.kernel.org>; Mon, 17 Feb 2025 20:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739824860; cv=none; b=UgpHOBqkR+phTupfizkgyb/JYDvQl5/tFebjIuDdm+sTOWrMA1/+knntGJwLoMEdAx9429kY9A2KjEoUsMzBAOAegfD/iWT/WWpWdVkesk3fQaBHIVCFqPs+lOO5sWwOqTCOuIBzbHkrzGOm1Av+9y/x41BQo4bFqL+nQCi0oz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739824860; c=relaxed/simple;
	bh=+O2FsB2biFPebdsD/mYQegd/ubEfl2Q7jmEet+oj0VI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JqYf4+V9jq9N2Pg1ex/ANVQf/IPjkPJSmhXutQ8qOXppyYs/ElcLq6jRbMlaGyU+9CcNxhBmlkJ1NaaD3EtTkyDpssdL0GGySLOVH2zq90GxzmU2J2K2LAMzpWYbYlNnUFMZ8S3NSv4SSenPfIU+nm8Sr7UGWxCDk40rMOIZRgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tk7uZ-0007oF-CW; Mon, 17 Feb 2025 21:40:15 +0100
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tk7uX-001TFw-2v;
	Mon, 17 Feb 2025 21:40:13 +0100
Received: from localhost ([::1] helo=dude05.red.stw.pengutronix.de)
	by dude05.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tk7uX-000W9t-2Q;
	Mon, 17 Feb 2025 21:40:13 +0100
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
Date: Mon, 17 Feb 2025 21:39:43 +0100
Subject: [PATCH v3 03/12] docs: thermal: sync hardware protection doc with
 code
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-hw_protection-reboot-v3-3-e1c09b090c0c@pengutronix.de>
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

Originally, the thermal framework's only hardware protection action was
to trigger a shutdown. This has been changed a little over a year ago to
also support rebooting as alternative hardware protection action.

Update the documentation to reflect this.

Fixes: 62e79e38b257 ("thermal/thermal_of: Allow rebooting after critical temp")
Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---
 Documentation/driver-api/thermal/sysfs-api.rst | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/Documentation/driver-api/thermal/sysfs-api.rst b/Documentation/driver-api/thermal/sysfs-api.rst
index c803b89b7248f9f26ac24608b0144db5e9c2ddb4..f73de211bdced452b578fb77fb8707b8e59c9180 100644
--- a/Documentation/driver-api/thermal/sysfs-api.rst
+++ b/Documentation/driver-api/thermal/sysfs-api.rst
@@ -413,18 +413,21 @@ This function serves as an arbitrator to set the state of a cooling
 device. It sets the cooling device to the deepest cooling state if
 possible.
 
-5. thermal_emergency_poweroff
-=============================
+5. Critical Events
+==================
 
-On an event of critical trip temperature crossing the thermal framework
-shuts down the system by calling hw_protection_shutdown(). The
-hw_protection_shutdown() first attempts to perform an orderly shutdown
-but accepts a delay after which it proceeds doing a forced power-off
-or as last resort an emergency_restart.
+On an event of critical trip temperature crossing, the thermal framework
+will trigger a hardware protection power-off (shutdown) or reboot,
+depending on configuration.
+
+At first, the kernel will attempt an orderly power-off or reboot, but
+accepts a delay after which it proceeds to do a forced power-off or
+reboot, respectively. If this fails, ``emergency_restart()`` is invoked
+as last resort.
 
 The delay should be carefully profiled so as to give adequate time for
-orderly poweroff.
+orderly power-off or reboot.
 
-If the delay is set to 0 emergency poweroff will not be supported. So a
-carefully profiled non-zero positive value is a must for emergency
-poweroff to be triggered.
+If the delay is set to 0, the emergency action will not be supported. So a
+carefully profiled non-zero positive value is a must for the emergency
+action to be triggered.

-- 
2.39.5


