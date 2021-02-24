Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3024C324151
	for <lists+linux-pm@lfdr.de>; Wed, 24 Feb 2021 17:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235903AbhBXPqp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Feb 2021 10:46:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234279AbhBXOnn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Feb 2021 09:43:43 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5640DC06178B
        for <linux-pm@vger.kernel.org>; Wed, 24 Feb 2021 06:42:37 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id t15so2105796wrx.13
        for <linux-pm@vger.kernel.org>; Wed, 24 Feb 2021 06:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=f3Rx3ISSQZbwMoT0/xtI9lPMDRxaNak0z84CcyofG7Y=;
        b=fqElaXSKfBJ38b7QbFzdBU+kVcKshlDQjYrzuEBxowokUdx8lc4QqQcOoyatrZM6dZ
         LJm0SC6BVetCwxUhYdyc4RCOfNR8w/1KyhfVBIT/6bDqEFDN30nWKcDKlgLxswe/xxuO
         PfRUAEP3fjVrHjiJ6oekfROrX2qJfVLmkk7HNiiSIrQtsEriU+6aoM8Zr+SSq36x/kdU
         QLAwm+T6d8Rsr74i5/lNmXaTmArHrb1Ar2XX3vAa1Ckico5nDHENWimRHw2qknx7JES4
         fXfZV3e1yUwMRECkGzsZCNSZE+cvkIOJ5+63vvmvzKXznBTFhh+b+NJG+t2+7yzmRkz+
         AgqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=f3Rx3ISSQZbwMoT0/xtI9lPMDRxaNak0z84CcyofG7Y=;
        b=FCy9c9Fn4DuRmR8RzC5hXLKatuHuE+dZcqh5KE+CIwtwOteFpgDf4EcwJK1eVN1+Tz
         RNHefN52g3mc8KuKeOA8V6j+0dZffRkIJU8epbyl/KrFWaudrN8X6D7esdDR8rMI/JUF
         VfvPs0qrJxoLSNcka5OWG0Xlfb8VZGWDqpnhPthhjND3EuLFnTrkfBk1UfTaTZCDxj/P
         YalHg29Gw36RqGGSLVwK4g+DDueK5ce7HgNGieOZAT+Wr42tEvFmh4D2OiiDTquGtBcl
         Np9xN6hzlvHPPn7NPG5mg74k2w8vV6kPz3RiE+6zT48g+8vsS/GX4tndr+pQuHXTb4ri
         a1fQ==
X-Gm-Message-State: AOAM532fTYR2KsjLEU8YK884g8ylseOa2Yuk+bdYR88L5+ZWTkW5FVwz
        xF+ASTGvOdZAAX/qcFa4gHkXcg==
X-Google-Smtp-Source: ABdhPJwvT4btJLmrQ/nxmzHr0aNf3TsIWrhqeIn9zW9/ZXiT+xKZKgf5pv7hocd0pTMSsIWZFa/Vxg==
X-Received: by 2002:adf:f6d0:: with SMTP id y16mr32364409wrp.351.1614177756072;
        Wed, 24 Feb 2021 06:42:36 -0800 (PST)
Received: from localhost.localdomain (lns-bzn-59-82-252-157-252.adsl.proxad.net. [82.252.157.252])
        by smtp.gmail.com with ESMTPSA id p3sm4170669wro.55.2021.02.24.06.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 06:42:35 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, andriy.shevchenko@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-pm@vger.kernel.org (open list:DEVICE FREQUENCY (DEVFREQ))
Subject: [PATCH v2 3/9] devfreq: Use HZ macros
Date:   Wed, 24 Feb 2021 15:42:13 +0100
Message-Id: <20210224144222.23762-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210224144222.23762-1-daniel.lezcano@linaro.org>
References: <20210224144222.23762-1-daniel.lezcano@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

HZ unit conversion macros are available in units.h, use them and
remove the duplicate definition.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Christian Eggers <ceggers@arri.de>
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/devfreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index bf3047896e41..b6d63f02d293 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -26,6 +26,7 @@
 #include <linux/hrtimer.h>
 #include <linux/of.h>
 #include <linux/pm_qos.h>
+#include <linux/units.h>
 #include "governor.h"
 
 #define CREATE_TRACE_POINTS
@@ -33,7 +34,6 @@
 
 #define IS_SUPPORTED_FLAG(f, name) ((f & DEVFREQ_GOV_FLAG_##name) ? true : false)
 #define IS_SUPPORTED_ATTR(f, name) ((f & DEVFREQ_GOV_ATTR_##name) ? true : false)
-#define HZ_PER_KHZ	1000
 
 static struct class *devfreq_class;
 static struct dentry *devfreq_debugfs;
-- 
2.17.1

