Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 898D71491FC
	for <lists+linux-pm@lfdr.de>; Sat, 25 Jan 2020 00:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387447AbgAXXZY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Jan 2020 18:25:24 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:34934 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387449AbgAXXZY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Jan 2020 18:25:24 -0500
Received: by mail-pj1-f68.google.com with SMTP id q39so510582pjc.0
        for <linux-pm@vger.kernel.org>; Fri, 24 Jan 2020 15:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FARh9+NSyoh9cEVojaQ5yO/5qNpny8hvAgXD5nEC67I=;
        b=H06xmx89YXaZ0rcfRMS2TzEW37mYI8VF98nq0ZMSaYi3lu8uAeqHa9gZSfOnFRnKYm
         qoFdh8VmrW/jYfFXK8gbQ2XlEKnW0TJ3P54II9lv3xnVRSLXaGayP+I8D1beKJxMK8bs
         oKHBzJRcMOmv12M0LXdfYDDpetCcuhWsZ6r5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FARh9+NSyoh9cEVojaQ5yO/5qNpny8hvAgXD5nEC67I=;
        b=Da01SoC2dciWO9pgzy1Ne/oxg1ijWHE9Y8AWMftiM56h1iHFE2oJZ0DFkqdprJUB2g
         jPQfuKfcoD06VGm07eyQ38TYubmcLyeOFf0p5N7tdexE1KTWTKdsrlypm/rrdDJAu/I7
         xLEqkk2A9I7Ssoab/QjmPAbBaZuZle9G3nl29t7UWqjup4d6M+x2L7crtakacOL08QZE
         kVw8I3KYNBJiwK8l5Vq79K97Dw0zn8GNv1jmHM3Zvoh4vVxxjV+8whc2+20Dw4Tr/C5p
         o+pkbaR6WY/29g/YCZPcrtTdWqnuvxu6tsUfNTe2z5VVoNS2s+VtINDs1nh/F5ZrybcC
         6xVA==
X-Gm-Message-State: APjAAAVYYwF/6TG88N0P10FYYwl+zzn5SxanxvAS8OoTaVEpLnviXQ9X
        ScKdzCFBTq6n+pubYdvPYaNTbQ==
X-Google-Smtp-Source: APXvYqyHd5FT8CvoOI9/vPxv4sxwo5PHmJDSN6SkVVSjaI1OtaJ7MDk1gnotjCGKLpyZEXEYrUGOcA==
X-Received: by 2002:a17:90a:9c1:: with SMTP id 59mr1846965pjo.65.1579908323338;
        Fri, 24 Jan 2020 15:25:23 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:172e:4646:c089:ce59])
        by smtp.gmail.com with ESMTPSA id b12sm2823103pfr.26.2020.01.24.15.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 15:25:22 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     enric.balletbo@collabora.com, groeck@chromium.org,
        bleung@chromium.org, lee.jones@linaro.org, sre@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Prashant Malani <pmalani@chromium.org>
Subject: [PATCH v8 3/4] mfd: cros_ec: Check DT node for usbpd-notify add
Date:   Fri, 24 Jan 2020 15:18:36 -0800
Message-Id: <20200124231834.63628-3-pmalani@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200124231834.63628-1-pmalani@chromium.org>
References: <20200124231834.63628-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add a check to ensure there is indeed an EC device tree entry before
adding the cros-usbpd-notify device. This covers configs where both
CONFIG_ACPI and CONFIG_OF are defined, but the EC device is defined
using device tree and not in ACPI.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---

Changes in v8:
- Patch first introduced in v8 of the series.

 drivers/mfd/cros_ec_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index d0c28a4c10ad0..411e80fc9a066 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -212,7 +212,7 @@ static int ec_device_probe(struct platform_device *pdev)
 	 * explicitly added on platforms that don't have the PD notifier ACPI
 	 * device entry defined.
 	 */
-	if (IS_ENABLED(CONFIG_OF)) {
+	if (IS_ENABLED(CONFIG_OF) && ec->ec_dev->dev->of_node) {
 		if (cros_ec_check_features(ec, EC_FEATURE_USB_PD)) {
 			retval = mfd_add_hotplug_devices(ec->dev,
 					cros_usbpd_notify_cells,
-- 
2.25.0.341.g760bfbb309-goog

