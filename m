Return-Path: <linux-pm+bounces-23692-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E27A583A1
	for <lists+linux-pm@lfdr.de>; Sun,  9 Mar 2025 12:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2F2116DE2E
	for <lists+linux-pm@lfdr.de>; Sun,  9 Mar 2025 11:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002711CAA81;
	Sun,  9 Mar 2025 11:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="3DLumRJ6"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2A71A9B29;
	Sun,  9 Mar 2025 11:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741519291; cv=none; b=Da69EOvGnmU01Csea2VQXD9zoxRXWu5G2WWP/Yonhh2NfUABfMh+h6KQCGl0ze16/IqvE6aJrj/o8JgppLXOkPc7HSpWZmz1uTzzS8EqcayOYzaINU/RIeqiM1blerq8Y/xAA3sybXsTS2a53ckGucJxT2Bn1vxRCFuW0FIAB7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741519291; c=relaxed/simple;
	bh=s38XCXeF8aPWEyOp56XQs3PsfxkLKNIQsEdGpBoujz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nFaSFRU6CzoX2kP+DEgfhQP0+Qxd31Q/Y7wJEI0UMzHoASMr7N1Vf04h7dm+lN+OxmHI+VxcmRqXJqJdQqx5letg3ZliPeswP8FqC+OLPzQvyRlzn/ug0e77FC8YXj7IHurPfENzncT8JCZmCjgdaoX5NwXZh9SFgu/aqzWiuGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=3DLumRJ6; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a05:f6c2:511b:0:8d8a:5967:d692:ea4e])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 21A8B2E03EE5;
	Sun,  9 Mar 2025 13:21:20 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1741519281;
	bh=4M2qvoxUG01q+gCBgRvG0VcejFL2w259EpXKpnylzkw=; h=From:To:Subject;
	b=3DLumRJ6JW40B/IJAe2FlrgGZChjekbl7ttgrh0xXjF7h/qe4v2rwPb481ZPiyvlJ
	 XIm0pRwASqw0/kEIJHtfbbAaDMac7Gw9aGJo8Lq+EnXk+otVQPQLMg+RMj4ccY7ElZ
	 2Q9K7LzJEUc/5lqEH3sRHSd7v506lsxiDZst+8AQ=
Authentication-Results: linux1587.grserver.gr;
	spf=pass (sender IP is 2a05:f6c2:511b:0:8d8a:5967:d692:ea4e) smtp.mailfrom=lkml@antheas.dev smtp.helo=localhost.localdomain
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
Subject: [PATCH v3 02/12] hwmon: (oxp-sensors) Add all OneXFly variants
Date: Sun,  9 Mar 2025 12:21:03 +0100
Message-ID: <20250309112114.1177361-3-lkml@antheas.dev>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250309112114.1177361-1-lkml@antheas.dev>
References: <20250309112114.1177361-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <174151928140.28666.16737544042267847744@linux1587.grserver.gr>
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


