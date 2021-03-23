Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3FAF34612D
	for <lists+linux-pm@lfdr.de>; Tue, 23 Mar 2021 15:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbhCWOPo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Mar 2021 10:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbhCWOPa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Mar 2021 10:15:30 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC46DC061574;
        Tue, 23 Mar 2021 07:15:29 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id h10so23590516edt.13;
        Tue, 23 Mar 2021 07:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KIib56X/7jLsOZcTZP1ltIUNXuXCqixlOs7iGx7lL3g=;
        b=Qqs1OXy4jF4mqYpg/nTLcCwPZVr1oFJ/Bq/9rQ+0Ibhd4Gqi2bbRSRA0FR1nZNVWnr
         5+2y2kc4P0gXxTCezKgOO2nq4yiSYkFOkFO9E7qgVtVIB+z7UeoTrTiOVMYBGHxkETkz
         e7dLwcF0oetqq+X1LITBqY60KTkvffim4FpBwfmwrsBaPHscgDTVBFs/Otj6X4vXCSMN
         j2DtHzMM6EBNdITtqsKkZStkQS6K/8sk92iRPM0gbH97rEK8J2grhuFlqhzde4e8dt8T
         Ml+QhDrt2sYgIUOhpoIAte6sMNFM+GPe5IuHN4USYXsAfytNTK2JDyjyJdhAO4ZUg8HT
         OokA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KIib56X/7jLsOZcTZP1ltIUNXuXCqixlOs7iGx7lL3g=;
        b=XiF/g6MNEAmZz3ua6fDg42o3XGor9YDB+MW9rKt3JZH8qWvSEvlnbYJTGk4b+QuotD
         bnDVYyFR+bJy+LEa0norA2dzxnKI3bJKHl17aVNV+ydKcpzirgrsWux0ztuWOmv+KUXn
         kbIRB3u9I+aFG0JOzM2Ai4ky22EXenKvBINQzXREafSUPXiyiHaPvkBUhmi6tTmZ581N
         BlAvtvMR0KpOYAOSoWHfz+JJZmpzmwv7Y152nzliCNXutoxC7UGhpKzYV2mwajcQVoCW
         vltf3XfGNcgdQaLZVNygTZ6MTGeoBgp7fOOxhozHn8XT+ujh1peyMJk+rIIRTtTBJoYq
         Z8Xw==
X-Gm-Message-State: AOAM532HJ0/m8wRpjRRk24dyNKfbSOKY7+IDA0dkWJQslRqtM9utuQcZ
        Gy7So8vBTUdUL7QaOsJYJaoiJebvBJih9Gng
X-Google-Smtp-Source: ABdhPJydwZylWjTpCsRopRQGQVhAUpVA0AsjCftXq2VPCPBXvIGOg+9D4sbAi0t9j+uTbDQ9a5ZIGA==
X-Received: by 2002:a05:6402:3075:: with SMTP id bs21mr4850193edb.274.1616508928570;
        Tue, 23 Mar 2021 07:15:28 -0700 (PDT)
Received: from localhost.localdomain ([176.88.28.231])
        by smtp.gmail.com with ESMTPSA id f3sm11297789ejd.42.2021.03.23.07.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 07:15:28 -0700 (PDT)
From:   Necip Fazil Yildiran <fazilyildiran@gmail.com>
To:     rjw@rjwysocki.net
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, paul@pgazz.com, jeho@cs.utexas.edu,
        julianbraha@gmail.com,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>
Subject: [PATCH v2] PM: Kconfig: fix unmet dependency for PM_SLEEP_SMP
Date:   Tue, 23 Mar 2021 17:14:06 +0300
Message-Id: <20210323141405.55115-1-fazilyildiran@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When PM_SLEEP_SMP is enabled and HOTPLUG_CPU is disabled, it results in
the following Kbuild warning:

WARNING: unmet direct dependencies detected for HOTPLUG_CPU
  Depends on [n]: SMP [=y] && (PPC_PSERIES [=n] || PPC_PMAC [=n] || PPC_POWERNV [=n] || FSL_SOC_BOOKE [=n])
  Selected by [y]:
  - PM_SLEEP_SMP [=y] && SMP [=y] && (ARCH_SUSPEND_POSSIBLE [=n] || ARCH_HIBERNATION_POSSIBLE [=y]) && PM_SLEEP [=y]

The reason is that PM_SLEEP_SMP selects HOTPLUG_CPU without depending on
or selecting HOTPLUG_CPU's dependencies.

Let PM_SLEEP_SMP depend on HOTPLUG_CPU's dependencies to avoid Kbuild issues.

Signed-off-by: Necip Fazil Yildiran <fazilyildiran@gmail.com>
---
v1->v2:
* Keep selecting HOTPLUG_CPU by PM_SLEEP_SMP as it needs to be selected
automatically, let PM_SLEEP_SMP depend on missing dependencies instead.
---
 kernel/power/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
index 6bfe3ead10ad..0c4aa403e04a 100644
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -125,6 +125,7 @@ config PM_SLEEP_SMP
 	depends on SMP
 	depends on ARCH_SUSPEND_POSSIBLE || ARCH_HIBERNATION_POSSIBLE
 	depends on PM_SLEEP
+	depends on PPC_PSERIES || PPC_PMAC || PPC_POWERNV || FSL_SOC_BOOKE
 	select HOTPLUG_CPU
 
 config PM_SLEEP_SMP_NONZERO_CPU
-- 
2.25.1

