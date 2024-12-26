Return-Path: <linux-pm+bounces-19758-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDF49FCA93
	for <lists+linux-pm@lfdr.de>; Thu, 26 Dec 2024 12:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9814C163122
	for <lists+linux-pm@lfdr.de>; Thu, 26 Dec 2024 11:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB421D54C0;
	Thu, 26 Dec 2024 11:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="NPA5kZ3Y"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EAE1D1F56;
	Thu, 26 Dec 2024 11:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735212480; cv=none; b=GPKFytbnpR6BZY5KCiu9gALiXXQd7hOGUsZn36VQ7e2PnKPE8ku+mgmOyja4e58d67tErMWtZrwZcTIZ32GdsA9hmFFkYol/NVXC1DYsODj2GQ/BEOXRZzGhRlZGgjiznKaHFn9J7txjNtsD1ULI0XFz6dN9P4gxgT9VQUadxp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735212480; c=relaxed/simple;
	bh=jWSL+2gtoB7puBo7qkUCPOJZjy5PZD3UNJkSagooUf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=divqqqAomtNDlSNC/Igm2f4ajughBYLSYlXRSGL7e7yHXIEveNgkZVwqMbgfX2w0vEJ5ZGlQOJrdCKXtKkmezvABi7SKiWraoFkegVvTCIxJF4XDdwMvXsNIDRnJDWcjJ9juqY+QO3h2H6CH1Zw2RouUI6Q2C6dxT5GcS8C/dGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=NPA5kZ3Y; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a02:2149:8b14:7c00:7f68:a54:8871:387f])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 72BD22E0087C;
	Thu, 26 Dec 2024 13:27:49 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1735212470;
	bh=ln9ypNRnxLSyUryhVcduspBrecNqwBgcHGHtva+ELhY=; h=From:To:Subject;
	b=NPA5kZ3YYSyYKAIveoVLBdKop7Mr2W1bRBvJFDKd8whgMNXFCxwChdAalK00wI0kZ
	 YhApiLydDT/fupz6RhxZ6CBGjTLfM89rmVrrhH5TeMHy80jz+EAa0DJ/lCCVH2z1rQ
	 HuW0n39kKU2Vv9lVvGPdLSBIWMBBrf92zx6tu31E=
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
Subject: [PATCH 05/10] hwmon: (oxp-sensors) Rename ec group to tt_toggle
Date: Thu, 26 Dec 2024 12:27:35 +0100
Message-ID: <20241226112740.340804-6-lkml@antheas.dev>
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
 <173521247012.11015.17946237438914856518@linux1587.grserver.gr>
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
index 8683d708d5a2..30b7020ea836 100644
--- a/drivers/hwmon/oxp-sensors.c
+++ b/drivers/hwmon/oxp-sensors.c
@@ -877,18 +877,18 @@ static const struct hwmon_channel_info * const oxp_platform_sensors[] = {
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
2.47.1


