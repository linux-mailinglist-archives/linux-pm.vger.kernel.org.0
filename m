Return-Path: <linux-pm+bounces-18969-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A029EBC56
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 22:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB0F0162160
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 21:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF37A23FA13;
	Tue, 10 Dec 2024 21:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="CPB36e4u"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBB523EA87;
	Tue, 10 Dec 2024 21:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733867769; cv=none; b=m8WU3vPDcGAe3cwDOQrtNZxC2a6L8g0uYaTIFrvWJMzTimqXYxtYFQS0yaR/4W4q5Hb11DkPQeHS/DL/17djxtqI48rIDzrEoPH98DqWD95qjDIS7LmnZQ0Bx1Vw5Wk6khOtH+XiH2SNPntJoFsVN7uOf3GPXmEz/By1eGkDXUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733867769; c=relaxed/simple;
	bh=8VBKzyLSPAGekr2MvdVRCAUGf5HHmqa9y4g6LCA+Gek=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SgSS2H13R/ePLUskQOOlt2iy7yiAFrNpV12NMxIJ3xVTdhWBfsgBcxa/f4eVH4EM71WqZCmtS6OU7cxoR51f82nJGQNMA8bpxkG4arO5xpxZiJbgtTttyVyA4RGH3f7RphSonf2BmlxZF3bMYsO0t1ZULxm1UPFWcl8ok3krXSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=CPB36e4u; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733867761;
	bh=8VBKzyLSPAGekr2MvdVRCAUGf5HHmqa9y4g6LCA+Gek=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CPB36e4u5nfp+T1dKQ2PzSqZDqAHdzLc0KAsw7fZbmqROqQJf27h7LojUff0F04m/
	 QNc/MWv/ko+FImh/7UNropsEXV/sf9tsbvVx0OYDxXRBfPqyu79tW6DTUGwA8zHdUT
	 pFWXzh48J1cNw2aVd/Dd/9OLzrGyVnddQ/KkZPKA=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 10 Dec 2024 22:55:58 +0100
Subject: [PATCH v2 11/14] power: supply: surface_battery: use dev_to_psy()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241210-power-supply-dev_to_psy-v2-11-9d8c9d24cfe4@weissschuh.net>
References: <20241210-power-supply-dev_to_psy-v2-0-9d8c9d24cfe4@weissschuh.net>
In-Reply-To: <20241210-power-supply-dev_to_psy-v2-0-9d8c9d24cfe4@weissschuh.net>
To: Sebastian Reichel <sre@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Maximilian Luz <luzmaximilian@gmail.com>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 platform-driver-x86@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733867760; l=1371;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=8VBKzyLSPAGekr2MvdVRCAUGf5HHmqa9y4g6LCA+Gek=;
 b=kEcjg2iJ1wVPliJAiTJukoDCeoTkaiNVP9Z1WW/0NLf1pMqcPXaNtEtf0PDUKL44o4mliLzyo
 8a/v2+DyaO1Cx8Mo2sGIHXX7G9apmFlizgjwi8QzbNQnJqwaQzkIZdH
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Use the new, explicit accessor to go from a 'struct device' to its
'struct power_supply'.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/power/supply/surface_battery.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/surface_battery.c b/drivers/power/supply/surface_battery.c
index ebd1edde28f12aa7711e4ff07f8516abc8cbc946..c759add4df49dafc92538ef1316b19f186e73929 100644
--- a/drivers/power/supply/surface_battery.c
+++ b/drivers/power/supply/surface_battery.c
@@ -667,7 +667,7 @@ static int spwr_battery_get_property(struct power_supply *psy, enum power_supply
 
 static ssize_t alarm_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct power_supply *psy = dev_get_drvdata(dev);
+	struct power_supply *psy = dev_to_psy(dev);
 	struct spwr_battery_device *bat = power_supply_get_drvdata(psy);
 	int status;
 
@@ -681,7 +681,7 @@ static ssize_t alarm_show(struct device *dev, struct device_attribute *attr, cha
 static ssize_t alarm_store(struct device *dev, struct device_attribute *attr, const char *buf,
 			   size_t count)
 {
-	struct power_supply *psy = dev_get_drvdata(dev);
+	struct power_supply *psy = dev_to_psy(dev);
 	struct spwr_battery_device *bat = power_supply_get_drvdata(psy);
 	unsigned long value;
 	int status;

-- 
2.47.1


