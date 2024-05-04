Return-Path: <linux-pm+bounces-7502-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0571F8BBD27
	for <lists+linux-pm@lfdr.de>; Sat,  4 May 2024 18:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34B9F1C20EAF
	for <lists+linux-pm@lfdr.de>; Sat,  4 May 2024 16:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5398C5A10B;
	Sat,  4 May 2024 16:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gi6CiFfA"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FD82943C
	for <linux-pm@vger.kernel.org>; Sat,  4 May 2024 16:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714840889; cv=none; b=lDNwxmMigdGthEL921mBrycqn+uadoP+9udWJLMNADqA/5XnBnF94yhrr5Gg+NAljTJrzjovcwXun77AYJ6ohdb7lFos0m2HbY78OE0oqQcScRyjY1ATYVvwgtBrEAcwaz/Eooc3yDkMhU9gOTvN53xsVBY21cYnPUKqpG7O6eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714840889; c=relaxed/simple;
	bh=KpPSxuxTopSdsLMFYAJuW1G57t5i7Cbx33R8xgTuY98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lKmqmf43jvPaQaxqKNtHvaozez73Qa2KVqDVNsDIB9A+1o1hhu4WfYWhTWu3EijUsScgM8QXXFxxiwoVIJEwW/r+wWrPvhnCar98h8rGvvaVqhx6XlDw2LhXwX78GCX8ARPtJFqG2axcZzpcTG1ovE8XMhfKfdK5rlXxw/jPiMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gi6CiFfA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714840885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GQlS9M0dUp2fANP/c9CMKV6Udz7olRiD9amcpYiERow=;
	b=Gi6CiFfApRZ9d5N96MskA7WKv7X0oItu8tVEhtyT4j+N1nXv0MkAWyoh0f6X7Zdu9wwJJm
	1lodouigWmqShBbPGY/g+9S2FWxkOs6pZQtRieRuMJ+eIX+07bl0l5t6UEG954atco3MGR
	11sCnOOarGEJ2rXR0+qkb8duCSbKLMw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-184-1ZV0f4_hMfqrYX__KL2mYQ-1; Sat,
 04 May 2024 12:41:20 -0400
X-MC-Unique: 1ZV0f4_hMfqrYX__KL2mYQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 71FC038116EE;
	Sat,  4 May 2024 16:41:19 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.41])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1F3D9EC680;
	Sat,  4 May 2024 16:41:18 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	Kate Hsuan <hpa@redhat.com>,
	Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	platform-driver-x86@vger.kernel.org,
	=?UTF-8?q?Andr=C3=A9=20Apitzsch?= <git@apitzsch.eu>,
	linux-leds@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v9 2/7] leds: rgb: leds-ktd202x: I2C ID tables for KTD2026 and 2027
Date: Sat,  4 May 2024 18:41:00 +0200
Message-ID: <20240504164105.114017-3-hdegoede@redhat.com>
In-Reply-To: <20240504164105.114017-1-hdegoede@redhat.com>
References: <20240504164105.114017-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

From: Kate Hsuan <hpa@redhat.com>

Add an i2c_device_id id_table to match manually instantiated
(non device-tree / ACPI instantiated) KTD202x controllers as
found on some x86 boards.

This table shows the maximum support LED channel for KTD2026
(three LEDs) and KTD-2027 (4 LEDs).

Link: https://www.kinet-ic.com/uploads/KTD2026-7-04h.pdf
Signed-off-by: Kate Hsuan <hpa@redhat.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/leds/rgb/leds-ktd202x.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/leds/rgb/leds-ktd202x.c b/drivers/leds/rgb/leds-ktd202x.c
index f1c810c415a4..60ca6ec34336 100644
--- a/drivers/leds/rgb/leds-ktd202x.c
+++ b/drivers/leds/rgb/leds-ktd202x.c
@@ -606,6 +606,13 @@ static void ktd202x_shutdown(struct i2c_client *client)
 	regmap_write(chip->regmap, KTD202X_REG_RESET_CONTROL, KTD202X_RSTR_RESET);
 }
 
+static const struct i2c_device_id ktd202x_id[] = {
+	{"ktd2026", KTD2026_NUM_LEDS},
+	{"ktd2027", KTD2027_NUM_LEDS},
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, ktd202x_id);
+
 static const struct of_device_id ktd202x_match_table[] = {
 	{ .compatible = "kinetic,ktd2026", .data = (void *)KTD2026_NUM_LEDS },
 	{ .compatible = "kinetic,ktd2027", .data = (void *)KTD2027_NUM_LEDS },
@@ -621,6 +628,7 @@ static struct i2c_driver ktd202x_driver = {
 	.probe = ktd202x_probe,
 	.remove = ktd202x_remove,
 	.shutdown = ktd202x_shutdown,
+	.id_table = ktd202x_id,
 };
 module_i2c_driver(ktd202x_driver);
 
-- 
2.44.0


