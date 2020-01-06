Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B851A131708
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jan 2020 18:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgAFRqo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Jan 2020 12:46:44 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38107 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgAFRqn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Jan 2020 12:46:43 -0500
Received: by mail-pg1-f195.google.com with SMTP id a33so27189278pgm.5;
        Mon, 06 Jan 2020 09:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=YdPHerSYFOJLKYefQHipXAmsHXvXtkbfyGcWcsin/Eo=;
        b=t0vgrTSVmmj/57ZBr/Sm79BsA7lylrWcfhlGn3rqkCJQCiNewUgV8qMRVWd8rd+egl
         y4YVUkO7FONNsn1TClHXBiMGXvlSzd8EjZHCxDyfZ8/ypJCvTGSy8kp4u/luDiWgNpte
         /xuomSpMzKHv0y+ZJvGamupdnU4OhCIJqHfkhjDpnrsSs1rV4bksqvmVVGeldtCqIFk/
         819/hKDzWB8e247vq3PjjUkLt61zIYtkRKmSMFad+FWT6x6C6Jcsl1fq+RH6GheqS9+k
         1403NTO1gKuKwNcYpL902uwwL6oQ+rariS58bn2hsAqJ3rxjl1Eqtojz7ewaRqFZIAVH
         LL/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YdPHerSYFOJLKYefQHipXAmsHXvXtkbfyGcWcsin/Eo=;
        b=pOwWaKC7mQ2CfgaJItXKNrop3Muuhm0LdQvXWhraQrgUDnNhhFkNOqmbpcn0rUcn2v
         +TM8LNPZSAS37Rlyp/p7ltcQG7DGsWWzh2FYTra6jSujrxFFLAfhWx8DfLSlf2mQeFOU
         eDV/yman44bQaqOxgb350jQhcrY8CjMM8BRbFzO9TRnSwOiIIxwNdEXD9Tbq6TgvVR6v
         QE3RhAkEUgY5aI3iKNKeV69xz31BdZ9gxMvGb4+xv++MrK8ZbUo0mDwAMKrvlbdAFXdB
         gQmp0bs2ykyVTVthrkiOfRvdk6bGOHEbIhrQHirUYNj3gHa9Yn/i5HVuDbmEQlmjhkTz
         Ablg==
X-Gm-Message-State: APjAAAXpyVoc7RK98S0L3q8XbjbZuWy7KIm1JR8oyMTq7q/26/RM4TBj
        Up1QFblKZuymomVBqlb7Z7o=
X-Google-Smtp-Source: APXvYqwNzPNo38qKaDE4TWjCFQ11EAzeBDsfFL07gxRaNNMnBA7f1Wmk2ubLY9y2gRba8Y9FzmQz5w==
X-Received: by 2002:aa7:874a:: with SMTP id g10mr91607578pfo.205.1578332803309;
        Mon, 06 Jan 2020 09:46:43 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id z4sm25051105pjn.29.2020.01.06.09.46.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Jan 2020 09:46:42 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, mripard@kernel.org,
        wens@csie.org, anarsoul@gmail.com, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, amit.kucheria@verdurent.com,
        megous@megous.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v2 1/2] thermal: sun8i: fix r40 ths number
Date:   Mon,  6 Jan 2020 17:46:38 +0000
Message-Id: <20200106174639.20862-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

According to the spec, r40 has 2 thermal sensors.
Sensor0 located in the CPU, another in the GPU.

Fixes: 730a45ccd9322 ("thermal/drivers/sun8i: Add thermal driver for H6/H5/H3/A64/A83T/R40")
Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Tested-by: Corentin Labbe <clabbe.montjoie@gmail.com>
Tested-on: sun8i-r40-bananapi-m2-ultra
---
 drivers/thermal/sun8i_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
index 23a5f4aa4be4..c5661d7c3e20 100644
--- a/drivers/thermal/sun8i_thermal.c
+++ b/drivers/thermal/sun8i_thermal.c
@@ -565,7 +565,7 @@ static const struct ths_thermal_chip sun8i_h3_ths = {
 };
 
 static const struct ths_thermal_chip sun8i_r40_ths = {
-	.sensor_num = 3,
+	.sensor_num = 2,
 	.offset = 251086,
 	.scale = 1130,
 	.has_mod_clk = true,
-- 
2.17.1

