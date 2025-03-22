Return-Path: <linux-pm+bounces-24414-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD6EA6C97E
	for <lists+linux-pm@lfdr.de>; Sat, 22 Mar 2025 11:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 492B81B66114
	for <lists+linux-pm@lfdr.de>; Sat, 22 Mar 2025 10:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C43F2222AC;
	Sat, 22 Mar 2025 10:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="0fLBGsEg"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1DF21D3D4;
	Sat, 22 Mar 2025 10:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742639786; cv=none; b=NCFvdDBi2XOKg061hYOG1CGfO0by/R19rerL3c+ZGwoks5gK4atWnwWTA6ZvmCHg2JoaFV+NNeorgxBSyxyqPaiimusde0IKuaZaqcjGQKvns3oe03N+YBDH9i9ld5T/XSlcCn4m1/pjB7sWS0+ETU6nu4FCij60Q60dISmnmn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742639786; c=relaxed/simple;
	bh=p4REON6CZ0/I/DUKXayqQKefOowL7KS980pmRo5rI5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oEAidfHS70d7HgahYsnzXYDu5mvxbzMlkmqRNIYOEetFzbyn0E0l7w+yY65+S3TvLZc8260X1cZtQmIufeDXFfU68eDHmGJ8wgKI5kpeVelUjwpZWZOB7sZvcgG8a0Ramz+upFwmXN0mVD5Vonm8L5d3z/0IE1igDBt/3YRHnN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=0fLBGsEg; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a05:f6c2:511b:0:cbc0:999f:73ad:33bd])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id F13902E08CBE;
	Sat, 22 Mar 2025 12:36:20 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1742639782;
	bh=p21Tm8CoWmwVucFoJV4zj39bOOoxdC5O9pA0/pdZXKs=; h=From:To:Subject;
	b=0fLBGsEgh4YNjz0S2X5TqeddoAAAqWtOZWcsekMg3Ajzc5zDa0+0aMXAlZs+GAjRj
	 1P5yFGI6F+axTpymxFVmbxZjBeZgUd/rx8JEkhv7sDCJsnfIGAMarB1wESOzdnAL9L
	 WcNtj9agKwchz78c1GI9qmyMJIaJYt7k5eYMs7bo=
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
Subject: [PATCH v8 05/14] ABI: testing: sysfs-class-oxp: add tt_led attribute
 documentation
Date: Sat, 22 Mar 2025 11:35:57 +0100
Message-ID: <20250322103606.680401-6-lkml@antheas.dev>
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
 <174263978258.11388.1209613350641023956@linux1587.grserver.gr>
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
index 091269ab2c8c4..ccf8e5902cf86 100644
--- a/Documentation/ABI/testing/sysfs-platform-oxp
+++ b/Documentation/ABI/testing/sysfs-platform-oxp
@@ -11,3 +11,15 @@ Description:
 		shortcut over the AT keyboard of the device. In addition,
 		using this setting is a prerequisite for PWM control for most
 		newer models (otherwise it NOOPs).
+
+What:		/sys/devices/platform/<platform>/tt_led
+Date:		Feb 2025
+KernelVersion:	6.15
+Contact:	"Antheas Kapenekakis" <lkml@antheas.dev>
+Description:
+		Some OneXPlayer devices (e.g., X1 series) feature a little LED
+		nested in the Turbo button. This LED is illuminated when the
+		device is in the higher TDP mode (e.g., 25W). Once tt_toggle
+		is engaged, this LED is left dangling to its last state. This
+		attribute allows userspace to control the LED state manually
+		(either with 1 or 0). Only a subset of devices contain this LED.
-- 
2.48.1


