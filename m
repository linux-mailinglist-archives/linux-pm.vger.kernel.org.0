Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D197BC649
	for <lists+linux-pm@lfdr.de>; Sat,  7 Oct 2023 10:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343679AbjJGI7s (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 7 Oct 2023 04:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343643AbjJGI7r (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 7 Oct 2023 04:59:47 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5CD1B9
        for <linux-pm@vger.kernel.org>; Sat,  7 Oct 2023 01:59:44 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-406402933edso26201835e9.2
        for <linux-pm@vger.kernel.org>; Sat, 07 Oct 2023 01:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696669183; x=1697273983; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DRLCAfYAsLg0hm9u7tG016t4o8+WS7/bFdh06s3Y9Mg=;
        b=V9FGIAf4J2wDbfXsMJRD3JMiy6hpGauoLf4RrrzpdbCYUnqdBJQAkbDE4ShK4DT0PL
         dWpTnU5LukqlzZ8pzYOHc6zI8jBuYKlmKSUplKDUi5WYZJiGxm9utMGWR8/3/lyECGct
         22ciW+ebCTzcmwObpkVr4qUqQgZ6IuLzmozetK/pKj8NAdWSEbPHIJn1n4sB63kABdVi
         CrksVS21BWfDn9DeP3oFyvovBHHbEhLkkvSO53Zv+Q8pcBCDdTG0tKgWoQuq/wX8MX64
         23e9vP2q+aWFNIjYr8hPMv/Pli62EJ76mQMGyH1UZaVzxxxubusKexO1B5bH5wlG12zk
         H9cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696669183; x=1697273983;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DRLCAfYAsLg0hm9u7tG016t4o8+WS7/bFdh06s3Y9Mg=;
        b=p7RshZBRnb2bGno1/m+9UYRzUHr1yy9P0wSn2qbqlV4sQi1oPM/ioiD3KlPedcl23w
         7mvTBpfAMPUkBAna8iOCCxRek3hBzoHj4TpD2SYjcU2hzmQikfbUOrN8ToArEpF6kfjZ
         8O2BwgjhYvhkmUyfm/BUI+PynjFExqeKskckOYvVDnc6wPMS5Q1+Z7UOuGYIJdiI4w2T
         6SlDGDWKh6kPUjpHsRLAKPjmAORno0w8Ezqj1RdB7O+LHvYuF7JhEu9xAMSgsG4n/g3G
         O0fGnGUgyz0vx6GyOYKiVPi0gA6Hs78RdPKN0Ag2WMVVxDAHRU88H7Op6bmrZJ/ME4qB
         uw8Q==
X-Gm-Message-State: AOJu0YyfK/vO3L+ZTxwedsb+M/GFPgC+MtolOw3Zfmxi3/78ZMcdep3b
        UxKonGfu8g5anoFuLd7ac5V55w==
X-Google-Smtp-Source: AGHT+IHi9iFgj3uEg7h3dId9e48yuQPWx5PVBJ83rE3h31iWwkuzFGdpca1Qra5vQ7YEmnMTA/pYfw==
X-Received: by 2002:a05:600c:2299:b0:3fe:1232:93fa with SMTP id 25-20020a05600c229900b003fe123293famr9100738wmf.22.1696669183168;
        Sat, 07 Oct 2023 01:59:43 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id q15-20020a7bce8f000000b00405391f485fsm5591798wmj.41.2023.10.07.01.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 01:59:42 -0700 (PDT)
Date:   Sat, 7 Oct 2023 11:59:39 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Thomas Sujith <sujith.thomas@intel.com>,
        linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] thermal: core: prevent potential string overflow
Message-ID: <514ef814-458d-4421-b93d-2d30bdc4a1e7@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The dev->id value comes from ida_alloc() so it's a number between zero
and INT_MAX.  If it's too high then these sprintf()s will overflow.

Fixes: 203d3d4aa482 ("the generic thermal sysfs driver")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/thermal/thermal_core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 45d0aa0b69b7..61f0b5a3b00c 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -681,7 +681,8 @@ int thermal_bind_cdev_to_trip(struct thermal_zone_device *tz,
 	if (result)
 		goto release_ida;
 
-	sprintf(dev->attr_name, "cdev%d_trip_point", dev->id);
+	snprintf(dev->attr_name, sizeof(dev->attr_name), "cdev%d_trip_point",
+		 dev->id);
 	sysfs_attr_init(&dev->attr.attr);
 	dev->attr.attr.name = dev->attr_name;
 	dev->attr.attr.mode = 0444;
@@ -690,7 +691,8 @@ int thermal_bind_cdev_to_trip(struct thermal_zone_device *tz,
 	if (result)
 		goto remove_symbol_link;
 
-	sprintf(dev->weight_attr_name, "cdev%d_weight", dev->id);
+	snprintf(dev->weight_attr_name, sizeof(dev->weight_attr_name),
+		 "cdev%d_weight", dev->id);
 	sysfs_attr_init(&dev->weight_attr.attr);
 	dev->weight_attr.attr.name = dev->weight_attr_name;
 	dev->weight_attr.attr.mode = S_IWUSR | S_IRUGO;
-- 
2.39.2

