Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3DEE3A25F7
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jun 2021 09:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbhFJIAj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Jun 2021 04:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbhFJIAg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Jun 2021 04:00:36 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D53C061574
        for <linux-pm@vger.kernel.org>; Thu, 10 Jun 2021 00:58:40 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id e20so10000023pgg.0
        for <linux-pm@vger.kernel.org>; Thu, 10 Jun 2021 00:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z8Q0hqWJSG4oD1OkwryocprVGZHye8iWaplw5ZkUYjk=;
        b=tcc/C0wbgpnfYomjqB3ocj6Nb8I8xhnoeQshcEO4ywGIcuxtdcl1MlWkUXy3/cppz9
         MZeqe+cn2yn0t+lFTHTGY4yLSk3q/s2itTQTRvXycbeYi1EBU+gnzh05nxs7uJTnCqpp
         ssh6Oe1+M3CF4xUREFWqQgEbsTBLkoGEWzYBIe73u3ZRP6uXeY4+/hzE2dIrzPu09ijI
         tespyZShSOfEaIMFdCb4RY5LAyugA+cTVn35V7+ipeI+sXz2ZSDk+hjsH964P7U/SO73
         udNSAqgllOXdsOIduXzvflaiejZFb03Q/NcLDp4Y1YJocM9Zo2YQicT/pZ1HtnrUuuF+
         PI4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z8Q0hqWJSG4oD1OkwryocprVGZHye8iWaplw5ZkUYjk=;
        b=DAYOcKu4bEXka41xFtii4iwRlJ4W7rv2+50L4FjS6wUwUo/Q5p5pQIq8Tt5GJ3m6hm
         E23p2X77o4YlNXTp1LeB4+SQsqdqAI7d1cG/sz7o2TLSpCUwHYeqXPQ3tTyMulkH5P13
         0eEnjREPH8Z2lK4PIpnNMan8eYmA8jLuD/Bkb1UGdTPd3ZcFfGKWjx8MvT0uRIzqGLZd
         ftvKxCAR+P0Z9FcQ+iHxQr4FrAcA/VmZClf1uU2SaZyAUxwktB/9gRF9nz+Fj45LN+MG
         nxW4pz8EY3L2WEH3mTCRRqotKvAtoRxiW2L+blvMH19fc1TTkxpkOyWW96qMUDjvVA2R
         RAMA==
X-Gm-Message-State: AOAM533IQQ3/nR/MrS2xNnZIkYftIBKo8/HQMY2fRjjbkvk6uJuxCwoj
        bpNPiboQnkaEzv4LZplUE/z0WA==
X-Google-Smtp-Source: ABdhPJywbRMqfw0QXGls+j3DOsQKG6/gnAV+3bWcXky4WTUNxRvzEMFMvnh6wo0qxKegHxgNpSBV1A==
X-Received: by 2002:a63:3ec3:: with SMTP id l186mr3710947pga.371.1623311919974;
        Thu, 10 Jun 2021 00:58:39 -0700 (PDT)
Received: from localhost ([136.185.169.128])
        by smtp.gmail.com with ESMTPSA id 141sm1755906pgf.92.2021.06.10.00.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 00:58:39 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Qian Cai <quic_qiancai@quicinc.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: cppc: Mark frequency invariance broken
Date:   Thu, 10 Jun 2021 13:28:29 +0530
Message-Id: <28308fc0d38f252baf90e6ffb31fd2f8660be273.1623311808.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There are few races in the frequency invariance support for CPPC driver,
namely the driver doesn't stop the kthread_work and irq_work on policy
exit during suspend/resume or CPU hotplug.

A proper fix won't be possible for the 5.13-rc, as it requires a lot of
changes. Instead of reverting the patch, mark this feature BROKEN for
now.

Fixes: 4c38f2df71c8 ("cpufreq: CPPC: Add support for frequency invariance")
Reported-by: Qian Cai <quic_qiancai@quicinc.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
Rafael, please apply this for v5.13-rc if it looks fine to you.

 drivers/cpufreq/Kconfig.arm | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index a5c5f70acfc9..614c34350f41 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -22,6 +22,7 @@ config ACPI_CPPC_CPUFREQ
 config ACPI_CPPC_CPUFREQ_FIE
 	bool "Frequency Invariance support for CPPC cpufreq driver"
 	depends on ACPI_CPPC_CPUFREQ && GENERIC_ARCH_TOPOLOGY
+	depends on BROKEN
 	default y
 	help
 	  This extends frequency invariance support in the CPPC cpufreq driver,
-- 
2.31.1.272.g89b43f80a514

