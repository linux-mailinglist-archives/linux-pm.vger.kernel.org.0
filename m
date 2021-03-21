Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1962B34349A
	for <lists+linux-pm@lfdr.de>; Sun, 21 Mar 2021 21:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbhCUUT7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 21 Mar 2021 16:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbhCUUTs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 21 Mar 2021 16:19:48 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808FEC061574;
        Sun, 21 Mar 2021 13:19:47 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id bf3so16913041edb.6;
        Sun, 21 Mar 2021 13:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8OrTT0saD0tGov5FNdr6kb239PnSO+8Nf5rWUBV4WE4=;
        b=eijbu2QuScvnFblen4RPksW0zKmVkVkbNftVM9OX1+z3+whKBSdYksKtdnLNH9TYUD
         ZcAs8n1FSV6Ik8uOS3QfuypEvoyfLTaCVS0cmLNaHxblPrlNlszSoGrDl9TbNQ7844vl
         jyLVuXouVG9B1ewTqzc3BegC70nHYf7gzxMxmUgT9DRPDhZlWGuCNbRY4onx/UWMQyql
         1m15MwaznhxQDwAP0fbvCfqhR/PEKPi5osWFafc/01v/k2h/VeUpl8SRk3to6kL+nEDO
         NiNIbMl3vBcVuCtQ+dNIkhVFOicqhqDnTUL0kPp2GPW4L7PfapOfFcVyhhJukRi7aGUe
         yLWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8OrTT0saD0tGov5FNdr6kb239PnSO+8Nf5rWUBV4WE4=;
        b=lcXKKd2QiuCFoJjl48y6/L00EibjV8A1stVMN8ROtc+167YwiF+H1aY33ndRFtEiq5
         UNkgcrcS9aAL8kjFqItzjGyRrs+rGRhBu4IXQbppQEU8jzNWSRDIyBZ6lhSxbIAH1zju
         oGB5x44awkERt8LTNO8jLOP5ewHHNaaXLJrSPZQeXjKwmVkwyG6pHf/BKq7B08oqzCfO
         7hcJDibrPddW1HsDH/KVzVGXR+g6MpfX18t1mk1sXQhkBYcjOF3RtdJbnct1O3pxHLhy
         SGvLzKrCMcZbbg+Jb0YHdjD8PaDCGGulKFYubGayjnJdfhIl7yz0JRXZUrvx6EaWq533
         8acQ==
X-Gm-Message-State: AOAM5318rqtN0wQJi4rbk/qcRKXLBLxn8zB3vcIAcbxr5yXt6DiF0gJV
        XsXTvhdB+/tYx1vHNW8IVhA=
X-Google-Smtp-Source: ABdhPJyS4A4hsa8Y60qvZS8mPQfNCewndNG/g8cMjMyMeMfqSeBeHp5tq3Gsp5CvrlnSROGUoRk7Vw==
X-Received: by 2002:aa7:db4f:: with SMTP id n15mr21961647edt.12.1616357986291;
        Sun, 21 Mar 2021 13:19:46 -0700 (PDT)
Received: from localhost.localdomain ([176.42.17.204])
        by smtp.gmail.com with ESMTPSA id gb22sm7623155ejc.78.2021.03.21.13.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 13:19:45 -0700 (PDT)
From:   Necip Fazil Yildiran <fazilyildiran@gmail.com>
To:     rjw@rjwysocki.net
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, paul@pgazz.com, jeho@cs.utexas.edu,
        julianbraha@gmail.com,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>
Subject: [PATCH] PM: Kconfig: fix unmet dependency for PM_SLEEP_SMP
Date:   Sun, 21 Mar 2021 23:18:19 +0300
Message-Id: <20210321201818.15271-1-fazilyildiran@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When PM_SLEEP_SMP is enabled and HOTPLUG_CPU is disabled, it results in the
following Kbuild warning:

WARNING: unmet direct dependencies detected for HOTPLUG_CPU
  Depends on [n]: SMP [=y] && (PPC_PSERIES [=n] || PPC_PMAC [=n] || PPC_POWERNV [=n] || FSL_SOC_BOOKE [=n])
  Selected by [y]:
  - PM_SLEEP_SMP [=y] && SMP [=y] && (ARCH_SUSPEND_POSSIBLE [=n] || ARCH_HIBERNATION_POSSIBLE [=y]) && PM_SLEEP [=y]

The reason is that PM_SLEEP_SMP selects HOTPLUG_CPU without depending on or
selecting HOTPLUG_CPU's dependencies.

Let PM_SLEEP_SMP depend on HOTPLUG_CPU instead to avoid Kbuild issues.

Signed-off-by: Necip Fazil Yildiran <fazilyildiran@gmail.com>
---
 kernel/power/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
index 6bfe3ead10ad..8b53c9b61347 100644
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -125,7 +125,7 @@ config PM_SLEEP_SMP
 	depends on SMP
 	depends on ARCH_SUSPEND_POSSIBLE || ARCH_HIBERNATION_POSSIBLE
 	depends on PM_SLEEP
-	select HOTPLUG_CPU
+	depends on HOTPLUG_CPU
 
 config PM_SLEEP_SMP_NONZERO_CPU
 	def_bool y
-- 
2.25.1

