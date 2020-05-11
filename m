Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75ED81CD99B
	for <lists+linux-pm@lfdr.de>; Mon, 11 May 2020 14:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729630AbgEKMZi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 May 2020 08:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729595AbgEKMZh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 May 2020 08:25:37 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33AB0C061A0C
        for <linux-pm@vger.kernel.org>; Mon, 11 May 2020 05:25:36 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id t16so3867711plo.7
        for <linux-pm@vger.kernel.org>; Mon, 11 May 2020 05:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+8aLBVF/jCNJkdmjTC/dudzjrY2tWkvRd1FtJjGwyUk=;
        b=euAP57wveF2y86MHZ6NV58TG0vSv9YKmBb6lQBV0IXubepFm2dNRippIbx93bponZ/
         5wu/RJRdOf1qM2bbmrGpSz6ojY2+0ae6Qi4gMb85pkSOp3p5T8376FlCZC/M5FXpk4hx
         T/CG2lZEw/CxOK3WQJXCioactq2A219Yv7f39F7U1X06RdQKm2O0Tcq9G7B+DEFMpvre
         GOUC/s4gXAOPn04Knsz2blgFHT8mZH61ngqCNUywerOsLd4Dd7ttlBYrsWsIFdMTSZID
         5AuWs8pFndMg5h1/INazI5Eygmo5OCwm53sWmj7im2uP1zvY/+pyW4Ie2fzgz1l8KdY7
         s3kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+8aLBVF/jCNJkdmjTC/dudzjrY2tWkvRd1FtJjGwyUk=;
        b=IHIeNA821Oqcvji3/LzPxJmwM5nZbl/KpUJKh+8QutAd2nG9RgDsiO5Ihm7whQoNWY
         cALoVf6BF0NOuZwVac/Vr0l86HpcCEii5EvdXK45D8E1LFo3ZNN9LpLnOx9ShZ6tnHBg
         D/DtJmrHUo85GPYpVJCH5gy6aCAh4zts36x/BbuJ4Tku0l/hJHDRRXZvMKHigAGshvXB
         GFJud72JFV0jOy1LLN8OvJuMAoNIk0Gk4f0ctoYUJWcbydKt7QFxVT/otN+muUBBO8+3
         MVFYKVEzLiYr6huRSwnwmFVE+268+ajzWI8h8V1ADdn9/aczA3ZTx3N+nRr+JLuzVDiI
         K6BA==
X-Gm-Message-State: AGi0PuajnOuNJxYJSzwYNpmNPKEgH94P36FQ2UNUupkBZWpHe0Ub8F+H
        aHRbPHsxAhOeFbQ8Pp9qGGk9mg==
X-Google-Smtp-Source: APiQypJ4qBRsFtSTkkiLyjxDBfw6clVcHL7/Oi64wn/3ZpAx5AIZwfiiazyOlZANpe6NwClLBYs2lA==
X-Received: by 2002:a17:90a:1501:: with SMTP id l1mr22882557pja.82.1589199935696;
        Mon, 11 May 2020 05:25:35 -0700 (PDT)
Received: from localhost ([45.127.45.102])
        by smtp.gmail.com with ESMTPSA id q6sm9049534pfh.193.2020.05.11.05.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 05:25:34 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Javi Merino <javi.merino@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH 01/14] thermal/core: Get rid of MODULE_* tags
Date:   Mon, 11 May 2020 17:54:49 +0530
Message-Id: <74339a09a55f8f3d86c4074fc2bf853a302d6186.1589199124.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1589199124.git.amit.kucheria@linaro.org>
References: <cover.1589199124.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The thermal framework can no longer be compiled as a module as of
commit 554b3529fe01 ("thermal/drivers/core: Remove the module Kconfig's
option"). Remove the MODULE_* tags.

Rui is mentioned in the copyright line at the top of the file and the
license is mentioned in the SPDX tags. So no loss of information.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/thermal_core.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 9a321dc548c8..286920e06277 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -27,10 +27,6 @@
 #include "thermal_core.h"
 #include "thermal_hwmon.h"
 
-MODULE_AUTHOR("Zhang Rui");
-MODULE_DESCRIPTION("Generic thermal management sysfs support");
-MODULE_LICENSE("GPL v2");
-
 static DEFINE_IDA(thermal_tz_ida);
 static DEFINE_IDA(thermal_cdev_ida);
 
-- 
2.20.1

