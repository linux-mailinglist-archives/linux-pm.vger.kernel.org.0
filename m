Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E81CA7AD8D7
	for <lists+linux-pm@lfdr.de>; Mon, 25 Sep 2023 15:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbjIYNST (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Sep 2023 09:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbjIYNSN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Sep 2023 09:18:13 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC08126
        for <linux-pm@vger.kernel.org>; Mon, 25 Sep 2023 06:18:06 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-50306b2920dso7864987e87.0
        for <linux-pm@vger.kernel.org>; Mon, 25 Sep 2023 06:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695647885; x=1696252685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v69V2ENFt1TssTyCbqe5C845eqJTGhyOD8iB4ntYSb0=;
        b=ss0xJAl4b3Luv/aaJzHuxFsK8UHwGzcZkvd9g+W7GHGFk2pdzRaZOcqYINxN1ggUBm
         TfpYLwki/36KbBZjNddluHvRiQx4HqWf9Y2ov8cJcju7UXgvn5J/HV5U0lP2KecSfhKl
         CIOVMu4v+Flxkat7a+P1af2TK1ctcdTvsnFIJsc7dOytfPqX46MkYXLz+SFTlDXuLbZC
         UZYtOMTAmRMO4WcipOJz/X177OJYN607BNOYaOye8wMj9QK9aXYtVTjaTEG2PVWoISsM
         fPy79CEsa5H1kC2edSSjs63IwSAXTftRTKQFwdZtqoVEKp/WpeuPKXNdh0jjx8nQtf0Q
         snpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695647885; x=1696252685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v69V2ENFt1TssTyCbqe5C845eqJTGhyOD8iB4ntYSb0=;
        b=UXZ+kOtw4+k63Kvjys0r7XpYOnj474LKRJc8kftcwKGZry7vb/R4pPDwuslgP28ZSN
         5PoUMY/BXV6r2pLJ/tghZ3DWwZRVd7Wq7jUHEvTbqrpq53uUCzK0olXAIwQFUv8MGFzl
         +ImV9IzRejjVH17DjIfDkNTOVWNLglcQMC7vbFTjHh5XAiKY9Aqg+Vj3EXsNN6cwBrYj
         ucubaO/mrUbCRdydnhOxVK+6jM7R5I+IbVCRpXx4jhoFFW/k2BR+4cQDlUGOLQOoNHmM
         JJcuPt4Fg70I8D/fRxvTSa4SeS2/ZxwZBrN8N5u+0yGYQfVaaCm+ORBnWUG73rIIxGBZ
         MbSQ==
X-Gm-Message-State: AOJu0YzMKleAdaHojXOYGSF5jXLZJjNDmVYEyd7K3wejQswO7o/lwXhV
        4OHzrUr+bHKtLGRJcOwg+0P9cA==
X-Google-Smtp-Source: AGHT+IFB4jox44cuBfgowSWNlx+iPrboExg7HfeLkLynB7PSkl1nWXmqlB8pRN1RfPF76Q7d8xE0dg==
X-Received: by 2002:ac2:4e06:0:b0:502:e235:20c7 with SMTP id e6-20020ac24e06000000b00502e23520c7mr3144823lfr.20.1695647884853;
        Mon, 25 Sep 2023 06:18:04 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id m29-20020a056512015d00b004fe10276bbfsm1823583lfo.296.2023.09.25.06.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 06:18:04 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Viresh Kumar <vireshk@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 8/9] firmware: arm_scmi: Specify the performance level when adding an OPP
Date:   Mon, 25 Sep 2023 15:17:14 +0200
Message-Id: <20230925131715.138411-9-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230925131715.138411-1-ulf.hansson@linaro.org>
References: <20230925131715.138411-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

To enable the performance level to be used for OPPs, let's convert into
using the dev_pm_opp_add_dynamic() API when creating them. This will be
particularly useful for the SCMI performance domain, as shown through
subsequent changes.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/firmware/arm_scmi/perf.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index 733c5ebeb555..c6a1332164c1 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -787,6 +787,7 @@ static int scmi_dvfs_device_opps_add(const struct scmi_protocol_handle *ph,
 {
 	int idx, ret;
 	unsigned long freq;
+	struct dev_pm_opp_data data = {};
 	struct perf_dom_info *dom;
 
 	dom = scmi_perf_domain_lookup(ph, domain);
@@ -799,7 +800,10 @@ static int scmi_dvfs_device_opps_add(const struct scmi_protocol_handle *ph,
 		else
 			freq = dom->opp[idx].indicative_freq * 1000;
 
-		ret = dev_pm_opp_add(dev, freq, 0);
+		data.level = dom->opp[idx].perf;
+		data.freq = freq;
+
+		ret = dev_pm_opp_add_dynamic(dev, &data);
 		if (ret) {
 			dev_warn(dev, "failed to add opp %luHz\n", freq);
 			dev_pm_opp_remove_all_dynamic(dev);
-- 
2.34.1

