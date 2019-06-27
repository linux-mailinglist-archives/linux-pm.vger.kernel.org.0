Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C780358CC2
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2019 23:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfF0VMg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Jun 2019 17:12:36 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35711 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726696AbfF0VMg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Jun 2019 17:12:36 -0400
Received: by mail-lf1-f65.google.com with SMTP id a25so2539303lfg.2;
        Thu, 27 Jun 2019 14:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gPGZMg3THPRwEyEU9V0LFA6+Mg8FLrRJcaRFxlEddPc=;
        b=AbcIlFLxF83sgdsecFJfq5OrfnFOfuUZjYQVtN6cdpcIKPOLrlvfQxZ3tTttFRy3v4
         d/iiy+nq7Y757DcUHytUOn0owQ9Z5j4dla1NBjbVsGHOoygeQSdknSXvGALf6pIIrGh9
         wTV8M9nOqYssdgOtWcR3RehHp/YdvoDsBLUQVWE/jNB7XVccX+u1qsYCmr9YuH0meuty
         a+Nl7yJ+gwZ+d97OtOBfCYKALsOOhs5QyhWC0kCUDqf0VFu6lmXEQzkEViAI62IBr0GX
         s2jqkUoHar9w/bPHTGjjyfPb2PqKiaQcZjihObvJp6aPUY6Lvui+Tr0lJjkOun846oz9
         gd+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gPGZMg3THPRwEyEU9V0LFA6+Mg8FLrRJcaRFxlEddPc=;
        b=Y8ypl4dgWPB88sNFI++LaLQO+c/cbbN0QKJMw0IRv/UkFQ33+VhmVL70MnwNkBU6l5
         zUdKPJxtTPr9v7FaXGRedQgvOvSUsqQWjLdf96918QpnkLb5MpaIEbWLdbj3hYPFHekr
         EPldqjWDUBe0yFKuGkMRFhbeWpSdTkhTCzyDSPIMt3NypwHv0bIAtbO9k1n99gNN+i20
         kJtghcOUzfvjA7qoQBYbjSVIURswpD7hdB4Rph0aOZ/ONTTgcooUgB/f6kmiASKvYA0m
         JHJ1svnt4bRkS2+4P9i5kecovhGpX3g9XLMIXQWn+NClQ8j16BUSbWtyP3l+D/u1T5zL
         +/bA==
X-Gm-Message-State: APjAAAW7uDNsh20HHduCQ0HVenrvbilQL35gnnTNaDimt8JFs5PbGVwj
        J0doLbIQ940CtmwU97VWm7Q=
X-Google-Smtp-Source: APXvYqyENrPadNnLAdInbiVF8JxIReLWwYRI7wvhvdNEfCQ1QgaLzr1TOieaPCloTfSnY0iGoOBpFg==
X-Received: by 2002:ac2:5609:: with SMTP id v9mr3022478lfd.27.1561669953780;
        Thu, 27 Jun 2019 14:12:33 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id p29sm30485ljp.87.2019.06.27.14.12.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 14:12:33 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 10/22] PM / devfreq: tegra30: Don't enable consecutive-down interrupt on startup
Date:   Fri, 28 Jun 2019 00:11:03 +0300
Message-Id: <20190627211115.21138-11-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190627211115.21138-1-digetx@gmail.com>
References: <20190627211115.21138-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The consecutive-down event tells that we should perform frequency
de-boosting, but boosting is in a reset state on start and hence the
event won't do anything useful for us and it will be just a dummy
interrupt request.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index cca2fc15bafe..65f0363dbf1b 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -557,7 +557,6 @@ static void tegra_actmon_configure_device(struct tegra_devfreq *tegra,
 		<< ACTMON_DEV_CTRL_CONSECUTIVE_ABOVE_WMARK_NUM_SHIFT;
 	val |= ACTMON_DEV_CTRL_AVG_ABOVE_WMARK_EN;
 	val |= ACTMON_DEV_CTRL_AVG_BELOW_WMARK_EN;
-	val |= ACTMON_DEV_CTRL_CONSECUTIVE_BELOW_WMARK_EN;
 	val |= ACTMON_DEV_CTRL_CONSECUTIVE_ABOVE_WMARK_EN;
 	val |= ACTMON_DEV_CTRL_ENB;
 
-- 
2.22.0

