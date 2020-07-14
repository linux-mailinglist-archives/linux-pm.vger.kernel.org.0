Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AEF521F56A
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jul 2020 16:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728947AbgGNOvZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jul 2020 10:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728561AbgGNOvE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jul 2020 10:51:04 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3AC1C08C5DB
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2020 07:51:03 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id s10so22129103wrw.12
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2020 07:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ov8mkUGBo3MkEAlxc2kYHhcoEYaszqjEJyXig/T1tiI=;
        b=t6daXhKQWGdOTczm6qL35xc0fppGdojfryPU3Yy+9b2M42Lz9lDVXu8Z+oQPer8/wn
         66lWCuWHscF79MDsDWoRINbL+J3DI3JwRywYtB3y/yDN2fYApJvODwK9fVhtnK1i5TrR
         6PwVmrMyZL9diMFGKxmlNMcb/U/bTKAABaKdcywqnPyqnVG8Qf3AUAoJpdZ/2pUkQHF/
         JNbL4G/kUrCSGBLIjO7xXY9Eqm4CKdYlM/6mJNq99ZnUxi1hI/38z3KoHgnowKzwqcF5
         DuKh916+E7/PuxfrO02rdsDIELOoLKt8hH+gN8cgun3vPBAXSTxr4R8r6rhWs+4/y9qb
         Zpdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ov8mkUGBo3MkEAlxc2kYHhcoEYaszqjEJyXig/T1tiI=;
        b=JJ3XLFrtXPn9XOUCxN0dsmsQlu73bygS9czVB6y7wSEDTxSGrRqrajvwjk35VG0u1m
         LHicJvSxf8aAC15n9V9ZvaWwocYw5lYzvs/P9DDxSyoXdSXIyCpYgZ/soU1pmljzf2i8
         v43RWf5DmmSjSFIMA0SgVpbguqBwy+09htQ3BH0KnX3ha8cQfPb88besCYyjpNLvKPKE
         7vE2Gj34jh//KvfAvsm11CHgy7DOyIXc8ZztthaNQ7fGKSy3FAXQGEiSHrkf9DHZc2ER
         +p7UtcaGCEwRf1on2tbMuz6kg8+MeydFUmgRtUdeBv24TaNwXZVR8Y7YxIaJhARL0wlw
         YkSw==
X-Gm-Message-State: AOAM530NliIE9LXrV6FTKzwb8sboyvV6OS14gheWLHE0apfRNXYriboe
        sDsvvONiVttBRV656grThDXjCBww8WY=
X-Google-Smtp-Source: ABdhPJwXO/T/LF1NI7ZgnyJQbsl2c1EL4iDXIFBRbgGKB7Pv7E0G1E9GvN5Ys7i50Jv2Wiu8MXJf4g==
X-Received: by 2002:adf:f18c:: with SMTP id h12mr5883468wro.375.1594738262394;
        Tue, 14 Jul 2020 07:51:02 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id a84sm4653305wmh.47.2020.07.14.07.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 07:51:01 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Andy Grover <andrew.grover@intel.com>,
        Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>,
        Dominik Brodowski <linux@brodo.de>,
        Denis Sadykov <denis.m.sadykov@intel.com>
Subject: [PATCH 09/13] cpufreq: acpi-cpufreq: Remove unused ID structs
Date:   Tue, 14 Jul 2020 15:50:45 +0100
Message-Id: <20200714145049.2496163-10-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200714145049.2496163-1-lee.jones@linaro.org>
References: <20200714145049.2496163-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Can't see them being used anywhere and the compiler doesn't complain
that they're missing, so ...

Fixes the following W=1 kernel build warning(s):

 drivers/cpufreq/acpi-cpufreq.c:1004:36: warning: ‘processor_device_ids’ defined but not used [-Wunused-const-variable=]
 997 | static const struct x86_cpu_id acpi_cpufreq_ids[] = {
 | ^~~~~~~~~~~~~~~~
 drivers/cpufreq/acpi-cpufreq.c:997:32: warning: ‘acpi_cpufreq_ids’ defined but not used [-Wunused-const-variable=]
 619 | static const struct acpi_device_id processor_device_ids[] = {
 | ^~~~~~~~~~~~~~~~~~~~

Cc: Andy Grover <andrew.grover@intel.com>
Cc: Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>
Cc: Dominik Brodowski <linux@brodo.de>
Cc: Denis Sadykov <denis.m.sadykov@intel.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/cpufreq/acpi-cpufreq.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index d38a693b48e03..fc68f13352695 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -995,18 +995,4 @@ MODULE_PARM_DESC(acpi_pstate_strict,
 late_initcall(acpi_cpufreq_init);
 module_exit(acpi_cpufreq_exit);
 
-static const struct x86_cpu_id acpi_cpufreq_ids[] = {
-	X86_MATCH_FEATURE(X86_FEATURE_ACPI, NULL),
-	X86_MATCH_FEATURE(X86_FEATURE_HW_PSTATE, NULL),
-	{}
-};
-MODULE_DEVICE_TABLE(x86cpu, acpi_cpufreq_ids);
-
-static const struct acpi_device_id processor_device_ids[] = {
-	{ACPI_PROCESSOR_OBJECT_HID, },
-	{ACPI_PROCESSOR_DEVICE_HID, },
-	{},
-};
-MODULE_DEVICE_TABLE(acpi, processor_device_ids);
-
 MODULE_ALIAS("acpi");
-- 
2.25.1

