Return-Path: <linux-pm+bounces-13285-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F995967215
	for <lists+linux-pm@lfdr.de>; Sat, 31 Aug 2024 16:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0D06283505
	for <lists+linux-pm@lfdr.de>; Sat, 31 Aug 2024 14:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1101BDDB;
	Sat, 31 Aug 2024 14:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fEZve2Oe"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F361523776
	for <linux-pm@vger.kernel.org>; Sat, 31 Aug 2024 14:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725114069; cv=none; b=PUP6I3rzNBZEHhxJXlyhnep7rvyEufEHrhBQr56EvaSd+cZgDhCKBqGzFBWkfiZfIqi6WFlOnJZZQxWuAPrwXLTH7n9sJVTmeYtiu90mDcol0OWOq3NaCHRVaJV3wYJdYJx7pdPQYK7NNCYi/wRWBWT5gso15Cojvbu6n6nXoWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725114069; c=relaxed/simple;
	bh=zINAiPqxol2jf7n95zfSwjCFNPHHesldhpOGxFwbcGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=objnXtjj40cyJFnwcyEZlA1KcqVNVpUxyyMNFKxHhWs5Dbfc98jHTC8rFWMg0YPNkzP1pUR5DQx+OOBvUU5lMH74IdUXmOgxKZszxNl3C0YCnF1tQU17SOlobXKTSWRjLXR2zmRP6vYx+amojOXg5iuNSAPVSpsYK6EPRE/7XNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fEZve2Oe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725114067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y5O3GspAeKQ3pneZEdcCy+Sw5OHilzaQkJasxbh7z3U=;
	b=fEZve2OeorTK7NMm3EejtESaekEC1D8/AW99yHc8DH+krZW/JaZuYl3+EfI+r0fo4F5iIi
	s/cfQy4nC1OR3H5MkxSHaCT2JGDd+dQ0rw7XsPCEelJFyjBQr34vgBGWGEjTvhXATvnKXX
	qXShm36Ii3IJvGAbamfx5zEzYIEmX0w=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-596-UNIRLRDgMwesO4-JeuSJWA-1; Sat,
 31 Aug 2024 10:21:03 -0400
X-MC-Unique: UNIRLRDgMwesO4-JeuSJWA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 26D1A19560AD;
	Sat, 31 Aug 2024 14:21:01 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.42])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AC60130001A4;
	Sat, 31 Aug 2024 14:20:55 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Sebastian Reichel <sre@kernel.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Enric Balletbo Serra <enric.balletbo@collabora.com>,
	Andrey Smirnov <andrew.smirnov@gmail.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-phy@lists.infradead.org
Subject: [PATCH 2/6] power: supply: ucs1002: Adjust ucs1002_set_usb_type() to accept string values
Date: Sat, 31 Aug 2024 16:20:35 +0200
Message-ID: <20240831142039.28830-3-hdegoede@redhat.com>
In-Reply-To: <20240831142039.28830-1-hdegoede@redhat.com>
References: <20240831142039.28830-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

power_supply_sysfs.c accept wrrites of strings to "usb_type" for strings
values matching an entry in POWER_SUPPLY_USB_TYPE_TEXT[]. If such a
string value is written then the int value passed to ucs1002_set_property()
will be an enum power_supply_usb_type value.

Before this change ucs1002_set_usb_type() expected the value to be an index
into ucs1002_usb_types[]. Adjust ucs1002_set_usb_type() to use the enum
value directly so that writing string values works.

The list of supported types in ucs1002_usb_types[] is: PD, SDP, DCP, CDP.
The [POWER_SUPPLY_USB_TYPE_]SDP, DCP and CDP enum labels have a value of
1, 2 and 3. So userspace selecting SDP, DCP or CDP by writing 1, 2 or 3
will keep working. POWER_SUPPLY_USB_TYPE_PD which is mapped to the ucs1002
dedicated mode however has a value of 6. Before this change writing 0 would
select the dedicated mode. To preserve userspace API compatibility also map
POWER_SUPPLY_USB_TYPE_UNKNOWN (which is 0) to the dedicated mode.

Cc: Enric Balletbo Serra <enric.balletbo@collabora.com>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/ucs1002_power.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/ucs1002_power.c b/drivers/power/supply/ucs1002_power.c
index 7970843a4f48..b67d5b03d93e 100644
--- a/drivers/power/supply/ucs1002_power.c
+++ b/drivers/power/supply/ucs1002_power.c
@@ -308,10 +308,13 @@ static int ucs1002_set_usb_type(struct ucs1002_info *info, int val)
 {
 	unsigned int mode;
 
-	if (val < 0 || val >= ARRAY_SIZE(ucs1002_usb_types))
-		return -EINVAL;
-
-	switch (ucs1002_usb_types[val]) {
+	switch (val) {
+	/*
+	 * POWER_SUPPLY_USB_TYPE_UNKNOWN == 0, map this to dedicated for
+	 * userspace API compatibility with older versions of this driver
+	 * which mapped 0 to dedicated.
+	 */
+	case POWER_SUPPLY_USB_TYPE_UNKNOWN:
 	case POWER_SUPPLY_USB_TYPE_PD:
 		mode = V_SET_ACTIVE_MODE_DEDICATED;
 		break;
-- 
2.46.0


