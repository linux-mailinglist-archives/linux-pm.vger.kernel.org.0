Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC8F76E0CEC
	for <lists+linux-pm@lfdr.de>; Thu, 13 Apr 2023 13:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbjDMLrA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Apr 2023 07:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjDMLq7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Apr 2023 07:46:59 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648552729
        for <linux-pm@vger.kernel.org>; Thu, 13 Apr 2023 04:46:56 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id o6-20020a05600c4fc600b003ef6e6754c5so5992586wmq.5
        for <linux-pm@vger.kernel.org>; Thu, 13 Apr 2023 04:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681386415; x=1683978415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3AD5Mv81x1OfSGYx8Typ89SsCtnJrhePS3JykvPhl6k=;
        b=R+IWqIXQjMrTORnXHQ/dbbWc/32x3W0LfqaNkiqXhr0Wti8JO4WnUrnFok8jp0nLsd
         OjkTjLPKbFSnra9XHlHWb1vLwnzPrxgk0kIoI97S35LTdHFD2zLLISaWc5B43q3T+QRe
         PkWCFNR4YpOTAUA4GRrw2BPL6A/YnWefg4uhb9s4ukBh5jpsKaUxVltnaE90lrnl6/bH
         nCeD7nb6MkKcxry5iir+1zIlXK6zw4V+SfBEm2DOvBRpYamqaSOy+Sq/0qxWs+BQKbxR
         7hBPYVEpTI2ueafA/Gs2hqipcOrp9WIroOdpzuvRx8OucrA2Fi2xBa9MkhjHaN4cr+iw
         DKQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681386415; x=1683978415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3AD5Mv81x1OfSGYx8Typ89SsCtnJrhePS3JykvPhl6k=;
        b=SFRD/wutHJJFMSET0EjG7CBiwedMo93/rKMymHecILWbjr2F1SdZP7HsJM00M17k4G
         BcAOMKkpYHis+nLe3hbhQTLm5LEopJHFfW350NOz4IHdKCshXJnyuWItnrTaHun+scfj
         dlhf/yql7JSQmoQ997/1kZ0ba1cbAtTm94QX58DO8Vjv+pwLyGngVEiOwzFdAD7tKuyB
         iXAxEtNp0KYEe51WccBIDGjVnLWBStCjggHkFUAOJgcRZxPZWVyt4VAbypccSMiiYfnA
         czYNA0fdgePeTljB60D9vnwYD8ptH8tSJBpNcTxEwPlyORu+NkgQmTJMtPZukiLpv1H/
         EUzQ==
X-Gm-Message-State: AAQBX9ebRJn/Ob43QjMMfLHEquqgpn21c9zp7rrpIL/+N6GgZ1Aa8kBs
        x+0A0FGp+H3W+S3uNI5nr1CWyw==
X-Google-Smtp-Source: AKy350aOOadYVPk63yq/w3nSCo+Rg2v8bVsrk3UMItD3+T8OjNao8Q+lCMMWTIvNuR+9JpAZ3dYy0Q==
X-Received: by 2002:a05:600c:c5:b0:3ed:8780:f265 with SMTP id u5-20020a05600c00c500b003ed8780f265mr1519565wmm.21.1681386414778;
        Thu, 13 Apr 2023 04:46:54 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:6418:c878:b0e:d11b])
        by smtp.gmail.com with ESMTPSA id iz11-20020a05600c554b00b003f09aaf547asm6730590wmb.1.2023.04.13.04.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 04:46:54 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Tim Zimmermann <tim@linux4.de>
Subject: [PATCH v3 2/6] thermal/drivers/intel_pch_thermal: Use thermal driver device to write a trace
Date:   Thu, 13 Apr 2023 13:46:43 +0200
Message-Id: <20230413114647.3878792-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230413114647.3878792-1-daniel.lezcano@linaro.org>
References: <20230413114647.3878792-1-daniel.lezcano@linaro.org>
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

Use the available accessors instead of accessing the structure directly.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/intel/intel_pch_thermal.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/intel_pch_thermal.c b/drivers/thermal/intel/intel_pch_thermal.c
index dce50d239357..b3905e34c507 100644
--- a/drivers/thermal/intel/intel_pch_thermal.c
+++ b/drivers/thermal/intel/intel_pch_thermal.c
@@ -127,7 +127,8 @@ static int pch_thermal_get_temp(struct thermal_zone_device *tzd, int *temp)
 
 static void pch_critical(struct thermal_zone_device *tzd)
 {
-	dev_dbg(&tzd->device, "%s: critical temperature reached\n", tzd->type);
+	dev_dbg(thermal_zone_device(tzd), "%s: critical temperature reached\n",
+		thermal_zone_device_type(tzd));
 }
 
 static struct thermal_zone_device_ops tzd_ops = {
-- 
2.34.1

