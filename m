Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 257863243C7
	for <lists+linux-pm@lfdr.de>; Wed, 24 Feb 2021 19:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbhBXSbS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Feb 2021 13:31:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233443AbhBXSbR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Feb 2021 13:31:17 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3211C061786
        for <linux-pm@vger.kernel.org>; Wed, 24 Feb 2021 10:30:36 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id p3so2632043wmc.2
        for <linux-pm@vger.kernel.org>; Wed, 24 Feb 2021 10:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wL1K9/n9PLRogotOLHvr5IREgjJjcX+pqPJAFHVOgkU=;
        b=h8fU3PBtSJjDPXgYs4/F4zTb4uHPnuRvghS3AJGYylHqnn11+oCHrRntCw2aOZXOnr
         KVy23orYJRYTnNI2w2+woHMgi1WG/1OgBES/Lu/gu0gfZG+SVaSFZJp4hzHUBHUAFLBK
         Fu3bbUnpoF/vzDJ0BXmUCMzl9qVuStBA/Hxqs2qVQ5ReNcTSvuoigefy2BE3zyn050Tc
         8tuawF1aelGfd8OPDaGtCb2e4jO61uwnO/E6/aIrQyKMSQHYCo073eDsYBe/gFO1aFAH
         kc+hdIUw0fbr7CgLdhqKDpvnpD5unIDtAFV1YvDw/O8Eq5jx89HJp5W9D1jczRd7q0ls
         FlDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wL1K9/n9PLRogotOLHvr5IREgjJjcX+pqPJAFHVOgkU=;
        b=JGPu7cQ43kLMJJIs5iMvprFTJfNpeZESHGqK8AkSKjjEL8fCUsPC6xfR6zSW1kjDq1
         1Xtm/nj3uKg3Hsc6vBYryEAjr9M+P4JZoLGVqBnXlQ4agZh4BJA2/sRJTcfnzoKsPptQ
         jVfFlA/qGg649uAQ5J9zoPBxvweqs5xIAvep/SsN5ri0/UCoJ466BJXEeP8rjdKhlPkc
         5GRndbKakuFs2Aaj+FziwMHm6McMnSXydI38k5gpx/g5DEm9puv0Aw/yFTotIq3TLqoG
         qWul8HPAuxnhuviXmlU91PxcXYMnqW2Dy2hl9fFb8m21ExGff8H8aClJG0RoZd2Dw+Ui
         lcrQ==
X-Gm-Message-State: AOAM531JIO99xAqy0ULVH97dEFzvr52h3N2gETeYEZCEoFRgUKSQ+h+F
        LQwSxxDf94zqLAFI1/B9ISt3Fw==
X-Google-Smtp-Source: ABdhPJzuaCGVLQBXibxUShW+ewHVnBZ8EoV2btHiqLSkz3hyIphMVMElhwBxNmR7UVT1qw+fL8pypw==
X-Received: by 2002:a05:600c:2942:: with SMTP id n2mr515523wmd.137.1614191435563;
        Wed, 24 Feb 2021 10:30:35 -0800 (PST)
Received: from localhost.localdomain (lns-bzn-59-82-252-157-252.adsl.proxad.net. [82.252.157.252])
        by smtp.gmail.com with ESMTPSA id c12sm5105987wru.71.2021.02.24.10.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 10:30:35 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 2/2] powercap/drivers/dtpm: Add the experimental label to the option description
Date:   Wed, 24 Feb 2021 19:30:22 +0100
Message-Id: <20210224183022.11846-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210224183022.11846-1-daniel.lezcano@linaro.org>
References: <20210224183022.11846-1-daniel.lezcano@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The DTPM framework will evolve in the next cycles. Let's add a
temporary EXPERIMENTAL tag to the option so users will be aware the
API may change over time.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/powercap/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/powercap/Kconfig b/drivers/powercap/Kconfig
index 20b4325c6161..8242e8c5ed77 100644
--- a/drivers/powercap/Kconfig
+++ b/drivers/powercap/Kconfig
@@ -45,7 +45,7 @@ config IDLE_INJECT
 	  on a per CPU basis.
 
 config DTPM
-	bool "Power capping for Dynamic Thermal Power Management"
+	bool "Power capping for Dynamic Thermal Power Management (EXPERIMENTAL)"
 	help
 	  This enables support for the power capping for the dynamic
 	  thermal power management userspace engine.
-- 
2.17.1

