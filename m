Return-Path: <linux-pm+bounces-15194-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4D09915B7
	for <lists+linux-pm@lfdr.de>; Sat,  5 Oct 2024 12:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56F821F23B50
	for <lists+linux-pm@lfdr.de>; Sat,  5 Oct 2024 10:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1AC415383C;
	Sat,  5 Oct 2024 10:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="OTfMmLXu"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEF914C5B5;
	Sat,  5 Oct 2024 10:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728122692; cv=none; b=WoEPMl+5Ap/y/D2caIIyO0XkHOEQfX6W3ya3tZATui7j3A5Iu8V6vp0vsG/aol6b82q9Py4Ilr5WUi+4mrnlFmbEnG9xd97/OGufEuzJuoahE3Mup6BMO9BHDI7RmKlK79/hVGYFvTcmmgnF2BrNY4XhwrpNB3bPotx9CBtqnm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728122692; c=relaxed/simple;
	bh=G7hFn53Hx/armmZCWo8cg+1e0J/zbMPD5IhuGApPuV4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bOu/ObGqBBaLCf3YENBBYhA2+p2qUJssX+Vbp9b7h7tTIJA+dYgkY6DOzFWPCQeKDRtBqghXE6f2BjzrvNrCCUQaY49fHYwR2rIZnAK5VZmbmM++3gBSPx+VQuVPx5sNIhL7pIdRwrmKYJ9xOIps+C9o7hETIxZJ7YybfaquiM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=OTfMmLXu; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1728122684;
	bh=G7hFn53Hx/armmZCWo8cg+1e0J/zbMPD5IhuGApPuV4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OTfMmLXuJtpBcquKC7KAfgSS3aCISaPH9eNFwhJdhwZv9963BBv7H7HkHctm4maBt
	 0GT7uYTwolZt3c03B6Plr1cLaHcqHODHQ3s7OigaSedCP8Be4oYFEp7IBKBG/5ftYe
	 gESZMJoNDgTPn76ddsggTEzdgguMNkM7IZ1D1dyA=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 05 Oct 2024 12:04:22 +0200
Subject: [PATCH 6/7] power: supply: ab8500: constify ocv table
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241005-power-supply-battery-const-v1-6-c1f721927048@weissschuh.net>
References: <20241005-power-supply-battery-const-v1-0-c1f721927048@weissschuh.net>
In-Reply-To: <20241005-power-supply-battery-const-v1-0-c1f721927048@weissschuh.net>
To: Sebastian Reichel <sre@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728122683; l=912;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=G7hFn53Hx/armmZCWo8cg+1e0J/zbMPD5IhuGApPuV4=;
 b=0NizM4/ou17qrDgIW2R6hywiNqZWjrLMRyiJqMrqhhsBwrsGGjKCWxRr22taXIvwHFBuulhi+
 oETkVsI8b0IAuP1r8skOlb0pZly3vIuJfpdua/3597aP1N7puRYmBSt
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The power supply core now allows this constification.
Prevent accidental or malicious modification of the data.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/power/supply/ab8500_bmdata.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/ab8500_bmdata.c b/drivers/power/supply/ab8500_bmdata.c
index 2fcfbbef050383eaef461ec2e8191e9b269305ff..19ed528528048547a97cddbf18f3f5aaf771d646 100644
--- a/drivers/power/supply/ab8500_bmdata.c
+++ b/drivers/power/supply/ab8500_bmdata.c
@@ -16,7 +16,7 @@
 /* Default: temperature hysteresis */
 #define AB8500_TEMP_HYSTERESIS	3
 
-static struct power_supply_battery_ocv_table ocv_cap_tbl[] = {
+static const struct power_supply_battery_ocv_table ocv_cap_tbl[] = {
 	{ .ocv = 4186000, .capacity = 100},
 	{ .ocv = 4163000, .capacity = 99},
 	{ .ocv = 4114000, .capacity = 95},

-- 
2.46.2


