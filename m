Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78DB156BFB0
	for <lists+linux-pm@lfdr.de>; Fri,  8 Jul 2022 20:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239573AbiGHSce (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 Jul 2022 14:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239600AbiGHSc0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 Jul 2022 14:32:26 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B75D1292
        for <linux-pm@vger.kernel.org>; Fri,  8 Jul 2022 11:32:22 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id q9so31620067wrd.8
        for <linux-pm@vger.kernel.org>; Fri, 08 Jul 2022 11:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VMSNl4aXxj8gUfbW/Yo0+vXzMXAM2NkamvbFD7ALP70=;
        b=QHKbQCi/uyJY2HVCVLW0HGvS0E2aoaeSgr3x3Imt2YLi0y71h2t1zN9uGcEY6VnjdG
         QRSRdvZwq8nmLBsPi6uTOtC6haZK7y9mu3ADhY2Rp0ZBQ8hDTuQGhNUNlVbCB2C9rZsb
         xr0+YP1HxS8YFwYaJpXDHyYlDjC2u+pwidK6yowECHeeBsaK4/q5H4gO1F8ntpgycIhc
         9cY5GyS3nyzEbTXqvgwI5hYzShhK4fgv6Zoqg9kheySsTj4dW5pUs4b82x5Dfbblol5i
         7Uhpfv2PI/ddAfSV/lHDAxpBOtJeDtgGcjzdpCpvjhsZRUa99jJ09OjYvlru0xOZ3CNb
         j63A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VMSNl4aXxj8gUfbW/Yo0+vXzMXAM2NkamvbFD7ALP70=;
        b=wHDGAhJ97Lcd7/PsbVJ06GN/H30Ir/6KZfzTA1fxC9CLVAO/rCA7a4m87LP39jFxoc
         eU+kiEAysFA4VnC3krmq4NH29V2RSS1YzAAJT0wXKyeozTBa9Gj9emCLendvKpSrZE8Z
         EbFOksIQEgMuPb6wczV+F7LwOZFJeoz0Br2OB5rjb8kIWPe01w3Ru5mIdxUzjANs/MD6
         XC1xU6NsCv8ZulpaMGF+VChivt/TAXWmae/ZbrN3kHSVeVSwCFa8nmo8w6VLIKhaWt9P
         zbWTl0RuHqrfYwNW+Aqmr0INrjTj0NsA86RB0fqAcNnOQMTPcu1LLHXDg4s552CvrTKS
         /boA==
X-Gm-Message-State: AJIora8Au+32PXsa1+BFh1VoO+Om1c5Tg162apVz5z3W5EKV7IFmQXOW
        2sHXZNEXGy7BBXq6FwY7GH49rQ==
X-Google-Smtp-Source: AGRyM1s8AwjUtL3ElAHbWB460RMjH7JJIOmM/uztVchYIW0xv+5N83lC5cUU2eIyDvrX0ZpkEj/SFg==
X-Received: by 2002:adf:e90d:0:b0:21d:6a18:918a with SMTP id f13-20020adfe90d000000b0021d6a18918amr4547628wrm.266.1657305141220;
        Fri, 08 Jul 2022 11:32:21 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id t9-20020adfeb89000000b0021d887f9468sm4292073wrn.25.2022.07.08.11.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 11:32:20 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     quic_manafm@quicinc.com, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v2 2/3] thermal/core: Passing a parameter instead of calling the function again
Date:   Fri,  8 Jul 2022 20:32:08 +0200
Message-Id: <20220708183210.1334839-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220708183210.1334839-1-daniel.lezcano@linaro.org>
References: <20220708183210.1334839-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

As the trip temperature is already available when calling the
function, pass it as a parameter instead of having the function
calling the ops again to retrieve the same data.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index d9f771b15ed8..f66036b3daae 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -340,12 +340,8 @@ void thermal_zone_device_critical(struct thermal_zone_device *tz)
 EXPORT_SYMBOL(thermal_zone_device_critical);
 
 static void handle_critical_trips(struct thermal_zone_device *tz,
-				  int trip, enum thermal_trip_type trip_type)
+				  int trip, int trip_temp, enum thermal_trip_type trip_type)
 {
-	int trip_temp;
-
-	tz->ops->get_trip_temp(tz, trip, &trip_temp);
-
 	/* If we have not crossed the trip_temp, we do not care. */
 	if (trip_temp <= 0 || tz->temperature < trip_temp)
 		return;
@@ -394,7 +390,7 @@ static void handle_thermal_trip(struct thermal_zone_device *tz, int trip)
 	handle_thermal_trip_crossed(tz, trip, trip_temp, hyst, type);
 
 	if (type == THERMAL_TRIP_CRITICAL || type == THERMAL_TRIP_HOT)
-		handle_critical_trips(tz, trip, type);
+		handle_critical_trips(tz, trip, trip_temp, type);
 	else
 		handle_non_critical_trips(tz, trip);
 	/*
-- 
2.25.1

