Return-Path: <linux-pm+bounces-18863-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7779EA077
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 21:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F06AD282511
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 20:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE82199239;
	Mon,  9 Dec 2024 20:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RUwOEnxM"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FB919AD8C
	for <linux-pm@vger.kernel.org>; Mon,  9 Dec 2024 20:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733776869; cv=none; b=PMNkyoQQ8VAQzLydguhYV/sbcLWvz2XZHbLkk7BpbKwoI5UmWsw43JVt0x6J8+/gShPvcZEYFDssAYU+vW+256SqLLiwMhaLSqhMheBVdvkeR6RWrJ5b5YPqvvC/4UyHbi0EZ8J6OZfAefOFpFvBWDHJy3cbx+PVmrdIvjSqIfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733776869; c=relaxed/simple;
	bh=paPAlffF8vhX5ObFCLLEx3I/GnOxk3OzFtB6ZX9OkY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OKM3CKVd1fLlFtL74K54+kzznz5rDLrN91KVA9yvLqOAXvE6QsuK0jpQY5ULcapO6M7TgXNINfh+VtggfsMOhJtuCf2elib/i2B4WoS4UU0BIy4Z0zYgUbupqrKQPcs4QLLX+ioAfLPXBaNoCOrEjvJXfJGKVvgSRH1kROnSeEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RUwOEnxM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733776866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lohySg24lUWiNmGZRpxy4jFG4cYR/OvwLjGt+18U+3I=;
	b=RUwOEnxMxjAYLWn2BGMu3VfFx1ZOb+MmlqIHKBc/0ytmcxpoRNpSXf8VlXeCTkLo0RZtXk
	Y9A+wSuVNXBIjPR6Ediui2piMGkEXna94zF3yOEpl6v8xrRX1ZYrlYvp6ohZDQrsllqhbn
	9V4OB03IjF1ks/+D/zKVkuknC4FduGY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-222-rp8hhgANP7GNH8xlXkN-fQ-1; Mon,
 09 Dec 2024 15:41:02 -0500
X-MC-Unique: rp8hhgANP7GNH8xlXkN-fQ-1
X-Mimecast-MFC-AGG-ID: rp8hhgANP7GNH8xlXkN-fQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3F69819560B3;
	Mon,  9 Dec 2024 20:40:59 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.3])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 08F023000199;
	Mon,  9 Dec 2024 20:40:55 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	platform-driver-x86@vger.kernel.org,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Jelle van der Waa <jelle@vdwaa.nl>,
	linux-pm@vger.kernel.org
Subject: [PATCH v3 1/4] power: supply: power_supply_show_enum_with_available(): Replace spaces with '_'
Date: Mon,  9 Dec 2024 21:40:48 +0100
Message-ID: <20241209204051.8786-2-hdegoede@redhat.com>
In-Reply-To: <20241209204051.8786-1-hdegoede@redhat.com>
References: <20241209204051.8786-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Some enum style power-supply properties have text-values / labels for some
of the enum values containing a space, e.g. "Long Life" for
POWER_SUPPLY_CHARGE_TYPE_LONGLIFE.

Make power_supply_show_enum_with_available() replace these spaces with
'_' when showing the available text-values. After this the output for
a battery which supports "Long Life" will be e.g.:

Fast [Standard] Long_Life

or:

Fast Standard [Long_Life]

Modify power_supply_store_property() to accept both the original text-value
with space and the alternative value with the spaces replaced by '_'.
This allows users to write the value with '_' after seeing this on reading
the property.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2
- Replace spaces with '_' instead of surrounding the text-value by ""
---
 drivers/power/supply/power_supply_sysfs.c | 37 ++++++++++++++++++++---
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index 571de43fcca9..034e1848f1ca 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -237,23 +237,52 @@ static enum power_supply_property dev_attr_psp(struct device_attribute *attr)
 	return  to_ps_attr(attr) - power_supply_attrs;
 }
 
+static void power_supply_escape_spaces(const char *str, char *buf, size_t bufsize)
+{
+	strscpy(buf, str, bufsize);
+	strreplace(buf, ' ', '_');
+}
+
+static int power_supply_match_string(const char * const *array, size_t n, const char *s)
+{
+	int ret;
+
+	/* First try an exact match */
+	ret = __sysfs_match_string(array, n, s);
+	if (ret >= 0)
+		return ret;
+
+	/* Second round, try matching with spaces replaced by '_' */
+	for (size_t i = 0; i < n; i++) {
+		char buf[32];
+
+		power_supply_escape_spaces(array[i], buf, sizeof(buf));
+		if (sysfs_streq(buf, s))
+			return i;
+	}
+
+	return -EINVAL;
+}
+
 static ssize_t power_supply_show_enum_with_available(
 			struct device *dev, const char * const labels[], int label_count,
 			unsigned int available_values, int value, char *buf)
 {
 	bool match = false, available, active;
+	char escaped_label[32];
 	ssize_t count = 0;
 	int i;
 
 	for (i = 0; i < label_count; i++) {
 		available = available_values & BIT(i);
 		active = i == value;
+		power_supply_escape_spaces(labels[i], escaped_label, sizeof(escaped_label));
 
 		if (available && active) {
-			count += sysfs_emit_at(buf, count, "[%s] ", labels[i]);
+			count += sysfs_emit_at(buf, count, "[%s] ", escaped_label);
 			match = true;
 		} else if (available) {
-			count += sysfs_emit_at(buf, count, "%s ", labels[i]);
+			count += sysfs_emit_at(buf, count, "%s ", escaped_label);
 		}
 	}
 
@@ -332,8 +361,8 @@ static ssize_t power_supply_store_property(struct device *dev,
 
 	ret = -EINVAL;
 	if (ps_attr->text_values_len > 0) {
-		ret = __sysfs_match_string(ps_attr->text_values,
-					   ps_attr->text_values_len, buf);
+		ret = power_supply_match_string(ps_attr->text_values,
+						ps_attr->text_values_len, buf);
 	}
 
 	/*
-- 
2.47.1


