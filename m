Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACA702FD32B
	for <lists+linux-pm@lfdr.de>; Wed, 20 Jan 2021 15:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733040AbhATOvs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Jan 2021 09:51:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727999AbhATOeN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Jan 2021 09:34:13 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1CFAC061575;
        Wed, 20 Jan 2021 06:33:32 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id n142so25513160qkn.2;
        Wed, 20 Jan 2021 06:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SLu7xLOHoJk5O71a5t7wOSknBRIhuk86LWysAaeDJZM=;
        b=GZxKdB38mCVGErj2d360bCRiS2NAxk1fd9wfaf8+zwujob//aIdTzNxpAAu9Iiazan
         kINFjOHISYOIKd73cZ2+G33l/NiDImZWGlvV0C6tVqxOtKtjpt6S2YvHEavLlWlC98In
         E54YCWU3qunL+3GY4VxarPKv/YD8b+CYQKrc9/5j26TYz7POHz1JwMRCOzzltflgOGyE
         Yoa1gNYdS7lkFF7URMebz9i3TIbaxM6ELI+K5b1tmWJzE881oHNMc98mIIlbnxzB06EY
         8Te+KmYTd9OOMdkxwSCvjyDdpq9Sdg52VSQd+MuykXLYdczVoOp+rhVNvBDqa936d1zS
         nPQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SLu7xLOHoJk5O71a5t7wOSknBRIhuk86LWysAaeDJZM=;
        b=jGGUD7W/1/fNRo8lb+zeDNcKqi08TLd6G2bNuFTIlOosChFNbYWJHxiSHUHV3cRuGS
         0X+pjeCO/a3hIFcplUnimUciDnXDb/hQweq8xZliJS3M3+vx6bz7roz6/3s+VaiHS/Ya
         pTHbZvpfLKAGkuqESdYg5ul1eniUZGkuXmrE1Kcm4VXEfg1NmqqumxuJptUUsxkuWhjU
         CyQFZOm6jevD6NrVgfMvVPOtaZG9PaZrImiNAQfz9ZZQ0c+UGCDKruCmsWHXuD+kjvpF
         QGIKytXGf/Hk90qOs3aSbI7c4OyGqwqjYjwI4wrEEa72hKZxcZkcN6gaZB23h5s4hjiI
         NyRw==
X-Gm-Message-State: AOAM532wJ7c687rdyNGZtdfmqhCdZROAA9EsQvSiS7IkN2uLi8af0apl
        BPeqTvMfIKzhPjtOmnQAftvYuL8+1zasbtJ4
X-Google-Smtp-Source: ABdhPJxHk4aeFawkVpe68oU75ElldH9GhBht/4QXt0tv+mHZU4x1LlehQ5KeQ21hqIICkrUg/GqPUg==
X-Received: by 2002:a37:a713:: with SMTP id q19mr9859652qke.23.1611153212088;
        Wed, 20 Jan 2021 06:33:32 -0800 (PST)
Received: from localhost.localdomain ([156.146.54.160])
        by smtp.gmail.com with ESMTPSA id q6sm1407832qkd.41.2021.01.20.06.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 06:33:31 -0800 (PST)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz,
        gregkh@linuxfoundation.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] drivers: base: power: Fix resposible -> responsible in runtime.c
Date:   Wed, 20 Jan 2021 20:03:12 +0530
Message-Id: <20210120143312.3229181-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

s/resposible/responsible/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/base/power/runtime.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index bfda153b1a41..a46a7e30881b 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1100,7 +1100,7 @@ EXPORT_SYMBOL_GPL(__pm_runtime_resume);
  * suspending the device when both its runtime PM status is %RPM_ACTIVE and its
  * runtime PM usage counter is not zero.
  *
- * The caller is resposible for decrementing the runtime PM usage counter of
+ * The caller is responsible for decrementing the runtime PM usage counter of
  * @dev after this function has returned a positive value for it.
  */
 int pm_runtime_get_if_active(struct device *dev, bool ign_usage_count)
--
2.30.0

