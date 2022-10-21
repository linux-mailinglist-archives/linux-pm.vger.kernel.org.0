Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80BF5607A36
	for <lists+linux-pm@lfdr.de>; Fri, 21 Oct 2022 17:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiJUPLV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Oct 2022 11:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbiJUPKh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Oct 2022 11:10:37 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2493167242
        for <linux-pm@vger.kernel.org>; Fri, 21 Oct 2022 08:10:35 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id bp15so5567430lfb.13
        for <linux-pm@vger.kernel.org>; Fri, 21 Oct 2022 08:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iOR9Cn2Ao7LcbAtkV7YNTyZf2Awy47Ush30fTe6NZ7o=;
        b=fumjPWjQIGVgJu1cVeqC9EpaFn0B5jT9PyBcxd6bHUvIZ5/THEeiHLj/jXOXYN6JM/
         3YcHnUceJdvMZzIhZYMTCxarOoMoIswIH5yLpCX/+rRe6iUDsh97NZdGXHSTvF0T76xG
         YDicGmnc9uT9Msc3k+OCraODleHuYdSm08c/m60SrutHpHJKyjlrg/poU6RkX6loVxr2
         3NMCxhewOWuxeGGwll7RDSSeNkYNiyA6nxXTTfE93IO3RGp7+pWGt6oo9r8NszbWsvwR
         gbUTowFMGUWQV43bbGGFT8c9D5yp5JrXob++0d0DDRyR3uvez6EHKvSedO/IGlpuXPEZ
         eBaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iOR9Cn2Ao7LcbAtkV7YNTyZf2Awy47Ush30fTe6NZ7o=;
        b=xd9t/4XNd0bR8VEr8yCdVv7y2P+ZIjssuUS6jmLCdvyDUsyotDksc0PwXHptYDsjsb
         NUj+iiReN1M/fdwqgrd6FdchEk5VOkf4XMOhOTfmxois2gRJ2/AXJATvWvDiQR52+OIo
         lWTT58r80wjT0a7+ZrQ+cxjEKpOR0AcVIzc7evGLk8LjJBDQdRRMX3wrb3C10wM84Tpm
         4go0V8rKmZ+MCRUEyuLC1pPwXxw1wALzyuzueJ5BWeNQpROxrEJQqCvgQMPSFy3HR0Nz
         aVei10c4jI+N0OM6zKPHnIBZ0Gf4SsmQiLmgAoJbRuk9/hVnZjBL+9IkSuIeY45ABS+/
         ThAg==
X-Gm-Message-State: ACrzQf07jM3mwqLFKiaowj1OLo/ShDLI3te/UNCegw5W2SC6787h1RQG
        lDNYpHaqn8tfnlAY5oGD4UDgzQ==
X-Google-Smtp-Source: AMsMyM4iURBeXV/sf9FyHh5MsVjFysPtxLXdAshK9S6YJaXUzdBzXiA9OI5BUaRS4gWE+zs8LR9GTQ==
X-Received: by 2002:a05:6512:3a82:b0:4a4:7fc1:35b2 with SMTP id q2-20020a0565123a8200b004a47fc135b2mr6740050lfu.369.1666365034343;
        Fri, 21 Oct 2022 08:10:34 -0700 (PDT)
Received: from uffe-XPS13.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id s10-20020a056512202a00b0049476667228sm3199764lfs.65.2022.10.21.08.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 08:10:33 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] cpuidle: dt: Clarify a comment and simplify code in dt_init_idle_driver()
Date:   Fri, 21 Oct 2022 17:10:13 +0200
Message-Id: <20221021151013.148457-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221021151013.148457-1-ulf.hansson@linaro.org>
References: <20221021151013.148457-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The drv->state_count is assigned the total number of available states, so
let's make that clear.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/cpuidle/dt_idle_states.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/cpuidle/dt_idle_states.c b/drivers/cpuidle/dt_idle_states.c
index 448bc796b0b4..7ca3d7d9b5ea 100644
--- a/drivers/cpuidle/dt_idle_states.c
+++ b/drivers/cpuidle/dt_idle_states.c
@@ -211,12 +211,9 @@ int dt_init_idle_driver(struct cpuidle_driver *drv,
 	of_node_put(cpu_node);
 	if (err)
 		return err;
-	/*
-	 * Update the driver state count only if some valid DT idle states
-	 * were detected
-	 */
-	if (i)
-		drv->state_count = state_idx;
+
+	/* Set the number of total supported idle states. */
+	drv->state_count = state_idx;
 
 	/*
 	 * Return the number of present and valid DT idle states, which can
-- 
2.34.1

