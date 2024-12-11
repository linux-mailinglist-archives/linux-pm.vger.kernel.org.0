Return-Path: <linux-pm+bounces-19046-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C27FE9ED3E2
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 18:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F37A028138B
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 17:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A238D1C1F1F;
	Wed, 11 Dec 2024 17:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XKY4gSqF"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA5E1DE2CA
	for <linux-pm@vger.kernel.org>; Wed, 11 Dec 2024 17:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733939113; cv=none; b=kbeCkULOZIpJNMrgthWvq08OT/c2fIrYP/oZSRbfmzupc47slgctLjxgTncyaUqAJXDTE2LYacgQw4daMhluy4OI4TjOBSvoA+lFf7PtV7xCKpE641Z5lG5Ml3w+btx74nVaUsix4At+Nmx9PdWYC6aylDY+PeHA4NlDs+FFuas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733939113; c=relaxed/simple;
	bh=6ozHm+PAo1J/q6MaSbEgm9/N7abaFJNXmPEyqkgqQnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IfbXEmp3TnY5JvdSPO+k7oRiIlGZNCLsBwgo02w+sofqDX3Q21CaL1oHsbZENgl8xEuRCFCoP8roOnMh8OtCvpQViaYEtL7wBpzhhxnJdSB5t+1Fjhq9Npo0XI2Go6sOEZWy2FihscKkmUHfMlPSrkMLfwRij5PaZeHqhUklqxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XKY4gSqF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733939110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JK3bX7Wpz3IQlcuIrqEXd7kN5s0cjBlDE0BVvz32mBM=;
	b=XKY4gSqFyZs2HtYc9hbqy3y4DW5MYIUnJelbfFYcXsIPxvTi1VFn+qIwYxrHJYT7bRUlpc
	7PhYyX6iuWAV2gRM/PiIOqAveCAnCy5jo0eKQaLVucDLxHdWDqDzSgaHluuXV5DldkV77B
	3zn7JXLWoig0FlLxxjYacd1/dcUKoww=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-658-WTtSej6qNmGY0PUDTG7UNA-1; Wed,
 11 Dec 2024 12:45:09 -0500
X-MC-Unique: WTtSej6qNmGY0PUDTG7UNA-1
X-Mimecast-MFC-AGG-ID: WTtSej6qNmGY0PUDTG7UNA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0789819560A1;
	Wed, 11 Dec 2024 17:45:07 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.61])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0070B1956048;
	Wed, 11 Dec 2024 17:45:03 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Jelle van der Waa <jelle@vdwaa.nl>,
	platform-driver-x86@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v4 1/4] power: supply: power_supply_show_enum_with_available(): Replace spaces with '_'
Date: Wed, 11 Dec 2024 18:44:48 +0100
Message-ID: <20241211174451.355421-2-hdegoede@redhat.com>
In-Reply-To: <20241211174451.355421-1-hdegoede@redhat.com>
References: <20241211174451.355421-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

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

Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2
- Replace spaces with '_' instead of surrounding the text-value by ""
---
 drivers/power/supply/power_supply_sysfs.c | 37 ++++++++++++++++++++---
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index 99bfe1f03eb8..b7b29ce61c34 100644
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
 
@@ -344,8 +373,8 @@ static ssize_t power_supply_store_property(struct device *dev,
 
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


