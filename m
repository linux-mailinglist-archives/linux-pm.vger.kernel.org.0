Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88A29367F9B
	for <lists+linux-pm@lfdr.de>; Thu, 22 Apr 2021 13:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236070AbhDVLfp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Apr 2021 07:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbhDVLfo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Apr 2021 07:35:44 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE77C06174A
        for <linux-pm@vger.kernel.org>; Thu, 22 Apr 2021 04:35:09 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id c15so35505420wro.13
        for <linux-pm@vger.kernel.org>; Thu, 22 Apr 2021 04:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nesQIfMK+IRA17P6tXXIkpXFOP6516pK+CAAmZXiyyQ=;
        b=RhrVbOBr+ZTTZC+LRLoruKwjZQua0h/acVoW8lowAFUm8W5rEJoG/dfoHoWhb7uDtI
         AcqAzJyW9K4jtEvSpb3omnXZyrhFCUf0bDScialHScz3A3olefuHdblE81bLIvnyldiz
         ZLsNSuu1vXzo4Y5VPGI5dLRWEnBhbWU4B40epR0mdVf2/wMmnZBGy5bVqnMw0oaJatxN
         PF06h6EvcN/FQA7QtA42pX5cYZQLY5OHANW97/uTQs3ssu8td7zj/4Vf/HIrbZyVQ0OW
         lWazLWPKaLfZaV6hOGlTKpv/hz6vFFqH9wpSXd878rubD0Kbeykkq2uvCtQkVElEF1Ny
         /ZRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nesQIfMK+IRA17P6tXXIkpXFOP6516pK+CAAmZXiyyQ=;
        b=O7k8NAlvZOvdFC8SkIUmyw3xyDC57+6B/xeXkgAXvQ5m2S7b6TCMwqqkIk6itGlLov
         uii5cNAmxQBbT6Mda0NSu0yN7RrWQQrCp2cgeC6XLzgwzFteqrGxq4qOEwaRJAov9QNb
         xn8cfI41lhxcI4QKxpgiOQN2pFJQCUCCbaXYAP726IedHYukc+phm4HuFNo7ldNARApQ
         LjLOls58gqktYsGwPQE8omiLsRK+cJ58igaxzeORmPghTA3kAx9rT90IkerWWBX3IL3x
         8A30+iybjmeT6AaMdv9UsuPE7NdHUR9WpYCQcdagQGjiQdSDxKQpfhXRfyZC6ZSeQ1IN
         UT+A==
X-Gm-Message-State: AOAM5302SDaqWTGtbUfzgBFDQpTI6qgZ2X75fVS9CcvrzZ7cohZq8EkH
        vkC814rJT5pk36bUrTBBOYwdGQ==
X-Google-Smtp-Source: ABdhPJz/kbxkcLITLyWEZrr8GDI8FPMwCbwPkj6TzcuC+3PHfDz7qgMR6PolesBs2ZD1ZRV/pWxlSw==
X-Received: by 2002:adf:f80c:: with SMTP id s12mr3657463wrp.115.1619091308380;
        Thu, 22 Apr 2021 04:35:08 -0700 (PDT)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:e88d:2580:c20:b786])
        by smtp.gmail.com with ESMTPSA id u6sm3237890wml.23.2021.04.22.04.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 04:35:07 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org
Cc:     Zhang Rui <rui.zhang@intel.com>, Amit Kucheria <amitk@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        dingsenjie <dingsenjie@yulong.com>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        linux-pm@vger.kernel.org (open list:THERMAL),
        linux-tegra@vger.kernel.org (open list:TEGRA ARCHITECTURE SUPPORT),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] thermal/drivers/tegra: Remove a pointless call get_thermal_instance()
Date:   Thu, 22 Apr 2021 13:34:55 +0200
Message-Id: <20210422113457.51578-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The driver is calling get_thermal_instance() but the lookup can happen
directly. Remove the call to get_thermal_instance().

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/tegra/soctherm.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index 8e303e9d1dc0..355fdf32cbc1 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -621,9 +621,8 @@ static int tegra_thermctl_set_trip_temp(void *data, int trip, int temp)
 				continue;
 
 			cdev = ts->throt_cfgs[i].cdev;
-			if (get_thermal_instance(tz, cdev, trip))
-				stc = find_throttle_cfg_by_name(ts, cdev->type);
-			else
+			stc = find_throttle_cfg_by_name(ts, cdev->type);
+			if (!stc)
 				continue;
 
 			return throttrip_program(dev, sg, stc, temp);
@@ -806,9 +805,8 @@ static int tegra_soctherm_set_hwtrips(struct device *dev,
 			continue;
 
 		cdev = ts->throt_cfgs[i].cdev;
-		if (get_thermal_instance(tz, cdev, trip))
-			stc = find_throttle_cfg_by_name(ts, cdev->type);
-		else
+		stc = find_throttle_cfg_by_name(ts, cdev->type);
+		if (!stc)
 			continue;
 
 		ret = throttrip_program(dev, sg, stc, temperature);
-- 
2.25.1

