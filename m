Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9B0C8D62
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2019 17:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728736AbfJBPul (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Oct 2019 11:50:41 -0400
Received: from mx6.ucr.edu ([138.23.62.71]:6401 "EHLO mx6.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726063AbfJBPul (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 2 Oct 2019 11:50:41 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Wed, 02 Oct 2019 11:50:40 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1570031441; x=1601567441;
  h=from:to:cc:subject:date:message-id;
  bh=Z+EVLw9fpQeyY0pHsne85bY8IJwYorDnDkYoPc67XmY=;
  b=H6m4hwnOZLhnnJv5JxRZZtI5Ls6kiAtRgQKbFv3neujni0uKwPTgsf2k
   U5sQJ9ATYDxeyIYKWtS/wI6DODHbcc45IDckAX0XZYx0Nyfk1fe3VZSp9
   BKGzgX2/j3V388EfSrkDXLeJE2zFngS81jYhiYf1D0aQbWASmdvDjhieh
   1t3KxWlLGYFsxKVBpOZcckrksP9+TqHfG4eXP+LOOul6+o4OIqEm0JaRH
   bTwLSWjUtr6jIjwHC80KevEse8RJuhPHPD3z4rsNz7mlFt5GzpODeaXtx
   6PesFl4VGvKC6aK+FF8dA+cGCBrwmg809RvI1DrUkUVJg38/dha2xSjvp
   g==;
IronPort-SDR: HVo5QoxwLRv+PbmR1xJuF9MGSYZW/hWAD422nlZsjGQ/dPOWe1vtloTuHsRr8u9THncf0goEau
 euNbnxEKlC0kLxwcDUALqQJgZsld3vHYHLHeRCKxnsDMdX+SmqLkj4vISNjKvviyJMpXKeh8KO
 3c7DnCodnxaJwf4DaxwJROWg0B1biqGVEetpDFfjodCMH3Dy9k01gIrUWqt1KspuhK1Y70GyQv
 Aj/Vk7tu3gB+THnUjdlQdGclNlro8gGNBgCtc2DeZRDbduKPbxb9DvjbZXQZ3hUu8zzFSujb0J
 TSc=
IronPort-PHdr: =?us-ascii?q?9a23=3AvxsSFx0RFlO0Uu8JsmDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8Zse0eKfad9pjvdHbS+e9qxAeQG9mCsLQY1aGH6+jJYi8p2d65qncMcZhBBV?=
 =?us-ascii?q?cuqP49uEgeOvODElDxN/XwbiY3T4xoXV5h+GynYwAOQJ6tL1LdrWev4jEMBx?=
 =?us-ascii?q?7xKRR6JvjvGo7Vks+7y/2+94fcbglVijexe7x/IRS5oQjVqsUdnJdvJLs2xh?=
 =?us-ascii?q?bVuHVDZv5YxXlvJVKdnhb84tm/8Zt++ClOuPwv6tBNX7zic6s3UbJXAjImM3?=
 =?us-ascii?q?so5MLwrhnMURGP5noHXWoIlBdDHhXI4wv7Xpf1tSv6q/Z91SyHNsD4Ubw4RT?=
 =?us-ascii?q?Kv5LpwRRT2lCkIKSI28GDPisxxkq1bpg6hpwdiyILQeY2ZKeZycr/Ycd4cQG?=
 =?us-ascii?q?pBX91RVzdAAoO6YIsEEvQPM/9FpInzplsBsx++ChSxD+/rxDJEmnr60Ksn2O?=
 =?us-ascii?q?ojDA7GxhQtEdIQvnrJotv7N6AcXPupwKXU1zjPc+lb1Svh5IXObxsvoeuMXb?=
 =?us-ascii?q?V1ccfJy0YvFgLEjlWNqYziIjiY0eQMsmmb7+V6VOKjl3Irpg9qrziy2sgskJ?=
 =?us-ascii?q?PFiZwIxVDZ7Ch0xps+K96gSENjf9KoDJ9duzuZOoZ2WM8uXXxktSYgxrEbvZ?=
 =?us-ascii?q?O2fzAGxIkmyhPbcfCLbYaF7xL5WOqPIDp0nnBodb25ih2v60av0Pf8WdOx0F?=
 =?us-ascii?q?tSqypFlcTDuW4V2hzI78iHVuN9/kC82TaTzwzT6v9LIUQzlafDLp4u2L8wlp?=
 =?us-ascii?q?4KvUTbES/6hVz6jKGLekgg+eWk8evnYrLhpp+TM497lBvyPbgpmsy6Geg4Mw?=
 =?us-ascii?q?4OUHaH+emkyrHv4Un0TK9Jg/A2iKXVro3WKMQBqqKkBwJY0Z4v6xOlADen1N?=
 =?us-ascii?q?QYk2MHLFVAeB+fj4noOlHOL+r5Dfujn1ihnixmx+3aMb37GJnCMGXMkKr5cb?=
 =?us-ascii?q?Zn90Fc0BYzzcxY559MDrEBIfTzWlL+tdDBFh85Nhe5w/joCNpjzIMSQ2GPDb?=
 =?us-ascii?q?GDMKPUr1CI4vgjI+6WZI8a637TMf8gss/vn38knhdJbLup1JpPMCuQA/98ZU?=
 =?us-ascii?q?iVfCy/0Z86DW4Ws19mH6TRg1qYXGsWOC6/?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2FAAABRxZRdh8bXVdFmHQEBBQEMBQG?=
 =?us-ascii?q?BVAcBCwGDXUwQjSCGKAaLPnGFeoMLhSeBewEIAQEBDAEBLQIBAYRAgkAjNQg?=
 =?us-ascii?q?OAgMJAQEFAQEBAQEFBAEBAhABAQEIDQkIKYVAgjopgzULFmdWPwEFATUiOYJ?=
 =?us-ascii?q?HAYF2FAWjfIEDPIxYiGcBCQ2BSAkBCIEiAYc0hFmBEIEHhGGEKIM9gkQEgTc?=
 =?us-ascii?q?BAQGVI5ZNAQYCghAUgXiTEieEOok9i0EBLYwNmxgCCgcGDyOBMQOCDU0lgWw?=
 =?us-ascii?q?KgURQEBSBWw4JFY4uITOBCJA8AQ?=
X-IPAS-Result: =?us-ascii?q?A2FAAABRxZRdh8bXVdFmHQEBBQEMBQGBVAcBCwGDXUwQj?=
 =?us-ascii?q?SCGKAaLPnGFeoMLhSeBewEIAQEBDAEBLQIBAYRAgkAjNQgOAgMJAQEFAQEBA?=
 =?us-ascii?q?QEFBAEBAhABAQEIDQkIKYVAgjopgzULFmdWPwEFATUiOYJHAYF2FAWjfIEDP?=
 =?us-ascii?q?IxYiGcBCQ2BSAkBCIEiAYc0hFmBEIEHhGGEKIM9gkQEgTcBAQGVI5ZNAQYCg?=
 =?us-ascii?q?hAUgXiTEieEOok9i0EBLYwNmxgCCgcGDyOBMQOCDU0lgWwKgURQEBSBWw4JF?=
 =?us-ascii?q?Y4uITOBCJA8AQ?=
X-IronPort-AV: E=Sophos;i="5.67,574,1566889200"; 
   d="scan'208";a="79706475"
Received: from mail-pg1-f198.google.com ([209.85.215.198])
  by smtpmx6.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Oct 2019 08:43:22 -0700
Received: by mail-pg1-f198.google.com with SMTP id e15so13607528pgh.19
        for <linux-pm@vger.kernel.org>; Wed, 02 Oct 2019 08:43:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=N3wwXKf0R7CCR4EOyO31YNISlkUagx3YW+ubBEkjy90=;
        b=QMv4jGcCXx1URDikgKlNGUTFPVSJO4RCDjXYf6zhQ61B9j4ZD9SGba71X54tQA4kbV
         7JCHjnSZ1dPQeEq84OuGkA9EnjGzjmNvrU2J1xNR097Lb/Bb+wsYt/tt9nLwICmKLRM0
         9ZsD/mRt6zc8SCPUTr7vwkyCbuZvHwRdDpbSKkOgTvlBkVWd/qzHaiZyxB8WFUMnbTRo
         wCHMnTxrTel0vr2JPnRg8+ZsJldqD2gLfkhauSQlRj5FjUiBgJ4KutAfz87/t8o6w/f1
         jwbUTWzf+HE4303koSjExoqNUQAg2eb9IB5lHC05TSyXraQkKIJv5u6OrcHacwQT0vJE
         HTVA==
X-Gm-Message-State: APjAAAX9accEOftYZspe7dOWcIDR/nNWYpfNU8cM0XdhatOkuEZ6yLpa
        GyqvZ8i7/ewTdflvMOu52ClVrgSlu6P6m+htapl5DhW2PDKkCaNFyhspzgZWXsWdQn3LjKr+ebk
        CeIM6aB3s6MCzV+mFr/tv
X-Received: by 2002:a17:90a:7181:: with SMTP id i1mr287702pjk.39.1570031001253;
        Wed, 02 Oct 2019 08:43:21 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx5xvAvA3yzxjudCSvj/C3DRFOv+3OVFLDlbq510/C1VN0iXsuolwLESAlE9074I/ysViusjg==
X-Received: by 2002:a17:90a:7181:: with SMTP id i1mr287657pjk.39.1570031000821;
        Wed, 02 Oct 2019 08:43:20 -0700 (PDT)
Received: from Yizhuo.cs.ucr.edu (yizhuo.cs.ucr.edu. [169.235.26.74])
        by smtp.googlemail.com with ESMTPSA id a23sm13678588pgd.83.2019.10.02.08.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 08:43:20 -0700 (PDT)
From:   Yizhuo <yzhai003@ucr.edu>
Cc:     csong@cs.ucr.edu, zhiyunq@cs.ucr.edu, Yizhuo <yzhai003@ucr.edu>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] power: supply: max17042_battery: fix the potential uninitialized use in max17042_write_verify_reg()
Date:   Wed,  2 Oct 2019 08:44:06 -0700
Message-Id: <20191002154406.8875-1-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In function max17042_write_verify_reg(), variable "read_value"
could be uninitialized if regmap_read() fails. However,
"read_value" is used to decide the control flow later in the if
statement, which is potentially unsafe.

Signed-off-by: Yizhuo <yzhai003@ucr.edu>
---
 drivers/power/supply/max17042_battery.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index 0dfad2cf13fe..e6a2dacaa730 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -486,12 +486,15 @@ static void max17042_external_power_changed(struct power_supply *psy)
 static int max17042_write_verify_reg(struct regmap *map, u8 reg, u32 value)
 {
 	int retries = 8;
-	int ret;
+	int ret, err;
 	u32 read_value;
 
 	do {
 		ret = regmap_write(map, reg, value);
-		regmap_read(map, reg, &read_value);
+		err = regmap_read(map, reg, &read_value);
+		if (err)
+			return err;
+
 		if (read_value != value) {
 			ret = -EIO;
 			retries--;
-- 
2.17.1

