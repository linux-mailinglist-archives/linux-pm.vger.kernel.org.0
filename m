Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 866643D55AB
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jul 2021 10:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbhGZHu3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Jul 2021 03:50:29 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:62269 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231728AbhGZHu3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 26 Jul 2021 03:50:29 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4GYCmw5268z4w;
        Mon, 26 Jul 2021 10:30:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1627288256; bh=UYfafvj7oW9lU+0ORYDLk6ttWEkFxJ3q5XJgf0F0aVU=;
        h=Date:From:Subject:To:Cc:From;
        b=Trev/yMf+9El35wMFvypcyf88ShLCs5n34obJZ86pTVQnrwZ5WY75a2MKbe7bT2sX
         IY8TEYiG5xyVDfs/I0StT/EQpl91WdxlUvYaON+tEj2Ob9EQZjUhrdvJ3upf90ZMEJ
         lDdx0HL0BAGMcKNM4/HrWhQILGF7grdQ1VMFACC67zKnNi0Z2jMFfrqEXj1dYbPpY6
         gJ47/ZicoEb/Emotv6c6PfMrcy0Gg/aLhmxqFaSZi6eWFMTujRd/DVPNI1ZW+ovpM6
         bnyMyCaQQUJ0L+Se+zg1/WWonAcwIZF154ylQvnuzjBuAwQDZDmVaP6cGOSbzKdpea
         zUl28RkURvJrg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.2 at mail
Date:   Mon, 26 Jul 2021 10:30:56 +0200
Message-Id: <aae042425e7a55d7d0f873cdfc3712953fb0df10.1627288191.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH] opp: remove WARN when no valid OPPs remain
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This WARN can be triggered per-core and the stack trace is not useful.
Replace it with plain dev_err(). Fix a comment while at it.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/opp/of.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index c582a9ca397b..01feeba78426 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -985,8 +985,9 @@ static int _of_add_opp_table_v2(struct device *dev, struct opp_table *opp_table)
 		}
 	}
 
-	/* There should be one of more OPP defined */
-	if (WARN_ON(!count)) {
+	/* There should be one or more OPPs defined */
+	if (!count) {
+		dev_err(dev, "%s: no supported OPPs", __func__);
 		ret = -ENOENT;
 		goto remove_static_opp;
 	}
-- 
2.30.2

