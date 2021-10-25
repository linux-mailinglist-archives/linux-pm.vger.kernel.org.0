Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E60443A5F4
	for <lists+linux-pm@lfdr.de>; Mon, 25 Oct 2021 23:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233949AbhJYViB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Oct 2021 17:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233946AbhJYViA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Oct 2021 17:38:00 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325ECC061348
        for <linux-pm@vger.kernel.org>; Mon, 25 Oct 2021 14:35:38 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id g26-20020a63521a000000b0029524f04f5aso6848930pgb.5
        for <linux-pm@vger.kernel.org>; Mon, 25 Oct 2021 14:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=TKRBjHsCjPIxlOUEzR0Pb/eiKAPe4iD4OTxtg9Qg2Kk=;
        b=gW0LmKm+u4QbAACyTrJHmOYLnfYNWriZsR/wK2+bqguI3qJ/PBaVOk+MKVpyE5OQHL
         3D+mq+0xwDGGryFNTSu9kjwrMZ+jZxTjlO1mGlHt4buLbs++7/Iz8MwYiKPlIinFBp78
         BrvGlHHRsmjI2EX60hcP5GX9l9J2VmI7CKcT70rglqqDC+fRhqs1h6b+dewxMI5YVx3A
         D4Vq9fYTbvDmDgnyjgEm05ywPWoIcALKJHdwrlgfxFVhZC3of8vulCcgjIEAJ7Zg8suA
         /dxG02tAT+Vzs2UXveta6nqOq50Yv/3e6gl/cFHF9IL7QxgML/XHaxV18HLOFrWJS8xB
         fh/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TKRBjHsCjPIxlOUEzR0Pb/eiKAPe4iD4OTxtg9Qg2Kk=;
        b=swCW49EObHHbjbPWdhQgk9cCka1q7waF1iM/k69HbFKSNoG4A8NLOzH4K1GHiL+nmH
         Wvgc8FIy0HyFTRhPPlWHp0Awo77sdzR2S+en3BfbGlF1TGFmXMgwY240v71f0QeQ9cPN
         wz9umb2FvxgWzZ/KTeglWxD4nXia2D+7Yc+ePLqRAv/vc2Zmkl5rBpL5s7cvJNgh+non
         DuDi6s8VTbU3u/iTqrI4IeBXv0fp3NLZz5sR/HSgQomyJoS65GxKGRqEEr1D1WrPETqL
         qhOEueJb2J5a/OKfDUJw5wsEuDyNVPe7ums7yyK88lzqh8Y6O3DEkn8iE8uq5qmTYdyu
         WYHA==
X-Gm-Message-State: AOAM533iFKgVI0uqVo+T4rlMVJXO7fLFamn7PPVWYZNSPBb/ObtgWEfw
        aWZJoChFipDn9ogB5wCfsMN+6kMuIac4
X-Google-Smtp-Source: ABdhPJxylj23bhbDXfOwywyglJGgQuaQVa+8V8I4Mo4MBJZH7vWobZ4mPT6W37GoD3U/xaqpW8+LVjazfcWn
X-Received: from rajat2.mtv.corp.google.com ([2620:15c:202:201:5478:3d15:6893:1074])
 (user=rajatja job=sendgmr) by 2002:a17:90b:3793:: with SMTP id
 mz19mr579625pjb.6.1635197737743; Mon, 25 Oct 2021 14:35:37 -0700 (PDT)
Date:   Mon, 25 Oct 2021 14:35:29 -0700
In-Reply-To: <20211025213532.2349161-1-rajatja@google.com>
Message-Id: <20211025213532.2349161-2-rajatja@google.com>
Mime-Version: 1.0
References: <20211025213532.2349161-1-rajatja@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v2 1/3] i2c: designware: Enable async suspend / resume of
 designware devices
From:   Rajat Jain <rajatja@google.com>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dtor@google.com
Cc:     Rajat Jain <rajatja@google.com>, rajatxjain@gmail.com,
        dbasehore@chromium.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Mark the designware devices for asynchronous suspend. With this, the
resume for designware devices does not get stuck behind other unrelated
devices (e.g. intel_backlight that takes hundreds of ms to resume,
waiting for its parent devices).

Signed-off-by: Rajat Jain <rajatja@google.com>
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
v2: Add Jarkko's ack / tested by

 drivers/i2c/busses/i2c-designware-platdrv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 21113665ddea..2bd81abc86f6 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -293,6 +293,8 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 					DPM_FLAG_MAY_SKIP_RESUME);
 	}
 
+	device_enable_async_suspend(&pdev->dev);
+
 	/* The code below assumes runtime PM to be disabled. */
 	WARN_ON(pm_runtime_enabled(&pdev->dev));
 
-- 
2.33.0.1079.g6e70778dc9-goog

