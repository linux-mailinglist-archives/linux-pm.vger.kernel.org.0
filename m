Return-Path: <linux-pm+bounces-18774-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 021589E853E
	for <lists+linux-pm@lfdr.de>; Sun,  8 Dec 2024 14:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AA4316444E
	for <lists+linux-pm@lfdr.de>; Sun,  8 Dec 2024 13:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BD115697B;
	Sun,  8 Dec 2024 13:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="FkRwI4lO"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCB2154426;
	Sun,  8 Dec 2024 13:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733662966; cv=none; b=X64hrT5ueMrhcQVygLfi6ElQ0YwUHX2QkcYyR4SENvu9HuQKEaYeFc/b72tY6wVKBUFripFEW3w0OctjsNhAWjfxC7zJn2GM3aoceCZFPQkPy2S5svaJWTKZ/ut5UkM9S3oqWcohMs5rUtygSkqzZzKgwL9NJoEv47+YLOWvgdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733662966; c=relaxed/simple;
	bh=FhwKSD0svgWVmDIfiDfI4K9PqSyh7QPjCU6VOQVWlzw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UNqczwVnphd/EOM3SNl1UBq/nUAcD1iuBAMqeVyW5frl1ao0W/mZ/1HLLfXE6zdNMnGtv6y+k+U+PsamOAWMnPRMUpL3OIQEt1a41S/6A2QIepkKTKT5HGDFbMIvckiJDmrPY26uqM2KNUbFnpMlJzkgWnl8eTzPLZASuSlLIG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=FkRwI4lO; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733662959;
	bh=FhwKSD0svgWVmDIfiDfI4K9PqSyh7QPjCU6VOQVWlzw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FkRwI4lOQB3Qc+iiQkkfmp4dOzbdU8bEK1PzJfAGMUCqwKef6GWFiQTO2tk6aip3+
	 es6Tknr2MY2ViKOYLL9JvdsYyFvEs1Sl47s1vRWbCRSVWaDrF3AeIoUa9X6osS6012
	 xFxnB6wAngXU8ijmv3ahcDBfVGWGqeNpG/JRtH0E=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 08 Dec 2024 14:02:41 +0100
Subject: [PATCH 09/14] power: supply: sysfs: use dev_to_psy()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241208-power-supply-dev_to_psy-v1-9-f95de9117558@weissschuh.net>
References: <20241208-power-supply-dev_to_psy-v1-0-f95de9117558@weissschuh.net>
In-Reply-To: <20241208-power-supply-dev_to_psy-v1-0-f95de9117558@weissschuh.net>
To: Sebastian Reichel <sre@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Maximilian Luz <luzmaximilian@gmail.com>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 platform-driver-x86@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733662957; l=2083;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=FhwKSD0svgWVmDIfiDfI4K9PqSyh7QPjCU6VOQVWlzw=;
 b=XPfi4TNCjbFrPfYK0u8q/s3oI97RuLONHZYg1Y2upaAoMTQYYJSVGr/UoUnKBl4aBIC8apNQM
 +O1YWRcRtXDAoFuFXdrNrK4Llvs/DW9Pm66UmAk8GdfBdAbK9J/hOnm
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Use the new, explicit accessor to go from a 'struct device' to its
'struct power_supply'.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/power/supply/power_supply_sysfs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index 99bfe1f03eb8326d38c4e2831c9670313b42e425..85b5134b8552cc573724e4cd5794a598192d3137 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -274,7 +274,7 @@ static ssize_t power_supply_format_property(struct device *dev,
 					    char *buf)
 {
 	ssize_t ret;
-	struct power_supply *psy = dev_get_drvdata(dev);
+	struct power_supply *psy = dev_to_psy(dev);
 	const struct power_supply_attr *ps_attr = to_ps_attr(attr);
 	enum power_supply_property psp = dev_attr_psp(attr);
 	union power_supply_propval value;
@@ -337,7 +337,7 @@ static ssize_t power_supply_store_property(struct device *dev,
 					   struct device_attribute *attr,
 					   const char *buf, size_t count) {
 	ssize_t ret;
-	struct power_supply *psy = dev_get_drvdata(dev);
+	struct power_supply *psy = dev_to_psy(dev);
 	const struct power_supply_attr *ps_attr = to_ps_attr(attr);
 	enum power_supply_property psp = dev_attr_psp(attr);
 	union power_supply_propval value;
@@ -376,7 +376,7 @@ static umode_t power_supply_attr_is_visible(struct kobject *kobj,
 					   int attrno)
 {
 	struct device *dev = kobj_to_dev(kobj);
-	struct power_supply *psy = dev_get_drvdata(dev);
+	struct power_supply *psy = dev_to_psy(dev);
 	umode_t mode = S_IRUSR | S_IRGRP | S_IROTH;
 
 	if (!power_supply_attrs[attrno].prop_name)
@@ -462,7 +462,7 @@ static int add_prop_uevent(const struct device *dev, struct kobj_uevent_env *env
 
 int power_supply_uevent(const struct device *dev, struct kobj_uevent_env *env)
 {
-	struct power_supply *psy = dev_get_drvdata(dev);
+	const struct power_supply *psy = dev_to_psy(dev);
 	int ret = 0, j;
 	char *prop_buf;
 

-- 
2.47.1


