Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3AD3BE893
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jul 2021 15:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbhGGNQY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Jul 2021 09:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbhGGNQY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Jul 2021 09:16:24 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE11C061762
        for <linux-pm@vger.kernel.org>; Wed,  7 Jul 2021 06:13:43 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id t6so2989514wrm.9
        for <linux-pm@vger.kernel.org>; Wed, 07 Jul 2021 06:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h+AugMQI9wEQJZOdDBg6Ny4letwAdD9I7PJCkMpNv4o=;
        b=pefpTcaYn4Nfe7B5MTQmCN1CJH5GS2ZQQJEJpWwaYrdA258XI8yOS0Jn7HPrSxMTdL
         FtOJbxGSRDTaMTdb1cJKx1ydl6cvODQsUFYW60n8FDL5iCFVw7eFJDOwQLxl0s/rP/+K
         viHa26MESqX9mbAu60CLuQ75R1xZ5xz7J4go85vd0UNfRnZNhb2HpmfCV/sVgA+U+YIt
         VOHd3ehtKj/t5OiAADE5nceovLRIk+5M2yDaFKNdpYCbTcmFg4kfSjMs+M4ac99qdgOT
         urDawe7yYz6y+7DzGwwNbp9rOKLhH2LtI9KOlvfX0yS47RlzEMrhKOiRM1R6NQWcQYt2
         zjuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h+AugMQI9wEQJZOdDBg6Ny4letwAdD9I7PJCkMpNv4o=;
        b=VOH/49EyUL88OEOL4WPjtCEWRMFcrnpW0p1VfrNlCzKjfFrntssXhGniySACB9F/Xt
         qXM8YHz8oQb95GXIyfkUeIm6n0xDVKv1anvsvyWCs2Abu1zN/zK4f7J7fYbS99RLAeUK
         ntZWKsNrrhUCD7J7K6qR649larf0doDFkn5tM0CBDc32UsdpG/Ia1SsUrKDJ/F/anJRx
         bxOhxNEWqsjpMvTT+FmqRxLuXr8BAxLNSaD7sJHXPlhQFglBmNuih6r0YMl1lcuGRjBa
         A8guxXoNuDuy18rbQdJbgBkzg1UNkJ7lwDXxn4s01mlrsMFfHIq7CEsBXx+QlZTO0Jee
         dmlQ==
X-Gm-Message-State: AOAM5337GLvHWYP1cHkyf/ycnQe2L6pwit8PveYDF/YOfJB2puUa6UvB
        G/d109vO+yv0Uowgpcn8/wrngQ==
X-Google-Smtp-Source: ABdhPJzMkC9Mt8OgsxeFtKkKFT+EZttdMm3T3q/B0gsgzmUtD609Ly+wXMVcIQfqj131ccQIgXwSPA==
X-Received: by 2002:adf:fa4c:: with SMTP id y12mr28402844wrr.302.1625663622019;
        Wed, 07 Jul 2021 06:13:42 -0700 (PDT)
Received: from bismarck.berto.se (p4fca2710.dip0.t-ipconnect.de. [79.202.39.16])
        by smtp.googlemail.com with ESMTPSA id l20sm19233670wmq.3.2021.07.07.06.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 06:13:41 -0700 (PDT)
From:   =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH 3/3] thermal: rcar_gen3_thermal: Fix datatype for loop counter
Date:   Wed,  7 Jul 2021 15:13:06 +0200
Message-Id: <20210707131306.4098443-4-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210707131306.4098443-1-niklas.soderlund+renesas@ragnatech.se>
References: <20210707131306.4098443-1-niklas.soderlund+renesas@ragnatech.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The loop counter 'i' should be unsigned int to match struct
rcar_gen3_thermal_priv num_tscs where it's stored.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 drivers/thermal/rcar_gen3_thermal.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index a438e05e7ca7f20e..8ca4bfee7bca4122 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -423,7 +423,8 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct resource *res;
 	struct thermal_zone_device *zone;
-	int ret, i;
+	unsigned int i;
+	int ret;
 
 	/* default values if FUSEs are missing */
 	/* TODO: Read values from hardware on supported platforms */
-- 
2.32.0

