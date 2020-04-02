Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE72119C3E9
	for <lists+linux-pm@lfdr.de>; Thu,  2 Apr 2020 16:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgDBOXp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Apr 2020 10:23:45 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45796 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731780AbgDBOXo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Apr 2020 10:23:44 -0400
Received: by mail-wr1-f68.google.com with SMTP id t7so4395202wrw.12
        for <linux-pm@vger.kernel.org>; Thu, 02 Apr 2020 07:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ji2Ku2ZH1WW9DKlxO4woetZ//ek7SsL6L8u0hVrXXuo=;
        b=uDxWJD1+e5A+13EgYs9zhFRoYydcLXaG9+KU75+MWWlTqI/smjoP8BYlAcotejfyLg
         wtu7NIoEdkzyc6NZYnBRh1jdwMrJFY04p2j/Oo4NM+dgGJ2pSmjMHrOJNSlvpzuPJDak
         UTwnemuXW8W12yCSX0lnqA90fG7Ri0s57uj00YNP9sBIuL63RdA4el0mAefXD6SPaz2S
         iCDJhAY7Ooe3dTi4iN075ckoXBXNnRpQfM11lJ9LuSR3waxPVFUyCQnAoxTrfNagPd+1
         qOWUqGblOYUR8cjCy0YPAMJXUYvon7R2k0nYF98htJNYMgclA7sMResIH74b8s6zqSZA
         nvrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ji2Ku2ZH1WW9DKlxO4woetZ//ek7SsL6L8u0hVrXXuo=;
        b=orVUetxBl5021ciPNpq05KtBcaTqid+QB+4BarBb2zMnKR/gUrFAYbdcbE+O7OgLBt
         zkPhmPsr2Eo4IV3MjGM9AnK971ZoF96PX5GGIIa+W2ECOeE8KDYIXeOpxDJQrwQW6pt0
         o/ccv15B124z4fL6zX9IR6B/CAjXYBebl0ehjhRkRInbhojtLVAxWVWoSLYUB6KZ43vo
         sjSKtHtZwHL6hsfQRh8P9sOiFaVQlh8njRsCo7+jUNNgjXZt3e6cG6+SPu6YelqIvtFQ
         3YLX5mhmbMl4J2bc3OQ2WnaSuia5yh0rOkUWLZo0ZZ6RTS2IfULGIPMzlCAl0PcnNXex
         WDoQ==
X-Gm-Message-State: AGi0PuZ6ntqmOSpqDSM9xXPf/OwhzR5M4n7lJEIYmFcvGWuZOXSQxvbV
        9z592iu1xRp70rc0LoXMt1wm3w==
X-Google-Smtp-Source: APiQypJF86iX+9FGY7/V9HXAMzna8j3EKU+Y+3rBQFK/ogLyrcLPa0jPk7CbGNhpCsejVuKqa1bj/Q==
X-Received: by 2002:adf:afdb:: with SMTP id y27mr3871899wrd.208.1585837421424;
        Thu, 02 Apr 2020 07:23:41 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:2db3:bc11:ecac:6375])
        by smtp.gmail.com with ESMTPSA id 9sm7096295wmm.6.2020.04.02.07.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 07:23:40 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com
Cc:     amit.kucheria@verdurent.com, vincent.whitchurch@axis.com,
        linux-pm@vger.kernel.org (open list:THERMAL),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] thermal: core: Send a sysfs notification on trip points
Date:   Thu,  2 Apr 2020 16:21:15 +0200
Message-Id: <20200402142116.22869-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <a7e8287d-72be-7ab0-697a-9de40eb3f81f@linaro.org>
References: <a7e8287d-72be-7ab0-697a-9de40eb3f81f@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently the userspace has no easy way to get notified when a
specific trip point was crossed. There are a couple of approaches:

- the userspace polls the sysfs temperature with usually an
  unacceptable delay between the trip temperature point crossing and
  the moment it is detected, or a high polling rate with an
  unacceptable number of wakeup events.

- the thermal zone is set to be managed by an userspace governor in
  order to receive the uevent even if the thermal zone needs to be
  managed by another governor.

These changes allow to send a sysfs notification on the
trip_point_*_temp when the temperature is getting higher than the trip
point temperature. By this way, the userspace can be notified
everytime when the trip point is crossed, this is useful for the
thermal Android HAL or for notification to be sent via d-bus.

That allows the userspace to manage the applications based on specific
alerts on different thermal zones to mitigate the skin temperature,
letting the kernel governors handle the high temperature for hardware
like the CPU, the GPU or the modem.

The temperature can be oscillating around a trip point and the event
will be sent multiple times. It is up to the userspace to deal with
this situation.

The following userspace program allows to monitor those events:

struct trip_data {
       int fd;
       int temperature;
       const char *path;
};

int main(int argc, char *argv[])
{
	int efd, i;
	struct trip_data *td;
	struct epoll_event epe;

	if (argc < 2) {
		fprintf(stderr, "%s <trip1> ... <tripn>\n", argv[0]);
		return 1;
	}

	if (argc > MAX_TRIPS) {
		fprintf(stderr, "Max trip points supported: %d\n", MAX_TRIPS);
		return 1;
	}

	efd = epoll_create(MAX_TRIPS);
	if (efd <  0) {
		fprintf(stderr, "epoll_create failed: %d\n", errno);
		return 1;
	}

	for (i = 0; i < argc - 1; i++) {

		FILE *f;
		int temperature;

		f = fopen(argv[i + 1], "r");
		if (!f) {
			fprintf(stderr, "Failed to open '%s': %d\n", argv[i + 1], errno);
			return 1;
		}

		td = malloc(sizeof(*td));
		if (!td) {
			fprintf(stderr, "Failed to allocate trip_data\n");
			return 1;
		}

		fscanf(f, "%d\n", &temperature);
		rewind(f);

		td->fd = fileno(f);
		td->path = argv[i + 1];
		td->temperature = temperature;

		epe.events = EPOLLIN | EPOLLET;
		epe.data.ptr = td;

		if (epoll_ctl(efd, EPOLL_CTL_ADD, td->fd, &epe)) {
			fprintf(stderr, "Failed to epoll_ctl: %d\n", errno);
			return 1;
		}

		printf("Set '%s' for temperature '%d'\n",
		       td->path, td->temperature);
	}

	while(1) {

		if (epoll_wait(efd, &epe, 1, -1) < 0) {
			fprintf(stderr, "Failed to epoll_wait: %d\n", errno);
			return 1;
		}

		td = epe.data.ptr;

		printf("The trip point '%s' crossed the temperature '%d'\n",
		       td->path, td->temperature);
	}

	return 0;
}

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index c06550930979..3cbdd20252ab 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -407,6 +407,19 @@ static void handle_critical_trips(struct thermal_zone_device *tz,
 	}
 }
 
+static int thermal_trip_crossed(struct thermal_zone_device *tz, int trip)
+{
+	int trip_temp;
+
+	tz->ops->get_trip_temp(tz, trip, &trip_temp);
+
+	if (tz->last_temperature == THERMAL_TEMP_INVALID)
+		return 0;
+
+	return ((tz->last_temperature < trip_temp)) &&
+		(tz->temperature >= trip_temp));
+}
+
 static void handle_thermal_trip(struct thermal_zone_device *tz, int trip)
 {
 	enum thermal_trip_type type;
@@ -417,6 +430,16 @@ static void handle_thermal_trip(struct thermal_zone_device *tz, int trip)
 
 	tz->ops->get_trip_type(tz, trip, &type);
 
+	/*
+	 * This condition will be true everytime the temperature is
+	 * greater than the trip point and the previous temperature
+	 * was below. In this case notify the userspace via a sysfs
+	 * event on the trip point.
+	 */
+	if (thermal_trip_crossed(tz, trip))
+		sysfs_notify(&tz->device.kobj, NULL,
+			     tz->trip_temp_attrs[trip].attr.attr.name);
+
 	if (type == THERMAL_TRIP_CRITICAL || type == THERMAL_TRIP_HOT)
 		handle_critical_trips(tz, trip, type);
 	else
-- 
2.17.1

