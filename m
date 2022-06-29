Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBCB35600CD
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jun 2022 15:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233582AbiF2NDO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jun 2022 09:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233514AbiF2NDM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jun 2022 09:03:12 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD16B1B0
        for <linux-pm@vger.kernel.org>; Wed, 29 Jun 2022 06:03:10 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id o16-20020a05600c379000b003a02eaea815so1123551wmr.0
        for <linux-pm@vger.kernel.org>; Wed, 29 Jun 2022 06:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0QzToYbJcDYbEYqG15J7NdQlssf7ghwObRQowDdojUI=;
        b=XKjGu06d/OfgUQZKCT46+udJiU3tUD8WeF1k0pFSual2dx0cm4mXRGnpHhVDuYgO3w
         zhf0k9lc0Az56ikgGmTxdJoIye7j5XyKi8T42EyyQd3Wte9phvNnAPnTwtOHMsgsyKhK
         CdO8mX0xzK7Ri+w/doy52BNYp50c3xkprBoxqNoAnXV1Yat6ZNODTedYfVUqcKWTaPpk
         fhH5h1Fn+viJJ95yW5AaU60wA0piPUZykoFQNMme0EAhf3Pwf4pH8chk8uG7vzc8h5Mo
         b+hPHvJX4nud9QmnPUulB7WMHVSP6M2v+JXYCXF2/5dI/CRPOf3s4I+WR+HTx69sJLrK
         Shxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0QzToYbJcDYbEYqG15J7NdQlssf7ghwObRQowDdojUI=;
        b=KVxqDbj8k9tQOGcX/3Z+oSbU4Qx6en161b6nfCwbpDqSv7apwHw/GW42VHRvuxPZ64
         fgyqREScKbeXXbFCwLhz/MGyixxGa/pTLv9aXDzB8E+9/+WllDheSxWP2OKG+VSOkERP
         X2kMzdNRW3wNbKf4KdBFprilb0qB5kgAIGMvF/4vNmGKVL++1pT03qVc7aZJnPJersDa
         cmBBQl/mAeGKDNWduZc+PcYkRSkeCoJrm/E8RNqWE6UfdlO3HyzCEtpH0wTOzwxxJ5kh
         fDGP4FtJoSZrKBzNkSZq9m+BhNk19kRPCz4Q57R3TavUmRoJDHAxJWqepwtpfsXrUj0I
         5PJg==
X-Gm-Message-State: AJIora+amZ4iIDKgvGjbmeDp+cMOE46LxmSGn/Y6yJAxVjDOLwem6yTg
        MBEDHnmTs+QAmwUM41F3wTXlvA==
X-Google-Smtp-Source: AGRyM1uDVYzhjflUeMr9IY0fibJYlCW7mwWt8uD26apminQjZz5gjm9JffDTY735uObRDSBuOKDv7w==
X-Received: by 2002:a05:600c:4e8b:b0:3a0:5826:3321 with SMTP id f11-20020a05600c4e8b00b003a058263321mr3649147wmq.108.1656507789238;
        Wed, 29 Jun 2022 06:03:09 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id g1-20020adffc81000000b00213ba3384aesm17056979wrr.35.2022.06.29.06.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 06:03:08 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     ilia.lin@kernel.org, agross@kernel.org, bjorn.andersson@linaro.org,
        rafael@kernel.org, viresh.kumar@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [RESEND PATCH 3/5] cpufreq: blocklist Qualcomm msm8939 in cpufreq-dt-platdev
Date:   Wed, 29 Jun 2022 14:03:01 +0100
Message-Id: <20220629130303.3288306-4-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220629130303.3288306-1-bryan.odonoghue@linaro.org>
References: <20220629130303.3288306-1-bryan.odonoghue@linaro.org>
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
index 96de1536e1cbf..71d5b0df4a75d 100644
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
2.36.1

