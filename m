Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F30D41CD9C1
	for <lists+linux-pm@lfdr.de>; Mon, 11 May 2020 14:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729811AbgEKMZv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 May 2020 08:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729728AbgEKMZs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 May 2020 08:25:48 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53CD6C061A0C
        for <linux-pm@vger.kernel.org>; Mon, 11 May 2020 05:25:48 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id k19so3867610pll.9
        for <linux-pm@vger.kernel.org>; Mon, 11 May 2020 05:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=haxNS0r+O/CZv15x/o++MDoCTq7xU6xDTOnaN5esXAw=;
        b=YXhiLmSx4goD8MUm/DW+rJ3zGpXWB6FJ31sgJ5LlIO1JYcdZkfCt5mSFZIuxiNtm5l
         UfHYxoICohviLDbSbjQmTo+sOI/dpnqt3cbXlcfW13WQsYTxb8gc/Ei0zObJ5Yh4p0Ba
         iF3fXBsX6jrgIDBJnZM4Wh/x3tNrHCcUf0MS3jsv6VVJmLC5qOzpwb4tGxZsrxkBbywa
         YxaL3gXVxEIlRpdW4oMDNSobiYem5inBDHkZxsUTxoA8QqbtdNHXhv5usHlkZeRqNhkO
         g/rXcAd6Vj+FDAc0jItxg+usDGmwxOWHSD++8EhIzWWfJUFNLJdxrvORZXMDBb5R+6zU
         8UYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=haxNS0r+O/CZv15x/o++MDoCTq7xU6xDTOnaN5esXAw=;
        b=LhwGYbkln07y77r54+x8k+876aU0M1bX3U9ylzgKk9r6Cvh12f2cQCIx8uoKh07iRy
         VDWoqESpKWTe2IiTqiAMxJvrS1vHEU4Q7TwdV9QU+npZD7nUm3tUZESRxKSEp7r7pmgc
         /G3adMB/npVd92mZQwJIic747ltT01BdNCMU0dzM7uM+tafHqClC7crfmbGsfXa4UbZZ
         0JuiLUP5yI/uh01zqH1Bbu70Gt/y1hZ1B4us1vrtDvHMj5cEVCZKYbFkO5erGb2Wh1nI
         0E8j4Po4eWghQJguu3zpkjejzfWdmP5da0U0a9Da9GTHMGKZTsWryZKhiUgVuWUY4fV8
         dAbA==
X-Gm-Message-State: AGi0Pua11C4W/wiyHyqXEHtjKdU2go27TIocQslfDHP9jLYWIbm3F8nw
        ta2KehYRJoSfeWdrEuYo41OETw==
X-Google-Smtp-Source: APiQypKuTjY9Gg8mysJb/lkYYkrUVhRtatcvHzJl+3wFXdbvG1f4JVxn/zvTUHIoQRLk+TPOTNmBjg==
X-Received: by 2002:a17:90a:e013:: with SMTP id u19mr20147358pjy.16.1589199947854;
        Mon, 11 May 2020 05:25:47 -0700 (PDT)
Received: from localhost ([45.127.45.102])
        by smtp.gmail.com with ESMTPSA id x193sm9569958pfd.54.2020.05.11.05.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 05:25:47 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Javi Merino <javi.merino@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH 04/14] thermal/drivers/thermal_helpers: Include export.h
Date:   Mon, 11 May 2020 17:54:52 +0530
Message-Id: <fd3443f00dbba6ca90f35726c7451ae52145d2d4.1589199124.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1589199124.git.amit.kucheria@linaro.org>
References: <cover.1589199124.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

It is preferable to include export.h when you are using EXPORT_SYMBOL
family of macros.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/thermal_helpers.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
index 8ea0a05404f7..e47da80daf3a 100644
--- a/drivers/thermal/thermal_helpers.c
+++ b/drivers/thermal/thermal_helpers.c
@@ -14,6 +14,7 @@
 
 #include <linux/device.h>
 #include <linux/err.h>
+#include <linux/export.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/sysfs.h>
-- 
2.20.1

