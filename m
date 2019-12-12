Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BEBF11CB3A
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2019 11:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728823AbfLLKrE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Dec 2019 05:47:04 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36925 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728648AbfLLKrE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Dec 2019 05:47:04 -0500
Received: by mail-pf1-f195.google.com with SMTP id p14so556759pfn.4
        for <linux-pm@vger.kernel.org>; Thu, 12 Dec 2019 02:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fE7IMePVLjFQjnYVNQlVTOVLLvpMYOoKCNMHpXwByQE=;
        b=EuHUCtrpzZjIKeMwhyCsgclqRS53cCfdpAYCbWldWKNmcScTnhi64z/RsE/aA7VEer
         JKH2n3QfWHAZO28XgcsvBHEQJPoYGcg9YOKnqK+7pDBpG/EUxUUZOpuQm8Q80v7zyfxc
         MTGN7mlm6lLZIDLT5z/C7rnQoGiaqMzvW6BJ1Lls4ayKIcHpMeul81N28pNEGZcL+psH
         PhnxGIS7CM+IOCWsw9hFgcQ/MObEgHI15ge06gpvLvgZHmuuHZvr6Gosd9TvAeU7SrDQ
         wYZYG10uF7xzX7QooSfVLM3Xsu0/33f1xiGwHcM+iZXwFtL5TEwSdoE+V4VBoACMRQQE
         4h6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fE7IMePVLjFQjnYVNQlVTOVLLvpMYOoKCNMHpXwByQE=;
        b=Cvm3eYkicb0ArSM4KkG1IdrsDvEbK/SZ6hpV8JQR8Dm6oznYc4yVy8GruyIUXoHh4c
         q5r6qxWGkmG/vguqWOXN67xxV6+CitvceqeZNaoMfvOnxxCBu3eklAhx4yJnwpTMHGm1
         8rycUEB/o3fYHxWEtm9kLROPQcvlq50Xpbx9oov2BYYibodfPZGvw5dYbeiWHFL81PWb
         W0d74b+o3SlNpfi64hZqhCpW+hD0xQJaNx6L3qcMykrn80LPwCt9zAvYVmA2M53fmnTr
         CG+g1RvQLEuz0NLHFY0OT+OB7GEehap37ywh60wqbrpMFcP2horcjGYpUOGNNIlMnUaQ
         ivtw==
X-Gm-Message-State: APjAAAUzYeG1sutYdfCsdM+7i4lIKY1N8PxLVlK+93uU6wumhjMHmehX
        8y7BY759JYnyGOo0Ooj1MvOKbQ==
X-Google-Smtp-Source: APXvYqxWdvDwQltpsuhPKSoxi1BqstgmYgEslmyM4ahlal9Rw/GqAYZAzIv0H1YLCLS/Q8y43/TNbw==
X-Received: by 2002:aa7:850c:: with SMTP id v12mr9061225pfn.188.1576147623344;
        Thu, 12 Dec 2019 02:47:03 -0800 (PST)
Received: from localhost ([14.96.118.80])
        by smtp.gmail.com with ESMTPSA id l18sm6635869pff.79.2019.12.12.02.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 02:47:02 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, agross@kernel.org, swboyd@chromium.org,
        stephan@gerhold.net, olof@lixom.net,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH v2] drivers: thermal: tsens: Work with old DTBs
Date:   Thu, 12 Dec 2019 16:08:14 +0530
Message-Id: <cea3317c5d793db312064d68b261ad420a4a81b1.1576146898.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1576146898.git.amit.kucheria@linaro.org>
References: <cover.1576146898.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In order for the old DTBs to continue working, the new interrupt code
must not return an error if interrupts are not defined. Don't return an
error in case of -ENXIO.

Fixes: 634e11d5b450a ("drivers: thermal: tsens: Add interrupt support")
Suggested-by: Stephan Gerhold <stephan@gerhold.net>
Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 015e7d2015985..0e7cf52369326 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -110,6 +110,9 @@ static int tsens_register(struct tsens_priv *priv)
 	irq = platform_get_irq_byname(pdev, "uplow");
 	if (irq < 0) {
 		ret = irq;
+		/* For old DTs with no IRQ defined */
+		if (irq == -ENXIO)
+			ret = 0;
 		goto err_put_device;
 	}
 
-- 
2.20.1

