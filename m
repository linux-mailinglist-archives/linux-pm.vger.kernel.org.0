Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC8A2263483
	for <lists+linux-pm@lfdr.de>; Wed,  9 Sep 2020 19:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729135AbgIIRVo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Sep 2020 13:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730064AbgIIPXP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Sep 2020 11:23:15 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86721C061242
        for <linux-pm@vger.kernel.org>; Wed,  9 Sep 2020 07:43:14 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id a15so3921518ljk.2
        for <linux-pm@vger.kernel.org>; Wed, 09 Sep 2020 07:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SyrNRlrzgocwFtm4m1D+vgyjZWlJZcz7p/Dz+/oWD3I=;
        b=sOj1ib2kl2SlVlUTM5hhtz7BMqvh2WSXwUCwvheygvKndh2ngHXDqcKNoc7mj8tYZk
         01QtqZ0bxAWLEZ4WudeP6XKfC77xSfbEuYiJKkkb4u5AvEE7P6POu5pYSNWs8+yKaxd1
         GfGyBAa6JywuElKfh3ASexqtPzVXubBXKO+KNhas2UbpFdGmVoNm16aURJLVm5M40p/p
         BUwT0qHygUiWcMVE03rPHC0/8QyZe2jyWehhW1WILAYmQFQcKv8Xc9MnhBNz5ok+ftQh
         T4K9KDD0uYhSoIAa0AcWpgL+oOXEklu53fwye3Tdx6FLAYax0gpgboJMl6zeIT2h2WF0
         fIDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SyrNRlrzgocwFtm4m1D+vgyjZWlJZcz7p/Dz+/oWD3I=;
        b=AR0mNeBW8iXoQFSrSZwA7fuboDts8jOeDTU5C+jqERUuO+Zk+EPTmBEwVpXhJ643AJ
         2KfJxKUxCtEnFSoTdy9hv7Ofp+tvZBxWyxoPd0Dvnz9fk4nLl1jBJ2dfRjUQaS3nutEy
         wHI4ucd0mpRGnYC7PIqIOsCeKv2fg6C7h9qUcWVqVFU7dmM8XwxzhHZr6mo9wyo9B5Pq
         sIkx2R7g02+9w6tKrhvTIxSYNW7gzxXAmD87pqkE1dm/cx7LibffMvJgcFzNC7ocUJ1z
         aE9trk3N99DilR0k3J4ubac3FmXQOsKWpIL1gJrnvn71UVz2PC6wFumR6BZ67gz6xbwH
         D0MQ==
X-Gm-Message-State: AOAM532lDtgyd43u5KtRj+bfURwr3B1JP+yU0fc1yXyQF7g7f4MpSe2/
        3RZsrzIS/YDnUtAVUTD4isn3dQ==
X-Google-Smtp-Source: ABdhPJw8HdhOumlwdp8/MgSIGzxjxCxBSs2n81KNfPpTNEZiW+9kSOqYfdiVoXJpyEyBoqTxdNCL4g==
X-Received: by 2002:a2e:8798:: with SMTP id n24mr1956427lji.373.1599662592137;
        Wed, 09 Sep 2020 07:43:12 -0700 (PDT)
Received: from eriador.lan ([188.162.64.155])
        by smtp.gmail.com with ESMTPSA id t12sm621665lfk.26.2020.09.09.07.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 07:43:11 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 05/10] iio: adc: qcom-vadc-common: use fixp_linear_interpolate
Date:   Wed,  9 Sep 2020 17:42:43 +0300
Message-Id: <20200909144248.54327-6-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200909144248.54327-1-dmitry.baryshkov@linaro.org>
References: <20200909144248.54327-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use new function fixp_linear_interpolate() instead of hand-coding the
linear interpolation.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/qcom-vadc-common.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/qcom-vadc-common.c b/drivers/iio/adc/qcom-vadc-common.c
index d11f3343ad52..40d77b3af1bb 100644
--- a/drivers/iio/adc/qcom-vadc-common.c
+++ b/drivers/iio/adc/qcom-vadc-common.c
@@ -2,6 +2,7 @@
 #include <linux/bug.h>
 #include <linux/kernel.h>
 #include <linux/bitops.h>
+#include <linux/fixp-arith.h>
 #include <linux/math64.h>
 #include <linux/log2.h>
 #include <linux/err.h>
@@ -368,10 +369,9 @@ static int qcom_vadc_map_voltage_temp(const struct vadc_map_pt *pts,
 	} else {
 		/* result is between search_index and search_index-1 */
 		/* interpolate linearly */
-		*output = (((s32)((pts[i].y - pts[i - 1].y) *
-			(input - pts[i - 1].x)) /
-			(pts[i].x - pts[i - 1].x)) +
-			pts[i - 1].y);
+		*output = fixp_linear_interpolate(pts[i - 1].x, pts[i - 1].y,
+						  pts[i].x, pts[i].y,
+						  input);
 	}
 
 	return 0;
-- 
2.28.0

