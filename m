Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B38E344FC0
	for <lists+linux-pm@lfdr.de>; Mon, 22 Mar 2021 20:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbhCVTSu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Mar 2021 15:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbhCVTSj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Mar 2021 15:18:39 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4113C061574;
        Mon, 22 Mar 2021 12:18:38 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id e9so18350416wrw.10;
        Mon, 22 Mar 2021 12:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=QRofTKWrT+jG8iMpv1k3ZL8O7IuxKzbyMIQ+0TNOyj0=;
        b=gS6jdkazdC6Tnlh77aqNirq11CTL45GPi/7YXTjbmGPK0+uzk1UQfxuH7B1pjWF4si
         xjZdDhQgkLAk+VO5uR1bMxTxMZ/mSDl+zLlppX9+9XLpfoN8wGvI05QzocvlQ27ArE8M
         hzRkZHMnsNfGNYwlxwbn4tNuG/YEZ2cXSoyUUBfzWvHjyvsragnzgCVIk8cvmcxOS1Yz
         15rp9uyYfKZJspcFpOCxY/HJBY28PvpfBm7SkMZDMISFRBPER5coQm8OeZWRwBoLXKtV
         RIdv43TQWV6ABBv9hwo2Bq4kIT5GreldCy+pjfk79tKp55YbJevHSSSaoc5XDOJHo9yQ
         axoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=QRofTKWrT+jG8iMpv1k3ZL8O7IuxKzbyMIQ+0TNOyj0=;
        b=AO7YIp4l+32DUuTmbM8Yv2jQ13xEmRVRFiTzzgj+CwUjCvPuBvlZcB59fxyPm2XmFw
         ERUHI8wQbGiVldfjaJ6Qo5qwV1sdLhaY5zgURXqjG7Xc9EHJmS7Y/qYduq1eWHo9jGvt
         pSJZyaGeyiJjXnmaEefyQL0/Psb3rpi4nrNPuEQVmiXU6ONuK7NDD2E043sJbqbM4ss9
         QXTwa0XTR1ze5/yGTQiKtAOuQsvWKfPAJshNUEzi+HRAD6d7QlXQpURyl6pkYe1jE0hU
         gDlwi27TsBa2PXr41cG6UUVuw+fV1DubLdSqY7bSx//o/V4JS3Xi4B6WVPMLnp6fkCZG
         C45w==
X-Gm-Message-State: AOAM5312VZAtKtelz7u3o26r7gG0ajtWU7+o30Lco40T+8lOVceed11r
        WF1S/6S9FbSeTRFUokz5RI8=
X-Google-Smtp-Source: ABdhPJzE2mIyB1SOimQm1h2vKXbBBeb14hfqFGiU0zqhLJPRLd7fds22RWG8xEpsb2/qEqPzD16neQ==
X-Received: by 2002:a5d:4905:: with SMTP id x5mr81701wrq.201.1616440717698;
        Mon, 22 Mar 2021 12:18:37 -0700 (PDT)
Received: from LEGION ([111.119.187.31])
        by smtp.gmail.com with ESMTPSA id d8sm22464468wrr.35.2021.03.22.12.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 12:18:37 -0700 (PDT)
Date:   Tue, 23 Mar 2021 00:18:30 +0500
From:   Muhammad Usama Anjum <musamaanjum@gmail.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>
Cc:     musamaanjum@gmail.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org,
        colin.king@canonical.com, dan.carpenter@oracle.com
Subject: [PATCH v2] thermal/core: avoid memory leak
Message-ID: <20210322191830.GA2123877@LEGION>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When memory allocation for cdev is successful but ida_simple_get fails,
branch to out_kfree_cdev label happens and cdev isn't freed. There are
also some other cases in which the memory can leak. Fix it by freeing cdev.

Signed-off-by: Muhammad Usama Anjum <musamaanjum@gmail.com>
---
Fix description

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

