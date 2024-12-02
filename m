Return-Path: <linux-pm+bounces-18374-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 736A79E0B95
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 20:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 264222808FC
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 19:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080631DE8A6;
	Mon,  2 Dec 2024 19:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="HJHQ1cOp"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D19D1DE3D8;
	Mon,  2 Dec 2024 19:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733166142; cv=none; b=OW6gExTtesXTRMQ/lEVk+Tbs6Ulj+4GnYhvkFMNs+V1+s84D2Ihy+GKCzLdN1YexEgtMLm10m3BcQsLsq8yO2W4h95SGTaIFCuYkAr8k+cVQFKhO9dcueMYtzZmfl76EzgqWg7LLpPhLiTSq61mTV7C+EbZcQnmiBWSeR5PSOOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733166142; c=relaxed/simple;
	bh=vs237hxNCHuIOeDxAr5dea8fYVyVtnREj4eNa7u5ziw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gSxN51j6/v7x8J+hD0GFaF+dejI3j0kDgkV8U4wxw4K7xKCRASupIntLoaE0jkg2JDsUxJ6x33SJqXXIxMnAowkIIxmHJwOTiu+rR0zds2VQ3CehQsWSIdnVx8XXpPqrXXFIYxg4r5B5aRwGpWJD1defUevFNm5byMVgryng+8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=HJHQ1cOp; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733166139;
	bh=vs237hxNCHuIOeDxAr5dea8fYVyVtnREj4eNa7u5ziw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HJHQ1cOpqRRHj15C7dTKRxiEUyRQZHPeMmL/iv77nBqIrW85va1896BUPBl3BAtwx
	 7xB0u8iQLrosdpZfcR+9yPCJxxcEBgtW4kOpy3YzxlLWhdCsFmrJbES2UPs941Ny14
	 0tk3FwG2dSs3alUIIOqQn6PAukYk/0+B35dRQ0po=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 02 Dec 2024 20:02:19 +0100
Subject: [PATCH 1/4] power: supply: ds2760: constify 'struct bin_attribute'
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241202-sysfs-const-bin_attr-psy-v1-1-f846430b8b66@weissschuh.net>
References: <20241202-sysfs-const-bin_attr-psy-v1-0-f846430b8b66@weissschuh.net>
In-Reply-To: <20241202-sysfs-const-bin_attr-psy-v1-0-f846430b8b66@weissschuh.net>
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733166139; l=1541;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=vs237hxNCHuIOeDxAr5dea8fYVyVtnREj4eNa7u5ziw=;
 b=FhfmEOx2XZpc+pfW3LjqcL+yoz3Mx/qIIYNe/k5GfKMq8H2PePGstWivVaV3cFEviHhaNwmjj
 wWAdeU3tiajAPSd9hjumOWZ96TrbZSM/Jueebh6w8p0sp59IarFqctx
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core now allows instances of 'struct bin_attribute' to be
moved into read-only memory. Make use of that to protect them against
accidental or malicious modifications.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/power/supply/ds2760_battery.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/ds2760_battery.c b/drivers/power/supply/ds2760_battery.c
index 7cf4ea06b5003427ac9719043c9a5a4361cb5341..83bdec5a2bda901460e0a8618949baa7ecc11e46 100644
--- a/drivers/power/supply/ds2760_battery.c
+++ b/drivers/power/supply/ds2760_battery.c
@@ -195,22 +195,22 @@ static int w1_ds2760_recall_eeprom(struct device *dev, int addr)
 }
 
 static ssize_t w1_slave_read(struct file *filp, struct kobject *kobj,
-			     struct bin_attribute *bin_attr, char *buf,
+			     const struct bin_attribute *bin_attr, char *buf,
 			     loff_t off, size_t count)
 {
 	struct device *dev = kobj_to_dev(kobj);
 	return w1_ds2760_read(dev, buf, off, count);
 }
 
-static BIN_ATTR_RO(w1_slave, DS2760_DATA_SIZE);
+static const BIN_ATTR_RO(w1_slave, DS2760_DATA_SIZE);
 
-static struct bin_attribute *w1_ds2760_bin_attrs[] = {
+static const struct bin_attribute *const w1_ds2760_bin_attrs[] = {
 	&bin_attr_w1_slave,
 	NULL,
 };
 
 static const struct attribute_group w1_ds2760_group = {
-	.bin_attrs = w1_ds2760_bin_attrs,
+	.bin_attrs_new = w1_ds2760_bin_attrs,
 };
 
 static const struct attribute_group *w1_ds2760_groups[] = {

-- 
2.47.1


