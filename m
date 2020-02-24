Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A40ED16A6A0
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2020 13:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbgBXM7U (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Feb 2020 07:59:20 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36195 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727689AbgBXM7S (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Feb 2020 07:59:18 -0500
Received: by mail-pf1-f194.google.com with SMTP id 185so5347506pfv.3
        for <linux-pm@vger.kernel.org>; Mon, 24 Feb 2020 04:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YyTMBW/LB/vN3eCREReLdM0mvM31rEOT+ERAgjHVtRY=;
        b=JZWSboEMZ1DD76EgGmGkJwuOffVfjE7SlTjAdOeMsMIBQwLbx0kdb8cyKjlpnEogsV
         5yk0rrXYLM3jCeJJySFyWt/RdE5ttiRJCU9O+IOsVGz9hxiLRXjhnDtxbdIRqdi1csel
         bbOZYlUiRh00qVjFpuCQsy5cCPFHJuWCHKmIRlTYW6nNFCgroLKjxzFRxjtsDbf/XKsT
         5O5WsGI8NklYrhNpufzN5w5kEK6/3viAihInhJSClEH/e3jntLVUiYBkQz+vOMRPZF+t
         7/5+z7kQzyyekDYT7tnnDG8VzCyROFRzzx56Rc7Nl7ElaXkEHp0pO+Ny52485wtpU6Rg
         C0gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YyTMBW/LB/vN3eCREReLdM0mvM31rEOT+ERAgjHVtRY=;
        b=LUfTzevcIkitglfoJjy5+/UoHhRBCbins8z8HGcKzWad1ymVotitj7ewYVeD/sCc3o
         xDnqIhuN41W/9LlRNWndX6aAPOQU8NaS2tAMoVxm9hm4eCacGye6l/ZH0oTKS2p0bGDy
         4l5q1xY/NP3+p2Ir2O+qNKFSP37jhkPHL827HKZmrbxJVsTQqff6VmKiMl5oL5Ge3z8Q
         BamARbsGcD568WuBmG1H7W6VnE/eeyqzoSNbcaod6CtVXwcL8Gs3BMDYKBTHi3fPawqt
         wjKwRH7hktQn71HhAwCAjoUCPNsMM8Wa6PyBuYwlpMBr5xM9QNvr6+Hp9fskIL0VFiAV
         78DA==
X-Gm-Message-State: APjAAAVKPJ9GFT1hly/il83+hj97LJd0sGB0Tc/mRS2YGV8a5+4ZIP3/
        fss6ViIyCRqKJsygo0fkGsx6FQ==
X-Google-Smtp-Source: APXvYqxMr6UU5kWlEufUAqUs+1fm+1FNQMvnYRHd7TLzwVzmccFVJ/TRH3el7hi3DJjhIP2MLqotPQ==
X-Received: by 2002:a62:1594:: with SMTP id 142mr51093679pfv.18.1582549157864;
        Mon, 24 Feb 2020 04:59:17 -0800 (PST)
Received: from localhost ([103.195.202.114])
        by smtp.gmail.com with ESMTPSA id a9sm13203869pjk.1.2020.02.24.04.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 04:59:17 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org, bjorn.andersson@linaro.org,
        swboyd@chromium.org, sivaa@codeaurora.org,
        Andy Gross <agross@kernel.org>
Cc:     Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH v6 4/8] drivers: thermal: tsens: Release device in success path
Date:   Mon, 24 Feb 2020 18:28:51 +0530
Message-Id: <9210fe430e75f6e971358c1db823d69ccab43580.1582548319.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1582548319.git.amit.kucheria@linaro.org>
References: <cover.1582548319.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

We don't currently call put_device in case of successfully initialising
the device. So we hold the reference and keep the device pinned forever.

Allow control to fall through so we can use same code for success and
error paths to put_device.

As a part of this fixup, change devm_ioremap_resource to act on the same
device pointer as that used to allocate regmap memory. That ensures that
we are free to release op->dev after examining its resources.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Link: https://lore.kernel.org/r/9fa8a4e09b6fcff4b9d4facc9f9e9f8e3c4a41d5.1582048155.git.amit.kucheria@linaro.org
---
 drivers/thermal/qcom/tsens-common.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index 1cbc5a6e5b4f..013750fff8b2 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -602,7 +602,7 @@ int __init init_common(struct tsens_priv *priv)
 		/* DT with separate SROT and TM address space */
 		priv->tm_offset = 0;
 		res = platform_get_resource(op, IORESOURCE_MEM, 1);
-		srot_base = devm_ioremap_resource(&op->dev, res);
+		srot_base = devm_ioremap_resource(dev, res);
 		if (IS_ERR(srot_base)) {
 			ret = PTR_ERR(srot_base);
 			goto err_put_device;
@@ -620,7 +620,7 @@ int __init init_common(struct tsens_priv *priv)
 	}
 
 	res = platform_get_resource(op, IORESOURCE_MEM, 0);
-	tm_base = devm_ioremap_resource(&op->dev, res);
+	tm_base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(tm_base)) {
 		ret = PTR_ERR(tm_base);
 		goto err_put_device;
@@ -687,8 +687,6 @@ int __init init_common(struct tsens_priv *priv)
 	tsens_enable_irq(priv);
 	tsens_debug_init(op);
 
-	return 0;
-
 err_put_device:
 	put_device(&op->dev);
 	return ret;
-- 
2.20.1

