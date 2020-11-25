Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5588B2C44E4
	for <lists+linux-pm@lfdr.de>; Wed, 25 Nov 2020 17:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730809AbgKYQYM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Nov 2020 11:24:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730747AbgKYQYL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Nov 2020 11:24:11 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE55C0613D4;
        Wed, 25 Nov 2020 08:24:11 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id x24so2805177pfn.6;
        Wed, 25 Nov 2020 08:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=3+3gfHD91/328qfooN+OsmJ9PHiYPgpjIR8tzOiYBHo=;
        b=YavSxQY4iVhrdX0h9CXAQtfQY3M/lSfjiujDt3l6QkRWufd91bgIX9sSzVy/CJPQrq
         O5CBFNRz30U5BB2MtV0PC7AlA7DIr1/WCYNY6O5N3bDGVQzIb2auyr/opkOZ/7bHa9CW
         LQ4zKVgVpfc30Ou7esFAYnagn3CYfwnMQKlvKuJ+QFnmEaluVp/REQeVECsmrJnWeaYC
         iKC4so2wF9PdUkTGZrRwc7unrzLxFU3jCjfaiaHM0J99PfhqD/vuk5pUuRTxtySIVsMI
         cPUwyixg1xr3OpqZ8pW6FqcXtNq3aKrjc6ySOfwHdPX7pwyikvv8a7p1OwmraJD0fF0a
         8frQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=3+3gfHD91/328qfooN+OsmJ9PHiYPgpjIR8tzOiYBHo=;
        b=X294hHSYw+JW2o2oKavxnMqe6lfRAjGrwJIfFpPuUoH7FdR+bnGCOq/QMuVsc3FEXZ
         wJbl0eZvo8FylYm37g7K17T4SRNy+F86EZAfXpu5ACSvlk21mixgsupu4AFHOB6sk76o
         hp9cW4XdSar6GB+BHed8Z7jmtXjn4E99/GQydwe2MwTrb4O311KT0iedTfp/52wvO49J
         NgkubN9s/zJoNUiSCCZ+5UDJhGhz5VF3+6I7aP4/wIV2powN3jR4LpGMuOAj0nH4j+mX
         VhZPtD4ctfVbAjL04ofTlb4II0620ECFAUWOFMbb02bn/zW0GRwFYklqBDg4fW54foNh
         HPwQ==
X-Gm-Message-State: AOAM531QkS1+D6I9g8rnTQrZvGXFQsBKLaEfDgmTD7yRZOz4Ps0ixIIO
        AMBv6cypowGdCYZ37YK0Z3U=
X-Google-Smtp-Source: ABdhPJxClJOLijc/qN4Y2TsUHFrwBBO/dNGfLQT1DiaRCkxu34lVJljgWO/JNiNtq4Nwes8TWw/gNw==
X-Received: by 2002:a62:61c2:0:b029:197:f5ee:6ffa with SMTP id v185-20020a6261c20000b0290197f5ee6ffamr3134826pfb.18.1606321451401;
        Wed, 25 Nov 2020 08:24:11 -0800 (PST)
Received: from paju ([116.124.119.85])
        by smtp.gmail.com with ESMTPSA id e4sm2613862pfh.90.2020.11.25.08.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 08:24:10 -0800 (PST)
Date:   Thu, 26 Nov 2020 01:24:05 +0900
From:   Dongjin Kim <tobetter@gmail.com>
To:     Guillaume La Roque <glaroque@baylibre.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>, linux-pm@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] thermal: amlogic_thermal: Add hwmon support
Message-ID: <20201125162405.GA1263100@paju>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Expose Amlogic thermal as HWMON devices.

	$ sensors
	cpu_thermal-virtual-0
	Adapter: Virtual device
	temp1:        +32.2 C  (crit = +110.0 C)

	ddr_thermal-virtual-0
	Adapter: Virtual device
	temp1:        +33.4 C  (crit = +110.0 C)

Signed-off-by: Dongjin Kim <tobetter@gmail.com>
---
 drivers/thermal/amlogic_thermal.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/thermal/amlogic_thermal.c b/drivers/thermal/amlogic_thermal.c
index ccb1fe18e993..2fce96c32586 100644
--- a/drivers/thermal/amlogic_thermal.c
+++ b/drivers/thermal/amlogic_thermal.c
@@ -29,6 +29,7 @@
 #include <linux/thermal.h>
 
 #include "thermal_core.h"
+#include "thermal_hwmon.h"
 
 #define TSENSOR_CFG_REG1			0x4
 	#define TSENSOR_CFG_REG1_RSET_VBG	BIT(12)
@@ -291,6 +292,9 @@ static int amlogic_thermal_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	if (devm_thermal_add_hwmon_sysfs(pdata->tzd))
+		dev_warn(&pdev->dev, "failed to add hwmon sysfs attributes\n");
+
 	ret = amlogic_thermal_enable(pdata);
 
 	return ret;
-- 
2.25.1

