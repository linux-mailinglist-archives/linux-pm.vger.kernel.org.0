Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFF73D4FB
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2019 20:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406806AbfFKSFu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Jun 2019 14:05:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:51534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406751AbfFKSFu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 11 Jun 2019 14:05:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D8FF20874;
        Tue, 11 Jun 2019 18:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560276349;
        bh=pUQrrrTa5WLl5Wa6xrkyfgXRj0jTEMVmm2ENa77fXlc=;
        h=Date:From:To:Cc:Subject:From;
        b=QKVcW6wqE84DdHUQo3qpUtrgp9MmHCbzMN06jLmT+LAXNrXlCdM+aJ/bF1zROAz0A
         942jP4y1tzj0XefryYanlDWNeQXkkEdqxx+0QWTOrpY9eceKQGDfcrCGGYM4w5cGwM
         k2hUHzCej/95tpWuTPgcLn/1CbD5rpryzdToCT+8=
Date:   Tue, 11 Jun 2019 20:05:47 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kevin Hilman <khilman@kernel.org>, Nishanth Menon <nm@ti.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH] power: avs: smartreflex: no need to check return value of
 debugfs_create functions
Message-ID: <20190611180547.GA13520@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

And even when not checking the return value, no need to cast away the
call to (void), as these functions were never a "must check" type of a
function, so remove that odd cast.

Cc: Kevin Hilman <khilman@kernel.org>
Cc: Nishanth Menon <nm@ti.com>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/power/avs/smartreflex.c | 41 +++++++++------------------------
 1 file changed, 11 insertions(+), 30 deletions(-)

diff --git a/drivers/power/avs/smartreflex.c b/drivers/power/avs/smartreflex.c
index c96c01e09740..4684e7df833a 100644
--- a/drivers/power/avs/smartreflex.c
+++ b/drivers/power/avs/smartreflex.c
@@ -899,38 +899,19 @@ static int omap_sr_probe(struct platform_device *pdev)
 	}
 
 	dev_info(&pdev->dev, "%s: SmartReflex driver initialized\n", __func__);
-	if (!sr_dbg_dir) {
+	if (!sr_dbg_dir)
 		sr_dbg_dir = debugfs_create_dir("smartreflex", NULL);
-		if (IS_ERR_OR_NULL(sr_dbg_dir)) {
-			ret = PTR_ERR(sr_dbg_dir);
-			pr_err("%s:sr debugfs dir creation failed(%d)\n",
-			       __func__, ret);
-			goto err_list_del;
-		}
-	}
 
 	sr_info->dbg_dir = debugfs_create_dir(sr_info->name, sr_dbg_dir);
-	if (IS_ERR_OR_NULL(sr_info->dbg_dir)) {
-		dev_err(&pdev->dev, "%s: Unable to create debugfs directory\n",
-			__func__);
-		ret = PTR_ERR(sr_info->dbg_dir);
-		goto err_debugfs;
-	}
 
-	(void) debugfs_create_file("autocomp", S_IRUGO | S_IWUSR,
-			sr_info->dbg_dir, (void *)sr_info, &pm_sr_fops);
-	(void) debugfs_create_x32("errweight", S_IRUGO, sr_info->dbg_dir,
-			&sr_info->err_weight);
-	(void) debugfs_create_x32("errmaxlimit", S_IRUGO, sr_info->dbg_dir,
-			&sr_info->err_maxlimit);
+	debugfs_create_file("autocomp", S_IRUGO | S_IWUSR, sr_info->dbg_dir,
+			    (void *)sr_info, &pm_sr_fops);
+	debugfs_create_x32("errweight", S_IRUGO, sr_info->dbg_dir,
+			   &sr_info->err_weight);
+	debugfs_create_x32("errmaxlimit", S_IRUGO, sr_info->dbg_dir,
+			   &sr_info->err_maxlimit);
 
 	nvalue_dir = debugfs_create_dir("nvalue", sr_info->dbg_dir);
-	if (IS_ERR_OR_NULL(nvalue_dir)) {
-		dev_err(&pdev->dev, "%s: Unable to create debugfs directory for n-values\n",
-			__func__);
-		ret = PTR_ERR(nvalue_dir);
-		goto err_debugfs;
-	}
 
 	if (sr_info->nvalue_count == 0 || !sr_info->nvalue_table) {
 		dev_warn(&pdev->dev, "%s: %s: No Voltage table for the corresponding vdd. Cannot create debugfs entries for n-values\n",
@@ -945,12 +926,12 @@ static int omap_sr_probe(struct platform_device *pdev)
 
 		snprintf(name, sizeof(name), "volt_%lu",
 				sr_info->nvalue_table[i].volt_nominal);
-		(void) debugfs_create_x32(name, S_IRUGO | S_IWUSR, nvalue_dir,
-				&(sr_info->nvalue_table[i].nvalue));
+		debugfs_create_x32(name, S_IRUGO | S_IWUSR, nvalue_dir,
+				   &(sr_info->nvalue_table[i].nvalue));
 		snprintf(name, sizeof(name), "errminlimit_%lu",
 			 sr_info->nvalue_table[i].volt_nominal);
-		(void) debugfs_create_x32(name, S_IRUGO | S_IWUSR, nvalue_dir,
-				&(sr_info->nvalue_table[i].errminlimit));
+		debugfs_create_x32(name, S_IRUGO | S_IWUSR, nvalue_dir,
+				   &(sr_info->nvalue_table[i].errminlimit));
 
 	}
 
-- 
2.22.0

