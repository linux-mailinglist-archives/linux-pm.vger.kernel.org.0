Return-Path: <linux-pm+bounces-19264-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 510109F24FF
	for <lists+linux-pm@lfdr.de>; Sun, 15 Dec 2024 18:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6088D7A11A5
	for <lists+linux-pm@lfdr.de>; Sun, 15 Dec 2024 17:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763521B219D;
	Sun, 15 Dec 2024 17:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O+nPwgY1"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D536E19993D
	for <linux-pm@vger.kernel.org>; Sun, 15 Dec 2024 17:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734283315; cv=none; b=MV1P1dwmzAp46JStqZWEF9OY+EMefT1ZDNxndBDSkJ0oH8h+KV9ou0laVA6gZkw6CcUQ4/ComjPqKuRuuv2z89ULYqTZ3gV2cRhoaLieUAXnLlbqF3yq8EKGka2aV9Tk3jLGvDRsYdIarXFz+FViN0h9YLaK55MLULnjsFY7UIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734283315; c=relaxed/simple;
	bh=baC+5Y0AsXod56OL6cElErtZM6yuubPxFZSumQXpLWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nOuqGjf892E+Q4JSifLYXOF8q/UokBCLlw7sRRS+d7fflraZ2hJZKwW+OGh60mUdF2JkyKNxMEeOY+7rX1aSJdG9d0I7/N4BzC03M4cd1vNDR/ON1ILJDsnrls2pRF+dPmrBJnpKVKg1b97ZWOfeiqlgrK+sAGXuAOlPEqTB26w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O+nPwgY1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734283312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o051YtfIONNUoOhyEifg3AicqGsMQyhVD2bNTrnKX9I=;
	b=O+nPwgY1zxfoyQFr5iQipV7c57gHVw+Uf1zKjKNgmXOa4L/2BScDyXhWvIryztfhrVxiI5
	HJhg3y+cKRguctHYYEnzpCnax5i3xEFBd/U/Cas/8G2Td6yF1/2zqD+FCTG+2BJsTeOMOX
	fqyxlW6B8dWov3cG0GwCrb+AJJ2w8VY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-503-ZS95ceNdNam1MuokLHgo3g-1; Sun,
 15 Dec 2024 12:21:51 -0500
X-MC-Unique: ZS95ceNdNam1MuokLHgo3g-1
X-Mimecast-MFC-AGG-ID: ZS95ceNdNam1MuokLHgo3g
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4EF3B19560A3;
	Sun, 15 Dec 2024 17:21:50 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.51])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3276F195605A;
	Sun, 15 Dec 2024 17:21:48 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	linux-pm@vger.kernel.org
Subject: [PATCH 6/8] power: supply: adc-battery-helper: Fix reporting capacity > 100%
Date: Sun, 15 Dec 2024 18:21:29 +0100
Message-ID: <20241215172133.178460-7-hdegoede@redhat.com>
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
index 1917e92ab1eb..104d9a888486 100644
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


