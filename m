Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E964913B5C1
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2020 00:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbgANX0x (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jan 2020 18:26:53 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:56183 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728769AbgANX0w (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jan 2020 18:26:52 -0500
Received: by mail-pj1-f67.google.com with SMTP id d5so6422625pjz.5
        for <linux-pm@vger.kernel.org>; Tue, 14 Jan 2020 15:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bcAzatl2XyyclHkai7dGbcQh/coSPP8i6YfbwNZKXZI=;
        b=U3kW736i5BiRCs3wXG7322fILUUKjZ0VBpecdN2VVG5K66VGIzz7C6L73yKZ1QFKIW
         yO95EnjRHdB0WJX/m8H+XcmCteeKaCXTVtUNDUslo2h043ib/JOJ9Vl3aIluwggeHW9M
         bYvnCDfgFatB4/cioa4hbpxs1i0nCajMbUMwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bcAzatl2XyyclHkai7dGbcQh/coSPP8i6YfbwNZKXZI=;
        b=cfRl28MQUHuHRshYLXYKrQxMfNqbWscx3EnvN2HasDUyHNHslbrle/bazQygdgC2/i
         cHoyLQUR/t3sOMUpQFH8/xqmxbZp5p9w6o9vM6KiP4Npb/JMmQQqPqyasZVsktTLQe8O
         g1uotzHKsWkgRXz0UyPFyO4oPk8iZic+ALzCKVGaqtYFjarCw4oE8YDCp0kXdJcUKPL5
         3cMCCz/gd5S/hhjYxrdV94FUFo6pIl9YtX8N6GEoPD2K2aeJsMq6gevHPvBBHn3xCKPV
         eJzUqBmj3/xwCTUM+gTCYunSQvah4SpM5ig2xD/sK00DUmiGLRV9lQpyX90W8m0pJWi+
         WcpA==
X-Gm-Message-State: APjAAAX730RPu9Q5GbQn3fWuyu3qJ14XxH+E0o340PTUxqrD/Lg83oTV
        IgWijOLdtk2jO+qCdcj+l54mmA==
X-Google-Smtp-Source: APXvYqxxu5svCpLIT7uLcBTW0aE7vWVXUxbwo1xa30xeAzfWfXn8RDA+yOAnWp/xxemdVrK8BsO5rw==
X-Received: by 2002:a17:90a:d801:: with SMTP id a1mr32423893pjv.34.1579044411798;
        Tue, 14 Jan 2020 15:26:51 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:172e:4646:c089:ce59])
        by smtp.gmail.com with ESMTPSA id u18sm18521839pgn.9.2020.01.14.15.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 15:26:51 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     enric.balletbo@collabora.com, groeck@chromium.org,
        bleung@chromium.org, lee.jones@linaro.org, sre@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Prashant Malani <pmalani@chromium.org>
Subject: [PATCH v6 2/3] mfd: cros_ec: Add cros-usbpd-notify subdevice
Date:   Tue, 14 Jan 2020 15:22:20 -0800
Message-Id: <20200114232219.93171-2-pmalani@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200114232219.93171-1-pmalani@chromium.org>
References: <20200114232219.93171-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add the cros-usbpd-notify driver as a subdevice on platforms that
support the EC_FEATURE_USB_PD EC feature flag and don't have the
ACPI PD notification device defined.

This driver allows other cros-ec devices to receive PD event
notifications from the Chrome OS Embedded Controller (EC) via a
notification chain.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---

Changes in v6:
- No changes.

Changes in v5:
- Updated the IS_ENABLED() check to check for CONFIG_OF instead of
  !CONFIG_ACPI according to upstream comments.

Changes in v4:
- Removed #ifndef usage; instead, moved cros-usbpd-notify to a separate
  mfd_cell and used an IS_ENABLED() check.
- Changed commit title and description slightly to reflect change in
  code.
 drivers/mfd/cros_ec_dev.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index c4b977a5dd966..d0c28a4c10ad0 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2014 Google, Inc.
  */
 
+#include <linux/kconfig.h>
 #include <linux/mfd/core.h>
 #include <linux/mfd/cros_ec.h>
 #include <linux/module.h>
@@ -87,6 +88,10 @@ static const struct mfd_cell cros_usbpd_charger_cells[] = {
 	{ .name = "cros-usbpd-logger", },
 };
 
+static const struct mfd_cell cros_usbpd_notify_cells[] = {
+	{ .name = "cros-usbpd-notify", },
+};
+
 static const struct cros_feature_to_cells cros_subdevices[] = {
 	{
 		.id		= EC_FEATURE_CEC,
@@ -202,6 +207,23 @@ static int ec_device_probe(struct platform_device *pdev)
 		}
 	}
 
+	/*
+	 * The PD notifier driver cell is separate since it only needs to be
+	 * explicitly added on platforms that don't have the PD notifier ACPI
+	 * device entry defined.
+	 */
+	if (IS_ENABLED(CONFIG_OF)) {
+		if (cros_ec_check_features(ec, EC_FEATURE_USB_PD)) {
+			retval = mfd_add_hotplug_devices(ec->dev,
+					cros_usbpd_notify_cells,
+					ARRAY_SIZE(cros_usbpd_notify_cells));
+			if (retval)
+				dev_err(ec->dev,
+					"failed to add PD notify devices: %d\n",
+					retval);
+		}
+	}
+
 	/*
 	 * The following subdevices cannot be detected by sending the
 	 * EC_FEATURE_GET_CMD to the Embedded Controller device.
-- 
2.25.0.341.g760bfbb309-goog

