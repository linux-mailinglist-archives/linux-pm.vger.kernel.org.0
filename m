Return-Path: <linux-pm+bounces-22732-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B69A40A01
	for <lists+linux-pm@lfdr.de>; Sat, 22 Feb 2025 17:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 058E53BB27A
	for <lists+linux-pm@lfdr.de>; Sat, 22 Feb 2025 16:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744471FC0FF;
	Sat, 22 Feb 2025 16:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="kxXcRSWt"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0A113C82E;
	Sat, 22 Feb 2025 16:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740241811; cv=none; b=suwU445ahSGkkAMLFnnj4DvyAzXf4iKszf+QNU8wpeI4TALx3CvqhGVLiIljkG9qxZItQAm9Eh3MOs/VA3q54QKQz15I3ICWuXOIhr5hdMn5h+bA6SbwXJyiqzqV8IvHtItmhk9R0UCMjgXVIiEvu7mIbQqLnVJhE4C091RmoPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740241811; c=relaxed/simple;
	bh=IcrhvnCvUHCuMIGbETR9mEFI0UQMqOZZMgN+zXUaL08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YGcuQI/0QlqhZv68cbMx4IYLvGKVIJHqh5NjJ1TXJsuQ/4+0qAxxCe/Zwj/UCgU6VdVltOfMvDnZqUWbVmO2YKjVsJZZc4J7mhTMneVi3fcvj/r+SWKkDYd1hdj+h3WQni5kNnJz5E2mBU9u9iGk8gkuHg/vuPYuHJdy0qJd7gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=kxXcRSWt; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a05:f6c2:511b:0:cbc0:999f:73ad:33bd])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id A229C2E08C33;
	Sat, 22 Feb 2025 18:20:27 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1740241229;
	bh=SCCDeCBo29de2kp+oo0Ou/s/xpcOPZtLKqPSGiCiYCY=; h=From:To:Subject;
	b=kxXcRSWt4jvgn7kSEpopuqDzsi2g5izBeKilZcWfSJ4X2JwGLz+OhpAmcO/SkJJKX
	 Ubm6UpNqWdOwfjBdnGCG73LkiAJjqGyl7wBzwpunO/yTc4IAdXvnuM/qwGGt7XDrPh
	 /uht/drt1TQTqsVIETAC6hXwzbqIVUYeCHrdTIwg=
Authentication-Results: linux1587.grserver.gr;
	spf=pass (sender IP is 2a05:f6c2:511b:0:cbc0:999f:73ad:33bd) smtp.mailfrom=lkml@antheas.dev smtp.helo=localhost.localdomain
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
From: Antheas Kapenekakis <lkml@antheas.dev>
To: linux-hwmon@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-pm@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
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
Subject: [PATCH v2 03/12] ABI: testing: sysfs-class-power: add BypassS0
 charge_type
Date: Sat, 22 Feb 2025 17:18:14 +0100
Message-ID: <20250222161824.172511-4-lkml@antheas.dev>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250222161824.172511-1-lkml@antheas.dev>
References: <20250222161824.172511-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <174024122903.13680.15334843946299538340@linux1587.grserver.gr>
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
index 2a5c1a09a28f..117731652ab0 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -404,6 +404,10 @@ Description:
 			The charger bypasses the charging path around the
 			integrated converter allowing for a "smart" wall
 			adaptor to perform the power conversion externally.
+		BypassS0:
+			Same as Bypass, but the device automatically enables
+			bypass only while on the S0 state and disables it when
+			it powers off or during sleep.
 
 		Access: Read, Write
 
@@ -412,7 +416,7 @@ Description:
 
 		Valid values:
 			      "Unknown", "N/A", "Trickle", "Fast", "Standard",
-			      "Adaptive", "Custom", "Long Life", "Bypass"
+			      "Adaptive", "Custom", "Long Life", "Bypass", "BypassS0"
 
 What:		/sys/class/power_supply/<supply_name>/charge_types
 Date:		December 2024
-- 
2.48.1


