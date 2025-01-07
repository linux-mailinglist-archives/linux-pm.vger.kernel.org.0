Return-Path: <linux-pm+bounces-20028-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE00CA03DD5
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 12:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11D0F7A27CC
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 11:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CAA81E9B03;
	Tue,  7 Jan 2025 11:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gz4ERnim"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C5A1E1025
	for <linux-pm@vger.kernel.org>; Tue,  7 Jan 2025 11:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736249642; cv=none; b=jHJtXVgyQgaqMUMHteEffMzBSliEMKpNb+j4F7SIha18TuNGMdvezwPUKU4mnutKe/EpndbADbQsUH9NHfmGwzc/gluuaU7NGH9TKKLTFlxw5S9E+IrOsoJI62gTFF4X8eQidVKtIUA8tOJ8/JslH8Ma75Xh7Z24GUqfNublOYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736249642; c=relaxed/simple;
	bh=sNJsp5Eeh14WzwncgtQegvKOhZVyidrhh0KCGQhkb1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ik+7+U+C4aoIMcoYODn0xwlG7KFFgETZY22AGQveddKFqe26tHVMTZCVg0e8Er9asBUpzoIhtPc8qPwJDahRzjHaKyI4lIo2Fjju1SRvSDSS8JNX+tV3Izv43EoJwMOssMUlR2AUhfTnB0ogTuw9XZnKU1kCIYWvyeIqRhV0DLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gz4ERnim; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736249639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jOqmC6/umgpKSQHeWjJhhSbMoCA0U8VYpk9tTPD1ZVs=;
	b=Gz4ERnimbona7Z6N3mQhTppAS3AbGeZmSx6Jo4MiLdnj8lu3XcjWwwdRdvOKQc2pU1hKnE
	bsRvtFoScNPpiNl8F5UFglB4qnPOqJCT3kbhOWiJM3Q1LRH4VA7Kgyq2IgDC/av2POmvWI
	m3H0cf1Li9JFi2UrHnPDz9Ez6snFQuM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-225-_lKpp0dhM26zYMY1iqJUig-1; Tue,
 07 Jan 2025 06:33:57 -0500
X-MC-Unique: _lKpp0dhM26zYMY1iqJUig-1
X-Mimecast-MFC-AGG-ID: _lKpp0dhM26zYMY1iqJUig
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A0C651956077;
	Tue,  7 Jan 2025 11:33:55 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.193.144])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 654BB3000197;
	Tue,  7 Jan 2025 11:33:54 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	linux-pm@vger.kernel.org
Subject: [PATCH v2 4/6] power: supply: adc-battery-helper: Fix reporting capacity > 100%
Date: Tue,  7 Jan 2025 12:33:44 +0100
Message-ID: <20250107113346.170612-5-hdegoede@redhat.com>
In-Reply-To: <20250107113346.170612-1-hdegoede@redhat.com>
References: <20250107113346.170612-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

The ocv_capacity_tbl[] to map the ocv voltage to capacity goes up to
4.3V for LiPo High Voltage (LiHV) cells.

For non HV cells the code assumes that the estimated ocv value never
comes above 4.2V, but there might be cases where it does go above
4.2V leading to adc_battery_helper_get_capacity() reporting a capacity
above 100%.

Do not use the table entries with a voltage above 4.2V for non HV cells
to avoid this use.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/adc-battery-helper.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/adc-battery-helper.c b/drivers/power/supply/adc-battery-helper.c
index 089ed919410c..fcbe484a4c90 100644
--- a/drivers/power/supply/adc-battery-helper.c
+++ b/drivers/power/supply/adc-battery-helper.c
@@ -115,7 +115,7 @@ static int adc_battery_helper_get_capacity(struct adc_battery_helper *help)
 		4250000,
 		4300000,
 	};
-	int i, ocv_diff, ocv_step;
+	int i, array_len, ocv_diff, ocv_step;
 
 	if (help->ocv_avg_uv < ocv_capacity_tbl[0])
 		return 0;
@@ -123,7 +123,16 @@ static int adc_battery_helper_get_capacity(struct adc_battery_helper *help)
 	if (help->status == POWER_SUPPLY_STATUS_FULL)
 		return 100;
 
-	for (i = 1; i < ARRAY_SIZE(ocv_capacity_tbl); i++) {
+	/*
+	 * Ignore the array-entries with voltages > 4200000 for non High-Voltage
+	 * batteries to avoid reporting values > 100% in the non HV case.
+	 */
+	if (help->psy->battery_info->constant_charge_voltage_max_uv >= 4300000)
+		array_len = ARRAY_SIZE(ocv_capacity_tbl);
+	else
+		array_len = ARRAY_SIZE(ocv_capacity_tbl) - 2;
+
+	for (i = 1; i < array_len; i++) {
 		if (help->ocv_avg_uv > ocv_capacity_tbl[i])
 			continue;
 
-- 
2.47.1


