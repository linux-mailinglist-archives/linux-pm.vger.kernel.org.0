Return-Path: <linux-pm+bounces-13868-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34CD597094B
	for <lists+linux-pm@lfdr.de>; Sun,  8 Sep 2024 20:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D32431F210FA
	for <lists+linux-pm@lfdr.de>; Sun,  8 Sep 2024 18:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C42178376;
	Sun,  8 Sep 2024 18:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QPb50jte"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9AF174EFA
	for <linux-pm@vger.kernel.org>; Sun,  8 Sep 2024 18:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725821637; cv=none; b=JlOfKfQtFAt8tZDXCaMAz/6b6UrQA6xPCdJiYS7aswXZ7/fNx7GsnkWdoiWXYhQOdIk+/JNkkCrASVSGej2YZHwq3rVvtzC5uFb4e7hZz4ZCwtmrxCtRQ8j9lmdCOgN8+v+SlBO9QGSVBcZuAtlJugP5aWlw1goxwU2QJwApCxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725821637; c=relaxed/simple;
	bh=TXjT02nNkweRJpO5Dg7VuI6bj9MzmfhEHygdoEsmS6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K7rojFZ6AtsLSVd8ZIl3Rw18QZ8mnxdqM/61yvxBqYoOWnuTDBstFjBjEvPmr6gPFEyELmOd6znAhITiBhBI9sruwWGS14aXUs4F8cm+JmQWMP9KNvwan8/PkjoUJQzEB2/j5ts+SsW9QYNZkahUaXo2uMR0ZctGfB3Nv7V4lTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QPb50jte; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725821635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=//KSUME4WHQgSBtMhGH4ucq0GV1J/cFmQHUsvLow9Rk=;
	b=QPb50jteuW0mKBqrDGyHN8nRdtdTnn5q+ioQZWyX8sV+7xeyIYOikzaOLP8x62jzWeeCwI
	Z01M/KJKExCluDGK8VKor7F5n/XF5xNq6t3Auh3I9EmeSXsafwvlmaQWevpXvecyH7xbhS
	zYrW8w5+BRl1lk2WquUmDo5sQXw1u7A=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-444-nd4Pff0VM52M-0bsYgIP4A-1; Sun,
 08 Sep 2024 14:53:52 -0400
X-MC-Unique: nd4Pff0VM52M-0bsYgIP4A-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C882A19560A5;
	Sun,  8 Sep 2024 18:53:50 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.33])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CA6A61955D44;
	Sun,  8 Sep 2024 18:53:48 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Andrey Smirnov <andrew.smirnov@gmail.com>,
	linux-pm@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2] power: supply: hwmon: Fix missing temp1_max_alarm attribute
Date: Sun,  8 Sep 2024 20:53:37 +0200
Message-ID: <20240908185337.103696-2-hdegoede@redhat.com>
In-Reply-To: <20240908185337.103696-1-hdegoede@redhat.com>
References: <20240908185337.103696-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Temp channel 0 aka temp1 can have a temp1_max_alarm attribute for
power_supply devices which have a POWER_SUPPLY_PROP_TEMP_ALERT_MAX
property.

HWMON_T_MAX_ALARM was missing from power_supply_hwmon_info for
temp channel 0, causing the hwmon temp1_max_alarm attribute to be
missing from such power_supply devices.

Add this to power_supply_hwmon_info to fix this.

Fixes: f1d33ae806ec ("power: supply: remove duplicated argument in power_supply_hwmon_info")
Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
The original code accidentally listed HWMON_T_MIN_ALARM twice instead
of having HWMON_T_MIN_ALARM + HWMON_T_MAX_ALARM. Commit f1d33ae806ec
fixed this the wrong way by removing the second MIN_ALARM.
---
 drivers/power/supply/power_supply_hwmon.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/power_supply_hwmon.c b/drivers/power/supply/power_supply_hwmon.c
index baacefbdf768..6fbbfb1c685e 100644
--- a/drivers/power/supply/power_supply_hwmon.c
+++ b/drivers/power/supply/power_supply_hwmon.c
@@ -318,7 +318,8 @@ static const struct hwmon_channel_info * const power_supply_hwmon_info[] = {
 			   HWMON_T_INPUT     |
 			   HWMON_T_MAX       |
 			   HWMON_T_MIN       |
-			   HWMON_T_MIN_ALARM,
+			   HWMON_T_MIN_ALARM |
+			   HWMON_T_MAX_ALARM,
 
 			   HWMON_T_LABEL     |
 			   HWMON_T_INPUT     |
-- 
2.46.0


