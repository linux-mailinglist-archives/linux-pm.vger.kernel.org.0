Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3A4958CBB
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2019 23:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfF0VNY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Jun 2019 17:13:24 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38881 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726749AbfF0VMk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Jun 2019 17:12:40 -0400
Received: by mail-lj1-f195.google.com with SMTP id r9so3810374ljg.5;
        Thu, 27 Jun 2019 14:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A/wvZWRvPJt4kWryTQr1tyDplrxh8gTwF3cbwz+VuPI=;
        b=mgtVOsBZl5cwqumrIrxMW6w5E1Bi4rVjPCzLrN0LJbkZ/rbe92kghNjglVxs4p2Vkh
         F0xujlaTpXgdNbd72B1lIxyoFXMkwf1/J8e2bRdBQS0zSd191b1qPdf7sD/MeG+N8ubL
         esEnFtgridGEtTmhMbj2Pu5QwUWPw4t/ddyKYlvNobVhPefLcH1sU+Bpjj/KtowaPJEY
         UqxYGIJY386zWu2fWcKT3KQ+w0B2UwMJEjVSCc0SODUbHmaPtb6DisiZaVW/2vHk0sNc
         Jj+Fwenq1eUxt65uf8op/Gz+CwYXNjfTBJXN0Lyk6FrPu0q33+m65opB0k5q0XRG/OZ0
         RzcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A/wvZWRvPJt4kWryTQr1tyDplrxh8gTwF3cbwz+VuPI=;
        b=UCt29rzUvnQBcyVBSnUvUAboc+zrMdfppKb8OcJOECj23UYStMWQaCwaJI/LD9i9Tk
         3Szb7EsYMiSAJOBygYtGBDOcMn1Vz8ZZ4YSoDfEdnTXGztKLdzQQz9TegR7w54Fbqa9D
         WPffUXgXnwi6qV5AYVo5vuJA7UOvw9KwBAKjkFpjIad0iXBEmtCdjfjgXvJjTn/VVL4b
         Stmu1NDOhoTJ9uwxtl+Qj4jUYH7JkauOevpWD0mYaelEl0eImzgR0g4vj0Q8scc2FGpz
         0Vzlrd4RPokVf3ysQaR4g86tB8RF+DXECAoeSun7+1bvWEBOI3f79PKdy24ytGa5BmJF
         thtw==
X-Gm-Message-State: APjAAAU25BYaKds6Wka8SY5TjgoexEwYYug31tRuPKo6LDhjh6a+2sGL
        XeohWWw5wmyesfYwh/X/IT4=
X-Google-Smtp-Source: APXvYqwEF0ay5gYXN5NBBL/TKVwQWVFsCQKRGebiHF2ydGGo66JBoBTRwnx0d820rE4UzlJDGVte7g==
X-Received: by 2002:a2e:8515:: with SMTP id j21mr3951641lji.233.1561669958102;
        Thu, 27 Jun 2019 14:12:38 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id p29sm30485ljp.87.2019.06.27.14.12.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 14:12:37 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 14/22] PM / devfreq: tegra30: Ensure that target freq won't overflow
Date:   Fri, 28 Jun 2019 00:11:07 +0300
Message-Id: <20190627211115.21138-15-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190627211115.21138-1-digetx@gmail.com>
References: <20190627211115.21138-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Potentially very high boosting could cause an integer overflow for a
highly clocked memory after conversion to MHz.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index d3e117d827d2..f86593ab3008 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -459,6 +459,7 @@ static unsigned long actmon_update_target(struct tegra_devfreq *tegra,
 {	unsigned long target_freq;
 
 	target_freq = dev->avg_count / ACTMON_SAMPLING_PERIOD + dev->boost_freq;
+	target_freq = min(target_freq, ULONG_MAX / KHZ);
 	target_freq = tegra_actmon_account_cpu_freq(tegra, dev, target_freq);
 
 	return target_freq;
-- 
2.22.0

