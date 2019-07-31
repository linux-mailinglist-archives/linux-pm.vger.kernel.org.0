Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02C207BDE9
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2019 12:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387675AbfGaKA5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 31 Jul 2019 06:00:57 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37968 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387644AbfGaKA4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 Jul 2019 06:00:56 -0400
Received: by mail-pl1-f194.google.com with SMTP id az7so30245622plb.5
        for <linux-pm@vger.kernel.org>; Wed, 31 Jul 2019 03:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=i+zcdOKM4uEsoBGbIg99q0zdIYp2a4lDHZin2ZyV6Ts=;
        b=H77GUufatg+2unukyfaUu5mIxtf9dK45weuozY3ifgIb2dgL2u+aeUCplrl82Pq2sP
         b2RX+7J/p/p2zmCozRuWIf8QArtB5MJKTKSI2W5+wf5MGGRL9fquoTMXWRZQeETW5oNG
         9AyOc2po9ajcww/AZ4Gk49nuuQezsh8pG3bp8pmqo6iV+urV4s2bkTAOF5lSjIztR9Cu
         qZOES5sOtvdtqd4j4eaANh/hLCDVHh9kULIB9iwNmy8npgfW4MWuOq18H202bivWBtxy
         ONuRYh2HtoahAfiLP7XBvyHSsMKGMpLWD+kd5UMYrtfkNLBu6fIixasyARHKZFxhCrrX
         zrUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=i+zcdOKM4uEsoBGbIg99q0zdIYp2a4lDHZin2ZyV6Ts=;
        b=R3+/7DZBjAc2CCeWf3iNx0xCSAbBcAJ7NMjpqVxz3XhIS0O24SBz8EAY+OFnsOV0RJ
         HPniSJzabBjoK/8qInR70LlWeNXNA4FxJ1fh0AIrdzXPZcZi3IgGB9Y/vZMmFbsfchZy
         dl52i0boCRzzpkfbEaDXBnNIAVskVDaO3Vshv3zROS3wPWou+3f+DcmwBUrvU80T6XP9
         dBDnCiAAnYCyYr96tMrywdcrhZk7UsNGVsM6GNuclDMQ/CVWZJg6LDAcOXb1qrrUjgCb
         X4x6lAfFhsAOZfomnwN1pbgf6gPpW9zDDpRTSB7jfnI8qxK6vVl0MoYUvf5LqZ7wFc2j
         G7Lw==
X-Gm-Message-State: APjAAAUtckK+wFi6qOZdrD7JIxwsGOZI+Yi0qT3+x2Nidv8koFDfA28s
        BQOg398ZzEwTPsGYxOCA1BWvoQ==
X-Google-Smtp-Source: APXvYqz0L0q/H6Aaq2C1hNAQC/UTqvaSD7TJO7dRD0vFgnlVqXzm0SKiN+S5lJQxC+3inAVkr70i1g==
X-Received: by 2002:a17:902:4401:: with SMTP id k1mr96016005pld.193.1564567255904;
        Wed, 31 Jul 2019 03:00:55 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id m6sm68611352pfb.151.2019.07.31.03.00.53
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 31 Jul 2019 03:00:55 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     sre@kernel.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, yuanjiang.yu@unisoc.com,
        baolin.wang@linaro.org, vincent.guittot@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] power: supply: sc27xx: Fix conditon to enable the FGU interrupt
Date:   Wed, 31 Jul 2019 18:00:24 +0800
Message-Id: <84abc5a002dcc29e51bf6525aee0ca2aace8e30a.1564566425.git.baolin.wang@linaro.org>
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

We should allow to enable FGU interrupt to adjust the battery capacity,
when charging status is POWER_SUPPLY_STATUS_DISCHARGING.

Signed-off-by: Yuanjiang Yu <yuanjiang.yu@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/power/supply/sc27xx_fuel_gauge.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/sc27xx_fuel_gauge.c b/drivers/power/supply/sc27xx_fuel_gauge.c
index 2fe97ae..ca7b73e 100644
--- a/drivers/power/supply/sc27xx_fuel_gauge.c
+++ b/drivers/power/supply/sc27xx_fuel_gauge.c
@@ -1098,7 +1098,8 @@ static int sc27xx_fgu_suspend(struct device *dev)
 	 * If we are charging, then no need to enable the FGU interrupts to
 	 * adjust the battery capacity.
 	 */
-	if (status != POWER_SUPPLY_STATUS_NOT_CHARGING)
+	if (status != POWER_SUPPLY_STATUS_NOT_CHARGING &&
+	    status != POWER_SUPPLY_STATUS_DISCHARGING)
 		return 0;
 
 	ret = regmap_update_bits(data->regmap, data->base + SC27XX_FGU_INT_EN,
-- 
1.7.9.5

