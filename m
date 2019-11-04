Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 070D8EECE4
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2019 23:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388986AbfKDWBM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Nov 2019 17:01:12 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40497 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388971AbfKDWBL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Nov 2019 17:01:11 -0500
Received: by mail-lf1-f66.google.com with SMTP id f4so13449229lfk.7;
        Mon, 04 Nov 2019 14:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g9RKaIiF4lILXf0g5OU6lPR/hR2F0oEkesL+dfO7WO0=;
        b=kF91mmE5TuLuwd7+S7smRA9aWsyfAuon99V7V0nSBZXIr2Cv4ZwPTgi+3dhkQ/lJEH
         DJWhdFN4m0liQDYEhzPLLIIHJ42afCEd2M1YAr71X9mdv7zGlyJbnLnjBXySTx8lO3LV
         7wvZG5d7GReX2dv4KDCBSStkmro7YgYUYWqdvTVpGF4Mof4B9lxp+7exlkx4G37Ufplm
         7X7ey8oEyNjujp0eDQrROQNCWLUoSYTKHpkTlfdavllTbQK19GfkywaGj0J3df2bHt0y
         2S6wUsQ9rHgLDhZyjd91ds5tFzAphGv76yI6ZqBqwR7nm8d1TN05eIEwaiDUYN+5NFKr
         2TPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g9RKaIiF4lILXf0g5OU6lPR/hR2F0oEkesL+dfO7WO0=;
        b=bcc0M+jNZh57n11HvjPZ1ZZk21Am7Km0jemGijI6TEO7Qs9GS3AkoJYAFQG3di51P+
         ZxMXFzJYxlSI2Xhq2xkjFBmjy5yxTvicmWUV6RxGXlUScheC6BOLrTIk1wNS3EJ+cm5P
         Pum6FIONjzfQj29mk9tLV8e1UmXXQa8PLPVhyz+i52o0ZUDAYOeGkLIILmsMMNXi4P7u
         Ufw5wsZHepi+MkusDboZHKgexstTpQCskap77313eyGNeT+oBa8Wll4EsOk4ecs2hLH+
         BTtjaMxRmc695eq/uS3fOvVTLTL6RboN4bT1ZOnWpHP1Z0sPt21RqbFXNtanLlAkwP7Z
         df7Q==
X-Gm-Message-State: APjAAAUIcwHUBOLuoeAfTsomOrwr61jn1hcrzCFPtn7ndENN+yZtdW3y
        F8YuQbWTRa4KNxqR4vPnYFY=
X-Google-Smtp-Source: APXvYqxfGdHoTMAi8ly9Z3bdC4cKcK5I4Mau7VYctsO6RcexwC8hSJXox0rdAwLH02Aj50U5aL7udg==
X-Received: by 2002:a19:7511:: with SMTP id y17mr18721120lfe.19.1572904869080;
        Mon, 04 Nov 2019 14:01:09 -0800 (PST)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id g3sm7454669ljj.59.2019.11.04.14.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 14:01:08 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Peter Geis <pgwipeout@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 10/19] PM / devfreq: tegra30: Don't enable consecutive-down interrupt on startup
Date:   Tue,  5 Nov 2019 00:56:08 +0300
Message-Id: <20191104215617.25544-11-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104215617.25544-1-digetx@gmail.com>
References: <20191104215617.25544-1-digetx@gmail.com>
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
index 9cb2d6468175..bc46af155b99 100644
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

