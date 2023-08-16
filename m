Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F2777E458
	for <lists+linux-pm@lfdr.de>; Wed, 16 Aug 2023 16:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343868AbjHPO6F (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Aug 2023 10:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343858AbjHPO54 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Aug 2023 10:57:56 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC75D26A1
        for <linux-pm@vger.kernel.org>; Wed, 16 Aug 2023 07:57:54 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-99bcfe28909so858328266b.3
        for <linux-pm@vger.kernel.org>; Wed, 16 Aug 2023 07:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692197873; x=1692802673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NixeQd6xSh2tNtmaq0jX+6ZW5LoNEOMcfMMtSKt75tk=;
        b=zf9tyl2LU6fms9X82BBE7C363LwuI0IzArByzcDFgH2ufio5w440Ni5mnXJE4r2/En
         mciSs6MjfoLdydInooORM+EhD+yi03jABlm83Ev/bQn70VFOpQJ5pOEfnvGUG+xx+1EI
         v2/hM/Kk+BzU7wCT29AJhn0kHDuXcrOCiMYEP+fcOmY9cLHxwyfN9ILV4vx2f6NpkCmk
         SeT/QbfT9hgJg/F8Dz7IKCqo+wZ2Hw/cIuce3VCXnaFyzalyvS7pucejADssfdsaKQzg
         fyclrtAV3shpb9CLihP86CcDVPxd3bQpBB3FECUaF7a64UxoChMrV5485G5UdXWY0jNJ
         C6Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692197873; x=1692802673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NixeQd6xSh2tNtmaq0jX+6ZW5LoNEOMcfMMtSKt75tk=;
        b=jR7QgsfmV9JzZQ86nCfLwnPqgG84dn88pkp5VW0IAZD/L0o7+pZkIleNRnrq+/ezWB
         q1eLEqVUPieibcqEZ3XcVQiEU8t5d1+2GN7Js/vihhO2hLfNbyl9/2qqJkUbOPYu4MKq
         SN78v2CnNHfdRZt0/NFufzcg/EMXn+HMymlvlmtCrVVmLPFFonSeBFfID2f7lNGSsgqv
         4pzLnnzTkMHOOS3zTiu/BdJHxew3irKFjnNkvb6cZXaPhDjKNk46vrAmbHZ9zlbhL6rV
         u8C66mwbw0LDIaDSM+3UFCYrnBPzX/sEf7/50LZvV1oooDp2H+lG9I2lxZqPb5DkQn9J
         8GFw==
X-Gm-Message-State: AOJu0YxO8GRluDQsQ2pVT+jfE4lAL4DwBEx0/NczPEb5djEFjnzuDhjy
        pZncNFV2bfksoxV6u6kzcycz7g==
X-Google-Smtp-Source: AGHT+IF0TqtXQdQBhempOuNMHQX9hq0+jdnohXAHrMPJL782fdIa1+n/q85sPoWG2TLxxQ4IRpEhHA==
X-Received: by 2002:a17:906:1da1:b0:99c:ca27:c447 with SMTP id u1-20020a1709061da100b0099cca27c447mr1450120ejh.43.1692197873154;
        Wed, 16 Aug 2023 07:57:53 -0700 (PDT)
Received: from hackbox.lan ([84.232.191.92])
        by smtp.gmail.com with ESMTPSA id f16-20020a170906561000b00992076f4a01sm8610403ejq.190.2023.08.16.07.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 07:57:52 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <tdas@qti.qualcomm.com>
Cc:     linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, Taniya Das <quic_tdas@quicinc.com>
Subject: [PATCH v2 2/6] PM: domains: Add the domain HW-managed mode to the summary
Date:   Wed, 16 Aug 2023 17:57:37 +0300
Message-Id: <20230816145741.1472721-3-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230816145741.1472721-1-abel.vesa@linaro.org>
References: <20230816145741.1472721-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Now that domains support being managed by the HW, lets add that
information to the genpd summary.

Suggested-by: Taniya Das <quic_tdas@quicinc.com>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/base/power/domain.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index dfb4f1de540d..053b7b510825 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -3171,6 +3171,15 @@ static void rtpm_status_str(struct seq_file *s, struct device *dev)
 	seq_printf(s, "%-25s  ", p);
 }
 
+static void mode_status_str(struct seq_file *s, struct device *dev)
+{
+	struct generic_pm_domain_data *gpd_data;
+
+	gpd_data = to_gpd_data(dev->power.subsys_data->domain_data);
+
+	seq_printf(s, "%20s", gpd_data->hw_mode ? "HW_Mode" : "SW_Mode");
+}
+
 static void perf_status_str(struct seq_file *s, struct device *dev)
 {
 	struct generic_pm_domain_data *gpd_data;
@@ -3229,6 +3238,7 @@ static int genpd_summary_one(struct seq_file *s,
 		seq_printf(s, "\n    %-50s  ", kobj_path);
 		rtpm_status_str(s, pm_data->dev);
 		perf_status_str(s, pm_data->dev);
+		mode_status_str(s, pm_data->dev);
 		kfree(kobj_path);
 	}
 
@@ -3245,8 +3255,9 @@ static int summary_show(struct seq_file *s, void *data)
 	int ret = 0;
 
 	seq_puts(s, "domain                          status          children                           performance\n");
-	seq_puts(s, "    /device                                             runtime status\n");
-	seq_puts(s, "----------------------------------------------------------------------------------------------\n");
+	seq_puts(s, "    /device                                             runtime status                           mode\n");
+	seq_puts(s, "------------------------------------------------------------------------------------------------------------\n");
+
 
 	ret = mutex_lock_interruptible(&gpd_list_lock);
 	if (ret)
-- 
2.34.1

