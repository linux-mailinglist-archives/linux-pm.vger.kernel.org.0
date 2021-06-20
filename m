Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B19E63AE09C
	for <lists+linux-pm@lfdr.de>; Sun, 20 Jun 2021 23:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbhFTVRD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 20 Jun 2021 17:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbhFTVRC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 20 Jun 2021 17:17:02 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440F3C061756;
        Sun, 20 Jun 2021 14:14:49 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id d16so19227706lfn.3;
        Sun, 20 Jun 2021 14:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZeaO9j1CH36NqplxfZvrUc6RyUETmNaWyi/Fv9u9sTQ=;
        b=KfjPj0y6NENx2JAZ4V7qAGoxJTYvgb0zE3OQZCtVlgue5AHRk9ssQhk0ZYXtMs3a3V
         cAK/+bXLmdeRV+yLiKwMn8wvD7KXfFcf/ZZeVYgFD71e/9hTLnN5OeLZ+iZGuCmQUDIN
         OdDG9+oHD+vqeqE//JTb+NVSVe88qAi6jATXufXTWw1++OWlxwzrmBOPGLDlLFlTbOOA
         4RX+fOQInmXAkRYMP6sZUxILbuYP9VOSsvZz5s3wC54gWye3QiDoV8m8vwYzEsr8N6rq
         Wf+vadl1ATgtOrhDf/vkAtchBPqJiG4iyc8DKz7ITHHRWyKMSzhgbMtRnYB2ow/qhsD6
         U5/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZeaO9j1CH36NqplxfZvrUc6RyUETmNaWyi/Fv9u9sTQ=;
        b=DcSAtynYCDa2oXt97GxYUI5mIjzzI3cN+Kz9z8D+YTrzjRCO5TxgW8mIofckdge3Gd
         bKG2EHmOO37rlwZtiM5Ik5NQhn4Puyt/COlJuD9K5TuMsCRDyRe75UfOsD1VKef7sDef
         P9hARsUul+akgiazU+2S5x8jSw3Ui5Lbss6We2ls/73zNNTckA09kTjjtPgiuu6DKqs7
         7KGII4ZTHx+IARux6DIikKIpo8z/uT2RnnBC9Y9lbZ1c0cIZXrJEUYmWTRnLPJ+tKM0o
         hrNUlvzPU0dhdrdVBhi57eRrew9IZnLr4XBQ4KXgcsr5GXyg0iayv5MfSKIYNC3nVO79
         s0/w==
X-Gm-Message-State: AOAM531KE6n/MQSD6EQ8x1F/Cy57xF8egTRMFQf0GvNxkTiO/t7IG5Vm
        FN+TjjfFLb66v4P9uliGUOc=
X-Google-Smtp-Source: ABdhPJxCR15jANmBa3wYw6jleLq7uu0WeIWab9dXNLBCOKUcyyxGFrBU7NEo01/ouYWEqavKOu439g==
X-Received: by 2002:a19:5d53:: with SMTP id p19mr11925961lfj.581.1624223687527;
        Sun, 20 Jun 2021 14:14:47 -0700 (PDT)
Received: from localhost.localdomain (94-29-29-31.dynamic.spd-mgts.ru. [94.29.29.31])
        by smtp.gmail.com with ESMTPSA id o142sm62875lfa.299.2021.06.20.14.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jun 2021 14:14:47 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v2 1/2] hwmon: (lm90) Prevent integer overflow of temperature calculations
Date:   Mon, 21 Jun 2021 00:14:07 +0300
Message-Id: <20210620211408.3893-2-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210620211408.3893-1-digetx@gmail.com>
References: <20210620211408.3893-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The minimum temperature value that is passed to the driver is unlimited
and value that is close to INT_MIN results in integer overflow of
temperature calculations made by the driver. Limit the value in order
to prevent the overflow. For now the overflow condition is harmless,
but thermal framework won't work properly once we will support the
set_trips() callback because it will pass INT_MIN value to the driver.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/hwmon/lm90.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index b53f17511b05..6e2fa976098f 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -1028,6 +1028,9 @@ static int lm90_set_temp11(struct lm90_data *data, int index, long val)
 	struct reg *regp = &reg[index];
 	int err;
 
+	/* prevent integer overflow */
+	val = max(val, -128000l);
+
 	/* +16 degrees offset for temp2 for the LM99 */
 	if (data->kind == lm99 && index <= 2)
 		val -= 16000;
@@ -1088,6 +1091,9 @@ static int lm90_set_temp8(struct lm90_data *data, int index, long val)
 	struct i2c_client *client = data->client;
 	int err;
 
+	/* prevent integer overflow */
+	val = max(val, -128000l);
+
 	/* +16 degrees offset for temp2 for the LM99 */
 	if (data->kind == lm99 && index == 3)
 		val -= 16000;
-- 
2.30.2

