Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81368433268
	for <lists+linux-pm@lfdr.de>; Tue, 19 Oct 2021 11:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235094AbhJSJip (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Oct 2021 05:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235108AbhJSJim (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Oct 2021 05:38:42 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB27C061768
        for <linux-pm@vger.kernel.org>; Tue, 19 Oct 2021 02:36:29 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id r7so46655317wrc.10
        for <linux-pm@vger.kernel.org>; Tue, 19 Oct 2021 02:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=31i1xoK4zj6WYEXJeZOG+hCuryOlTysPNDj29OD14Qs=;
        b=Y2eamLP67cGTLHdzxPbLdUPEYihkfZRXjLmtnxWMV7V8ha/xCyyiXWo24W7cKen6+2
         AGmoxk8bAW1ZE6wRgyRZos2ZQJMvNmw3sEuikrcYvIIJYL03YACYQOa86okD3Erk21lV
         zAulkyr2f+gShgG97UnqzhdNrdO4Ua/xG4LPoWuamUHLjChfopvT3lP+voMhWfkt75tD
         zuNwqbKJobK755qHzpRhFHg3/uXIWAqhCAsc34J2OyIwWG2lZJkVUYczpRjmhcaddgYi
         S+iJFqHmqysc2aP70TNig3aAyHEkcBamDT9NGvGMwzizmPHMQZX9kKJlZVFcn3mFIdL5
         Ioew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=31i1xoK4zj6WYEXJeZOG+hCuryOlTysPNDj29OD14Qs=;
        b=p2z91iE/sRQG2t+QnZuY67Wi4jIfCsFWx1AaHvRi4ecFlp1f8ni8ij9uJAjpL59xVX
         i4Axsb+z6eoB2i7Y8tbPHqaRogpTwwS5KdKTMKTdYOnih/v28+wRMLVE7lLIKHtM3X6X
         qA4RxSmw12n7aVzW+juTkzdYbJW0StDpILZolZ7h4TO6EtMAGmx8CFIVGYXl/wjY4vPN
         ZIfoynn1NjynSeKMJlrHrvfKeYOHE+syTI/ZxF2GYu5jGC+ufpyZYpoebuejoQxlFZcY
         mFWShgQ35w5pAogCYhNTkcqn0RBBkWdRE2Vu+CRPUgKjJ0CxkEScBPHJF+bYpO48+FDt
         t6Lg==
X-Gm-Message-State: AOAM533U+W0+gZUv7td72nxcZ0hhaXIFcYtDxzEk8irvs5GLgKBd4Q9q
        k5XOUZMRuBg/ruIOzESxhXN77Q==
X-Google-Smtp-Source: ABdhPJw4NYs7gbiGNwWpmbKhDuahGeNvec/NydYON0RX/wR9CskYqy79yYN2c7zZkDO3NcrXwh+8DA==
X-Received: by 2002:adf:f812:: with SMTP id s18mr5519018wrp.347.1634636188391;
        Tue, 19 Oct 2021 02:36:28 -0700 (PDT)
Received: from blmsp.lan ([2a02:2454:3e6:c900:5142:5fbb:5821:5dc3])
        by smtp.gmail.com with ESMTPSA id o23sm1765765wms.18.2021.10.19.02.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 02:36:28 -0700 (PDT)
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, fparent@baylibre.com,
        khilman@baylibre.com, Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v2 2/4] thermal: mediatek: Fix apmixed error message
Date:   Tue, 19 Oct 2021 11:34:02 +0200
Message-Id: <20211019093404.1913357-3-msp@baylibre.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211019093404.1913357-1-msp@baylibre.com>
References: <20211019093404.1913357-1-msp@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Seems to be a copy and paste mistake, this is the apmixed address, not
auxadc.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Fixes: a92db1c8089e (thermal: Add Mediatek thermal controller support)
---
 drivers/thermal/mtk_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
index ede94eadddda..93ee043d70da 100644
--- a/drivers/thermal/mtk_thermal.c
+++ b/drivers/thermal/mtk_thermal.c
@@ -1050,7 +1050,7 @@ static int mtk_thermal_probe(struct platform_device *pdev)
 	of_node_put(apmixedsys);
 
 	if (apmixed_phys_base == OF_BAD_ADDR) {
-		dev_err(&pdev->dev, "Can't get auxadc phys address\n");
+		dev_err(&pdev->dev, "Can't get apmixed phys address\n");
 		return -EINVAL;
 	}
 
-- 
2.33.0

