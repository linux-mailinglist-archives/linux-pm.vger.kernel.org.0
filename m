Return-Path: <linux-pm+bounces-19262-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A10CF9F24FD
	for <lists+linux-pm@lfdr.de>; Sun, 15 Dec 2024 18:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DF727A11A5
	for <lists+linux-pm@lfdr.de>; Sun, 15 Dec 2024 17:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D8D1B414D;
	Sun, 15 Dec 2024 17:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XtP0f/ur"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FDC1B4138
	for <linux-pm@vger.kernel.org>; Sun, 15 Dec 2024 17:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734283313; cv=none; b=d0U9bk9cQq/PLVlgDCrpBtcLXmAscsTPW4lYU8DCntsNfaKw1I3ITk5z0LXQVqlt/HLVBF7u/ZMfwl1BxHb8w88Ab2VMCwh3EO8JTEo38KJE+Jn7gaD322Ou77SDXjl/SR0vh+YL9A9ThBSvo1aNkoCG5bHjFbhdkVY/GCz8wKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734283313; c=relaxed/simple;
	bh=FiV/ZuFImTrqTHapITSZqL4+GK1rpTFj9SEW4OW8Tb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lqZ2oSLPqv5NPkTrMq461pu2cP5Q67eV7ZVDziGG9PgmwL9XgNU26EWTljqHyMopbkTEh8IlcmF7E3ZQIJNzGdGXyZVADfO7qX7kHCShlRthIKna5Sw3k2kUZfdNaL/Mhp7Yg5RPfQF85nnl6kSQDTWjZP+Qcb3o7wlul2Go+k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XtP0f/ur; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734283311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V7DZmgTPNoj6PSGzKxL+tnUIAhI5Qohrd49vV833GF8=;
	b=XtP0f/urHZcCsIgVS2Q4itWRnYh0+aTo071nYLvB0EBp8tWV16TLHsJmAjh7bMWpt22nZ8
	gt+K84zlFfk64E5ynvRPmR+XSsEt3o2fNaejgW8aRnelCc//qCtX2Z89O/9gU8GokeY5sD
	SILQhINX1eaIenK5qyyZ39D7kZ2P8As=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-474-8LP9ARGyM-OLCIfvk5EaWw-1; Sun,
 15 Dec 2024 12:21:49 -0500
X-MC-Unique: 8LP9ARGyM-OLCIfvk5EaWw-1
X-Mimecast-MFC-AGG-ID: 8LP9ARGyM-OLCIfvk5EaWw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C05001956089;
	Sun, 15 Dec 2024 17:21:48 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.51])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 94544195605A;
	Sun, 15 Dec 2024 17:21:47 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	linux-pm@vger.kernel.org
Subject: [PATCH 5/8] power: supply: ug3105_battery: Put FG in standby on remove and shutdown
Date: Sun, 15 Dec 2024 18:21:28 +0100
Message-ID: <20241215172133.178460-6-hdegoede@redhat.com>
In-Reply-To: <20241215172133.178460-1-hdegoede@redhat.com>
References: <20241215172133.178460-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Put the fuel-gauge in standby mode when the driver is unbound and on
system shutdown.

This avoids unnecessary battery drain when the system is off.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/ug3105_battery.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/power/supply/ug3105_battery.c b/drivers/power/supply/ug3105_battery.c
index 3cd0c6944750..8d4ee8c12db9 100644
--- a/drivers/power/supply/ug3105_battery.c
+++ b/drivers/power/supply/ug3105_battery.c
@@ -206,6 +206,8 @@ static struct i2c_driver ug3105_i2c_driver = {
 		.pm = &ug3105_pm_ops,
 	},
 	.probe = ug3105_probe,
+	.remove = ug3105_stop,
+	.shutdown = ug3105_stop,
 	.id_table = ug3105_id,
 };
 module_i2c_driver(ug3105_i2c_driver);
-- 
2.47.1


