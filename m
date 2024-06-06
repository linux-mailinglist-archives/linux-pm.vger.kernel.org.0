Return-Path: <linux-pm+bounces-8720-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D03A68FF01C
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 17:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 645391F21EAC
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 15:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8201A256B;
	Thu,  6 Jun 2024 14:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="bkBQBzA+"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17651A2548;
	Thu,  6 Jun 2024 14:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717685468; cv=none; b=JrUQJdWT9tDUhzu2mdjK/YBwdhmPR0YXgrPMj/jDNnmXz2eSdrEVDt7t54xXZwCsBD0CAeoLg1ebLxbRFFxMTmjGRHHJtvTjtc2X+WSt9U+P0P3/zfpCFuHgt7RkNVT913cIC1Kx6SrQWl8txTdEMSf2svm87r/PpCm2jevEu30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717685468; c=relaxed/simple;
	bh=iwmtGXBeadQYz1BR7WvStUjlWi2C455oBoc3ud/Aeks=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=swaw3Wa+6xJLo9XewlEHtQTvKZSv6vPCle7rBRlGIyq6WtZSE2Xgj7/kqhVBQ+UMroQwgIsf/hxA3+t1qlmEtc3qhNwu8wI+LpsR7QYthPEiOh7LxTyF5koBH3IQnJwWz5pcrfVlYYN9w+x0vUX+ikawQV5zMY5O5hx5P94tS5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=bkBQBzA+; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1717685463;
	bh=iwmtGXBeadQYz1BR7WvStUjlWi2C455oBoc3ud/Aeks=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bkBQBzA+FzaLq9u9NdMLSdi3HvwS5F6FzhMpNcPMteXAdkASFCDh1HOcYw4ghI7TY
	 /+o47YaaxcTrlSvPwepFXcol+3VomRR3IAaeWksCpqlk4xWttN23omkEpowWeUc2qt
	 bI3YSjyEMwm/jdUNeP5iL6da54SgGH+m9YQhTwq0=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 06 Jun 2024 16:50:55 +0200
Subject: [PATCH RFC 1/6] power: supply: sysfs: use
 power_supply_property_is_writeable()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240606-power-supply-extensions-v1-1-b45669290bdc@weissschuh.net>
References: <20240606-power-supply-extensions-v1-0-b45669290bdc@weissschuh.net>
In-Reply-To: <20240606-power-supply-extensions-v1-0-b45669290bdc@weissschuh.net>
To: Sebastian Reichel <sre@kernel.org>, Jeremy Soller <jeremy@system76.com>, 
 System76 Product Development <productdev@system76.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 platform-driver-x86@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717685463; l=853;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=iwmtGXBeadQYz1BR7WvStUjlWi2C455oBoc3ud/Aeks=;
 b=Cm894uo9qkvCZ/6aRkPtVyxRlt7d8CnehIna7X2jXsUNGaYd2ka67wBaMKaLbTdMA+uOjfHuB
 ajRTaCxvYB6AZn2Mp5KH8Ft/sfRfkbzMB4awGLr67225DA9etXAsanH
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


