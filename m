Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 242A96A5EB
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2019 11:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732671AbfGPJzJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jul 2019 05:55:09 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43312 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732656AbfGPJzJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jul 2019 05:55:09 -0400
Received: by mail-pl1-f196.google.com with SMTP id 4so2882672pld.10
        for <linux-pm@vger.kernel.org>; Tue, 16 Jul 2019 02:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=72lapS1gikWJzRuHujLBmPCAQQBs6mR5D22kmc/6LFI=;
        b=Ic+8VmZBJDL+AveYtejzGXQn+oCRJbcOkYUcEdKomP2PxUCxknQBSiHwU/AXBFr7ud
         L+wyHFUGzxanL6nLtLdNriPaJsYtakivv2DKKpX8kE58v2PUaQduuMX4+DiCOk3QhUOE
         QrRIcJu96ZU06gv6PTc+D4xzaoIoTccec2ZqJPlg2zdqwspbE5tN/ILsRmsEkvg+IUha
         3tIr4/FS6SXdYCQvg4MlXTwrcyHBInZrJR0cs9F9Reu5+8In9qNkgJqbJgjwBE9QOOKd
         IJ/xaYDVX7aesT7XMV/ZUpdMv2d7rS5M8jjt4u38R5nt6ZDf8mBtp/EJLWLlvdfbSFLN
         Qysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=72lapS1gikWJzRuHujLBmPCAQQBs6mR5D22kmc/6LFI=;
        b=JBOTNGi97rr1LEIkBq0fohS2mdXy4GbXmUdpxdN0ofrpNvXkOLCuy0FiUxP2omaSpp
         QsLyXOoYk0qwjh/YO6NV1J621BefIl7ScVQ055tvM/9IQvBxN3tXciXTlB7Ce5HkFDDh
         Y8LzQ5mciSc5tJnpKT0U42ibCHy0/E73+oPJptlupeEsCupwVMiVzM1kuLUem1H2Tc6i
         sisV5IneG6GUZslLXI/t1HGQLriUX3X1yrVh+900TB7KaQ8axQJjRuNrXk0PGB7Mnnt4
         bFA1uOJZrZpujQc9OzDxq8XuaE/GJFBpLJnKNT4CpH5nHGXPSCy24Xap940ozfdX1cUT
         XeWw==
X-Gm-Message-State: APjAAAWZN6lVzE+u9qglG6jxl0IxsZHtwWNjGldQIywJVyM8FzLokID/
        m7MCzJtjY7h0VVt8gCh0ikomNg==
X-Google-Smtp-Source: APXvYqzeaNi38O9lql/oJoXxZ6MU7hs7u5/fWqENPyDBh1gH3wmJqSzZjATK903NFWCSI1oGuaBluA==
X-Received: by 2002:a17:902:f216:: with SMTP id gn22mr33365742plb.118.1563270908342;
        Tue, 16 Jul 2019 02:55:08 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id m4sm38578557pff.108.2019.07.16.02.55.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 02:55:07 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/10] arch_topology: Use CPUFREQ_CREATE_POLICY instead of CPUFREQ_NOTIFY
Date:   Tue, 16 Jul 2019 15:24:48 +0530
Message-Id: <c7b330fa1dccfc44314089ffd0edc2726de35213.1563270828.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
In-Reply-To: <cover.1563270828.git.viresh.kumar@linaro.org>
References: <cover.1563270828.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

CPUFREQ_NOTIFY is going to get removed soon, lets use
CPUFREQ_CREATE_POLICY instead of that here. CPUFREQ_CREATE_POLICY is
called only once (which is exactly what we want here) for each cpufreq
policy when it is first created.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/arch_topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 9b09e31ae82f..49f2884fe77f 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -175,7 +175,7 @@ init_cpu_capacity_callback(struct notifier_block *nb,
 	if (!raw_capacity)
 		return 0;
 
-	if (val != CPUFREQ_NOTIFY)
+	if (val != CPUFREQ_CREATE_POLICY)
 		return 0;
 
 	pr_debug("cpu_capacity: init cpu capacity for CPUs [%*pbl] (to_visit=%*pbl)\n",
-- 
2.21.0.rc0.269.g1a574e7a288b

