Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEBF33B12A8
	for <lists+linux-pm@lfdr.de>; Wed, 23 Jun 2021 06:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbhFWEZI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Jun 2021 00:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbhFWEZH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Jun 2021 00:25:07 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80607C061756;
        Tue, 22 Jun 2021 21:22:49 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id f30so1855080lfj.1;
        Tue, 22 Jun 2021 21:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c2GV8eATeToxDrzoZV6+700+LfP1LGt3uPIeH8pfaR0=;
        b=HDJaVspKcZN4I4zKKnVXeIDejNMglmh7TUgW2aBhzcN1P7qK0RuhfLigDKBGg0gXpH
         nSlQ3e5C1L2Pmu+QXX3u+2nQzUAU6Jatb+OuE6UBaayaDpo96lMQP/C9Yu0m6Kdo4saR
         Roziu5NPgBahujWHnhtuE0AVcklJyl4ujIlZzYkmACkiqUMIVgQUKVDkARQ5iSNcmytT
         NZXyZ7mBKr2dLpta6iJzN1rBoYYWAk5JOWGag4nk5s9OAvjGy8UGgGtSktg65K2qilKW
         eTGZp2PeQQWbfUtHsBvcbDXjjaqBB2YrZPCVRjA/LBCiuoGOm3n44UejW/cRPlcMH4ha
         uX7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c2GV8eATeToxDrzoZV6+700+LfP1LGt3uPIeH8pfaR0=;
        b=j5yAt3kDrCjgUdUt90Lb3QLQ+87oROeLzoORvT4Kkm0fjPeJBfb+4zFo+IF7pai0Nb
         Xw9bF8IA6RyZ2H2WyHUROdgAJUpY0mWIaJgNcqWsDbdqqH1e7keZuaifdPlJfOEfINHB
         X0uLxk26314kfBKyEAoZhKqQsOUkxkupks6X6LLs3GydlM24qfR4rdys1ANsuKZWSrKk
         wO8kdD630bZCVhhZZUcl7DOGw3yZe3TeI8wCvDCymY4o6g7jSDqAEMvCqW/93Fmya1qs
         7DoPxTkGcJc3e6H3xJp4WqBHQIb9WPEiFX/VVCKP330PHq15q1ld19jHcjR84fGXieRW
         fs1w==
X-Gm-Message-State: AOAM532BL9PSRPMTwpH2zycBsGHwSkc0DTduG2Xowi/A5lkPlL7Fqr9R
        o4zCs1ov96qAOWeidJqsQVQ=
X-Google-Smtp-Source: ABdhPJzC0uw/+CV0rEkPKaQdUJxwXlikpYC8MRUx8ab63SVI0XrbOKLz5oLgPZPqru43n4QtCQ0gXw==
X-Received: by 2002:a19:c743:: with SMTP id x64mr5429256lff.96.1624422167937;
        Tue, 22 Jun 2021 21:22:47 -0700 (PDT)
Received: from localhost.localdomain (94-29-29-31.dynamic.spd-mgts.ru. [94.29.29.31])
        by smtp.gmail.com with ESMTPSA id c9sm174027ljb.22.2021.06.22.21.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 21:22:47 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v5 1/2] hwmon: (lm90) Prevent integer underflows of temperature calculations
Date:   Wed, 23 Jun 2021 07:22:30 +0300
Message-Id: <20210623042231.16008-2-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210623042231.16008-1-digetx@gmail.com>
References: <20210623042231.16008-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The min/max/crit and all other temperature values that are passed to
the driver are unlimited and value that is close to INT_MIN results in
integer underflow of the temperature calculations made by the driver
for LM99 sensor. Temperature hysteresis is among those values that need
to be limited, but limiting of hysteresis is independent from the sensor
version. Add the missing limits.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/hwmon/lm90.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index b53f17511b05..567b7c521f38 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -1029,8 +1029,11 @@ static int lm90_set_temp11(struct lm90_data *data, int index, long val)
 	int err;
 
 	/* +16 degrees offset for temp2 for the LM99 */
-	if (data->kind == lm99 && index <= 2)
+	if (data->kind == lm99 && index <= 2) {
+		/* prevent integer underflow */
+		val = max(val, -128000l);
 		val -= 16000;
+	}
 
 	if (data->kind == adt7461 || data->kind == tmp451)
 		data->temp11[index] = temp_to_u16_adt7461(data, val);
@@ -1089,8 +1092,11 @@ static int lm90_set_temp8(struct lm90_data *data, int index, long val)
 	int err;
 
 	/* +16 degrees offset for temp2 for the LM99 */
-	if (data->kind == lm99 && index == 3)
+	if (data->kind == lm99 && index == 3) {
+		/* prevent integer underflow */
+		val = max(val, -128000l);
 		val -= 16000;
+	}
 
 	if (data->kind == adt7461 || data->kind == tmp451)
 		data->temp8[index] = temp_to_u8_adt7461(data, val);
@@ -1137,6 +1143,9 @@ static int lm90_set_temphyst(struct lm90_data *data, long val)
 	else
 		temp = temp_from_s8(data->temp8[LOCAL_CRIT]);
 
+	/* prevent integer underflow */
+	val = max(val, -128000l);
+
 	data->temp_hyst = hyst_to_reg(temp - val);
 	err = i2c_smbus_write_byte_data(client, LM90_REG_W_TCRIT_HYST,
 					data->temp_hyst);
-- 
2.30.2

