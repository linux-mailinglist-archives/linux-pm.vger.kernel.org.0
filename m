Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A64466A3F1E
	for <lists+linux-pm@lfdr.de>; Mon, 27 Feb 2023 11:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjB0KHD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Feb 2023 05:07:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjB0KHC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Feb 2023 05:07:02 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6081E1EBE6;
        Mon, 27 Feb 2023 02:06:55 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id bt28so5559049wrb.8;
        Mon, 27 Feb 2023 02:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yJDKXszmmKLN/R4d+/6xdWOXvYFvI2xH82tZbAjm4g8=;
        b=KbugpxkvguhSI2rmjI2w2+7SfWTVbj4WqjS+DU7abkH7AmVjkvrP2Qak0bH+OAav96
         Kj+PDHJHcv/iQJSgDSTHhj9NdXHcpeZZWNNeX2bUEMjU5Siq5XiGsAbUnhK38386rTxl
         bB3JlRKZ2N70hajSrS3xeaBDRb5+NYxIbvJv2u5hzkdLB+LPwfTRzHNo9CZ1GnwWVkWn
         ZPjkNZPgPi3gnsOSPny2gMTAOmTWtGaux+iOmiO+3hV1/BoO7VbxyzPM6pb7obOP/EI4
         6xBFx+G9RfR1xt+p9asA/OJIqVnlmFNZFEAi8ln4w27dILRcJGajv5M1BKa1wrmOZMeW
         1p1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yJDKXszmmKLN/R4d+/6xdWOXvYFvI2xH82tZbAjm4g8=;
        b=T6/R/f6iGS7GfATEQogCjxdJF5Na6lcCu2IU2Ht7uGauIDdi7/xXPNhEFFIX716Ut0
         rBLhTrQ3e//sX0yYN7b/yv8X52kFLxziNH03ekKsfUmYsKU8OS5EeTI3DMpViyN11LpE
         CcqGe+otLa8Htx+CmNLCi4EUPh1gYo2TwZgmvCZkQjkgneLm1AkqzW/UpTTukNqwyJtS
         HBbN6IDDjZcvuHmhbo2ch6HQaRS4SebPs+UqvLVe4BxpV2OnzbjwihnSMZCwLAWjzLI1
         FytQbiitbFWUDcsf4WTxOZiNMeoBL6BBTb+8BCxL9uy69MhUmDHOf+pRUJz4nSuw05ab
         35kA==
X-Gm-Message-State: AO0yUKUnIrqh8hTGpqcU2sp4lx4C4o0kHc04Xh1uN9veGCvM2VSkYkqr
        +z3GZmywE5rJTda30vV5KfI=
X-Google-Smtp-Source: AK7set+t02ISuqkHwl46+XUcjwJTBXAtfqwc42XUAZrwlpi+bmSRMYlmn7pg1rHurkV3Z/xBA8lOYQ==
X-Received: by 2002:a5d:564e:0:b0:2c9:993a:f4db with SMTP id j14-20020a5d564e000000b002c9993af4dbmr4812267wrw.7.1677492413873;
        Mon, 27 Feb 2023 02:06:53 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id e15-20020a5d594f000000b002c5d3f0f737sm6620989wri.30.2023.02.27.02.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 02:06:53 -0800 (PST)
Date:   Mon, 27 Feb 2023 13:06:50 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Boon Leong <boon.leong.ong@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Bryan O'Donoghue <pure.logic@nexus-software.ie>,
        "Kweh, Hock Leong" <hock.leong.kweh@intel.com>,
        linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] thermal: intel: quark_dts: fix error pointer dereference
Message-ID: <Y/yAusqpje3MqS1N@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

If alloc_soc_dts() fails, then we can just return.  Trying to free
"soc_dts" will lead to an Oops.

Fixes: 8c1876939663 ("thermal: intel Quark SoC X1000 DTS thermal driver")
Signed-off-by: Dan Carpenter <error27@gmail.com>
---
 drivers/thermal/intel/intel_quark_dts_thermal.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/thermal/intel/intel_quark_dts_thermal.c b/drivers/thermal/intel/intel_quark_dts_thermal.c
index 97b843fa7568..ffdc95047838 100644
--- a/drivers/thermal/intel/intel_quark_dts_thermal.c
+++ b/drivers/thermal/intel/intel_quark_dts_thermal.c
@@ -400,22 +400,14 @@ MODULE_DEVICE_TABLE(x86cpu, qrk_thermal_ids);
 
 static int __init intel_quark_thermal_init(void)
 {
-	int err = 0;
-
 	if (!x86_match_cpu(qrk_thermal_ids) || !iosf_mbi_available())
 		return -ENODEV;
 
 	soc_dts = alloc_soc_dts();
-	if (IS_ERR(soc_dts)) {
-		err = PTR_ERR(soc_dts);
-		goto err_free;
-	}
+	if (IS_ERR(soc_dts))
+		return PTR_ERR(soc_dts);
 
 	return 0;
-
-err_free:
-	free_soc_dts(soc_dts);
-	return err;
 }
 
 static void __exit intel_quark_thermal_exit(void)
-- 
2.39.1

