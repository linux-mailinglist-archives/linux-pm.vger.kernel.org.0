Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46F8511F7D9
	for <lists+linux-pm@lfdr.de>; Sun, 15 Dec 2019 14:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbfLONCM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 15 Dec 2019 08:02:12 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35959 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbfLONCM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 15 Dec 2019 08:02:12 -0500
Received: by mail-pl1-f196.google.com with SMTP id d15so3303208pll.3;
        Sun, 15 Dec 2019 05:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=quqseq6iPMQF1FVXX9HnBc22kYXAEYNLOrdqtNexOas=;
        b=p2RO5v4iwHSr0AQpXjRerB2HVhxbf8qXUlVHWlPFTNtK3Qwb75plrABEwRdDpW0ulW
         Jx/h8CUWGX+hAOkrLX1JWG34yee2RAEIefKvn2tEnDdcj+DZ1IgXwrVw5ULyDveRnKVO
         pNwOkKdTeF0wo/dQBbqfwrFDJP+MJVAm97q+Rdv54S3/PTEkeNmwx+T43lxIBNTFDORO
         8tsV5PH9lxpKyeh3D9ZQiG2DAVMITwlebsVvRW+MyaUkQszObe6INnjG7mNYUqkva47Z
         BijQfYWZRd0BZrEmFNB5mueaSkAJe/GQjvM/+s4YImQx+jync7/5qvC6wfU4gUbm6N/z
         N4pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=quqseq6iPMQF1FVXX9HnBc22kYXAEYNLOrdqtNexOas=;
        b=hAT4cE+vb5mVrT/3zQx45aXDNA9jMys9mMVGQrlOno701bXkKVon/8xUKxul2VWajw
         MRiWcMXhPZIJe6CpDTQVJmS2KG+uZbZy4+bHdaqCJ7oFVDskPIBwkOa5SAPASPavhQba
         HmimgWuvbZlqWl3V4hOdVA0+bo2hJUKQ3Fc/cYC1z4NvekckUB/CbOUR63lkAS6juys0
         IEL5pJ2koEv+m7p4qnu1ph3ZMXuB4C8h0StOe6Dnp5Waeddtnhu8gPdUDtail1zFGb0m
         mJKVPP0VcyxUWtdzIKHSutd214vQ1w9f5lvYLzQtLZ7UND9e+NxZwW2N7ovVWkQL7SrZ
         HR+A==
X-Gm-Message-State: APjAAAWk71DktkJH1z6c+XvP6LbQn2g/svogCM2sZM+Z1KLU0DOc+Xd0
        Om59Xs2iaoqRdIGk8/1aflo=
X-Google-Smtp-Source: APXvYqwSZudvDKwwD+qN+akaodIq8lTpRSPuMTSkixiJXC+E+W/W6GOnXscbqm98VGni5Kla7iwPsg==
X-Received: by 2002:a17:90a:178f:: with SMTP id q15mr12153921pja.132.1576414931682;
        Sun, 15 Dec 2019 05:02:11 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id k15sm18675514pfg.37.2019.12.15.05.02.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Dec 2019 05:02:11 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     rjw@rjwysocki.net, daniel.lezcano@linaro.org, shc_work@mail.ru
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 1/2] cpuidle: kirkwood: convert to devm_platform_ioremap_resource
Date:   Sun, 15 Dec 2019 13:02:06 +0000
Message-Id: <20191215130206.30265-2-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191215130206.30265-1-tiny.windzz@gmail.com>
References: <20191215130206.30265-1-tiny.windzz@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/cpuidle/cpuidle-kirkwood.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-kirkwood.c b/drivers/cpuidle/cpuidle-kirkwood.c
index d23d8f468c12..511c4f46027a 100644
--- a/drivers/cpuidle/cpuidle-kirkwood.c
+++ b/drivers/cpuidle/cpuidle-kirkwood.c
@@ -55,10 +55,7 @@ static struct cpuidle_driver kirkwood_idle_driver = {
 /* Initialize CPU idle by registering the idle states */
 static int kirkwood_cpuidle_probe(struct platform_device *pdev)
 {
-	struct resource *res;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	ddr_operation_base = devm_ioremap_resource(&pdev->dev, res);
+	ddr_operation_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(ddr_operation_base))
 		return PTR_ERR(ddr_operation_base);
 
-- 
2.17.1

