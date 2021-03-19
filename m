Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41E503426C6
	for <lists+linux-pm@lfdr.de>; Fri, 19 Mar 2021 21:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbhCSUYt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Mar 2021 16:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbhCSUYk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Mar 2021 16:24:40 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C133C06175F
        for <linux-pm@vger.kernel.org>; Fri, 19 Mar 2021 13:24:40 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id k8so10338188wrc.3
        for <linux-pm@vger.kernel.org>; Fri, 19 Mar 2021 13:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=To100haQPKOBjLlAqeL1HTpqN/JRH0WmiZY+PGrzAJo=;
        b=yc+n7UFNfb9dxeA2Qs7dVY+hwA4gBRhOjbL7I+oh0myXqdqg8bt2XRwiG+ZlOZ++Lb
         fPKZ5q/srgACP5q5a+EToVqcFt6sZJrubgCPEVmUvO7LKiEAUcqmunaouDvdvZX4x9uL
         6KonOLsVOZntozK9QDpcpbv7/ij5wo+W2G73pxviWQohfnfxtXQeyIRJ/P1eGikkjDG+
         VSe2QguDwT4vvHNG9lIlOzYNVQDY3ibzenaCDHQI1pKSxDba6g2uvbxXAOFD+xOmnCYX
         T0T2FJZwIen0BYPlYAh0Iy0P1rIsQaWyI30b8Uo/OzbMfog0X6bfywZuTxX1MGBYCDvl
         BAvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=To100haQPKOBjLlAqeL1HTpqN/JRH0WmiZY+PGrzAJo=;
        b=FuDrX37MSTkjAvN2YV9nsDLisrmByUiEHgEwz7OIFqH40sO6o+xq6ED+f18n6nqOqr
         4z9l7s1m/zND90hsx6JsakFGjSTITyleU8iiUVC8g6GVWZstIqiL4x5MRDh/O8zNzVBM
         Kjm4rj5YwObaqFsL9mfYpkk4plEitc30sXM+N1E7hIanx4KO3AB9CvVF9s846L0wD4we
         KEY8QHA/ILL00J2le06WygELVaK/qzBOiSa+Us2F0OLsH1ahR2HrxH/mqVUccSsJmZcA
         Ck6ZEz+2YOZSIn6Gtk3Qo3FwPEbJUae10aQ/Mk5BBjnRYwzJolYyVCa6G1ix/mGz1eQG
         Eudw==
X-Gm-Message-State: AOAM5317j0HY981Ad3XJOTw3SZwmjzfFpj42cxmoK5g/MIrBEv6CUd7L
        IGhkr0vQ6FePmXXq3brOMPZXpw==
X-Google-Smtp-Source: ABdhPJxet7YkdkkkS6MuolVtx/s83lKAi59VjrMyJSiRyZF/aMaqkn0TJVeLhb5r49OQif7vHyAJCA==
X-Received: by 2002:adf:e805:: with SMTP id o5mr6527004wrm.196.1616185479092;
        Fri, 19 Mar 2021 13:24:39 -0700 (PDT)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:ddd7:1eb:a66:7a85])
        by smtp.gmail.com with ESMTPSA id y10sm9796122wrl.19.2021.03.19.13.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 13:24:38 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org
Cc:     kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        linux-pm@vger.kernel.org (open list:THERMAL),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] thermal/drivers/devfreq_cooling: Fix wrong return on error path
Date:   Fri, 19 Mar 2021 21:24:23 +0100
Message-Id: <20210319202424.890968-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210317143126.GC2087@kadam>
References: <20210317143126.GC2087@kadam>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following error is reported by kbuild:

 smatch warnings:
 drivers/thermal/devfreq_cooling.c:433 of_devfreq_cooling_register_power() warn: passing zero to 'ERR_PTR'

Fix the error code by the setting the 'err' variable instead of 'cdev'.

Fixes: f8d354e821b2 ("thermal/drivers/devfreq_cooling: Use device name instead of auto-numbering")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/devfreq_cooling.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
index fb250ac16f50..3a788ac4f525 100644
--- a/drivers/thermal/devfreq_cooling.c
+++ b/drivers/thermal/devfreq_cooling.c
@@ -402,7 +402,7 @@ of_devfreq_cooling_register_power(struct device_node *np, struct devfreq *df,
 	if (err < 0)
 		goto free_table;
 
-	cdev = ERR_PTR(-ENOMEM);
+	err = -ENOMEM;
 	name = kasprintf(GFP_KERNEL, "devfreq-%s", dev_name(dev));
 	if (!name)
 		goto remove_qos_req;
-- 
2.25.1

