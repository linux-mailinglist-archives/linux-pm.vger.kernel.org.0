Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97CF21400F8
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2020 01:31:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730433AbgAQAb5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Jan 2020 19:31:57 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34351 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730193AbgAQAb5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Jan 2020 19:31:57 -0500
Received: by mail-pg1-f196.google.com with SMTP id r11so10781279pgf.1
        for <linux-pm@vger.kernel.org>; Thu, 16 Jan 2020 16:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QzTHBo5IXQ98fAgDDnwmqt+aQIhM0Rq/3jjYFgU3Syk=;
        b=Ja9LYSL/lvo4ov1/EHda0AWB3Bc7ncMWi834t8jOprxtKEZHXBfFgJkxq2Nc58js3P
         Hqs0sag5SJCNokzEGSyGdtld/G8TbD90gIQKsUku4mUTefxBiUJnng1Oaw2CMLethqaK
         FsNY1Ga89ekD+Lx7c9J+HdkWsUBIb/305FdBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QzTHBo5IXQ98fAgDDnwmqt+aQIhM0Rq/3jjYFgU3Syk=;
        b=RKMhR1a5KGRsLdvnGyN4PLXN1wp5py4l6SCej2dTdeO5euAChQa3eR3RMsP3Utj1Sp
         QewdNgJd7xRkf+zJTfsMlZgF0AfLlKCT2JyJtLqGIq9Rh6hK3r6TM+uhAN4imuovyddf
         f0nuRxWLokim9hg5wuwwkN55twkBW7jCVVuAR+MUUZm+wrubCaXflBMtAVlgyt+tPW/M
         iFr84Dhx+7R1gkrLsTC/SZHgVyQD437SPBqE/XHePMe13ESsIJTim9x7ZbyjKQvYOL1f
         kwx9fhPqiR0UiBOEbANW9fQLheFAo4rFmiTeIJj71bA83mRjNqV1n2lmmC17QhvXNBRP
         fTRA==
X-Gm-Message-State: APjAAAXQPpDyboUZo+ILTwJ2uTrdNUx6zO94g78cOjqAx5KGS+Hg4xs8
        eBm0a30lyyoyS4L/YMeurUW9/w==
X-Google-Smtp-Source: APXvYqwJ2ipzvyvR9BF94b7DerbcSYdnPNFjzXl19efACdIE1xkErUGEgozVoWEmt8GVTG4tBC/GZQ==
X-Received: by 2002:a65:484d:: with SMTP id i13mr42683635pgs.32.1579221116692;
        Thu, 16 Jan 2020 16:31:56 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:172e:4646:c089:ce59])
        by smtp.gmail.com with ESMTPSA id c188sm667420pga.83.2020.01.16.16.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 16:31:56 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     enric.balletbo@collabora.com, groeck@chromium.org,
        bleung@chromium.org, lee.jones@linaro.org, sre@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Prashant Malani <pmalani@chromium.org>
Subject: [PATCH v7 2/3] mfd: cros_ec: Add cros-usbpd-notify subdevice
Date:   Thu, 16 Jan 2020 16:28:22 -0800
Message-Id: <20200117002820.56872-2-pmalani@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200117002820.56872-1-pmalani@chromium.org>
References: <20200117002820.56872-1-pmalani@chromium.org>
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

Reviewed-by: Benson Leung <bleung@chromium.org>
Signed-off-by: Prashant Malani <pmalani@chromium.org>
---

Changes in v7:
- No changes.

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

