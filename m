Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 587637AD9A
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2019 18:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732854AbfG3Qcd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Jul 2019 12:32:33 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37083 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732828AbfG3Qc2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jul 2019 12:32:28 -0400
Received: by mail-wr1-f68.google.com with SMTP id n9so41401344wrr.4;
        Tue, 30 Jul 2019 09:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g5tURnCPvlR1FgVTUPFvio04s8CzBn2V+f8QGTCwOFA=;
        b=IGInv4Z4YwMrX+CzLKwBULMOwtb1kMKFrTq5nNuQJXWIxGRIAxRnoRhL/V0wizQrc2
         OYfkqFqb8nmpMrTo9SIAWsIHJP+aWJouQTY/LOHOCZvYu5hbbCALBhYFe6DmdiNBTp0L
         DCp9z6Bc4mJ5sXMG/uLNbAEJRkcXeI+OlsqPj4a5muYfK/QU2EKmdDqTaHUrDSyI67cd
         2f5Hoq6j6xmbvpWaWycijHRihZuxYHaBY58LEuznOBmhb+2KRsWS6iwG+1ceup7Ss5qq
         DWz/uzhsDsC7ATPepc0H6DB5JvVFYqrNhfW7vNu0q1ckJzvq1+a5Tf/oN4dDe29E5ifo
         PXQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g5tURnCPvlR1FgVTUPFvio04s8CzBn2V+f8QGTCwOFA=;
        b=aGNo+BO9D/+JEZmXqtzFk75iD6Ar5aPU+l05BA+CCgdFFdbE2CNYkIpAq4fuYY6IUG
         QeNl6p417OutPFcg2Fe0Otk/qJfM40x4iXH9g2X/2kAyrOrRBhP0/syoV2KTcXa5J+iG
         tOcv0kHLksGJNbDRy0L6Us5KVNEWXheEYlQU17PTgQTnuh+V2KCoUayJrz+3gZk/S8ZL
         MgdhjkE9b29uRXfrQuxoWcpVBE6YCUd/LfViJOuTOyLMj96oH/nl1byIOHEF766bmVEx
         L3bGQVM6sixydsdnEiu+NiYlADJ8/jnjKzuxW8UI8zKwt9cOxvpfH3mPsjrPbr5Dq/VU
         9Ccg==
X-Gm-Message-State: APjAAAVNl2AG3MuBV+J7UkM2GzooDjYSTlnXnzwSbERQ2SmfdqhddELT
        SIdepviy5KHCa6dPXC+MYp740ibt
X-Google-Smtp-Source: APXvYqwd3YWgwQpq7SrWlW8v2kpTJkh48PQh6m24ruER9NF1l3cCVBckpMSQWVcPAfZly9ld9NEJfw==
X-Received: by 2002:adf:ed8a:: with SMTP id c10mr132636248wro.33.1564504346710;
        Tue, 30 Jul 2019 09:32:26 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-220-99.pppoe.mtu-net.ru. [91.78.220.99])
        by smtp.gmail.com with ESMTPSA id c65sm64835175wma.44.2019.07.30.09.32.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 09:32:26 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 06/20] PM / devfreq: tegra30: Tune up boosting thresholds
Date:   Tue, 30 Jul 2019 19:22:22 +0300
Message-Id: <20190730162236.6063-7-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190730162236.6063-1-digetx@gmail.com>
References: <20190730162236.6063-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Now that average-sustain coefficient / multiplier is gone, it won't hurt
to re-tune the boosting thresholds to get a bit harder boosting for MCALL
clients, resulting in a more reactive governing in a case of multimedia
applications usage like 3d / video.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 2331052fd8bd..4525c051f85c 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -111,8 +111,8 @@ static struct tegra_devfreq_device_config actmon_device_configs[] = {
 		.irq_mask = 1 << 26,
 		.boost_up_coeff = 200,
 		.boost_down_coeff = 50,
-		.boost_up_threshold = 60,
-		.boost_down_threshold = 40,
+		.boost_up_threshold = 50,
+		.boost_down_threshold = 25,
 	},
 	{
 		/* MCCPU: memory accesses from the CPUs */
-- 
2.22.0

