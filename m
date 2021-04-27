Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AED836CBDB
	for <lists+linux-pm@lfdr.de>; Tue, 27 Apr 2021 21:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238822AbhD0TpK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Apr 2021 15:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238838AbhD0TpJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Apr 2021 15:45:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4FF4C06175F
        for <linux-pm@vger.kernel.org>; Tue, 27 Apr 2021 12:44:25 -0700 (PDT)
Date:   Tue, 27 Apr 2021 19:44:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619552663;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MfNPVXU7ie35VwgTuVUuND4oIEXYwgWGjLb0UYY5YtM=;
        b=nOXz0ILLhLZAD3hQntXBt3uT/X0sGJTnvtC4YdNTMupCjquS/dliWACWgcMpCgZEK3KTSU
        2K0IFGEeBeCVhUAAkiy9kar201eYEQP1L3fpC8DgHGaOH4yfhrDhpFwyaa61KNaHmOO7YF
        LaZA+w/yBnphiSXj9TDjCBchmB5IKY4ZdUV27XFdr1TrEEWKVxqHGGb7XAstKjekqvEMz/
        puvLESZ6/31JcczZuGARfYfFiYgjzDb4+t0pM7I5ppAgsDlHPyXnkuLokC0EzzTDQtW8tr
        Dat6fi6bJQ4zwLyk1bi8jlCwPRgDWENrCgQB3RCbk+YQL/1hLmmo5KUngLXtCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619552663;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MfNPVXU7ie35VwgTuVUuND4oIEXYwgWGjLb0UYY5YtM=;
        b=APbIGy6d047SHHcvU3pGjfb0EevYyfEeK+LgaYwNtnQQtWSXjnI543h/cwM++QKTpB/HPW
        QDprNap4uWEQhEDg==
From:   "thermal-bot for Colin Ian King" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/mtk_thermal: Remove redundant
 initializations of several variables
Cc:     Colin Ian King <colin.king@canonical.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20210422120412.246291-1-colin.king@canonical.com>
References: <20210422120412.246291-1-colin.king@canonical.com>
MIME-Version: 1.0
Message-ID: <161955266273.29796.17804080313828073962.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     c310e546164d5cca4c12faf9582b75989b030b68
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//c310e546164d5cca4c12faf9582b75989b030b68
Author:        Colin Ian King <colin.king@canonical.com>
AuthorDate:    Thu, 22 Apr 2021 13:04:12 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 22 Apr 2021 23:51:32 +02:00

thermal/drivers/mtk_thermal: Remove redundant initializations of several variables

Several variables are being initialized with values that is never
read and being updated later with a new value. The initializations
are redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210422120412.246291-1-colin.king@canonical.com
---
 drivers/thermal/mtk_thermal.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
index 149c6d7..97e8678 100644
--- a/drivers/thermal/mtk_thermal.c
+++ b/drivers/thermal/mtk_thermal.c
@@ -573,12 +573,12 @@ static int raw_to_mcelsius_v1(struct mtk_thermal *mt, int sensno, s32 raw)
 
 static int raw_to_mcelsius_v2(struct mtk_thermal *mt, int sensno, s32 raw)
 {
-	s32 format_1 = 0;
-	s32 format_2 = 0;
-	s32 g_oe = 1;
-	s32 g_gain = 1;
-	s32 g_x_roomt = 0;
-	s32 tmp = 0;
+	s32 format_1;
+	s32 format_2;
+	s32 g_oe;
+	s32 g_gain;
+	s32 g_x_roomt;
+	s32 tmp;
 
 	if (raw == 0)
 		return 0;
