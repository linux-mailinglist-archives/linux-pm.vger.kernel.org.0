Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61595E92B6
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2019 23:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725978AbfJ2WHO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Oct 2019 18:07:14 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41923 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728152AbfJ2WGW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Oct 2019 18:06:22 -0400
Received: by mail-lf1-f66.google.com with SMTP id j14so6772820lfb.8;
        Tue, 29 Oct 2019 15:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NjtBEPOF4XbVe+GmLN7lt3oHWVo/ez1Q/5iY5o1k9lo=;
        b=IBTo1jvkbjvGXpJRGG14Z58KiP+5J01AFzxhzNglk2gPwzqMKtnfB62PBri9ZPSmWQ
         21qCykXYRVA/BuneaGPskG/5QlCxluxLAn1Fw4XgMOLLu8acU9ZL3a4lmbMmNQD2FdqS
         KlZTjZecVeV4kfqc92WtohtDAMyOmH3DfUqlu++rz6JKLfKeDbtd0pWLnIaAsIhliSYo
         MFYESbwLllWNsaBPMfO8Nya+k89u3xFQ6j+7SdAoZ7tDh6fu9kNchHGQsLZyqj8vIgRf
         QJFrD5HjXddslQ2B3x/zDZUz7oCeOht2Mxc0AJyAvCVB9klwnC29L3CH7qSqu/nHg0Hc
         0fag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NjtBEPOF4XbVe+GmLN7lt3oHWVo/ez1Q/5iY5o1k9lo=;
        b=hJeqdafhafQV/nAPQVVhIFtjNV4Dz2/w7H4UOcoaeFPfsrv1j/eUJDUrLC89ZflwD0
         6HqEa26HgGqR++SJcCDNdeBP3pkNm5IAbGpMAsDBjJ2yF8UJ6BiHp3ODfowi57V7LsAO
         uERpn13GSNQXx4SwiVwvPy7cPU61Sh+DeKFN59nFVLbhJKHSfZgWnyWrbPHJ0XcgxQXM
         95CqiXfF/yaWzvIT364niWJHYx2YgtUdp/vIhdy7mB91SE7FUp4DhgS0k542Woff4QSY
         L5695PFOnjWQ7DPxRRcl0VWCVxKR12C2beecmvOWPKhWnWe01mTUzBPiNm1aAuUiMUTA
         vrwA==
X-Gm-Message-State: APjAAAXp5Yg61aZP+DrOM3icNae8NvAm4+5+ksUOZ0Ueanroc1Ir5F0P
        bbuKIn90P/Aj+2hYJWY+VfM=
X-Google-Smtp-Source: APXvYqwzGkr1pqdaiAoBOGPoFu0qbrG/moOR9RIjKczyiaaJln/Z1KWQ7j5j8RPdi+KR+RecKJXT5Q==
X-Received: by 2002:ac2:5442:: with SMTP id d2mr3834303lfn.161.1572386779255;
        Tue, 29 Oct 2019 15:06:19 -0700 (PDT)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id 12sm51536lje.92.2019.10.29.15.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 15:06:18 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 10/19] PM / devfreq: tegra30: Don't enable consecutive-down interrupt on startup
Date:   Wed, 30 Oct 2019 01:00:10 +0300
Message-Id: <20191029220019.26773-11-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191029220019.26773-1-digetx@gmail.com>
References: <20191029220019.26773-1-digetx@gmail.com>
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

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Tested-by: Peter Geis <pgwipeout@gmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index fb1163aaaae7..e9cb0ea54ee7 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -490,7 +490,6 @@ static void tegra_actmon_configure_device(struct tegra_devfreq *tegra,
 		<< ACTMON_DEV_CTRL_CONSECUTIVE_ABOVE_WMARK_NUM_SHIFT;
 	val |= ACTMON_DEV_CTRL_AVG_ABOVE_WMARK_EN;
 	val |= ACTMON_DEV_CTRL_AVG_BELOW_WMARK_EN;
-	val |= ACTMON_DEV_CTRL_CONSECUTIVE_BELOW_WMARK_EN;
 	val |= ACTMON_DEV_CTRL_CONSECUTIVE_ABOVE_WMARK_EN;
 	val |= ACTMON_DEV_CTRL_ENB;
 
-- 
2.23.0

