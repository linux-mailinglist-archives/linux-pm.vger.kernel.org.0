Return-Path: <linux-pm+bounces-23546-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE67A54691
	for <lists+linux-pm@lfdr.de>; Thu,  6 Mar 2025 10:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2E60188593D
	for <lists+linux-pm@lfdr.de>; Thu,  6 Mar 2025 09:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9F520AF94;
	Thu,  6 Mar 2025 09:39:19 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806C320AF64
	for <linux-pm@vger.kernel.org>; Thu,  6 Mar 2025 09:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741253959; cv=none; b=dJ9oVoTyZuSflrcVaIikG9GrjRWH7ZhcUPvb5bZTnX6fQErXptvkhNLiFVv4gT0rFs9SZc+ihx3Vz3ROmC4W9E9KrIqEzn4QAo8HOCLyXc365vJQE95SQNj81p8PVUeJrsROamfM9tU40XUKEgQ7Nyuf3VwxaIwD3ShUhoepBjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741253959; c=relaxed/simple;
	bh=+6O+mA2fzpX7x0jBw55O1jhy+s61L25CXgYyz0ThUBw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WSrxRB+yZSVHUgCGrT6BWza9n/1g0LiVheVxB5sB5Ae7vwuSnoLmpzZYRx6x0xteED9hGX+kMOEZOg9NqEfsa3DQxqrCzt88ElzV5WFx9fSxD5jsJRRYLKJRnla11AaWlN4oLleWsGiJXPUp/13tKw8RgA0yhV2u8R307eJhxkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tq7h0-0002QE-Ix; Thu, 06 Mar 2025 10:39:02 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tq7gz-004I9Z-1z;
	Thu, 06 Mar 2025 10:39:01 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tq7gz-009EBl-1k;
	Thu, 06 Mar 2025 10:39:01 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Sebastian Reichel <sre@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	=?UTF-8?q?S=C3=B8ren=20Andersen?= <san@skov.dk>
Subject: [PATCH v4 1/7] power: Extend power_on_reason.h for upcoming PSCRR framework
Date: Thu,  6 Mar 2025 10:38:53 +0100
Message-Id: <20250306093900.2199442-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250306093900.2199442-1-o.rempel@pengutronix.de>
References: <20250306093900.2199442-1-o.rempel@pengutronix.de>
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
- POWER_ON_REASON_OVERTEMPERATURE for over temperature situations.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 include/linux/power/power_on_reason.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/power/power_on_reason.h b/include/linux/power/power_on_reason.h
index 95a1ec0c403c..f2446cece277 100644
--- a/include/linux/power/power_on_reason.h
+++ b/include/linux/power/power_on_reason.h
@@ -15,5 +15,8 @@
 #define POWER_ON_REASON_XTAL_FAIL "crystal oscillator failure"
 #define POWER_ON_REASON_BROWN_OUT "brown-out reset"
 #define POWER_ON_REASON_UNKNOWN "unknown reason"
+#define POWER_ON_REASON_OVER_CURRENT "over current"
+#define POWER_ON_REASON_REGULATOR_FAILURE "regulator failure"
+#define POWER_ON_REASON_OVERTEMPERATURE "overtemperature"
 
 #endif /* POWER_ON_REASON_H */
-- 
2.39.5


