Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E22A42F959D
	for <lists+linux-pm@lfdr.de>; Sun, 17 Jan 2021 22:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729748AbhAQVsl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 17 Jan 2021 16:48:41 -0500
Received: from sender11-of-o51.zoho.eu ([31.186.226.237]:21165 "EHLO
        sender11-of-o51.zoho.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728042AbhAQVsj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 17 Jan 2021 16:48:39 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1610920066; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=Q6Zpp2JXCLlP45v9hxW73pOlhKNMTF42okK9oPAy52C3SqkvJJgag/8l5E5l32oG4xsTURMBOi+nQHQ4wGLhB/zhXPxZlSsS+0Gd+aPOLbZ9W1huxsqJp4jSiQDEPut6F4X+cJgP7f/H37BKgfKXn+jtP5yFDRxDF7sH78DVdME=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1610920066; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=nndW2GvjBb4LPgtorpR+Ticot9oCoEX8Pzv9Ar2PQAY=; 
        b=KVkZ1dv8DZUeiT6kBNsakSPttTfhXdsMmdYxRR3QkjALsRhwevFy2BN+bpFt+aP8gt7CZPNQ33Tt+VRTZuAwpl35CspPkL5N743Tx4MReUohAZto/B0OJuhb/v4LeLNm5AF2g2T6FNwAsWvqYi8IRiGs7rVlI8k9lmD2yMz6NP8=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        spf=pass  smtp.mailfrom=philipp@uvos.xyz;
        dmarc=pass header.from=<philipp@uvos.xyz> header.from=<philipp@uvos.xyz>
Received: from localhost.localdomain (ip-95-222-215-9.hsi15.unitymediagroup.de [95.222.215.9]) by mx.zoho.eu
        with SMTPS id 1610920066357845.413414857171; Sun, 17 Jan 2021 22:47:46 +0100 (CET)
Date:   Sun, 17 Jan 2021 22:47:45 +0100
From:   Carl Philipp Klemm <philipp@uvos.xyz>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-omap@vger.kernel.org,
        Arthur Demchenkov <spinal.by@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Merlijn Wajer <merlijn@wizzup.org>, Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 4/5] power: supply: cpcap-charger: fix small mistake in
 current to register conversion
Message-Id: <20210117224745.40c38ae352761663db1752c9@uvos.xyz>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Signed-off-by: Carl Philipp Klemm <philipp@uvos.xyz>
---
 drivers/power/supply/cpcap-charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/cpcap-charger.c b/drivers/power/supply/cpcap-charger.c
index 152090faf5b2..be7d1da7a5a5 100644
--- a/drivers/power/supply/cpcap-charger.c
+++ b/drivers/power/supply/cpcap-charger.c
@@ -300,7 +300,7 @@ static int cpcap_charger_current_to_regval(int microamp)
 		return CPCAP_REG_CRM_ICHRG(0x0);
 	if (miliamp < 177)
 		return CPCAP_REG_CRM_ICHRG(0x1);
-	if (miliamp > 1596)
+	if (miliamp >= 1596)
 		return CPCAP_REG_CRM_ICHRG(0xe);
 
 	res = microamp / 88666;
-- 
2.29.2

