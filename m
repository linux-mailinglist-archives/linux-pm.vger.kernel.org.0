Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBA4333C95
	for <lists+linux-pm@lfdr.de>; Wed, 10 Mar 2021 13:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbhCJMZN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Mar 2021 07:25:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbhCJMYq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Mar 2021 07:24:46 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC383C061760;
        Wed, 10 Mar 2021 04:24:45 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id 16so10438388pfn.5;
        Wed, 10 Mar 2021 04:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=wuZ7Tj7BwTy6hVZuAWi1nQ3E4gOZYnPzBXefRg0kZPU=;
        b=Iq6hc4p3pEUPX0ryf5lZ+7v2GqP86f7RHCdcs4xXkaJiaBWqrfN2wCf1wqzRQtBBEY
         rNDPsVRzJCDzbhetPy+rCaW5uCal3vExi/2xcmYpL236fnMMVTiwmvmmBCqT9sLVRWaD
         BZZMCKwJvN96RElmxWyqFPVAv3LG62pUZiIsKsVIessbaT3DOr0duoxmoMYW6+OClugt
         llqyclovZ0nVyQqazJh7U4Nw2rmyhYpDzztYTPkSsHvBX5HPoA/oEXCCCLVaxOxomROX
         CPuwOcHrhjpvtUycyDzNdb20CH7IC3LUxxUvx+P/uD/DKehb32SH6P0qPAS0ZLmJwd1u
         vWcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wuZ7Tj7BwTy6hVZuAWi1nQ3E4gOZYnPzBXefRg0kZPU=;
        b=gJD8iukC39eHCBr3Snv7AMjY/UJWgn9NMro9hVJFaoALVT4JUgwrHkJSreX2nP64Nu
         l/T80+9Rn5Du2O0RAUPYmk0kuhPmAPrmLh990Oog0EQp/zVagpL7hfQVKNbrkuW5Q0VA
         142aaBlBHlNbPXthrYJis/lfhOlLhe5eQnZt3XXRgMfVcCTYPAtp0o6n2tZ22Wtcp5+0
         Nqd82CDL6TxhuzPGieyuIKc4HfIjjyVexqhaUBYSZZeaj0Esf1KoVZ0aSqkSO67aL0zv
         4Xb7zpx8j/1m4cCe6Q1O0YjOAPS23AfyipYrKKO82j/9xRY0MZgPcRAau6xGJDJNTcd9
         OgmA==
X-Gm-Message-State: AOAM531HZQZQyvtMET+E3S12XuL+QmP0ykCZHsp7yn4QDgCgH9vGwz/H
        6J64Q7svaFWEchrh+czCHDc=
X-Google-Smtp-Source: ABdhPJwFPu5GUYLlVOCrnQ+Z3JHSMv/JOMDoEsza7h6uis5elP6ntNkeM3u+j8pKmPdAsaO2mK3CJQ==
X-Received: by 2002:a62:ac1a:0:b029:1f9:5ca4:dd4d with SMTP id v26-20020a62ac1a0000b02901f95ca4dd4dmr2553621pfe.68.1615379085246;
        Wed, 10 Mar 2021 04:24:45 -0800 (PST)
Received: from localhost.localdomain ([45.135.186.89])
        by smtp.gmail.com with ESMTPSA id c193sm17433859pfc.180.2021.03.10.04.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 04:24:44 -0800 (PST)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH v2] thermal: thermal_of: fix error return code of thermal_of_populate_bind_params()
Date:   Wed, 10 Mar 2021 04:24:23 -0800
Message-Id: <20210310122423.3266-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When kcalloc() returns NULL to __tcbp or of_count_phandle_with_args() 
returns zero or -ENOENT to count, no error return code of
thermal_of_populate_bind_params() is assigned.
To fix these bugs, ret is assigned with -ENOMEM and -ENOENT in these
cases, respectively.

Fixes: a92bab8919e3 ("of: thermal: Allow multiple devices to share cooling map")
Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
v2:
* Add the fixing about of_count_phandle_with_args() and the fixes tag.
  Thank Daniel Lezcano for good advice.

---
 drivers/thermal/thermal_of.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 69ef12f852b7..5b76f9a1280d 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -704,14 +704,17 @@ static int thermal_of_populate_bind_params(struct device_node *np,
 
 	count = of_count_phandle_with_args(np, "cooling-device",
 					   "#cooling-cells");
-	if (!count) {
+	if (count <= 0) {
 		pr_err("Add a cooling_device property with at least one device\n");
+		ret = -ENOENT;
 		goto end;
 	}
 
 	__tcbp = kcalloc(count, sizeof(*__tcbp), GFP_KERNEL);
-	if (!__tcbp)
+	if (!__tcbp) {
+		ret = -ENOMEM;
 		goto end;
+	}
 
 	for (i = 0; i < count; i++) {
 		ret = of_parse_phandle_with_args(np, "cooling-device",
-- 
2.17.1

