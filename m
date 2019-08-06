Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32FEB8297D
	for <lists+linux-pm@lfdr.de>; Tue,  6 Aug 2019 04:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730717AbfHFCCl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Aug 2019 22:02:41 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38536 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730900AbfHFCCl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Aug 2019 22:02:41 -0400
Received: by mail-pl1-f196.google.com with SMTP id az7so37146652plb.5
        for <linux-pm@vger.kernel.org>; Mon, 05 Aug 2019 19:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2A7aCPKk6mS2mwCaQ9tN7cyd1W6l/kKs9HodzX2zX+c=;
        b=Zje3tE621Ojg3sGbzZrUpatf2ua/2akje8upEj8kKZWg0yRl3VrTL3XDKBy48T6kgb
         syUgZjdPajj51AUmC2L6oASScdItCbsm8dJaHU+sosmP1n0gkRNuSFtdvsZP2mPfvHy6
         FpAJEnQYFkqNsB9LXhAkXF4+6tt9HsueDowefp8c0HHcoETzb3o/e58K/QIISJSmPCGo
         JzwNZhUjEVkNSowviGFC4RlMhdqZuVmq7F17oQiqpnsyMPBxuiEhEFxVOyezISUuD11B
         Shqe5YXQ2z6FcHSK4bWcdPPDP9mEcIvCKLWUzY7pCm0oLnjiwezQmVvWRLfBCJ8ckeCo
         7XNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2A7aCPKk6mS2mwCaQ9tN7cyd1W6l/kKs9HodzX2zX+c=;
        b=QYEcD260tImCsWyaNLfTcR21BD2MChIYCFX/Il+WZpzPvQH+7N+64hvEAAC/lileae
         N8GaUzg7b/jGPNTVafW62HdItVEY/B/GFosnAArbiGbKbEOvCa+/xyAiNS5jhpmQOkrz
         ORs8NkcDngzQ2y+rCWYOh4G9KZ3zGnuN+0PcccJmMhMoB2JZ4BM13BFOLQ/ORm3c328h
         Vb4EnOTk2OTdbHoqBpToVGwz5cW7zxmV7PUMWtFXp3yUDnVAn483u3+6XIg0O5L3fOAO
         FpFZVDaX6MRxooWmBpAWrnef5BfNJf2/d6WtYQfhz5dKCTEgvu9eQtbddCiGznXr+5f0
         rA7Q==
X-Gm-Message-State: APjAAAVFNMs1xbLmfWEbsKHXaXZLpyNXdSXy+6UgUWU21ArP8iptaJ+q
        0MX4YJFkt697H8V1BoG79uA=
X-Google-Smtp-Source: APXvYqx5vj0ONpo35uPfYPZnnEtIY6YO0l00JSfJ2btje1iBW222+PbtLfu42MMvD7otbksXyC65YQ==
X-Received: by 2002:a17:902:724a:: with SMTP id c10mr660845pll.298.1565056960328;
        Mon, 05 Aug 2019 19:02:40 -0700 (PDT)
Received: from huyue2.ccdomain.com ([218.189.10.173])
        by smtp.gmail.com with ESMTPSA id a6sm85573694pfa.162.2019.08.05.19.02.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 19:02:39 -0700 (PDT)
From:   Yue Hu <zbestahu@gmail.com>
To:     rui.zhang@intel.com, edubezval@gmail.com, daniel.lezcano@linaro.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-pm@vger.kernel.org, huyue2@yulong.com
Subject: [PATCH RESEND] thermal/drivers/core: Use put_device() if device_register() fails
Date:   Tue,  6 Aug 2019 10:02:21 +0800
Message-Id: <20190806020221.8504-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.17.1.windows.2
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Yue Hu <huyue2@yulong.com>

Never directly free @dev after calling device_register(), even if it
returned an error! Always use put_device() to give up the reference
initialized.

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
 drivers/thermal/thermal_core.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 6bab66e..ffe5d8e 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -985,7 +985,7 @@ static void bind_cdev(struct thermal_cooling_device *cdev)
 	result = device_register(&cdev->device);
 	if (result) {
 		ida_simple_remove(&thermal_cdev_ida, cdev->id);
-		kfree(cdev);
+		put_device(&cdev->device);
 		return ERR_PTR(result);
 	}
 
@@ -1292,7 +1292,7 @@ struct thermal_zone_device *
 	dev_set_name(&tz->device, "thermal_zone%d", tz->id);
 	result = device_register(&tz->device);
 	if (result)
-		goto remove_device_groups;
+		goto release_device;
 
 	for (count = 0; count < trips; count++) {
 		if (tz->ops->get_trip_type(tz, count, &trip_type))
@@ -1347,8 +1347,11 @@ struct thermal_zone_device *
 	device_unregister(&tz->device);
 	return ERR_PTR(result);
 
-remove_device_groups:
-	thermal_zone_destroy_device_groups(tz);
+release_device:
+	ida_simple_remove(&thermal_tz_ida, tz->id);
+	put_device(&tz->device);
+	return ERR_PTR(result);
+
 remove_id:
 	ida_simple_remove(&thermal_tz_ida, tz->id);
 free_tz:
-- 
1.9.1

