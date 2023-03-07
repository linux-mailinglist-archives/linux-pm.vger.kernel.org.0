Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 581626AE0BA
	for <lists+linux-pm@lfdr.de>; Tue,  7 Mar 2023 14:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjCGNiA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Mar 2023 08:38:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbjCGNh7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Mar 2023 08:37:59 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E909031
        for <linux-pm@vger.kernel.org>; Tue,  7 Mar 2023 05:37:57 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id h11so12146234wrm.5
        for <linux-pm@vger.kernel.org>; Tue, 07 Mar 2023 05:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678196276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mIjogzcbB9NbNQDtYcUOxd5sO+Lh6rQ2yVngUMiZyBg=;
        b=YG5ga49pJHXfSemMbf0p1srILRTv58YCHpLvV/P7+8IagzwrOhVhY7ZKGa0EYsmRo/
         G2CoSa4u0ZEPOC0Vr70fZU1bQ41CO1Y4MMaxwuSbD7SbxOR1Dzpss8lJ/qrzohTOAMFs
         TWxHtI4ngmaSsg3tMPJcWKwjqdVjAyBsxhGaReWOJlZo4/jUDQVQSh+7eDi7aKiHqvWq
         Vs/+qJbWZzqKUHoiZSdeKb362nA3ACs5FJymKmMPaLPNbJgJYa34BxAVmMeOvtmasGxV
         EgAlVDdpg2jnHLSqMEooMAFjtMZYCMpfINVTeqnOeyNAxNeurKrrDromBo23nT+lHimD
         0F5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678196276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mIjogzcbB9NbNQDtYcUOxd5sO+Lh6rQ2yVngUMiZyBg=;
        b=5WU4MNM5Ib36asPAJQFTfnyibvCVg8V2GTky/AnfmMSvd4IJzuwoSwVxzVJYV0+P7R
         UF7RXPdzQBnVdqM2pB/wDtUu6nJ/6UVCOqepFvP3ASfVFsa/MNX1kq0yTyPT+8A9FXuH
         daqrH0YK/eRlkbIscZycg0p9u/J537MWYtdR0iNi28WYyHZ1aid4KvzemuEthA73y0l2
         XbsHOnrTwSGBgcl6uWm2LcRJDeW813JZ5igl9RApHJ5B5/DTEk428I5NbkX1pyAKCT5o
         2bXSxzco0MjlUONgdh/Wr5dwhQRnwL0eyzklhyerE6VY5tshPve8MLRQ+D3bw1M7s+3n
         iieA==
X-Gm-Message-State: AO0yUKXLIy1JwBBKNn8v/FoJ39z7Scm77VCpxvWx04q5/yLuMe4/yu95
        RCyZVXC7JDG28GF579icjVb6TQ==
X-Google-Smtp-Source: AK7set/4lXJCmPfCyDhu+dCKKQKbXeAog36vaBFmsPGjAwv5R3tEcPT/BWmWipC6Naeq00anV5N6JA==
X-Received: by 2002:a5d:5253:0:b0:2c5:5d21:7d4c with SMTP id k19-20020a5d5253000000b002c55d217d4cmr9400374wrc.43.1678196276323;
        Tue, 07 Mar 2023 05:37:56 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:5ab9:1ac6:870d:35c])
        by smtp.gmail.com with ESMTPSA id v5-20020a5d43c5000000b002c55de1c72bsm12311477wrr.62.2023.03.07.05.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 05:37:56 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, amitk@kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Adam Ward <DLG-Adam.Ward.opensource@dm.renesas.com>,
        Tim Zimmermann <tim@linux4.de>,
        linux-pm@vger.kernel.org (open list:THERMAL),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1 02/11] thermal/drivers/intel_pch_thermal: Use thermal driver device to write a trace
Date:   Tue,  7 Mar 2023 14:37:26 +0100
Message-Id: <20230307133735.90772-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230307133735.90772-1-daniel.lezcano@linaro.org>
References: <20230307133735.90772-1-daniel.lezcano@linaro.org>
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

The pch_critical() callback accesses the thermal zone device structure
internals, it dereferences the thermal zone struct device and the 'type'.

For the former, the driver related device should be use instead and
for the latter an accessor already exists. Use them instead of
accessing the internals.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/intel/intel_pch_thermal.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/intel_pch_thermal.c b/drivers/thermal/intel/intel_pch_thermal.c
index dce50d239357..0de46057db2a 100644
--- a/drivers/thermal/intel/intel_pch_thermal.c
+++ b/drivers/thermal/intel/intel_pch_thermal.c
@@ -127,7 +127,10 @@ static int pch_thermal_get_temp(struct thermal_zone_device *tzd, int *temp)
 
 static void pch_critical(struct thermal_zone_device *tzd)
 {
-	dev_dbg(&tzd->device, "%s: critical temperature reached\n", tzd->type);
+	struct pch_thermal_device *ptd = thermal_zone_device_priv(tzd);
+
+	dev_dbg(&ptd->pdev->dev, "%s: critical temperature reached\n",
+		thermal_zone_device_type(tzd));
 }
 
 static struct thermal_zone_device_ops tzd_ops = {
-- 
2.34.1

