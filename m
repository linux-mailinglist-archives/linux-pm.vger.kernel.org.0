Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3AEA6180E
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2019 00:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbfGGWgn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 Jul 2019 18:36:43 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34869 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728043AbfGGWfR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Jul 2019 18:35:17 -0400
Received: by mail-qt1-f196.google.com with SMTP id d23so16300732qto.2;
        Sun, 07 Jul 2019 15:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3N4+CnGw3uZRT26u6KujNlQMivpwesG5iBfNg5ReVc0=;
        b=Z0b8a1DzdUogow88YGmv2m1TPJjQNaorzeuy7WwmS22LKu/m3PfpMAomKInpcE+QEQ
         LhB/58nxQfosQ9c+4MyNfa9lafEDbgr14m50xhWXXvTWScmuSKN/7KafzNUo9lbrIMO6
         S5dd1JaTrDIF1R4kEIs0AahAuk7FnVX5Xm58CTZ+r+hZYwkaaRtmRSdRVpaUcOSJGkgK
         nE6aNAVifPm4gIuxyLVF8V9n3HFeRjfr+Sx2VcROsYSsuEGcaolVYF69bFodEJ6wjxmO
         QdCbfLNaixmwbfVbtbI/XsjD70faVs3fr4mN47HumePveyEkWEMfVf/OlpgYJcJvXv/z
         cxxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3N4+CnGw3uZRT26u6KujNlQMivpwesG5iBfNg5ReVc0=;
        b=m4jvC/Is+pET6m2YAT8qXT4rvrMCoBMhZgwz74xSjmFNH0VI5wC7hYCRrqKCjzmo0S
         1+xf/YlsDf2xpNHzCPa2ioJ3U4ePzhBhzK8wJ06XrzcbNHWi1WPjIMKLZmykI8wS5rm7
         ddG0UYufKHAie0UBNLIDnF6X0V7qz3BH3FCGq6EA+A0YICjN9a+AJn+3VG5OSA+MqK1V
         Mqgz3B3gxG0YNzurhp2IAwwUf2b9cu/FEFqOk0BxrsWu8uBjRtZQX+jMXbBVvePsoDlp
         z6v0y954JbiFPl5RgledRypPgtUDmxy4s0uPFrOXFsD/7QRgPtMlBxqW/6yVozq1udoX
         aUJQ==
X-Gm-Message-State: APjAAAVBPMEL0DQnJs1ARZAwiTXnxCvEmLIt0+5duArrHK9q73sEjiwY
        OH/5qS8VVpfBbf0lcWexBj0=
X-Google-Smtp-Source: APXvYqykxghm2VzyjKrVM/CfIz/Y5pXnpTCd96dFGiqreY2m7zas+kaWtCMp7cVjlOPkwqntZj3m8Q==
X-Received: by 2002:ac8:450e:: with SMTP id q14mr8746094qtn.132.1562538915896;
        Sun, 07 Jul 2019 15:35:15 -0700 (PDT)
Received: from localhost.localdomain (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.gmail.com with ESMTPSA id p4sm6998453qkb.84.2019.07.07.15.35.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Jul 2019 15:35:15 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 06/24] PM / devfreq: tegra30: Tune up boosting thresholds
Date:   Mon,  8 Jul 2019 01:32:45 +0300
Message-Id: <20190707223303.6755-7-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190707223303.6755-1-digetx@gmail.com>
References: <20190707223303.6755-1-digetx@gmail.com>
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

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 16f7e6cf3b99..2bf65409ddd8 100644
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

