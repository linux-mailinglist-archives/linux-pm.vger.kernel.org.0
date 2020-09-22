Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 460392739EF
	for <lists+linux-pm@lfdr.de>; Tue, 22 Sep 2020 06:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728518AbgIVEru (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Sep 2020 00:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728516AbgIVEru (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Sep 2020 00:47:50 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DCA7C061755;
        Mon, 21 Sep 2020 21:47:50 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id t14so10921148pgl.10;
        Mon, 21 Sep 2020 21:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vumKbUqbxeyCIUVMv4z41zxEKfPfEFtt2lD6WR2MEgA=;
        b=fgM0ZfFfBOhWcLSesS82sbpszfxep2FMFz2Xf19cXKVt5tzzZwaCsHiq4WnXmPEB3S
         yck4egyQNqA3onxAFLpDezvKOSsmzLxd8blMdeeJugrvwbRmjPxYhmS0eN2Xi5Fd5r64
         8Q5sqYzcrb1lFEwnMGyCvbmywiFMIZWlMQORgWwTGdQniO5suy7uUWfNGObUFuj3NZFu
         m4PwzwNEogiqGadn+8xiIOxMa8mgYpBDLC7UI/WcphpjXTrwnWx+aOO+ESiS1/oyepzI
         8jilvlIwP8tHVOHw2nm3Emj9X+9J6cprnyZ3oY8knUMfQvOqPw6disO/UbBjrVma6zmo
         E6ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vumKbUqbxeyCIUVMv4z41zxEKfPfEFtt2lD6WR2MEgA=;
        b=YTTIvwUZwzKNzWX5sOImqH2M2AwdR2L9cQr/NBJ6m1CYEraYuhyrKO48jaP4vOYRV8
         ZWaNsIaLj+kc22NiNwfZ31ClWheGQnG+mv4tTNAVT5sH9jC0kXtH9n/pl86rKqBLC3Dx
         RrfKi7h7Omuhab1b4ne47c03FpQIY9zIeyuLBQHXrGaQn0VHZjXTuvCN/SbCths40x7M
         FWsFteXhvwkB5w6bCRxrbtCuQBUWRqZJnxZpwzUZHkW667ilwN7s0LGT3I37gTD+yzw5
         ZTiJbXQVWVB15s0T22pBPoe7u8Eaw+nag+U9A12u0Ng6BEP2QVi+qIUMyvs+6KEAX/iZ
         y7bw==
X-Gm-Message-State: AOAM530U7LEzjVDK3WFFkwVSR3YHe17kEIUh81r3QQSSMPkMxYXDEF6S
        QS+rjqTb04QuqwRDspLQmA==
X-Google-Smtp-Source: ABdhPJz6uvBTYf5HoG/lQc1314IOxqm1wKikddE/wWGMVpq/b28kQE2IHr/aR4yXCH0jqsD/PyD4/g==
X-Received: by 2002:aa7:8b4f:0:b029:142:2501:35e9 with SMTP id i15-20020aa78b4f0000b0290142250135e9mr2724502pfd.73.1600750069976;
        Mon, 21 Sep 2020 21:47:49 -0700 (PDT)
Received: from localhost.localdomain ([47.242.131.39])
        by smtp.gmail.com with ESMTPSA id k28sm13077424pfh.196.2020.09.21.21.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 21:47:49 -0700 (PDT)
From:   Pujin Shi <shipujin.t@gmail.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Herrington <hankinsea@gmail.com>, shipujin.t@gmail.com,
        Pujin Shi <shipj@lemote.com>
Subject: [PATCH v4] powercap: include header to fix -Wmissing-prototypes
Date:   Tue, 22 Sep 2020 12:46:52 +0800
Message-Id: <20200922044652.3393-1-shipujin.t@gmail.com>
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

