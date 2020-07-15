Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA64322070D
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jul 2020 10:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729925AbgGOI05 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 04:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729921AbgGOI0x (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2020 04:26:53 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23C2C061755
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2020 01:26:52 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id s10so1419489wrw.12
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2020 01:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yBqTF9msKxXESKXR6D7ZZTPRiLswk1Xy6QhvSew6gR0=;
        b=oRHNplZ7GSg6wW9XCQnXu7Ag3RRbpbsqZQOc7oxhhgEyiH+dzYvNYDSO1XjRvkWcJl
         7uBZeyJQHXz5gFKwdA4IaSPpjV0DX6KUjXmZbpt8DBZ3nZ44yItO9dQ//zBdrT/9cvTm
         Z72l+F9wCR8PderUySuiWy3jJEaa+wHxOy/cCPEY1a5C1RNJjZLnes/9fkbm4M1QHuS+
         PgfHkNEUwTaIxHSK6Iv6NBKuuHfF1GDdnFJjO0G83E91e34xz0i1ZA2+w8hIbKEF8GHy
         LlIZ+WuoYrKed+fVVbT2gpUEMdYo71pO5SW08hEGUWqSPfskXX6Mi9dOWpWUo89QJinQ
         FZZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yBqTF9msKxXESKXR6D7ZZTPRiLswk1Xy6QhvSew6gR0=;
        b=j+tSGeAG+jpIjoW4WzIMpbo1qabNGo0sT36drz95IdsoKAwZygpGgb+kGZBsHPdZ//
         1Xa7gKLYu8pH81jDtNs9Yli0OVOA+J57tDl6E3TFCzOmY+0IGX696LCJa6SzxhFUUSOH
         tM7cheUbnqbaGx+36M5FTurCWi42d+avhX0M4h7Tciktd62cob0DU4rbDuyQFPBoD9vm
         b/PiLtLOwpv1mFTefesoV3/UsYSnE2oXZr8ir8ElzHtN+MukKXTn4U0jf8gLZq49IKCt
         hSn8RNmSJBKePNQjUPkokTj47Kb4e1rRvi/gksBftLIKgA7mVTcCf7DhpF5rMRAdJyyv
         rgSw==
X-Gm-Message-State: AOAM532xMcsfAQJNWdNHcbH5VYQATcynsu5ruBQUzhItGRsT36EHyPeB
        w/qp4/3PfPb67jUA98/ReWbevA==
X-Google-Smtp-Source: ABdhPJy5SCVD1rT1DRxu8zgDWo02ZeuPue7Qv83+P6OX3TiNf3xq9p2hLtBri2FdrgS6Qle9GcUXPA==
X-Received: by 2002:a5d:6ac1:: with SMTP id u1mr9898491wrw.123.1594801611303;
        Wed, 15 Jul 2020 01:26:51 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id h13sm2400361wml.42.2020.07.15.01.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 01:26:50 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Andreas Herrmann <herrmann.der.user@googlemail.com>,
        Dominik Brodowski <linux@brodo.de>,
        Pavel Machek <pavel@ucw.cz>,
        Paul Devriendt <paul.devriendt@amd.com>,
        Mark Langsdorf <mark.langsdorf@amd.com>
Subject: [PATCH v2 10/13] cpufreq: powernow-k8: Mark 'hi' and 'lo' dummy variables as __always_unused
Date:   Wed, 15 Jul 2020 09:26:31 +0100
Message-Id: <20200715082634.3024816-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200715082634.3024816-1-lee.jones@linaro.org>
References: <20200715082634.3024816-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

if we fail to use a variable, even a dummy ones, then the compiler
complains that it is set but not used.  We know this is fine, so we
set them as __always_unused here to let the compiler know.

Fixes the following W=1 kernel build warning(s):

 drivers/cpufreq/powernow-k8.c: In function ‘pending_bit_stuck’:
 drivers/cpufreq/powernow-k8.c:89:10: warning: variable ‘hi’ set but not used [-Wunused-but-set-variable]
 89 | u32 lo, hi;
 | ^~
 drivers/cpufreq/powernow-k8.c: In function ‘core_voltage_pre_transition’:
 drivers/cpufreq/powernow-k8.c:285:14: warning: variable ‘lo’ set but not used [-Wunused-but-set-variable]
 285 | u32 maxvid, lo, rvomult = 1;
 | ^~

Cc: Andreas Herrmann <herrmann.der.user@googlemail.com>
Cc: Dominik Brodowski <linux@brodo.de>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Paul Devriendt <paul.devriendt@amd.com>
Cc: Mark Langsdorf <mark.langsdorf@amd.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/cpufreq/powernow-k8.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/powernow-k8.c b/drivers/cpufreq/powernow-k8.c
index 3984959eed1d5..0acc9e241cd7d 100644
--- a/drivers/cpufreq/powernow-k8.c
+++ b/drivers/cpufreq/powernow-k8.c
@@ -86,7 +86,7 @@ static u32 convert_fid_to_vco_fid(u32 fid)
  */
 static int pending_bit_stuck(void)
 {
-	u32 lo, hi;
+	u32 lo, hi __always_unused;
 
 	rdmsr(MSR_FIDVID_STATUS, lo, hi);
 	return lo & MSR_S_LO_CHANGE_PENDING ? 1 : 0;
@@ -282,7 +282,7 @@ static int core_voltage_pre_transition(struct powernow_k8_data *data,
 {
 	u32 rvosteps = data->rvo;
 	u32 savefid = data->currfid;
-	u32 maxvid, lo, rvomult = 1;
+	u32 maxvid, lo __always_unused, rvomult = 1;
 
 	pr_debug("ph1 (cpu%d): start, currfid 0x%x, currvid 0x%x, reqvid 0x%x, rvo 0x%x\n",
 		smp_processor_id(),
-- 
2.25.1

