Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE893505C63
	for <lists+linux-pm@lfdr.de>; Mon, 18 Apr 2022 18:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346120AbiDRQZN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Apr 2022 12:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346111AbiDRQZM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Apr 2022 12:25:12 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1125F2ED5F
        for <linux-pm@vger.kernel.org>; Mon, 18 Apr 2022 09:22:33 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id ay36-20020a05600c1e2400b0038ebc885115so139964wmb.1
        for <linux-pm@vger.kernel.org>; Mon, 18 Apr 2022 09:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=izd4aobBUdIcnlIk6dxtT+7YkZnxvrym4hDj9aretWM=;
        b=p0/RSWXMzm8ANXrbLys1Y2hsGjB4b1SvGMV2LDNnYbWA3GGqD4YOXasXCb53ZJJOr3
         k27ci5hrLmiFetzqr8lxTKl0u8u71J40S/UrZwsARjIKUrNZndTibo/1e3QB7ZAXb0Eu
         t2WKF+pMkzbdO4LGTUkYuykeeZjj4qDHCXAD+h1pw0fqT5VPscSUjiXpTfD9Ce+SEiGH
         daOOaXY9o+Y+U4N+QgT1FziGyOSj3FYrEE4Ewjz+JVwiPvut6CJeIeBJyNA1x8Ve4Wri
         Lw9Ek//k6E3rQNo/y8HroEQGMhMxCbZuXCXpC4EJBVaJychxSxG+zPNeFA80UV5Lv3v8
         SB6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=izd4aobBUdIcnlIk6dxtT+7YkZnxvrym4hDj9aretWM=;
        b=xhXNqN7Q8KsBnGnK/QuduTWxY2Pv4tmWssYGZShlwrUIFDIFA3gllIg+7mg0xfDBKK
         pTKQ3tulMAzOT8weJJhfsVWsn+kDooaYA6xIw1+LZYvHh3rY6VNr0NJ76g9oIukovzPn
         JX4rCMd8Cp5aSgJtxpsxp1kl37E4VZzhK2Cw3ZZ4W2Abbux6Xbe63R4qOMmyL784FjUe
         +/bbWRSHm6mOvyV4QO3Tj4YJaTiuMpb1e7lWLbT51ZinapMseeIx100esWySsxyqg7KC
         TMOX1fqYlDW15JvrspenenufFclydstUtFw0R1K6GAOOeN2BSt2FBf24I19WWnFegkqz
         uqTw==
X-Gm-Message-State: AOAM532EbFvJL/rvjs1/FGENHIoxlykify5Ciyxi4JbZvDbt/OUFGq3q
        fnxzQtCvA4n/2Ap/vF6aUs0AGXNAszB5OA==
X-Google-Smtp-Source: ABdhPJyB62MNK0LVql6GqOyDr8WAthaiVdPAtkd1NzxZ9/hBGGRGh7ILp3hhusQuBUcmaqeuH0CB3Q==
X-Received: by 2002:a05:600c:3555:b0:392:68aa:a46d with SMTP id i21-20020a05600c355500b0039268aaa46dmr12627730wmq.20.1650298951732;
        Mon, 18 Apr 2022 09:22:31 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id 205-20020a1c02d6000000b003928c42d02asm8460853wmc.23.2022.04.18.09.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 09:22:31 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, ilia.lin@kernel.org,
        rafael@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        bryan.odonoghue@linaro.org
Subject: [PATCH 3/5] cpufreq: blocklist Qualcomm msm8939 in cpufreq-dt-platdev
Date:   Mon, 18 Apr 2022 17:22:24 +0100
Message-Id: <20220418162226.2983117-4-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220418162226.2983117-1-bryan.odonoghue@linaro.org>
References: <20220418162226.2983117-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

msm8939 uses qcom-cpufreq-nvmem. Block it on the generic cpufreq-dt list.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 96de1536e1cb..71d5b0df4a75 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -136,6 +136,7 @@ static const struct of_device_id blocklist[] __initconst = {
 	{ .compatible = "nvidia,tegra210", },
 
 	{ .compatible = "qcom,apq8096", },
+	{ .compatible = "qcom,msm8939", },
 	{ .compatible = "qcom,msm8996", },
 	{ .compatible = "qcom,qcs404", },
 	{ .compatible = "qcom,sa8155p" },
-- 
2.35.1

