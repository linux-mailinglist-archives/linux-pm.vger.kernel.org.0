Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C79118306D
	for <lists+linux-pm@lfdr.de>; Thu, 12 Mar 2020 13:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbgCLMht (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Mar 2020 08:37:49 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:52478 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727299AbgCLMhs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Mar 2020 08:37:48 -0400
Received: by mail-pj1-f68.google.com with SMTP id f15so2511549pjq.2
        for <linux-pm@vger.kernel.org>; Thu, 12 Mar 2020 05:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MJ0FTWWOebHELFkNME8B6qpcBpjJgX3FutsQbbeYbhU=;
        b=vgUq0cR6g4DhSwUTniZtXzWlsPO2JOT3AJwg1A5p+8JxLiR801I+5eEh705Tv4Uayu
         6nkHCOxM3xSOLEXsTYHfv8IAD3UuRZnIG4FA0Lo2jjBUk2a5nHS2jIkZSLKRZyTJ9mEt
         kPtm8CsOpPl7xKRKtmtZ2g2mu1qeGDSQyTf6UHH2+Bda/dRBCk5RiattdGDAJMJ2s+yA
         aFuLuYQ4Dve/2Qk8hdnxfV7Kc/UlAC4SLINpPDIpdpYXkXvN6Ey32kguYOB9QgPnQwyk
         H+s3f1Lii4YXcQLTr4juiaWvo9wn7+je3ZrZtEiBG+5M3+8sRchqs9PyBsVKdefidqeO
         cY/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MJ0FTWWOebHELFkNME8B6qpcBpjJgX3FutsQbbeYbhU=;
        b=rV4AGCZwrB9dUPWzLEgybJhv1birwezq72o6icJXt6TR92n6OmAL0xRpYUTf9sO0xn
         /PQXiKD2dssjYM+uu6+HtH/2IDY5kDCAG+KOXONAQbJQeU/5vNQfxsr8mQiiPhBFKLTz
         jLotDakch056MYVNabFUyj30S85qC+Lf0pJMRPIpAK3dYeiKCCHYCG644OsNCnfXeeoO
         1dYnP2HOiqTSH7CwoeADTFi+fjXVv0jCQ2zZfuv7OMBNDMb2qu0tqfHZL2eRv4i3Jq7M
         GhMYSKuFzuEFm4tF5qq1OdK3oXEImqh+LqKEcVYzFSj7OJO9ANcxEIRMPehriwRMOgzP
         dGpQ==
X-Gm-Message-State: ANhLgQ2V2u329Bs9U37msL8z4cBiVxZ9pKKLnNJt7lpSrYu58cGUSdpa
        wXcOB2MzgOe74nZtRS57DGIF2B4vkh0=
X-Google-Smtp-Source: ADFU+vshJ0hZN2X2sbZNGeO6p20WvGt4x019suitTVRzrV++c8U4DDolbSv6KgnTzCpdG3GRmqC9pQ==
X-Received: by 2002:a17:902:fe83:: with SMTP id x3mr7942892plm.310.1584016667514;
        Thu, 12 Mar 2020 05:37:47 -0700 (PDT)
Received: from localhost ([45.127.45.7])
        by smtp.gmail.com with ESMTPSA id z12sm6349993pfj.144.2020.03.12.05.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 05:37:46 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org, bjorn.andersson@linaro.org,
        swboyd@chromium.org, sivaa@codeaurora.org,
        Andy Gross <agross@kernel.org>
Cc:     Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH v7 8/8] drivers: thermal: tsens: Remove unnecessary irq flag
Date:   Thu, 12 Mar 2020 18:07:05 +0530
Message-Id: <8ac92e45b65fe411f4aaf70dcde4e7e7c3169b2d.1584015867.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1584015867.git.amit.kucheria@linaro.org>
References: <cover.1584015867.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

IRQF_TRIGGER_HIGH is already specified through devicetree interrupts
property. Remove it from code.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/thermal/qcom/tsens.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 05d2721320471..2f77d235cf735 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -104,7 +104,7 @@ static int tsens_register_irq(struct tsens_priv *priv, char *irqname,
 	} else {
 		ret = devm_request_threaded_irq(&pdev->dev, irq,
 						NULL, thread_fn,
-						IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
+						IRQF_ONESHOT,
 						dev_name(&pdev->dev), priv);
 		if (ret)
 			dev_err(&pdev->dev, "%s: failed to get irq\n",
-- 
2.20.1

