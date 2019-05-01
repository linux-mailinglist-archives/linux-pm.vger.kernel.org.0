Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 517AE11051
	for <lists+linux-pm@lfdr.de>; Thu,  2 May 2019 01:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbfEAXmv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 May 2019 19:42:51 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:50822 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbfEAXmE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 May 2019 19:42:04 -0400
Received: by mail-it1-f194.google.com with SMTP id q14so363161itk.0;
        Wed, 01 May 2019 16:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VRrBRm+Zojzq1Xs8C9ndqMr3g130PwILxKvLl3EyBq0=;
        b=PtzVkK4bXPQLQ1KxKJjRnLy9Jzk62yNT6LaV9ugG04rl3m8c+4SNYWw9jxCrfy+emv
         6my1oaDPLEa4TqHkOv2ZgjI3dmlITKvT1dLQWcQ9qRxMs1I/UE5nI2aoI6ewOJwP2Rfj
         +FwRD7zjxU42dbvBHT4woq3VNXUvY48thJEhQvEJAvGDbjWTnRrL/cxOxU+CEdclEChl
         Ma5ohYxpAWZBdxeAaghiBmf63SLg445soW+ouBmIwwJ6Je3VA0IutwKvoZNvecRSnHbf
         rwGRkcpJ2Dkl8j6gIVSpfF8ccaavqMErUDpDqumpd9SinYUHLt3JlKai2a78VVyhtOiL
         uB+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VRrBRm+Zojzq1Xs8C9ndqMr3g130PwILxKvLl3EyBq0=;
        b=BLLiCQ6DV1ZxP4u5bkfc7hpiTppX7VYkWWgTA3aTklGhPgqW1YHA8IIYYppbm884RR
         kWQSihLKL1fbH0pAak5kh+dSb/ggdSyxW6vIttnrPBxXvbUQc30idbAcVSkq4eaHdR8I
         QK2A1IVHy/XvSKbuvu8R/fZ4SP7mWd8Z0VLFkFL+kyx7XB1q8u3ti6Wsp7wqgkMpiYUT
         RFDv5UWG4qVzzk5ne4RRluKZkQQpHJr/RZl/GL91oe6fhTh5fILlQ7Mvc+xVJcGa9kub
         PxBIPqv2M3j7atXqfYbM35009jxAS3yO0eaBOnxYYdZ1lzkN6+vl7VfIfRZrksZK7/aT
         e2yw==
X-Gm-Message-State: APjAAAXJ3RrUbWhTst+bfdP9RPSWM2+CWlJEIUYAm1YPIpfFVsTnDqd6
        gU0TiesIZHo0jOvzOS4Grn0=
X-Google-Smtp-Source: APXvYqwmIeMUoR/eZ2dqiRwYWtZe+e+IVQoxt32E9XCZdsA1OyVypjcufCzvutl6UBKmyl7kdJJoeA==
X-Received: by 2002:a05:6638:209:: with SMTP id e9mr363429jaq.22.1556754123190;
        Wed, 01 May 2019 16:42:03 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id m3sm2392507ion.69.2019.05.01.16.42.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 16:42:02 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 09/16] PM / devfreq: tegra: Avoid inconsistency of current frequency value
Date:   Thu,  2 May 2019 02:38:08 +0300
Message-Id: <20190501233815.32643-10-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190501233815.32643-1-digetx@gmail.com>
References: <20190501233815.32643-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The frequency value potentially could change in-between. It doesn't
cause any real problem at all right now, but that could change in the
future. Hence let's avoid the inconsistency.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra-devfreq.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index ea0da05cd7f2..5265d735419f 100644
--- a/drivers/devfreq/tegra-devfreq.c
+++ b/drivers/devfreq/tegra-devfreq.c
@@ -509,13 +509,15 @@ static int tegra_devfreq_get_dev_status(struct device *dev,
 {
 	struct tegra_devfreq *tegra = dev_get_drvdata(dev);
 	struct tegra_devfreq_device *actmon_dev;
+	unsigned long cur_freq;
 
-	stat->current_frequency = tegra->cur_freq * KHZ;
+	cur_freq = READ_ONCE(tegra->cur_freq);
 
 	/* To be used by the tegra governor */
 	stat->private_data = tegra;
 
 	/* The below are to be used by the other governors */
+	stat->current_frequency = cur_freq * KHZ;
 
 	actmon_dev = &tegra->devices[MCALL];
 
@@ -526,7 +528,7 @@ static int tegra_devfreq_get_dev_status(struct device *dev,
 	stat->busy_time *= 100 / BUS_SATURATION_RATIO;
 
 	/* Number of cycles in a sampling period */
-	stat->total_time = ACTMON_SAMPLING_PERIOD * tegra->cur_freq;
+	stat->total_time = ACTMON_SAMPLING_PERIOD * cur_freq;
 
 	stat->busy_time = min(stat->busy_time, stat->total_time);
 
-- 
2.21.0

