Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B89346048FF
	for <lists+linux-pm@lfdr.de>; Wed, 19 Oct 2022 16:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbiJSOSo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Oct 2022 10:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233409AbiJSOSQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Oct 2022 10:18:16 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189EF1929B9
        for <linux-pm@vger.kernel.org>; Wed, 19 Oct 2022 07:01:22 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id c24so17327864pls.9
        for <linux-pm@vger.kernel.org>; Wed, 19 Oct 2022 07:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YBJNc8d1DN49dwvNIgcD6LtTNDN4+u1e0rvTArMbSRY=;
        b=YGAYOVv+brUZd23y7jvKSb64Bb5umVyN2Q3QSeu1MMFEuhjPw2hd8U1Zx8Vsqj0Sd8
         vzvgLc83OHECsisUyP9UWZgPnvUSOt/KGIz/h/D6SIS6z9DRQBv0qfRq6tKbYHCS/hYm
         AFf5CgV2T1wHNeCArE60X4fjJFf7WwCcYzDouX1lzJCEvjpGR4dRZpFM99Dru7lPpiix
         HyFttEscr3sUOB/T3vMUgzBxl0G/HmbkqvS/HbpeBBWNpSfAaM6lUEDtuLR6duB2dHrl
         Pj3wiwvBiI8v9iWj3kwfrkJ4Q0qgJhyMtUbrKBUxKPOlsKA9tVYEMKmVHRWTeJST54W1
         b0/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YBJNc8d1DN49dwvNIgcD6LtTNDN4+u1e0rvTArMbSRY=;
        b=4SUWh4BMIfN/PwVPxmlJ39ocbsAYO1HdO04uRJssAuCg4eCUWQzS34T50hgnpFDPOu
         wQCirKifRAkhT2m40LQGufve0Dkm5jabm/LflV6pD0BD/tzuilQ0Dsz6GZ5pQ3dT69D3
         06ddCDB6AtRACEWysrx0nR7BTcMna1YMOV1/+bU3D2Fud7fckulql+FlGZz9D8LWqVCN
         1ws1FRKMD1C2g9M2KUK1n6fj994xNzMBd5L3Z003rmaCa1PNIEnGbi+Z9S3eA0Kjkplp
         h0qB56O04to2MNpCNaY8nZGSAiBo9xr4kmWIgdfrBsjdNDIf2ZwcKO+ECCTjxCENYzPW
         k8BQ==
X-Gm-Message-State: ACrzQf03rhFfDJ2vs1WiYgYOi138Z+hP2MfSmauDgpHVWyscI6yqEArF
        yBDjJRK1zRKWPnOUMzJoLxY4HBG4KHrAtI536Q==
X-Google-Smtp-Source: AMsMyM5RAyuFcDOTNF/J54YuFDz0XY336F9mIaRgP/VNJvUjPZvimZIU8+XTmb04ID/iF9YODLsMLQ==
X-Received: by 2002:a17:90b:4a84:b0:20d:8953:5ab0 with SMTP id lp4-20020a17090b4a8400b0020d89535ab0mr44983588pjb.48.1666187982638;
        Wed, 19 Oct 2022 06:59:42 -0700 (PDT)
Received: from localhost.localdomain ([117.193.210.93])
        by smtp.gmail.com with ESMTPSA id 194-20020a6216cb000000b0053e199aa99bsm11240322pfw.220.2022.10.19.06.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 06:59:41 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, viresh.kumar@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, rafael@kernel.org,
        robh+dt@kernel.org
Cc:     johan@kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 1/4] cpufreq: qcom-hw: Remove un-necessary cpumask_empty() check
Date:   Wed, 19 Oct 2022 19:29:22 +0530
Message-Id: <20221019135925.366162-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221019135925.366162-1-manivannan.sadhasivam@linaro.org>
References: <20221019135925.366162-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

CPUFreq core will always set the "policy->cpus" bitmask with the bitfield
of the CPU that goes first per domain/policy. So there is no way the
"policy->cpus" bitmask will be empty during qcom_cpufreq_hw_cpu_init().

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index d5ef3c66c762..a5b3b8d0e164 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -552,11 +552,6 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 		data->per_core_dcvs = true;
 
 	qcom_get_related_cpus(index, policy->cpus);
-	if (cpumask_empty(policy->cpus)) {
-		dev_err(dev, "Domain-%d failed to get related CPUs\n", index);
-		ret = -ENOENT;
-		goto error;
-	}
 
 	policy->driver_data = data;
 	policy->dvfs_possible_from_any_cpu = true;
-- 
2.25.1

