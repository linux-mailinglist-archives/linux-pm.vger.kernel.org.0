Return-Path: <linux-pm+bounces-23695-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1DAA583AC
	for <lists+linux-pm@lfdr.de>; Sun,  9 Mar 2025 12:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB8873ADF7E
	for <lists+linux-pm@lfdr.de>; Sun,  9 Mar 2025 11:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7F71D47C7;
	Sun,  9 Mar 2025 11:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="v58cANX8"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545B71CAA9E;
	Sun,  9 Mar 2025 11:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741519296; cv=none; b=p2aEd3tVJHIhn1dEkiwhgYpLXDVI+lOKP1TIfxPoitJXPQyEdDAzI5v5y9PMJbStvYtbmH75GTp3gnN+294jIOaBL0gsnS5wWS88sPtGR4D/2a/b9Jsj339X4X8w3Hlka4B6JLCaPeUIn53nab3PWRhjL3aEMRKCtdv9ly31kYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741519296; c=relaxed/simple;
	bh=mcDiigB2MLujej3Is1lfFTDzDZDST+7UORn7RokivIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O12zv6nvE/AwDgaryGh7goVxoXL+HAuyMdOSxSx4Gr9++5HO3ifrPqsARmK7+GgkM3SMRlIGszd4epVkIbJaBpBrUx7iwIV2CBi6fb5xkxcXDbOhRlFnqtxaxO6bdz2MtqpIrqXj+4MHo4o4Ngz8lQvC+mFIyRNEECd5DHWCrWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=v58cANX8; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a05:f6c2:511b:0:8d8a:5967:d692:ea4e])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 855092E07C2F;
	Sun,  9 Mar 2025 13:21:30 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1741519292;
	bh=Irn9TsitqOq21o2rMAMNr7IvOLb5uG37PT+InEpVZNE=; h=From:To:Subject;
	b=v58cANX8Keox3+vl4ROEwuMQVkARna6pKJ6QiLYaIDz7n8pFlFUQgpB6gyCIxskbf
	 kunpsFOuRKwpaTsTJ/AliWKrlMeM/br/4zPZISEXY/p0caXTUrkcIWBMH6l6iVcGLC
	 OrjsdVUyVICWJQQ0eQBE7gH6QwjLo/woEF/IpU/M=
Authentication-Results: linux1587.grserver.gr;
	spf=pass (sender IP is 2a05:f6c2:511b:0:8d8a:5967:d692:ea4e) smtp.mailfrom=lkml@antheas.dev smtp.helo=localhost.localdomain
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
	Antheas Kapenekakis <lkml@antheas.dev>
Subject: [PATCH v3 07/12] platform/x86: oxpec: Rename ec group to tt_toggle
Date: Sun,  9 Mar 2025 12:21:08 +0100
Message-ID: <20250309112114.1177361-8-lkml@antheas.dev>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250309112114.1177361-1-lkml@antheas.dev>
References: <20250309112114.1177361-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <174151929188.29053.16741927704981455335@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

Currently, the EC group is used for the turbo button. However, the next
patch in the series adds support for the LED button in X1 devices, which
is only applicable for X1 devices. Therefore, rename it to prepare for
adding the second group.

Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/platform/x86/oxpec.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/oxpec.c b/drivers/platform/x86/oxpec.c
index dd6d333ebcfa..9cb024325da5 100644
--- a/drivers/platform/x86/oxpec.c
+++ b/drivers/platform/x86/oxpec.c
@@ -888,18 +888,18 @@ static const struct hwmon_channel_info * const oxp_platform_sensors[] = {
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


