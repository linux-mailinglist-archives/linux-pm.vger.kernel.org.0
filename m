Return-Path: <linux-pm+bounces-13858-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB806970835
	for <lists+linux-pm@lfdr.de>; Sun,  8 Sep 2024 16:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EE9B1F21186
	for <lists+linux-pm@lfdr.de>; Sun,  8 Sep 2024 14:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791CB167296;
	Sun,  8 Sep 2024 14:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aQBr0+Cm"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC57EACD
	for <linux-pm@vger.kernel.org>; Sun,  8 Sep 2024 14:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725806671; cv=none; b=X4YTt/UoqBh8Z7/WJLxVD0ZHREgBe4XCTtbounIywU2tK5q2mGliPpnEh6whvA4S9yiBQbQVbkBvga+vCW62tMv9TFamgFVfXqrngfuVFkqq6opJEhnI24Ui/53ZBtheFN2VTT3nNCRKAbz0v22nFF+EOk70F292UkaqkyCiKxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725806671; c=relaxed/simple;
	bh=zdlRpztLmzftiRfjsq2RXQaqloPZy8rJ6OyhqHp2cGc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TM/rZch4Y+NtgDppxs9BqcqBMPOROCq7q6gHNdAiiWX1DytnfDq3U5aQiRx6UvjOypEgYmAeXZpiQHTofMKEgeHo0Lpdx9vIhHKjuCMrvEajc+QB1+TPVxglnJpiEmb+YN6EdO7pa9fBjP2Vlw6bA/caX2Lceb7Dhevoj0EjFt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aQBr0+Cm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725806667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=duFMkMJ3Fvhj52p9hfDJs48kWrkYGevSwaUUN1sFCko=;
	b=aQBr0+CmdLPMHP36BU5qWn0GOn4Y5CdlbRSdYknYbR9Up0AzEeQ/1KF4BTRwK/bcSnqHsj
	TQPrkHmntjePjkmJYyxtW0+ekNoHA0DeGVPi7VyrkhYLCybBZ3Zjw+mXm3HQRi+P5zE5w/
	osRWou0nv4+Q86hpBxMowfK6yoOa1G8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-501-KBHFqJkVNzmIwOtXd4M_Gw-1; Sun,
 08 Sep 2024 10:44:25 -0400
X-MC-Unique: KBHFqJkVNzmIwOtXd4M_Gw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CC8B61956089;
	Sun,  8 Sep 2024 14:44:22 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.73])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BBDCB1956054;
	Sun,  8 Sep 2024 14:44:20 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	linux-pm@vger.kernel.org,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 6.11 regression fix] power: supply: sysfs: Revert use power_supply_property_is_writeable()
Date: Sun,  8 Sep 2024 16:44:14 +0200
Message-ID: <20240908144414.82887-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

power_supply_property_is_writeable() contains the following check:

        if (atomic_read(&psy->use_cnt) <= 0 ||
                        !psy->desc->property_is_writeable)
                return -ENODEV;

psy->use_cnt gets initialized to 0 and is incremented by
__power_supply_register() after it calls device_add(); and thus after
the driver core calls power_supply_attr_is_visible() to get the attr's
permissions.

So when power_supply_attr_is_visible() runs psy->use_cnt is 0 failing
the above check. This is causing all the attributes to have permissions
of 444 even those which should be writable.

Move back to manually calling psy->desc->property_is_writeable() without
the psy->use_cnt check to fix this.

Fixes: be6299c6e55e ("power: supply: sysfs: use power_supply_property_is_writeable()")
Cc: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Note this is a straight-forward revert of be6299c6e55e
---
 drivers/power/supply/power_supply_sysfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index 6cd3fac1891b..fb9b67b5a9aa 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -387,7 +387,8 @@ static umode_t power_supply_attr_is_visible(struct kobject *kobj,
 		int property = psy->desc->properties[i];
 
 		if (property == attrno) {
-			if (power_supply_property_is_writeable(psy, property) > 0)
+			if (psy->desc->property_is_writeable &&
+			    psy->desc->property_is_writeable(psy, property) > 0)
 				mode |= S_IWUSR;
 
 			return mode;
-- 
2.46.0


