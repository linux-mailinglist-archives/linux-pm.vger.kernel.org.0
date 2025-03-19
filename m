Return-Path: <linux-pm+bounces-24296-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57AD0A69729
	for <lists+linux-pm@lfdr.de>; Wed, 19 Mar 2025 18:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D684746118A
	for <lists+linux-pm@lfdr.de>; Wed, 19 Mar 2025 17:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3625213E79;
	Wed, 19 Mar 2025 17:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="X2vzH9qr"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E826212B29;
	Wed, 19 Mar 2025 17:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742406936; cv=none; b=MbH2cUw+iN85E7Z7bJnb2BeSbOtHWEvB4/YJdOWZJnltzXFG81oZB73UjlpdbaIU6SRKb556lVz13x21PFVi0Jninwsg/eYV8BEpJDhAtNrJfkJvyiuPp6iukKjKEGRvxew/nJpIbbZ/f0bttfOYjZFzNnOD6w5eSVAOpKFTCSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742406936; c=relaxed/simple;
	bh=R2tsTvFHU28NYUTGbrvpyfcsC2ZaMbVploeaNWvqSmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oinBcfoUqZn9xb1LfKwxgSu7oVT1iL+XlFJgyV2X5kyToeYieyhPcDzHi/OSpYuB9KEHFO4Li0hg7GppJhURq1o3WAw5EKfNiMQl2BPqGLE0dlM2VheuT27Qhm7mi6gCoGpUzcmd+dmRjrrLMzZTCrS9cvBgkBf/Hc0NTnID7zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=X2vzH9qr; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a05:f6c2:511b:0:cbc0:999f:73ad:33bd])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 94D192E0931B;
	Wed, 19 Mar 2025 19:55:31 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1742406933;
	bh=mJgmIe8lOvPxjf+wLyD8RBgL5ygfb/bNCRktNzVRiR4=; h=From:To:Subject;
	b=X2vzH9qrgoB+0wWVp+/GrTRTecku0mUomLbvxbUByzl9GWxToV98lsE2wKu0sX/rQ
	 LI13iaPFr0SqjUaa0J4Zmh0YgQJD5HjxUVq1OB2G/ulCjD4Z3DfsWxfsMtbNWwtK5n
	 EpilLd56iG3qiH0ou3lhfVu8ABhTKFoXI090VbcQ=
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
Subject: [PATCH v6 05/14] ABI: testing: sysfs-class-oxp: add tt_led attribute
 documentation
Date: Wed, 19 Mar 2025 18:55:00 +0100
Message-ID: <20250319175512.27059-6-lkml@antheas.dev>
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
 <174240693322.24731.17671220535705397611@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

Adds documentation about the tt_led attribute of OneXPlayer devices
to the sysfs-class-oxp ABI documentation.

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


