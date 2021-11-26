Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF5D645F71A
	for <lists+linux-pm@lfdr.de>; Sat, 27 Nov 2021 00:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245123AbhKZXOX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Nov 2021 18:14:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245611AbhKZXMX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Nov 2021 18:12:23 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1EBC061758
        for <linux-pm@vger.kernel.org>; Fri, 26 Nov 2021 15:08:42 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id c4so21626610wrd.9
        for <linux-pm@vger.kernel.org>; Fri, 26 Nov 2021 15:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qbYoHvREwzpSnoVYou5OhDU3fgIZXVmb/TA1x9djirI=;
        b=p2cmLV5Hf8omBqtVLfW9fsGqyehzgadlSykYoS6akK8tBcF2/S3PLUNCcCBrYXJpTj
         Mx+ynN8Yi0NNxoGXqpsJs2l0wEpsBDbSIU8wPvjyVHvpJRnlVF0qI976pb5nGa5wPLgZ
         4uB2VVuDenGRhT1gfOkT8Q53RDAEk6qR0kmmLyBKVCDf91WL5hV8Fc+gbvpMrx59u5iZ
         SvBpmTRTbP4TA1PIo8aEPYupZYAV7NNi5I7ybMZHej9EwQQsEhKfmMhv2XOrp8YluS/B
         Q3FG6ttxlCPNMZAWCxIZZRoEWxeKi/n7CK/G8X4i2SV2lm8b7AeRB/Bi/NecHyogC9z8
         pYQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qbYoHvREwzpSnoVYou5OhDU3fgIZXVmb/TA1x9djirI=;
        b=64RrKuOWfttN37QmD1otpz7npK9vW5Gy3F+H6XGhAgobGj70JBtyvOuNzhlxuhN88M
         LrKBfzrfqn+cAPgtnjjbnQf+j+/RqmdNoGo51WCBunfj8nnVKt9z2R4heDtSJbTaxUr7
         cZGIsYJwzWc69pxZEbIBppoDd6BUV2sxHKuImnBO994dha2djik8qb0V5MiFJ4OJGRQv
         fw3ruulPG2NxX2UxVv7HiEAfZ8kuC7/+WVpmSq7LQZ5VtozDb0s9hBEdzeHzrpb8SG+D
         gaPJlPHLGbI+XIYFpRx+8KG4PozREjxwyb0UTJ8DUlhlk4wNmPG3vFqvvo2tDAaWRdVI
         DZeA==
X-Gm-Message-State: AOAM532rldTNtSAM4ZM7HoUfSxkqNetmgg67N5yJ/AFPcxwQD4xuJL0s
        t2/PZ26NvX63ZsADXzZ7DrDDuA==
X-Google-Smtp-Source: ABdhPJx8sNVncP+qBm3NvhgjazjMTKnFL3Izh/LDWmcpJwolE6cpUx6oJRCTPdkNMsbOBYmXzfyMZA==
X-Received: by 2002:a5d:63ca:: with SMTP id c10mr17367315wrw.124.1637968121314;
        Fri, 26 Nov 2021 15:08:41 -0800 (PST)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:70b:e5b5:f868:20cf])
        by smtp.gmail.com with ESMTPSA id n32sm16234057wms.1.2021.11.26.15.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 15:08:40 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     dsmythies@telus.net, rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukasz.luba@arm.com, gregkh@linuxfoundation.org,
        Daniel Lezcano <daniel.lezcano@kernel.org>
Subject: [PATCH] powercap/drivers/dtpm: Disable dtpm at boot time
Date:   Sat, 27 Nov 2021 00:08:20 +0100
Message-Id: <20211126230820.3441863-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <9821f60a-c562-12e8-bdd4-45dbfe88a117@linaro.org>
References: <9821f60a-c562-12e8-bdd4-45dbfe88a117@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The DTPM framework misses a mechanism to set it up. That is currently
under review but will come after the next cycle.

As the distro are enabling all the kernel options, the DTPM framework
is enabled on platforms where the energy model is not implemented,
thus making the framework inconsistent and disrupting the CPU
frequency scaling service.

Remove the initialization at boot time as a hot fix.

Fixes: 7a89d7eacf8e ("powercap/drivers/dtpm: Simplify the dtpm table")
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/powercap/dtpm.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/powercap/dtpm.c b/drivers/powercap/dtpm.c
index b9fac786246a..fb35c5828bfb 100644
--- a/drivers/powercap/dtpm.c
+++ b/drivers/powercap/dtpm.c
@@ -471,9 +471,6 @@ static int __init init_dtpm(void)
 		return PTR_ERR(pct);
 	}
 
-	for_each_dtpm_table(dtpm_descr)
-		dtpm_descr->init();
-
 	return 0;
 }
 late_initcall(init_dtpm);
-- 
2.25.1

