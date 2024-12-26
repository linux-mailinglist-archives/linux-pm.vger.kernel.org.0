Return-Path: <linux-pm+bounces-19753-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7561D9FCA83
	for <lists+linux-pm@lfdr.de>; Thu, 26 Dec 2024 12:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E1231615F3
	for <lists+linux-pm@lfdr.de>; Thu, 26 Dec 2024 11:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA08C1D432F;
	Thu, 26 Dec 2024 11:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="evYl73Yf"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9911D0DEC;
	Thu, 26 Dec 2024 11:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735212476; cv=none; b=g1VfpYzPwBOCljzT9hYniQp0qt5EgXKye9kxscYIh+04Av4z6u146Ea591NIbRK8r1GvxxbngqYMcxVEaKCz1sZscAnnjz/Q3DolzwL0U5a7J75DEx2rb2s7mfM1s/NOj+zUz6UsFDV65og8MzfCjXTI3khz2tGoYti+xj2cySk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735212476; c=relaxed/simple;
	bh=oFSjZVZojPLkVJ4Vu59k6TEXOmZFb/QUWrdEC0XgaXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fjCoVelN1++M0sMng4Oj8r2/zoGTV8gLMgVn+84wYF0oX+sfRpEK2hEWbIjoocoj53UBHRrCX0Tye/eekxiYpDTrsKtYCpLxMt4izHQv7j/zYiDMbEHQB2LssNCBeSaNaM/Q02Duy2JR+gVA9ztBCmCCMeaJHRI9maPmd0qPY8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=evYl73Yf; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a02:2149:8b14:7c00:7f68:a54:8871:387f])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 971C22E0058F;
	Thu, 26 Dec 2024 13:27:44 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1735212465;
	bh=s41bXvIWLLG8V+CzanXSlCo59G8kSYLm4mQGMG4i7+I=; h=From:To:Subject;
	b=evYl73Yft5pYMedTLWg9Wm2WiHPZ1rEa6Ei5pWZ4mjKRL00D+6sSCQ7vjlxpX2nSh
	 uMlGIo81l30GRn61ASV8kcDpHEbW8mM1hbtJ0Wls0yWEhg2vlR+//feCtbmHOrd2ja
	 lIIC33dAOlNiNsVFPmTX58GIp2Cl5YkOYIW61hhE=
Authentication-Results: linux1587.grserver.gr;
	spf=pass (sender IP is 2a02:2149:8b14:7c00:7f68:a54:8871:387f) smtp.mailfrom=lkml@antheas.dev smtp.helo=localhost.localdomain
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
From: Antheas Kapenekakis <lkml@antheas.dev>
To: linux-hwmon@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
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
Subject: [PATCH 01/10] hwmon: (oxp-sensors) Distinguish the X1 variants
Date: Thu, 26 Dec 2024 12:27:31 +0100
Message-ID: <20241226112740.340804-2-lkml@antheas.dev>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241226112740.340804-1-lkml@antheas.dev>
References: <20241226112740.340804-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <173521246528.10782.10935237896828499666@linux1587.grserver.gr>
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

Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/hwmon/oxp-sensors.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/oxp-sensors.c b/drivers/hwmon/oxp-sensors.c
index 83730d931824..5cb0da3e5d54 100644
--- a/drivers/hwmon/oxp-sensors.c
+++ b/drivers/hwmon/oxp-sensors.c
@@ -205,7 +205,21 @@ static const struct dmi_system_id dmi_table[] = {
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
 		},
 		.driver_data = (void *)oxp_x1,
 	},
-- 
2.47.1


