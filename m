Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F274D42DAF1
	for <lists+linux-pm@lfdr.de>; Thu, 14 Oct 2021 15:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbhJNN7Z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Oct 2021 09:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbhJNN7Y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Oct 2021 09:59:24 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C748C061764
        for <linux-pm@vger.kernel.org>; Thu, 14 Oct 2021 06:57:14 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id y3so19905771wrl.1
        for <linux-pm@vger.kernel.org>; Thu, 14 Oct 2021 06:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=31i1xoK4zj6WYEXJeZOG+hCuryOlTysPNDj29OD14Qs=;
        b=AbHERgV7hhK7Q6TsIVXDya02ZczmFNkqDkzMRSz+b+mHRNIq6O6J/3YIaczr+Yo5w4
         L9JZQ8vTipg5kViM+Gi+d62zIR9O0Nze896kdfMcAS5x2Z3MCeiUka1h8f8/EO4VfAoP
         Y1SIkDm6VKBF91hvtGbAzn7tK6qAo4btprN1Zf7wqxYeAv25KVG9GgCM9bH3QPOk6z84
         dtoqxU3Kj+yA8e/bObrV3McYIyICqYUULyvr7+Y0N7uKnahrTECmyrXw+uwe/YpjNldC
         Ur/IA7QCkYjR/X8Ta/9ylJhKw02phSqKkPvmkg+24El7J8HWAHSoFMiUHcNlDV2ncKhd
         2j3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=31i1xoK4zj6WYEXJeZOG+hCuryOlTysPNDj29OD14Qs=;
        b=noFN5JbLx5eXfmeHbbAB2FvEjL2Qq4K1YVhtaPn/03Ds7RVQS3FCHydgQZD2TMTp5o
         A0oFBO0sgsUtS/5j5Jkh/oKroYEhJMAnO+oP2/wMNsxPmAq3rQRi1oEiruIKAmsgfRzQ
         9CAQ48b/5OLcodDfLuLHAJOBTbqZW79/ksigFfJi/RR6YZwyoYrVZSsLJRys6EsSvV+M
         OHfK2mhpklDfhkqApl8KIUmcqB9T2PEonAdRQQzGQE+mtFvTZQAbjhnhteSBB9sH3W39
         oS0xmTPGq0YJJ/0WL5GyTgmjTdY945WGeMpOisGnIHOtz5B1NeQeJNI9yBIOMz7J+qw+
         C57w==
X-Gm-Message-State: AOAM530lvLuFYz5IWDt6yVctuLDQqMwiHSfPBPmSCofNM8E891EnCxBf
        4DpWTF0jQz40YySqb69FdQZTbQ==
X-Google-Smtp-Source: ABdhPJzovFHxnVhnPJn8Z93ko4jfsXuTJHegbHkAVGuJQykKzBnhuZgk+oxF6vDUOvuqwSsAAyi9Bw==
X-Received: by 2002:a05:600c:21cc:: with SMTP id x12mr11267492wmj.8.1634219833159;
        Thu, 14 Oct 2021 06:57:13 -0700 (PDT)
Received: from blmsp.lan ([2a02:2454:3e6:c900::97e])
        by smtp.gmail.com with ESMTPSA id d1sm2596480wrr.72.2021.10.14.06.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 06:57:12 -0700 (PDT)
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, fparent@baylibre.com,
        khilman@baylibre.com, Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH 2/3] thermal: mediatek: Fix apmixed error message
Date:   Thu, 14 Oct 2021 15:56:35 +0200
Message-Id: <20211014135636.3644166-3-msp@baylibre.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211014135636.3644166-1-msp@baylibre.com>
References: <20211014135636.3644166-1-msp@baylibre.com>
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

