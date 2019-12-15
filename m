Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E102E11F7D4
	for <lists+linux-pm@lfdr.de>; Sun, 15 Dec 2019 14:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbfLONCK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 15 Dec 2019 08:02:10 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:37483 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbfLONCK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 15 Dec 2019 08:02:10 -0500
Received: by mail-pj1-f68.google.com with SMTP id ep17so1806140pjb.4;
        Sun, 15 Dec 2019 05:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xNa0YO9i+PgQItqALzHc2Ca92D6+HcEc/gZ6BbMbQCo=;
        b=anFNcxAJvR3IX167LmYZb3wvbf+jRobRHPJ31pDH1PrN5fnW70yM5jcvhXRQRLMPTu
         m4blTi+idGxM0T4eCf7cZKA8k4oIQNgmnMh/dLjC6FJut+e5mSjtMh7Q5nEirI1y6J5X
         MrlNYq9IoghInUaTWfXvpp31+wgobK4K+Ndzi+80DBPEtfYGO0xat+vkO3gaum+9Bj+Y
         QuOXkgF6uE2zXThOvKZjMfEPnKTcaDFxaMESzimnsEeU69EeBQFupmazyGy4HXYaAJpd
         8YBejr3Zn5fQb+mih5oM6XkPq2Z/QoleVi1U2DvuVNfx8pB15FrbdOb34IegX/gg6LTU
         Hb/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xNa0YO9i+PgQItqALzHc2Ca92D6+HcEc/gZ6BbMbQCo=;
        b=PyV7IemaF27mqSisfNzbFPLzm0tdtde2oJACYppw/JSkD3Kn7g9GzUkk9DaCaLqJOz
         PaTxKZw9d5llJdvLhb65e3sWAkSWmvyxyEw8kTvylZKkoPTjwGN4w6MoPFj0IOousehK
         GcQkHHY4rWV6TLQiWcDAIxv/7gjmnqqr5IOXT4vIR/KavgwkTthucz3Esha8HoLIYiDK
         aBkBqAOO64BZd0BIn+ACC8HJIPbIK+GWBn7HX3r0Og7V7ZHqXbQaF/sfiyuoOx056QdL
         C44DHlmKfomXlL5Ip4oCCukFJ3Qa0sK9KphgIMatr7kbm3qXyWIwtVmYvWtwm8F3FIaS
         o3lA==
X-Gm-Message-State: APjAAAXMIznsnL//SCWXDN2zvboJ0LGjrlZv02j/GiFSfff6+kf9Mrx3
        8/fJMZRsAUTUCPo38fQSVQE=
X-Google-Smtp-Source: APXvYqweRAPO3QMbCaNi3MbULtPGBgI7s0pOkFauOXkW+xKr9IXis34RDvftiP+xuFAJWohKKYgaqA==
X-Received: by 2002:a17:902:d915:: with SMTP id c21mr10585935plz.295.1576414929617;
        Sun, 15 Dec 2019 05:02:09 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id m27sm18896092pff.179.2019.12.15.05.02.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Dec 2019 05:02:08 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     rjw@rjwysocki.net, daniel.lezcano@linaro.org, shc_work@mail.ru
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] cpuidle: clps711x: convert to devm_platform_ioremap_resource
Date:   Sun, 15 Dec 2019 13:02:05 +0000
Message-Id: <20191215130206.30265-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/cpuidle/cpuidle-clps711x.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-clps711x.c b/drivers/cpuidle/cpuidle-clps711x.c
index 6e36740f5719..fc22c59b6c73 100644
--- a/drivers/cpuidle/cpuidle-clps711x.c
+++ b/drivers/cpuidle/cpuidle-clps711x.c
@@ -37,10 +37,7 @@ static struct cpuidle_driver clps711x_idle_driver = {
 
 static int __init clps711x_cpuidle_probe(struct platform_device *pdev)
 {
-	struct resource *res;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	clps711x_halt = devm_ioremap_resource(&pdev->dev, res);
+	clps711x_halt = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(clps711x_halt))
 		return PTR_ERR(clps711x_halt);
 
-- 
2.17.1

