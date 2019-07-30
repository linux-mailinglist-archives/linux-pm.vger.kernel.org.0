Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA7D7AD97
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2019 18:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725871AbfG3Qcc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Jul 2019 12:32:32 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33964 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732831AbfG3Qc3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jul 2019 12:32:29 -0400
Received: by mail-wr1-f65.google.com with SMTP id 31so66515162wrm.1;
        Tue, 30 Jul 2019 09:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WHBbqbfFd0BRb3uV6lTGI/raeYIwezEYsIDJ6CAqnew=;
        b=NOsQUkAHUbBKJkEQDYdf9orMNjGdUlOLEbihtSpdWqMReWthFuC7gSvsnTq6k0HJu2
         WXLTu49yiS9IkRNFuM2dmZWl53KqzY0aNt71mzrweHjPE95NsaErymAHmPPkL5Ui87Gv
         FzQzWg/IpryqzRPE2NvosLu0nhGrZKk9LTKV5OAbOsRSNQj31FjK4VgPtwH79V+v0Pnu
         hq7W8iwWInx+F+C8WYEfc9Qjm7Hw5Puff4FlMmcgbu+/dUemJkedAYBTzYjaG1U6FWJ9
         pY3QFdmyJp4eUd+7GeLDXDRd03bJ+tr5rRaUe+zaXD6583btfDgfaIhhnuSvy5odbcU3
         5hGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WHBbqbfFd0BRb3uV6lTGI/raeYIwezEYsIDJ6CAqnew=;
        b=G5RY28pL4PbBwl+Xs69+XN3QCldEg9zLTXIi9k1A/yGW+zAttIudpNFWxZ55jn6v6a
         iFhjYYG4+nuE7vyN4tiLVl8jF+FwWkr7MiEaL6LvfonigFS2giK+s09BPpqo9pVPvb1m
         rkBd0gJnB8nESeoz2mR/ekmR027t/IkXehsCqLzopWDVaxgF/TmS+Mx59Kx4H0UAAkp+
         lsZoSw1Y7UCUBpbPbxzK8CvljAqXkbnI3s01f7KN3++6fUU9EZYZ09mBmv6d++hmiLl5
         rcrrz1Lr7fOTq3Tq36vv1Do+W5ZOsu/OE0qboVdkXDjeNPLvoK0iPqiMbmtJCnykjUb9
         AytQ==
X-Gm-Message-State: APjAAAW26sijGKqVZ1qAdU1pDJf2AziIpfa2GA8qjlUTYWVLEbmIJuWt
        IE5Vz7+3zS9j9g1ACOnGf40=
X-Google-Smtp-Source: APXvYqzGQEp+w42idntKHGTPcZFnvHK7pxdgdlOjEGe3nu686QWc4MYOrCIqgRrUzTQ1l8Iif6Yd9w==
X-Received: by 2002:adf:dd8e:: with SMTP id x14mr126350891wrl.344.1564504347946;
        Tue, 30 Jul 2019 09:32:27 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-220-99.pppoe.mtu-net.ru. [91.78.220.99])
        by smtp.gmail.com with ESMTPSA id c65sm64835175wma.44.2019.07.30.09.32.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 09:32:27 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 07/20] PM / devfreq: tegra30: Fix integer overflow on CPU's freq max out
Date:   Tue, 30 Jul 2019 19:22:23 +0300
Message-Id: <20190730162236.6063-8-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190730162236.6063-1-digetx@gmail.com>
References: <20190730162236.6063-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There is another kHz-conversion bug in the code, resulting in integer
overflow. Although, this time the resulting value is 4294966296 and it's
close to ULONG_MAX, which is okay in this case.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 4525c051f85c..70dce58212a4 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -70,6 +70,8 @@
 
 #define KHZ							1000
 
+#define KHZ_MAX						(ULONG_MAX / KHZ)
+
 /* Assume that the bus is saturated if the utilization is 25% */
 #define BUS_SATURATION_RATIO					25
 
@@ -167,7 +169,7 @@ struct tegra_actmon_emc_ratio {
 };
 
 static struct tegra_actmon_emc_ratio actmon_emc_ratios[] = {
-	{ 1400000, ULONG_MAX },
+	{ 1400000,    KHZ_MAX },
 	{ 1200000,    750000 },
 	{ 1100000,    600000 },
 	{ 1000000,    500000 },
-- 
2.22.0

