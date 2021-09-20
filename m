Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69C0A412AB5
	for <lists+linux-pm@lfdr.de>; Tue, 21 Sep 2021 03:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbhIUB5M (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Sep 2021 21:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232840AbhIUBk3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Sep 2021 21:40:29 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5404C06B8E1;
        Mon, 20 Sep 2021 13:39:02 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id i25so73453868lfg.6;
        Mon, 20 Sep 2021 13:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MPnBrzDXyHGbYObQMGIu6DVpYK5ELubwD5xdOaGONpM=;
        b=OFMFf8u3LE2k6ugWaOUBuWew2j28WlYs7DKwg2HqtuEOobQ13Af/ICzNIJwjLEabBE
         /8n4iWuD5IC6Jokk95xIAB6I0HrUryTP6EmrIxDscV+WxqjL6cFokkrBqAv5cNwJ8J4F
         esNE20J5cKzOClUOWLUPVXqFsXeEpgneM0yOKedSJuykXw6dNJzQSHrQfvcOPpH+Zn/N
         CXfdfk1FR9w+Qh9A/Cd1nhtDcMayxVGpTceVAgCMCMFVXV68knDd6JRb98Ve0ybVsu8A
         sgzJk3pAMCVWGua+QQznwCpWuNtSnRtZvhy055yLTjt8qulq7x7Fq/B0O9DU3SUvM6eE
         IznA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MPnBrzDXyHGbYObQMGIu6DVpYK5ELubwD5xdOaGONpM=;
        b=YDxOJbLdp+81Yrc9D9t9zEYmesf6y3qqxU6ucEBW4gupyckUq/Rk0NdtxRtqLWlv31
         M7+vrq9xXCvuejC9vK5cOCkbibt02EDjFks+AZhvtmqHZexjQQI4qYj9MBnosikUypuN
         NHbVSRib0d6Bskv884bZWt9/6Wk+xzmCR6A39NJc5gurDQkeWAkiDS8ru80Q9F2FT0V6
         k+wW4D8PVmnp6GyfZ5SmAt+M+luOKHrZuOycD1o7Upuep97eeOCMrZhLxSrgg5tH1Win
         nC2K7/CyzGMf/QAVyo6H2pjWdRgiULgHAxX0TJuM2rtAIk9ZLl+fMVaeFyn/P2OIiZnN
         tbtw==
X-Gm-Message-State: AOAM531lPvluJlc4/sz3+urF2+voI9QvJA2UyzH2DssPNOl3yiT4xIeG
        8VfbGvKg1fJOyubTynUTDcs=
X-Google-Smtp-Source: ABdhPJzuG2NmAlbP97MYYaBE4Br6JXUTsaB/PsNpHNBy+aO+FamgHEwqXNzJfaGBUZ5NN0ORYwlbGA==
X-Received: by 2002:a05:651c:1548:: with SMTP id y8mr1131446ljp.17.1632170339693;
        Mon, 20 Sep 2021 13:38:59 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-228-193.NA.cust.bahnhof.se. [98.128.228.193])
        by smtp.gmail.com with ESMTPSA id z21sm1883109ljh.114.2021.09.20.13.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 13:38:59 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Talel Shenhar <talel@amazon.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>, Amit Kucheria <amitk@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH] thermal: thermal_mmio: Constify static struct thermal_mmio_ops
Date:   Mon, 20 Sep 2021 22:38:49 +0200
Message-Id: <20210920203849.32136-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The only usage of thermal_mmio_ops is to pass its address to
devm_thermal_zone_of_sensor_register(), which has a pointer to const
struct thermal_zone_of_device_ops as argument. Make it const to allow
the compiler to put it in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/thermal/thermal_mmio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_mmio.c b/drivers/thermal/thermal_mmio.c
index ded1dd0d4ef7..360b0dfdc3b0 100644
--- a/drivers/thermal/thermal_mmio.c
+++ b/drivers/thermal/thermal_mmio.c
@@ -34,7 +34,7 @@ static int thermal_mmio_get_temperature(void *private, int *temp)
 	return 0;
 }
 
-static struct thermal_zone_of_device_ops thermal_mmio_ops = {
+static const struct thermal_zone_of_device_ops thermal_mmio_ops = {
 	.get_temp = thermal_mmio_get_temperature,
 };
 
-- 
2.33.0

