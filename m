Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED217B5ABC
	for <lists+linux-pm@lfdr.de>; Mon,  2 Oct 2023 21:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjJBS7v (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Oct 2023 14:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238522AbjJBS7u (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Oct 2023 14:59:50 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C488D7
        for <linux-pm@vger.kernel.org>; Mon,  2 Oct 2023 11:59:46 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-50305abe5f0so33808e87.2
        for <linux-pm@vger.kernel.org>; Mon, 02 Oct 2023 11:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696273184; x=1696877984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q1heHX5rrMSY/dD5UhqY1PvNOm7/fsl8X1S0Buse7vI=;
        b=KFzFKDfAuRSCyHScI07yudPn/bRwNHkYt5A2wQb3QN4o9aFgFydRW63d73SpIB6aqV
         c+zTHVzgsmD/YbakYfTeKqdcrcVw72htWpCF4V6xLxV4OuMn49eO1QkHW3TQHKhWeO04
         XiuBT6B43meZj7I/TeUXigrYV+QmCJ+WOEDSIaLCjMKLDbVm+Xs+77SKxiyD/9Vrjvh9
         WwC9RxR3OSIOjhJGE6QgYQW/ldggnhl/Q4mD/EGeijNDReVClLLzyHu8YJoOto6rNI+u
         v2g/ICijeowUNMu6JUmgjwhQk3i4Hx6TLOc+8J/EWiI3ExvFR3nukih0pfkxy5cw6EHy
         VG0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696273184; x=1696877984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q1heHX5rrMSY/dD5UhqY1PvNOm7/fsl8X1S0Buse7vI=;
        b=kP6QChQa2G7Sa5au0BSxDMvv5i/8G/3OMea2vQSgNT8iL869I0O+7zyQ/y6I/MNxZ9
         z/MGkgnx/r8NDSk2PDh2N7A4m+3E2a9/zZRoiBsr+yJy05nvZpw940TK9BKm9CJteqHb
         PSECZtALmDyhn0kQVURe0FysVkalDmyGlD1r1stKDzEWfP3fZJgP8WmHnGH3IlFwXKJL
         NbfzodvaIV0PxvCE/xMhyE/+1oNgcbMe5rpa1U480ElG3sl+k5UhKGECdcrzxIQTbUwo
         dPa9eqIEBCvr22353aVnIcoyMhTqdNk1RVuI+piLR/zTMZmw/b5QN2u3eIYflplGg3nJ
         ceGQ==
X-Gm-Message-State: AOJu0YzgKUy0OsLWQM3CYFvxSZBZA9Zrj/iFLQkP/PTMTfvTadOq9cC3
        fAZ+GcOW2DkPIuhScjUbgYhXyQ==
X-Google-Smtp-Source: AGHT+IHr19H6Cze+Q47I7x1qKrppOYVudyg44AYVTgEBEL5dGi26gc6A6DWuFqw85i0NUnco5CEOvw==
X-Received: by 2002:a05:6512:3d10:b0:500:7a23:720b with SMTP id d16-20020a0565123d1000b005007a23720bmr13652498lfv.55.1696273184283;
        Mon, 02 Oct 2023 11:59:44 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id t6-20020a19ad06000000b00502d7365e8fsm2443981lfc.137.2023.10.02.11.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 11:59:43 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        Christian Marangi <ansuelsmth@gmail.com>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH v5 4/6] cpufreq: qcom-nvmem: drop pvs_ver for format a fuses
Date:   Mon,  2 Oct 2023 21:59:38 +0300
Message-Id: <20231002185940.1271800-5-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231002185940.1271800-1-dmitry.baryshkov@linaro.org>
References: <20231002185940.1271800-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The fuses used on msm8960 / apq8064 / ipq806x families of devices do not
have the pvs version. Drop this argument from parsing function.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/cpufreq/qcom-cpufreq-nvmem.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index 9db060bed742..e5c17d9f5a24 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -50,7 +50,7 @@ struct qcom_cpufreq_drv {
 static struct platform_device *cpufreq_dt_pdev, *cpufreq_pdev;
 
 static void get_krait_bin_format_a(struct device *cpu_dev,
-					  int *speed, int *pvs, int *pvs_ver,
+					  int *speed, int *pvs,
 					  u8 *buf)
 {
 	u32 pte_efuse;
@@ -181,8 +181,7 @@ static int qcom_cpufreq_krait_name_version(struct device *cpu_dev,
 
 	switch (len) {
 	case 4:
-		get_krait_bin_format_a(cpu_dev, &speed, &pvs, &pvs_ver,
-				       speedbin);
+		get_krait_bin_format_a(cpu_dev, &speed, &pvs, speedbin);
 		break;
 	case 8:
 		get_krait_bin_format_b(cpu_dev, &speed, &pvs, &pvs_ver,
-- 
2.39.2

