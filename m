Return-Path: <linux-pm+bounces-24413-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3ED3A6C976
	for <lists+linux-pm@lfdr.de>; Sat, 22 Mar 2025 11:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34E89468DEC
	for <lists+linux-pm@lfdr.de>; Sat, 22 Mar 2025 10:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A26214210;
	Sat, 22 Mar 2025 10:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="G9fSuztd"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD9A200BBC;
	Sat, 22 Mar 2025 10:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742639784; cv=none; b=DAA+AbCWGUtAnANqCgPp8KAkM4kiI0jP2f2iI6DUBZ2+DFhPznRP2ZKnfAStzSLaF0rSu8YpAiC9pQc1j6fj9NdwSoXksZZR8LKdB2UQAwveAvYV7/oE4qobtIXZafoyLYSOO+4H/sec/yZIsCb5g4ytEoUsOOE86ogRpugAy/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742639784; c=relaxed/simple;
	bh=hUKOcqhQp/TDrerLgUBgRAyI7jJWLtmRoc/95c//Ul8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XdRtkoVJpQEg4T1eZUAIrH4AMTDVs8BeWvRf0nQojzyI1mdWGJZQxfPJNli5b1vElrFlDMui1oqerokx0rAt0ivqJBjwNG1+geRiUYcf2cjHOTNYoAqvdoPls4AAXc5qif1XXdQn4J0N77pI28mj/gOM8kT0PFFD/2fzOVqWBd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=G9fSuztd; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a05:f6c2:511b:0:cbc0:999f:73ad:33bd])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id C9BC82E08C6B;
	Sat, 22 Mar 2025 12:36:18 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1742639780;
	bh=ewSfbNvtaLK0jqHvTSiVayJIjeB6chV6mPkIxmFui3w=; h=From:To:Subject;
	b=G9fSuztdabtWdsAsApNFHFjkdAAEUnwGJBFIt8J5nCHKh7HhuQeDQXvq7OfNi5jkm
	 O2DMp3uMq/1dJyoIPHdJ3zhso163HKCac3Up6RvlTDt39DeXcRxnZORIVejtNHzIvT
	 22zSgIl0ZbEJzmqCEdzYfk0OHIksMXcAmTE3ylBI=
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
Subject: [PATCH v8 04/14] ABI: testing: sysfs-class-oxp: add missing
 documentation
Date: Sat, 22 Mar 2025 11:35:56 +0100
Message-ID: <20250322103606.680401-5-lkml@antheas.dev>
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
 <174263978043.11274.15758543961267347337@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

Add missing documentation about the tt_toggle attribute that was
added in kernel 6.5.

Fixes: be144ee491272 ("hwmon: (oxp-sensors) Add tt_toggle attribute on supported boards")
Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 Documentation/ABI/testing/sysfs-platform-oxp | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-oxp

diff --git a/Documentation/ABI/testing/sysfs-platform-oxp b/Documentation/ABI/testing/sysfs-platform-oxp
new file mode 100644
index 0000000000000..091269ab2c8c4
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-platform-oxp
@@ -0,0 +1,13 @@
+What:		/sys/devices/platform/<platform>/tt_toggle
+Date:		Jun 2023
+KernelVersion:	6.5
+Contact:	"Antheas Kapenekakis" <lkml@antheas.dev>
+Description:
+		Takeover TDP controls from the device. OneXPlayer devices have a
+		turbo button that can be used to switch between two TDP modes
+		(usually 15W and 25W). By setting this attribute to 1, this
+		functionality is disabled, handing TDP control over to (Windows)
+		userspace software and the Turbo button turns into a keyboard
+		shortcut over the AT keyboard of the device. In addition,
+		using this setting is a prerequisite for PWM control for most
+		newer models (otherwise it NOOPs).
-- 
2.48.1


