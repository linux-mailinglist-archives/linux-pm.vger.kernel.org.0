Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5145634D000
	for <lists+linux-pm@lfdr.de>; Mon, 29 Mar 2021 14:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbhC2MYs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Mar 2021 08:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbhC2MYp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Mar 2021 08:24:45 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A3DC061574
        for <linux-pm@vger.kernel.org>; Mon, 29 Mar 2021 05:24:44 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id x14so12113934qki.10
        for <linux-pm@vger.kernel.org>; Mon, 29 Mar 2021 05:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T/fMBYR4Yd5piX+1pA3p+PIx0zWWBB+T3lnvR9rHYBo=;
        b=q6qRHAQXV+hKgpBAY9KIiHljsognBYKZkanegA1uC8hRRCT4gWZPseYrnWDS8FV0Qi
         gBt3SxuKNYAwbXVrY1VILIUGdqyLLjXb1B2vUGXAE3ih1zbpJhCP6gX4gN6mSaweckQ1
         OIbZeQFoqOrXA2svbTGXRwWDxXB74UPjowsRYbvapsNhwao5gHm1J++nTBK6X1GrVklh
         ISPmnv+D9/m6npYrovZ3meGiis3N3tc+KUUo0xSoljpI5sNcDpDzbRfQxl+LcgeOuo+c
         PdHhpjNpfYCRxbCY5dfhkyFi5EIzN1E7bI4tJayHcOwQ86MO6JLmp4Vw4z7QC6wEsqM9
         dtOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T/fMBYR4Yd5piX+1pA3p+PIx0zWWBB+T3lnvR9rHYBo=;
        b=pyarMO2G6dp6A+rmTHS2BdIIrMzXgk8jRYgUa9cgq7vKwxj+Eja/XYUsC/ZToeGENa
         mWJxQnLEWXNr3uzk3e2ytcSgAMuEFYx7l94EzNu1B5OFaUowOckrmfZtytKViBlGdDqt
         BUD+jushhvAxn4ITtmwJE0WmNKei9HT2OIFtlxWL3PyusdccDOJSn7BmRS3FwJ0revpQ
         +A+1wyoci9OD7+pfOhEjurXBOk150c5USC4T/dBiYWsUQUTG35tQEraDeg5Ah33OXyKf
         WSerBUpJS3nuwla+oHP13gCEE19JDxg3/C7ftIkpY8PIkycGCMlXwI9L4Iiq468zSoC7
         zV+w==
X-Gm-Message-State: AOAM533pRpxeyUV3paI4SoBzt+mwK/odskfg/xvi5NyktutTjWmaOHrc
        N+QbPPFnpSO78QU8OQffyJGWSy+gyyE=
X-Google-Smtp-Source: ABdhPJyC84R1sthJRLTxBia2zf5iDkKMTOyg3Ynh1tFBadaliwhJol5lwHH5Cm/I9F9PiK5KklVQ9g==
X-Received: by 2002:a37:9fd2:: with SMTP id i201mr24090294qke.435.1617020683910;
        Mon, 29 Mar 2021 05:24:43 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:482:919:7898:56c:200:f2a5])
        by smtp.gmail.com with ESMTPSA id s13sm13246877qkg.17.2021.03.29.05.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 05:24:43 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     cw00.choi@samsung.com
Cc:     linux-imx@nxp.com, linux-pm@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 1/2] PM / devfreq: imx-bus: Remove unneeded of_match_ptr()
Date:   Mon, 29 Mar 2021 09:24:24 -0300
Message-Id: <20210329122425.579386-1-festevam@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

i.MX is a DT-only platform, so of_match_ptr() can be safely
removed.

Remove the unneeded of_match_ptr(). 

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/devfreq/imx-bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/imx-bus.c b/drivers/devfreq/imx-bus.c
index 4f38455ad742..3fc3fd77492d 100644
--- a/drivers/devfreq/imx-bus.c
+++ b/drivers/devfreq/imx-bus.c
@@ -169,7 +169,7 @@ static struct platform_driver imx_bus_platdrv = {
 	.probe		= imx_bus_probe,
 	.driver = {
 		.name	= "imx-bus-devfreq",
-		.of_match_table = of_match_ptr(imx_bus_of_match),
+		.of_match_table = imx_bus_of_match,
 	},
 };
 module_platform_driver(imx_bus_platdrv);
-- 
2.25.1

