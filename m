Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C63A2F8FF6
	for <lists+linux-pm@lfdr.de>; Sun, 17 Jan 2021 01:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbhAQAru (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 16 Jan 2021 19:47:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbhAQArt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 16 Jan 2021 19:47:49 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576E6C061573;
        Sat, 16 Jan 2021 16:47:09 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id b64so15580305qkc.12;
        Sat, 16 Jan 2021 16:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=RiXlgQf+Mo2eOv0JPdNXbtA3mU1YASRn3j2BtNxUVYM=;
        b=pDdmWx/vIp3z8KIGDOq5VG6RUVwtn0V8Y50QUOOnUfWkWdZROXdVZrskl+OF5HAs4E
         8HWVoLZaqkJ73j7VzKFE070zxIN0xZ7zJZKzmEhJjJ+G1kI9iAxXDUbvgsmzF4vU4SCL
         2mAUB+TBy14yZldI0d9kpsVS6JE+AIBo6YO+VL4ymE1NQz6FvriAiPVF2sWNxMegQzTj
         4eLTOv+EXqFKpWuumCeNzUKYuN49tCiPPzbpaeFKyRgW/KuqXtgt1juC7eLV2ySy2qyl
         li8u4o8uHR9R7DM9a/ku2TlCmbzeEWNN7P4rLlUzmlUCQHXtlvu5BjeM7j3cT7bc+JdK
         lgvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=RiXlgQf+Mo2eOv0JPdNXbtA3mU1YASRn3j2BtNxUVYM=;
        b=P+iOAK1buYLNNL8JOtaHono8uR/VoBvrseTtTWd0xrxNYYJqZme0Z9vmrYoi5eCMQU
         aOcGdLGzuyuCY6jKkJUZgJSqyvdGXnSjUf4u2JhP4KsZG11EYEZXyOCDRW38M4q8qqzn
         Gm6J+SHOuAlVMr+vdOREv3sMXH6cgo9mHZKfrAs0RweRORjNiu1sTQ3ZZyFZOJzYCujc
         ZTIjPVPHlIzHw4AwzsgTtJOQKPY0TsP9SrRlXF1yXzxLBXwYeeaSuEVs6JHLhXEZnSs8
         xYV7/S0v2hRXkBnAf/jvT1PXLnpvQBAHSDYJD0tcKuN/5Zh0aXxGKc4XTvChLWWx8VG+
         Tidg==
X-Gm-Message-State: AOAM533RsgsLdqWZSGl3gnbxIkugsBmy4wo45z9GmNmiLhFu2je/HaOB
        TSMAOazDj4J8rT/AVkd7Eyc=
X-Google-Smtp-Source: ABdhPJxAFt/WwZMWoeJiRtan155zLqaAJY0khzUASKvJxnze27VqpTsEEcGGi2B1RCrRw6qkGtz4rg==
X-Received: by 2002:a37:8703:: with SMTP id j3mr19002691qkd.455.1610844428297;
        Sat, 16 Jan 2021 16:47:08 -0800 (PST)
Received: from fedora ([2604:2000:ffc0:0:347e:7d23:25c9:8337])
        by smtp.gmail.com with ESMTPSA id m64sm7956346qkb.90.2021.01.16.16.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jan 2021 16:47:07 -0800 (PST)
Date:   Sat, 16 Jan 2021 19:47:05 -0500
From:   Nigel Christian <nigel.l.christian@gmail.com>
To:     srinivas.pandruvada@linux.intel.com, lenb@kernel.org,
        rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] cpufreq: intel_pstate: Remove repeated word
Message-ID: <20210117004705.GA10789@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In the comment for trace in passive mode there is an 
unnecessary "the". Eradicate it.

Signed-off-by: Nigel Christian <nigel.l.christian@gmail.com>
---
 drivers/cpufreq/intel_pstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 6f2ff2775664..5175ae3cac44 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2498,7 +2498,7 @@ static int intel_cpufreq_verify_policy(struct cpufreq_policy_data *policy)
  * driver call was via the normal or fast switch path. Various graphs
  * output from the intel_pstate_tracer.py utility that include core_busy
  * (or performance or core_avg_perf) have a fixed y-axis from 0 to 100%,
- * so we use 10 to indicate the the normal path through the driver, and
+ * so we use 10 to indicate the normal path through the driver, and
  * 90 to indicate the fast switch path through the driver.
  * The scaled_busy field is not used, and is set to 0.
  */
-- 
2.29.2

