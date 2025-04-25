Return-Path: <linux-pm+bounces-26196-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D48AA9C711
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 13:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BD5C9C56D1
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 11:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49C72459D0;
	Fri, 25 Apr 2025 11:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="XE7GT5qE"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF55E2288D5;
	Fri, 25 Apr 2025 11:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745579913; cv=none; b=FXrqSDYMYw+2UntYwJH6ObhS9hCxZMkRGuMx5eBh7EYiNbTx6SP4m9rzVyrXd5iZq4/q9uFboetvSNmaUu4+bb0nxEkH2Xb8Rqpk32iS4eYvTzmB5mCdl03o0MXA6N5FmLvfuBziApcQk761BonSLdM58/t+niDtD+VPTsopqLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745579913; c=relaxed/simple;
	bh=DQuiCF1SN/NjnZzhOowdWV/B0vWkundVtE6TjRFYqqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DoQmKut+FEgNkt1ApBmx5yOtK2sj3hcMXWtcl+D4JdPHa6dxUM1pCNnLqu5czoqcdsUop9Mnc1kUH39+YEWEFneKrY85rAHMyVLTNBIN52n97B5ylI+e9J6rmjjxxFqL6jYeRXkuYU/JuvJ2rHHlth+u9loQ+DChvNccnK9Go6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=XE7GT5qE; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a02:2149:8a3b:5a00:3490:6581:3910:8337])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id C6C482E08DB1;
	Fri, 25 Apr 2025 14:18:27 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1745579908;
	bh=/7DXyuv2rJHvdhAG9cuHuiAEipooyujiZO2C2+5uEdU=; h=From:To:Subject;
	b=XE7GT5qEFNmSB/X3c5JAUI6QBtX29SPwRCvbIBiApjcXyLCqXbYaRv+A/v86XS+7O
	 o4KxX6BimoR7/fR6vTteBn8guufp3BsRwbkmsmab+4XGEB/hp/3vUkS8ZguzVLcVZZ
	 Mro1HUgBm3jtiozlOJcS2zgSbHPTQm/ax2ozeHhg=
Authentication-Results: linux1587.grserver.gr;
	spf=pass (sender IP is 2a02:2149:8a3b:5a00:3490:6581:3910:8337) smtp.mailfrom=lkml@antheas.dev smtp.helo=localhost.localdomain
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
From: Antheas Kapenekakis <lkml@antheas.dev>
To: platform-driver-x86@vger.kernel.org
Cc: linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Jean Delvare <jdelvare@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Joaquin Ignacio Aramendia <samsagax@gmail.com>,
	Derek J Clark <derekjohn.clark@gmail.com>,
	Kevin Greenberg <kdgreenberg234@protonmail.com>,
	Joshua Tam <csinaction@pm.me>,
	Parth Menon <parthasarathymenon@gmail.com>,
	Eileen <eileen@one-netbook.com>,
	linux-kernel@vger.kernel.org,
	sre@kernel.org,
	linux@weissschuh.net,
	ilpo.jarvinen@linux.intel.com,
	hdegoede@redhat.com,
	mario.limonciello@amd.com,
	Antheas Kapenekakis <lkml@antheas.dev>
Subject: [PATCH v10 02/16] hwmon: (oxp-sensors) Add all OneXFly variants
Date: Fri, 25 Apr 2025 13:18:07 +0200
Message-ID: <20250425111821.88746-3-lkml@antheas.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425111821.88746-1-lkml@antheas.dev>
References: <20250425111821.88746-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <174557990864.22256.14651202597221804722@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

Currently, the driver only has the F1 OneXFly variant, which was based
on the 7000 AMD platform. Add its special editions: F1 EVA-01, F1 OLED.
F1 OLED might have been a dev unit, but it is supported by OneXConsole
with the same features so add it. Then add the F1L variant which is
based on the 8000 AMD platform and the F1Pro and its special edition
EVA-02.

One might ask why not just fuzzy match. Well, EVA-02 is a variant of
F1Pro which is a Strix Point handheld, but does not have F1Pro in its
name. This makes it risky to fuzzy match, as special variants in the
future from different platforms might not have the same feature set
or registers.

By happenstance, all current devices use the same registers. For the
charge limitting feature on this series, only F1Pro/X1 (AMD) were
released with it, but OneXPlayer is providing bios updates for F1, F1L,
X1 Mini units that use the same register, so treat all of them the same.

Acked-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/hwmon/oxp-sensors.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/hwmon/oxp-sensors.c b/drivers/hwmon/oxp-sensors.c
index 5a4230ad3757e..f7a64fbc8f33e 100644
--- a/drivers/hwmon/oxp-sensors.c
+++ b/drivers/hwmon/oxp-sensors.c
@@ -188,6 +188,41 @@ static const struct dmi_system_id dmi_table[] = {
 		},
 		.driver_data = (void *)oxp_fly,
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ONE-NETBOOK"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "ONEXPLAYER F1 EVA-01"),
+		},
+		.driver_data = (void *)oxp_fly,
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ONE-NETBOOK"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "ONEXPLAYER F1 OLED"),
+		},
+		.driver_data = (void *)oxp_fly,
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ONE-NETBOOK"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "ONEXPLAYER F1L"),
+		},
+		.driver_data = (void *)oxp_fly,
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ONE-NETBOOK"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "ONEXPLAYER F1Pro"),
+		},
+		.driver_data = (void *)oxp_fly,
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ONE-NETBOOK"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "ONEXPLAYER F1 EVA-02"),
+		},
+		.driver_data = (void *)oxp_fly,
+	},
 	{
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "ONE-NETBOOK"),
-- 
2.49.0


