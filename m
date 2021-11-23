Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A37EA459FE5
	for <lists+linux-pm@lfdr.de>; Tue, 23 Nov 2021 11:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235369AbhKWKT3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Nov 2021 05:19:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235022AbhKWKT3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Nov 2021 05:19:29 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BBC6C061714
        for <linux-pm@vger.kernel.org>; Tue, 23 Nov 2021 02:16:21 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id d24so38091377wra.0
        for <linux-pm@vger.kernel.org>; Tue, 23 Nov 2021 02:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DZJ0pxIjHebOIgHJhAjt85uASRoyNqvHRW8sK2dJsck=;
        b=bzqyFoJbju0H64NRMsrmMZPfpjr6ROaZo8mf5XCxAiGcJuX4YJOG31hfSbdILuooPS
         U5geXhNTfP1fwUpGVfOXKvLgtt/l1Y66uautoDjwxrwLgfzzvcHrWVoAZQe49anNSmnf
         aPulz+ANJc60ImWLf+pXusZJMViYjzYeKiaoNTk0u2Vyq+aaqa0Ce4RKxOEENp6AD6nx
         ZeKT4bu959EfWnu+GcqjslmsECg72A//xZht1ScKMhUO0ymw1o+KwFbGPGC4jnNkPH19
         gjUCFMkBdkgKu63HsoY/Xa9udovlA/QqAm4m0fbaCk/KdvMrzhGymh7F8L+Ty6Ts+SZa
         krEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DZJ0pxIjHebOIgHJhAjt85uASRoyNqvHRW8sK2dJsck=;
        b=jcEssYF2TfoXwuBn/UQVbRktGVcB8G5KWylkD8zvGxuyCORMP1+vISGxtQHjd6SGig
         NshTBwOTxPro3NYMPMDPbJX+hlVklZrB+HTEQe/o+ngV641a7FtCiHw1QELJn6fFGyav
         zC0cBaFVqqkhiG+r1Og7YfVrcRzM4fEsZBmUCZBWC1ULJkyScfu+dkK5LTBiv94wPxep
         55fi6KTQpf00rCSG6mRrQK9i62MbMhEmZUrWW1kWPzkFeQJkQsUASUPYhrTC1z9SOkhj
         KvlUX1s+LAMJjvkqLDvKxS36RXVSpFvEgYqqFWW+BiJ/VfqIGA1ePwFonGvLmGS52HP8
         l6oQ==
X-Gm-Message-State: AOAM530RcLyOGOpexqRKC37wNQf1RNG1SHjxzMJbKO4I+9QCmhH9tDWH
        kUd0Sld5HCHc6f5S3pDZpvB9JA==
X-Google-Smtp-Source: ABdhPJzqtQ0HmeHz2vTPiJcVo06FjcO174hKk/G8QqiqKsfPzWuVOiWRWIKAxLuj0ZtHtYrjs5mPGQ==
X-Received: by 2002:adf:fed0:: with SMTP id q16mr6033330wrs.276.1637662579661;
        Tue, 23 Nov 2021 02:16:19 -0800 (PST)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:3c04:dd20:bbdc:7a85])
        by smtp.gmail.com with ESMTPSA id v8sm11492662wrd.84.2021.11.23.02.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 02:16:19 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@kernel.org>
Subject: [PATCH 1/2] powercap/drivers/dtpm: Remove unused function definition
Date:   Tue, 23 Nov 2021 11:16:00 +0100
Message-Id: <20211123101601.2433340-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The dtpm.h header file is exporting a function which is not
implemented neither needed. Remove it.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 include/linux/dtpm.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/dtpm.h b/include/linux/dtpm.h
index 2890f6370eb9..d37e5d06a357 100644
--- a/include/linux/dtpm.h
+++ b/include/linux/dtpm.h
@@ -70,6 +70,4 @@ void dtpm_unregister(struct dtpm *dtpm);
 
 int dtpm_register(const char *name, struct dtpm *dtpm, struct dtpm *parent);
 
-int dtpm_register_cpu(struct dtpm *parent);
-
 #endif
-- 
2.25.1

