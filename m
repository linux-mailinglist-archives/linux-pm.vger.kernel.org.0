Return-Path: <linux-pm+bounces-24295-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0685DA696F3
	for <lists+linux-pm@lfdr.de>; Wed, 19 Mar 2025 18:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE9DE19C7AF7
	for <lists+linux-pm@lfdr.de>; Wed, 19 Mar 2025 17:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D764621147C;
	Wed, 19 Mar 2025 17:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="rQn1BDFs"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A1820B20D;
	Wed, 19 Mar 2025 17:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742406934; cv=none; b=QAhEnT+sOu2CS32DCuzB3ZXG44+1uQyUhUE9kdbuOI3FYE9kSN5yKjZqkhbaEPPmwt8+VwlIEmNEVAcDaKMCUhotqsCvrAWBmvWXk2slM2nZeeMkIh57Obgsk7RDYxlCYaqmZOYEHlGgx1wKExagBkOtQvqJvL5cHtcbmQ+/LCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742406934; c=relaxed/simple;
	bh=fxo7YKLqPTQqpfZWj4WWOS727JYFwPvRqMG5VgdGezM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GNCEKnas5fjg5NfkFbfX9I0EmD1VdFAV+H32QXcI4YXoAxTfvQhU5u/MForidHvm+XSL5cK7qTvgVrwzgz3So5w0qEOpwu5NQVv/hv5+L6sG/5WMG4QIaIiUO7S+u9VRnuqgsDnG0ERn1VREizdvhZDxBvjml4F+wrJzOXhe620=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=rQn1BDFs; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a05:f6c2:511b:0:cbc0:999f:73ad:33bd])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 3C2A12E09313;
	Wed, 19 Mar 2025 19:55:25 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1742406931;
	bh=3xy9aNmFP8vUFziUuxWin7iyjv/4K1w0WXqL+Rp5p7M=; h=From:To:Subject;
	b=rQn1BDFsp1xUNBR/gaZ/bOCX8ByV3JAdgAcS6+8L+sXG9YGGw3nFcA0OWmuicpWuC
	 iEw5EhIpcJFGO4Hkjy8Dwl+fSwRjMPIplQaY+OXYxiI5kjC2rHVrK9Gkpnozg/w9HF
	 +AOu3aCzh/waulsGxligfRYT9N3BCT92j5Cq83lA=
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
Subject: [PATCH v6 04/14] ABI: testing: sysfs-class-oxp: add missing
 documentation
Date: Wed, 19 Mar 2025 18:54:59 +0100
Message-ID: <20250319175512.27059-5-lkml@antheas.dev>
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
 <174240692963.24621.5636643658752178705@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

Add missing documentation about the tt_toggle attribute that was
added in kernel 6.5.

Fixes: be144ee491272 ("hwmon: (oxp-sensors) Add tt_toggle attribute on supported boards")
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


