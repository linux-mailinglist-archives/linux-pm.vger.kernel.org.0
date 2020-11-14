Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77B772B2B5D
	for <lists+linux-pm@lfdr.de>; Sat, 14 Nov 2020 05:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgKNE5u (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Nov 2020 23:57:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbgKNE5u (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Nov 2020 23:57:50 -0500
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5F9C0613D1;
        Fri, 13 Nov 2020 20:57:50 -0800 (PST)
Received: by mail-qv1-xf44.google.com with SMTP id d38so4755593qvc.3;
        Fri, 13 Nov 2020 20:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=VTHWI66K7/TxpFbAPjbyj/737uDp2NK8Kdd46nTsTA0=;
        b=eOlxawo3E9+dQg1yrxaiHWgwLtPgsEmsbzINWjoEeD3RYh3YDODmKfkn55hlj+7rn+
         WQRDR9ZqK/PZHKxPB0iQ/3Y5S9Gtu7TZNAmwxOU53ucllPpBaqVHH/Axzg90XfzG4ao9
         EhfJE+TBEacsLcOP0Ca3AWp6EZUc+fwSHSyegW43lSMFkSbRaGy+iV2dItr+bNE3t9IY
         mI3oaKYK/wphJKovaiTR+oX7G4CgRTtG7gBmBhkk8B90/HONPLn5Ob7g2/imbv1p2epx
         e5+afzpkeh3N6uZkrw8Ko9TdGUpko/r19aLyy6uR0Zvz1oOQAG2HXM9GJWXNLSgMN5cc
         HwTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=VTHWI66K7/TxpFbAPjbyj/737uDp2NK8Kdd46nTsTA0=;
        b=gom98zMMgE3ghFGYuoYu56pKPexFsc13tW2kgCK66NhF9r4G863EhTT8/Qc1D4Yc94
         iC7fXWg3g2+txCuZ2o4MMewO+r+uAKmO2SfyDRgANc2FzdF+ly7HLzpKchsnL0FF5t9P
         poYZ009XVxP3/Wt4lR8cRmSayAn32/jzHpHrQMmNFLQ96kwcRkA1lY63w7TNBxNOPtw4
         2JbAkskmG+DKSH6WpFCoAhsfdqDBByPtR4sFEgREo59rpWXoQytF6zLAI8a65prDYhnq
         uT8Lp8gstUrEFkWuXebvM8Zgh3+tgox5ejJoq/RRDf6zb5dnlmOelqnx+4SoHJaTFAey
         W8Vw==
X-Gm-Message-State: AOAM533HAVN42BxOYyPVIlVe1BHrBwtniBtR2s+0kpr48hndqTCOWRrq
        jladSNkMkc/43lggVh5TLq4=
X-Google-Smtp-Source: ABdhPJw10MCJbuObkjneubj1wttdmYvd8cwCmaulFDPKQFi3rIMeU06U1PeSUol0w+79eOYAbNH8KA==
X-Received: by 2002:ad4:4908:: with SMTP id bh8mr5995816qvb.58.1605329869522;
        Fri, 13 Nov 2020 20:57:49 -0800 (PST)
Received: from fedora-project ([195.181.168.216])
        by smtp.gmail.com with ESMTPSA id g123sm1309002qkd.135.2020.11.13.20.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 20:57:48 -0800 (PST)
Date:   Fri, 13 Nov 2020 23:57:47 -0500
From:   Nigel Christian <nigel.l.christian@gmail.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] power: supply: pm2301_charger: remove unnecessary variable
Message-ID: <20201114045747.GA4209@fedora-project>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The variable "ret" is initialized to zero and then returned.
Remove it and return zero.

Signed-off-by: Nigel Christian <nigel.l.christian@gmail.com>
---
 drivers/power/supply/pm2301_charger.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/power/supply/pm2301_charger.c b/drivers/power/supply/pm2301_charger.c
index 2df6a2459d1f..ac06ecf7fc9c 100644
--- a/drivers/power/supply/pm2301_charger.c
+++ b/drivers/power/supply/pm2301_charger.c
@@ -455,7 +455,6 @@ static int pm2_int_reg4(void *pm2_data, int val)
 static int pm2_int_reg5(void *pm2_data, int val)
 {
 	struct pm2xxx_charger *pm2 = pm2_data;
-	int ret = 0;
 
 	if (val & (PM2XXX_INT6_ITVPWR2DROP | PM2XXX_INT6_ITVPWR1DROP)) {
 		dev_dbg(pm2->dev, "VMPWR drop to VBAT level\n");
@@ -468,7 +467,7 @@ static int pm2_int_reg5(void *pm2_data, int val)
 		dev_dbg(pm2->dev, "Falling/Rising edge on WPWR1/2\n");
 	}
 
-	return ret;
+	return 0;
 }
 
 static irqreturn_t  pm2xxx_irq_int(int irq, void *data)
-- 
2.28.0

