Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1DE6772C5D
	for <lists+linux-pm@lfdr.de>; Mon,  7 Aug 2023 19:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbjHGRMd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Aug 2023 13:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbjHGRMR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Aug 2023 13:12:17 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E745B1BD3;
        Mon,  7 Aug 2023 10:12:06 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1bc411e9d17so29224915ad.0;
        Mon, 07 Aug 2023 10:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691428326; x=1692033126;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8BWwQKRJpzoHOTxVfrEWi7WrUwdArtmVUIFmQG2FfZk=;
        b=nUcZ6zaKb9oJP6CEIYRcJkVn2doIh/RF8s3VrpAVFmfsq1IIqx19G69U84jz9jzQgY
         cHr+lYbYhmNdbIukaqOqGsPKk2sw7KWC72wtrTjbwCp2nPjSAYHSsMBH7eotQ46I/B5g
         nrRXrNOtuNQ5D77wN3uGg1Kyl8uwOqC3fyBEvWvZPLsblIAAkDYjhjLFN0cHZTIlyy1p
         xqJ+DIubWTGtHZgXWaPwzzkZRHyyhuHowAEJC2+dZuPLFCgSw5RkybhX20f8D894mI3n
         uzwcIeGy9iHqQ7RK7Rgox4rrkdOrpBNCJihzyD4UB+d9OGt8+t7Z2G+lZDzn8OPSEH/w
         aoqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691428326; x=1692033126;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8BWwQKRJpzoHOTxVfrEWi7WrUwdArtmVUIFmQG2FfZk=;
        b=SLHFXzeKvy6TDiqkOJq/wNXcnBhe4djslkO4WhAbA5X/Gea8wz+d/uExuHuzw9WrB9
         fM8TK4g3xoF9D/I7SwaMScgYwriDGWx4eVx43cKXga03/GxrZ2f8Lx7+hVVYYQ0y3z9g
         UundRB6qk4gWAqXWUe+dVfiLde2Z01x4joruk5Dmn8r8W9yjxrxkoebHsaw63uf2H8yC
         0RwDpXF+7nx3dwXKNU1si4XkTZprA1xz80ei8NJxeNDt7G2ulaL/rhKvOmlKuNrAe3r2
         29ZXlp4dk+GzRT587NkXnmGhiTqg+ofaWFBLjGE+PYP6EjQl3XC/DqUPSwh4/kEkITAY
         sVlA==
X-Gm-Message-State: AOJu0YyyT2QDV/e7PDHU4mxFlZ5hq/kHZFr5hWASzUzLtj8Q7TLyf5ZE
        Xmv47tKuodvqCnh6aNyEqkDAnRKmRvg=
X-Google-Smtp-Source: AGHT+IHiIsybfpW8I/4HRIF/dVyngB0zec9md5KKieStD7fN6pUtE5S6xEynqQO6g3nIMhlAahP9yQ==
X-Received: by 2002:a17:902:ecc3:b0:1bc:382b:6897 with SMTP id a3-20020a170902ecc300b001bc382b6897mr10420079plh.13.1691428325704;
        Mon, 07 Aug 2023 10:12:05 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:6c80:7c10:75a0:44f4])
        by smtp.gmail.com with ESMTPSA id s21-20020a170902b19500b001a1b66af22fsm7155258plr.62.2023.08.07.10.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 10:12:05 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org (open list:POWER MANAGEMENT CORE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 4/9] PM / QoS: Decouple request alloc from dev_pm_qos_mtx
Date:   Mon,  7 Aug 2023 10:11:38 -0700
Message-ID: <20230807171148.210181-5-robdclark@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230807171148.210181-1-robdclark@gmail.com>
References: <20230807171148.210181-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

Similar to the previous patch, move the allocation out from under
dev_pm_qos_mtx, by speculatively doing the allocation and handle
any race after acquiring dev_pm_qos_mtx by freeing the redundant
allocation.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/base/power/qos.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/base/power/qos.c b/drivers/base/power/qos.c
index 7e95760d16dc..5ec06585b6d1 100644
--- a/drivers/base/power/qos.c
+++ b/drivers/base/power/qos.c
@@ -930,8 +930,12 @@ s32 dev_pm_qos_get_user_latency_tolerance(struct device *dev)
 int dev_pm_qos_update_user_latency_tolerance(struct device *dev, s32 val)
 {
 	struct dev_pm_qos *qos = dev_pm_qos_constraints_allocate(dev);
+	struct dev_pm_qos_request *req = NULL;
 	int ret = 0;
 
+	if (!dev->power.qos->latency_tolerance_req)
+		req = kzalloc(sizeof(*req), GFP_KERNEL);
+
 	mutex_lock(&dev_pm_qos_mtx);
 
 	dev_pm_qos_constraints_set(dev, qos);
@@ -945,8 +949,6 @@ int dev_pm_qos_update_user_latency_tolerance(struct device *dev, s32 val)
 		goto out;
 
 	if (!dev->power.qos->latency_tolerance_req) {
-		struct dev_pm_qos_request *req;
-
 		if (val < 0) {
 			if (val == PM_QOS_LATENCY_TOLERANCE_NO_CONSTRAINT)
 				ret = 0;
@@ -954,17 +956,15 @@ int dev_pm_qos_update_user_latency_tolerance(struct device *dev, s32 val)
 				ret = -EINVAL;
 			goto out;
 		}
-		req = kzalloc(sizeof(*req), GFP_KERNEL);
 		if (!req) {
 			ret = -ENOMEM;
 			goto out;
 		}
 		ret = __dev_pm_qos_add_request(dev, req, DEV_PM_QOS_LATENCY_TOLERANCE, val);
-		if (ret < 0) {
-			kfree(req);
+		if (ret < 0)
 			goto out;
-		}
 		dev->power.qos->latency_tolerance_req = req;
+		req = NULL;
 	} else {
 		if (val < 0) {
 			__dev_pm_qos_drop_user_request(dev, DEV_PM_QOS_LATENCY_TOLERANCE);
@@ -976,6 +976,7 @@ int dev_pm_qos_update_user_latency_tolerance(struct device *dev, s32 val)
 
  out:
 	mutex_unlock(&dev_pm_qos_mtx);
+	kfree(req);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(dev_pm_qos_update_user_latency_tolerance);
-- 
2.41.0

