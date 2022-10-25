Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C93F60C546
	for <lists+linux-pm@lfdr.de>; Tue, 25 Oct 2022 09:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbiJYHdp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Oct 2022 03:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbiJYHdZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Oct 2022 03:33:25 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDCA4153E17
        for <linux-pm@vger.kernel.org>; Tue, 25 Oct 2022 00:33:24 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so5754398pjc.3
        for <linux-pm@vger.kernel.org>; Tue, 25 Oct 2022 00:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YBJNc8d1DN49dwvNIgcD6LtTNDN4+u1e0rvTArMbSRY=;
        b=NKtZ4/S+UJJX5l07YfNyJffaTjRg3x5gdXQAfp1hQjYamonsDlnRlVScMQpKuxUuPD
         YH8HOm3NA3whEWOSPxoCMiSBZmcSzP47sA3dxaxRqwtt4iT2RrGst6q8oF8xpfMphvti
         L4xnbJ5fggOICM+WWyZsf9U01siCUPrcA/dFZdZM6yhRWIVH5kyzncKzkb31c5fyJMIJ
         FH8MZ8824mHcT6q3HhP8Cbz32wtXD8GgJxrXxf4Bu7yqwstSFxG/VT5TruN/RUa+lmhP
         8eAMqK+9z7F5TAIrPlpMzAXglgn9aS5hIhTm/X1R8B5d1ihaxSRWSOLgR/jmf73BEAv5
         syqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YBJNc8d1DN49dwvNIgcD6LtTNDN4+u1e0rvTArMbSRY=;
        b=E23N4RqDKOSffocwqqoVvInrkiw+UM1kLp5GRt2T42Py9nrfZQK/uiQ9lNmbs2R6ON
         8DEVM6PRA8ffOl8mCJ4LsP4fEUDBEwQvZyrh5DIItp3iMZw6IhbmkG+5wWSPLGyVZGBH
         m6Cj853TyWFMGRXEmrtCsE8v/7LaI4z0o/Cka9VayZXJ6R8R9i/3c49NbZDR/Sa1Ce9j
         rN5GEp6TI+yGoI1xWsOaGhq+Y3iIQ6nwGH3LrbCLfYoc4YOQeqLQNmH0AE/cJAvk5yKH
         WB0141hscr18jHGI1gbJ22GleQ4vVQ/eQhJFV7PQ6CdWX3N1vIQ/t8cGmfZWP921sYIi
         UDmw==
X-Gm-Message-State: ACrzQf2czXqIIP8TRrE5optDav4Mulg9UrP1LdZ/WmRPj18Ru9DgmPOI
        /p0TCVzywrI+DeG9utaIuTa+
X-Google-Smtp-Source: AMsMyM5ebe21aJ/05A103NwimF4/lit+9de8xb0gRjapa87GIXBhmDcr9nCa4c19+EffxDcuh8iIAw==
X-Received: by 2002:a17:902:a606:b0:178:57e4:a0c1 with SMTP id u6-20020a170902a60600b0017857e4a0c1mr36885582plq.83.1666683204458;
        Tue, 25 Oct 2022 00:33:24 -0700 (PDT)
Received: from localhost.localdomain ([117.193.211.146])
        by smtp.gmail.com with ESMTPSA id c1-20020a17090a4d0100b0020dda7efe61sm5048369pjg.5.2022.10.25.00.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 00:33:22 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, viresh.kumar@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, rafael@kernel.org,
        robh+dt@kernel.org
Cc:     johan@kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 3/7] cpufreq: qcom-hw: Remove un-necessary cpumask_empty() check
Date:   Tue, 25 Oct 2022 13:02:50 +0530
Message-Id: <20221025073254.1564622-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221025073254.1564622-1-manivannan.sadhasivam@linaro.org>
References: <20221025073254.1564622-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

