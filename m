Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D34985EAA23
	for <lists+linux-pm@lfdr.de>; Mon, 26 Sep 2022 17:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235881AbiIZPTX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Sep 2022 11:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236284AbiIZPSz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Sep 2022 11:18:55 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3685F816AB
        for <linux-pm@vger.kernel.org>; Mon, 26 Sep 2022 07:06:23 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id n12so10387116wrx.9
        for <linux-pm@vger.kernel.org>; Mon, 26 Sep 2022 07:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=jmpCz9X5WVxh1IdlD0BjEhB4jAKQCO/83Z0tz1CW7NQ=;
        b=Unj4fsRjSapJWLRiFGOi/9WlHeSp6j1ZX58v54hU5ozvLpi+exiOKyQlOCR2lYf2Hi
         fYvVjRurDnsQ3WPDVkXCtLPg7OTrz0mEVzLv/kGBGoI0o74I2PsgBS/KIrkbI5Idgkia
         sV4LrrCvW04KdbPdiDT0exoEhy8c6bUs7FyZLftnl6C3dw8pJDfg1lVha9ktTeuQ60mX
         cvJ5xlOSXbv3UPaHkGXnBuvduIbg7wbmdGH6k0vOlrD88bG95fdS2YQN0nWQGw61Z2CR
         WB2CzQ6T4C+nd3xxU7eJzTiNm6+klk86UyU24RESrWc6ju4NGHHQFC0091Dc1nXcmL9/
         sJ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=jmpCz9X5WVxh1IdlD0BjEhB4jAKQCO/83Z0tz1CW7NQ=;
        b=hebLKCk6xWsBPQZpL+CucQuAdLGatwabxGOhqP387Q/FiPkuytTGsBO+8AGiaYyKv0
         xdANh+uAJwFHj4g5ysvqoXeEVpJhgL9RdNq+kIs1tkfYm0AMwRuq9T0HfZFsJtDsmFRQ
         vA6d6vrM/E62goFCBeENBOTed4I4s3VcNGgzNRuVAedoZmFqGiY/tduN9qsFxrJAKl4g
         /sFtRIXKO27HmeelSnK1XD9L/W8fUpm+mxO1c7ClbAErlaPsqsKZ5gYmxTt5S57G0bwh
         3UxBOffVorzeNp7CbU36rA+gT57Tlg78LGiIo4hYhh/Ey779S7zUZDXNLfPHbPuOEUZT
         mVsA==
X-Gm-Message-State: ACrzQf0IiIqEEpu+Moh/O5kGfA5v02+4/ywPl+zYgGRutannmjTdOzvS
        Xc2u3ONYOo7qTPrLl4+CCUNBggdJ35NKuQ==
X-Google-Smtp-Source: AMsMyM5EYPBaxhG7sUBR7UFiqb5ixd3MZAfz3SJXSrKw3i+AlWtnzb+g5TMD3a4r2OaxwnaM8Nwsaw==
X-Received: by 2002:adf:d0d2:0:b0:22a:daf4:87e8 with SMTP id z18-20020adfd0d2000000b0022adaf487e8mr13522466wrh.167.1664201181346;
        Mon, 26 Sep 2022 07:06:21 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id v3-20020adfebc3000000b0022adf321d22sm14310731wrn.92.2022.09.26.07.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 07:06:20 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com, Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v5 04/30] thermal/core: Add a generic thermal_zone_get_crit_temp() function
Date:   Mon, 26 Sep 2022 16:05:38 +0200
Message-Id: <20220926140604.4173723-5-daniel.lezcano@linaro.org>
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

The thermal zone ops defines a callback to retrieve the critical
temperature. As the trip handling is being reworked, all the trip
points will be the same whatever the driver and consequently finding
the critical trip temperature will be just a loop to search for a
critical trip point type.

Provide such a generic function, so we encapsulate the ops
get_crit_temp() which can be removed when all the backend drivers are
using the generic trip points handling.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Zhang Rui <rui.zhang@intel.com>
---
 include/linux/thermal.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 5350a437f245..66373f872237 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -343,6 +343,8 @@ int thermal_zone_set_trip(struct thermal_zone_device *tz, int trip_id,
 
 int thermal_zone_get_num_trips(struct thermal_zone_device *tz);
 
+int thermal_zone_get_crit_temp(struct thermal_zone_device *tz, int *temp);
+
 #ifdef CONFIG_THERMAL
 struct thermal_zone_device *thermal_zone_device_register(const char *, int, int,
 		void *, struct thermal_zone_device_ops *,
-- 
2.34.1

