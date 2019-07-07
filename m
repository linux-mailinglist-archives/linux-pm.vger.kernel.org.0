Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD1F617FF
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2019 00:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbfGGWfh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 Jul 2019 18:35:37 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37768 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728245AbfGGWfg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Jul 2019 18:35:36 -0400
Received: by mail-qk1-f194.google.com with SMTP id d15so11883282qkl.4;
        Sun, 07 Jul 2019 15:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k9WSyPCB4rRAI9+QNTWdJTxNh0K8pTknWsVtmMdfXoE=;
        b=YYWFYuliBA0TJafpCWYhmHq/ipz530A97NxM3WFJNFfsKoAxq5AIRXCvQbDGYaHo6o
         AA3yi7pZ0KNDrop79OiD6XOrcu9Wb9HUjXdnbXH9c4GS2mBZoSRrDYJzJnrbJJoQik6O
         WF8VsCWbl5RVdDKdcfse0CKrufD0BT7HjqfzEe5GQEywxuCbln2qYUYGVbXZ1/tZpIUc
         9RwwPuSbZiMpTiI+Osl3deDosszvcvI29OmVDGHa4/Un/Qp4hZB2P5sHv88uWw2DOIfV
         /J/G52M8M5mlLelP3vGHOFPb+9rjoX1y6h8/LNt+UWT2AohWUHNt5dUrPqPc/8rfY6eO
         boPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k9WSyPCB4rRAI9+QNTWdJTxNh0K8pTknWsVtmMdfXoE=;
        b=i3FCEpnfL+zrGQc4Nv+L10R25C8HSuND7kU3zk0AlAl6uMGkDdySP5yhq2JPK7vhsU
         DJjKv0dKZ7k6IHkzelyGFJuLwjypFBiT9CkM4fC5s2EMO/dVw4Se32yTQRkVhcNeU/Zn
         y071+UDldSDLljHHSZCkPlb4BWg9zO5aOfYeh4/LL6axHAV7L2sAEaUM73ZWGDEQRdWN
         l8m03gzoZP5q9lm3f/pUK5EwB+sAQ0levJocme28EcCChh/9ojRYTNt2BHkKAG1yoBx9
         g+S10XkFAEi9XhR5QmM1cp+wuLoOQAbUigC6LAIQwsK5yp9Ex8Jpk2F3Xmz2OlJF9nn+
         vofw==
X-Gm-Message-State: APjAAAX+ZJrZqEhNDdAqMff+dqVkJZlFU0eJ9ONK6flZFltdONhBc2er
        G/Xw8P9VaGYwd1iiO8dtyeg=
X-Google-Smtp-Source: APXvYqyooYWHFit0xGZITwo452W8QmbToLSLJElLvtLZMWgL5u434Pm2LqkehQSBCt1Hu1C2+n3xNg==
X-Received: by 2002:ae9:ee14:: with SMTP id i20mr10717529qkg.428.1562538935582;
        Sun, 07 Jul 2019 15:35:35 -0700 (PDT)
Received: from localhost.localdomain (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.gmail.com with ESMTPSA id p4sm6998453qkb.84.2019.07.07.15.35.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Jul 2019 15:35:35 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 15/24] PM / devfreq: tegra30: Fix integer overflow on CPU's freq max out
Date:   Mon,  8 Jul 2019 01:32:54 +0300
Message-Id: <20190707223303.6755-16-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190707223303.6755-1-digetx@gmail.com>
References: <20190707223303.6755-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There is another kHz-conversion bug in the code, resulting in integer
overflow. Although, this time the resulting value is 4294966296 and it's
close to ULONG_MAX, which is okay in this case.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 0de1efdaabf4..60ebf9c9cd86 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -172,7 +172,7 @@ struct tegra_actmon_emc_ratio {
 };
 
 static const struct tegra_actmon_emc_ratio actmon_emc_ratios[] = {
-	{ 1400000, ULONG_MAX },
+	{ 1400000, ULONG_MAX / KHZ },
 	{ 1200000,    750000 },
 	{ 1100000,    600000 },
 	{ 1000000,    500000 },
-- 
2.22.0

