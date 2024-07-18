Return-Path: <linux-pm+bounces-11231-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E89CA9351FA
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jul 2024 21:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F6F81C20CBA
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jul 2024 19:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7557E14534B;
	Thu, 18 Jul 2024 19:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="UUJquti2"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B1A43AB4;
	Thu, 18 Jul 2024 19:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721329321; cv=none; b=kofWkJKze0XCq6gSOff9AgzrLMWP61TxNZ1nK/gEhOG8cNvipLbIFQGnXuzTpXtWMJAYfxjmQYMl5O71saOcyIgTkkFkikO1KSRLxCmKlvBdYUMETiuVR7W6qz9Kl/tXOrP5h9FVnA5jFbQOCTcH4AyNL+BWpXUL5dagOyiqKFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721329321; c=relaxed/simple;
	bh=qyUSyn1a3z120cQ3nryQctzC7rh0Rf4zPRfG4Bu9ebk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DI0NGmZMxRTGfcEzptEwmLELUEciZT52w4TbthVjZ7FTKK3S8SX3nGPQMRmLOOb36q6f9IjTOY8jojk9uW0RxKRhLDxEu/P9ZE4LM8CrXBhNDiSorzxnetyd6nWGEiU8/BseZjjLm9HkTnK8CeASc7IKpSotrkXXToPfKJKx6D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=UUJquti2; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 51d6a60e70638d15; Thu, 18 Jul 2024 21:01:56 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 413936A1D1C;
	Thu, 18 Jul 2024 21:01:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1721329316;
	bh=qyUSyn1a3z120cQ3nryQctzC7rh0Rf4zPRfG4Bu9ebk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UUJquti2EPnBPuHGF67u+qvLZodv2MEx2qxKMYUm7cb5CfaNuHsH7yfAzQYtCHthN
	 nI/BjbndnFCFXEglsixwZJE/yWOzcPakV/ppEtAYYgW/c7OX6XvquzrBKZ0uUCw74J
	 SihWzwJ1i1JQ0NhmeU40US4i2e4LzdKg8n2GVvb7gwQNfzgvqL8lgrhelO108Ddol2
	 gaeRCrH2Odx/rKUKggd8tSV09supEuXe2+dtKBgrTmFqz6nojPNtHzapHPnJ05mqMU
	 bmPWc71y0bjyrngR5gnF0Z+FchI+0+clUP8vXDcK5jlPgphPMG5sTPwupBX0Z0Y0Mn
	 rzHha7vlYEY7w==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v1 1/2] thermal: trip: Split thermal_zone_device_set_mode()
Date: Thu, 18 Jul 2024 21:00:35 +0200
Message-ID: <2206793.irdbgypaU6@rjwysocki.net>
In-Reply-To: <2348857.ElGaqSPkdT@rjwysocki.net>
References: <2348857.ElGaqSPkdT@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrgeelgddufeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohephedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehnvghi
 lhdrrghrmhhsthhrohhngheslhhinhgrrhhordhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Pull a wrapper around thermal zone .change_mode() callback out of
thermal_zone_device_set_mode() because it will be used elsewhere
subsequently.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c |   31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -272,6 +272,22 @@ static int __init thermal_register_gover
 	return ret;
 }
 
+static int __thermal_zone_device_set_mode(struct thermal_zone_device *tz,
+					  enum thermal_device_mode mode)
+{
+	if (tz->ops.change_mode) {
+		int ret;
+
+		ret = tz->ops.change_mode(tz, mode);
+		if (ret)
+			return ret;
+	}
+
+	tz->mode = mode;
+
+	return 0;
+}
+
 /*
  * Zone update section: main control loop applied to each zone while monitoring
  * in polling mode. The monitoring is done using a workqueue.
@@ -540,7 +556,7 @@ monitor:
 static int thermal_zone_device_set_mode(struct thermal_zone_device *tz,
 					enum thermal_device_mode mode)
 {
-	int ret = 0;
+	int ret;
 
 	mutex_lock(&tz->lock);
 
@@ -548,14 +564,15 @@ static int thermal_zone_device_set_mode(
 	if (mode == tz->mode) {
 		mutex_unlock(&tz->lock);
 
-		return ret;
+		return 0;
 	}
 
-	if (tz->ops.change_mode)
-		ret = tz->ops.change_mode(tz, mode);
+	ret = __thermal_zone_device_set_mode(tz, mode);
+	if (ret) {
+		mutex_unlock(&tz->lock);
 
-	if (!ret)
-		tz->mode = mode;
+		return ret;
+	}
 
 	__thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
 
@@ -566,7 +583,7 @@ static int thermal_zone_device_set_mode(
 	else
 		thermal_notify_tz_disable(tz);
 
-	return ret;
+	return 0;
 }
 
 int thermal_zone_device_enable(struct thermal_zone_device *tz)




