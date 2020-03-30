Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8E31971B8
	for <lists+linux-pm@lfdr.de>; Mon, 30 Mar 2020 03:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbgC3BJy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 29 Mar 2020 21:09:54 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35038 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728412AbgC3BJy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 29 Mar 2020 21:09:54 -0400
Received: by mail-lj1-f195.google.com with SMTP id k21so16333154ljh.2;
        Sun, 29 Mar 2020 18:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1McuIoe+/gchddRsq87TQMJQf8Rp7Vve2u5t5nrquN0=;
        b=b0LrrTZVzfHMBFktbu8bi6guGoeKKYPyscr7FgSWXG8u5NEJwgkgd6Oyd11o9AFkoa
         TJNRZTaOFIj+wksmETf023Gl95/UvNxOrZPZCgJo+CCS13hlTwQqZGgnR2p+FOX++w2G
         dlPcja6KqQNs3by9CFOpE6X3lZkbRcnKld/P5a6ZWBBWV3OSG+oLLBPDh+RmZTrhog6K
         JtlmkEgi4AluGfvdPtX1nbyxza05ITPOLChyv56T6E57hQxG8I6s/vVAcSIczOUFs3t2
         ds7aaFehKmS0wFvsksjfmvjKUKyr15eDGViJUhI2IqTH9tjYelqKLRspXLkgj6WD4qen
         XmiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1McuIoe+/gchddRsq87TQMJQf8Rp7Vve2u5t5nrquN0=;
        b=pWHg+RXzoyzyTwPyPLRC5bP6xsZxuaLWJy7znzEzJig4zOl1yBa2tLv3SKH0BlQehG
         DShywsLWIZ3XXreOokK7CgVIj7mD9OPnEtwY7jfjbZIrNyhW39zESWuS+AkGT8m1kzSq
         CSYCiQul/k8F41lmOCHMejQQ1T+KRLzdrzyAkwFjKcNV23YVBfCsorseeiPSkgjm5NwA
         eilT/vKwneCNu3/jdNiTSdx4dUjCn3cJfBN/O3GqVe9cwx62syzBf9jQV1FAwTEXxKm/
         hJNDsQvb3wA5SHvlmAOfAbOVcIHId11oEyoaEQ/O/K2qTa3hBNa+dt5PcYvcekcm8OuB
         yj9Q==
X-Gm-Message-State: AGi0PubziOBjNAP7iyeQbMTL6Hks9lwUyEP4GQJ6XndODIaJ9a5HZvjP
        BL54cCQwaR9Ae938wi9rYes=
X-Google-Smtp-Source: APiQypIdK6kO0xOLWty28oV/L6mJHCpdn490Kvca3eAPIUp5XW8mOja7127egPyznp9kVIoEwMooqQ==
X-Received: by 2002:a2e:b04d:: with SMTP id d13mr5775623ljl.278.1585530589939;
        Sun, 29 Mar 2020 18:09:49 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.gmail.com with ESMTPSA id f23sm2449005lja.60.2020.03.29.18.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 18:09:49 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 15/22] memory: tegra20-emc: Create tegra20-devfreq device
Date:   Mon, 30 Mar 2020 04:08:57 +0300
Message-Id: <20200330010904.27643-16-digetx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200330010904.27643-1-digetx@gmail.com>
References: <20200330010904.27643-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The tegra20-devfreq driver provides memory frequency scaling functionality
and it uses EMC clock for the scaling. Since tegra20-devfreq is a software
driver, the device for the driver needs to be created manually. Let's do
it from EMC driver since it provides the clk rate-change functionality.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/tegra20-emc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/memory/tegra/tegra20-emc.c b/drivers/memory/tegra/tegra20-emc.c
index a2fcff221659..867cd518b32e 100644
--- a/drivers/memory/tegra/tegra20-emc.c
+++ b/drivers/memory/tegra/tegra20-emc.c
@@ -838,6 +838,9 @@ static int tegra_emc_probe(struct platform_device *pdev)
 				err);
 	}
 
+	if (IS_ENABLED(CONFIG_ARM_TEGRA20_DEVFREQ))
+		platform_device_register_simple("tegra20-devfreq", -1, NULL, 0);
+
 	return 0;
 
 unset_cb:
-- 
2.25.1

