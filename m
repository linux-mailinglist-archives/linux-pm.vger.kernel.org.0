Return-Path: <linux-pm+bounces-24292-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE4EA696FD
	for <lists+linux-pm@lfdr.de>; Wed, 19 Mar 2025 18:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37D10463653
	for <lists+linux-pm@lfdr.de>; Wed, 19 Mar 2025 17:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E643320966B;
	Wed, 19 Mar 2025 17:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="hLbOpP6Z"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF931DF269;
	Wed, 19 Mar 2025 17:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742406931; cv=none; b=SmCF039bUV3H6IQbCEqqgQajuI+Z6fesSHTGPwwkKD1bFpWfx29gMwSzXeIyN0m5HF3gly0v6GZH47KIZ7K5gV4+w5Ui44lvTTJYc7AubkXV8Gc+cG+6pgrRALAxt0rrMXI0xA7qdadOqVS2qSHL7ZEUOdjq5lI+Hc9/mXfKnZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742406931; c=relaxed/simple;
	bh=tdiUN/gA808UkpN6g6l5ag5+wM4qUAmQudO57SdnzHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=afB8KILEF+b5sBCnXxWKpiO7Hi9W63yF9nvJNAVzc3SSkhobOu/I3uv/QldfVgxZS7mf4l6RJhxyRgoae8yqyUnmN8crmp4v2B7k4sRnV1C8k0Lu/rxuer17AMaxXmzExTG85RQq8Y1m8af9coXzImwJuuwCWXjoxqk6LPRPRO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=hLbOpP6Z; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a05:f6c2:511b:0:cbc0:999f:73ad:33bd])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 2E7482E09308;
	Wed, 19 Mar 2025 19:55:18 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1742406920;
	bh=ZipG212NCF1KOV9rJuhRvhXErr3HGLMwbPUXCMDhaTs=; h=From:To:Subject;
	b=hLbOpP6ZW5jHVM3grIOKkezUUOyOcDWPuktL2Db55Y5rx8vk4uCDK6Fbmh/eBkjDU
	 y2ie3vawnHO+eOk17GdCQMmKzJPACQhJBOkABQ9sIUcfYt+oJD7MeHug6W9DBnnriJ
	 bezdpiNm48baOtv+BtsHuKCt7fkJR/1EfZdyyHpo=
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
Subject: [PATCH v6 01/14] hwmon: (oxp-sensors) Distinguish the X1 variants
Date: Wed, 19 Mar 2025 18:54:56 +0100
Message-ID: <20250319175512.27059-2-lkml@antheas.dev>
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
 <174240691980.24342.5226663537575734284@linux1587.grserver.gr>
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


