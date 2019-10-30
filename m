Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF99BE9E9D
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2019 16:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbfJ3PPC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Oct 2019 11:15:02 -0400
Received: from mail-wr1-f73.google.com ([209.85.221.73]:51689 "EHLO
        mail-wr1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbfJ3PPB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Oct 2019 11:15:01 -0400
Received: by mail-wr1-f73.google.com with SMTP id t2so1493494wri.18
        for <linux-pm@vger.kernel.org>; Wed, 30 Oct 2019 08:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1SoSUVQGtw0xqhat0J9cgyKetzE2XJjl2eMiWbfu6h8=;
        b=h5//0TRn9EKJvylW7TY1JvOZXS2ibA0DV4HxdiJVlR8UQ99rEu2e+mFCVQdObxwG8c
         9rAPJy3+G57qCyJyjMNxN0HC+P6xwYJmgpdlcoNYtOf7jvqO+JG7+muQ6+LG545oxyKp
         r6XSN9ordGxuwsAEuFb61cPh7hX6YM9CBAiEYpyyQAghYSE7SRz89svjnI8mfsXSLc9l
         beJV0kFXUt9k1y8oq2CxYAd6hp41ZnL8r0u4MTKah6oFw4co6penwmyEX7wIrj+1drQu
         NTrItd13CNheMjSU3XG7slYf+dR3n8RzoBGtILn3h9GaLmltWsEgWGztckWdHxqJDAKX
         IXzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1SoSUVQGtw0xqhat0J9cgyKetzE2XJjl2eMiWbfu6h8=;
        b=jGTRdawcjJQ3JF0qAzSQWE4BawSJTGL+hWggkAcVTtheBvtdIbvH/+xjLTLR8Prt0f
         Ufjd+d1yIzrxmIDKMKTAxs/1GiR9XmxVEBKv94mKloBGa2WVFJe/vO46RMz+Llj4owT8
         /6NM7USIFIj3r04jHecfiB1UB5dHyG/HuxsBERJUoEPlarJeNEiT0DIGBWRKd6d92/GD
         f90WtCDR2tK4WdqxrJpBlZiFjsQWfEklsI9omI3KqXrKJZ/uWdbEXiI8w9RS86Sz64Pw
         5GvfZUkPWjuBiVrR3ZM0MDAYHKGLcDZk80lltI72TvrZy6d9Wp8IATpDIqohys2y+O3p
         dcag==
X-Gm-Message-State: APjAAAVMh9KEgCmNTECacR/k165rMCqk3f67ACmvU9vUOY9S3d9HTjiY
        pXf1j2Uwk8/9EKMVg5MtsUeYnY98fWi4
X-Google-Smtp-Source: APXvYqySHRuDfYqqlCAgMra1Sxad7qU6NdrSxE7WWWgkDHIWXiSLRdq98hYpruwBtXj1XdEq1j4LhR1RhuLt
X-Received: by 2002:a5d:4491:: with SMTP id j17mr353365wrq.46.1572448500122;
 Wed, 30 Oct 2019 08:15:00 -0700 (PDT)
Date:   Wed, 30 Oct 2019 15:14:49 +0000
In-Reply-To: <20191030151451.7961-1-qperret@google.com>
Message-Id: <20191030151451.7961-3-qperret@google.com>
Mime-Version: 1.0
References: <20191030151451.7961-1-qperret@google.com>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH v9 2/4] PM / EM: Declare EM data types unconditionally
From:   Quentin Perret <qperret@google.com>
To:     edubezval@gmail.com, rui.zhang@intel.com, javi.merino@kernel.org,
        viresh.kumar@linaro.org, amit.kachhap@gmail.com, rjw@rjwysocki.net,
        catalin.marinas@arm.com, will@kernel.org, daniel.lezcano@linaro.org
Cc:     dietmar.eggemann@arm.com, ionela.voinescu@arm.com,
        mka@chromium.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, qperret@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The structs representing capacity states and performance domains of an
Energy Model are currently only defined for CONFIG_ENERGY_MODEL=y. That
makes it hard for code outside PM_EM to manipulate those structures
without a lot of ifdefery or stubbed accessors.

So, move the declaration of the two structs outside of the
CONFIG_ENERGY_MODEL ifdef. The client code (e.g. EAS or thermal) always
checks the return of em_cpu_get() before using it, so the exising code
is still safe to use as-is.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 include/linux/energy_model.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index 73f8c3cb9588..d249b88a4d5a 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -9,7 +9,6 @@
 #include <linux/sched/topology.h>
 #include <linux/types.h>
 
-#ifdef CONFIG_ENERGY_MODEL
 /**
  * em_cap_state - Capacity state of a performance domain
  * @frequency:	The CPU frequency in KHz, for consistency with CPUFreq
@@ -40,6 +39,7 @@ struct em_perf_domain {
 	unsigned long cpus[0];
 };
 
+#ifdef CONFIG_ENERGY_MODEL
 #define EM_CPU_MAX_POWER 0xFFFF
 
 struct em_data_callback {
@@ -160,7 +160,6 @@ static inline int em_pd_nr_cap_states(struct em_perf_domain *pd)
 }
 
 #else
-struct em_perf_domain {};
 struct em_data_callback {};
 #define EM_DATA_CB(_active_power_cb) { }
 
-- 
2.24.0.rc0.303.g954a862665-goog

