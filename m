Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC2CF566715
	for <lists+linux-pm@lfdr.de>; Tue,  5 Jul 2022 11:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbiGEJwF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Jul 2022 05:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232367AbiGEJvP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Jul 2022 05:51:15 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD04813F81
        for <linux-pm@vger.kernel.org>; Tue,  5 Jul 2022 02:49:59 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id o3-20020a17090a744300b001ef8f7f3dddso3526964pjk.3
        for <linux-pm@vger.kernel.org>; Tue, 05 Jul 2022 02:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dNuDujWN9W1g88kKFQJS4fnKwCoQVZmV8mz8Iq8FU/s=;
        b=BhBQ9g2q9M0kZORA2LG2XIzUp7lCMhxIe5kQhvGIfqCVFNtnBWDtCYi/aSXCzPCe+u
         h7jocr2l1u+4Q9JnBf5J1ZCcBrmAQLy5ZgF4zxXobx7Ao8I6L3VqPN06HBr5kSTu020e
         Z0j+PaSP/GSURTlhhrzZfoMoYnUuzneOYqxu0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dNuDujWN9W1g88kKFQJS4fnKwCoQVZmV8mz8Iq8FU/s=;
        b=jlwoZFSc/y2BjN05BH+69lkGYvmUHPeJYZOO6D0J3AnEK2j2UJ/GxeoFmuPsK45xRc
         a7pZkSl1dscQ2WKfNEkhW2jCzZk8btW5VXMMnwBckGlPR2VqtZwUMOJi/qq82jwbZhuV
         Cr8w2/X5AMeRIrgAYjjMctw/t6FJxltDiaN6qNG42l/KswFun0/+/rW9vigJWzWLoGmH
         akqXTVs2lYJKBLEdV12WZqEH/0oTjuRqeQwbqK6poUD700VS+Nk/5gZfSrM18A9CiAZ/
         2aDA44Al6v/2GawmHsNCLfUklnF/Jzkwz81O7+ptVVEGKgBLT/1o+kCJlMeLAm6UYmzv
         qk1w==
X-Gm-Message-State: AJIora/BMpWcHuiKdQbx10TP4O+UG5hgtLA7c+CEEI47LG4Elc1rDYcQ
        0K+dzLspNnUjIwoPC0XfGgTXeduoEOIjmw==
X-Google-Smtp-Source: AGRyM1srUa7NyStt9XxdcLUu8TEjpzpM9KcuxS4p7FiTh2jnPnLRDGAc5YssLWz/O7Tg/YLTswEFOA==
X-Received: by 2002:a17:903:41c4:b0:16a:1fda:579f with SMTP id u4-20020a17090341c400b0016a1fda579fmr40995717ple.169.1657014599029;
        Tue, 05 Jul 2022 02:49:59 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:c921:5fa9:6620:638])
        by smtp.gmail.com with ESMTPSA id j8-20020a17090a060800b001ed1444df67sm12002232pjj.6.2022.07.05.02.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 02:49:58 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Strudel <tstrudel@google.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Pin-yen Lin <treapking@chromium.org>
Subject: [PATCH] PM: domains: Ensure genpd_debugfs_dir exists before remove
Date:   Tue,  5 Jul 2022 17:49:47 +0800
Message-Id: <20220705094946.827697-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

genpd_debug_remove() may be indirectly called from others while
genpd_debugfs_dir is not yet set. Make sure genpd_debugfs_dir exists
before remove the sub components, otherwise components under
/sys/kernel/debug may be accidentally removed.

Fixes: 718072ceb211 ("PM: domains: create debugfs nodes when adding power domains")
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
An example:
scpsys_probe() in drivers/soc/mediatek/mtk-pm-domains.c indirectly calls
genpd_debug_remove() on probe fail, causing /sys/kernel/debug/usb to be
removed.
---
 drivers/base/power/domain.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 3e86772d5fac5..5a2e0232862e0 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -222,6 +222,9 @@ static void genpd_debug_remove(struct generic_pm_domain *genpd)
 {
 	struct dentry *d;
 
+	if (!genpd_debugfs_dir)
+		return;
+
 	d = debugfs_lookup(genpd->name, genpd_debugfs_dir);
 	debugfs_remove(d);
 }
-- 
2.37.0.rc0.161.g10f37bed90-goog

