Return-Path: <linux-pm+bounces-24293-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E955A696EB
	for <lists+linux-pm@lfdr.de>; Wed, 19 Mar 2025 18:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE53B19C64E4
	for <lists+linux-pm@lfdr.de>; Wed, 19 Mar 2025 17:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B290720ADFE;
	Wed, 19 Mar 2025 17:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="fD0Xkhxn"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3854F1DF996;
	Wed, 19 Mar 2025 17:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742406932; cv=none; b=NVvk9/IIYTHovVx8FTuCwy1aY70kS6pNRpltD/mcV++FCrqnek7rEqIg9xBe5KIS7wPyP4NVau13qXRuf0Zp3xTog2Z3bRVo6FtFmUjgOV36X19+XrzvNwJtBq3MgNQpS3PRC4LOAd2wFFrVBZ8EhuQso7MM4d0Y6Y7nO9qlAKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742406932; c=relaxed/simple;
	bh=Gss3XMvEr6F8jZFASLjg30cmvsp+TDCFV0lyB/oGlnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dr7J80+h6q5p7LlSWi17BZ6bKak6ZV8cppiCd9QGxY22B26aXf3GwsfSXX2SCBCoS4ecYc76J/EDDy6oanWEXeOn/LHz4F7K5an7f8vd5s+ckWCiNTMFNd71y0187q53+7V6o7NpnHRVVnT92T4LC66WBgu5/LobyG2Hg+SzGKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=fD0Xkhxn; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a05:f6c2:511b:0:cbc0:999f:73ad:33bd])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 5A54C2E0930B;
	Wed, 19 Mar 2025 19:55:20 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1742406922;
	bh=LSdJAQ0bA/H736JjZxupZ8TrXX+Ae+7knS+jEmuGyQg=; h=From:To:Subject;
	b=fD0Xkhxnmv6e3juxY48P/wIbYyZrtKTq6siplhuzAgME6l45WZWY1z9JlaEYgJ7aI
	 rEvCZfz7ltHyVEG1aYOb56gmJpGzhHXM3NZatDnnZnWEXtAqhZQhSVc0k2AYepo2it
	 1GDJSanHlpqqBrMt3JcobQvyJf+2KI1JVcK2UEuA=
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
Subject: [PATCH v6 02/14] hwmon: (oxp-sensors) Add all OneXFly variants
Date: Wed, 19 Mar 2025 18:54:57 +0100
Message-ID: <20250319175512.27059-3-lkml@antheas.dev>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250319175512.27059-1-lkml@antheas.dev>
References: <20250319175512.27059-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <174240692193.24418.10812033760188993737@linux1587.grserver.gr>
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
2.48.1


