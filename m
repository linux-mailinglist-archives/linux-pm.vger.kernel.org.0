Return-Path: <linux-pm+bounces-17340-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CFD39C48B3
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 23:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 401F7B2EB08
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 21:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46991BC076;
	Mon, 11 Nov 2024 21:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="PeeEgWAm"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C36D16DC0E;
	Mon, 11 Nov 2024 21:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731361212; cv=none; b=QAqom/AIvi3+tLw2cceFr1zuY1SSLLzBY+/wFKL6H7MS9wHnZImcwP8L0FnEfD9fMLS2uk0cCCasliToag/104II5TtYGSsSSp8kgG3j9yEcRMCibAUYrG9zeJVtzMjLC7aybF+rIAnunJJ4WZnRvowf5ENOBc9HQWxrRXnW/4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731361212; c=relaxed/simple;
	bh=PEMBij3nSwWEOtYjjW03xhQPeVizCPnNovZ+ZQe+NxQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jVmEsI+JsOe0zLRd/ub8a+Mv10yBF9V/sKRcTVPeJ0FrpfbdlOvF4UJ+APp5Xq8yDRQBZN0t379L8J6UG+mwAtqmBpRHlsaqrWBes2tpxjbnZgMQ7vYxJnwVKSjA1fMHB7tD/gAuC99k+UOUuGAF1YGQtJJB9sHzG/d5f4g+/pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=PeeEgWAm; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1731361208;
	bh=PEMBij3nSwWEOtYjjW03xhQPeVizCPnNovZ+ZQe+NxQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PeeEgWAmAMNrUf2LkZ+/uFIYCfd4p5+KyqdBttRJ1VZPkETctNyx5SDZeLPd2eySF
	 SV6o4dnhs80AGyl7dS4oR1I1QDX+clHqJDH4N+DDaoYhtpZjDe922tUiLXmhYq3eaR
	 Gk5bPo5IeX/Kcl/Q3zI8fieLiyNI9xTKyw2FGoXY=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 11 Nov 2024 22:40:03 +0100
Subject: [PATCH v4 1/9] power: supply: sysfs: print single value in uevent
 for POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241111-power-supply-extensions-v4-1-7240144daa8e@weissschuh.net>
References: <20241111-power-supply-extensions-v4-0-7240144daa8e@weissschuh.net>
In-Reply-To: <20241111-power-supply-extensions-v4-0-7240144daa8e@weissschuh.net>
To: Sebastian Reichel <sre@kernel.org>, Armin Wolf <W_Armin@gmx.de>, 
 Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@weissschuh.net>, 
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 chrome-platform@lists.linux.dev, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731361208; l=3176;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=PEMBij3nSwWEOtYjjW03xhQPeVizCPnNovZ+ZQe+NxQ=;
 b=Q0CcjGh9IdrsTiwuhtc26fH7x92TZy2MTu1xePbsdRs43G6WJlMcUSsh/YBC1bINihvWhQxRv
 m+tlLz4gNsCDY5NbLfmDqs6uCZi47wRDJkvTlat5pqGU1sXpE6Z+uPc
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Currently an uevent contains the same string representation of a
property as sysfs. However for POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR this
is specially formatted to indicate all possible values.
This doesn't make sense for uevents and complicates parsing.
Instead only include the currently active value in uevents.

As currently no in-tree driver uses POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR
this change is not a problem.
Soon the property will actually be used so fix the formatting before
that happens.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/power/supply/power_supply_sysfs.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index 571de43fcca9827cf0fe3023e453defbf1eaec7d..a7351b9c8fe34a464a4e69b1a1a4a4179c1a4b4f 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -268,9 +268,11 @@ static ssize_t power_supply_show_enum_with_available(
 	return count;
 }
 
-static ssize_t power_supply_show_property(struct device *dev,
-					  struct device_attribute *attr,
-					  char *buf) {
+static ssize_t power_supply_format_property(struct device *dev,
+					    bool uevent,
+					    struct device_attribute *attr,
+					    char *buf)
+{
 	ssize_t ret;
 	struct power_supply *psy = dev_get_drvdata(dev);
 	const struct power_supply_attr *ps_attr = to_ps_attr(attr);
@@ -303,6 +305,8 @@ static ssize_t power_supply_show_property(struct device *dev,
 				psy->desc->usb_types, value.intval, buf);
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR:
+		if (uevent) /* no possible values in uevents */
+			goto default_format;
 		ret = power_supply_charge_behaviour_show(dev, psy->desc->charge_behaviours,
 							 value.intval, buf);
 		break;
@@ -310,6 +314,7 @@ static ssize_t power_supply_show_property(struct device *dev,
 		ret = sysfs_emit(buf, "%s\n", value.strval);
 		break;
 	default:
+default_format:
 		if (ps_attr->text_values_len > 0 &&
 				value.intval < ps_attr->text_values_len && value.intval >= 0) {
 			ret = sysfs_emit(buf, "%s\n", ps_attr->text_values[value.intval]);
@@ -321,6 +326,13 @@ static ssize_t power_supply_show_property(struct device *dev,
 	return ret;
 }
 
+static ssize_t power_supply_show_property(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	return power_supply_format_property(dev, false, attr, buf);
+}
+
 static ssize_t power_supply_store_property(struct device *dev,
 					   struct device_attribute *attr,
 					   const char *buf, size_t count) {
@@ -437,7 +449,7 @@ static int add_prop_uevent(const struct device *dev, struct kobj_uevent_env *env
 	pwr_attr = &power_supply_attrs[prop];
 	dev_attr = &pwr_attr->dev_attr;
 
-	ret = power_supply_show_property((struct device *)dev, dev_attr, prop_buf);
+	ret = power_supply_format_property((struct device *)dev, true, dev_attr, prop_buf);
 	if (ret == -ENODEV || ret == -ENODATA) {
 		/*
 		 * When a battery is absent, we expect -ENODEV. Don't abort;

-- 
2.47.0


