Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA91351FB5
	for <lists+linux-pm@lfdr.de>; Thu,  1 Apr 2021 21:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235351AbhDATZC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Apr 2021 15:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234646AbhDATYk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Apr 2021 15:24:40 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C820C0319E3
        for <linux-pm@vger.kernel.org>; Thu,  1 Apr 2021 11:37:16 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id x13so2737878wrs.9
        for <linux-pm@vger.kernel.org>; Thu, 01 Apr 2021 11:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mWp87AvriRPuSbwzklCYB4OLn1zwKcfSlyq/Ns8RiTU=;
        b=qXsmmaslDu7+q9I+6oxHqAzPye7Ygo83eFdoYV6MpA8awK+MWTJkISpji/Zceg8hf9
         XfuXrlJf9Qk2NMbj7SQYi7XnPg/6mZ4RNqGc138v0Ax/12WAFwxD8YQKXCF7jnZpcz/M
         FNpF38UDo9p1bQNV5yvJsGoDbJnPMFYnxMSj2NMC5Jm5r7EsrWqiap1sswpQOvAqhjJ9
         D3fJk5hu1b/tNajDtx5BWi7FsrZMTxkKaFmip7WlAxXoC9VMvwYlSLBjowG8CvQpS5TV
         2IWKuvrzxnXJ+Ac1/8tDQ6A2lrn6mVbGPs+3JVvr9Ak+y+YaVSQyiu3PlQRS8kH02HUq
         dBCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mWp87AvriRPuSbwzklCYB4OLn1zwKcfSlyq/Ns8RiTU=;
        b=d9WBSWEfK2Z6FzoM8K/m5IgPHb5mqGUjw5w2EJqYGf3qmZ+/d+KmvdyvU9OMjk3o7s
         8jFEZ2rP02d1bY6o60xvsaM74BukIFkSZ7VWDGeFER6OINSn16ZQkLF2CNImFmpvsTPd
         7GyjdMXTBQeXg9USrtVCYUF25PS0sGNQGk5Z2o4ZnGjar34GTdAaYTTxpczwSJiGERqr
         f95pqYIpox1I2dg3IJxcaBO92QbjMgX4F6JOUqPnfNhGcdfcy/duPNwexn73NrTF3Ykb
         jQb4j1aFPxBRmGvOIjMLGgTS9e+S/loFHXE+cj9GqmdMXYipOEONXF/iC1Jg4ssgX8Du
         h1QQ==
X-Gm-Message-State: AOAM532KkajpSWqdFwTkFy4Mw4Q+skBD/ePT5qmNWIvmj8gQ5yTXxvPt
        WNrqNfO4DvGRuaFmINI/zlhebg==
X-Google-Smtp-Source: ABdhPJwattzDw5AfClw4cKUx5DETB7Tk72Dsv8S0ms+4/8KuYiJlAZT6WFQedDiojl0bh7428+2JdA==
X-Received: by 2002:a5d:6242:: with SMTP id m2mr11160995wrv.384.1617302235113;
        Thu, 01 Apr 2021 11:37:15 -0700 (PDT)
Received: from localhost.localdomain ([82.142.26.252])
        by smtp.gmail.com with ESMTPSA id b131sm9111490wmb.34.2021.04.01.11.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 11:37:14 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukasz.luba@arm.com, rafael@kernel.org, gregkh@linuxfoundation.org
Subject: [PATCH v6 6/7] powercap/drivers/dtpm: Export the symbols for the modules
Date:   Thu,  1 Apr 2021 20:36:53 +0200
Message-Id: <20210401183654.27214-6-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210401183654.27214-1-daniel.lezcano@linaro.org>
References: <20210401183654.27214-1-daniel.lezcano@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The DTPM framework provides a generic API to register devices which
power capable. The devices may be compiled as modules while the
framework is not.

Export the necessary API to let the drivers register themselves.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/powercap/dtpm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/powercap/dtpm.c b/drivers/powercap/dtpm.c
index b389bc397cdf..733567bbe0be 100644
--- a/drivers/powercap/dtpm.c
+++ b/drivers/powercap/dtpm.c
@@ -289,6 +289,7 @@ int dtpm_update_power(struct dtpm *dtpm)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(dtpm_update_power);
 
 /**
  * dtpm_release_zone - Cleanup when the node is released
@@ -486,6 +487,7 @@ void dtpm_init(struct dtpm *dtpm, struct dtpm_ops *ops)
 		dtpm->ops = ops;
 	}
 }
+EXPORT_SYMBOL_GPL(dtpm_init);
 
 /**
  * dtpm_unregister - Unregister a dtpm node from the hierarchy tree
@@ -500,6 +502,7 @@ void dtpm_unregister(struct dtpm *dtpm)
 
 	pr_debug("Unregistered dtpm node '%s'\n", dtpm->zone.name);
 }
+EXPORT_SYMBOL_GPL(dtpm_unregister);
 
 /**
  * dtpm_register - Register a dtpm node in the hierarchy tree
@@ -574,6 +577,7 @@ int dtpm_register(const char *name, struct dtpm *dtpm, struct dtpm *parent)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(dtpm_register);
 
 static int __init init_dtpm(void)
 {
-- 
2.17.1

