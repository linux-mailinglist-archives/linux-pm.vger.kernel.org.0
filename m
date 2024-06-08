Return-Path: <linux-pm+bounces-8814-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E83E490134C
	for <lists+linux-pm@lfdr.de>; Sat,  8 Jun 2024 21:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DFE0B21362
	for <lists+linux-pm@lfdr.de>; Sat,  8 Jun 2024 19:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C411A702;
	Sat,  8 Jun 2024 19:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="M6Fh6kNj"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0DF208D7;
	Sat,  8 Jun 2024 19:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717874388; cv=none; b=Jdct7Vqi8+HKm6/VZRYPSV7H83GSKUFy9tOEGyMjUKYzwBB++iTtc+g9UCu0QaG1fa+kdIy2iMFGEphvPRi0c9TY8K14uOX6/ld2WhBXx5dCaulNdNH+V5zaGGVDElSeR//5APlvyHQ7tH8T+BtThBmbwI0CsCKEgFfM/0XIAro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717874388; c=relaxed/simple;
	bh=iwmtGXBeadQYz1BR7WvStUjlWi2C455oBoc3ud/Aeks=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fgJHfl7rhbBFB0TwpPbQ1SVjhtqGT4/MAhlsb4I5ke1ZevXhzvyWtjoJsfIUMP3F4SU1jzf9Ha9EcCUj3hcgvBDiFjM77heGw4ohUsTweuIoo3OHnVIl9SBbS6HvR7yp50ncmnpOEnfg+2ndmqkfaSG3Ozzgnbn7mYvAct/pmp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=M6Fh6kNj; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1717874384;
	bh=iwmtGXBeadQYz1BR7WvStUjlWi2C455oBoc3ud/Aeks=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=M6Fh6kNjdEy4vCeZRbziCA9LlafxoXiWfT9DpmPUP6H2D+YcR97yUZ3hn3povp1Lb
	 Z5oBEc7PpmHiIJ3OoWAgZZ187F0gVY8PCOZEEqenkiLNHk6Lfgyx6k+j1AgZxJ/T+e
	 bUkA0yYOZOe2RKp3eUQvGIxwt7XYGhg4HfqoUONw=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 08 Jun 2024 21:19:37 +0200
Subject: [PATCH RFC v2 1/5] power: supply: sysfs: use
 power_supply_property_is_writeable()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240608-power-supply-extensions-v2-1-2dcd35b012ad@weissschuh.net>
References: <20240608-power-supply-extensions-v2-0-2dcd35b012ad@weissschuh.net>
In-Reply-To: <20240608-power-supply-extensions-v2-0-2dcd35b012ad@weissschuh.net>
To: Sebastian Reichel <sre@kernel.org>, Armin Wolf <W_Armin@gmx.de>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717874383; l=853;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=iwmtGXBeadQYz1BR7WvStUjlWi2C455oBoc3ud/Aeks=;
 b=Y81t2lrBOMhekgXcsMAguQilpQSiGF+UCH5p7pLG15hQ69z1vWfMlcNc06bwTgJ5x4qj2l8+0
 dzz1ox36lGYAv0MdsyvCVrw2sMG3S4D26RdA5nOHutbppB/Tbzz1Djk
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Instead of open-coding the helper use it directly.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/power/supply/power_supply_sysfs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index b86e11bdc07e..3e63d165b2f7 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -379,8 +379,7 @@ static umode_t power_supply_attr_is_visible(struct kobject *kobj,
 		int property = psy->desc->properties[i];
 
 		if (property == attrno) {
-			if (psy->desc->property_is_writeable &&
-			    psy->desc->property_is_writeable(psy, property) > 0)
+			if (power_supply_property_is_writeable(psy, property) > 0)
 				mode |= S_IWUSR;
 
 			return mode;

-- 
2.45.2


