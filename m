Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11B1432FAAF
	for <lists+linux-pm@lfdr.de>; Sat,  6 Mar 2021 13:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbhCFMeZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 6 Mar 2021 07:34:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbhCFMeX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 6 Mar 2021 07:34:23 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A479FC06174A;
        Sat,  6 Mar 2021 04:34:23 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id j12so3933453pfj.12;
        Sat, 06 Mar 2021 04:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2bel8WxAAVdcg7Ih/Zmgmx7/7DH0OduvfVoBZIrEeZQ=;
        b=K8XNwsaCAedUfgHw5brelHxc40hYnjGSrw8iqQnmumDQjL7zEqJ5vbVWEJQk1/x/rP
         EK7lEHuMhfBe7YB7PWfmhh1B2IAXwNojq6u42WmIf6j3XRRMWSgiqPw9vNBBV74HpscL
         sywfB03Jt3mV2WKzqy5UuQbHPSbVlDRcEj1TJAHyIRFzbZIRNJamKDqnP4YTtfwAfQA/
         8lPfaXwYzjbxUJVJE0VNKLvQjQbmB6vnJzuBe42g+8nGU8KUByoVDAvKAdBiyHIELncm
         FRJ2SXwbu6qMXhPFUNASuWwoM8nXMcPbd+MlEvZ/0OxqBuZwnAnoEduUVMfAW/HmQXVu
         58aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2bel8WxAAVdcg7Ih/Zmgmx7/7DH0OduvfVoBZIrEeZQ=;
        b=OgxsC8mbZx17ls1zb4a3bC0fz5AAZ/6tvJSV6JwbfPSszBKqxuWFQlrSrurXEa9+Mk
         1ImcLuB3qF7RkZE48wstw7YPtRpPzQRFUagfVMz0iy9iOEBdwKBB6L9AOCPXeec4JkIK
         OVrN2zhJwThH8r4zl6diDpogA15uNh6uj1CeNyaPwzdEKulPNPDsNN0fNQFgPqWw5Zib
         LZiekrbJQyNTNLwAmGYNVHm86UYbRaX22k10VM27fuTbyQZajtiS5OLkyBLFqY4g9Sto
         adoSemLeLSF9EkdLzTpeV7ixmUVvoQmcUyRv9uDe+yfO7K8MIM/jwqtwYh6nDiUVCWdW
         wkSA==
X-Gm-Message-State: AOAM531oAbAeCF7UX6cGNJuD+YE+KU1B/5aTXwSChWyoIrublOIU2OMu
        +xmDH8uy8t3kIQGWAQ0yaov5SyrIGKA=
X-Google-Smtp-Source: ABdhPJya8uPVCXWvY0+dz+/eXOc3M1PQKgeisV/hRI5+wB23z1f8VGAmanybyVPR0S3xnHVNsMus9A==
X-Received: by 2002:a05:6a00:2296:b029:1b6:6972:2f2a with SMTP id f22-20020a056a002296b02901b669722f2amr13212655pfe.69.1615034062844;
        Sat, 06 Mar 2021 04:34:22 -0800 (PST)
Received: from localhost.localdomain ([178.236.46.205])
        by smtp.gmail.com with ESMTPSA id e1sm5114566pjt.10.2021.03.06.04.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 04:34:22 -0800 (PST)
From:   menglong8.dong@gmail.com
X-Google-Original-From: zhang.yunkai@zte.com.cn
To:     edubezval@gmail.com
Cc:     j-keerthy@ti.com, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amitk@kernel.org, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhang Yunkai <zhang.yunkai@zte.com.cn>
Subject: [PATCH] thermal:ti-soc-thermal: remove duplicate include in ti-bandgap
Date:   Sat,  6 Mar 2021 04:34:15 -0800
Message-Id: <20210306123415.219441-1-zhang.yunkai@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Zhang Yunkai <zhang.yunkai@zte.com.cn>

'of_device.h' included in 'ti-bandgap.c' is duplicated.
It is also included in the 25th line.

Signed-off-by: Zhang Yunkai <zhang.yunkai@zte.com.cn>
---
 drivers/thermal/ti-soc-thermal/ti-bandgap.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
index 8a3646e26ddd..d81af89166d2 100644
--- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
+++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
@@ -32,7 +32,6 @@
 #include <linux/pm_runtime.h>
 #include <linux/pm.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 
 #include "ti-bandgap.h"
 
-- 
2.25.1

