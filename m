Return-Path: <linux-pm+bounces-15193-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D01C9915B4
	for <lists+linux-pm@lfdr.de>; Sat,  5 Oct 2024 12:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 869F1B2340F
	for <lists+linux-pm@lfdr.de>; Sat,  5 Oct 2024 10:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC5714F125;
	Sat,  5 Oct 2024 10:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="D7YyuQY1"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B45D149C7A;
	Sat,  5 Oct 2024 10:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728122691; cv=none; b=LJRWvh0JS3JMhz4pnq9mY+ZnqcQDClDMOmkf8CoHjAjyU4EXW5ZcmcZyMEEsF4W9MPk97T4vtrgvgRFO5vOsYVHtkUO3QSPkvPeDjfyff+htLCgIsRd9I1mvsIH/yYYl0Q3ZrkL2LrIGciVd/FXgsjDtDDkRV1w1jCvOfHWTekw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728122691; c=relaxed/simple;
	bh=fG25pPqPUSkyr8a2zQoffk/BcWOXq6/l1QyvlkGHiqg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=otcq5UGA8H/pMlldubN4nJPzyX4fLlz/aUVdWjQnba3VzJcbqSjCflwVm/gl0ohQz7wnBt7fVnSuZDpK4b0F1OZhBk3JCFRdDxqf19P43ItBHnya8PB6O3sBiqzFW38XlQzAtkKKy3x6RWcWeO+9cDFod8sh9teXKTqEwmjnSXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=D7YyuQY1; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1728122684;
	bh=fG25pPqPUSkyr8a2zQoffk/BcWOXq6/l1QyvlkGHiqg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=D7YyuQY16aeP14n4/0NbURg9QUmFLm2nAmea4TqI8AkrXQaRldR+V/RC6csVWvAxB
	 OZIcDVHv6tLJTu4dy/7FA0pcZW3wK/6UPMY6ufMUazZjSd8sENRuplmOVsMkoe+Gl0
	 lXmdbi/LVmXaMIvQKT12AmRaTDrQe2ewhRSj41ro=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 05 Oct 2024 12:04:23 +0200
Subject: [PATCH 7/7] power: supply: samsung-sdi-battery: constify ocv table
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241005-power-supply-battery-const-v1-7-c1f721927048@weissschuh.net>
References: <20241005-power-supply-battery-const-v1-0-c1f721927048@weissschuh.net>
In-Reply-To: <20241005-power-supply-battery-const-v1-0-c1f721927048@weissschuh.net>
To: Sebastian Reichel <sre@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728122683; l=2342;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=fG25pPqPUSkyr8a2zQoffk/BcWOXq6/l1QyvlkGHiqg=;
 b=R5veXLGLavA7E332CjyjZI7xjw+FpI71xLof/yJX0E3W7oftC0ZRylnnwMjgFAx3YPeOhb3tA
 SywIafUrmjACjws0wtjOgWo5XSy3icQBiX7+Ay9ETu2pFr6zLgtAQ1T
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The power supply core now allows this constification.
Prevent accidental or malicious modification of the data.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/power/supply/samsung-sdi-battery.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/samsung-sdi-battery.c b/drivers/power/supply/samsung-sdi-battery.c
index 263592d625837e3851ccb30b4cf1272139ee923d..33565002ee27053b27a2b16cc588976faab4fce5 100644
--- a/drivers/power/supply/samsung-sdi-battery.c
+++ b/drivers/power/supply/samsung-sdi-battery.c
@@ -447,7 +447,7 @@ static const struct power_supply_resistance_temp_table samsung_temp2res[] = {
  * These must be sorted by falling OCV value.
  */
 
-static struct power_supply_battery_ocv_table samsung_ocv_cap_eb485159lu[] = {
+static const struct power_supply_battery_ocv_table samsung_ocv_cap_eb485159lu[] = {
 	{ .ocv = 4330000, .capacity = 100},
 	{ .ocv = 4320000, .capacity = 99},
 	{ .ocv = 4283000, .capacity = 95},
@@ -499,7 +499,7 @@ static struct power_supply_battery_ocv_table samsung_ocv_cap_eb485159lu[] = {
 };
 
 /* Same capacity table is used by eb-l1m7flu, eb425161la, eb425161lu */
-static struct power_supply_battery_ocv_table samsung_ocv_cap_1500mah[] = {
+static const struct power_supply_battery_ocv_table samsung_ocv_cap_1500mah[] = {
 	{ .ocv = 4328000, .capacity = 100},
 	{ .ocv = 4299000, .capacity = 99},
 	{ .ocv = 4281000, .capacity = 98},
@@ -540,7 +540,7 @@ static struct power_supply_battery_ocv_table samsung_ocv_cap_1500mah[] = {
 	{ .ocv = 3300000, .capacity = 0},
 };
 
-static struct power_supply_battery_ocv_table samsung_ocv_cap_eb535151vu[] = {
+static const struct power_supply_battery_ocv_table samsung_ocv_cap_eb535151vu[] = {
 	{ .ocv = 4178000, .capacity = 100},
 	{ .ocv = 4148000, .capacity = 99},
 	{ .ocv = 4105000, .capacity = 95},
@@ -572,7 +572,7 @@ static struct power_supply_battery_ocv_table samsung_ocv_cap_eb535151vu[] = {
 	{ .ocv = 3300000, .capacity = 0},
 };
 
-static struct power_supply_battery_ocv_table samsung_ocv_cap_eb585157lu[] = {
+static const struct power_supply_battery_ocv_table samsung_ocv_cap_eb585157lu[] = {
 	{ .ocv = 4320000, .capacity = 100},
 	{ .ocv = 4296000, .capacity = 99},
 	{ .ocv = 4283000, .capacity = 98},

-- 
2.46.2


