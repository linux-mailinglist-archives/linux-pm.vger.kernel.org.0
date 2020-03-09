Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0C3A17DA86
	for <lists+linux-pm@lfdr.de>; Mon,  9 Mar 2020 09:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgCIITJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Mar 2020 04:19:09 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:55154 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgCIITJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Mar 2020 04:19:09 -0400
Received: by mail-pj1-f68.google.com with SMTP id np16so4035990pjb.4;
        Mon, 09 Mar 2020 01:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=0dwzfZBdNlOZMuJhJ5m0U1KGetNN67/bhUzuOF6YkZk=;
        b=GWFO1xvXViZGSxx6IuIEj+83xa59xbFeYUTUPtEHlRzAfU1UOsdwdT36XBZpifD1Ek
         uRA7Pu4Q7O7JQk8rg0Gfv2dtrJJfI9QGZHBVa23IeE24HZbestU81oNR8PDB32/XUpxV
         AHp+8QlixL3ZNiiVGTDngidzn3OupWGCCm2KxTlTJMB3MA8Hhc7W1McqxaRaBJCCPQhb
         2C8e1tHhcQ1IWZi7MeCdhCvDpoWuposU7gDauj9lf7F3QvJTuo8TaGAqPgF+Aeflv69m
         O5QHU0TfnyN7GOM4v8Q2bLz7SU2Ib6IsQoM+mkGTodq93blD9E6s7CbZWPpAO5Ngiqgb
         Q2hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=0dwzfZBdNlOZMuJhJ5m0U1KGetNN67/bhUzuOF6YkZk=;
        b=S79e7G35jCZdxoV4vjMVm7kUdp1w7DdB4Fa01wj9VxvkT0kk+puop6jEbt4muX5+P3
         lGeKJg1DBv+mL7szpyAveFUfj2HY8uZgMC2S5+fBR28B0xfgQXa8oSU3N7pAVDKnNWoz
         PWTjXN8rIusZJNy/hn7kyXFSWb5ps/JaTpZXUD1wJEm5jOThzKhtaASDSgwQADcR2Xj0
         8l1Hd6412o4uNuglbfjjS2iVabwr0qOWT9P+1BilTcnK6KT4FeVz3lvfLfL1JFwl8cLP
         lbD2c72qkIPxRPWEOF5NslnuwHi3V8l6JP8lBxNYEbUD19LhHqJ2nGP2lFVVhI7fy8TU
         49hA==
X-Gm-Message-State: ANhLgQ0q2AwMYSZUed2aHuPU2LVpFDZ0GjAPUiZFDEUCvtXbj8eQanKV
        1ozMz1ruc1zyKddkNQu87uQ=
X-Google-Smtp-Source: ADFU+vuoXTBMNKKmBuHT08cyyk8tD50wxzgrbD0pn0R1YewfUM/GY4EexBDxX8A+R5gg6rHwNlGIEA==
X-Received: by 2002:a17:90a:a786:: with SMTP id f6mr1883293pjq.169.1583741947919;
        Mon, 09 Mar 2020 01:19:07 -0700 (PDT)
Received: from sh03840pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id 193sm21862277pfu.181.2020.03.09.01.19.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Mar 2020 01:19:07 -0700 (PDT)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     sre@kernel.org
Cc:     baolin.wang7@gmail.com, orsonzhai@gmail.com, zhang.lyra@gmail.com,
        kernel-team@android.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] power: reset: sc27xx: Power off the external subsystems' connection
Date:   Mon,  9 Mar 2020 16:18:44 +0800
Message-Id: <eae00dced755376239401b18b38e4553200dc517.1583740881.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1583740881.git.baolin.wang7@gmail.com>
References: <cover.1583740881.git.baolin.wang7@gmail.com>
In-Reply-To: <cover.1583740881.git.baolin.wang7@gmail.com>
References: <cover.1583740881.git.baolin.wang7@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Sherry Zong <sherry.zong@unisoc.com>

When powering off the whole system, we should power off some external
subsystems' connection firstly, otherwise some external subsystems
will hold some power and result in powering down abnormally.

Signed-off-by: Sherry Zong <sherry.zong@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
 drivers/power/reset/sc27xx-poweroff.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/power/reset/sc27xx-poweroff.c b/drivers/power/reset/sc27xx-poweroff.c
index 29fb08b..2bedd4c 100644
--- a/drivers/power/reset/sc27xx-poweroff.c
+++ b/drivers/power/reset/sc27xx-poweroff.c
@@ -13,6 +13,8 @@
 
 #define SC27XX_PWR_PD_HW	0xc2c
 #define SC27XX_PWR_OFF_EN	BIT(0)
+#define SC27XX_SLP_CTRL		0xdf0
+#define SC27XX_LDO_XTL_EN	BIT(3)
 
 static struct regmap *regmap;
 
@@ -40,6 +42,9 @@ static void sc27xx_poweroff_shutdown(void)
 
 static void sc27xx_poweroff_do_poweroff(void)
 {
+	/* Disable the external subsys connection's power firstly */
+	regmap_write(regmap, SC27XX_SLP_CTRL, SC27XX_LDO_XTL_EN);
+
 	regmap_write(regmap, SC27XX_PWR_PD_HW, SC27XX_PWR_OFF_EN);
 }
 
-- 
1.9.1

