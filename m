Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B480220705
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jul 2020 10:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729875AbgGOI0o (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 04:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729868AbgGOI0n (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2020 04:26:43 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185C5C08C5DB
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2020 01:26:43 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id c80so4501558wme.0
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2020 01:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JqiGjo2A+JuWYmJhOxUeBH7YynB0Z20iJW99N6uR5uY=;
        b=CDfyeeeQ8Et3gI4BeM9nFnG0rJHPytBjxmubMrji/xwR7Y/4y1u7qdOOK7R0COCM4j
         DixdnjvwrQY/XWYwRHdWwC/lexyC3w/Zw35GVuHu21hHXhW7No33wZJyu4URGeL8PpVJ
         WYR4aiH1P1yPpX0wpis2ygq1Al65X2lq0zbOkuLm8i4Fsj9/Qagc0/HsjhXnyB4R83Pk
         Yx531xndHS0pnQQ097IVLNzLELQIIj1zWpd/xpKcfRZUcF8+RQPusKV8eWdxB4CrJmTy
         DNfP0/wzD8uznhQXNoZkppTa1N8/gXGTe+ygny5+WLNSIX0XJhr4bKlOP7t0zA/MYq60
         r9fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JqiGjo2A+JuWYmJhOxUeBH7YynB0Z20iJW99N6uR5uY=;
        b=P2M4G4AXbwRSXNKtrMq5p/gvkzByCVZWMuIjbS8/casTqv6ooE2ByO7l1YSdhClx1K
         6WjezJjc2sXl2Kkp1Z+NaoKY7+rodL2x/rHTrxK0Mp82dltz7GWxXgOo/rP/FGFCaQ0B
         YtitvKUOz1c1xY4TwVj1S9zhfYrYrm8iwdsdCLd7CJgXegpTbHX6qVFoEcVH26hx0W4f
         CAVMO8mV5m/xwh/0toDzprJyDhR+dljvpzvTFV6P+WTGLqZuOsw4ktDX8QHM4RHKKIWi
         DhWTxjZUkFmzo+iYdxATWAiDTIUD0M5QLCP7JLpsDKeuDEUzPZaSgkk1cxLGAUgJTdS5
         N6Aw==
X-Gm-Message-State: AOAM532TRBpcEGK1w4CFlrnDpUmBE1biE3YDZ0QOlPoq15jygp/rsJS+
        YmryoMZU6RLmbfeI9z3Iu7CB1g==
X-Google-Smtp-Source: ABdhPJwdC0CBwfwEFgnMWBs2itS0D4XePO3DqtgB9k/WgQwQPpp6vszxazNlsyxsWskCia0jOGxeZQ==
X-Received: by 2002:a7b:cf16:: with SMTP id l22mr8091360wmg.68.1594801601851;
        Wed, 15 Jul 2020 01:26:41 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id h13sm2400361wml.42.2020.07.15.01.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 01:26:41 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
        Jun Nakajima <jun.nakajima@intel.com>,
        Alexander Clouter <alex@digriz.org.uk>
Subject: [PATCH v2 03/13] cpufreq: cpufreq_governor: Demote store_sampling_rate() header to standard comment block
Date:   Wed, 15 Jul 2020 09:26:24 +0100
Message-Id: <20200715082634.3024816-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200715082634.3024816-1-lee.jones@linaro.org>
References: <20200715082634.3024816-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There is no need for this to be denoted as kerneldoc.

Fixes the following W=1 kernel build warning(s):

 drivers/cpufreq/cpufreq_governor.c:46: warning: Function parameter or member 'attr_set' not described in 'store_sampling_rate'
 drivers/cpufreq/cpufreq_governor.c:46: warning: Function parameter or member 'buf' not described in 'store_sampling_rate'
 drivers/cpufreq/cpufreq_governor.c:46: warning: Function parameter or member 'count' not described in 'store_sampling_rate'

Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Cc: Jun Nakajima <jun.nakajima@intel.com>
Cc: Alexander Clouter <alex@digriz.org.uk>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/cpufreq/cpufreq_governor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index f99ae45efaea7..63f7c219062b9 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -26,7 +26,7 @@ static DEFINE_PER_CPU(struct cpu_dbs_info, cpu_dbs);
 static DEFINE_MUTEX(gov_dbs_data_mutex);
 
 /* Common sysfs tunables */
-/**
+/*
  * store_sampling_rate - update sampling rate effective immediately if needed.
  *
  * If new rate is smaller than the old, simply updating
-- 
2.25.1

