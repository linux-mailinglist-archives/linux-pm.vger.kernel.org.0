Return-Path: <linux-pm+bounces-25246-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CAB6A85CFB
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 14:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EEB19A49E6
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 12:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE9C29DB8F;
	Fri, 11 Apr 2025 12:18:23 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF0129C357
	for <linux-pm@vger.kernel.org>; Fri, 11 Apr 2025 12:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744373903; cv=none; b=K5qTFHq4ix6B8YhkFOVfFgvzQWHz9PZwZiADAoDvTFMB2/fpwHNAU2tDAdeZBl5k0T6ctCjXdTa6AgzvgF8jq+b4z1pG1IIDS6EjRJ64/7rk3dRIJ0z18y8M6ihnB00Cd/d39Hnr6sAKeoY7ZfwFanN3CfiVExFJNJe+NQQX1To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744373903; c=relaxed/simple;
	bh=penylcrZjRjoRlt2DxZgzg5QOoQPPyQfH7KISVKYXtg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qk/VhKT2H+g4HILdXwlCBng0wLfmeAd9+DaOVPbx+cH39m6aCyhiImeMG7oWURhDMEb3o9ULC8PGFuRguVXNPomIYlp8x9AEA8+KtjaEFZkIskg21mIRGXBrcR+Qmmjfm+9f8Y6lCERVluvYU7wW6aiawf+eXWX8RfZKBvQ65fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1u3DKZ-0006JY-Fv; Fri, 11 Apr 2025 14:17:59 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1u3DKY-004Qkc-2A;
	Fri, 11 Apr 2025 14:17:58 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1u3DKY-002PCM-1k;
	Fri, 11 Apr 2025 14:17:58 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Sebastian Reichel <sre@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
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
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	chrome-platform@lists.linux.dev
Subject: [PATCH v8 7/7] Documentation: Add sysfs documentation for PSCRR reboot reason tracking
Date: Fri, 11 Apr 2025 14:17:57 +0200
Message-Id: <20250411121757.573419-8-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250411121757.573419-1-o.rempel@pengutronix.de>
References: <20250411121757.573419-1-o.rempel@pengutronix.de>
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
Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
changes v8:
- Simplify and clarify example sysfs value comments
- Add note that not all values are meaningful on every system
changes v7:
- document expected values
---
 .../ABI/testing/sysfs-kernel-reboot-pscrr     | 74 +++++++++++++++++++
 1 file changed, 74 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-kernel-reboot-pscrr

diff --git a/Documentation/ABI/testing/sysfs-kernel-reboot-pscrr b/Documentation/ABI/testing/sysfs-kernel-reboot-pscrr
new file mode 100644
index 000000000000..96369422ed6e
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-kernel-reboot-pscrr
@@ -0,0 +1,74 @@
+What:		/sys/kernel/pscrr/reason
+Date:		April 2025
+KernelVersion:  6.16
+Contact:	Oleksij Rempel <o.rempel@pengutronix.de>
+Description:
+		This file provides access to the current power state
+		change reason. If supported, the reason may be stored
+		persistently in an NVMEM cell or another backend.
+
+		Reading this file returns an integer representing the
+		current shutdown or reboot cause.
+
+		Writing an integer value to this file sets the reason
+		to be stored for system analysis on next reboot.
+
+		Example usage:
+		  Read:
+			$ cat /sys/kernel/pscrr/reason
+			1   # (Example: Under-voltage shutdown)
+
+		  Write:
+			$ echo 4 > /sys/kernel/pscrr/reason
+			# Sets the reason to 4 (Example: Over-temperature shutdown)
+
+		Note:
+		  Not all systems support all reason values. Hardware or
+		  configuration may limit which reasons are applicable.
+
+		Values are defined in:
+		  - include/linux/reboot.h (enum psc_reason)
+
+		Supported Values:
+		  (from include/linux/reboot.h)
+
+		+-------+---------------------------+--------------------------+
+		| Value | Symbol                    | Description              |
+		+-------+---------------------------+--------------------------+
+		| 0     | PSCR_UNKNOWN              | Unknown or unspecified   |
+		|       |                           | power state change reason|
+		+-------+---------------------------+--------------------------+
+		| 1     | PSCR_UNDER_VOLTAGE        | Supply voltage dropped   |
+		|       |                           | below safe threshold     |
+		+-------+---------------------------+--------------------------+
+		| 2     | PSCR_OVER_CURRENT         | Excessive current draw or|
+		|       |                           | potential short circuit  |
+		+-------+---------------------------+--------------------------+
+		| 3     | PSCR_REGULATOR_FAILURE    | Voltage regulator failure|
+		|       |                           | preventing stable supply |
+		+-------+---------------------------+--------------------------+
+		| 4     | PSCR_OVER_TEMPERATURE     | Unsafe system temperature|
+		|       |                           | detected by sensors      |
+		+-------+---------------------------+--------------------------+
+		| 5     | PSCR_EC_PANIC             | Reboot triggered by EC   |
+		|       |                           | (Embedded Controller)    |
+		+-------+---------------------------+--------------------------+
+
+What:		/sys/kernel/pscrr/reason_boot
+Date:		April 2025
+KernelVersion:  6.16
+Contact:	Oleksij Rempel <o.rempel@pengutronix.de>
+Description:
+		This file provides the last recorded power state change
+		reason from before the current boot. If a supported backend
+		is configured (e.g., NVMEM), the value is retained across
+		reboots.
+
+		Example usage:
+		  Read:
+			$ cat /sys/kernel/pscrr/reason_boot
+			4   # (Example: Over-temperature shutdown)
+
+		Supported values:
+		  Same as /sys/kernel/pscrr/reason (see above).
+
-- 
2.39.5


