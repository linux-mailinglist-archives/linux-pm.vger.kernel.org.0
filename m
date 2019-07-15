Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A42C699EA
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jul 2019 19:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732122AbfGORai (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Jul 2019 13:30:38 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43447 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731820AbfGOR3y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jul 2019 13:29:54 -0400
Received: by mail-lj1-f195.google.com with SMTP id 16so17082390ljv.10;
        Mon, 15 Jul 2019 10:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YB/K51J2yBjrGqQBOAGlFNTt2rdW770Na58VRvSkzkE=;
        b=G9r1UpHe9emFel8CP1Z4Q/bhOOyPPtMwUPGjut2D2WJ5X7sg4agszqUKUO42WEeXxO
         1P7iKfqH87IK9lPCUtqFtNDS7Y7ETgi9VOuufW9wEt0GpnZzfvUgQIczex830SIwXAQe
         tgAppGVlXy7vn1hY6MRXISj6MJH0nksjUdyEtOtf+oG1AbeQ3HgTr8BiFfwmNxx2Q0aT
         +k4pdY/TSo0M8pbgIibURbNgg+Czv6saq/6yVQlzWO5VnMDYV77Im8fdJnCKkfaKceJy
         HKmHmt/U/lii15n2Cev059HpaEWR5zxR57bEnrPjRTNJqxiZ/n3rHPFHx6RSnZjzDSLi
         MmSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YB/K51J2yBjrGqQBOAGlFNTt2rdW770Na58VRvSkzkE=;
        b=UZFDIVNCvCPW1SRDrj9dhrFjv4FLkWzDfkDD+z+XMfWluM0VVE2vHBGtOHRcdUarMb
         mS4YrnQqnrY6KKHuRjPpv45FaIUAZKEm2SUCcOcp6gCmPAuujfEOmTqMZaleN6zSbUl4
         xjQBEogb2te9Yd1AEtOfXZGRe4Gq987XwyNf4KvFqIr29phzrtMlYOke+9Jr8rJT3BhC
         W+iZIxXhDNa6qJyxEjBeqdy0P/n8A+1It5TymcPUqRcVoz1ORxXM4Jtw1QkZAkwvlmvO
         I0WPcdujtoOTEK3TX9Pe7LIAGRkcOXZtQQSjkG2HanObbnzPlkfDfxncnP87WJmy+q1y
         hsdA==
X-Gm-Message-State: APjAAAU6ZNDLLWkvD9Qpjnzqvf68MoCoNGfuvDgP40LbNoRS5ygmJTwY
        cOVh1mRkZAW2KiBWIqwzSNQ=
X-Google-Smtp-Source: APXvYqzYar7cir4nEVfsw6pDWLzHKGGrWy3yMbYTr6PHAK+wnKscoo/k7Aj37D/0aOCGiOjSrG7D/g==
X-Received: by 2002:a2e:9213:: with SMTP id k19mr12089693ljg.237.1563211792709;
        Mon, 15 Jul 2019 10:29:52 -0700 (PDT)
Received: from localhost.localdomain (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.gmail.com with ESMTPSA id b17sm3248765ljf.34.2019.07.15.10.29.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 10:29:52 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 08/13] clk: tegra: Add missing stubs for the case of !CONFIG_PM_SLEEP
Date:   Mon, 15 Jul 2019 20:26:24 +0300
Message-Id: <20190715172629.4437-9-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190715172629.4437-1-digetx@gmail.com>
References: <20190715172629.4437-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The new CPUIDLE driver uses the Tegra's CLK API and that driver won't
strictly depend on CONFIG_PM_SLEEP, hence add the required stubs in
order to allow compiling of the new driver with the CONFIG_PM_SLEEP=n.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 include/linux/clk/tegra.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/clk/tegra.h b/include/linux/clk/tegra.h
index b8aef62cc3f5..cf0f2cb5e109 100644
--- a/include/linux/clk/tegra.h
+++ b/include/linux/clk/tegra.h
@@ -108,6 +108,19 @@ static inline void tegra_cpu_clock_resume(void)
 
 	tegra_cpu_car_ops->resume();
 }
+#else
+static inline bool tegra_cpu_rail_off_ready(void)
+{
+	return false;
+}
+
+static inline void tegra_cpu_clock_suspend(void)
+{
+}
+
+static inline void tegra_cpu_clock_resume(void)
+{
+}
 #endif
 
 extern void tegra210_xusb_pll_hw_control_enable(void);
-- 
2.22.0

