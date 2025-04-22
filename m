Return-Path: <linux-pm+bounces-25869-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D115A9637A
	for <lists+linux-pm@lfdr.de>; Tue, 22 Apr 2025 11:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED53B3B18FC
	for <lists+linux-pm@lfdr.de>; Tue, 22 Apr 2025 08:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC57325A328;
	Tue, 22 Apr 2025 08:57:36 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1A3255247
	for <linux-pm@vger.kernel.org>; Tue, 22 Apr 2025 08:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745312256; cv=none; b=Z22qQYn00z4wiPXed9XfJWFhnbO3QUWqtq/r0BF+WZ7pCTnWaekKfJ+K9Cdz4s7I89gb4KZb2T+KCz0vEtLPPKXJUbyplpKERNreCTa8htuwvtPDrIak1UitIcGfHVIJprkV3aKWc0DgYWsuimfSGEPEQQXnU+W+VjYgqqb9PoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745312256; c=relaxed/simple;
	bh=lTbHJ1/ZlZxy/0X5aGRTsmnSe0G1gRDQaLVCb3W0FPk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jhs7dYFl44tC5XVDVgs72Zlwq7f+d/vmCSoIDe+RkokSF35YKC9Woeb8uh05Z6zSe++Ziyg6LRiuKmgT9O6fA7Fp/c3e5ZDRrBYO141z+AHGlDisFzjsvmmTRNgwX+MwZ6cKavxsiWVYAlDrs8qyY5IpE3AXiMzi1q51Qa3t1Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1u79RQ-0007Tz-3o; Tue, 22 Apr 2025 10:57:20 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1u79RO-001WRC-2n;
	Tue, 22 Apr 2025 10:57:18 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1u79RO-00AvpD-2W;
	Tue, 22 Apr 2025 10:57:18 +0200
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
Subject: [PATCH v9 1/7] power: Extend power_on_reason.h for upcoming PSCRR framework
Date: Tue, 22 Apr 2025 10:57:11 +0200
Message-Id: <20250422085717.2605520-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250422085717.2605520-1-o.rempel@pengutronix.de>
References: <20250422085717.2605520-1-o.rempel@pengutronix.de>
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

Prepare for the introduction of the Power State Change Reason Recorder
(PSCRR)  framework by expanding the power_on_reason.h header. This
extension includes new power-on reasons:
- POWER_ON_REASON_OVER_CURRENT for over-current conditions.
- POWER_ON_REASON_REGULATOR_FAILURE for regulator failures.
- POWER_ON_REASON_OVER_TEMPERATURE for over temperature situations.
- POWER_ON_REASON_EC_PANIC for EC panics

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
changes v6:
- add POWER_ON_REASON_EC_PANIC
- s/POWER_ON_REASON_OVERTEMPERATURE/POWER_ON_REASON_OVER_TEMPERATURE
---
 include/linux/power/power_on_reason.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/power/power_on_reason.h b/include/linux/power/power_on_reason.h
index 95a1ec0c403c..bf9501792696 100644
--- a/include/linux/power/power_on_reason.h
+++ b/include/linux/power/power_on_reason.h
@@ -15,5 +15,9 @@
 #define POWER_ON_REASON_XTAL_FAIL "crystal oscillator failure"
 #define POWER_ON_REASON_BROWN_OUT "brown-out reset"
 #define POWER_ON_REASON_UNKNOWN "unknown reason"
+#define POWER_ON_REASON_OVER_CURRENT "over current"
+#define POWER_ON_REASON_REGULATOR_FAILURE "regulator failure"
+#define POWER_ON_REASON_OVER_TEMPERATURE "over temperature"
+#define POWER_ON_REASON_EC_PANIC "EC panic"
 
 #endif /* POWER_ON_REASON_H */
-- 
2.39.5


