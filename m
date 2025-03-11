Return-Path: <linux-pm+bounces-23866-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E48ABA5CB36
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 17:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16E693B83E8
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 16:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A73261366;
	Tue, 11 Mar 2025 16:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="fXX8kXO8"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C460260A2A;
	Tue, 11 Mar 2025 16:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741712059; cv=none; b=oQLCEZj8aL5VRZ2dTlnhnsQhFCx4ds+Msif+/4FYbL764R+dTLaiZuUsYT99Gnrwmi7aT8JZ0txKD+TpujbxRUo4gRBhSkNTa6yqbvSbQrVVLwdNw6r4typ8EKql4OzlXy1I26vHwXdmDaKnu22Y3jzOdFVET/NB2sYZOqHMwOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741712059; c=relaxed/simple;
	bh=kmv3XjQR3LxCUV12vUqlHURIuf90Pq99ScjhPq4M/Hs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fC3ycDoF7aWCII+zIZqiwHARFxrmrK3+YeKv6aAhHcdLCCTuojNvXZTd18p8ZvU4cRQHunBN/agn8R0Yq85omyDaU6w5wVrM5T2clOBynwa7du4LNJTeILVFbPVeQwzhP1UUW6/rw4vzGHbQcQwLR8KvQTA8DB352ipMzzHIhtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=fXX8kXO8; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a05:f6c2:511b:0:cbc0:999f:73ad:33bd])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 656BF2E0922F;
	Tue, 11 Mar 2025 18:54:12 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1741712053;
	bh=YtLt9XdehsGGA86qaXpSdbFKUYdPorwNx5IDHL9oMvc=; h=From:To:Subject;
	b=fXX8kXO8aqeIL443OSWAI6gC7wYERTMT2Wq8zivYS0rxz1UawzihQqjVAFKm6cn7Y
	 d41V/r4Nw9egQ15bpsCh2YgvVvk3Q/mvOAvI5MtumcdSMUH3i/ebFEbvnpFcGdodUY
	 eK9msW2C1pzzTlUHdSkob5TTenHe1cj5oyGH+hKU=
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
	Antheas Kapenekakis <lkml@antheas.dev>
Subject: [PATCH v4 02/13] hwmon: (oxp-sensors) Add all OneXFly variants
Date: Tue, 11 Mar 2025 17:53:54 +0100
Message-ID: <20250311165406.331046-3-lkml@antheas.dev>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311165406.331046-1-lkml@antheas.dev>
References: <20250311165406.331046-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <174171205366.19167.17638543065004868049@linux1587.grserver.gr>
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
index 5a4230ad3757..f7a64fbc8f33 100644
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


