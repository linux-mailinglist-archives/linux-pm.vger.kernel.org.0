Return-Path: <linux-pm+bounces-25658-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A19A92474
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 19:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C9F47ABDF6
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 17:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561B42571AF;
	Thu, 17 Apr 2025 17:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="nQZDLXkC"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8982561DF;
	Thu, 17 Apr 2025 17:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744912412; cv=none; b=o9rSKdDBhBtI7Xo/Rc16PNP+JrjJ3pLv7UjiMu3MrkvCCc8BY+EqkVSUgmU3vHh0J2JXQnt10DSyg9QZQHGmCz0aYSOiMjRkYlwn2eA+BqTlgZpDlABUOcxah4DdibN3ucqK7hwBu4Y2G+S1XZvfiVvJ6g7OVh6Z3TbcHDEr9es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744912412; c=relaxed/simple;
	bh=azP9R//yUd3y5xSiHZSqZVFVUGg1StaFMpCzpZ10L/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DWHAQPmzjxfwCPg2GyCW0fISf5Pd7AEBWW4leVWKRvWY4nZ49drtNOH2uf5RCtcFUozfbGEjgrpTEQKVUVnTAvRYc8GoOlN8ZJ++vf2qAbEIuClw+PBEh4TZDSSUHL8ISLMNJOCdAOq3SeGoni+lXU9FB9w5RqfA7LpXBCHfRpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=nQZDLXkC; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a05:f6c2:511b:0:cbc0:999f:73ad:33bd])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 84C632E0873F;
	Thu, 17 Apr 2025 20:53:18 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1744912400;
	bh=B46fOP7F4O5Q9kYipJf9WysyVm2OwQxbttBN2mgY+e8=; h=From:To:Subject;
	b=nQZDLXkCo6y8D5mobePHaSkXW4MLoaPxvk3fI3MsohATLkY9TstJm4XuIJkHodPlO
	 pVNtrm11jdtFkSFWRddtEcyEEvAfwDExqTXzFP79wanp8j0MlkA2LKLXlGZjaDSKeI
	 kavbkg5H5x5hWrHPdXyDSY1/xBXRLdv5ejJkqbuA=
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
Subject: [PATCH v9 01/15] hwmon: (oxp-sensors) Distinguish the X1 variants
Date: Thu, 17 Apr 2025 19:52:56 +0200
Message-ID: <20250417175310.3552671-2-lkml@antheas.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417175310.3552671-1-lkml@antheas.dev>
References: <20250417175310.3552671-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <174491240014.24615.16762837287985019775@linux1587.grserver.gr>
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
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
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
2.49.0


