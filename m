Return-Path: <linux-pm+bounces-24028-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2DFBA61013
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 12:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B2D27AB806
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 11:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9DE1FF1AF;
	Fri, 14 Mar 2025 11:36:35 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5081FE47E
	for <linux-pm@vger.kernel.org>; Fri, 14 Mar 2025 11:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741952195; cv=none; b=oGySl/Ura1Xm/amu16SBEhRg8knj5JiuK1rzhqPFjluibB6Q46oXbOyB52HMoHXKqWW3csTPdQKOlkRTCmia9d5wP4NBYNsKihFs1iSzN545jNSqTloLbG7rVnj4hDh1k/YKBVKbbzFybgOKSZJ+W1+rK1Yv1sRXeIaxraTx+lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741952195; c=relaxed/simple;
	bh=BM2P1+sWqXKKZwR/jHqONVfULGU+/JuCKI63iVNdZTM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sQQ5s+g5ql1P8SwHMhjTqb7TRmrYVGTKGmgN+puK2S/E+ooFNQvt9EdUyv9pGL/G+h6g/nBPsfdo/wht6FxRsr6QYACJwYJk/30RkWpfV41Gj6f3n55m/K2jF61fG+QBpB8i4EGpWz0K1vjVUfD6xKYaO61L9v5gcp7b3uxLy3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tt3Kg-0007Nf-QE; Fri, 14 Mar 2025 12:36:06 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tt3Kf-005h5z-2K;
	Fri, 14 Mar 2025 12:36:05 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tt3Kf-007S73-1z;
	Fri, 14 Mar 2025 12:36:05 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Sebastian Reichel <sre@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	=?UTF-8?q?S=C3=B8ren=20Andersen?= <san@skov.dk>,
	Guenter Roeck <groeck@chromium.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	chrome-platform@lists.linux.dev
Subject: [PATCH v6 7/7] Documentation: Add sysfs documentation for PSCRR reboot reason tracking
Date: Fri, 14 Mar 2025 12:36:04 +0100
Message-Id: <20250314113604.1776201-8-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250314113604.1776201-1-o.rempel@pengutronix.de>
References: <20250314113604.1776201-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org

Add documentation for the Power State Change Reason Recorder (PSCRR)
sysfs interface, which allows tracking of system shutdown and reboot
reasons. The documentation provides details on available sysfs entries
under `/sys/kernel/pscrr/`, explaining their functionality, example usage,
and how they interact with different backend storage options (e.g., NVMEM).

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 .../ABI/testing/sysfs-kernel-reboot-pscrr     | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-kernel-reboot-pscrr

diff --git a/Documentation/ABI/testing/sysfs-kernel-reboot-pscrr b/Documentation/ABI/testing/sysfs-kernel-reboot-pscrr
new file mode 100644
index 000000000000..7cc643f89675
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-kernel-reboot-pscrr
@@ -0,0 +1,46 @@
+What:		/sys/kernel/pscrr/reason
+Date:		April 2025
+KernelVersion:  6.15
+Contact:	Oleksij Rempel <o.rempel@pengutronix.de>
+Description:
+		This file provides access to the last recorded power state
+		change reason. The storage backend is configurable and, if
+		supported, the reason may be stored persistently in an
+		NVMEM cell or another backend.
+
+		Reading this file returns an integer representing the last
+		recorded shutdown or reboot cause.
+
+		Writing an integer value to this file sets the reason to be
+		stored and recorded for system analysis.
+
+		Example usage (values are for illustration and may not reflect
+		actual reasons used in a given system):
+		  Read:
+			$ cat /sys/kernel/pscrr/reason
+			3   # (Example: Power loss event, may differ per system)
+
+		  Write:
+			$ echo 5 > /sys/kernel/pscrr/reason
+			# Sets the reason to 5 (Example: User-triggered reboot,
+			# this may not be a real value in your system)
+
+		Values are defined in:
+		  - `include/linux/reboot.h` (enum psc_reason)
+
+What:		/sys/kernel/pscrr/reason_boot
+Date:		April 2025
+KernelVersion:  6.15
+Contact:	Oleksij Rempel <o.rempel@pengutronix.de>
+Description:
+		This file provides the last recorded power state change reason
+		from before the current system boot. If a supported backend
+		(e.g., NVMEM) is configured, this value is retained across
+		reboots.
+
+		Example usage (values are for illustration and may not reflect
+		actual reasons used in a given system):
+		  Read:
+			$ cat /sys/kernel/pscrr/reason_boot
+			2   # (Example: Over-temperature shutdown, may differ per system)
+
-- 
2.39.5


