Return-Path: <linux-pm+bounces-22724-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EBCA409DE
	for <lists+linux-pm@lfdr.de>; Sat, 22 Feb 2025 17:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAE37189C2FE
	for <lists+linux-pm@lfdr.de>; Sat, 22 Feb 2025 16:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C111E9B27;
	Sat, 22 Feb 2025 16:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="R5ZyCvhp"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A4D1F19A;
	Sat, 22 Feb 2025 16:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740241239; cv=none; b=ICWKYeeX2vTehoEvAKQ7eKyspHJUysqNNU27AgCcSa4f6P8HZmWGk0R9ZTth1KW5OSaFK1RXXvVKMdZvSln3g1ksAPS8kwp8GmqWctYVjJPijVPYyg+dGvysm2RFL+BZtIYIgmGt2NWWjDHcXDhcHJLmynf80dUIkqQicBptKgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740241239; c=relaxed/simple;
	bh=O1s9MppqBD24Uxeex5wnrbx/DM8VUSADzkNddc4Evsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PZC3x3jn5ZbvHnRzd6Cc8t4wU0HPdFnaBFrRrIvqyXIdDP6GIYOFTZLe7JVoxdKykIW8dqNnS2rlU/j+kp5W7PmZx/BP1JSYHW6K4b5BxaWQv5D1L83Dfm2MCBTkyeWBW7ZjFx0ZJ/obM9041A3GSWUI/Wx878U0YJvC8rlE3Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=R5ZyCvhp; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a05:f6c2:511b:0:cbc0:999f:73ad:33bd])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 3C7EF2E08C37;
	Sat, 22 Feb 2025 18:20:31 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1740241232;
	bh=2lNU/XHEtmmljo7nIHbwCfjs1skLNJxV0ouzdd8xI+A=; h=From:To:Subject;
	b=R5ZyCvhpqfXCSc0VZCZDs03z8IF3wat7OSmqQUMaNSn0O0ZZWdbspYRVqM0vldAQl
	 djbqfFd5iu3bcl2pZ6yTHhlKJPFzani3wqZ39B12UZie383CeeipD+weL/8ah1q9nU
	 qQURkB3qOZpDuKPSaoh78QQo4aNizV75ScPPKJOg=
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
Subject: [PATCH v2 05/12] hwmon: (oxp-sensors) Rename ec group to tt_toggle
Date: Sat, 22 Feb 2025 17:18:16 +0100
Message-ID: <20250222161824.172511-6-lkml@antheas.dev>
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
 <174024123248.13812.6826396738358864198@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

Currently, the EC group is used for the turbo button. However, the next
patch in the series adds support for the LED button in X1 devices, which
is only applicable for X1 devices. Therefore, rename it to prepare for
adding the second group.

Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/hwmon/oxp-sensors.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/oxp-sensors.c b/drivers/hwmon/oxp-sensors.c
index f8ffc78deedd..1c01636582d7 100644
--- a/drivers/hwmon/oxp-sensors.c
+++ b/drivers/hwmon/oxp-sensors.c
@@ -884,18 +884,18 @@ static const struct hwmon_channel_info * const oxp_platform_sensors[] = {
 	NULL,
 };
 
-static struct attribute *oxp_ec_attrs[] = {
+static struct attribute *oxp_tt_toggle_attrs[] = {
 	&dev_attr_tt_toggle.attr,
 	NULL
 };
 
-static struct attribute_group oxp_ec_attribute_group = {
+static struct attribute_group oxp_tt_toggle_attribute_group = {
 	.is_visible = tt_toggle_is_visible,
-	.attrs = oxp_ec_attrs,
+	.attrs = oxp_tt_toggle_attrs,
 };
 
 static const struct attribute_group *oxp_ec_groups[] = {
-	&oxp_ec_attribute_group,
+	&oxp_tt_toggle_attribute_group,
 	NULL
 };
 
-- 
2.48.1


