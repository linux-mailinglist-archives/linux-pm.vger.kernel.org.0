Return-Path: <linux-pm+bounces-39944-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D89CCDE9F3
	for <lists+linux-pm@lfdr.de>; Fri, 26 Dec 2025 12:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1204B300CBBF
	for <lists+linux-pm@lfdr.de>; Fri, 26 Dec 2025 11:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F9631A55F;
	Fri, 26 Dec 2025 11:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SzTt57Xo";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PN/lkGsa"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB2D319600
	for <linux-pm@vger.kernel.org>; Fri, 26 Dec 2025 11:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766747431; cv=none; b=KnbzJp5slFytG0KhmgecuZeh+njiY8ZiRu/ce7rYBUZW3NiaEqdY3ECvIc5PhKpA9ph1KGRmFOt5vad65uzlR+lPPGV292RUmdZeedvKNlwLbP/wrz1BdSHNLG2VsWsWgRisah/PdSkIlxKHF0bB5a60Dt2s1ix3YfgyMdVoj2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766747431; c=relaxed/simple;
	bh=TZBm7xraSyzbd3zPTXLuxxnIVTOSK7rzIf/fTMWuvKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dErUrEBjKQDe84NuQ+NvV9o9WBmCbkFPkUUavBz4MNFPmFOyTKpAmvfVqtgo0V03+neH2Kyd0Xvc3Is6BFLIDn2UHFcOBqH5qlQddlC1M/w7ZMxdAScOae4SaYt/jF2Hm3THmiBFIqjiCyyTLHcwLvCOsUHEqB0IM9y6TZtDk/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SzTt57Xo; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PN/lkGsa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766747428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hxxe+0EjF9NUofDY+U4LnGwysYHjaMOQnhMUAVNbt4s=;
	b=SzTt57XoTAQ41oKuNcrMgedNqpXjaoDtdSg2uXb/3eK/5Miqe+tc5ex11mm+633O2hwEp8
	9EG45a8XeeGhE6UrRuwf/nf7F+kH893Sw5LS79Uz6TuIMoR26XlFgNRxsy0ti1KzuL0nom
	Qg8+OAjkA1LGbCjVPFWhdvPB43DCQXU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-LUWSLXEHMyiOZHcDDe9zEA-1; Fri, 26 Dec 2025 06:10:27 -0500
X-MC-Unique: LUWSLXEHMyiOZHcDDe9zEA-1
X-Mimecast-MFC-AGG-ID: LUWSLXEHMyiOZHcDDe9zEA_1766747426
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4779b3749a8so50831485e9.1
        for <linux-pm@vger.kernel.org>; Fri, 26 Dec 2025 03:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766747426; x=1767352226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hxxe+0EjF9NUofDY+U4LnGwysYHjaMOQnhMUAVNbt4s=;
        b=PN/lkGsaiwnoL0MOc6s29768g3GoOmcAhxBDj2HzgYB2tBBE0+he70PypnnJX3oJ/c
         PKZfmaEppk0Jzeo+3Yns5yDNxen3WRWnzcK5OZ4qZaog2D03WjuAUn0wg51YrrR1uDzL
         brlSBB6wyKVz1hwDFe0pm1yKo4qh8ZbFfH6RgqdbvWy5wQ4JJnoBrlxwtnfogSnPJUoV
         GRGDDoMijCAzU2V1yWhCM2zG6tO3NTLeQaSv5Oj+neBAk8Md6/KtN+Q01fn3MpILwNU1
         I+QugsB2H8TEtVp5gAjpp/+oGdCIEE7LOQLbYFSI+5YOM6uRFm8gBfu7efjezhXJvtZo
         8nAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766747426; x=1767352226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hxxe+0EjF9NUofDY+U4LnGwysYHjaMOQnhMUAVNbt4s=;
        b=RmNf1/oPEmN+38sWy/Pd2Ag6SyWJ/dPf2FEJkEabFOnrkK4NRHRr1uNPNBLo6AiBlB
         OPNW+IIFZRfW4o6Insjce0fD7WJeLITSqltwOQLFlcIhZl2OrOwX4vTYHgPsdUjLFuKX
         cFtC+IJagQlAcQSLwvhaz8O0gq1AGh5mB3C0dg3besYXCQZaxl3OlqZ5fAO0C7x0Y9aL
         XsNkbZS4vAsiRZxNVMVOyoNTto/LGqe6aRZLA8X6JKMeYgC44EKUZ0WMVwzGMCtMuTds
         MFwy4/Ch7uvo6XG2Pw8CUfKBJwCH+8OYwpQC+nQsQxaWHLfCR6j4iQS8K2nrmUoZ+NnZ
         Ww/A==
X-Forwarded-Encrypted: i=1; AJvYcCXknMB4mlA2hpe7PkjjQgPBUZ+nn/HbuK1fRLQ+W7MbSHAYy8PN/XFq0GciFCjQaznw2icfZPvosQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwpnsHP6Pg7QuREmjlKj63l3EJPWbVsf9gKnwCndDnySN6z/bPh
	DTN+CMKJSJU5BKJlkw5Y84gLD5Ag260/Y+V7EJ3JfWlemQaoPSlHMrpyLCTygbPjLem8KpkPWcr
	vVrvByqCTYufYpuL3IwbIYUQc/QqfIKuvHlr4+6790/YwqDBt013T0L0hb+1G
X-Gm-Gg: AY/fxX6O3F74Ipw5jRgnI2GegJA1mQd98bP4LRurj7bffvKxFSPeANloZpiE5u0CY3V
	Ifphc45PsHPB40mpqmAziFSIF2tS2DVS/bGKGiNOjjHD+RgDRX9fMKRUo6xPThmuceFQNzRRsKe
	yTIyAnlvubRQ1nyl4/ixhVOTQVwUaBqUhq2hYX9y2pLeyytwxNEjwgV1NUBY3I/vmuHq6klgmLE
	fbetRTZ4hOBYaJsjOxxIbDv7lcPadp/t0caJrA0Z3PJtkFtbL2dsSgC2n0Pren98PKZpasdBt8h
	GtoipiDL+idcqwUZk2UqeHcdBqNJwyXUoXAQIlaF21eHe319RbUw4MnKYJYgyfp050bGzClH2Qn
	gNghrAvDW4WgOuDIZaH040xoEgKCn4Dcst7dZIOQ7ruNknaxf38eFj+kMqtIajDtzUwv2GjhUAR
	kAbXihcHnmzw==
X-Received: by 2002:a05:600c:310c:b0:46e:32dd:1b1a with SMTP id 5b1f17b1804b1-47d1953b941mr192007355e9.7.1766747426184;
        Fri, 26 Dec 2025 03:10:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHrAJY07FPV6QeiBb5VL/M5EhPut9Jv/p09K9isCNRbjpx9PlU/IWIEkXo0YNR2MTtFi2aaLQ==
X-Received: by 2002:a05:600c:310c:b0:46e:32dd:1b1a with SMTP id 5b1f17b1804b1-47d1953b941mr192007135e9.7.1766747425712;
        Fri, 26 Dec 2025 03:10:25 -0800 (PST)
Received: from sissix.lzampier.com ([2a06:5900:814a:ab00:3725:2991:6cf3:b3aa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d193d4e91sm375653855e9.13.2025.12.26.03.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Dec 2025 03:10:25 -0800 (PST)
From: Lucas Zampieri <lzampier@redhat.com>
To: linux-input@vger.kernel.org
Cc: Lucas Zampieri <lzampier@redhat.com>,
	linux-kernel@vger.kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Bastien Nocera <hadess@hadess.net>,
	linux-pm@vger.kernel.org,
	lcasmz54@gmail.com
Subject: [PATCH v6 1/3] HID: input: Convert battery code to devm_*
Date: Fri, 26 Dec 2025 11:10:14 +0000
Message-ID: <20251226111019.31243-2-lzampier@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251226111019.31243-1-lzampier@redhat.com>
References: <20251226111019.31243-1-lzampier@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the HID battery code to use devm_* managed resource APIs for
the power_supply_desc allocation, battery name string, and power supply
registration.

The error path uses devm_kfree() to clean up allocated memory if
devm_power_supply_register() fails, preventing memory waste on repeated
setup attempts. The hidinput_cleanup_battery() function is removed as
devm handles cleanup automatically.

Signed-off-by: Lucas Zampieri <lzampier@redhat.com>
---
 drivers/hid/hid-input.c | 34 +++++++---------------------------
 1 file changed, 7 insertions(+), 27 deletions(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index e56e7de53279..71862beede9e 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -530,13 +530,13 @@ static int hidinput_setup_battery(struct hid_device *dev, unsigned report_type,
 	if (quirks & HID_BATTERY_QUIRK_IGNORE)
 		return 0;
 
-	psy_desc = kzalloc(sizeof(*psy_desc), GFP_KERNEL);
+	psy_desc = devm_kzalloc(&dev->dev, sizeof(*psy_desc), GFP_KERNEL);
 	if (!psy_desc)
 		return -ENOMEM;
 
-	psy_desc->name = kasprintf(GFP_KERNEL, "hid-%s-battery",
-				   strlen(dev->uniq) ?
-					dev->uniq : dev_name(&dev->dev));
+	psy_desc->name = devm_kasprintf(&dev->dev, GFP_KERNEL, "hid-%s-battery",
+					strlen(dev->uniq) ?
+						dev->uniq : dev_name(&dev->dev));
 	if (!psy_desc->name) {
 		error = -ENOMEM;
 		goto err_free_mem;
@@ -576,7 +576,7 @@ static int hidinput_setup_battery(struct hid_device *dev, unsigned report_type,
 	if (quirks & HID_BATTERY_QUIRK_AVOID_QUERY)
 		dev->battery_avoid_query = true;
 
-	dev->battery = power_supply_register(&dev->dev, psy_desc, &psy_cfg);
+	dev->battery = devm_power_supply_register(&dev->dev, psy_desc, &psy_cfg);
 	if (IS_ERR(dev->battery)) {
 		error = PTR_ERR(dev->battery);
 		hid_warn(dev, "can't register power supply: %d\n", error);
@@ -587,27 +587,13 @@ static int hidinput_setup_battery(struct hid_device *dev, unsigned report_type,
 	return 0;
 
 err_free_name:
-	kfree(psy_desc->name);
+	devm_kfree(&dev->dev, psy_desc->name);
 err_free_mem:
-	kfree(psy_desc);
+	devm_kfree(&dev->dev, psy_desc);
 	dev->battery = NULL;
 	return error;
 }
 
-static void hidinput_cleanup_battery(struct hid_device *dev)
-{
-	const struct power_supply_desc *psy_desc;
-
-	if (!dev->battery)
-		return;
-
-	psy_desc = dev->battery->desc;
-	power_supply_unregister(dev->battery);
-	kfree(psy_desc->name);
-	kfree(psy_desc);
-	dev->battery = NULL;
-}
-
 static bool hidinput_update_battery_charge_status(struct hid_device *dev,
 						  unsigned int usage, int value)
 {
@@ -660,10 +646,6 @@ static int hidinput_setup_battery(struct hid_device *dev, unsigned report_type,
 	return 0;
 }
 
-static void hidinput_cleanup_battery(struct hid_device *dev)
-{
-}
-
 static void hidinput_update_battery(struct hid_device *dev, unsigned int usage,
 				    int value)
 {
@@ -2379,8 +2361,6 @@ void hidinput_disconnect(struct hid_device *hid)
 {
 	struct hid_input *hidinput, *next;
 
-	hidinput_cleanup_battery(hid);
-
 	list_for_each_entry_safe(hidinput, next, &hid->inputs, list) {
 		list_del(&hidinput->list);
 		if (hidinput->registered)
-- 
2.52.0


