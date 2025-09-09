Return-Path: <linux-pm+bounces-34219-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E91B4A5D1
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 10:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69BBF4E00F0
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 08:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C9E271475;
	Tue,  9 Sep 2025 08:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="ialt3h7+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C40254846
	for <linux-pm@vger.kernel.org>; Tue,  9 Sep 2025 08:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757407612; cv=none; b=TcJzvv95k1rXwU4+L7l6ttq7/tpHOZOHY/zJHOZRHNvPN0Za3uneH+mysX0/RSPaZ7PVR5qN74NdprbyISPvhiUGltaiUx9CjELzU0MI+YidER5LZs7E6moXPud6q26yRaHB/drdyVorjqrkRG8Uv6TmYGQwnIxOO9Vk7ZhlRnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757407612; c=relaxed/simple;
	bh=mYJq7NdizkvMdSZxU8icOCwkhET/6v2tHdwcQ5m4/Ys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UlpcOmccg0qo2VwCCgyce3HQqCEoOfSXzSdZY9gP1KkcUXfWBR3prC1SXWCS8ZlkVzeAqRtaNSApnCaayYqwFmE865KeBuePfDq+Gaz1ym3G4r1J957ZLAh43dDxsHghuWP4QQ2N+bP8Dp6+K76r6LBRzbScZD7gCtsxbag24/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=ialt3h7+; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=GBHrwW80hyg0dJPdstFO1QWtNoC5gkJRN26Rn1Ij9LQ=; b=ialt3h
	7+SrRsxfRpg7fzzJ2GRW0DIjCKYEPhsSwgKeuq6ucMchNh39BhJI0XfJNV6Mh42U
	k46xFW3ZqdDkIOxDehWACKaxy9KYEaY4nmEWUrkxaUFdO3tU8BXBbmDD/9DE8vyM
	7aAW2ltQCLh10uhGVVfbZ+8AOSNe6WUQkNvPtNF2yY0wSYsqbKwlrJQzJyTcsG2K
	/RvaI3PZvVE84YLNLG+W7EJBQIgB4Hp+PmwnflVEwz6tUp0VOGj2bhp3adHNVt2X
	mIa9mTMHC8TPCAKi/atw6qkeAXkWF6JO94TkkDuA3I6Fuuu54XLrx8AegPSgiH1x
	8+JNEUWORaCb4jrg==
Received: (qmail 172323 invoked from network); 9 Sep 2025 10:46:40 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 9 Sep 2025 10:46:40 +0200
X-UD-Smtp-Session: l3s3148p1@IPi5V1o+UuwgAwDPXyerAKQ7QDbxBzog
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
	Marek Vasut <marek.vasut@gmail.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-pm@vger.kernel.org
Subject: [RFC PATCH 1/2] thermal/drivers/rcar_gen3: fix mapping SoCs to generic Gen4 entry
Date: Tue,  9 Sep 2025 10:46:19 +0200
Message-ID: <20250909084618.23082-5-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250909084618.23082-4-wsa+renesas@sang-engineering.com>
References: <20250909084618.23082-4-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

S4 was added first so it was assumed to be the blueprint for R-Car Gen4.
It turned out now, that S4 is a special mix between Gen3 and Gen4. V4H
and V4M are the similar ones as confirmed by HW engineers.

So, rename the S4 entry to be specific instead of generic. Rename the
V4H entry to be the new generic one, so V4M will use it as well now.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/thermal/renesas/rcar_gen3_thermal.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/renesas/rcar_gen3_thermal.c b/drivers/thermal/renesas/rcar_gen3_thermal.c
index 01858e72f4e0..07b53d4f2683 100644
--- a/drivers/thermal/renesas/rcar_gen3_thermal.c
+++ b/drivers/thermal/renesas/rcar_gen3_thermal.c
@@ -371,7 +371,7 @@ static const struct rcar_gen3_thermal_fuse_default rcar_gen3_thermal_fuse_defaul
 	},
 };
 
-static const struct rcar_gen3_thermal_fuse_default rcar_gen3_thermal_fuse_default_info_v4h = {
+static const struct rcar_gen3_thermal_fuse_default rcar_gen3_thermal_fuse_default_info_gen4 = {
 	.ptat = { 3274, 2164, 985 },
 	.thcodes = { /* All four THS units share the same trimming */
 		{ 3218, 2617, 1980 },
@@ -397,7 +397,7 @@ static const struct rcar_thermal_info rcar_gen3_thermal_info = {
 	.fuse_defaults = &rcar_gen3_thermal_fuse_default_info_gen3,
 };
 
-static const struct rcar_thermal_info rcar_gen4_thermal_info = {
+static const struct rcar_thermal_info rcar_s4_thermal_info = {
 	.scale = 167,
 	.adj_below = -41,
 	.adj_above = 126,
@@ -405,12 +405,12 @@ static const struct rcar_thermal_info rcar_gen4_thermal_info = {
 	.fuse_defaults = &rcar_gen3_thermal_fuse_default_info_gen3,
 };
 
-static const struct rcar_thermal_info rcar_v4h_thermal_info = {
+static const struct rcar_thermal_info rcar_gen4_thermal_info = {
 	.scale = 167,
 	.adj_below = -41,
 	.adj_above = 126,
 	.fuses = &rcar_gen3_thermal_fuse_info_gen4,
-	.fuse_defaults = &rcar_gen3_thermal_fuse_default_info_v4h,
+	.fuse_defaults = &rcar_gen3_thermal_fuse_default_info_gen4,
 };
 
 static const struct of_device_id rcar_gen3_thermal_dt_ids[] = {
@@ -452,11 +452,11 @@ static const struct of_device_id rcar_gen3_thermal_dt_ids[] = {
 	},
 	{
 		.compatible = "renesas,r8a779f0-thermal",
-		.data = &rcar_gen4_thermal_info,
+		.data = &rcar_s4_thermal_info,
 	},
 	{
 		.compatible = "renesas,r8a779g0-thermal",
-		.data = &rcar_v4h_thermal_info,
+		.data = &rcar_gen4_thermal_info,
 	},
 	{
 		.compatible = "renesas,r8a779h0-thermal",
-- 
2.47.2


