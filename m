Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEDEC562E0C
	for <lists+linux-pm@lfdr.de>; Fri,  1 Jul 2022 10:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233786AbiGAIWv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Jul 2022 04:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235902AbiGAIW1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Jul 2022 04:22:27 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B250572ECC
        for <linux-pm@vger.kernel.org>; Fri,  1 Jul 2022 01:21:43 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id b2so1705256plx.7
        for <linux-pm@vger.kernel.org>; Fri, 01 Jul 2022 01:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MkV+K20z+SrLBFTmdhzZDzVO0y1dFuzDvpTTKeDqBqE=;
        b=yzdRH8X6v7XjVbWCRmhQya6HuMcF5QDs3XhGwV0qUuOVC7N9Vjw37/iNdrHs/HUQxV
         y74PcIn1/3l0cSSs8nvADtawNuwHVw24Tj5pE/Y5YZ/SrnAIiyn37VtRAcWc6F2VTdPH
         Og0S9HJ7/t0sSbyZOabJ8szydSfhBN26udvPspUSGWc7QC1l21GFd2nWHe4uU2zGABcy
         0llFeMCk2bCaTiH50HqxyLUS9wHn05ko/MYu3aAaOjbdab2MHDn8azhy3W61Sn1Fk7xe
         itPeaif5tkizyseanEr7m+J/gTbum7xOL3kVh0NZeeo1JdU5dV1hpkdf8pt99F63mI9/
         p9JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MkV+K20z+SrLBFTmdhzZDzVO0y1dFuzDvpTTKeDqBqE=;
        b=8GOeeliARCOj1kDIwgOraX5bCwQ15QxlEmEHgB5NGLrNb+qURtR/EeTq3jeNLIJhaM
         AFFVdat76FToGBYFmAsHA1XQZ7WTzpOb7DvuZB777crQcImlIipUPxu/GKbJJ342OeIk
         6D9otlTWNSvHVjq0bpLE0Cxv2MbnM09gH3Dt9qlgEBCpyjSvaTLLOpIx19bpiJu6iXy+
         fJNxLh5W0LdYnkNXoubG9RIHMGkRQMxF9fTtQQkVCyP1RdyrlDzUwQW/yqnhi9PV+qb1
         lfDl5iph7vsoBcHDjUFMIzOMkOFxTLFa96Pf+naki/T4P5nIrjuMQWf+KYcBwXqo3MmG
         1Bag==
X-Gm-Message-State: AJIora/46sSWh77s3D+kE/Ho17yhq+N2X2TAO/yBosySfAlEeiYg+LQJ
        +QpQGsDSp6YLksbXRM10G8O7Aw==
X-Google-Smtp-Source: AGRyM1u79Bc2S58wPQPdFbJkDACJ+sZ7/b/+tANdARi2YjYY5IPeQwazkB2h7rZACs0vqq6yAt9e4Q==
X-Received: by 2002:a17:902:db08:b0:16a:4b7e:af5f with SMTP id m8-20020a170902db0800b0016a4b7eaf5fmr19884988plx.143.1656663703361;
        Fri, 01 Jul 2022 01:21:43 -0700 (PDT)
Received: from localhost ([122.172.201.58])
        by smtp.gmail.com with ESMTPSA id j8-20020a17090a318800b001ed2fae2271sm3331446pjb.31.2022.07.01.01.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 01:21:43 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 21/30] soc/tegra: Add comment over devm_pm_opp_set_clkname()
Date:   Fri,  1 Jul 2022 13:50:16 +0530
Message-Id: <b19a02422cae2408f953b92ae3c46a37fba688a3.1656660185.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1656660185.git.viresh.kumar@linaro.org>
References: <cover.1656660185.git.viresh.kumar@linaro.org>
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

Explain why special handling was required here, it isn't obvious at all.

Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/soc/tegra/common.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/soc/tegra/common.c b/drivers/soc/tegra/common.c
index 32c346b72635..9f3fdeb1a11c 100644
--- a/drivers/soc/tegra/common.c
+++ b/drivers/soc/tegra/common.c
@@ -108,6 +108,13 @@ int devm_tegra_core_dev_init_opp_table(struct device *dev,
 	u32 hw_version;
 	int err;
 
+	/*
+	 * For some devices we don't have any OPP table in the DT, and in order
+	 * to use the same code path for all the devices, we create a dummy OPP
+	 * table for them via this call. The dummy OPP table is only capable of
+	 * doing clk_set_rate() on invocation of dev_pm_opp_set_rate() and
+	 * doesn't provide any other functionality.
+	 */
 	err = devm_pm_opp_set_clkname(dev, NULL);
 	if (err) {
 		dev_err(dev, "failed to set OPP clk: %d\n", err);
-- 
2.31.1.272.g89b43f80a514

