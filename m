Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13F9B28CC5
	for <lists+linux-pm@lfdr.de>; Thu, 23 May 2019 23:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387709AbfEWV7C (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 May 2019 17:59:02 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33173 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387616AbfEWV7B (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 May 2019 17:59:01 -0400
Received: by mail-qt1-f193.google.com with SMTP id z5so2321231qtb.0;
        Thu, 23 May 2019 14:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lTgN7h3hdKr1+n0VjmGc/qWeMMTNBbp9DYutgOmMsBE=;
        b=QWbKFbknKqScP8lkJNlpzZhJFZIFQqaNViglb5lX/qE5mAIVvrSs1mEANeC2R2rz4W
         vr2CQALElWfwHN3hYOMXmx3SyeYeHL1CwqyJQXQ6KHiLEKVwgpCcTNUDnoY4kCe8slfe
         29pDR7UlZXXz1zRY3hWKJ+8pE/ZKtMUNCNmBOZxc3X1TzU/ZMrBCX5LhCOUceJwrwbjY
         sTWp/DdpTvLlkimimWAkKobngh+PBCAeK0yI26t/venNA1qTnL/XlmtG4AYB/YtjmuKk
         zQXUp/gj8XzS9blh+3/3q1WefBLkyFlZo/uJPyCyUu1znC+wanluCi/b1pU20wbHTKQM
         6NSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lTgN7h3hdKr1+n0VjmGc/qWeMMTNBbp9DYutgOmMsBE=;
        b=uDC7PjEmqOHOK9Ueb02TE86HJzGFWbN2oh6o2pFAMDT+vaifmWJXrDLeF6+7pu5pm3
         +zlGO2SibfRW4tREijfCCM8xqfD+Z7dxPtM8nhMsU4xs8InVV+anouz2wAZhVxx8ldD/
         wlGn+5jHIPt2KKd3/WmJwv7owbXsqFOOFBcLj1P+BjTjFgz39VaWPiMHHRt+Vl3wm1y7
         z+PD6Tdt5QA/w6n6PqlskTdCNpgfwKYzx31DcubPYR2xVuIZhyS58JGNQp+eNVOCFu61
         ZihbRuIUwIZ7KxpQxd7UFyrG8MdHpJUbVUqrtifG4oTnJBb05+w8yIEEIlD47vGRdFdo
         /QNA==
X-Gm-Message-State: APjAAAWV/dgo3mOl3iJWbAdWHhy84qhd4b2sSusvHSPpUXOhTOOBZqWf
        Z+BfPt9KPMUSsmW3WFi7yLKStlJMsnQ=
X-Google-Smtp-Source: APXvYqwhxl26lCFqQbvw0xH5Wts3d1RmkKlYkbFIX4IScnu1FnkZLxIMiLvv14t5bKn8SQu61Ssiqg==
X-Received: by 2002:a0c:b621:: with SMTP id f33mr49951528qve.199.1558648740234;
        Thu, 23 May 2019 14:59:00 -0700 (PDT)
Received: from localhost ([2601:184:4780:7861:5010:5849:d76d:b714])
        by smtp.gmail.com with ESMTPSA id b11sm300127qtt.6.2019.05.23.14.58.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2019 14:58:59 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     Rob Clark <robdclark@chromium.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] PM / devfreq: try_then_request_governor should not return NULL
Date:   Thu, 23 May 2019 14:58:45 -0700
Message-Id: <20190523215853.16622-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

The two spots it is called expect either an IS_ERR() or a valid pointer,
but not NULL.

Fixes this crash that I came across:

   Unable to handle kernel NULL pointer dereference at virtual address 0000000000000030
   Mem abort info:
     ESR = 0x96000005
     Exception class = DABT (current EL), IL = 32 bits
     SET = 0, FnV = 0
     EA = 0, S1PTW = 0
   Data abort info:
     ISV = 0, ISS = 0x00000005
     CM = 0, WnR = 0
   [0000000000000030] user address but active_mm is swapper
   Internal error: Oops: 96000005 [#1] PREEMPT SMP
   Modules linked in:
   Process kworker/2:1 (pid: 212, stack limit = 0x(____ptrval____))
   CPU: 2 PID: 212 Comm: kworker/2:1 Not tainted 5.1.0-43338-g460e6984675c-dirty #54
   Hardware name: Google Cheza (rev3+) (DT)
   Workqueue: events deferred_probe_work_func
   pstate: 00c00009 (nzcv daif +PAN +UAO)
   pc : devfreq_add_device+0x2e4/0x410
   lr : devfreq_add_device+0x2d4/0x410
   sp : ffffff8013d93740
   x29: ffffff8013d93790 x28: ffffffc0f54f8670
   x27: 0000000000000001 x26: 0000000000000007
   x25: ffffff80124abfd8 x24: 0000000000000000
   x23: ffffffc0fabc4048 x22: ffffffc0fabc4388
   x21: ffffffc0fabc4010 x20: ffffffc0fa243010
   x19: ffffffc0fabc4000 x18: 0000000091c3d373
   x17: 0000000000000400 x16: 000000000000001a
   x15: 000000019e06d400 x14: 0000000000000001
   x13: 0000000000000000 x12: 00000000000006b6
   x11: 0000000000000000 x10: 0000000000000000
   x9 : ffffffc0fa18ba00 x8 : 0000000000000000
   x7 : 0000000000000000 x6 : ffffff80127a3d9a
   x5 : ffffff8013d93550 x4 : 0000000000000000
   x3 : 0000000000000000 x2 : 0000000000000000
   x1 : 00000000000000fe x0 : 0000000000000000
   Call trace:
    devfreq_add_device+0x2e4/0x410
    devm_devfreq_add_device+0x64/0xac
    msm_gpu_init+0x320/0x5c0
    adreno_gpu_init+0x21c/0x274
    a6xx_gpu_init+0x68/0xf4
    adreno_bind+0x158/0x284
    component_bind_all+0x110/0x204
    msm_drm_bind+0x118/0x5b8
    try_to_bring_up_master+0x15c/0x19c
    component_master_add_with_match+0xb4/0xec
    msm_pdev_probe+0x1f0/0x27c
    platform_drv_probe+0x90/0xb0
    really_probe+0x120/0x298
    driver_probe_device+0x64/0xfc
    __device_attach_driver+0x8c/0xa4
    bus_for_each_drv+0x88/0xd0
    __device_attach+0xac/0x134
    device_initial_probe+0x20/0x2c
    bus_probe_device+0x34/0x90
    deferred_probe_work_func+0x74/0xac
    process_one_work+0x210/0x428
    worker_thread+0x278/0x3e4
    kthread+0x120/0x130
    ret_from_fork+0x10/0x18
   Code: aa0003f8 b13ffc1f 54000762 f901c278 (f9401b08)
   ---[ end trace a6ecc18ce5894375 ]---
   Kernel panic - not syncing: Fatal exception

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/devfreq/devfreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 0ae3de76833b..d29f66f0e52a 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -254,7 +254,7 @@ static struct devfreq_governor *try_then_request_governor(const char *name)
 		/* Restore previous state before return */
 		mutex_lock(&devfreq_list_lock);
 		if (err)
-			return NULL;
+			return ERR_PTR(err);
 
 		governor = find_devfreq_governor(name);
 	}
-- 
2.20.1

