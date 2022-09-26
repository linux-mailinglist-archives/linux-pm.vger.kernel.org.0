Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 571405EAA43
	for <lists+linux-pm@lfdr.de>; Mon, 26 Sep 2022 17:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236192AbiIZPUM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Sep 2022 11:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236412AbiIZPTM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Sep 2022 11:19:12 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8728382879
        for <linux-pm@vger.kernel.org>; Mon, 26 Sep 2022 07:06:36 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id o20-20020a05600c4fd400b003b4a516c479so3795615wmq.1
        for <linux-pm@vger.kernel.org>; Mon, 26 Sep 2022 07:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=/DpVb9+AKUGgq8A4EZDNel0xrsv5+R31U81PHZWHu7A=;
        b=WX3OvpQFA+M9INHpNy4Py5kKdxy5cfqEVZL375Jc/6L8OMcOpg9sqElg7DCTxP/x0F
         /54NRSlGurAKIoKRlRMjNrQJ/vEiT8OxGW27RIc+V6r48AxKSdrsl5a6INwzaQJsgv4G
         vlUzn89BfKonHFjj39dYQUJOGBE1CVqMSo8bUKkrqjxMNvGgKdJYE9H7cvTeYh3GdCd3
         7w8vlWxvnBd6igvNHoZ0s9s44dQOejOs5rnTq0+VxUVSmUwsFHXP+Tw4a8cWfGy1LkrH
         PH7VlEnKVv0qq/E7ufVO7jIUVARcbQ3S4VH36qGW/HW0+IpUOu1uoOCHTk3v3+oLrIR3
         QL+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=/DpVb9+AKUGgq8A4EZDNel0xrsv5+R31U81PHZWHu7A=;
        b=wwiW0XZjG4tH/SBhpyf6Nb8LdMQabK7k+xyxYtUvklzHkfhx7rgwNFzln+LFU0YL+C
         UE5Wui7MfCUfAsGi9qtssBcOrEB0BHCep2IrKqMPMNhA8CTs2GnIwbgUPV4IDbcXPxBm
         xV6KkQ6Br/T1EJiK/kGPf5UL85z1dtPquMs0Z9+WKvBNohCqLvM7bDBfj+DA3qMj1OS9
         9EAgAr790R7/0ksSlQBvqThg0MAXmhPr9qgAXBCRUAnVrxdzV0jofBZkoMTNKGki/bfW
         rPMsUBuFn9s+fkISapyOYG1DqGM2vYxg3fX55qQJfmuy1FUDpYouP4tWrbE4NJ/hAHQG
         h+hA==
X-Gm-Message-State: ACrzQf0K/efNkPNRXzpqLsPgSvZaHeVY5bXMcJeMKI6MnulHsn/KDWGZ
        1cazGdep6V5Ku1jIVz6PAFL0mg==
X-Google-Smtp-Source: AMsMyM7428UZktkIZgkcsoeeRa7QJH2nQ/49f5LZT+CS/3G/N/SXB0obuvQV6dEoQlM05iLibcLMnA==
X-Received: by 2002:a05:600c:1f05:b0:3b4:ae0a:b2e5 with SMTP id bd5-20020a05600c1f0500b003b4ae0ab2e5mr15829413wmb.104.1664201196515;
        Mon, 26 Sep 2022 07:06:36 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id v3-20020adfebc3000000b0022adf321d22sm14310731wrn.92.2022.09.26.07.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 07:06:36 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com, Amit Kucheria <amitk@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT)
Subject: [PATCH v5 14/30] thermal/drivers/qcom: Use generic thermal_zone_get_trip() function
Date:   Mon, 26 Sep 2022 16:05:48 +0200
Message-Id: <20220926140604.4173723-15-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220926140604.4173723-1-daniel.lezcano@linaro.org>
References: <20220926140604.4173723-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The thermal framework gives the possibility to register the trip
points with the thermal zone. When that is done, no get_trip_* ops are
needed and they can be removed.

Convert ops content logic into generic trip points and register them with the
thermal zone.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Amit Kucheria <amitk@kernel.org>
---
 drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 39 +++++++++------------
 1 file changed, 17 insertions(+), 22 deletions(-)

diff --git a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
index be785ab37e53..127e8c90211c 100644
--- a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
+++ b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
@@ -263,17 +263,17 @@ static int qpnp_tm_update_critical_trip_temp(struct qpnp_tm_chip *chip,
 	return qpnp_tm_write(chip, QPNP_TM_REG_SHUTDOWN_CTRL1, reg);
 }
 
-static int qpnp_tm_set_trip_temp(struct thermal_zone_device *tz, int trip, int temp)
+static int qpnp_tm_set_trip_temp(struct thermal_zone_device *tz, int trip_id, int temp)
 {
 	struct qpnp_tm_chip *chip = tz->devdata;
-	const struct thermal_trip *trip_points;
+	struct thermal_trip trip;
 	int ret;
 
-	trip_points = of_thermal_get_trip_points(chip->tz_dev);
-	if (!trip_points)
-		return -EINVAL;
+	ret = thermal_zone_get_trip(chip->tz_dev, trip_id, &trip);
+	if (ret)
+		return ret;
 
-	if (trip_points[trip].type != THERMAL_TRIP_CRITICAL)
+	if (trip.type != THERMAL_TRIP_CRITICAL)
 		return 0;
 
 	mutex_lock(&chip->lock);
@@ -299,22 +299,17 @@ static irqreturn_t qpnp_tm_isr(int irq, void *data)
 
 static int qpnp_tm_get_critical_trip_temp(struct qpnp_tm_chip *chip)
 {
-	int ntrips;
-	const struct thermal_trip *trips;
-	int i;
-
-	ntrips = of_thermal_get_ntrips(chip->tz_dev);
-	if (ntrips <= 0)
-		return THERMAL_TEMP_INVALID;
-
-	trips = of_thermal_get_trip_points(chip->tz_dev);
-	if (!trips)
-		return THERMAL_TEMP_INVALID;
-
-	for (i = 0; i < ntrips; i++) {
-		if (of_thermal_is_trip_valid(chip->tz_dev, i) &&
-		    trips[i].type == THERMAL_TRIP_CRITICAL)
-			return trips[i].temperature;
+	struct thermal_trip trip;
+	int i, ret;
+
+	for (i = 0; i < thermal_zone_get_num_trips(chip->tz_dev); i++) {
+
+		ret = thermal_zone_get_trip(chip->tz_dev, i, &trip);
+		if (ret)
+			continue;
+
+		if (trip.type == THERMAL_TRIP_CRITICAL)
+			return trip.temperature;
 	}
 
 	return THERMAL_TEMP_INVALID;
-- 
2.34.1

