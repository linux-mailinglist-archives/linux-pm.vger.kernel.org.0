Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4E95271B38
	for <lists+linux-pm@lfdr.de>; Mon, 21 Sep 2020 09:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgIUHEj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Sep 2020 03:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbgIUHEj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Sep 2020 03:04:39 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64827C061755;
        Mon, 21 Sep 2020 00:04:39 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id b124so8445430pfg.13;
        Mon, 21 Sep 2020 00:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I2ZbtwVmDvOFK+zycxCjfdKVKY6xF0Wy1/dJQK2JDm0=;
        b=o8tGxzau2gDvTjcFKlTm8o00rEEjLcbqbxiuYoS9gm8j+Jc38UaqRX1mskLjzw8qtW
         KXx5O8nFLjrw0c8kXUUVvsCqvFVnE8zy3LyQQi1zI3DY9GHMkr5BSGHN/njPZGhz9hVS
         5KFnwsV5X4q3AP0AMiyXsMGsngC1oNvgQAHJcGiPu/WEM37tmV9iOQkD3VIqaKSObb/o
         h5CZ726agWwKFjZUvIMMcvKs8I+JBDTtaVbC9J2yC1PCsKO3/DZ5ZXXXV12uNue/l8sd
         I9zlXUT9bk7I2MH+zzV5YtVqSn8CJYS/qQCNbYp8HxCJcb/RhEPZTW3DoJTHkwrZvQSi
         yP5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I2ZbtwVmDvOFK+zycxCjfdKVKY6xF0Wy1/dJQK2JDm0=;
        b=tUnAWWniS3YK8KI+KHFLNaIEblrRDso5uyl4d5urtNOFsnsKSYw9WV1RYnfhm+Jycf
         g+5pK75I9LJbWy4wfwVTXf0XsHWC+X0/9utZsEYF0W/GoULn+UXRFXv8DhuEkI5ts9eW
         7qQ8CKBqkuKagI1U4kKCV4ne5BIBGTKlAhelgIHm8Iz04sErcJLxq1fCKlqwcsD5M1/L
         7J00B9TZ+S8zpRPKwBNC17IV/USti7/+soOt5sGWDfQNC10Qe/W7L/N36kOfbIqFNeO+
         j5mUko7jZBfwTcTPWIX5UppMantWPvo+efhv3lA02vCThAOysUqybOP5RCvDJfmw8uR2
         Jxew==
X-Gm-Message-State: AOAM5323TUOTQqFlbxL4Ri6RYoMVwcKxL5uyoyGfnvMPCflRZtx9Dvdz
        174h24llQoL4ak3rw+aqrnaddoGgXRuul0+r
X-Google-Smtp-Source: ABdhPJxauJfV3iIfYHv2fZVgLIL3gwOGcPNQSd5OnGX3Cd0KzCdRiPOt0FDIMC5ssPVIgCkewP04Ng==
X-Received: by 2002:aa7:904a:0:b029:142:2501:35d8 with SMTP id n10-20020aa7904a0000b0290142250135d8mr25862705pfo.56.1600671878867;
        Mon, 21 Sep 2020 00:04:38 -0700 (PDT)
Received: from localhost.localdomain ([47.242.4.81])
        by smtp.gmail.com with ESMTPSA id m13sm10095919pjl.45.2020.09.21.00.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 00:04:38 -0700 (PDT)
From:   Herrington <hankinsea@gmail.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        shipujin.t@gmail.com, hankinsea@gmail.com,
        Pujin Shi <shipj@lemote.com>
Subject: [PATCH v2] powercap: include header to fix -Wmissing-prototypes
Date:   Mon, 21 Sep 2020 15:04:17 +0800
Message-Id: <20200921070417.1121-1-hankinsea@gmail.com>
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

Signed-off-by: Herrington <hankinsea@gmail.com>
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

