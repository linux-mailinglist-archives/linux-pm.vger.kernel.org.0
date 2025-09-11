Return-Path: <linux-pm+bounces-34432-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3326B52984
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 09:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD5301C23686
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 07:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A59A1553A3;
	Thu, 11 Sep 2025 07:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="NrC/qmfr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B41B329F0F
	for <linux-pm@vger.kernel.org>; Thu, 11 Sep 2025 07:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757574200; cv=none; b=HIlTq51/KYW4AHMo5YDVyIXVUIDJg7d2zyQ3Pi22UeTpvD0FJBAt4DoBlDqEVsPfOfrM1ej3ONE6LzPvE+X465u/GP5lN+cVQYsiw5iAtYW5sqbK/UhaLzzoUw0jW7UP86HVHcVZPvxJN85mPp2oXGjxlA+HzCS2yxiTuQzXyMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757574200; c=relaxed/simple;
	bh=D0AQll4YNpo4Aw6s5Jkuob5l/K0NCNf16jd3ETY+tQk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nNfexvm/6CLN9MizcpEVa0ldwr1tp43JFbQZdapJHDmQL9IZM83ZhJfmyc8GxNwzI6N4mOvRAmq04XDdWbFLaAQvUoJDtEyOodSTy5waguVGoVq5kgiIzluc1nOwuH1xnT6YpDw66uhbSIk8h12BsCK1XZiOhkR7wkPoBgOW6Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=NrC/qmfr; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-type:content-transfer-encoding; s=k1; bh=g
	m0BxvLWaTi74FC+aSojSvZF2Kqn0p/GrNAhDhRzchw=; b=NrC/qmfrpfYmUrE0b
	U/JSUpi9qSKBg8TVIg/bJZvYmrbZphGK3kAR5GA+XCJDz+cHroEW6JGxP9VR4u4b
	baj+6Hp71DwoicwqSowNpgVSaA0zN0kB+aDbxajQXkyOCD5q46sbeAX2MhfN0tEA
	5IJegKum1Q1PPfYh2j3O7WTO9ax+w9lzX8+aD9PaURopNREZs0avX5eRL+RZE+IY
	EGRbsvAHhozx5fX6T/BTr4LA1j9sLrmuIy9KB39wlA47GLaXPYAhdC9FVB176LFE
	nm/rhKjfWEZ1d8QuUjfIG4XL6UNli9rTJYmltji9gfr1tUpqqS4Z0XDGgbw2LV3H
	38PLA==
Received: (qmail 878067 invoked from network); 11 Sep 2025 09:03:12 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 11 Sep 2025 09:03:12 +0200
X-UD-Smtp-Session: l3s3148p1@9dJmIYE+FqUgAwDPXyerAKQ7QDbxBzog
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-pm@vger.kernel.org
Subject: [PATCH] thermal/drivers/rcar_gen3: fix mapping SoCs to generic Gen4 entry
Date: Thu, 11 Sep 2025 09:00:13 +0200
Message-ID: <20250911070254.2214-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

S4 was added first so it was assumed to be the blueprint for R-Car Gen4.
It turned out now, that S4 is a special mix between Gen3 and Gen4. V4H
and V4M are the similar ones as confirmed by HW engineers.

So, rename the S4 entry to be specific instead of generic. Rename the
V4H entry to be the new generic one, so V4M will use it as well now.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Changes since RFC:
* added tags from Niklas and Geert (thanks!)
* dropped patch 2/2 because it needs more internal discussion and may be
  superfluous in the end. This patch here seems to have consensus, though.

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


