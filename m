Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37DC17805A7
	for <lists+linux-pm@lfdr.de>; Fri, 18 Aug 2023 07:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357215AbjHRF2N (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Aug 2023 01:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239444AbjHRF1n (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Aug 2023 01:27:43 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7841DCD
        for <linux-pm@vger.kernel.org>; Thu, 17 Aug 2023 22:27:42 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-68879c4cadeso449681b3a.2
        for <linux-pm@vger.kernel.org>; Thu, 17 Aug 2023 22:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692336462; x=1692941262;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HU5RTBEwbDAykOIX7ilNn8IFEodPR9FSTcqGXKFW6xA=;
        b=kI7/9v41wk6+l3PeHPG73dQNP7pL/7JGVtK0+HWlj+5FFKj4vuSLj5YWmYmlsTZzsc
         cWZogyWlpiHrskHQBT+2ebjqXs+rDefOIcuBrdqNFrrVBQUFtD62s1UfdHIym1+ygvQZ
         rxI7JPRIb/mwCAU+7Cf1dI/yVydlM0ITWdF0wGhClFJJqUWsq167stnU2JcEsRsrJN4i
         TFldG3qAup4/LZMB5+V455v0FgMxCp9TVY+3sOYB4/O8oXE8EEizKDZW/qJIIxsRx1Ay
         p5rtQnt1BEuklbpPl/tMhS15t19vYBtOT4SuCoruajwzViWprtF5OGF5kSPkbsNdxR7y
         QOmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692336462; x=1692941262;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HU5RTBEwbDAykOIX7ilNn8IFEodPR9FSTcqGXKFW6xA=;
        b=B8YZCND4JUjJKlICZO2N8qkTSUaYLQXcRUG5/Vp1GAkmagXcZaaRCMbPprHwmobmYs
         ece6TEWnUEm10WKS/z4heLuzROnfvVHWpPm1UcpNr4JWUlgSqivKnQ5XtmZVZn4P+/vm
         DyzppqAdSgJRRfnw0h64GhSvyabs+xqDf5GR/M39bz1OUe8kWs6PqdDlFLJJVpknl0Eu
         AozXKbn1VJbnPIqLeL+OtFLrvPc//0FnhYzcqaRpnq4tac1OA3qrS9CF5DLRJP7i4IS4
         VuxNlmjmJQ2yHhUICV7oiyEMcEogeHBW9R6V7avpB+e9szulO/BJ4s4B0SpHNMtH2mln
         Lwqw==
X-Gm-Message-State: AOJu0YwqunrE63v1Ol1HFVa26pW3zt5DoKEK5OsCRxHa2Sdk8/jYzZvp
        74JPliH3h5m4/7f51OWCvljskA==
X-Google-Smtp-Source: AGHT+IGdceAFfzkeXASXtoi9F+09M7iSr9jZEZyAjFpb7p5vcHPA2aRwThZNz09QG1DSLwecPrpPNg==
X-Received: by 2002:a05:6a20:656:b0:13e:b58a:e3e8 with SMTP id 22-20020a056a20065600b0013eb58ae3e8mr1572913pzm.50.1692336461933;
        Thu, 17 Aug 2023 22:27:41 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id v2-20020aa78502000000b00686bef8e55csm671681pfn.39.2023.08.17.22.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 22:27:41 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] OPP: Fix argument name in doc comment
Date:   Fri, 18 Aug 2023 10:57:33 +0530
Message-Id: <a5a297918abba9e35b4b1683b14542d6b7f31ade.1692336440.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
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

The name of the argument is "opp_table" and not "table", fix the
comment.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202308172310.FzcidE4c-lkp@intel.com/
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/opp/cpu.c b/drivers/opp/cpu.c
index 3c3506021501..12c429b407ca 100644
--- a/drivers/opp/cpu.c
+++ b/drivers/opp/cpu.c
@@ -24,7 +24,7 @@
 /**
  * dev_pm_opp_init_cpufreq_table() - create a cpufreq table for a device
  * @dev:	device for which we do this operation
- * @table:	Cpufreq table returned back to caller
+ * @opp_table:	Cpufreq table returned back to caller
  *
  * Generate a cpufreq table for a provided device- this assumes that the
  * opp table is already initialized and ready for usage.
@@ -89,7 +89,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_init_cpufreq_table);
 /**
  * dev_pm_opp_free_cpufreq_table() - free the cpufreq table
  * @dev:	device for which we do this operation
- * @table:	table to free
+ * @opp_table:	table to free
  *
  * Free up the table allocated by dev_pm_opp_init_cpufreq_table
  */
-- 
2.31.1.272.g89b43f80a514

