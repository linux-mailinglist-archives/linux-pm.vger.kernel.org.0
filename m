Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 177E47BDE7
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2019 12:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387612AbfGaKAy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 31 Jul 2019 06:00:54 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41430 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387642AbfGaKAy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 Jul 2019 06:00:54 -0400
Received: by mail-pg1-f196.google.com with SMTP id x15so21371332pgg.8
        for <linux-pm@vger.kernel.org>; Wed, 31 Jul 2019 03:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=MmBOwwNeN+W1dC0nmIPZG6LtIHwgJLZWSo5QrSMSqcg=;
        b=F2cmNKe82FILmNf5yBHDnTc0fv/W9P8ElxWyX9nD9eNEddHhrjcVcMripReHGh+S0v
         tSNdYbOTYj5QQBmbdLKklAfAnbsGhNRFF8O/+LB3M71Jf26oCbFHGBxBwHSsBhGdqxyA
         +KxTVK8klRgp4/pNwu9f2ux4WWomzu+suJyXaCfOMITmKuJ2rNjMgyJNtefNtQk/6Ced
         +G4XQdEfuvog8fX/p/pcnavzvF0fv3pGjJxnKPAJzsT26oHgPzE1HZaAb08cu8XimFcy
         Ot89rgQl1jDKVtz6fQ/61d+80sPzURiNrw0u2ctVaFEOZ6aLQg8LP6zliTaQ5zR/CcnX
         jBig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=MmBOwwNeN+W1dC0nmIPZG6LtIHwgJLZWSo5QrSMSqcg=;
        b=WqKcL5OG6+cWfNmCVd1WitLyuPiSA9w99/ST8kPrdTBvcFaPtKvGutBhEJE0M9BlbI
         fl7QerxYHXnZtft+xvXeDqFo1pNrAzr6/9vuTyca5V+V2CXSC/iHUzJFmObUL+dGS1W7
         LkMvNYSh0xSMcISOPFKWOJJx6sbIun/CbpvDXxEBUQv5a0CuZhV/gk8D1BmXfDfbqacH
         PNM08RCe4Bur5aZWpFGPtU8D3LfYIzy8wPGhy+DJ3XDa5i2mAQDkLMgYrifEslNnQQ7B
         2AJEDAjT8hZK5o07WxIAVs3RqB6+eU36+0IY9Tg7mZt6aH5xRtV5QfzbVsE/tQtLxZhw
         xlYw==
X-Gm-Message-State: APjAAAV7Xf6ZctV0mPcQAzS/cj+7/Bg1cOZkUnJZaLeJpKEs4hFEHNNy
        08/vCs2aHqd2A/Exx06lm8VbkQ==
X-Google-Smtp-Source: APXvYqwtDG50+CDnx8yHTX0XWjamhJQ0wzyuOwxWwmAtlyxz5NNOSYgypMSGVytueAL/Ooa0yoUJyA==
X-Received: by 2002:a63:d555:: with SMTP id v21mr90143798pgi.179.1564567253116;
        Wed, 31 Jul 2019 03:00:53 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id m6sm68611352pfb.151.2019.07.31.03.00.50
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 31 Jul 2019 03:00:52 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     sre@kernel.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, yuanjiang.yu@unisoc.com,
        baolin.wang@linaro.org, vincent.guittot@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] power: supply: sc27xx: Add POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN attribute
Date:   Wed, 31 Jul 2019 18:00:23 +0800
Message-Id: <a48b8acd5111120e3effe71e05d5f8166470f725.1564566425.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1564566425.git.baolin.wang@linaro.org>
References: <cover.1564566425.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1564566425.git.baolin.wang@linaro.org>
References: <cover.1564566425.git.baolin.wang@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Yuanjiang Yu <yuanjiang.yu@unisoc.com>

Add POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN attribute to provide the battery's
design capacity for charger manager to calculate the charging counter.

Signed-off-by: Yuanjiang Yu <yuanjiang.yu@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/power/supply/sc27xx_fuel_gauge.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/power/supply/sc27xx_fuel_gauge.c b/drivers/power/supply/sc27xx_fuel_gauge.c
index 24895cc..2fe97ae 100644
--- a/drivers/power/supply/sc27xx_fuel_gauge.c
+++ b/drivers/power/supply/sc27xx_fuel_gauge.c
@@ -587,6 +587,10 @@ static int sc27xx_fgu_get_property(struct power_supply *psy,
 		val->intval = value * 1000;
 		break;
 
+	case POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN:
+		val->intval = data->total_cap * 1000;
+		break;
+
 	default:
 		ret = -EINVAL;
 		break;
@@ -644,6 +648,7 @@ static int sc27xx_fgu_property_is_writeable(struct power_supply *psy,
 	POWER_SUPPLY_PROP_CURRENT_NOW,
 	POWER_SUPPLY_PROP_CURRENT_AVG,
 	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
+	POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN,
 };
 
 static const struct power_supply_desc sc27xx_fgu_desc = {
-- 
1.7.9.5

