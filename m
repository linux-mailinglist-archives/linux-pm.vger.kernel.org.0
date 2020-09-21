Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3D6B272AE5
	for <lists+linux-pm@lfdr.de>; Mon, 21 Sep 2020 18:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgIUQA0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Sep 2020 12:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726696AbgIUQA0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Sep 2020 12:00:26 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5F9C061755;
        Mon, 21 Sep 2020 09:00:26 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id kk9so21037pjb.2;
        Mon, 21 Sep 2020 09:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1z7DxZA1C6ZLPIw2jqF0dHu9eU0mYGkZpeGpThre5W0=;
        b=QnEDrJd5mKeVdUFr1/aPFCjEysnxjkDGtLcVK6OwRG7mQyvggpoAWaypcsnZyzfKpO
         FgQStqDqwVYGlMTtJXMgSeHoin8vnaugWMZhSg1YgzWBtGVOhxEux13fUkqpTVcfA1u3
         nay+BQDY1yy+aGoUhnIlq4XIIT3XvRuD/X/W9TY2lGqBDNpdOTl/QGyoNk8FtZ6UJYUz
         quyAgUtuYPt2UhpqTcpLDi33n6NNGDklaNHsDzcuiWXbwgk+1RsgdZEQM8XW/KlT+y0j
         d3ghTVjzQIvhuQXEmWbknfdibssdwKjsWxBZSbykdsw3LE4kjo0qJOtG+vihysGlsAzJ
         RpAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1z7DxZA1C6ZLPIw2jqF0dHu9eU0mYGkZpeGpThre5W0=;
        b=d1QcQN0AGEft2M0x2J8uAEZ7HPmXDdL659fNYEKXmk7LOXt95JF4ZNKVvt2q42T1gs
         bTLOLhT04pvPggTuBbzlsjPWD672fouhuGh4bmONtvMVRZtOPuXg7z7QDGsAVmV1tnNf
         ABjdyuP25gKTksRrCCio9D/ul88JPjuCV9ZACgx6fBrkpvpX8+ZI2ils+ScRzeI7rGsX
         nF4fO2Y/gsQz3hm+XREwgpnqqGKAVKaa1jnjpkSFuE4MDs49/hxllEq2JWxP/I5BHyxg
         3TWTIzaeL7tMY4wW1zjwcOp2So5Fr6G5WYa7QklapH6gN7CEU9k9RaOD587Xpx/cV5O8
         XR6w==
X-Gm-Message-State: AOAM531fVa9rvs1j1ErGQw7rduJWdEuSd2C+10Nik0RSiisvP4EYGXSS
        SgpyqFebXbcKfSJSEcfzpiaH5xUhWOwBw8jeLQ==
X-Google-Smtp-Source: ABdhPJzDYQ+qQl0zHfHu3dx0mPPwS7Piu9hDRkwW6ap//krle+V13oNG9arVJDRIlibdmn77a15DbA==
X-Received: by 2002:a17:90b:3cb:: with SMTP id go11mr65880pjb.152.1600704026027;
        Mon, 21 Sep 2020 09:00:26 -0700 (PDT)
Received: from localhost.localdomain ([47.242.131.39])
        by smtp.gmail.com with ESMTPSA id y13sm12554963pfr.141.2020.09.21.09.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 09:00:25 -0700 (PDT)
From:   Pujin Shi <shipujin.t@gmail.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        hankinsea@gmail.com, shipujin.t@gmail.com,
        Pujin Shi <shipj@lemote.com>
Subject: [PATCH v3] powercap: include header to fix -Wmissing-prototypes
Date:   Tue, 22 Sep 2020 00:00:08 +0800
Message-Id: <20200921160008.2162-1-shipujin.t@gmail.com>
X-Mailer: git-send-email 2.18.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Include the linux/idle_inject.h header to fix W=1 build warning:

    drivers/powercap/idle_inject.c:152:6: warning: no previous prototype for ‘idle_inject_set_duration’ [-Wmissing-prototypes]
    drivers/powercap/idle_inject.c:167:6: warning: no previous prototype for ‘idle_inject_get_duration’ [-Wmissing-prototypes]
    drivers/powercap/idle_inject.c:179:6: warning: no previous prototype for ‘idle_inject_set_latency’ [-Wmissing-prototypes]
    drivers/powercap/idle_inject.c:195:5: warning: no previous prototype for ‘idle_inject_start’ [-Wmissing-prototypes]
    drivers/powercap/idle_inject.c:227:6: warning: no previous prototype for ‘idle_inject_stop’ [-Wmissing-prototypes]
    drivers/powercap/idle_inject.c:299:28: warning: no previous prototype for ‘idle_inject_register’ [-Wmissing-prototypes]
    drivers/powercap/idle_inject.c:345:6: warning: no previous prototype for ‘idle_inject_unregister’ [-Wmissing-prototypes]

Signed-off-by: Pujin Shi <shipujin.t@gmail.com>
Signed-off-by: Pujin Shi <shipj@lemote.com>
---
 drivers/powercap/idle_inject.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/powercap/idle_inject.c b/drivers/powercap/idle_inject.c
index 4310901a074e..6e1a0043c411 100644
--- a/drivers/powercap/idle_inject.c
+++ b/drivers/powercap/idle_inject.c
@@ -43,6 +43,7 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/smpboot.h>
+#include <linux/idle_inject.h>
 
 #include <uapi/linux/sched/types.h>
 
-- 
2.25.4

