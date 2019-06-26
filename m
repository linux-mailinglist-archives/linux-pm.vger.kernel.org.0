Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8891D55D91
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2019 03:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfFZBfN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Jun 2019 21:35:13 -0400
Received: from mail-lj1-f176.google.com ([209.85.208.176]:40520 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbfFZBfN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Jun 2019 21:35:13 -0400
Received: by mail-lj1-f176.google.com with SMTP id a21so410086ljh.7;
        Tue, 25 Jun 2019 18:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CGZLSAOSCX2ukpdIKr7yrA/D7uj3ejgsDhB+FZTC0rs=;
        b=HfD0P73KYrHLhypYu5if3iQFfdcXKuHHkiEZHCj8FNZCtZQceBrpfyVcIzDb1c8PXX
         C6InukuET6MfAZ34bcU+BTNXdEho+OgmcK9I/GDX4j39KIOAhrhcw8TR09Snd7iJBFqW
         Z5uYk1clVTbfCwq3QiFCjR4vZQ+k9815r6xDqyb8h0EJysjO8h34qLUJYSfTLQ6pKKPt
         KCa9IckTGpvE8bZMJNOcA42zHh3hov6h5CNCpki4mqIOCCL3zM7HzoxBTYWrNZWN1weL
         Fb9mgLbDdJMl7562fzqtZRoD6w9k+uCRkNwQhmmJEeTfKXO5FyXDZj9LzyqRX5TjiUPz
         PIxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CGZLSAOSCX2ukpdIKr7yrA/D7uj3ejgsDhB+FZTC0rs=;
        b=bPXRCDynsd1RNIk+Urhdkn+LhQ2oQr1CNbJXbHvzUo7tOl0+JLOlxSMO44E1VCaEa+
         6E+dVo49DeJmgao3wtrtrXUkwxDcyaEk0OvOOwzh4vFqyYBrHv9xqkktRqcimHuibxKG
         tLNXjAB24eHjjf/GfSmJf/mC23mCVmjtGWkmtQHm9Li5dOTrKRVsgAOD2ywdFvBRuJLN
         1b0fGXaaE7IYgtdTyz3FsuXqNbb1l/zAxWtHd6RZFTk9kthziWOv1qn12vHh7OM3Yyp3
         84Mp829jMVHHQw1vnDDUuRJq7eXUWcfdXa/FHK/HgA8vADdirLqNYWm05Li625cxhPpQ
         vbHw==
X-Gm-Message-State: APjAAAUjqLxdAdzbK1RAIhgsgjXfz2Vm9lEG+EyKhhW+TGvSoxLzb2zC
        scGoIwryHQ8k63Jf91VOZ6s=
X-Google-Smtp-Source: APXvYqxyQMkkvB0wQdu53o/X1w6Hh7JnOzM8e2r3q1Heim80uTnr8wdNnu8b8q/BDoiFrgm5VscYdQ==
X-Received: by 2002:a2e:81c4:: with SMTP id s4mr879268ljg.182.1561512910494;
        Tue, 25 Jun 2019 18:35:10 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id 199sm2549581ljf.44.2019.06.25.18.35.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 18:35:10 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 14/17] PM / devfreq: tegra30: Ensure that target freq won't overflow
Date:   Wed, 26 Jun 2019 04:32:48 +0300
Message-Id: <20190626013252.30470-15-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190626013252.30470-1-digetx@gmail.com>
References: <20190626013252.30470-1-digetx@gmail.com>
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
index d85de0e3dce0..1dcc2d2fa9e0 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -458,6 +458,7 @@ static unsigned long actmon_update_target(struct tegra_devfreq *tegra,
 {	unsigned long target_freq;
 
 	target_freq = dev->avg_count / ACTMON_SAMPLING_PERIOD + dev->boost_freq;
+	target_freq = min(target_freq, ULONG_MAX / KHZ);
 	target_freq = tegra_actmon_account_cpu_freq(tegra, dev, target_freq);
 
 	return target_freq;
-- 
2.22.0

