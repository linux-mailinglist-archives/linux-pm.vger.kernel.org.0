Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7DC6244AC5
	for <lists+linux-pm@lfdr.de>; Fri, 14 Aug 2020 15:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbgHNNm2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Aug 2020 09:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728261AbgHNNm1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Aug 2020 09:42:27 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A647C061384;
        Fri, 14 Aug 2020 06:42:26 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id d6so9973061ejr.5;
        Fri, 14 Aug 2020 06:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0ea8aqWQ03A+LTiarGv9IDwr9wAWoEp4rehXTFeQjn4=;
        b=g+SB0f0TPX12oxfdzGHhzA8P76UZsMAdpd7j48g9GUESskc1VmnOPcruldrvgjo7Yr
         o8PZiHBw2FyGFNIrtkoJdM1kzd145t52VQTHNwhBKwLhRZeNt2heZXb/6Z5V7t+Kob5m
         KPOj1b2jKR61Kmi0KtRg6wrj2FX3NG6FQqdJiF7LihoLPwvkJ1E1rwAjy2iwbNY7UoCe
         SQCqlZJGgnJdmjsa3QpXW6Nb9jMmjmLpst25vGeaNHyx32NBV8OWdMBcRDlvm6o0/qyI
         xzXnSkf24PkuCdYOnfy/MZpJ1RlCZZMP7qnx68Jw3UGq47mq5A21oYApVTUXSnw8Vte6
         +ffw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0ea8aqWQ03A+LTiarGv9IDwr9wAWoEp4rehXTFeQjn4=;
        b=sIRoulmoW0SshhsYJBOhDmRfjk8muVQQSJloctNKBjzKEYCYp3xMrxvUFG89wbPfAe
         oAz1Rln17Lkawx0jowHBNsP3ANH1RcJ97ghd5NeJ1M8JlY1r1nGR0Lx8ztspUqcXu9P5
         kRo44OAwtN2CbIc8Xu/2qLeOxn0oyjpY1RkznkWRV2/ZzA1BSwQYnytHUPoENDs3uJ/h
         P5/ZA57CX33in15f2h1PXZ0Lstrq/206ZhnZe8BLcDIMGeaTlpEBhWRgOeDuq9xPK/EA
         s0qLDJpuhPhGWWWj7Jy4WtM3mfHvUnosYMoJAdP8UoGeRcdAq7BdTTEG7mPdhS2SxWJc
         iMQA==
X-Gm-Message-State: AOAM530Tz9MCmWfr/BMFLFlbcb1Wcs3HEP260vgCgz+xLw9TIpnXkOxr
        JmnFK5KYoy72uou62ON3b70=
X-Google-Smtp-Source: ABdhPJxOR9deuuaATcWM1zfhd3dzycAnv3BLjx6ASgIC+UpiV/kr2Q/cC9YCV/tEiESc0uNlm6TmhA==
X-Received: by 2002:a17:906:1cd4:: with SMTP id i20mr2408850ejh.480.1597412545226;
        Fri, 14 Aug 2020 06:42:25 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host-87-0-192-118.retail.telecomitalia.it. [87.0.192.118])
        by smtp.googlemail.com with ESMTPSA id s2sm6767118ejd.17.2020.08.14.06.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 06:42:24 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v6 6/8] drivers: thermal: tsens: Change calib_backup name for msm8960
Date:   Fri, 14 Aug 2020 15:41:20 +0200
Message-Id: <20200814134123.14566-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200814134123.14566-1-ansuelsmth@gmail.com>
References: <20200814134123.14566-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Follow standard naming for calib secondary rom and change calib_backup
to tsens_calsel.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/thermal/qcom/tsens-8960.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/tsens-8960.c b/drivers/thermal/qcom/tsens-8960.c
index ca83c7f838a5..a8c85bd6c71f 100644
--- a/drivers/thermal/qcom/tsens-8960.c
+++ b/drivers/thermal/qcom/tsens-8960.c
@@ -191,7 +191,7 @@ static int calibrate_8960(struct tsens_priv *priv)
 
 	data = qfprom_read(priv->dev, "calib");
 	if (IS_ERR(data))
-		data = qfprom_read(priv->dev, "calib_backup");
+		data = qfprom_read(priv->dev, "calib_sel");
 	if (IS_ERR(data))
 		return PTR_ERR(data);
 
-- 
2.27.0

