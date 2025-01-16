Return-Path: <linux-pm+bounces-20586-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E8EA14284
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 20:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F6EA7A236E
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 19:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C01234CF2;
	Thu, 16 Jan 2025 19:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="akHQe3vn"
X-Original-To: linux-pm@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2D522F387;
	Thu, 16 Jan 2025 19:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737056698; cv=none; b=BXxiisgovINtptRhxSHLGgC3u5jMpZELe7sTCtHZgvEu7cbDelGHjCaMcoJmESPcD2iK7JBzaxH9HGKlsyfdrFE4AN0IzYSG5L7UeeiLSuJhZDz9N5w9GASBtRVXoeY+Ffo1vu1hUlDXRiaKlW2R5R0APwLSdvAl84EEv0HQ72Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737056698; c=relaxed/simple;
	bh=IcjiODguC40y78u4uqPvE4L9y/vTL7BHxqp7PNXf8UI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eXheYYreZaLSmvAxYt54OsJqkM7O1Ig6SVl3Y2jQsFmNBd61Ct9vI7F9MLpxXgczIZELUSumaoOdN9GlGElBRZtTOqEv2vVnlaGL1RXL+CLhvGimJVvFg8Zb3MWlxft6rgsLce6Wei4zkqNuxkTTuNE17GVRDa7NFRiIsksh8aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=akHQe3vn; arc=none smtp.client-ip=192.19.144.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 6AA36C004305;
	Thu, 16 Jan 2025 11:44:50 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 6AA36C004305
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1737056690;
	bh=IcjiODguC40y78u4uqPvE4L9y/vTL7BHxqp7PNXf8UI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=akHQe3vngF/Tinu8bCQyyaUSzR1V3VZM4bmGXvCrKAXLU/SON6FLTz1OHD3LXsfTS
	 dwqnUyhzzQkg+xBus5kKBqWJ0q3Yu/je2mHvA9bx13+kTTz1BSfdyQjsmwf1IsMS3j
	 Onio1Eq4EDoTfzNgcN6et91nRPAAX3dBIZ8sBYd4=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id EA1EA18041CAD2;
	Thu, 16 Jan 2025 11:44:49 -0800 (PST)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: linux-kernel@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Markus Mayer <mmayer@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-pm@vger.kernel.org (open list:BROADCOM STB AVS TMON DRIVER),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE)
Subject: [PATCH 2/2] thermal: brcmstb_thermal: Add support for BCM74110
Date: Thu, 16 Jan 2025 11:38:42 -0800
Message-ID: <20250116193842.758788-3-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250116193842.758788-1-florian.fainelli@broadcom.com>
References: <20250116193842.758788-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BCM74110 uses a different process node compared to previous chips that
requires a different equation, account for that.

Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/thermal/broadcom/brcmstb_thermal.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/broadcom/brcmstb_thermal.c b/drivers/thermal/broadcom/brcmstb_thermal.c
index 270982740fde..f46f2ddc174e 100644
--- a/drivers/thermal/broadcom/brcmstb_thermal.c
+++ b/drivers/thermal/broadcom/brcmstb_thermal.c
@@ -286,14 +286,20 @@ static int brcmstb_set_trips(struct thermal_zone_device *tz, int low, int high)
 	return 0;
 }
 
-static const struct thermal_zone_device_ops brcmstb_16nm_of_ops = {
+static const struct thermal_zone_device_ops brcmstb_of_ops = {
 	.get_temp	= brcmstb_get_temp,
 };
 
+static const struct brcmstb_thermal_params brcmstb_8nm_params = {
+	.offset	= 418670,
+	.mult	= 509,
+	.of_ops	= &brcmstb_of_ops,
+};
+
 static const struct brcmstb_thermal_params brcmstb_16nm_params = {
 	.offset	= 457829,
 	.mult	= 557,
-	.of_ops	= &brcmstb_16nm_of_ops,
+	.of_ops	= &brcmstb_of_ops,
 };
 
 static const struct thermal_zone_device_ops brcmstb_28nm_of_ops = {
@@ -308,6 +314,7 @@ static const struct brcmstb_thermal_params brcmstb_28nm_params = {
 };
 
 static const struct of_device_id brcmstb_thermal_id_table[] = {
+	{ .compatible = "brcm,avs-tmon-bcm74110", .data = &brcmstb_8nm_params },
 	{ .compatible = "brcm,avs-tmon-bcm7216", .data = &brcmstb_16nm_params },
 	{ .compatible = "brcm,avs-tmon", .data = &brcmstb_28nm_params },
 	{},
-- 
2.43.0


