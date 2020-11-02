Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 249242A240A
	for <lists+linux-pm@lfdr.de>; Mon,  2 Nov 2020 06:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbgKBFVu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Nov 2020 00:21:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgKBFVt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Nov 2020 00:21:49 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC72C061A04
        for <linux-pm@vger.kernel.org>; Sun,  1 Nov 2020 21:21:48 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id h6so9784913pgk.4
        for <linux-pm@vger.kernel.org>; Sun, 01 Nov 2020 21:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZLied8helMF+F7KhRJDmbzvMJ1y9a8NSxlUAHjNzrA4=;
        b=LcvlVVPcHl8HKxEsJOC3f/AskunDiuG6wO8JqVWzXUizFQzMUsGK1y3I6LiXYgWbdG
         UEJkXD4PSQoj33CalsPE9+ztINdFlLkt0ehHERU9GrSD/WJqIRSJfA0m6JNVm8dU+7TD
         Fs3sxoiXonqIyuwzW6u0lH71gcPQnsK/OglfTtikUebccZjHuk3Rq1ume3RT1ilBCR/u
         3HBiAlrJzAwt9NY+78UeJyktKmyfM9Z3EjFb5wKu4jq49nOc118ZPdZe4veaZRHiacPs
         8Swq8mmjiqL1JdMPm/b0LW5rGOcsJmGUa4U4TfevS3C8piJR5iWjR4foG/a5Gi9uSWgS
         q6ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZLied8helMF+F7KhRJDmbzvMJ1y9a8NSxlUAHjNzrA4=;
        b=dg0HSg0ZmYZ8V3BrN48zza5u0u12gHRC6gSXYSQCZfRge8e+nBO6HOKXVN65T5vRCV
         Me8TytQSHI3aYU1s2HWG+hlAaRSCjlZikUk3PAwR1PuqW9bldAaZqD8mx78SHsf29wHO
         x+7ElMJwbLxo12WkIz5c4leA1kUSTkyK7WjCaLUcrqQuosPW8EoytEOKC14xG4gtX35b
         pvJ2meJub2G1C69TlwdmKKZZGqC4pNDTVoP1/+WcTA9z9/OfJOOMUsgWXADWqTCDHTqa
         gRJWZMtoG5v6MmC2z2JjDmmmeWquK7cUe+s3JKX8s3snZpJ+aW0xuTFc+GBIWT0zU+HW
         Fl5A==
X-Gm-Message-State: AOAM530Y/yr96H11WqqCLnghJ01RhGKgu7Tl4GBUBxUI3kd8ck3hKfWs
        iRyE/vj2QX1zaQ30uex8MGOdtA==
X-Google-Smtp-Source: ABdhPJyaQSnyKmfheFF8kxj1+XNkSRk5unrkzwuHuXuBwOQJneDdzvwSyxx8WZ9seXSSbIglizHbwg==
X-Received: by 2002:a17:90a:ef81:: with SMTP id m1mr16029143pjy.212.1604294507492;
        Sun, 01 Nov 2020 21:21:47 -0800 (PST)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id g17sm12310731pfu.130.2020.11.01.21.21.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Nov 2020 21:21:46 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>, robdclark@gmail.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] opp: Always add entries in dev_list with opp_table->lock held
Date:   Mon,  2 Nov 2020 10:51:38 +0530
Message-Id: <ef43f01ac06976b2aa2b17266d307bb1a4f7e6f9.1604294460.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The readers of dev_list expect the updates to it to take place from
within the opp_table->lock and this is missing in the case where the
dev_list is updated for already managed OPPs.

Fix that by calling _add_opp_dev() from there and remove the now unused
_add_opp_dev_unlocked() callback. While at it, also reduce the length of
the critical section in _add_opp_dev().

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 0e0a5269dc82..84035ab8bb31 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1036,8 +1036,8 @@ static void _remove_opp_dev(struct opp_device *opp_dev,
 	kfree(opp_dev);
 }
 
-static struct opp_device *_add_opp_dev_unlocked(const struct device *dev,
-						struct opp_table *opp_table)
+struct opp_device *_add_opp_dev(const struct device *dev,
+				struct opp_table *opp_table)
 {
 	struct opp_device *opp_dev;
 
@@ -1048,7 +1048,9 @@ static struct opp_device *_add_opp_dev_unlocked(const struct device *dev,
 	/* Initialize opp-dev */
 	opp_dev->dev = dev;
 
+	mutex_lock(&opp_table->lock);
 	list_add(&opp_dev->node, &opp_table->dev_list);
+	mutex_unlock(&opp_table->lock);
 
 	/* Create debugfs entries for the opp_table */
 	opp_debug_register(opp_dev, opp_table);
@@ -1056,18 +1058,6 @@ static struct opp_device *_add_opp_dev_unlocked(const struct device *dev,
 	return opp_dev;
 }
 
-struct opp_device *_add_opp_dev(const struct device *dev,
-				struct opp_table *opp_table)
-{
-	struct opp_device *opp_dev;
-
-	mutex_lock(&opp_table->lock);
-	opp_dev = _add_opp_dev_unlocked(dev, opp_table);
-	mutex_unlock(&opp_table->lock);
-
-	return opp_dev;
-}
-
 static struct opp_table *_allocate_opp_table(struct device *dev, int index)
 {
 	struct opp_table *opp_table;
@@ -1148,7 +1138,7 @@ static struct opp_table *_opp_get_opp_table(struct device *dev, int index)
 
 	opp_table = _managed_opp(dev, index);
 	if (opp_table) {
-		if (!_add_opp_dev_unlocked(dev, opp_table)) {
+		if (!_add_opp_dev(dev, opp_table)) {
 			dev_pm_opp_put_opp_table(opp_table);
 			opp_table = ERR_PTR(-ENOMEM);
 		}
-- 
2.25.0.rc1.19.g042ed3e048af

