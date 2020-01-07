Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A276A133741
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2020 00:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbgAGXVA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Jan 2020 18:21:00 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54801 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727074AbgAGXU7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jan 2020 18:20:59 -0500
Received: by mail-wm1-f68.google.com with SMTP id b19so599931wmj.4;
        Tue, 07 Jan 2020 15:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DFqhTgxbHey+swfK5cQ0/kLBEvOg3feXk6FuLBIj6rg=;
        b=nDisnmX+PIgFhWQVRWdesWNv9ixcj6x9PUEZ34fWlUmNl4k8eta3jASZ3azwX2INHe
         QxZljfKPiaAHTT6Q85B6WzdpkTBA3/ymeGOCRWoz5OFGEQeoqrv4oEl7luT115kwfzVo
         NcWx0AnOU61d5xFxAHhGlgVzQ7hgMWkJyY3HFRkO9mjTfBnJA3ELrMJBgFPcLqb6wHdO
         Q9LePQ4MDbstvjExvSoFyL6kHfLui9Wu5yQcBlkSJ+XnJBKv3cPDG5IC0S13TbspXkr4
         4ow4IhTq1sI44jfXmwA1od3gLhyi698C8Gv3eTo2ZFQZJBq1c3ZU5g2XXs5TQmLPoiAJ
         gkNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DFqhTgxbHey+swfK5cQ0/kLBEvOg3feXk6FuLBIj6rg=;
        b=NXGbLcp5+cGPa+mertLPYWBWGnrZHqNV0s0N3IpHY8qKBi7ztIKQJED8j0BYDkpCC2
         vRRUTb/MaxYUpqypIpaV1Wa5rHW30LTLblvKeRtxNaFm4PAdOR858PN7z/p4M9BKVbQv
         43VcBhflr/fxcR5WT3HjtnLb9f2GGIB0Iz+4rb+CDIRVyOiR6zmD1xcvZDVs2Luvtkh4
         sEPUEA2xG8H9LOnw7bS40D0ac+l57YVTyDMssRO15wKtLbgS7JiGoXwCMr3oAkYpo+T+
         3+op9oBmKfz6G85mKGxWWPD+RzR2xCVvV48on6UerTklCVF4zyq0tyvfIJQ9UsEZSfJV
         3KuQ==
X-Gm-Message-State: APjAAAVm0Hf5gvkmOxh7f34oa+AEfoviO1lKISU4iWQJGpem/EDmhXyz
        uvpXawnlt0m5KQrONxURQYU=
X-Google-Smtp-Source: APXvYqyf2pAQeQc6Y08scs8hc1IAo7Q9zP/id20wK7G8tbkv2vN+vhc6m/InBffSRAKW6T0dRy7FbA==
X-Received: by 2002:a1c:4454:: with SMTP id r81mr626445wma.117.1578439257221;
        Tue, 07 Jan 2020 15:20:57 -0800 (PST)
Received: from localhost.localdomain (p200300F1373A1900428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:373a:1900:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id n3sm1669577wrs.8.2020.01.07.15.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 15:20:56 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com, linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        jeff.dagenais@gmail.com, edubezval@gmail.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 1/2] thermal: generic-adc: silence "no lookup table" on deferred probe
Date:   Wed,  8 Jan 2020 00:20:43 +0100
Message-Id: <20200107232044.889075-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107232044.889075-1-martin.blumenstingl@googlemail.com>
References: <20200107232044.889075-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

A "generic-adc-thermal" without "temperature-lookup-table" is perfectly
valid since commit d36e2fa0253875 ("thermal: generic-adc: make lookup
table optional"). On deferred probe the message "no lookup table,
assuming DAC channel returns milliCelcius" is still logged.
Prevent this message on deferred probe of the IIO channel by first
looking up the IIO channel.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/thermal/thermal-generic-adc.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/thermal-generic-adc.c b/drivers/thermal/thermal-generic-adc.c
index ae5743c9a894..226e3c2b7469 100644
--- a/drivers/thermal/thermal-generic-adc.c
+++ b/drivers/thermal/thermal-generic-adc.c
@@ -124,13 +124,6 @@ static int gadc_thermal_probe(struct platform_device *pdev)
 	if (!gti)
 		return -ENOMEM;
 
-	ret = gadc_thermal_read_linear_lookup_table(&pdev->dev, gti);
-	if (ret < 0)
-		return ret;
-
-	gti->dev = &pdev->dev;
-	platform_set_drvdata(pdev, gti);
-
 	gti->channel = devm_iio_channel_get(&pdev->dev, "sensor-channel");
 	if (IS_ERR(gti->channel)) {
 		ret = PTR_ERR(gti->channel);
@@ -139,6 +132,13 @@ static int gadc_thermal_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	ret = gadc_thermal_read_linear_lookup_table(&pdev->dev, gti);
+	if (ret < 0)
+		return ret;
+
+	gti->dev = &pdev->dev;
+	platform_set_drvdata(pdev, gti);
+
 	gti->tz_dev = devm_thermal_zone_of_sensor_register(&pdev->dev, 0, gti,
 							   &gadc_thermal_ops);
 	if (IS_ERR(gti->tz_dev)) {
-- 
2.24.1

