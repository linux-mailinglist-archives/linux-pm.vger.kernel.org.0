Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65AF92F96EF
	for <lists+linux-pm@lfdr.de>; Mon, 18 Jan 2021 01:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730132AbhARA40 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 17 Jan 2021 19:56:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730234AbhARA4R (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 17 Jan 2021 19:56:17 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53774C061574;
        Sun, 17 Jan 2021 16:55:37 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id x20so21600566lfe.12;
        Sun, 17 Jan 2021 16:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+a0TnX2ybR+9zT3v5f4ICq5eAhyFrIALU+uTlPBGTCA=;
        b=CtxxSCvcUvDVc5k8siym1L1Xn7APGDTcrMhrLOFN2UQetgZ7xyxXaxg6eSSHZsKb8A
         6Ccdfc6/+YOSmbJZnNxiLBfBZP4ZEOjIUtrPVZKe9qcKvL1dbJf/hX9DZjhqbr/7c+TD
         ePsSN9B7c6DQmA2m25xvJCJEFYn//ffKWLDM6dW/fhyWTkSdV3PhVEvXy+7YJRjvdrck
         KLpCWaSmYbL1SbHtXrUGpm5k2KriF8Gj62xST9Q69wUDWxrKAHSoqRLZCUP6sUAjTz56
         dpTIFnodEmHhGVF57TBBGf2ZGt2lC+ZW3PO+pdbe5UURg/2IuG16m28h+oOVAT/sou5i
         YcbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+a0TnX2ybR+9zT3v5f4ICq5eAhyFrIALU+uTlPBGTCA=;
        b=Ux+4C/Jc4/LHXrIs5DEKkKauUG1SgQsmK6rH/Ljrh5a0NbKO0sS4aqJpEobaJF0met
         nj8L3DhfOHOAIazkRka3CNabUKKk0JnkuYZ1r9CjvbpXGfxi5taZuyykvfy/Ijb8sy6B
         G5oc8Dqa7F8PgXtxHWoZAgUcTT0Y1GDqS/20LKZf/lJliyDIBUoFoiVmalfAT/2JWN0H
         mQzrDpHxU+Imsq8DV8r4xqahPCOjhmWBtwKHHv1N5JGSUVZAc2mqBTGwGc8LHsiNXHKE
         bplmIw2vvoi3NIOE+X9PtOnoWIuxTxL0yRVisB0AAviG9eM8fX6LuhyhgSOHqzVu/sdv
         rVnA==
X-Gm-Message-State: AOAM530TouF9+g7Skrswpby8TKVX556Qk1NzubSRgwxVH/poZXIVpKlY
        DaoXPXP+ketIcmXeYegCgPUfD+dbHf8=
X-Google-Smtp-Source: ABdhPJx5WCEh/lj3K7rWyUD+Rzb3nCDmTazV0J0o5LiH8805KR36AAf7zFIST3A2ciVyrfS08FtVPg==
X-Received: by 2002:a19:7507:: with SMTP id y7mr8737220lfe.554.1610931335896;
        Sun, 17 Jan 2021 16:55:35 -0800 (PST)
Received: from localhost.localdomain (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.gmail.com with ESMTPSA id m24sm1484553ljj.62.2021.01.17.16.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jan 2021 16:55:35 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Matt Merhar <mattmerhar@protonmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v3 01/12] opp: Fix adding OPP entries in a wrong order if rate is unavailable
Date:   Mon, 18 Jan 2021 03:55:13 +0300
Message-Id: <20210118005524.27787-2-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210118005524.27787-1-digetx@gmail.com>
References: <20210118005524.27787-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix adding OPP entries in a wrong (opposite) order if OPP rate is
unavailable. The OPP comparison was erroneously skipped, thus OPPs
were left unsorted.

Tested-by: Peter Geis <pgwipeout@gmail.com>
Tested-by: Nicolas Chauvet <kwizart@gmail.com>
Tested-by: Matt Merhar <mattmerhar@protonmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/opp/core.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index dfc4208d3f87..48618ff3e99e 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1527,12 +1527,10 @@ int _opp_add(struct device *dev, struct dev_pm_opp *new_opp,
 	mutex_lock(&opp_table->lock);
 	head = &opp_table->opp_list;
 
-	if (likely(!rate_not_available)) {
-		ret = _opp_is_duplicate(dev, new_opp, opp_table, &head);
-		if (ret) {
-			mutex_unlock(&opp_table->lock);
-			return ret;
-		}
+	ret = _opp_is_duplicate(dev, new_opp, opp_table, &head);
+	if (ret) {
+		mutex_unlock(&opp_table->lock);
+		return ret;
 	}
 
 	list_add(&new_opp->node, head);
-- 
2.29.2

