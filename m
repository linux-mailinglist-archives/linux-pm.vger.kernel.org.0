Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 921795FFA19
	for <lists+linux-pm@lfdr.de>; Sat, 15 Oct 2022 15:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiJONEp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 15 Oct 2022 09:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiJONEo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 15 Oct 2022 09:04:44 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4642813D5C
        for <linux-pm@vger.kernel.org>; Sat, 15 Oct 2022 06:04:42 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id t4so4956627wmj.5
        for <linux-pm@vger.kernel.org>; Sat, 15 Oct 2022 06:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M3YfUt++W8dDaqgtSWE1khIACcQPCyEYMQHXrvEQmhs=;
        b=Y4wbOjgx2lEWRAFVJ3dc7xv73XQApHAV+DYnGZ3iqL/BL4RdytNcTox/0ZvbdGiC0Z
         MTGU7zq3js0WGVaMIoB3g8iMnaYBUuz507VAFbttX8TVPaMjEwPclvCjsf4mF8fxZo94
         J5ROzk0h+ykzWxTGS3ld6a06kDMuClfztt4hfdXpSheURLY7Pf/5UTVagqoy9AJj1iCp
         oPRSX3KKATin472tvlIHB9qGC2sPKF/OgAICsBpXZilaqZAzbzZGmLfqdQVG1hTGdsXk
         LaRGWd+4I1EZI4H15ZVj0UJhBuBKgpeU9k8L5YrSObzI6UaqolYZKIuzWtlEsreeHc1J
         29cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M3YfUt++W8dDaqgtSWE1khIACcQPCyEYMQHXrvEQmhs=;
        b=0KIoADoVUMtCP0G58R2wM1TiDZUGm8Y5yjH8s8Lf7YQxwcMXuCCZfrXMBf/1B/BUGy
         kYU5K+pD6WCQEUJKAkgICkOQK91vVnuvRfc10lRnHxRKm3TSJvBhw8CdCqbMt2NotQtn
         YyflCaYRNY1U9mYkp/sIQT8HE51YZZRBz2LHLDCJQn4sQ2AZnCLtKoxiFNEGogyVuc9c
         cQHOT4GZAftPUHOwVbAf9roAhU+bN7tAcL4sjsnUj9o1WfLj95FEojEZ/YNsjp3OVPWM
         ws8nqgDDB5WEv8IC3H+2dhVTfeMLLmUiuDfu4TNon+p4oTj7rYiLZkmGuWTiXg6Be5oq
         Iuqw==
X-Gm-Message-State: ACrzQf19gdJaZlKLFKscunmFMOqc17XuNOJx3n9Vz6vvvWQOsfsJrT/b
        oChUcYxSMr/GVoxjdDvj3SO06A==
X-Google-Smtp-Source: AMsMyM7VtjssO0g1B+G+QEidrcorpyk907nPgfpyKAdNojVkFviM9ToQjtlr9UnD1i8OK8as7HkLMQ==
X-Received: by 2002:a05:600c:21c5:b0:3c6:ec59:5180 with SMTP id x5-20020a05600c21c500b003c6ec595180mr3717470wmj.130.1665839080533;
        Sat, 15 Oct 2022 06:04:40 -0700 (PDT)
Received: from radium.lan ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id r12-20020adff10c000000b00225239d9265sm4151282wro.74.2022.10.15.06.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Oct 2022 06:04:40 -0700 (PDT)
From:   Fabien Parent <fabien.parent@linaro.org>
To:     ilia.lin@kernel.org, agross@kernel.org, andersson@kernel.org,
        rafael@kernel.org, viresh.kumar@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, Fabien Parent <fabien.parent@linaro.org>
Subject: [PATCH v2 1/3] cpufreq: qcom: fix memory leak in error path
Date:   Sat, 15 Oct 2022 15:04:22 +0200
Message-Id: <20221015130424.1923706-1-fabien.parent@linaro.org>
X-Mailer: git-send-email 2.37.2
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

If for some reason the speedbin length is incorrect, then there is a
memory leak in the error path because we never free the speedbin buffer.
This commit fixes the error path to always free the speedbin buffer.

Fixes: a8811ec764f9 ("cpufreq: qcom: Add support for krait based socs")
Signed-off-by: Fabien Parent <fabien.parent@linaro.org>
---

v2: Added missing "Fixes" tag

 drivers/cpufreq/qcom-cpufreq-nvmem.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index 863548f59c3e..3bd38acde4b9 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -213,6 +213,7 @@ static int qcom_cpufreq_krait_name_version(struct device *cpu_dev,
 	int speed = 0, pvs = 0, pvs_ver = 0;
 	u8 *speedbin;
 	size_t len;
+	int ret = 0;
 
 	speedbin = nvmem_cell_read(speedbin_nvmem, &len);
 
@@ -230,7 +231,8 @@ static int qcom_cpufreq_krait_name_version(struct device *cpu_dev,
 		break;
 	default:
 		dev_err(cpu_dev, "Unable to read nvmem data. Defaulting to 0!\n");
-		return -ENODEV;
+		ret = -ENODEV;
+		goto len_error;
 	}
 
 	snprintf(*pvs_name, sizeof("speedXX-pvsXX-vXX"), "speed%d-pvs%d-v%d",
@@ -238,8 +240,9 @@ static int qcom_cpufreq_krait_name_version(struct device *cpu_dev,
 
 	drv->versions = (1 << speed);
 
+len_error:
 	kfree(speedbin);
-	return 0;
+	return ret;
 }
 
 static const struct qcom_cpufreq_match_data match_data_kryo = {
-- 
2.37.2

