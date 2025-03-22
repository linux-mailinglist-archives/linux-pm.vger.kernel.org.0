Return-Path: <linux-pm+bounces-24410-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4099A6C968
	for <lists+linux-pm@lfdr.de>; Sat, 22 Mar 2025 11:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE9011B635FF
	for <lists+linux-pm@lfdr.de>; Sat, 22 Mar 2025 10:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF6B1FBE9B;
	Sat, 22 Mar 2025 10:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="BJOtsTaz"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C981FA164;
	Sat, 22 Mar 2025 10:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742639778; cv=none; b=KFOvsJo19HSiJ3rPYNzbHyaGRDzMd+jhQ91RtbkqN/1U0bC52CCLs6qF9JHcqocemeLwJFPFLrk4BlYVpZ0pC2VW0Uh1SqTDVfuLrQVj22OL+B+AvA3Hdy1SjDhFynnUPEO0hIUL2743pl5zOqQXNss1zTwS4nUHJQ7vbfYs/T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742639778; c=relaxed/simple;
	bh=opjunFQFrouA8DNOU6C9wAbagyDhvppy9rI6YE5PA+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ocNBgvUiN5S+T/rw3etZzFCoPMdBKsBoC6xSrhBBnKqAyNwgG0baESsTza9o/faeIkVfU41HZJrH+jr16IpsuKCfe0h80OXlxVQLd4JeTDFXuFj16xCQdlt8LPVdYpk8CJPbIDQ1+i3CQV8Bf5Kjb5UUa+M3F0sIwo559yV+3QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=BJOtsTaz; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a05:f6c2:511b:0:cbc0:999f:73ad:33bd])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 1736E2E07CD9;
	Sat, 22 Mar 2025 12:36:11 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1742639774;
	bh=c35JAt7mYxKoY6ySFdvKRllEVw68EG0Y5y2dsMntsfA=; h=From:To:Subject;
	b=BJOtsTaz5rCDHErYgsQf9hWugzOMGOjq6viYOc2O9+YRvKWdo4POjgL19Pp/rMKfh
	 uz2DqfHiF3Y01FXbHuuZciyEMYaqOsU4T3r5yxvIxDKktSFGgOwIr6u9bWZJb8mSXM
	 rrv/SxQypZpk5uLfQtSi4OGIdra2OWQXcpHTLu3A=
Authentication-Results: linux1587.grserver.gr;
	spf=pass (sender IP is 2a05:f6c2:511b:0:cbc0:999f:73ad:33bd) smtp.mailfrom=lkml@antheas.dev smtp.helo=localhost.localdomain
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
Subject: [PATCH v8 01/14] hwmon: (oxp-sensors) Distinguish the X1 variants
Date: Sat, 22 Mar 2025 11:35:53 +0100
Message-ID: <20250322103606.680401-2-lkml@antheas.dev>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250322103606.680401-1-lkml@antheas.dev>
References: <20250322103606.680401-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <174263977277.10976.16854053857234553384@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

Currently, the oxp-sensors driver fuzzy matches the X1 variants. Luckily,
X1 and X1 mini share most hardware features so this works. However, they
are completely different product lines, and there is an expectation that
OneXPlayer will release more devices in the X1 line that may have
differences.

Therefore, distinguish the 3 devices that currently exist in the market.
These are the OneXPlayer X1 AMD and Intel variants, and the X1 mini which
only has an AMD variant. As far as registers go, all three support the
current driver functionality.

Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
Acked-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/hwmon/oxp-sensors.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/oxp-sensors.c b/drivers/hwmon/oxp-sensors.c
index 83730d9318240..5a4230ad3757e 100644
--- a/drivers/hwmon/oxp-sensors.c
+++ b/drivers/hwmon/oxp-sensors.c
@@ -205,7 +205,28 @@ static const struct dmi_system_id dmi_table[] = {
 	{
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "ONE-NETBOOK"),
-			DMI_MATCH(DMI_BOARD_NAME, "ONEXPLAYER X1"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "ONEXPLAYER X1 A"),
+		},
+		.driver_data = (void *)oxp_x1,
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ONE-NETBOOK"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "ONEXPLAYER X1 i"),
+		},
+		.driver_data = (void *)oxp_x1,
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ONE-NETBOOK"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "ONEXPLAYER X1 mini"),
+		},
+		.driver_data = (void *)oxp_x1,
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ONE-NETBOOK"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "ONEXPLAYER X1Pro"),
 		},
 		.driver_data = (void *)oxp_x1,
 	},
-- 
2.48.1


