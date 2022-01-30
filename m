Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0F474A39A7
	for <lists+linux-pm@lfdr.de>; Sun, 30 Jan 2022 22:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356436AbiA3VCe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 30 Jan 2022 16:02:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356391AbiA3VC1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 30 Jan 2022 16:02:27 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06291C06173B
        for <linux-pm@vger.kernel.org>; Sun, 30 Jan 2022 13:02:27 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id c23so21621780wrb.5
        for <linux-pm@vger.kernel.org>; Sun, 30 Jan 2022 13:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MNQUuQFFfpeWugiolZqopaG6OtAWAYvBDQU1DSusnnk=;
        b=kHh6+rnAfh1UicGsC+iJz9NJQum0K2Cxfwo4EqwieSebI9JjCzku9c+/47G38UUuuS
         OMZ9UMlxqVkK1n1TuEvSgEESwt2BSbn2IfkLx4Rc8qxW9NOrdgJ/bSED5jAOrNXM3EtJ
         lTZLyHJEufuRQdpYbgHsGC8Ts4qncbAug9thUjRUm2n0kk/1iO4QT3pUHZVbWtTF7hIf
         /HnMPGBos/MHr+Zx2okCr8mjdtkGr2cy7Akp+A1jIHwsnaGDpwFnEo6zggRlT1jKt4Y1
         wFfs6rICskTLjQE2VCdu021HMul+hsBRy6s8mvrCRO4+hvrbUvoTzDAcYnaM8XTEJsAq
         7k/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MNQUuQFFfpeWugiolZqopaG6OtAWAYvBDQU1DSusnnk=;
        b=GdUYOTvH4htj24MXmqnJH65RvyHfIaTHM0WF0o2sUI+5O32l89iyaD9zpa51FwxAu/
         89N3DoBm9lkSco82kCJYNO+kK8QIM2TKIy7WC7FeS+45Sv7xYJVNTk2TtPw93yI8iDlW
         0evg1ueegqaju+QK8hqTENU64lB2lJcrWyQsyhbcVT27RZ7plcgdGLDGEhKsEaj8AD1d
         SibpJm4qA+JOKI9DBeX4CO1utiAYpJsf1fD6J6CDlMmWowieEXN+9fuO3kpfhXgUa3ub
         8P9TnuK0fBZJerFOiGVEsU7yJ/GkoTuj3UohF49l/zyHpHPsc5h+o+nYNRNH2vQqEn/z
         1QqQ==
X-Gm-Message-State: AOAM532xt8/XYYpgM3/ni2shifym1LdVmETm7+2npmEI1O8ocy1lgTdt
        6orpHAY8aCYJtZTfClnoKZxeNw==
X-Google-Smtp-Source: ABdhPJwnWuziiq1f4PdtrcCYU1OtKdjwSfYjmTBoTDV76XQcm47JlfCtRFtPAz9INT1cD5L8qeIjoQ==
X-Received: by 2002:adf:fe01:: with SMTP id n1mr15207083wrr.141.1643576545483;
        Sun, 30 Jan 2022 13:02:25 -0800 (PST)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:d3c5:fe0:78a4:5227])
        by smtp.gmail.com with ESMTPSA id i6sm9845185wrw.8.2022.01.30.13.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 13:02:24 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rjw@rjwysocki.net
Cc:     heiko@sntech.de, lukasz.luba@arm.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, ulf.hansson@linaro.org,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC
        support),
        linux-rockchip@lists.infradead.org (open list:ARM/Rockchip SoC support)
Subject: [PATCH v1 7/7] dtpm/soc/rk3399: Add the ability to unload the module
Date:   Sun, 30 Jan 2022 22:02:09 +0100
Message-Id: <20220130210210.549877-7-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220130210210.549877-1-daniel.lezcano@linaro.org>
References: <20220130210210.549877-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The dtpm hierarchy can now be removed with the
dtpm_destroy_hierarchy() function. Add the module_exit() callback so
the module can be unloaded by removing the previously created
hierarchy.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/soc/rockchip/dtpm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/soc/rockchip/dtpm.c b/drivers/soc/rockchip/dtpm.c
index ebebb748488b..5a23784b5221 100644
--- a/drivers/soc/rockchip/dtpm.c
+++ b/drivers/soc/rockchip/dtpm.c
@@ -52,6 +52,12 @@ static int __init rockchip_dtpm_init(void)
 }
 module_init(rockchip_dtpm_init);
 
+static void __exit rockchip_dtpm_exit(void)
+{
+	return dtpm_destroy_hierarchy();
+}
+module_exit(rockchip_dtpm_exit);
+
 MODULE_SOFTDEP("pre: panfrost cpufreq-dt");
 MODULE_DESCRIPTION("Rockchip DTPM driver");
 MODULE_LICENSE("GPL");
-- 
2.25.1

