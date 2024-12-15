Return-Path: <linux-pm+bounces-19260-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BAF19F24FA
	for <lists+linux-pm@lfdr.de>; Sun, 15 Dec 2024 18:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6295B164705
	for <lists+linux-pm@lfdr.de>; Sun, 15 Dec 2024 17:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B0D1B394C;
	Sun, 15 Dec 2024 17:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HQQEQIeC"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEAE199252
	for <linux-pm@vger.kernel.org>; Sun, 15 Dec 2024 17:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734283310; cv=none; b=j2Jtggu0XZejTmOQPbDHZdmPgEePo9zQ9iosgn43NsnXtbduVVoeqRkMqoqQfNVwdLWjqBo8W0xPcCl/4doPCS5CBThnTW0Gzwq2N9caOnmnH+5uWma5c3TOuCAo+6+4s6PUdCVixJthNSczymc2GyjzNHr4iNs81N4339snM/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734283310; c=relaxed/simple;
	bh=FpagBzpadjdugK8vP+FdqRPXynBQIevUfmOWE6+DXM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lS6YFoj/QoTTQTWtT0t6MN9KVQm4D9kj/xV4kdFAjLvUmqCwbHF0RCl8bEyQrfA0yyKn+WrFX1MAtuzqpojrMu1rukR3vw58AqkK4EqwA7yA/35J/AFwqVt1FTyru434aDyKtmn1j1YGh9MXAaXeaZi8STh/eW6Nkxs8gX4vl1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HQQEQIeC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734283308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gCExS2GQQVUfl2HkmDSFZ4RIkpnjywd3Qq4IE+TUcDc=;
	b=HQQEQIeCy5tka3bltdukkvo9C7dsKOm3c60cFv7SQ726uxjvMAIeeZHroq6dJccVpjK5h9
	06XbJHlQBhQnd8I2ViAOeF0W7rrLOHMkAMLx0Yz4KctGOsJsEQ2y0WadQzViOK3S0XA1b4
	z2JbmLwT0aO4lmG06OGNlSV7+9x7OrQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-HaSNKq72Mj65MS2xJIRzlQ-1; Sun,
 15 Dec 2024 12:21:46 -0500
X-MC-Unique: HaSNKq72Mj65MS2xJIRzlQ-1
X-Mimecast-MFC-AGG-ID: HaSNKq72Mj65MS2xJIRzlQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B007D19560A3;
	Sun, 15 Dec 2024 17:21:45 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.51])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6EF2D195605A;
	Sun, 15 Dec 2024 17:21:44 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	linux-pm@vger.kernel.org
Subject: [PATCH 3/8] power: supply: ug3105_battery: Let the core handle POWER_SUPPLY_PROP_TECHNOLOGY
Date: Sun, 15 Dec 2024 18:21:26 +0100
Message-ID: <20241215172133.178460-4-hdegoede@redhat.com>
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

The power-supply core already takes care of handling
POWER_SUPPLY_PROP_TECHNOLOGY based on the battery_info.

Drop the unnecessary handling from the driver.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/ug3105_battery.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/power/supply/ug3105_battery.c b/drivers/power/supply/ug3105_battery.c
index ccc5c4d2e230..38e23bdd4603 100644
--- a/drivers/power/supply/ug3105_battery.c
+++ b/drivers/power/supply/ug3105_battery.c
@@ -287,7 +287,6 @@ static void ug3105_work(struct work_struct *work)
 static enum power_supply_property ug3105_battery_props[] = {
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_PRESENT,
-	POWER_SUPPLY_PROP_TECHNOLOGY,
 	POWER_SUPPLY_PROP_SCOPE,
 	POWER_SUPPLY_PROP_VOLTAGE_NOW,
 	POWER_SUPPLY_PROP_VOLTAGE_OCV,
@@ -316,9 +315,6 @@ static int ug3105_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_PRESENT:
 		val->intval = 1;
 		break;
-	case POWER_SUPPLY_PROP_TECHNOLOGY:
-		val->intval = chip->info->technology;
-		break;
 	case POWER_SUPPLY_PROP_SCOPE:
 		val->intval = POWER_SUPPLY_SCOPE_SYSTEM;
 		break;
-- 
2.47.1


