Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCEC10CAD2
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2019 15:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbfK1Ozd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Nov 2019 09:55:33 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46669 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfK1Ozc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Nov 2019 09:55:32 -0500
Received: by mail-pf1-f196.google.com with SMTP id 193so13242710pfc.13;
        Thu, 28 Nov 2019 06:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9drT9CU5cZN6dzbiFt4dm2bln4hYnigDIHpJhrBGGI4=;
        b=CTpe8s2xCUn55c5tx7AZUMZmQFZTo7qTzSlyyhWDRNZHydZxvqwsQmL6ogW1652b52
         OACTjH44RQmVeLfHQbVyDLx8Vd83i7kIhU5hCKICNON6BtISh6E/d89zNjqNe/4t6PCt
         DkGm6SqPiTF7LJLoBwW5c/DTDfeYgEdPZalDfSNxcqcytKwwumIHhYnxLeZzeXSQEbzQ
         7I+e22yZDZ2zGxogtzTv46Lxa5jBexMH65DJUi/Ypu9ToRrl0FwiB5zOuH4NCj3syD97
         8By4nqa2uYdz6Hv17AqYwA/K9SbsTu5rqes1cHVKZr6Q/aXZ4/NiU2A8noQ8XiorPir+
         8u0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9drT9CU5cZN6dzbiFt4dm2bln4hYnigDIHpJhrBGGI4=;
        b=BXGpvhBNQG0pXLeVreNhwIjkx9sNlvGeG+e2Wuxib5wBUScXaAN1hSLvTjCg6b84rb
         jhTf3mm6cYjvINiaGkBPH+/trlwDryf3dI35QYFUFyaOXPCcCoMt8D8KM5kZ5me7KHx/
         XL6zirjkJmZC2a0NoVNoh1jp8OQ41df+Ik2iNvKHc2+E1QWKTxpO4ZCanH4qBddtdos6
         PhQyD3yIyrccIAfrZOf23E58tjfQafZnZdM3P8fPuaf3alyusC1/NW0CZYuo6GmZONHP
         k6RQrAI2HEBS1vJ5U7bp9k/e/842xp+6v4wfJAQFR+YBXuQLS8ruNm2Wj1k8HQZ0OO6l
         r5Fw==
X-Gm-Message-State: APjAAAXjDDRe7G9B6nNPfTSIs5Qcej8CjiFgwqi9wyp1/fCqKjj2dwlp
        aWLB8qA/+JGB6fzFnI/CQC4=
X-Google-Smtp-Source: APXvYqz5GDqSUvR11svaKL3mV9F7NGqWfJiFhxG9BLX8Gx4vc1cLuLg0Od4+rsbz5kbxFJNVK+mzmA==
X-Received: by 2002:a63:642:: with SMTP id 63mr6907260pgg.73.1574952931743;
        Thu, 28 Nov 2019 06:55:31 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:8015:e854:5ef0:f52e])
        by smtp.gmail.com with ESMTPSA id z11sm22282563pfg.117.2019.11.28.06.55.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 28 Nov 2019 06:55:30 -0800 (PST)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     linux-nvme@lists.infradead.org, linux-hwmon@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Sujith Thomas <sujith.thomas@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH v2 8/8] thermal: remove kelvin to/from Celsius conversion helpers from <linux/thermal.h>
Date:   Thu, 28 Nov 2019 23:54:39 +0900
Message-Id: <1574952879-7200-9-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574952879-7200-1-git-send-email-akinobu.mita@gmail.com>
References: <1574952879-7200-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This removes the kelvin to/from Celsius conversion helpers in
<linux/thermal.h> which were switched to <linux/temperature.h> helpers.

Cc: Sujith Thomas <sujith.thomas@intel.com>
Cc: Darren Hart <dvhart@infradead.org>
Cc: Andy Shevchenko <andy@infradead.org>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Amit Kucheria <amit.kucheria@verdurent.com>
Cc: Jean Delvare <jdelvare@suse.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
* v2
- don't preserve DECI_KELVIN_TO_MILLICELSIUS_WITH_OFFSET()

 include/linux/thermal.h | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index e45659c..da272fa 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -32,17 +32,6 @@
 /* use value, which < 0K, to indicate an invalid/uninitialized temperature */
 #define THERMAL_TEMP_INVALID	-274000
 
-/* Unit conversion macros */
-#define DECI_KELVIN_TO_CELSIUS(t)	({			\
-	long _t = (t);						\
-	((_t-2732 >= 0) ? (_t-2732+5)/10 : (_t-2732-5)/10);	\
-})
-#define CELSIUS_TO_DECI_KELVIN(t)	((t)*10+2732)
-#define DECI_KELVIN_TO_MILLICELSIUS_WITH_OFFSET(t, off) (((t) - (off)) * 100)
-#define DECI_KELVIN_TO_MILLICELSIUS(t) DECI_KELVIN_TO_MILLICELSIUS_WITH_OFFSET(t, 2732)
-#define MILLICELSIUS_TO_DECI_KELVIN_WITH_OFFSET(t, off) (((t) / 100) + (off))
-#define MILLICELSIUS_TO_DECI_KELVIN(t) MILLICELSIUS_TO_DECI_KELVIN_WITH_OFFSET(t, 2732)
-
 /* Default Thermal Governor */
 #if defined(CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE)
 #define DEFAULT_THERMAL_GOVERNOR       "step_wise"
-- 
2.7.4

