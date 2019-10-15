Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5F1D7AEC
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2019 18:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387412AbfJOQNv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Oct 2019 12:13:51 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40619 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbfJOQNv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Oct 2019 12:13:51 -0400
Received: by mail-pf1-f193.google.com with SMTP id x127so12779855pfb.7;
        Tue, 15 Oct 2019 09:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=QMLeDmrBfu8L9JXe6ClGJAZaALXBboTs7aJjY2tzHE8=;
        b=SZiPdzHa3MKUnPhz8+AUs7ksEAv4jGGFTSHj1J7sdp7fn8o587GY9JMSqDNB9I0wpa
         6nFDwv+SEIV3HpAALiOnWmtYfNgbT/VCTkiVFOe+1HHcjL9OqdG5wyXfU+rpt3OdyWUr
         lvTMD4IHjEH8vTYqj17z5E9x4aFu4KbDQ78IN2zmwO4ovRzniH56z/arbWdUh3fThTAu
         arNQY0lMGzGiC6IXnua6296aHfVGbOnSOwUbBRHm4cLd6jMBCSp/sqp1GvEOIOl8Uazo
         +vdGacAktDgHcKxYpJetg4s/shhZJLxG5yw/GjqzQOVbJY5JjLGT4XMp2mO1kWNzWJgF
         jo+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QMLeDmrBfu8L9JXe6ClGJAZaALXBboTs7aJjY2tzHE8=;
        b=aLqAkBdkAdH1W08/cd7Lvo/Ia75NqzYBBfa4CVh2KEthgmL77kZc8TkZYR3ra6Vpc/
         IuUxukHspbm09Aci3DUIutJXwXdMYeI/cfziX3EBytKBRPeRiah8O+BdXbrEAsoZkfbI
         Ad0E5b/EjgC626/ZHUhDDIesymZ25TQpLtvz0T4RoidviKlXmbIISVLJIAOzLsAJ9DTg
         9whAR2xVssgt1AmBCbILX9S/jjgqt0o6k0GJUiU4ObBCiuA/h76pW3/mOTqrJ4XlQwIK
         0AnOfY2qI75MYa8g1moxbGjpOJOq4RRowIsvymF373Yp4l1N2SoxmlzAU0x0ipn16Avv
         tMOg==
X-Gm-Message-State: APjAAAUwhluO4Phoj3Me5hxNQTdaQGmpG6xdCFvO9Scrg1b7/gi1ASRh
        HDrWr+d9AWQtOuXn4aCGXIA=
X-Google-Smtp-Source: APXvYqx0jr5OJ/tnFIQb/PMk2gKB/BvNcnTF8qf1O/Y0SSoqKsaJzH1hreY1ig6kz9DW7w6+By27vQ==
X-Received: by 2002:a17:90a:a891:: with SMTP id h17mr44330994pjq.32.1571156030704;
        Tue, 15 Oct 2019 09:13:50 -0700 (PDT)
Received: from madhuparna-HP-Notebook.nitk.ac.in ([2402:3a80:537:9e2a:d73:bfaf:e15e:cd77])
        by smtp.gmail.com with ESMTPSA id e4sm19548753pff.22.2019.10.15.09.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 09:13:49 -0700 (PDT)
From:   madhuparnabhowmik04@gmail.com
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
Subject: [PATCH] Power: supply: abx500_chargalg.c: Fixed a code indentation error
Date:   Tue, 15 Oct 2019 21:43:41 +0530
Message-Id: <20191015161341.26868-1-madhuparnabhowmik04@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>

Fixed Code indentation error caused due to using spaces
instead of tabs.
The error reported by checkpatch.pl is:
 ERROR: code indent should use tabs where possible
The warning reported by checkpatch.pl is:
 WARNING: please, no spaces at the start of a line

Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
---
 drivers/power/supply/abx500_chargalg.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/abx500_chargalg.c b/drivers/power/supply/abx500_chargalg.c
index 23757fb10479..e6e37d4f20e4 100644
--- a/drivers/power/supply/abx500_chargalg.c
+++ b/drivers/power/supply/abx500_chargalg.c
@@ -354,13 +354,13 @@ static int abx500_chargalg_check_charger_enable(struct abx500_chargalg *di)
 
 	if (di->chg_info.charger_type & USB_CHG) {
 		return di->usb_chg->ops.check_enable(di->usb_chg,
-                         di->bm->bat_type[di->bm->batt_id].normal_vol_lvl,
-                         di->bm->bat_type[di->bm->batt_id].normal_cur_lvl);
+			di->bm->bat_type[di->bm->batt_id].normal_vol_lvl,
+			di->bm->bat_type[di->bm->batt_id].normal_cur_lvl);
 	} else if ((di->chg_info.charger_type & AC_CHG) &&
 		   !(di->ac_chg->external)) {
 		return di->ac_chg->ops.check_enable(di->ac_chg,
-                         di->bm->bat_type[di->bm->batt_id].normal_vol_lvl,
-                         di->bm->bat_type[di->bm->batt_id].normal_cur_lvl);
+			di->bm->bat_type[di->bm->batt_id].normal_vol_lvl,
+			di->bm->bat_type[di->bm->batt_id].normal_cur_lvl);
 	}
 	return 0;
 }
-- 
2.17.1

