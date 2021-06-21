Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 915C33AF773
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jun 2021 23:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbhFUVfb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Jun 2021 17:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbhFUVfb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Jun 2021 17:35:31 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3639EC061756;
        Mon, 21 Jun 2021 14:33:15 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id u11so16270548ljh.2;
        Mon, 21 Jun 2021 14:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1jk2ZclpdBEYX/i3iFJW267F/ek+tRQuhMbQVF0BgrE=;
        b=YICQtMKci5AJn2Shtt9a4JsPuq0LLF9u31qxuBLNJhLvMIssXKk2NLa/HHoYZAwaXE
         B55nSGuM08o2m1dV9fPeWDQB0znmoGG1C11ywwbhKV8QVI3vw0cK1NZkS75+Lsfn5v1Z
         i9Ig48RfVfxTMvEq5GjLnWxhojbNqo1NnXj1qRNfAnSd4x5z1NSsfu/CoAkoVQ3wcCNP
         NYe3J3QOkhsdvLsMbDZROrfnMlYhdOubCiOKHaJ2B3pvIrFhj1jTlyaJMQYe77fcX4GJ
         sp/j+I9mxORymbbIPVjb8VJo53vI1tKbuZRSfb2e0Ahn2j3a17H95nuzr3fnCSAXFXV0
         6K7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1jk2ZclpdBEYX/i3iFJW267F/ek+tRQuhMbQVF0BgrE=;
        b=nOZpfJfFV6vXKwGrmSWsdU9AOjz8MBbrziu3VY7fq21r9+TCdhFbJcPVDS323/Lpln
         mg7ZHsTJ05BdUFiTpGuNREdFAqrup8necohct3DYmRCypK5Rxfin5VwGTLpED1G6tIjB
         Zw3scitlmwU0QwC/JfHLxzA7XgD3o6SJ5UmtjgKcUZDJW6mIpPEQBvFChDOSRW7/3olO
         i3DC1i/iM9LWR5RWgoBmCqAPLEiN6oSnUcCSVUhfWPJ6IWrvu6WAGyKOc2fVKWk7tcN0
         joT7pIvbhL1p9if7RUO3f3JIg+68uHo0m5Ax8TuS1fZfDAfc61dQvVEA858FV9svQhpG
         tjBg==
X-Gm-Message-State: AOAM530OFBh3CTJu5O29xiPfKEVH8Pt6FEdDTX4j6iCHu57dE+f5FHIs
        Eu7DO9OKqP7ikPtIE8jgupY=
X-Google-Smtp-Source: ABdhPJwah8tVZBczoVu5NMaUGDWFixuzNq0zAcAuFesvAGG8dMtzMyz59RhgSC+xRB+GV2q+S1OBQg==
X-Received: by 2002:a2e:58c:: with SMTP id 134mr189515ljf.441.1624311193633;
        Mon, 21 Jun 2021 14:33:13 -0700 (PDT)
Received: from localhost.localdomain (94-29-29-31.dynamic.spd-mgts.ru. [94.29.29.31])
        by smtp.gmail.com with ESMTPSA id u10sm1074722lfg.240.2021.06.21.14.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 14:33:13 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v4 1/2] hwmon: (lm90) Prevent integer underflows of temperature calculations
Date:   Tue, 22 Jun 2021 00:31:52 +0300
Message-Id: <20210621213153.28247-2-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210621213153.28247-1-digetx@gmail.com>
References: <20210621213153.28247-1-digetx@gmail.com>
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
 drivers/hwmon/lm90.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index b53f17511b05..ee6b8190f08e 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -1028,6 +1028,9 @@ static int lm90_set_temp11(struct lm90_data *data, int index, long val)
 	struct reg *regp = &reg[index];
 	int err;
 
+	/* prevent integer underflow */
+	val = max(val, -128000l);
+
 	/* +16 degrees offset for temp2 for the LM99 */
 	if (data->kind == lm99 && index <= 2)
 		val -= 16000;
@@ -1088,6 +1091,9 @@ static int lm90_set_temp8(struct lm90_data *data, int index, long val)
 	struct i2c_client *client = data->client;
 	int err;
 
+	/* prevent integer underflow */
+	val = max(val, -128000l);
+
 	/* +16 degrees offset for temp2 for the LM99 */
 	if (data->kind == lm99 && index == 3)
 		val -= 16000;
@@ -1130,6 +1136,9 @@ static int lm90_set_temphyst(struct lm90_data *data, long val)
 	int temp;
 	int err;
 
+	/* prevent integer underflow */
+	val = max(val, -128000l);
+
 	if (data->kind == adt7461 || data->kind == tmp451)
 		temp = temp_from_u8_adt7461(data, data->temp8[LOCAL_CRIT]);
 	else if (data->kind == max6646)
-- 
2.30.2

