Return-Path: <linux-pm+bounces-19756-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 327A49FCA8C
	for <lists+linux-pm@lfdr.de>; Thu, 26 Dec 2024 12:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DF8D1882FAF
	for <lists+linux-pm@lfdr.de>; Thu, 26 Dec 2024 11:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52ED51D5146;
	Thu, 26 Dec 2024 11:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="iCfVf2mD"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F9C1D318F;
	Thu, 26 Dec 2024 11:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735212478; cv=none; b=DCtV+NaIzHC2AB7Z/8grpY5/ExhQoHdLxb2yY83DuR9wAqf7tDdPsP6vtOlz4VTiGM6bud0PgC+BXJ6F54gCyUXFw8+TZciyDb/doOlECpzQQXoojE5Wjw3TePNmVDBQui0LbW/EPU2zGWVBIytQjD4rBtFTQt/BVGYETFyJ/Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735212478; c=relaxed/simple;
	bh=vc8davraFvBL1ufBT1fYM8D9/dpVmLSnSpy0OZQYBXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gWBA1WwcGF9Xi1TbX6KuvbciilD3Bcj5CzK1eZkHD+U6n6OiWuB8g72pyWgUf7uZueDTWhCt5dTje5q7BFQcIhS2Uxeaha35zi18zyEUj99wBf36j9dqjeoi/i1SEWfTdStMEhYnGIE10zhm0YUODmG6A4Abhx8gP+fdZTs+hLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=iCfVf2mD; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a02:2149:8b14:7c00:7f68:a54:8871:387f])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 4081F2E0069F;
	Thu, 26 Dec 2024 13:27:47 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1735212468;
	bh=lT7UjWteYmK5XZUxENvFOAbI7A5PTsvIpqIY55g/x18=; h=From:To:Subject;
	b=iCfVf2mDtapDyzrULsEVsGez0tU+rWWi9apjPdOLPM3Q2MZBl2PKLOWLFcLfciEXQ
	 WtyEpf5IifAlGtK43OuUrGwZeFe9EOGWsMJyfsaIKmhE+B2UiPxXpCB1EErl6WR6eY
	 SeOb5HeTXpyutEJKFM1n/Rx9NLBzxI9B3GjkprPw=
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
Subject: [PATCH 03/10] ABI: testing: sysfs-class-power: add BypassS0
 charge_type
Date: Thu, 26 Dec 2024 12:27:33 +0100
Message-ID: <20241226112740.340804-4-lkml@antheas.dev>
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
 <173521246792.10914.16647945750230088150@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

OneXPlayer devices support a conditional bypass type, in which the
device will only perform the battery bypass while in the S0 state.
Therefore, add BypassS0, which is a state in which the device
conditionally bypasses the battery only in the S0 state.

Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 Documentation/ABI/testing/sysfs-class-power | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index 45180b62d426..1f5a56aa5c70 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -404,12 +404,16 @@ Description:
 			The charger bypasses the charging path around the
 			integrated converter allowing for a "smart" wall
 			adaptor to perform the power conversion externally.
+		BypassS0:
+			Same as Bypass, but the device automatically enables
+			bypass only while on the S0 state and disables it when
+			it powers off or during sleep.
 
 		Access: Read, Write
 
 		Valid values:
 			      "Unknown", "N/A", "Trickle", "Fast", "Standard",
-			      "Adaptive", "Custom", "Long Life", "Bypass"
+			      "Adaptive", "Custom", "Long Life", "Bypass", "BypassS0"
 
 What:		/sys/class/power_supply/<supply_name>/charge_term_current
 Date:		July 2014
-- 
2.47.1


