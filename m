Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 468542240BA
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jul 2020 18:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgGQQmc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Jul 2020 12:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbgGQQma (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jul 2020 12:42:30 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B43C0619D3
        for <linux-pm@vger.kernel.org>; Fri, 17 Jul 2020 09:42:28 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f2so11833094wrp.7
        for <linux-pm@vger.kernel.org>; Fri, 17 Jul 2020 09:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Uf8bzKAkN9OCCDfHeegI3pqxuhYTL3n6jrxOgpitcxs=;
        b=e2YzeDrsy9g/TykVozOONhF8n8NR0N3bSvPoLKREGAOIv04Oh1OeVj/d2Zl5iZnGB7
         JZJ/NyA3lz+4fOZTnN7lBDfWN7SpL05GrAkRSKteAaL299ZOj8GFuW9hLzJ+9AdosSlo
         VVPT5m1dZlQkSvN9dj4oq+hFPlrAqGlQzOadz+6lSorgatkdZh1JUL4qHg9iqlrOf6pJ
         97Yz91dTs/I8QdlnNFyuTXv7tLPY533N88zGnEsLAH6jA+2ZMzN3RJyX4r+RyPP2vTkW
         AmUfE9drvd5qEpy8/EOhNIJ5i2f1X+FQ0+O/pobNalUzXEzVAwVlYFBCQzuvU3XssIRR
         cc8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Uf8bzKAkN9OCCDfHeegI3pqxuhYTL3n6jrxOgpitcxs=;
        b=FbbfUlvjwYRIsaXh1GDooWUqjZZhJQD6FEMCih4VN0aDjQah2iFlkaqgUE/YZ0CXPj
         bEF16b21FvNyOoPgkQdFAFhColqAx+zrb2SixfU8Xx6T36TpAK9pa/yDc7Qmn0QxfHcH
         htfEgRidGTpsJ6y39YeQS2vQ8KGveQbnwplDY3/faFN99rBrtTEa5H7Et7PiPs8/hG02
         OWKBV8Skv7Kc5m8knAQT62SEJVWfjco/HcSAOVV8gL91DWjABGdFsCwWMRXdho739vWT
         6+e2tOhAim1O5ooqEi/43+REmxoZ6C69Yru4b2xeDYWt38L16nrPFxDkzt13Hk79JXbf
         uurA==
X-Gm-Message-State: AOAM531BbHbmWpgqJm+2qsSo5GB4nBErsANAZkGXlfyMbcFEKL778D7s
        TIRm+BRnl3TwjVuDznPL6sGPe/aROAU=
X-Google-Smtp-Source: ABdhPJxPd7iCY+hsRcY6KNpNMkoDYU2RJT5i7Bi5H6fXUVMxabIOEjAzIJGqw097rU6IOJDwIru/fQ==
X-Received: by 2002:adf:f203:: with SMTP id p3mr11318444wro.331.1595004147174;
        Fri, 17 Jul 2020 09:42:27 -0700 (PDT)
Received: from localhost.localdomain (lns-bzn-59-82-252-131-168.adsl.proxad.net. [82.252.131.168])
        by smtp.gmail.com with ESMTPSA id q5sm15312610wrp.60.2020.07.17.09.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 09:42:26 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        m.szyprowski@samsung.com, amit.kucheria@linaro.org
Subject: [PATCH 2/2] thermal: core: Move initialization after core initcall
Date:   Fri, 17 Jul 2020 18:42:17 +0200
Message-Id: <20200717164217.18819-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200717164217.18819-1-daniel.lezcano@linaro.org>
References: <20200717164217.18819-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The generic netlink is initialized at subsys_initcall, so far after
the thermal init routine and the thermal generic netlink family
initialization.

On ŝome platforms, that leads to a memory corruption.

The fix was sent to netdev@ to move the genetlink framework
initialization at core_initcall.

Move the thermal core initialization to postcore level which is very
close to core level.

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index c2e7d7aaa354..79551bb6cd4c 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1617,4 +1617,4 @@ static int __init thermal_init(void)
 	mutex_destroy(&poweroff_lock);
 	return result;
 }
-core_initcall(thermal_init);
+postcore_initcall(thermal_init);
-- 
2.17.1

