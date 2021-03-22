Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4BCF344FAD
	for <lists+linux-pm@lfdr.de>; Mon, 22 Mar 2021 20:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbhCVTMX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Mar 2021 15:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232071AbhCVTMM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Mar 2021 15:12:12 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352FDC061574;
        Mon, 22 Mar 2021 12:12:12 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id e18so18350578wrt.6;
        Mon, 22 Mar 2021 12:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=1UQ+ySphikPYmcOREZJMTjlDDCrOsVCHxDYLzztStg0=;
        b=hjnBZ4WCrjOg8NJVDbytAmHGUcSedlPsR0mtIBVSbhg58CRvPqkxgW1T94fjLTEzms
         6pMuge+Xyvjmn3ir/XkMzb1XswBPSbiM0hQxXa6a6qiTNSHTGvkpSGl80NG8OcuEiF65
         91M9CW5bqrN6H90JpyCHjldMhd4LtvvI8lOvao6jXADDm7vVyZOC88lU+VMYRf3cllTL
         UAMfbhyxrkhjGKo6teeLe36+TFMy5W2qe4BWnpWISCqs/dRwrHEUZ8NFezgAtLecOPfZ
         lVss4xenHdHJOyOTaJwpOFPWIr74azYnR13j/45r5ALlSTSwZChttRRN69P4HWgwMwYZ
         BS+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=1UQ+ySphikPYmcOREZJMTjlDDCrOsVCHxDYLzztStg0=;
        b=jIwbeQyLKqEFF4FDze3nktq9PEQYLKS1nrD0/oxWdNAQbbdVLxYJB0ZL1vXv6gwlDd
         bvPXa0W229gl7527CgJpp0O7zBza1BFlJDS+/IVha6F5hoNOLDG+o08acw13eGJ96QBs
         qrC7a5Ocn18+pKjnThjDmS0zd3nZitG4wNPlX7Xs0KcUrFxXDpsC9UVDB4pS9ZRlLpfv
         Aeh2slkUY6WuawGr3c8Nc/nvEkO+fc53Uol0YzJGdCYBLeHsH81d/LShc7KXM4HDizqf
         E+b2gUVmiLOOkXsGkQGhw11avc/nOQrHI1VI4P02bdpRf5nekUHQJlSqf7moQToc+CMA
         2BAg==
X-Gm-Message-State: AOAM531vg/KjTqI5S08N8sjXhpbPZhB0kNkmkL95qySTcwFFKR4F+7Lj
        gWBkuRjwEbUQmZU6BaHCCho=
X-Google-Smtp-Source: ABdhPJw1QG/bCvuUg7WvQYFZRj6JGePX7C9v9hJKhGvtl6+AavLkrsgURp+lYSXZ3x1l/F9LRT28qw==
X-Received: by 2002:a5d:6103:: with SMTP id v3mr38000wrt.375.1616440331027;
        Mon, 22 Mar 2021 12:12:11 -0700 (PDT)
Received: from LEGION ([111.119.187.31])
        by smtp.gmail.com with ESMTPSA id c16sm25151135wrs.81.2021.03.22.12.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 12:12:10 -0700 (PDT)
Date:   Tue, 23 Mar 2021 00:12:04 +0500
From:   Muhammad Usama Anjum <musamaanjum@gmail.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>
Cc:     musamaanjum@gmail.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        colin.king@canonical.com, dan.carpenter@oracle.com
Subject: [PATCH] thermal/core: avoid memory leak
Message-ID: <20210322191204.GA2122573@LEGION>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When memory allocation for cdev is successful but ida_simple_get fails,
branch to out_kfree_cdev label happens and cdev isn't freed. There are
other some other branches in which the memory can leaked. Fix it by
freeing cdev.

Signed-off-by: Muhammad Usama Anjum <musamaanjum@gmail.com>
---
 drivers/thermal/thermal_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index c8d4010940ef..3566fd291399 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1017,6 +1017,7 @@ __thermal_cooling_device_register(struct device_node *np,
 out_ida_remove:
 	ida_simple_remove(&thermal_cdev_ida, cdev->id);
 out_kfree_cdev:
+	kfree(cdev);
 	return ERR_PTR(ret);
 }
 
-- 
2.25.1

