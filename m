Return-Path: <linux-pm+bounces-24415-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE73A6C982
	for <lists+linux-pm@lfdr.de>; Sat, 22 Mar 2025 11:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC63B1B66540
	for <lists+linux-pm@lfdr.de>; Sat, 22 Mar 2025 10:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9535822540A;
	Sat, 22 Mar 2025 10:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="JxNFwG0n"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F75F224243;
	Sat, 22 Mar 2025 10:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742639788; cv=none; b=BHzUX1ToX3dhIvPmX+h/JGO1U5fI6NSXJXlD9VpgzF+4ie6DIo+nZWpKk6tJbcTE7Pzdq5soVWC82ZOUf1fTWdk4ZwsWXT+/EW2sgOOK79Q6siJPg5ZuXl1blOz+xkMeFB2KrAqQgaq6dUZ2IZ0Y2uBPma5v5+MWUEJKnznN32k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742639788; c=relaxed/simple;
	bh=/KvgUz8i7N6/hLJGxRzMSZh3JYF/OFtnmAqOqgar4d8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S/ml+Da+xA9bvG5Vp4iBdLkj04GBEsVw0NtQM1ZzTegaPuSeyWFyoqKv0MLZKZbgCdkAGj7ieQKIwi8thsiPMGSQ8xinqXEPMmxervXci8v8cKFpr0sgtXQmaVBV4XOaJac3Rfwdon5l00m15BKr5SrlduZtNePTN2CFO9WTpiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=JxNFwG0n; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a05:f6c2:511b:0:cbc0:999f:73ad:33bd])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 13CAE2E08CC5;
	Sat, 22 Mar 2025 12:36:23 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1742639785;
	bh=lIAHailjUftj3R7GYA/7XBDg/ivH7rMaXGjU6mpPrlE=; h=From:To:Subject;
	b=JxNFwG0nwHBZe3JUpWgpKzTg39kFwBgsKX3T3Z3I68wedBsUD4YFQTFSD6dwm3D02
	 ex85t8qXkYljP/vAJdfiH3vbC07OGwMfT+MyGJQlfPtDptBL9PJwvMhrjxhFWuJscQ
	 5Ozn6fVTi5b+ZE1azaS8UPd9qGAQQNeLPV6q3bNQ=
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
Subject: [PATCH v8 06/14] platform/x86: oxpec: Rename ec group to tt_toggle
Date: Sat, 22 Mar 2025 11:35:58 +0100
Message-ID: <20250322103606.680401-7-lkml@antheas.dev>
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
 <174263978470.11480.11986584464237392428@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

Currently, the EC group is used for the turbo button. However, the next
patch in the series adds support for the LED button in X1 devices, which
is only applicable for X1 devices. Therefore, rename it to prepare for
adding the second group. And make it const while at it.

Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/platform/x86/oxpec.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/oxpec.c b/drivers/platform/x86/oxpec.c
index dc3a0871809cd..ee37070ec54fc 100644
--- a/drivers/platform/x86/oxpec.c
+++ b/drivers/platform/x86/oxpec.c
@@ -681,18 +681,18 @@ static const struct hwmon_channel_info * const oxp_platform_sensors[] = {
 	NULL,
 };
 
-static struct attribute *oxp_ec_attrs[] = {
+static struct attribute *oxp_tt_toggle_attrs[] = {
 	&dev_attr_tt_toggle.attr,
 	NULL
 };
 
-static struct attribute_group oxp_ec_attribute_group = {
+static const struct attribute_group oxp_tt_toggle_attribute_group = {
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


