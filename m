Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C26913AF538
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jun 2021 20:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbhFUSnd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Jun 2021 14:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbhFUSna (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Jun 2021 14:43:30 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58877C061574;
        Mon, 21 Jun 2021 11:41:15 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id m21so31792847lfg.13;
        Mon, 21 Jun 2021 11:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1jk2ZclpdBEYX/i3iFJW267F/ek+tRQuhMbQVF0BgrE=;
        b=RO7zJnbbWCPVzPMhvCitQtX5ZboD2tfKMGxjoo3FQgJ/tjcmitdtafqdwcZgAu8n1Q
         Y+jVITDQg/VHxVGvNLWCnxooNolmYP8KH9F59KAom9iDJp5kQQwD10Gv/9XsiGEYU+5+
         s0eUkp2dYi+RPWBA5WHwh5ean7pIhki+v/LWg1L5yCCOlgmd1xuQcOLzlbIwSDL9Iwfo
         y6e0aGtoL9i4wWfAXhoYZlosP8nJ4yRgQhikJOkxlOWjevO7+8yZzyOd8BWLDvKZbYqC
         KZpgY50WSDEPL4RxdfrHGzUwg6oV8+7V4zJkyK+N6tqfKHxnVw8bFLj+eJugmMBZEshX
         3gQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1jk2ZclpdBEYX/i3iFJW267F/ek+tRQuhMbQVF0BgrE=;
        b=Cr3q1FHkz0DKVPSONayCYFZrOpcaqEDtS3JM09ZQudQV7pxvQMXqcrkJ8Q88MWLLeZ
         89P+PtpNmFNXZHADd8d2YxplpmXLHG/pfEJAiT3Ve2k8tAmnpd5wEOnPtaWnq/jrlffN
         /JqsCJ6Gf9xUDg4Uv0xdZSxbCtYF4HfEVhzzDblFZDKM743jKi+FHPWywTooRGwywm8/
         UPCNWzBnku8Q7HcfecudfLezw8jODX7JRgNsEtAR62wZuR8zhBhtV9GsDODiLT4xk0kj
         mNKe5B88pHjRcglMmEV4kf9+ImpK+mU5spoVEb+LwoX8moFUPLaJYdhhU19WjHsn0GwV
         o0YA==
X-Gm-Message-State: AOAM530WhKUE0HpeLTMCb5pvpqL4U8+zSATTeP4BdXchXBoR5W7f4fxh
        Lhzfi30Tct7QKqw6h4+7ync=
X-Google-Smtp-Source: ABdhPJxIzTooWK3bftvJAo8/sDoMM4tyc2qMr7vRHi9SUuHdVbQ02muwvy5EsUEbtudZeMz332Y6YA==
X-Received: by 2002:a19:d7:: with SMTP id 206mr14745697lfa.457.1624300873719;
        Mon, 21 Jun 2021 11:41:13 -0700 (PDT)
Received: from localhost.localdomain (94-29-29-31.dynamic.spd-mgts.ru. [94.29.29.31])
        by smtp.gmail.com with ESMTPSA id y22sm1950843lfa.145.2021.06.21.11.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 11:41:13 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v3 1/2] hwmon: (lm90) Prevent integer underflows of temperature calculations
Date:   Mon, 21 Jun 2021 21:40:57 +0300
Message-Id: <20210621184058.4110-2-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210621184058.4110-1-digetx@gmail.com>
References: <20210621184058.4110-1-digetx@gmail.com>
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

