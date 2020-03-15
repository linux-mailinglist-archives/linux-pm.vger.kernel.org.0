Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5910C185DEA
	for <lists+linux-pm@lfdr.de>; Sun, 15 Mar 2020 16:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728796AbgCOPOx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 15 Mar 2020 11:14:53 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40651 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728789AbgCOPOx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 15 Mar 2020 11:14:53 -0400
Received: by mail-wm1-f67.google.com with SMTP id z12so6081763wmf.5;
        Sun, 15 Mar 2020 08:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YohDd/F61lZ9cpzSoLOwuZMoRWWt6P3Yq9P3ddNnkbo=;
        b=XiJtWJVXYzhft5hDCOjhW/SzT2EOuK4lmRfZet718rPEO3v0tNPBa4rxcc6pUa1Zzj
         ykbYktbuy78pbILvJ27jfnTjxXNIijF22xzNmZU0rVB+EE9b+v0ovURXkZtIMLseI2RF
         CBiZ+OGLADQLVsUfKW+MVbazd7AZue0hrS60MnBTM6hdRpNHUHe1x8iQH8i9ODvcXKC+
         FTmx2VHuilVu/bITGxxj5AFXb4HlRwepTQjOZra0YeJa5V2Q/m3ELW9idoyy65z9B4BB
         Dcf5d/z/4UrRuP65CsAjKO6G8j1n3GkGoc42wtLeA2ld9+luGXZVvEZVTmIKVO9z0znC
         coww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YohDd/F61lZ9cpzSoLOwuZMoRWWt6P3Yq9P3ddNnkbo=;
        b=a62PavIFqGl4G/sh89hqXpQ3+PL8SUe90Z7Y2wz0i7VXRM3bYzrHSGr++jo7tsHtDZ
         zGIwQMKhYjncfJgaYJQN0OkPU3tyiS70II1ZE591cryI0ZBqDwS1WmLp1K57G/wzMOgY
         mMrCaY6AIVPME7cw9nDU6M6+oChVPZ0kYEdQdgLDw+2YMlkgfdDPqXwDtudG5EC+IUx/
         i7BsW7qj27Gxgz8FglDwijX8bkLI90wTryxeKy1Vmc+BbSz/51kBjKAo6FutafDd0KqJ
         KYS+pFfHXl0CJUqDCTNe01iHfIPiMyh7ioFxMbqIDpnC/puKFFiznDck25zrRjOpjgNW
         l8wA==
X-Gm-Message-State: ANhLgQ32NhTxm4T7zWSEMjC4PhOLuTVjPd0g99D07Ts9oksRqpQjIcp7
        zCJ8Smo5dmaxZWJwKP1XBIc=
X-Google-Smtp-Source: ADFU+vtyBVa7ztI9TPGIZx3lv0hyXvP/N0b9ZzvgYmJ+acAwYmOdf+X/RTUOT+/RfO2qUx/Ty67hXg==
X-Received: by 2002:a1c:2b44:: with SMTP id r65mr21901486wmr.72.1584285290262;
        Sun, 15 Mar 2020 08:14:50 -0700 (PDT)
Received: from supervisor.net28 ([46.53.248.79])
        by smtp.gmail.com with ESMTPSA id i67sm67746869wri.50.2020.03.15.08.14.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Mar 2020 08:14:49 -0700 (PDT)
From:   Arthur Demchenkov <spinal.by@gmail.com>
To:     Tony Lindgren <tony@atomide.com>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Pavel Machek <pavel@ucw.cz>, sre@kernel.org,
        linux-pm@vger.kernel.org, linux-omap@vger.kernel.org
Cc:     Arthur Demchenkov <spinal.by@gmail.com>
Subject: [PATCH 15/15] power: supply: cpcap-battery: Add rounding to capacity reporting
Date:   Sun, 15 Mar 2020 18:12:06 +0300
Message-Id: <20200315151206.30909-15-spinal.by@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200315151206.30909-1-spinal.by@gmail.com>
References: <20200315151206.30909-1-spinal.by@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add rounding to capacity reporting.

Signed-off-by: Arthur Demchenkov <spinal.by@gmail.com>
---
 drivers/power/supply/cpcap-battery.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/cpcap-battery.c
index 4e872bd36ccf..b16848cfb58c 100644
--- a/drivers/power/supply/cpcap-battery.c
+++ b/drivers/power/supply/cpcap-battery.c
@@ -627,7 +627,9 @@ static int cpcap_battery_get_property(struct power_supply *psy,
 		empty = cpcap_battery_get_empty(ddata);
 		if (!empty->voltage || !ddata->charge_full)
 			return -ENODATA;
-		val->intval = empty->counter_uah - latest->counter_uah;
+		/* (ddata->charge_full / 200) is needed for rounding */
+		val->intval = empty->counter_uah - latest->counter_uah +
+			ddata->charge_full / 200;
 		val->intval = clamp(val->intval, 0, ddata->charge_full);
 		val->intval = val->intval * 100 / ddata->charge_full;
 		break;
-- 
2.11.0

