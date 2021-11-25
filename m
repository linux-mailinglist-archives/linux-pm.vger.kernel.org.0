Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDC6C45D2E2
	for <lists+linux-pm@lfdr.de>; Thu, 25 Nov 2021 03:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbhKYCJC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Nov 2021 21:09:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbhKYCHC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Nov 2021 21:07:02 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C56C061A2D;
        Wed, 24 Nov 2021 17:43:20 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id 132so7069211qkj.11;
        Wed, 24 Nov 2021 17:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FHSyfYNh4kqVfz/DcHad2gPU3SAVYUgpjooodIzjFm0=;
        b=JEXkFxuuZxM9RM3WVTJX0twe1hIlDH6DnTFn6BIAOjnXKMg2rs2Zt3WbEsDut1Nm/8
         KePRY5eGFGucwixY4mo5iXNX8s0i5Vf+FJH8As6ThKF8WAE5okbp0Q6bMbYvvBDnTyXr
         wuxkjP9ceRTrz2RNv2JerZVx2T+HXNNhpL47Lr3n/Q6XZilTlGQZyV8nQRcpzym1CLQh
         MXFI+dA7UOS5EM/zYjjiXQXn4+4+I7ozRuOCqC3A5BmIwBMGFjr2UWvYwQYLw6EIKK8a
         d6Tc4HGRmRXAz/Jjvrhag4Vp/KrOWEzJRxkdYodyL7yHHHPucGOsztR+cbqrYwlJ0d+g
         yOSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FHSyfYNh4kqVfz/DcHad2gPU3SAVYUgpjooodIzjFm0=;
        b=ekwS+P4v6m9N/2hMuuE34sjqmHFFzLiW+CXgzaTZtXcpDCdYhd1/fCwuwPuysxnjOE
         dVJbNR41GmZMrpYWUeWPlDPaZe+xiC1yd6PW2d8C5yEmbh/cfx9CB7WhX05U4ffxKaws
         EYCCTk42Ukv6LMDECp+hhDmgN4uTuU2BIM/bhnwpxEN2kWfhVJCzT/dI1c0MurIyw0XU
         1FVXmdHXie+RJKIdCOBQPMhTSkTz42qMKnwjECTix37OdN3C+6sv7Abo+gG3AdjIuYug
         xZsSUE2o2u/nO6+4oenPhjAhaU8hMMJDcMLoTC8f22ukV6l6TsJXeX1aLXn69o7OX2yH
         lx4A==
X-Gm-Message-State: AOAM531o5OdzvZnBUx7YSM/OfOTsC2uLYdNGsgjEpmU4x0ZgaUEzoaEa
        PEo5jxbaVBn8jFg7Jk1s3qc=
X-Google-Smtp-Source: ABdhPJweWGI1rOYYvAde+ec4S9KjgaaM4Hkj3tWn0q8eJwXmgBHjR5EgJCduioDxPLJn3DiJRZbfPA==
X-Received: by 2002:a05:620a:4008:: with SMTP id h8mr11469575qko.302.1637804599309;
        Wed, 24 Nov 2021 17:43:19 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id 9sm709874qkm.5.2021.11.24.17.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 17:43:18 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: deng.changcheng@zte.com.cn
To:     nks@flawful.org
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] PM: AVS: Use div64_ul instead of do_div
Date:   Thu, 25 Nov 2021 01:43:11 +0000
Message-Id: <20211125014311.45942-1-deng.changcheng@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Changcheng Deng <deng.changcheng@zte.com.cn>

do_div() does a 64-by-32 division. Here the divisor is an unsigned long
which on some platforms is 64 bit wide. So use div64_ul instead of do_div
to avoid a possible truncation.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
---
 drivers/soc/qcom/cpr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/cpr.c b/drivers/soc/qcom/cpr.c
index 1d818a8ba208..e9b854ed1bdf 100644
--- a/drivers/soc/qcom/cpr.c
+++ b/drivers/soc/qcom/cpr.c
@@ -1010,7 +1010,7 @@ static int cpr_interpolate(const struct corner *corner, int step_volt,
 		return corner->uV;
 
 	temp = f_diff * (uV_high - uV_low);
-	do_div(temp, f_high - f_low);
+	temp = div64_ul(temp, f_high - f_low);
 
 	/*
 	 * max_volt_scale has units of uV/MHz while freq values
-- 
2.25.1

