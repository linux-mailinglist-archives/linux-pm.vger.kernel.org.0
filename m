Return-Path: <linux-pm+bounces-25661-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E5DA92480
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 19:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF9F17B075D
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 17:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37E52580F1;
	Thu, 17 Apr 2025 17:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="nUCn0eye"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA78B257424;
	Thu, 17 Apr 2025 17:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744912414; cv=none; b=ewhhu45TpTpfcg/ujXHnCyToWmWJCz0W+C1tMg+rsFeBOdKjLyVyzXKzn8gXEZHQ1QWDDiu8IFsV3zyH06HR2pavyuinPwkr93cEuR+u+26Ly8AVZDm8GVlkksn4IXxwqxFyG8cillStsS790UigDh6ply2anHGQbpOkAHPsr8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744912414; c=relaxed/simple;
	bh=yYF43Unru39rskLB6o15FW18gb2pC1rZY8MRgF53hIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sVS0BmvUFFqascKtBjRJ0oSW9NxgoPSSlpyXGiICMp52GVOaeBxO9IoV67rj/ibVYeP6hx7izCjCNYntZe9qLDLLu1cUnRysccIcaQu/F5wtm7Atja4N0B3jOBhLYeaTz7cPK58eIN7G7ChBJkzZhUyKZ4sHBihZV6Y9cIdnug0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=nUCn0eye; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a05:f6c2:511b:0:cbc0:999f:73ad:33bd])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 43D182E08A29;
	Thu, 17 Apr 2025 20:53:29 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1744912411;
	bh=rPiuh34oF+Te4yOv2w+rVAfjfi+m0fUEXD7gGDgXtCU=; h=From:To:Subject;
	b=nUCn0eye67J9FNVs+biACED7f313IDwmXp2xJqVyEIdWrATWohEkGkXuJ4kS797ei
	 72WmY0vXlkQent9eFpwK6lBHilmy4elfDnGMN+OUp4P+N16qJoSvnHul1B0xT/tJ1M
	 GiPOMwVzlCALE9FH5uAP2dlqxNl/qHFzAu+9QPbU=
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
Subject: [PATCH v9 06/15] platform/x86: oxpec: Rename ec group to tt_toggle
Date: Thu, 17 Apr 2025 19:53:01 +0200
Message-ID: <20250417175310.3552671-7-lkml@antheas.dev>
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
 <174491241084.25014.303836050158476415@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

Currently, the EC group is used for the turbo button. However, the next
patch in the series adds support for the LED button in X1 devices, which
is only applicable for X1 devices. Therefore, rename it to prepare for
adding the second group. And make it const while at it.

Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
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
2.49.0


