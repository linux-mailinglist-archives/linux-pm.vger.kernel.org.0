Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A398D7BDF1
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2019 12:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729092AbfGaKBL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 31 Jul 2019 06:01:11 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40093 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387645AbfGaKBD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 Jul 2019 06:01:03 -0400
Received: by mail-pf1-f195.google.com with SMTP id p184so31580005pfp.7
        for <linux-pm@vger.kernel.org>; Wed, 31 Jul 2019 03:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=hT++od96JIv4ERj/5q43A9sdV6GV4nXuETH/GErjU/I=;
        b=kIXAp4MzviR01IRWqe7+ak4T/tIj/IFNOIOhRvpjmPe4Iky3tFm/wfi5mHwn+pc5DK
         BQr4/V2CGVXy3LsdNBMhg93+PTiKMQhTlHIm5KoA1US4OPQS9jfABuFeaTh5gnT+r2aX
         nIoi4PywtlKhdVqSZOj3IKK1NvCelqy/7qMhasvUnDLoaz2EMKpUZIxxfyXFzAraP4Ox
         iKncbdTOLXT99eGgIOaUMIJJzvIoi2zdT+fSBRWqENUmT/UezZtf8dIF2BK3IICY2HN+
         D695VleypTnWA8Je1k4uXVgjgWZ8D8GJiwdlybFBgC7IWA4KSWK3FBUq7x1kMW9XG3xw
         eB2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=hT++od96JIv4ERj/5q43A9sdV6GV4nXuETH/GErjU/I=;
        b=Y7fJsu9Iwkjme8lEbSEPbQ27x6VDdodlzXIgqnGzaz1WykMD26AHwPahanTx5Kot5c
         h7+WrcGNUwTA3zwoM2kWM86W0+gGme37Zwlzp/w5pRe1I5oCQ3IQJWZ97KxqSLFFZJ8S
         n5ZZKFta6326tWwcDbmAWBVxn9EfIt9D/p+BaPjn+KXDTv6ydYv9GA9wv8XnV6uYYziT
         5rCN4JmGFVXO71okec/+0k0nk8hOpu0nmRfMlQ866tEpu41eSyJQSmWGPLq1R48q1Q5v
         aLyBsHvjkibVI+R0QwyWkBsSgIXZUSvylh+itRbFsCjgBq1ZxRFQMYMpIDfj3GuQSZ0D
         vAVQ==
X-Gm-Message-State: APjAAAW8gza1dv83CyREZxHeGqldbRmXDdMQXyg8iSgF/3sKvvkIBI0F
        +fWbIEr4UrveYHIC6RGbLHiCaA==
X-Google-Smtp-Source: APXvYqzXNx5w1M0CUiKp7nGMuwNt7ZCkwdDTEa9GNGjgnC2N3BvUWTewMA7HX54pOwDNkuJOSYLSgw==
X-Received: by 2002:aa7:8acb:: with SMTP id b11mr44975412pfd.109.1564567263283;
        Wed, 31 Jul 2019 03:01:03 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id m6sm68611352pfb.151.2019.07.31.03.01.00
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 31 Jul 2019 03:01:02 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     sre@kernel.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, yuanjiang.yu@unisoc.com,
        baolin.wang@linaro.org, vincent.guittot@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] power: supply: sc27xx: Make sure the alarm capacity is larger than 0
Date:   Wed, 31 Jul 2019 18:00:27 +0800
Message-Id: <5c3bb516c6020410a932c12eb2481fd75c34b7fe.1564566425.git.baolin.wang@linaro.org>
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

We must make sure the alarm capacity is larger than 0, to help to
calibrate the low battery capacity.

Signed-off-by: Yuanjiang Yu <yuanjiang.yu@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/power/supply/sc27xx_fuel_gauge.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/power/supply/sc27xx_fuel_gauge.c b/drivers/power/supply/sc27xx_fuel_gauge.c
index f670131..fa85f40 100644
--- a/drivers/power/supply/sc27xx_fuel_gauge.c
+++ b/drivers/power/supply/sc27xx_fuel_gauge.c
@@ -915,6 +915,8 @@ static int sc27xx_fgu_hw_init(struct sc27xx_fgu_data *data)
 	data->alarm_cap = power_supply_ocv2cap_simple(data->cap_table,
 						      data->table_len,
 						      data->min_volt);
+	if (!data->alarm_cap)
+		data->alarm_cap += 1;
 
 	power_supply_put_battery_info(data->battery, &info);
 
-- 
1.7.9.5

