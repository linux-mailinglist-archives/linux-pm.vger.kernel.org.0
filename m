Return-Path: <linux-pm+bounces-25660-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 014B1A9247B
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 19:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 948081B60815
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 17:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A042580C2;
	Thu, 17 Apr 2025 17:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="eI5bkfiC"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FDD2571CA;
	Thu, 17 Apr 2025 17:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744912414; cv=none; b=Dp3rf9+wQcNoeLpT0ZFlRBVNPLoCfyGbu0RhiXCc2cB8HcJ3QG6s/wEZ1r14ycTg+K3O+WSPv2iukeKiJbRVFCVSaPuP/C+yY4WiDmkd11DxsZl/iwwRPPoUgcpeuR/pmkkpusgydwo+FJwkeRGNm0GQZwtf0lWru88M0M8olkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744912414; c=relaxed/simple;
	bh=7z9+NBdXvgZs8VMPVVMsPGq7ziNHtwhTTOGs0r+Jai0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lpr8n7VmJnZk99NLqDcqaLW0wRo9C14Eiy5wEkDevGEX5/EsbDQfvVS7wbWmeYUtilPV5+QIjBzrdCvtEEGFwH7IOv2KPDyfhratZV5bRlgs4GNWeamwzx3GZkJMG1jfEuDZy+PcO0fHHiKLdgWrgINqsqNwQZmQROk8dGoWefM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=eI5bkfiC; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a05:f6c2:511b:0:cbc0:999f:73ad:33bd])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 29EA92E088D8;
	Thu, 17 Apr 2025 20:53:27 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1744912409;
	bh=2oyeEHL5RGXZ13onh6k9JhX2IrdUxRPNzwIc6bpWggA=; h=From:To:Subject;
	b=eI5bkfiCjE39Na+a+PLeO9hw96UbRO+03N4O8OnmGFoj8RpnUC7uXzPpCbYj/OPOY
	 GHXmDrAgnCBcOy6QmarNJvHMe6Ntya4ykULOBclqayGGVwZKRBiU3EA25aufGbgiY9
	 pOJdJ6HU1JWnY/MZf9jAHUpyZyqOjQ6ftzMmqIKQ=
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
Subject: [PATCH v9 05/15] ABI: testing: sysfs-class-oxp: add tt_led attribute
 documentation
Date: Thu, 17 Apr 2025 19:53:00 +0200
Message-ID: <20250417175310.3552671-6-lkml@antheas.dev>
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
 <174491240878.24952.11919427039514044173@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

Adds documentation about the tt_led attribute of OneXPlayer devices
to the sysfs-class-oxp ABI documentation.

Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 Documentation/ABI/testing/sysfs-platform-oxp | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-platform-oxp b/Documentation/ABI/testing/sysfs-platform-oxp
index 091269ab2c8c4..b3f39fc21dfa8 100644
--- a/Documentation/ABI/testing/sysfs-platform-oxp
+++ b/Documentation/ABI/testing/sysfs-platform-oxp
@@ -11,3 +11,15 @@ Description:
 		shortcut over the AT keyboard of the device. In addition,
 		using this setting is a prerequisite for PWM control for most
 		newer models (otherwise it NOOPs).
+
+What:		/sys/devices/platform/<platform>/tt_led
+Date:		April 2025
+KernelVersion:	6.16
+Contact:	"Antheas Kapenekakis" <lkml@antheas.dev>
+Description:
+		Some OneXPlayer devices (e.g., X1 series) feature a little LED
+		nested in the Turbo button. This LED is illuminated when the
+		device is in the higher TDP mode (e.g., 25W). Once tt_toggle
+		is engaged, this LED is left dangling to its last state. This
+		attribute allows userspace to control the LED state manually
+		(either with 1 or 0). Only a subset of devices contain this LED.
-- 
2.49.0


