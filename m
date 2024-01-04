Return-Path: <linux-pm+bounces-1862-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E615824845
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jan 2024 19:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB6A628707E
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jan 2024 18:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06A324B3C;
	Thu,  4 Jan 2024 18:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UgxsaWNw"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374C728E02
	for <linux-pm@vger.kernel.org>; Thu,  4 Jan 2024 18:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704393333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=F9ZBJJfDZvL4vcmw1UTFuG3ge8BWaykNpSZgdDbo8vs=;
	b=UgxsaWNwvPOqXbpZB9D9KM7YCGiet4sYA1I3+GpaLIaeh6lsdtc1sQVLR0+lu3WoEnqHl/
	afyTxaTbJGcXgAQcUa2JGiB9w7i9XNAFQ1m5TB13xRf9SihWJs0mLvesqlsnYY6DN93pG1
	VWvX+bEYL2OCFfYXCIwAJBOJTmmxcWs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-sqSeawCEOIq0W2uyVgir1Q-1; Thu, 04 Jan 2024 13:35:26 -0500
X-MC-Unique: sqSeawCEOIq0W2uyVgir1Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 25A9588B7A0;
	Thu,  4 Jan 2024 18:35:26 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.122])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4776E3C27;
	Thu,  4 Jan 2024 18:35:25 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Chen-Yu Tsai <wens@csie.org>,
	linux-pm@vger.kernel.org
Subject: [PATCH 1/3] power: supply: axp288_charger: Call power_supply_changed() after set_property()
Date: Thu,  4 Jan 2024 19:35:14 +0100
Message-ID: <20240104183516.312044-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

A successful set_property() call may result in some related properties
on the charger and/or the battery it is supplying having changed.

Call power_supply_changed() after a successful set_property().

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/axp288_charger.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supply/axp288_charger.c
index b5903193e2f9..3c442114d55b 100644
--- a/drivers/power/supply/axp288_charger.c
+++ b/drivers/power/supply/axp288_charger.c
@@ -359,6 +359,8 @@ static int axp288_charger_usb_set_property(struct power_supply *psy,
 
 out:
 	mutex_unlock(&info->lock);
+	if (ret == 0)
+		power_supply_changed(info->psy_usb);
 	return ret;
 }
 
-- 
2.43.0


