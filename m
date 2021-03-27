Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46FC434B54B
	for <lists+linux-pm@lfdr.de>; Sat, 27 Mar 2021 08:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhC0Hvw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 27 Mar 2021 03:51:52 -0400
Received: from sender4-pp-o95.zoho.com ([136.143.188.95]:25576 "EHLO
        sender4-pp-o95.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbhC0Hvo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 27 Mar 2021 03:51:44 -0400
X-Greylist: delayed 902 seconds by postgrey-1.27 at vger.kernel.org; Sat, 27 Mar 2021 03:51:44 EDT
ARC-Seal: i=1; a=rsa-sha256; t=1616830597; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=L7RoJufF7tTskibx7JNSmfobQIg7ub/xEhvYpysY/wIQQ6pSmigeYd1HBj7t/UWa2s3m3bqyTCGNRLDGQDRe4+P2wCigMzY+pxQAf2KRRDaLsMkMnXZv/eWbQWvjPVwG2URW+U1L9md7d3sqnaoJKys2F0/xXUc3FpuzeaHetYw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1616830597; h=Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=JXV2C3QRfZwpVe624SV2Rt/jHM07FVh8LsURJOnPjVk=; 
        b=Jbpq0RhgbCKz23PT5VH0tSPshPshob1O0R96uprdTinNIB7eVpWUV/EKbkNpYhEPWyk5YUggdUmfA66zvzPnxwaFTbM6TBGeVWwBNuuNA9nNI1vEaH2NwVwtzrUH3vaVTcpm6i3VyKdet1cdgqyyhj789OcJ8S9bwbi/pJQg1ag=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zohomail.com;
        spf=pass  smtp.mailfrom=mdjurovic@zohomail.com;
        dmarc=pass header.from=<mdjurovic@zohomail.com> header.from=<mdjurovic@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1616830597;
        s=zm2020; d=zohomail.com; i=mdjurovic@zohomail.com;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Transfer-Encoding;
        bh=JXV2C3QRfZwpVe624SV2Rt/jHM07FVh8LsURJOnPjVk=;
        b=XpWzsokB8zMCeVUNFc7dfLopjzgaaC5Z6GlPGzKwPqUyywyIFwqyi/7HzDYy+o8p
        iCT4LiBgPKygMFAW7kAzLEHn5qR0NN3NfIbHnm6sKErnVFu9sRvgn1g/UKdNYMhED1R
        EiYTtzmutLs0nbfhV1Fzh2Kd4NtUchf3/WJG+2LM=
Received: from milan-pc.attlocal.net (107-220-151-69.lightspeed.sntcca.sbcglobal.net [107.220.151.69]) by mx.zohomail.com
        with SMTPS id 1616830595107321.69318646500085; Sat, 27 Mar 2021 00:36:35 -0700 (PDT)
From:   Milan Djurovic <mdjurovic@zohomail.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, Milan Djurovic <mdjurovic@zohomail.com>
Subject: [PATCH] power: supply: 88pm860x_battery: Remove unnecessary int for long long
Date:   Sat, 27 Mar 2021 00:36:05 -0700
Message-Id: <20210327073605.7626-1-mdjurovic@zohomail.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Change 'long long int' to 'long long' because the int is unnecessary,
as suggested by checkpatch.pl.

Signed-off-by: Milan Djurovic <mdjurovic@zohomail.com>
---
 drivers/power/supply/88pm860x_battery.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/88pm860x_battery.c b/drivers/power/supply/88pm860x_battery.c
index 590da88a17a2..f3f3f8cd1a7f 100644
--- a/drivers/power/supply/88pm860x_battery.c
+++ b/drivers/power/supply/88pm860x_battery.c
@@ -109,8 +109,8 @@ struct pm860x_battery_info {
 };
 
 struct ccnt {
-	unsigned long long int pos;
-	unsigned long long int neg;
+	unsigned long long pos;
+	unsigned long long neg;
 	unsigned int spos;
 	unsigned int sneg;
 
-- 
2.31.0

