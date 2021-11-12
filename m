Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB1944E3A3
	for <lists+linux-pm@lfdr.de>; Fri, 12 Nov 2021 10:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234584AbhKLJMl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Nov 2021 04:12:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234621AbhKLJMk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Nov 2021 04:12:40 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86ACDC061767;
        Fri, 12 Nov 2021 01:09:50 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id m15so3649136pgu.11;
        Fri, 12 Nov 2021 01:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OL4QYJUzHptOBxtdYKxpiQov6ltgvIZBysaXTy9bid0=;
        b=ngCXF6ZSTvcaFDFIP/mtK0DKp/1d+0IzNH9AQ86KKHCvEUA9o0BMT5RSCryTAuqPWx
         YN/a/hBZ5sQ16yJz2yluP3/XDyo86hwxkRhhTLcQXYBBCqbmKgU5EVmQnat+JTNpizwy
         6Rej6iHucmrp8OUSMQRfe7KLfqL72r2OWba1WSnDSjyFZe6BwiEZpdN9y/6XXzvRtcew
         KI/iVg9O/siu9zREWL4TSnaGdUEFLRD62hLHiATJVrs1RRchtpw3V/9jnzinMfO4G+EY
         VxvQ7qudvB94ZCoaZZbt7QyeEhgBWKH2DHHrsSirL65DTc+3XL36xRuwG19g7WCHh1/z
         mELQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OL4QYJUzHptOBxtdYKxpiQov6ltgvIZBysaXTy9bid0=;
        b=JKYQ2zlVdruuWVmb2DEGSursd1W9v4PHAVC1Pw+OgD0g+0GS12ys9tKEQohDFHOejT
         s6aKPhFWQFlinxy6q2Cm9cUkUVqut54wYLSDfPwMXDkoVbGjzoBIZxRMC6cZb7G+FxJv
         HBCY8cTu9nLQdva8j1rM7LBCa0dLEDX01hgu3X8GlfhcX/hdujjb9zZlPDuIGBHxcirV
         gRz7D7IZG0KpiEya6h/6R7I0M/8PnITSP/ni6MhCbAlyWHwCUHWYHsyGga4m4HIQ2h5N
         4xIbKpqsU3rPcfAyZzOgpc0QbQ4FqsYnNoQV3VuuNEq6h6L8YuMXdcbhNd9s+G2V7mGp
         CWPQ==
X-Gm-Message-State: AOAM530dS4NZCXoWCwkkKMjYuAu5ZsPd0bgpREkrGARdOHcS1yzYgRhf
        Lt/Tasv40gyAaFlTESpnthE=
X-Google-Smtp-Source: ABdhPJz/4WZOhYg5nibpGGCOEU4kc1wY/olHV1QOv5CYlN4JhIkwZR5ulYHM0vDjyYdFuy4Z9ums6g==
X-Received: by 2002:a05:6a00:248b:b0:49f:9d7f:84e2 with SMTP id c11-20020a056a00248b00b0049f9d7f84e2mr12612297pfv.40.1636708190107;
        Fri, 12 Nov 2021 01:09:50 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id qe2sm2311752pjb.42.2021.11.12.01.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 01:09:49 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: ran.jianping@zte.com.cn
To:     rafael@kernel.org
Cc:     daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        ran.jianping@zte.com.cn, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] tools/thermal: remove unneeded variable
Date:   Fri, 12 Nov 2021 09:09:46 +0000
Message-Id: <20211112090946.9026-1-ran.jianping@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: ran jianping <ran.jianping@zte.com.cn>

Fix the following coccicheck review:
/tools/thermal/tmon/pid.c:57:5-8: Unneeded variable

Remove unneeded variable used to store return value.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ran jianping <ran.jianping@zte.com.cn>
---
 tools/thermal/tmon/pid.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/thermal/tmon/pid.c b/tools/thermal/tmon/pid.c
index c54edb4f630c..296f69c00c57 100644
--- a/tools/thermal/tmon/pid.c
+++ b/tools/thermal/tmon/pid.c
@@ -54,7 +54,6 @@ static double xk_1, xk_2; /* input temperature x[k-#] */
  */
 int init_thermal_controller(void)
 {
-	int ret = 0;
 
 	/* init pid params */
 	p_param.ts = ticktime;
@@ -65,7 +64,7 @@ int init_thermal_controller(void)
 
 	p_param.t_target = target_temp_user;
 
-	return ret;
+	return 0;
 }
 
 void controller_reset(void)
-- 
2.25.1

