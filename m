Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9965BDC6
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jul 2019 16:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbfGAONM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Jul 2019 10:13:12 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45636 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfGAONM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Jul 2019 10:13:12 -0400
Received: by mail-pl1-f194.google.com with SMTP id bi6so7426399plb.12;
        Mon, 01 Jul 2019 07:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Np8t2ahuf6PSMMAtQnfPXPhzxV6M5y5kKeRAo/FYD1c=;
        b=KgcTHsMFOwmh3UnuXrsJF1EA2VSVVmNtZLBxlMR8hyWdERYGMcLjbinOPhZkaJPI/1
         v0Rgz9Zm0FYAbCn/iyTDWCzkbf1cKwuCHNiFD0FZ4hfyyIPEU7cQ7RVh/m6Nvn1sfQzC
         +ji8X3mFWZBXgrDnRHWSNIPlUPaoRxsuN/ZLEjw8YzrwxLW5bnWTjCb4IkjdyHBIAcJ0
         pZAGFkK0Bnza/lkcDKg7dq/5YkD3rBvxqKu4PbZG0sZBApv6PPIFKLAIJKbZBfAC368y
         qYZnC7LsA0vwefjKRN6LaBZ0JDEuL7GGzdOX6ET2ufoxB5CKqmm94Xk7RZwz3jg6SMnW
         iP1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Np8t2ahuf6PSMMAtQnfPXPhzxV6M5y5kKeRAo/FYD1c=;
        b=a/hM1oXNfX8iv3+NF3QHDjaHw/msDt/MOhR7/YpC6GbvfOnAifeUCiMaors173TyWj
         kJTuYC8DaJr/AN05WLe6XlwQqLbHa75ZHJ4bYIJpoQgIAHjM9haGUiSmhLa8i8tEhH16
         pYDXW+AvJICww4T6t0of8EUEavGtf0aQUIViYbEl+l88d4NXwq5FCZRIGhnUKs7svQYn
         2TfJbAESKCTGx8E2CMNXBazUBFpaI9pIMRmdPF/d98zXAjSHZx5GAR0d0bDSqmb9F6XZ
         mH1I4jmntbA5s9owSNInYbDlUenEyouVL513kF3HJ2IYMOmoDEsU49uYoYQWPtu1RYEt
         kOUw==
X-Gm-Message-State: APjAAAVS4C1RokD1PYgdxznJaC3A7zt8zhqWmieqnpUrpaNzzMik5P8I
        W5CH9h+eL58CljYRktf4GDo=
X-Google-Smtp-Source: APXvYqxR8ijDX+vYdEqlei8m9p262FyDtdBtj0wEjAJ3RyOplcr2PCl47Dwcp3UQ42+H9ufLUaELfw==
X-Received: by 2002:a17:902:112c:: with SMTP id d41mr28901493pla.33.1561990391753;
        Mon, 01 Jul 2019 07:13:11 -0700 (PDT)
Received: from mita-MS-7A45.lan ([240f:34:212d:1:368e:e048:68f1:84e7])
        by smtp.gmail.com with ESMTPSA id n19sm11383871pfa.11.2019.07.01.07.13.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 01 Jul 2019 07:13:11 -0700 (PDT)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     linux-nvme@lists.infradead.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Rob Herring <robh@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Kenneth Heitke <kenneth.heitke@intel.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH v5 3/4] nvme: support DT thermal zone device
Date:   Mon,  1 Jul 2019 23:12:33 +0900
Message-Id: <1561990354-4084-4-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1561990354-4084-1-git-send-email-akinobu.mita@gmail.com>
References: <1561990354-4084-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In addition to the standard thermal zone device, this adds support for
registering the DT thermal zone device.

If there is a device tree thermal zone node with the nvme temperature
sensor, the standard thermal zone device is not created.
Because we don't need two thermal zone devices for the same sensor.

Cc: Rob Herring <robh@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Minwoo Im <minwoo.im.dev@gmail.com>
Cc: Kenneth Heitke <kenneth.heitke@intel.com>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
* v5
- split the DT thermal zone support into separate patch
- don't register both standard and DT thermal zone

 drivers/nvme/host/nvme.h    |  1 +
 drivers/nvme/host/thermal.c | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 49dd59ec..d501567 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -159,6 +159,7 @@ struct nvme_fault_inject {
 struct nvme_tz {
 	struct thermal_zone_params params;
 	struct thermal_zone_device *dev;
+	struct thermal_zone_device *of_dev;
 	unsigned int sensor;
 };
 
diff --git a/drivers/nvme/host/thermal.c b/drivers/nvme/host/thermal.c
index c3608f6..431aeb4 100644
--- a/drivers/nvme/host/thermal.c
+++ b/drivers/nvme/host/thermal.c
@@ -150,6 +150,11 @@ static struct thermal_zone_device_ops nvme_tz_ops = {
 	.set_trip_temp = nvme_tz_set_trip_temp,
 };
 
+static struct thermal_zone_of_device_ops nvme_tz_of_ops = {
+	.get_temp = nvme_tz_of_get_temp,
+	.set_trip_temp = nvme_tz_of_set_trip_temp,
+};
+
 static const struct thermal_zone_params nvme_tz_params = {
 	.governor_name = "user_space",
 	.no_hwmon = true,
@@ -164,6 +169,36 @@ static int nvme_thermal_zone_register(struct nvme_ctrl *ctrl,
 	int ret;
 
 	tz->sensor = sensor;
+
+	tzdev = thermal_zone_of_sensor_register(ctrl->dev, sensor, tz,
+						&nvme_tz_of_ops);
+	if (!IS_ERR(tzdev)) {
+		int trip_temp;
+
+		ret = tzdev->ops->get_trip_temp(tzdev, 0, &trip_temp);
+		if (ret) {
+			dev_err(ctrl->device,
+				"Failed to get trip temp: %d\n", ret);
+			return ret;
+		}
+
+		ret = tzdev->ops->set_trip_temp(tzdev, 0, trip_temp);
+		if (ret) {
+			dev_err(ctrl->device,
+				"Failed to set trip temp: %d\n", ret);
+			return ret;
+		}
+
+		tz->of_dev = tzdev;
+
+		return 0;
+	}
+
+	if (PTR_ERR(tzdev) != -ENODEV)
+		dev_warn(ctrl->device,
+			 "Failed to register thermal zone of sensor %d: %ld\n",
+			 sensor, PTR_ERR(tzdev));
+
 	tz->params = nvme_tz_params;
 	snprintf(name, sizeof(name), "nvme%d_temp%u", ctrl->instance, sensor);
 
@@ -286,6 +321,9 @@ void nvme_thermal_zones_unregister(struct nvme_ctrl *ctrl)
 			tz->dev = NULL;
 		}
 
+		thermal_zone_of_sensor_unregister(ctrl->dev, tz->of_dev);
+		tz->of_dev = NULL;
+
 		__clear_bit(i, ctrl->tz_enabled);
 	}
 }
-- 
2.7.4

