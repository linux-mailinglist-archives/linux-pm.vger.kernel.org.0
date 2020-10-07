Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 536B32860A6
	for <lists+linux-pm@lfdr.de>; Wed,  7 Oct 2020 15:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728570AbgJGNyz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Oct 2020 09:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728536AbgJGNyz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Oct 2020 09:54:55 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E64C0613D9
        for <linux-pm@vger.kernel.org>; Wed,  7 Oct 2020 06:54:49 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id a7so1308574lfk.9
        for <linux-pm@vger.kernel.org>; Wed, 07 Oct 2020 06:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SyrNRlrzgocwFtm4m1D+vgyjZWlJZcz7p/Dz+/oWD3I=;
        b=uFtBURH+GBLaevo8g6cPWDqH7zEiO6ttieUedSBQrZea4Hlco0FLbEc5lMRvQv5Mo4
         haQjIcg8xsZJzUID+l/b03Y3RmVN4a75yZaxf9dp6SvF7Be7dfm1R1LML3adXoh1Cag2
         SZb2fL7/Hiy5QUvkDvRwLjcWeqPO1MrK3d6Ou/re6j71emqaPi+OVNPofZBA7drL+na/
         ac91wolwQrvZd1zs4ay9ERrSLhW14kiaGK7QnjQRQn0Xp6C5XxFFYHxk5QhUh8lZ2qk8
         wiDbobfDJjpr/Wx18Ne8HtD9SZW+d/KT6Uy1p/oyv4V5Jk/YIhsYAXU3RbI0N/Zvc6mc
         kRhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SyrNRlrzgocwFtm4m1D+vgyjZWlJZcz7p/Dz+/oWD3I=;
        b=WACc+zc4aV13vKrbJ6qyZDQ6weib2+Mtb6a9dpi354JK9iPIIV04tfSo2+3j9VKk7F
         m9grrXj92V8Xdmk2mdXhFhGInt2d4pF6o0lldcDXJM9yGD4VtTCVIQFWpcxrrcqPUjfA
         RWGIgGEk1I4iLgccAi7koLrRAEdSC1S73sX3TN2fN3TW7RtHztVCkqi16PTev26vB80U
         C78JLckjQsR12Zqn1ih15uorKnctkKyUR0GHK6HHXY8PW33iOmNJ/BM8TmxXQiVwKJlF
         j3ZXY0Vo+0bIUmr6YefMk4cSUPHyva52TIqLn06CLh2rQJiHikkvcVvmjA6HmyaoK49n
         PVQQ==
X-Gm-Message-State: AOAM531SRyanNE+6+bRmOw1eGU2E/fLhsPN7ZCpGuNrMjy/95HNhKFYh
        psiHYdKpU68uKslbfmtdHwiOIw==
X-Google-Smtp-Source: ABdhPJzbO3zNETMnpVpRvluAZ6FR3Gy1w+BTC/UFV5bpDYMWQfx0bDAXQGzVWG9SInalGLksvjGkBA==
X-Received: by 2002:a05:6512:3702:: with SMTP id z2mr926943lfr.35.1602078887854;
        Wed, 07 Oct 2020 06:54:47 -0700 (PDT)
Received: from localhost.localdomain ([188.162.65.250])
        by smtp.gmail.com with ESMTPSA id n3sm339768lfq.274.2020.10.07.06.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 06:54:47 -0700 (PDT)
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
        Jishnu Prakash <jprakash@qti.qualcomm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v7 04/10] iio: adc: qcom-vadc-common: use fixp_linear_interpolate
Date:   Wed,  7 Oct 2020 16:54:27 +0300
Message-Id: <20201007135433.1041979-5-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201007135433.1041979-1-dmitry.baryshkov@linaro.org>
References: <20201007135433.1041979-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

