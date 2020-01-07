Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D81D13373C
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2020 00:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbgAGXVB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Jan 2020 18:21:01 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36863 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbgAGXU7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jan 2020 18:20:59 -0500
Received: by mail-wr1-f68.google.com with SMTP id z3so1462859wru.3;
        Tue, 07 Jan 2020 15:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vV3UUGvvS5e8WsB7ogZ/noPCe30PWO4cAHloQARZuMU=;
        b=QWaRBgfZaWwF/o5TtRmsgFA8xMd72UlNn8DRyiFN0jTom3bemOIPUhrrsKBbPAIFPJ
         OfNPUerjyxw6FJm3VOSYYi5Jgr+yKEMboXZfvsuYAU45QDTIYTNGFT7b4Dnd6llum1GO
         OYVNZfemZicnDMO/Gbi6LPR+cmcbUamwBbbKb6PmT/ZELPKX9wA3PiUldg1RwEFbpZJn
         FChDB9Cwd2uWGi82zr/EoW+/0IdYDj9pSitFG9zN1kP+GK+xahlLOedxl0bQf6TtlRGj
         mcHrgAF6imjQzl6jZDR9Rxjj8vQL2u3++H3O10BNjbxcTxdtE1Aaad7VlOpHNIRI7GDf
         JY3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vV3UUGvvS5e8WsB7ogZ/noPCe30PWO4cAHloQARZuMU=;
        b=GoOok3I9YdI4GEpFvm9azGU1npvOzepQubPtSiFx7SHHH639LQepTMQZWRuSjmqrkq
         rOPOxisUFuG7/pMW4tt94WIB2UOkxZTOpdlQnOPz+Q7Uf2Fm+2nkLEbJ3qsRzODtBnEt
         LO6kSQWv6E7bhKY8udwcmL1jpAfMbQKfShMhPcWE/Bnt9o3TSnipf3KS2jwSAV8m61GP
         7Pu2lBPjjbIDKXc3ibWOePrMssWwXTYBwPZxiB+TUTDDQdd0sbbuw1U36M7Vhh3iwsgU
         aoZxUiGMZIAUtqNO7vT1wPu8aAOv7hQCGkeAmT8Q3o7asdYsu4lCS9keTzq2gALTb86+
         MQBQ==
X-Gm-Message-State: APjAAAUBgPSbsBig7vELt46cO+UtQjFRkLOxcf1G07/lB7Ei/1aubTdA
        yOquuPffsxebKIL4yZify0D+z8r3L9I=
X-Google-Smtp-Source: APXvYqyKuhYihOEUdettZiq3ZmkfYHAwS5DF2R/FVnINtIyY9r4EbiuwLBRM7ACqUWiqDdfnsEIjrA==
X-Received: by 2002:a5d:62d0:: with SMTP id o16mr1319611wrv.197.1578439258079;
        Tue, 07 Jan 2020 15:20:58 -0800 (PST)
Received: from localhost.localdomain (p200300F1373A1900428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:373a:1900:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id n3sm1669577wrs.8.2020.01.07.15.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 15:20:57 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com, linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        jeff.dagenais@gmail.com, edubezval@gmail.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 2/2] thermal: generic-adc: silence info message for IIO_TEMP channels
Date:   Wed,  8 Jan 2020 00:20:44 +0100
Message-Id: <20200107232044.889075-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107232044.889075-1-martin.blumenstingl@googlemail.com>
References: <20200107232044.889075-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Since commit d36e2fa0253875 ("thermal: generic-adc: make lookup table
optional") "generic-adc-thermal" can be used with an IIO_TEMP channel.
In this case the following message is logged at probe time:
  no lookup table, assuming DAC channel returns milliCelcius

Silence this info message if the channel type is known to be in
milli celsius. Keep this message when the channel type is unknown or not
of type temperature.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/thermal/thermal-generic-adc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal-generic-adc.c b/drivers/thermal/thermal-generic-adc.c
index 226e3c2b7469..73665c3ccfe0 100644
--- a/drivers/thermal/thermal-generic-adc.c
+++ b/drivers/thermal/thermal-generic-adc.c
@@ -76,13 +76,17 @@ static int gadc_thermal_read_linear_lookup_table(struct device *dev,
 						 struct gadc_thermal_info *gti)
 {
 	struct device_node *np = dev->of_node;
+	enum iio_chan_type chan_type;
 	int ntable;
 	int ret;
 
 	ntable = of_property_count_elems_of_size(np, "temperature-lookup-table",
 						 sizeof(u32));
 	if (ntable <= 0) {
-		dev_notice(dev, "no lookup table, assuming DAC channel returns milliCelcius\n");
+		ret = iio_get_channel_type(gti->channel, &chan_type);
+		if (ret || chan_type != IIO_TEMP)
+			dev_notice(dev,
+				   "no lookup table, assuming DAC channel returns milliCelcius\n");
 		return 0;
 	}
 
-- 
2.24.1

