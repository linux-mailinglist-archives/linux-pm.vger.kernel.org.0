Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1A11491F9
	for <lists+linux-pm@lfdr.de>; Sat, 25 Jan 2020 00:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729353AbgAXXYp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Jan 2020 18:24:45 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:39534 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729299AbgAXXYp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Jan 2020 18:24:45 -0500
Received: by mail-pj1-f66.google.com with SMTP id e11so495882pjt.4
        for <linux-pm@vger.kernel.org>; Fri, 24 Jan 2020 15:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WzqWvK5o+ybR/i3ON58T7OBtUXSoGrpaLS3XPpmmh0A=;
        b=oAxRHSpko6+wbCZ+XPcsBwlhuXzprapRJ6ZcGOKxys0g1A1XFkMUzICXYjOw0u8Clc
         beS9cyE9tFJ3aIpjvNjFsWSqrWIRMKb4SnQJOJxujHrG9aKGH9fTSb9N6RFx+HqqD3/3
         uZ3yU+hdm7BcFpK0QoABL0UJAWC3DCu02w3Ws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WzqWvK5o+ybR/i3ON58T7OBtUXSoGrpaLS3XPpmmh0A=;
        b=m/27tTT9zxgFnzz75hv5jt0SYdNSPc9R4Jwm51eZAXQqCafrPKrnn9eRxPYMyYM53E
         /9AM3Ha5NSC6AsvDRh0VL0DLDgJ9CJAx2p4XzMdUERTD2em2sOF9d/xKBEIk/S5o6tX/
         0fCSsU+OWSwHQOvT9UOCVcerSB2c2RXtEu65imQz1eoah4TKdVskM1X0nkAQnJH8u9Gz
         Dq8+8qR+nLLtKxuNA2q9Z662Vcm3HMuv6v1rRpwkK3d8PQDuTxIBTd+kke/Zm3e80TG9
         boNnX+QpyPAfoG1csHLwBD4iz7MtBrdH8tOQ2myJ6a3jOyIrO0QDdV4kDsS+Upe7uNGU
         yD5w==
X-Gm-Message-State: APjAAAVAesShMfaiUKq+xEcS8L1Lr81kUMQZtdw71ML6nQLPnRbdsDQA
        64ky0zl1tCROXODmKO46F6F6dA==
X-Google-Smtp-Source: APXvYqzX4PEk08eSMfSGJt0meMlg10gfZoj4miTS8teTEZnQBYUzKZjvd5YAiAgw3Jbjl0s3IXokRg==
X-Received: by 2002:a17:902:ba86:: with SMTP id k6mr5847880pls.96.1579908284673;
        Fri, 24 Jan 2020 15:24:44 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:172e:4646:c089:ce59])
        by smtp.gmail.com with ESMTPSA id b12sm2823103pfr.26.2020.01.24.15.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 15:24:44 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     enric.balletbo@collabora.com, groeck@chromium.org,
        bleung@chromium.org, lee.jones@linaro.org, sre@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Prashant Malani <pmalani@chromium.org>
Subject: [PATCH v8 2/4] mfd: cros_ec: Add cros-usbpd-notify subdevice
Date:   Fri, 24 Jan 2020 15:18:34 -0800
Message-Id: <20200124231834.63628-2-pmalani@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200124231834.63628-1-pmalani@chromium.org>
References: <20200124231834.63628-1-pmalani@chromium.org>
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

Changes in v8:
- No changes. Patch v6 was applied, but maintaining it in this series,
  since Patch 3/4 adds a change to the if condition.

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

